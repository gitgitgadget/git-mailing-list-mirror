Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E1C2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73872465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgQ32GSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLSJQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:16:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39113 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfLSJQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 04:16:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id t17so4120562eds.6
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 01:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b2GYGY9rn1kEQWMpPAXx3Ikkw2LMtBFA83UVlLrw90w=;
        b=RgQ32GSu5lKvYIESU5tuPwGUUz/lpAumf4PPFtN+4XV52uy9FWZMx/Fb+hehWLKKd6
         HJoSoyuKvLb4Qfk1i1fxkjHjDDwRBFNFtIzIiU1qJCDNpcE09UvX9EB2QU6ROKDDYag9
         FZeAl4bW80+NQNZUGONPHsnqjSwRX4CXVzl1avZEO1uPVe/UjUlvRejwrevIp/tFV484
         LRxEhbv4ZXsUaKnMzhiivUqSMw69bSI95epRvNDn/vpTg1mx72SrEVfF2Q5TRLQ5QKlN
         sujQfpDhODXgt7wi5IldbVA7QnPVieOj6bRXvzYMv42NZdmqp0XdiqkwKTLS9qo6PjQW
         GHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b2GYGY9rn1kEQWMpPAXx3Ikkw2LMtBFA83UVlLrw90w=;
        b=bVNnGaHq6HHRafaO+mXS7mTP0YmLlQXhR7UvdwZ8hL8wVY4obKVxugKB8O0Eg2yYJH
         uycrLJSVnFzdi2JDrb7knQ9LaQynOQ5n/9cnjV7VCq7NFT0QUvhWpIOyYE6ZGVKpr9My
         i9Q884ZwxEtZm2SvJP4lyJtbPsNsJOkhAYIOjORcD7BMYsZGbZquE1i3o+a3YTS83o8Y
         CVT467FZ4qKh4xz3LPbukZXNX4THNhjiGec/6j7FhG9LQsCQqaPCuLaB0lYGbMzIQKbl
         9WoYT3nQDJEyFI/EFoBuiMecCky0HwrbL8nzuw/lucEXhC6qL9a0Y41v0q0qzj/wqibv
         ObQg==
X-Gm-Message-State: APjAAAWSVjLfzzodcFp/u2TOzJPONZiIPJMC9j1wcktdy2snfCOpNkiZ
        Jt4sBGQXz691/mMFpWAGnWVk7Sy/
X-Google-Smtp-Source: APXvYqz1yGNYluTcx+bhnaYQLxmBnxhQCYa0KqzvfkdMf8BRDgUoSiOxH3Vs7EpvRvkosY/TAJkKww==
X-Received: by 2002:a17:906:8250:: with SMTP id f16mr8284834ejx.304.1576746984511;
        Thu, 19 Dec 2019 01:16:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm249943edq.5.2019.12.19.01.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 01:16:24 -0800 (PST)
Message-Id: <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 09:16:22 +0000
Subject: [PATCH v2 1/1] commit: display advice hints when commit fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Display hints to the user when trying to commit without staging the
modified files first (when advice.statusHints is set to true). Change
the output of the unsuccessful commit from e.g:

  # [...]
  # Changes not staged for commit:
  #   modified:   builtin/commit.c
  #
  # no changes added to commit

to:

  # [...]
  # Changes not staged for commit:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #   modified:   /builtin/commit.c
  #
  # no changes added to commit (use "git add" and/or "git commit -a")

In ea9882bfc4 (commit: disable status hints when writing to
COMMIT_EDITMSG, 2013-09-12) the intent was to disable status hints when
writing to COMMIT_EDITMSG, but in fact the implementation disabled
status messages in more locations, e.g in case the commit wasn't
successful, status hints will still be disabled and no hints will be
displayed to the user although advice.statusHints is set to true.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 builtin/commit.c                          | 18 ++++++++++++------
 t/t7500-commit-template-squash-signoff.sh |  9 +++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e48c1fd90a..868c0d7819 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -811,12 +811,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	old_display_comment_prefix = s->display_comment_prefix;
 	s->display_comment_prefix = 1;
 
-	/*
-	 * Most hints are counter-productive when the commit has
-	 * already started.
-	 */
-	s->hints = 0;
-
 	if (clean_message_contents)
 		strbuf_stripspace(&sb, 0);
 
@@ -837,6 +831,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		int saved_color_setting;
 		struct ident_split ci, ai;
 
+		/*
+		 * Most hints are counter-productive when displayed in
+		 * the commit message editor.
+		 */
+		s->hints = 0;
+
 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
 				!merge_contains_scissors)
@@ -912,6 +912,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
 		committable = run_status(s->fp, index_file, prefix, 1, s);
+		if(!committable)
+			/*
+			 Status is to be printed to stdout, so hints will be useful to the
+			 user. Reset s->hints to what the user configured
+			 */
+			s->hints = advice_status_hints;
 		s->use_color = saved_color_setting;
 		string_list_clear(&s->change, 1);
 	} else {
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 46a5cd4b73..a8179e4074 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -382,4 +382,13 @@ test_expect_success 'check commit with unstaged rename and copy' '
 	)
 '
 
+test_expect_success 'commit without staging files fails and displays hints' '
+	echo "initial" >>file &&
+	git add file &&
+	git commit -m initial &&
+	echo "changes" >>file &&
+	test_must_fail git commit -m update >actual &&
+	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
+'
+
 test_done
-- 
gitgitgadget
