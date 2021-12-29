Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A461EC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 06:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhL2GXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 01:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhL2GXo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 01:23:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1549EC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:23:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so42388464wrr.8
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UrV4Hb2b1vfnHNW4Dy1goFSVbGdLWzuqi/lS9maQwwY=;
        b=G+SN88zWmhI5lUnoozV/a+2yVfuG2iRrUUhpBF3xJP7rHXEtzJXI+GFVKB9BTBnryS
         UioHNw1aaD0OBO/vIr1Nm9W43KvdcDsFrv5IKiwUFOnZMfbDWME5DYdfKYvSqXOpAlh7
         i/oXrvI9kwRVfgrf2n7V7OBgmfMvr2KACE+CeC/DUYZN6Gt4l16UnPIuvhk9Sr4eaQgz
         bnGro9ge0rUcTy9F9XNajRQ4M1KbD+Iuv6E7fK1KbylJj5bbpc+QCmS93ZHpAqRXnFej
         fclgftjNemc2uyBJjvgjP/4AE2DTMZS/YbMq8sqNUyN9x0t9j9Gco81UhhuILhdLBDBe
         EyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UrV4Hb2b1vfnHNW4Dy1goFSVbGdLWzuqi/lS9maQwwY=;
        b=RHX+TcimzUUyRd076ZEx68kCmpvQI/u89sqkc+RA+Hj5nAelxUlYrcZ9z/rq9Ju+1+
         bOJL24uy+duqYhK1dsJJz4H4FT/iq8+hLJiNmSrP4OlHRFc1HCn0LarZI6CHrFg5IhJW
         /qClJKe4s7L+E9u8Ig7iyee7+Och4XCf3mMQuyrcTUxiIhws/AA9MiJ3HEc3i8yb934/
         uy53+qWd4zcWj83i/Fe+EcxihbstAEH5GW8trVV7wuG+9wrJtUANcYs1vAZ4AKVvYOke
         2flrsRxSGRGYjwEKIMGZ153aU6aJ60ZUINj2EGb4YPn7Phhpz01ETLbfbDX/NO5C7A1u
         5RoQ==
X-Gm-Message-State: AOAM532WivwpbBzzBcwAylq4dMx6qkfAWuKYP1URqanAmsKdYBQ6YtzK
        aoPsFbcDO+rnsYP2JU7Bxok1qTcREkY=
X-Google-Smtp-Source: ABdhPJwArFgXwaMHQsmZNk9GQDVuYi8QjKjBRuHESju9O3ILTvuOXMHJtmA9SSj97hCjffaKrnb5ew==
X-Received: by 2002:adf:d20a:: with SMTP id j10mr19843562wrh.699.1640759022496;
        Tue, 28 Dec 2021 22:23:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm2578334wmc.39.2021.12.28.22.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:23:42 -0800 (PST)
Message-Id: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 06:23:39 +0000
Subject: [PATCH v2 0/2] name-rev: deprecate --stdin in favor of --anotate-text
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a --anontate-text that is functionally equivalent of --stdin.
--stdin does not behave as --stdin in other subcommands, such as
pack-objects whereby it takes one argument per line. Since --stdin can be a
confusing and misleading name, the goal is to rename it to --anotate-text.

This is the first step in a process of eventually fully deprecating --stdin.
This change also adds a warning to --stdin warning that it will be removed
in the future.

See https://lore.kernel.org/git/xmqqsfuh1pxz.fsf@gitster.g/ for discussion.

changes since v1 (thanks to Junio's review):

 * s/annotate_text/annotate_stdin
 * add a commit to replace the 2048 size buffer with a strbuf and use
   strbuf_getwholeline to get lines from stdin
 * fixed formatting bugs in documentation udpates.

John Cai (2):
  name-rev: deprecate --stdin in favor of --annotate-text
  name-rev.c: use strbuf_getline instead of limited size buffer

 Documentation/git-name-rev.txt | 29 ++++++++++++++++++++++++++++-
 builtin/name-rev.c             | 27 +++++++++++++++++----------
 2 files changed, 45 insertions(+), 11 deletions(-)


base-commit: 55b058a8bbcc54bd93c733035c995abc7967e539
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1171%2Fjohn-cai%2Fjc%2Fdeprecate-name-rev-stdin-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1171/john-cai/jc/deprecate-name-rev-stdin-v2
Pull-Request: https://github.com/git/git/pull/1171

Range-diff vs v1:

 1:  b83d9422d0c ! 1:  e8063284b4d name-rev: deprecate --stdin in favor of --annotate-text
     @@ Documentation/git-name-rev.txt: OPTIONS
       	List all commits reachable from all refs
       
       --stdin::
     -+	This option is deprecated in favor of 'git name-rev --annotate-text'.
     ++	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
      +	They are functionally equivalent.
      +
     -+--annotate-text::
     ++--annotate-stdin::
       	Transform stdin by substituting all the 40-character SHA-1
       	hexes (say $hex) with "$hex ($rev_name)".  When used with
       	--name-only, substitute with "$rev_name", omitting $hex
     @@ Documentation/git-name-rev.txt: OPTIONS
      +The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
      +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +
     -+$ git name-rev --annotate-text < sample.txt
     ++$ git name-rev --annotate-stdin <sample.txt
      +
      +An abbreviated revision 2ae0a9cb82 will not be substituted.
      +The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907
      +(master),
      +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
      +
     -+$ git name-rev --name-only --annotate-text < sample.txt
     ++$ git name-rev --name-only --annotate-stdin <sample.txt
      +
      +An abbreviated revision 2ae0a9cb82 will not be substituted.
      +The full name is master,
     @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *dat
       {
       	struct object_array revs = OBJECT_ARRAY_INIT;
      -	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
     -+	int all = 0, annotate_text = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
     ++	int all = 0, annotate_stdin = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
       	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
       	struct option opts[] = {
       		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
       		OPT_GROUP(""),
       		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
       		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
     -+		OPT_BOOL(0, "annotate-text", &annotate_text, N_("annotate text text from stdin")),
     ++		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
       		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
       		OPT_BOOL(0, "always",     &always,
       			   N_("show abbreviated commit object as fallback")),
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
      -	if (all + transform_stdin + !!argc > 1) {
      +
      +	if (transform_stdin) {
     -+		warning("--stdin is deprecated. Please use --annotate-text instead, "
     ++		warning("--stdin is deprecated. Please use --annotate-stdin instead, "
      +					"which is functionally equivalent.\n"
      +					"This option will be removed in a future release.");
     -+		annotate_text = 1;
     ++		annotate_stdin = 1;
      +	}
      +
     -+	if (all + annotate_text + !!argc > 1) {
     ++	if (all + annotate_stdin + !!argc > 1) {
       		error("Specify either a list, or --all, not both!");
       		usage_with_options(name_rev_usage, opts);
       	}
      -	if (all || transform_stdin)
     -+	if (all || annotate_text)
     ++	if (all || annotate_stdin)
       		cutoff = 0;
       
       	for (; argc; argc--, argv++) {
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
       	name_tips();
       
      -	if (transform_stdin) {
     -+	if (annotate_text) {
     - 		char buffer[2048];
     +-		char buffer[2048];
     ++	if (annotate_stdin) {
     ++		struct strbuf sb = STRBUF_INIT;
       
       		while (!feof(stdin)) {
     + 			char *p = fgets(buffer, sizeof(buffer), stdin);
 -:  ----------- > 2:  4636e27f53e name-rev.c: use strbuf_getline instead of limited size buffer

-- 
gitgitgadget
