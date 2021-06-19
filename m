Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28254C49361
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0179A61363
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhFSAdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 20:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhFSAdd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 20:33:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB6C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:31:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 2-20020a3709020000b02903aa9873df32so7143483qkj.15
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=1QBAgnAcnZbQZXw1MVzt/aeujWBHbcqWA73iR8XLTG4=;
        b=upcyoWlRxXU4hl0gIDxNIURO/U9oWclPSQzwotRKimuHTQAYuWzNXqOnUF8gkh7DAF
         mhcP60Lamsgk1yMsn1BsU22njKV9iVg9h5j3QgRgk1ak7mDpZzoRsjgsaAwGSAa2TPT/
         CVndWZFivWu6rCAOTTieEukBjdjdBaXXaXPPmUhgJtbCpAE0EycfuoRTisn1h+hDmXXJ
         +J6uTyc+pSUY5ahXFpo3aoCIDEo6wK+hE4B6QJmZ1SoWb3H3E1Q12Ubrpu4JIJc40XyZ
         LmLnaG44q+w77ZXnlB8yB8w3myJgj/jk62xBCtdJENFCgLgRQd3JVrdtU90gSwGrxIoR
         8RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=1QBAgnAcnZbQZXw1MVzt/aeujWBHbcqWA73iR8XLTG4=;
        b=PQTJzHd+TsXX8K1D4mTk+CsGlHV8ZQEootCBvv++xjVLOU+7k6WX1lhYnyruShF41m
         xYocN+/kXaklwnckt/wpbFvegVYLlmwW31Gxlmw7YUXzA7ESGVIQgw3CIjRZvO2JcEIJ
         fcmkd0h9AmXjIobxqq2jM4lAKdSRJNgCRHGtpWgiZCG7tGKXhyjPGgwcaNV3OAyEI8sS
         jc4edzeCM1enKfhzG488s8OU4hElatQlQr84znk1uyoitvzoGKLrbrI/vxb/pvPNzQBq
         jcn/an2yrXVF1j7+c/Pp3i8gTZBPZ98Ax+jtwKA3e4n9mTcT+KCN29iVKP+UzTO8BNal
         Xoaw==
X-Gm-Message-State: AOAM533isxJfZYv2uLIlRyoU9FKM0FZsOTyhWSqJbMZ1ot9gCuo5IgxU
        jM5gresslt+r/pqKdhnLiZ/TpPQtaWcW2sFjSAhatOGAeMA/dlj3PmIs9M7HU5YJjQB9kp/yRtL
        iSLeDk87HkJO6+kGWtR1jVPHnOcphvZsYKojNSMddbQRinSk4pwRQ/h4v/n23u+jdvapdpFwYkg
        ==
X-Google-Smtp-Source: ABdhPJw1QaZhb/6OiyteOqdwIEqJFVoBQ44MFvoXAWTSbOIRsAPLBu2VyzWU6ZasyxhrhgRHXpgsqsuqnLcR3CnzDao=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:258c:: with SMTP id
 fq12mr8481222qvb.30.1624062681020; Fri, 18 Jun 2021 17:31:21 -0700 (PDT)
Date:   Fri, 18 Jun 2021 17:31:15 -0700
In-Reply-To: <20210423001539.4059524-1-emilyshaffer@google.com>
Message-Id: <20210619003118.1352300-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v3 0/2] share a config between submodule and superproject
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now based on es/superproject-aware-submodules.

By using the cached path to the superproject, I was able to drop the
extra subprocess(es) to find out the superproject's gitdir. That means
this change should now be relatively low overhead, and we can discuss
things like naming, recursion, etc. to our hearts' content.

Since v2 of this series, I have rebased the series onto
es/superproject-aware-submodules and made appropriate changes, including
dropping v2 patches 2 and 3. However, I think this solution answers a
handful of the comments on v2:

 - dscho asked about submodules who live outside of the superproject's
   tree; assuming the submodule was created in one of the ways covered
   by superproject-aware-submodules, it should be a nonissue now.
 - Phillip had comments on patches 2 and 3; they're not necessary to
   make the tests pass anymore, because there is no longer an additional
   process cluttering up the traces as a result of this series.

I did not address Phillip's comment about breaking scripts by changing
the config scope name, but I think it's probably valid, so maybe patch 1
also should go (or be replaced by a robust comment).

I'm hoping this can also serve as a nice example of what
https://lore.kernel.org/git/20210616004508.87186-1-emilyshaffer@google.com
can enable.

Happy CI: https://github.com/nasamuffin/git/actions/runs/951382014

Thanks,
 - Emily

Emily Shaffer (2):
  config: rename "submodule" scope to "gitmodules"
  config: add 'config.superproject' file

 Documentation/git-config.txt   |  21 +++++-
 builtin/config.c               |   9 ++-
 config.c                       |  32 ++++++++-
 config.h                       |   5 +-
 submodule-config.c             |   2 +-
 t/t1311-superproject-config.sh | 116 +++++++++++++++++++++++++++++++++
 6 files changed, 178 insertions(+), 7 deletions(-)
 create mode 100755 t/t1311-superproject-config.sh

Range-diff against v2:
1:  785f961f4c = 1:  cddd53e33a config: rename "submodule" scope to "gitmodules"
2:  b4d853e261 ! 2:  3eaca59b65 config: add 'config.superproject' file
    @@ builtin/config.c: static struct option builtin_config_options[] = {
      	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
      	else if (use_system_config) {
    - 		given_config_source.file = git_etc_gitconfig();
    + 		given_config_source.file = git_system_config();
      		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
     +	} else if (use_superproject_config) {
     +		struct strbuf superproject_cfg = STRBUF_INIT;
    @@ config.c
      
      struct config_source {
      	struct config_source *prev;
    -@@ config.c: const char *git_etc_gitconfig(void)
    - 	return system_wide;
    +@@ config.c: void git_global_config(char **user_out, char **xdg_out)
    + 	*xdg_out = xdg_config;
      }
      
     +void git_config_superproject(struct strbuf *sb, const char *gitdir)
     +{
    -+	if (!get_superproject_gitdir(sb))
    -+		/* not a submodule */
    ++	const char *sp_gitdir;
    ++	if (git_config_get_string_tmp("submodule.superprojectGitDir", &sp_gitdir))
    ++		/* probably not a submodule */
     +		strbuf_addstr(sb, gitdir);
    ++	else
    ++		/* definitely a submodule */
    ++		strbuf_addstr(sb, sp_gitdir);
     +
     +	strbuf_addstr(sb, "/config.superproject");
     +}
    @@ config.h: typedef int (*config_parser_event_fn_t)(enum config_event_t type,
      	unsigned int ignore_worktree : 1;
      	unsigned int ignore_cmdline : 1;
      	unsigned int system_gently : 1;
    -@@ config.h: int git_config_rename_section_in_file(const char *, const char *, const char *);
    +@@ config.h: int git_config_rename_section(const char *, const char *);
    + int git_config_rename_section_in_file(const char *, const char *, const char *);
      int git_config_copy_section(const char *, const char *);
      int git_config_copy_section_in_file(const char *, const char *, const char *);
    - const char *git_etc_gitconfig(void);
     +void git_config_superproject(struct strbuf *, const char *);
      int git_env_bool(const char *, int);
      unsigned long git_env_ulong(const char *, unsigned long);
      int git_config_system(void);
     
    - ## submodule.c ##
    -@@ submodule.c: void absorb_git_dir_into_superproject(const char *path,
    - 	}
    - }
    - 
    -+int get_superproject_gitdir(struct strbuf *buf)
    -+{
    -+	struct strbuf sb = STRBUF_INIT;
    -+	struct child_process cp = CHILD_PROCESS_INIT;
    -+	int rc = 0;
    -+
    -+	/* NEEDSWORK: this call also calls out to a subprocess! */
    -+	rc = get_superproject_working_tree(&sb);
    -+	strbuf_release(&sb);
    -+
    -+	if (!rc)
    -+		return rc;
    -+
    -+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
    -+
    -+	strvec_pushl(&cp.args, "-C", "..", "rev-parse", "--absolute-git-dir", NULL);
    -+	cp.git_cmd = 1;
    -+
    -+	rc = capture_command(&cp, buf, 0);
    -+	strbuf_trim_trailing_newline(buf);
    -+
    -+	/* leave buf empty if we didn't have a superproject gitdir */
    -+	if (rc)
    -+		strbuf_reset(buf);
    -+
    -+	/* rc reflects the exit code of the rev-parse; invert into a bool */
    -+	return !rc;
    -+}
    -+
    - int get_superproject_working_tree(struct strbuf *buf)
    - {
    - 	struct child_process cp = CHILD_PROCESS_INIT;
    -
    - ## submodule.h ##
    -@@ submodule.h: void prepare_submodule_repo_env(struct strvec *out);
    - void absorb_git_dir_into_superproject(const char *path,
    - 				      unsigned flags);
    - 
    -+/*
    -+ * Return the gitdir of the superproject, which this project is a submodule of.
    -+ * If this repository is a submodule, return 1 and fill buf with the absolute
    -+ * path to the superproject's gitdir. If this repository is not a submodule of
    -+ * another repository, return 0 and leave buf untouched.
    -+ */
    -+int get_superproject_gitdir(struct strbuf *buf);
    -+
    - /*
    -  * Return the absolute path of the working tree of the superproject, which this
    -  * project is a submodule of. If this repository is not a submodule of
    -
      ## t/t1311-superproject-config.sh (new) ##
     @@
     +#!/bin/sh
-- 
2.32.0.288.g62a8d224e6-goog

