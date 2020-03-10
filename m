Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B2C18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985D220873
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpyUx+p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgCJNSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:18:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42619 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbgCJNL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so15775708wrm.9
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VWW8FfBCCnjTtpZa/h3PDT4exuGP8tqt9pB6XFp3cJ8=;
        b=HpyUx+p9gYY6qAZXmDz47WbzEnO1K/twTCD55HAzlO+sX3tqEjBFbI6mDr17SaezV8
         YorqtjCH7em4wTaBgPPkYtDpRTcoYuC8klstqeq8UHG/G23Y6Y5kSyCmT7FEIhxvRa/s
         2HWQ2ZhsMl3Y2DeM64rMYIYgSgfWZJa3nwaj7lfmdSg22Ldz71Njw270uPiVSiNr7WLW
         nu4QSMH0dUn51IB43ahr+xtPqd0leozKWmaTW2QQEWR6hymJtSQ6cx0Mn7rkshwYyYYT
         sqynfDUKQPqwAOFwsmECjEzELOkR6tCc4SAgJwnCCBycwR4DXMhOtf+DmjTEHZXa2IyL
         7lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VWW8FfBCCnjTtpZa/h3PDT4exuGP8tqt9pB6XFp3cJ8=;
        b=DZiqaQlAxS+teNO6gJXDbISCy9r+JiEOpEu6yTHoQe9Vzk6vwz3/j6zh+3q+8O7jeh
         cEs27pqYoeX0uVTcmshlT7vL3n2xy0yFwCb29lkUYN1od6DNHDOsISpiKNTQRM4XXWMc
         YhTyPg9pKShrLV0+QobSbSFy3reW8ZwjxCh38vbxWMmtPUHl517YfbQdXxs1bBYPwfwN
         0p894VMGcu56Lhwz88btl3LKshSG88FtHkB1RBo340uCkRvGnm7rXyJTMHmUDtVeZJmC
         GfHa3hcAQP9fwmfpr/OggPAIyLPf5AwEXqbmut//gTaGJmganuMpYkqxP86jn45jdTsg
         F/PA==
X-Gm-Message-State: ANhLgQ1c0nzlm8QTTUpEMRIMTv6//d1KBfU0bPGFHPMN9WO/cpUj2qsx
        PJxaXkmkJNLFhmxh3fY6fB3SduXN
X-Google-Smtp-Source: ADFU+vtdiKqWRY6+hR0u+qJMiNXIUmF+xiSke8g9bOGRLNVHBFQ71fUJrRJpCuC9qmTur9NI8gPxiA==
X-Received: by 2002:adf:de84:: with SMTP id w4mr20821568wrl.350.1583845886652;
        Tue, 10 Mar 2020 06:11:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm28912666wrm.46.2020.03.10.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:11:25 -0700 (PDT)
Message-Id: <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
In-Reply-To: <pull.575.git.1583521396.gitgitgadget@gmail.com>
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 13:11:20 +0000
Subject: [PATCH v2 0/4] Fix bugs related to real_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V1
-------------------
1) Removed `strbuf_realpath()` that weren't needed
2) Code style in declaration of `get_superproject_working_tree()`

Original description
-------------------
The issue with `real_path()` seems to be long-standing, where multiple
people solved parts of it over time. I'm adding another part here
after I have discovered a crash related to it.

Even with this step, there are still problems remaining:
* `read_gitfile_gently()` still uses shared buffer.
* `absolute_path()` was not removed.

These issues remain because there're too many code references and I'd like
to avoid submitting a single topic of a scary size.

Alexandr Miloslavskiy (4):
  set_git_dir: fix crash when used with real_path()
  real_path: remove unsafe API
  real_path_if_valid(): remove unsafe API
  get_superproject_working_tree(): return strbuf

 abspath.c                  | 18 +-----------------
 builtin/clone.c            |  6 +++++-
 builtin/commit-graph.c     |  5 ++++-
 builtin/init-db.c          |  4 ++--
 builtin/rev-parse.c        | 12 ++++++++----
 builtin/worktree.c         |  9 ++++++---
 cache.h                    |  4 +---
 editor.c                   | 11 +++++++++--
 environment.c              | 18 ++++++++++++++++--
 path.c                     |  4 ++--
 setup.c                    | 35 ++++++++++++++++++++++-------------
 sha1-file.c                | 13 ++++---------
 submodule.c                | 22 ++++++++++++----------
 submodule.h                |  4 ++--
 t/helper/test-path-utils.c |  5 ++++-
 worktree.c                 | 12 +++++++++---
 16 files changed, 107 insertions(+), 75 deletions(-)


base-commit: 076cbdcd739aeb33c1be87b73aebae5e43d7bcc5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-575%2FSyntevoAlex%2F%230205(git)_crash_real_path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-575/SyntevoAlex/#0205(git)_crash_real_path-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/575

Range-diff vs v1:

 1:  f7afcb4cc83 = 1:  f7afcb4cc83 set_git_dir: fix crash when used with real_path()
 2:  039d3d36866 ! 2:  29e7133dcd9 real_path: remove unsafe API
     @@ -64,7 +64,6 @@
       			die_errno(_("failed to unlink '%s'"), dest->buf);
       		if (!option_no_hardlinks) {
      -			if (!link(real_path(src->buf), dest->buf))
     -+			strbuf_reset(&realpath);
      +			strbuf_realpath(&realpath, src->buf, 1);
      +			if (!link(realpath.buf, dest->buf))
       				continue;
     @@ -92,7 +91,6 @@
       	prepare_alt_odb(r);
       	for (odb = r->objects->odb; odb; odb = odb->next) {
      -		if (!strcmp(obj_dir_real, real_path(odb->path)))
     -+		strbuf_reset(&odb_path_real);
      +		strbuf_realpath(&odb_path_real, odb->path, 1);
      +		if (!strcmp(obj_dir_real, odb_path_real.buf))
       			break;
     @@ -139,7 +137,6 @@
      -	write_file(sb.buf, "%s", real_path(sb_git.buf));
      +	strbuf_realpath(&realpath, sb_git.buf, 1);
      +	write_file(sb.buf, "%s", realpath.buf);
     -+	strbuf_reset(&realpath);
      +	strbuf_realpath(&realpath, get_git_common_dir(), 1);
       	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
      -		   real_path(get_git_common_dir()), name);
     @@ -261,7 +258,6 @@
       		if (*path == '/') {
       			*path = '\0';
      -			if (fspathcmp(real_path(path0), work_tree) == 0) {
     -+			strbuf_reset(&realpath);
      +			strbuf_realpath(&realpath, path0, 1);
      +			if (fspathcmp(realpath.buf, work_tree) == 0) {
       				memmove(path0, path + 1, len - (path - path0));
     @@ -274,7 +270,6 @@
       
       	/* check whole path */
      -	if (fspathcmp(real_path(path0), work_tree) == 0) {
     -+	strbuf_reset(&realpath);
      +	strbuf_realpath(&realpath, path0, 1);
      +	if (fspathcmp(realpath.buf, work_tree) == 0) {
       		*path0 = '\0';
     @@ -338,7 +333,6 @@
      +		struct strbuf realpath = STRBUF_INIT;
       		while (argc > 2) {
      -			puts(real_path(argv[2]));
     -+			strbuf_reset(&realpath);
      +			strbuf_realpath(&realpath, argv[2], 1);
      +			puts(realpath.buf);
       			argc--;
 3:  59af49ad9f6 ! 3:  a4917638671 real_path_if_valid(): remove unsafe API
     @@ -122,7 +122,6 @@
       		return NULL;
       	for (; *list; list++) {
      -		const char *wt_path = real_path_if_valid((*list)->path);
     -+		strbuf_reset(&wt_path);
      +		if (!strbuf_realpath(&wt_path, (*list)->path, 0))
      +			continue;
       
 4:  2eeefda3d41 ! 4:  41950069a16 get_superproject_working_tree(): return strbuf
     @@ -33,7 +33,7 @@
       }
       
      -const char *get_superproject_working_tree(void)
     -+int get_superproject_working_tree(struct strbuf* buf)
     ++int get_superproject_working_tree(struct strbuf *buf)
       {
      -	static struct strbuf realpath = STRBUF_INIT;
       	struct child_process cp = CHILD_PROCESS_INIT;
     @@ -94,6 +94,6 @@
      + * another repository, return 0.
        */
      -const char *get_superproject_working_tree(void);
     -+int get_superproject_working_tree(struct strbuf* buf);
     ++int get_superproject_working_tree(struct strbuf *buf);
       
       #endif

-- 
gitgitgadget
