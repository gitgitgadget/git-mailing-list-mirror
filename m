Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B2CC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEE721D7D
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgSGwCDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLSJQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:16:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46926 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSJQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 04:16:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id m8so4098517edi.13
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 01:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SXk4gHFytKvpPfbeGRnlFpqUo5d/ck9tGyy+uNklmNo=;
        b=cgSGwCDWRgY617nndutxSJkhtPNUJz2PgN/RAyrZ/euJuqjAInIsSxRQi8wSRwiW29
         WrPrzTgO6HXSdiquaeGa0nUaIs38eJbOBWb8WaGbPjrhu5PXM2T75xHb92Q9F6XnC6/R
         qJ0xfltwkPzbGHeVU4KLkq9rVf1utetbshGDryrJ6vjHTNUQEwTn2ZfCb7zhLj/KCcgD
         NbG+0ntk66Zbb+RAsOPC0CocFXEIzFllZ1TL1BoiaYN1uLawwGp8Q+N+M5mRp333i+7Y
         jfdOMsYCdiUOdjjx42ODnqVtPHyv/3IMrD+/HRcdxI6YzQUWQzCn0pUWdHtX01z2jto6
         b94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SXk4gHFytKvpPfbeGRnlFpqUo5d/ck9tGyy+uNklmNo=;
        b=D5vRWWfPiVqgCQd9LvWi5eR3qpXC5RaO2mcknSK5aOspb0UwbyJ2Ezv8qJI0wITV4R
         +faG846ai05Vz9zT195+OPK9WI/Gxk33ah3n6EcTacDNdL5j1BDB+FhzG82xLp24bIMt
         NmSTWlKSuOezKIaiu39pjq+Q1I1cuA8oNDOffEYxNuUPKBxCCI5AZQ6rX60YO3kc/L9Y
         w7T1DwkarfqjntDk7EOlaa82E/ogHeYHcGHKnWYYSiEX9BZbqFymVhSb7SaSFKSnMfHh
         aB6qIjmztyK1PFJhRP+e9weEOTUOpsJ2gZjAKvMmwoQBnaclnwYVcyw8uLD+RZZ4Y6Qz
         TtSQ==
X-Gm-Message-State: APjAAAXDUL6htv+XNghTSHyDIXMasYph7z0hnNn5mtkPH1RC4BrfnUmg
        +2NuQ5kjUZZvzmjF0dcLlOn4TB8V
X-Google-Smtp-Source: APXvYqyxrrUgL2jtFFr+yqQ8vjuTsrK53UMIbG1YIO9QxwXIhvUlTXNPpxQqpovsvZr/oPSX/yFAwQ==
X-Received: by 2002:a50:ed94:: with SMTP id h20mr7771258edr.17.1576746983758;
        Thu, 19 Dec 2019 01:16:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm238267edj.33.2019.12.19.01.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 01:16:23 -0800 (PST)
Message-Id: <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
In-Reply-To: <pull.495.git.1576574242.gitgitgadget@gmail.com>
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 09:16:21 +0000
Subject: [PATCH v2 0/1] [Outreachy] commit: display advice hints when commit fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Display hints to the user when trying to commit without staging the modified
files first (when advice.statusHints is set to true). Change the output of
the unsuccessful commit from e.g:

 . [...] . Changes not staged for commit: . modified: builtin/commit.c . .
no changes added to commit

to:

 . [...] . Changes not staged for commit: . (use "git add ..." to update
what will be committed) . (use "git checkout -- ..." to discard changes in
working directory) . . modified: ../builtin/commit.c . . no changes added to
commit (use "git add" and/or "git commit -a")

In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
2013-09-12) the intent was to disable status hints when writing to
COMMIT_EDITMSG, but in fact the implementation disabled status messages in
more locations, e.g in case the commit wasn't successful, status hints will
still be disabled and no hints will be displayed to the user although
advice.statusHints is set to true.

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Heba Waly (1):
  commit: display advice hints when commit fails

 builtin/commit.c                          | 18 ++++++++++++------
 t/t7500-commit-template-squash-signoff.sh |  9 +++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-495%2FHebaWaly%2Fhints-for-unsuccessful-commit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-495/HebaWaly/hints-for-unsuccessful-commit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/495

Range-diff vs v1:

 1:  f23477c5a3 ! 1:  ebec237920 commit: display advice hints when commit fails
     @@ -2,9 +2,9 @@
      
          commit: display advice hints when commit fails
      
     -    Display hints to the user when trying to commit without staging the modified
     -    files first (when advice.statusHints is set to true). Change the output of the
     -    unsuccessful commit from e.g:
     +    Display hints to the user when trying to commit without staging the
     +    modified files first (when advice.statusHints is set to true). Change
     +    the output of the unsuccessful commit from e.g:
      
            # [...]
            # Changes not staged for commit:
     @@ -19,16 +19,16 @@
            #   (use "git add <file>..." to update what will be committed)
            #   (use "git checkout -- <file>..." to discard changes in working directory)
            #
     -      #   modified:   ../builtin/commit.c
     +      #   modified:   /builtin/commit.c
            #
            # no changes added to commit (use "git add" and/or "git commit -a")
      
     -    In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
     -    2013-09-12) the intent was to disable status hints when writing to
     -    COMMIT_EDITMSG, but in fact the implementation disabled status messages in
     -    more locations, e.g in case the commit wasn't successful, status hints
     -    will still be disabled and no hints will be displayed to the user although
     -    advice.statusHints is set to true.
     +    In ea9882bfc4 (commit: disable status hints when writing to
     +    COMMIT_EDITMSG, 2013-09-12) the intent was to disable status hints when
     +    writing to COMMIT_EDITMSG, but in fact the implementation disabled
     +    status messages in more locations, e.g in case the commit wasn't
     +    successful, status hints will still be disabled and no hints will be
     +    displayed to the user although advice.statusHints is set to true.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     @@ -36,13 +36,44 @@
       --- a/builtin/commit.c
       +++ b/builtin/commit.c
      @@
     - 	 */
     - 	if (!committable && whence != FROM_MERGE && !allow_empty &&
     - 	    !(amend && is_a_merge(current_head))) {
     -+		s->hints = advice_status_hints;
     - 		s->display_comment_prefix = old_display_comment_prefix;
     - 		run_status(stdout, index_file, prefix, 0, s);
     - 		if (amend)
     + 	old_display_comment_prefix = s->display_comment_prefix;
     + 	s->display_comment_prefix = 1;
     + 
     +-	/*
     +-	 * Most hints are counter-productive when the commit has
     +-	 * already started.
     +-	 */
     +-	s->hints = 0;
     +-
     + 	if (clean_message_contents)
     + 		strbuf_stripspace(&sb, 0);
     + 
     +@@
     + 		int saved_color_setting;
     + 		struct ident_split ci, ai;
     + 
     ++		/*
     ++		 * Most hints are counter-productive when displayed in
     ++		 * the commit message editor.
     ++		 */
     ++		s->hints = 0;
     ++
     + 		if (whence != FROM_COMMIT) {
     + 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
     + 				!merge_contains_scissors)
     +@@
     + 		saved_color_setting = s->use_color;
     + 		s->use_color = 0;
     + 		committable = run_status(s->fp, index_file, prefix, 1, s);
     ++		if(!committable)
     ++			/*
     ++			 Status is to be printed to stdout, so hints will be useful to the
     ++			 user. Reset s->hints to what the user configured
     ++			 */
     ++			s->hints = advice_status_hints;
     + 		s->use_color = saved_color_setting;
     + 		string_list_clear(&s->change, 1);
     + 	} else {
      
       diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
       --- a/t/t7500-commit-template-squash-signoff.sh
     @@ -56,7 +87,7 @@
      +	git add file &&
      +	git commit -m initial &&
      +	echo "changes" >>file &&
     -+	test_must_fail git commit -m initial >actual &&
     ++	test_must_fail git commit -m update >actual &&
      +	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
      +'
      +

-- 
gitgitgadget
