Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F9C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbiAEXAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245222AbiAEXAD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:00:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57B3C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 15:00:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso259307wmf.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 15:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fWLwWNRdd2eiLGFfomA91njmTggXbYpWwkTjwc92pCQ=;
        b=Xqupx+qusDb2xeDb+UWIeEb90xjvquEMdt7H6Z2qAG4Lm/dBAJSBocXB1/WO20i+Hc
         08pkWGtlA9GrrXwXxhwoECi5zv5bzY8ZgafnzNAmXisq/XPn1bQzEuENodxqEcKTevJB
         sRcECNNm4LmLUP506m4Rl/Tb41ccQTlhqE0usA77zjjUMIYvisbmFLwD8HOu0t4qL2/g
         rWRsWdNDapiYT+YPRCAXkkuWbQhVyRgVz4TPzXLd3GR6MjORJQwxFRIcaHH7v0jCyCtZ
         +wJ6i4zs8quxbAmPoNgKtzEH8poi0wKebKXz/nX3vccM0BHdEiHNsR5rNVncwvoFIVzT
         ge1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fWLwWNRdd2eiLGFfomA91njmTggXbYpWwkTjwc92pCQ=;
        b=jUmDtaxr2qm2dDmTiEpPypE47DclxssYoKlvvHhT8t2t40lyKIFqOngllCEWRwbdpj
         RRfcU3afJPpn1zsBeHN8AlOVM05rZrvlUU8hMP9tZ1vhqmc823mRoxRJRhQiQyECbxgE
         lSCClAJu/FfKxaaTOgi/TEy9arIxfcEmYVWFkdDmt2fi6CCosF4ra5gGDS7o/TBu1+wJ
         FfRQeBcx3dShTyy4f96J1Tin7Jp/dOfRxnMx1Vw4OmbqfAVPrXyuIxXJXEOzuMTKlO6A
         ycEnhP1Be295JSnwfvgWL7f+fad5UIPOFx1HvxpGoYeNAhMZkgFSMlzFZAXYeHKOxzVm
         fQjg==
X-Gm-Message-State: AOAM531TUmyrVEUTkMuQD1fp8K2dRY65GcnPCCXTGLnhKfEs3xLI3DJm
        uvnreuS3K3SdHCIzxkiohO8PrpR+4YM=
X-Google-Smtp-Source: ABdhPJwM0VRPXP/EMyTS/9tUxQmz+gNJlmOMF7CU120V2cTt/R+BZI4UaX++dfYRix7smB8YrwTQzg==
X-Received: by 2002:a05:600c:154e:: with SMTP id f14mr4906231wmg.126.1641423601123;
        Wed, 05 Jan 2022 15:00:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm167231wme.36.2022.01.05.15.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 15:00:00 -0800 (PST)
Message-Id: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
References: <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 22:59:58 +0000
Subject: [PATCH v6 0/2] name-rev: deprecate --stdin in favor of --annotate-stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a --annotate-stdin that is functionally equivalent of --stdin.
--stdin does not behave as --stdin in other subcommands, such as
pack-objects whereby it takes one argument per line. Since --stdin can be a
confusing and misleading name, the goal is to rename it to --annotate-stdin.

This is the first step in a process of eventually fully deprecating --stdin.
This change also adds a warning to --stdin warning that it will be removed
in the future.

See https://lore.kernel.org/git/xmqqsfuh1pxz.fsf@gitster.g/ for discussion.

changes since v5:

 * fixed documentation example indentation (again)
 * moved initialization of strbuf from 1/2 to 2/2

changes since v4:

 * fixed documentation example indentation

changes since v3:

 * use strbuf_getline instead of strbuf_getwholeline (based on Junio's
   feedback)
 * fixed commit message s/annotate-text/annotate-stdin (based on Junio's
   feedback)
 * since strbuf_getline does not keep the trailing terminator, add back '\n'
   with strbuf_addchr
 * reordered documentation blocks based on (Philip Oakley's feedback)
 * fixed doc typos in example block

John Cai (2):
  name-rev: deprecate --stdin in favor of --annotate-stdin
  name-rev.c: use strbuf_getline instead of limited size buffer

 Documentation/git-name-rev.txt       | 30 ++++++++++++++++++++++++++--
 builtin/name-rev.c                   | 30 ++++++++++++++++++----------
 t/t3412-rebase-root.sh               |  2 +-
 t/t4202-log.sh                       |  2 +-
 t/t6007-rev-list-cherry-pick-file.sh | 26 ++++++++++++------------
 t/t6012-rev-list-simplify.sh         |  2 +-
 t/t6111-rev-list-treesame.sh         |  3 ++-
 t/t6120-describe.sh                  |  9 +++++++--
 8 files changed, 72 insertions(+), 32 deletions(-)


base-commit: c8b2ade48c204690119936ada89cd938c476c5c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1171%2Fjohn-cai%2Fjc%2Fdeprecate-name-rev-stdin-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1171/john-cai/jc/deprecate-name-rev-stdin-v6
Pull-Request: https://github.com/git/git/pull/1171

Range-diff vs v5:

 1:  7c5fb10d87c ! 1:  3caf254a73e name-rev: deprecate --stdin in favor of --annotate-stdin
     @@ Documentation/git-name-rev.txt: OPTIONS
      ++
      +For example:
      ++
     -+--
     -+	$ cat sample.txt
     ++-----------
     ++$ cat sample.txt
      +
     -+	An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+	The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
     -+	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     ++An abbreviated revision 2ae0a9cb82 will not be substituted.
     ++The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
     ++while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +
     -+	$ git name-rev --annotate-stdin <sample.txt
     ++$ git name-rev --annotate-stdin <sample.txt
      +
     -+	An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+	The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907 (master),
     -+	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     ++An abbreviated revision 2ae0a9cb82 will not be substituted.
     ++The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907 (master),
     ++while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +
     -+	$ git name-rev --name-only --annotate-stdin <sample.txt
     ++$ git name-rev --name-only --annotate-stdin <sample.txt
      +
     -+	An abbreviated revision 2ae0a9cb82 will not be substituted.
     -+	The full name after substitution is master,
     -+	while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     -+--
     ++An abbreviated revision 2ae0a9cb82 will not be substituted.
     ++The full name after substitution is master,
     ++while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
     ++-----------
      +
      +--stdin::
      +	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
     @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *dat
       	struct option opts[] = {
       		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
      @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *prefix)
     + 				   N_("ignore refs matching <pattern>")),
       		OPT_GROUP(""),
       		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
     - 		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
     +-		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
     ++		OPT_BOOL_F(0, "stdin", &transform_stdin, N_("deprecated: use annotate-stdin instead"), PARSE_OPT_HIDDEN),
      +		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
       		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
       		OPT_BOOL(0, "always",     &always,
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
       	name_tips();
       
      -	if (transform_stdin) {
     --		char buffer[2048];
      +	if (annotate_stdin) {
     -+		struct strbuf sb = STRBUF_INIT;
     + 		char buffer[2048];
       
       		while (!feof(stdin)) {
     - 			char *p = fgets(buffer, sizeof(buffer), stdin);
      
       ## t/t3412-rebase-root.sh ##
      @@ t/t3412-rebase-root.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 2:  2acd70f36e7 ! 2:  32ad96530b9 name-rev.c: use strbuf_getline instead of limited size buffer
     @@ Commit message
      
       ## builtin/name-rev.c ##
      @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *prefix)
     + 	name_tips();
     + 
       	if (annotate_stdin) {
     - 		struct strbuf sb = STRBUF_INIT;
     +-		char buffer[2048];
     ++		struct strbuf sb = STRBUF_INIT;
       
      -		while (!feof(stdin)) {
      -			char *p = fgets(buffer, sizeof(buffer), stdin);

-- 
gitgitgadget
