Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D379C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 17:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358612AbiFVRIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377130AbiFVRIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 13:08:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128A41F87
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:07:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j24so3611292wrb.11
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iXHuSa8MHomVNL4RePTkfGFddKoRsEULNMD48PZDpVM=;
        b=eU6gV9iGFz7vyAx0EsOg3ZP0ELOHJaX2rR77Nug8vI0wAfMwHtP4wGuY1pnb+9Oj4y
         jA0PlRotTAalTuxUbvyVW8AWa65BfABbYaIGgeWmNSBhocazWIn7m8L39R8VTLYqgCrL
         ZzcRBBVPvqGmtjfghuq/XPLgQtr3N7LRexFWOcXLwi5GYvMk20dULQbCaAANFsqAWNgQ
         ZaOMjzyAvG9V6r6hoMPt8Nr70PkGAgF9QBqkWiEqwO7ZNW9tYgycUb49AGuyeoZc8IqB
         KXNXOwNnZiYK0/Nx1f6+GkRjXaDu4Qes3gkCfSfRgI/GC6l086Tky73VwpzCV0lecjLu
         i1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=iXHuSa8MHomVNL4RePTkfGFddKoRsEULNMD48PZDpVM=;
        b=cJrwuy0Zf4cz/H2MbXxVUZjpOWDDXm5y4hso6z7wBFa0lpLgLyIR7QsUNEf9mRolJ+
         +YGri5fNLLx9toDU9sWtu8HoWhY1iFcNvHrjNy0NQN9NZ4TjJJwZjgKS2R3675iDPQAj
         t5tj2qjCvJKHaF6jTxG60zPJP3JALUsMkX6CQbG2l/imNUoKdMFElnx7ScnKG0EP0vsq
         r5Mjrwl8Rp1eOXwYi5YJ18c/opn9RWfGqNTjvb1C7CXPAJjgjS8YbHlxFpaYgU+Fg9Vr
         2AN5GbbMrKerZBm660NC1iRq6LVsZkp8OtNMOjIKGeGxtTFVgpHpx9jlaQlXkU7dNj5z
         NDwA==
X-Gm-Message-State: AJIora+m81YHupOoaVFp7DVPTmQfGqFfgp92ourngLWLExq9BLTJrkmp
        2PIvFq8chZqE+x/42tEPwF0Q07etWI5DbQ==
X-Google-Smtp-Source: AGRyM1tiQtmpVim0Q4wx0OEv7siMXFMWEItlMWequa4USu5yfA1f68VC+pQeV+O0NmX5Ge25BKut7g==
X-Received: by 2002:adf:db48:0:b0:21b:9733:e134 with SMTP id f8-20020adfdb48000000b0021b9733e134mr4387615wrj.396.1655917629787;
        Wed, 22 Jun 2022 10:07:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3-20020a1c7703000000b003a02d8de7e2sm848521wmi.43.2022.06.22.10.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:07:09 -0700 (PDT)
Message-Id: <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
In-Reply-To: <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
References: <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
From:   "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 17:07:06 +0000
Subject: [PATCH v3 0/2] grep: add --max-count command line option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Martin =?UTF-8?Q?=C3=85gren?= [ ]" <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a command line option analogous to that of GNU grep(1)'s -m
/ --max-count, which users might already be used to. This makes it possible
to limit the amount of matches shown in the output while keeping the
functionality of other options such as -C (show code context) or -p (show
containing function), which would be difficult to do with a shell pipeline
(e.g. head(1)).

Signed-off-by: Carlos López 00xc@protonmail.com

Carlos López (2):
  grep: add --max-count command line option
  tests: add tests for grep --max-count

 Documentation/git-grep.txt |  9 +++++
 builtin/grep.c             |  9 +++++
 grep.c                     |  2 +-
 grep.h                     |  2 +
 t/t7810-grep.sh            | 83 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)


base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1278%2F00xc%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1278/00xc/master-v3
Pull-Request: https://github.com/git/git/pull/1278

Range-diff vs v2:

 1:  ee7eb298854 ! 1:  5bf7244437e grep: add --max-count command line option
     @@ Documentation/git-grep.txt: providing this option will cause it to die.
      +	Limit the amount of matches per file. When using the `-v` or
      +	`--invert-match` option, the search stops after the specified
      +	number of non-matches. A value of -1 will return unlimited
     -+	results (the default).
     ++	results (the default). A value of 0 will exit immediately with
     ++	a non-zero status.
      +
       --threads <num>::
       	Number of grep worker threads to use.
     @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      +	 * We do this to keep results consistent with GNU grep(1).
      +	 */
      +	if (opt.max_count == 0)
     -+		exit(EXIT_FAILURE);
     ++		return 1;
      +
       	if (show_in_pager) {
       		if (num_threads > 1)
     @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      
       ## grep.c ##
      @@ grep.c: static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
     - 		bol = eol + 1;
     - 		if (!left)
     - 			break;
     -+		if (opt->max_count != -1 && count == opt->max_count)
     -+			break;
     - 		left--;
     - 		lno++;
     - 	}
     + 				return 0;
     + 			goto next_line;
     + 		}
     +-		if (hit) {
     ++		if (hit && (opt->max_count < 0 || count < opt->max_count)) {
     + 			count++;
     + 			if (opt->status_only)
     + 				return 1;
      
       ## grep.h ##
      @@ grep.h: struct grep_opt {
 -:  ----------- > 2:  525958af877 tests: add tests for grep --max-count

-- 
gitgitgadget
