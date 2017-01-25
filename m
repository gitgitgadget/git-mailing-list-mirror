Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040811F437
	for <e@80x24.org>; Wed, 25 Jan 2017 00:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbdAYAqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 19:46:47 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32868 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdAYAqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 19:46:46 -0500
Received: by mail-pf0-f177.google.com with SMTP id y143so53741959pfb.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4D6KRSJugU4ngPho3FbjWSlHh3jGmPjs8aMvbQBm1M=;
        b=Q8EzOSYt+aI2Q5Slzky9P68yNhVmsB+TcqYtOOpOERSrDGK3qumQdSfvwMugzfxIZ7
         /xej7+Ccog9GR+zjJSAS0XscTVicKzaiNxIZiCMnInYwbiirNnMaqfskwDXlfoye7nGA
         cIYLImZ7YR8Qi8aLh6dyrKZ+OQkwZzVNf5ebXZF92G9yRnlsRiG24l0DnEKojr+w/BM/
         WThrdEKkjmthiFjQJQvzebxtjf5QVnILNL6JmXpoGTHLn5BfWFVF6uU2OU5e9f5qUdT0
         Gt/Dsvdwq3Ao6hCJUZQNLhmH2r69OTItQYQAIp7fzxZDdZOJcvL1RLkdpd3RIR/FDb4A
         k10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4D6KRSJugU4ngPho3FbjWSlHh3jGmPjs8aMvbQBm1M=;
        b=E281kf5B+qHaXAdXg7HhP85XxfeSi349yRaTMHwJPcaKG0hM7iz7tqB84GRfgvoFU4
         VnTZ/o8Jtoe5LoqaXytGas0ueXUObIwvHL7HXntFD74/nkrawutTrhWf5tyBdQFXbYNF
         hC4A0U8LEnULlo131a62i2yu+eDCqoiYFihiebzU0ADx7kEYTGCD6tjEgmiC+xymsGP5
         aqHEfAQIdxe3iZBdSOR7CxswbYvcTqCzX+U4G4s2IQF3H4onbXRu6OKphukzmkkJ04RN
         PNNQJFwyB8l6yRTNdB4HDg5r+5ISqaCA7UvgjLyZqvfl4CQYWqfJBgBABCWHZK6nxc+I
         /BpA==
X-Gm-Message-State: AIkVDXLFtuCxWvjbVzswh8LyVOQXJdkSisXGmyYMrhPKvl6lHjHQnz4ZelxA/QnT+7dQN1wA
X-Received: by 10.99.123.3 with SMTP id w3mr43355180pgc.155.1485305173172;
        Tue, 24 Jan 2017 16:46:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:85e5:5d8f:4777:ba11])
        by smtp.gmail.com with ESMTPSA id b67sm47241148pfj.81.2017.01.24.16.46.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 16:46:11 -0800 (PST)
Date:   Tue, 24 Jan 2017 16:46:10 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCHv2 3/3] submodule absorbing: fix worktree/gitdir pointers
 recursively for non-moves
Message-ID: <20170125004610.GC58021@google.com>
References: <20170124221948.GB58021@google.com>
 <20170124235651.18749-1-sbeller@google.com>
 <20170124235651.18749-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170124235651.18749-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/24, Stefan Beller wrote:
> Consider having a submodule 'sub' and a nested submodule at 'sub/nested'.
> When nested is already absorbed into sub, but sub is not absorbed into
> its superproject, then we need to fixup the gitfile and core.worktree
> setting for 'nested' when absorbing 'sub', but we do not need to move
> its git dir around.
> 
> Previously 'nested's gitfile contained "gitdir: ../.git/modules/nested";
> it has to be corrected to "gitdir: ../../.git/modules/sub1/modules/nested".
> 
> An alternative I considered to do this work lazily, i.e. when resolving
> "../.git/modules/nested", we would notice the ".git" being a gitfile
> linking to another path.  That seemed to be robuster by design, but harder
> to get the implementation right.  Maybe we have to do that anyway once we
> try to have submodules and worktrees working nicely together, but for now
> just produce 'correct' (i.e. direct) pointers.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c                        | 43 ++++++++++++++++++++++++++++++--------
>  t/t7412-submodule-absorbgitdirs.sh | 27 ++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 9 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 4c4f033e8a..95437105bf 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1437,22 +1437,47 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  				      const char *path,
>  				      unsigned flags)
>  {
> +	int err_code;
>  	const char *sub_git_dir, *v;
>  	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
>  	struct strbuf gitdir = STRBUF_INIT;
> -
>  	strbuf_addf(&gitdir, "%s/.git", path);
> -	sub_git_dir = resolve_gitdir(gitdir.buf);
> +	sub_git_dir = resolve_gitdir_gently(gitdir.buf, &err_code);
>  
>  	/* Not populated? */
> -	if (!sub_git_dir)
> -		goto out;
> +	if (!sub_git_dir) {
> +		char *real_new_git_dir;
> +		const char *new_git_dir;
> +		const struct submodule *sub;
> +
> +		if (err_code == READ_GITFILE_ERR_STAT_FAILED)
> +			goto out; /* unpopulated as expected */
> +		if (err_code != READ_GITFILE_ERR_NOT_A_REPO)
> +			/* We don't know what broke here. */
> +			read_gitfile_error_die(err_code, path, NULL);
>  
> -	/* Is it already absorbed into the superprojects git dir? */
> -	real_sub_git_dir = real_pathdup(sub_git_dir);
> -	real_common_git_dir = real_pathdup(get_git_common_dir());
> -	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
> -		relocate_single_git_dir_into_superproject(prefix, path);
> +		/*
> +		* Maybe populated, but no git directory was found?
> +		* This can happen if the superproject is a submodule
> +		* itself and was just absorbed. The absorption of the
> +		* superproject did not rewrite the git file links yet,
> +		* fix it now.
> +		*/
> +		sub = submodule_from_path(null_sha1, path);
> +		if (!sub)
> +			die(_("could not lookup name for submodule '%s'"), path);
> +		new_git_dir = git_path("modules/%s", sub->name);
> +		if (safe_create_leading_directories_const(new_git_dir) < 0)
> +			die(_("could not create directory '%s'"), new_git_dir);
> +		real_new_git_dir = real_pathdup(new_git_dir);
> +		connect_work_tree_and_git_dir(path, real_new_git_dir);

Memory leak with 'real_new_git_dir'

> +	} else {
> +		/* Is it already absorbed into the superprojects git dir? */
> +		real_sub_git_dir = real_pathdup(sub_git_dir);
> +		real_common_git_dir = real_pathdup(get_git_common_dir());

The scope of 'real_sub_git_dir' and 'real_common_git_dir' variable can
be narrowed.  Move their declaration here and free it prior to exiting
the else block.

> +		if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))

'v' isn't ever used, just use starts_with() and get rid of 'v'

> +			relocate_single_git_dir_into_superproject(prefix, path);
> +	}
>  

There's a label 'out' at the end of the function which can be removed as
there is no 'goto' statement using it.

>  	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 1c47780e2b..e2bbb449b6 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -64,6 +64,33 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>  	test_cmp expect.2 actual.2
>  '
>  
> +test_expect_success 're-setup nested submodule' '
> +	# un-absorb the direct submodule, to test if the nested submodule
> +	# is still correct (needs a rewrite of the gitfile only)
> +	rm -rf sub1/.git &&
> +	mv .git/modules/sub1 sub1/.git &&
> +	GIT_WORK_TREE=. git -C sub1 config --unset core.worktree &&
> +	# fixup the nested submodule
> +	echo "gitdir: ../.git/modules/nested" >sub1/nested/.git &&
> +	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
> +		core.worktree "../../../nested" &&
> +	# make sure this re-setup is correct
> +	git status --ignore-submodules=none
> +'
> +
> +test_expect_success 'absorb the git dir in a nested submodule' '
> +	git status >expect.1 &&
> +	git -C sub1/nested rev-parse HEAD >expect.2 &&
> +	git submodule absorbgitdirs &&
> +	test -f sub1/.git &&
> +	test -f sub1/nested/.git &&
> +	test -d .git/modules/sub1/modules/nested &&
> +	git status >actual.1 &&
> +	git -C sub1/nested rev-parse HEAD >actual.2 &&
> +	test_cmp expect.1 actual.1 &&
> +	test_cmp expect.2 actual.2
> +'
> +
>  test_expect_success 'setup a gitlink with missing .gitmodules entry' '
>  	git init sub2 &&
>  	test_commit -C sub2 first &&
> -- 
> 2.11.0.495.g04f60290a0.dirty
> 

You can squash them into your patch, assuming you agree with the changes
:)

-- 
Brandon Williams

--8<--

From 0336c4bee60a85d8ad319ff55deea95debb3ceda Mon Sep 17 00:00:00 2001
From: Brandon Williams <bmwill@google.com>
Date: Tue, 24 Jan 2017 16:44:43 -0800
Subject: [PATCH] SQUASH

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index 95437105b..0d9c4bbbe 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1438,8 +1438,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 				      unsigned flags)
 {
 	int err_code;
-	const char *sub_git_dir, *v;
-	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
+	const char *sub_git_dir;
 	struct strbuf gitdir = STRBUF_INIT;
 	strbuf_addf(&gitdir, "%s/.git", path);
 	sub_git_dir = resolve_gitdir_gently(gitdir.buf, &err_code);
@@ -1471,12 +1470,18 @@ void absorb_git_dir_into_superproject(const char *prefix,
 			die(_("could not create directory '%s'"), new_git_dir);
 		real_new_git_dir = real_pathdup(new_git_dir);
 		connect_work_tree_and_git_dir(path, real_new_git_dir);
+
+		free(real_new_git_dir);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
-		real_sub_git_dir = real_pathdup(sub_git_dir);
-		real_common_git_dir = real_pathdup(get_git_common_dir());
-		if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
+		char *real_sub_git_dir = real_pathdup(sub_git_dir);
+		char *real_common_git_dir = real_pathdup(get_git_common_dir());
+
+		if (!starts_with(real_sub_git_dir, real_common_git_dir))
 			relocate_single_git_dir_into_superproject(prefix, path);
+
+		free(real_sub_git_dir);
+		free(real_common_git_dir);
 	}
 
 	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
@@ -1506,6 +1511,4 @@ void absorb_git_dir_into_superproject(const char *prefix,
 
 out:
 	strbuf_release(&gitdir);
-	free(real_sub_git_dir);
-	free(real_common_git_dir);
 }
-- 
2.11.0.483.g087da7b7c-goog

