Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30262C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 13:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiAHNrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 08:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiAHNrc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 08:47:32 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DCFC061574
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 05:47:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v7so5281549qtw.13
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QtScvY1RqBTME6fGf4KcNABx4xWOT7XhlepQEmRj4Pw=;
        b=i+1VkbPE3gNnop2MO+qbqrEIc9uMzd7N89aP/f1KqnxlULHdR5uxZPzMxftmIj6BR6
         1nsb6TMMswTjYgSMu8HbLGmoqNhMDxZxAetaSGOTcfh9t2bHwlbvPd/GaFPt5y7zvQ7Q
         /00koUgJGknKJjKu/xdY+XOsK7CtlE7UL+LpLGgWOQ8pa0F/9d6OZE2CgxDCHhFKXkUt
         Jk4g1Ts/B+IW4vwfuVaC3k0t+QqJ5EjGxeEf+7GNBEXqh0VkAN9CM+tfGSSjzhRWpkUI
         eOSU55ineYKN3zVjZHs+wfzGWQc0JJEpTZAX7mvLrhigpRCwrOnfCxVx7fPHCsrjkudw
         wg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QtScvY1RqBTME6fGf4KcNABx4xWOT7XhlepQEmRj4Pw=;
        b=TFABAV7hBVVlhaRx2f+GOA/8FFg5P6rj4JzZzeYYU/kD/ksNUT/3QD7T7q08YSDYCN
         H1pbMgc+8kA8lCU/XKXoVi+ilvzWOudM4HezbM3UBo/zk/rbRZSjyvM0bEonJWNxjBGI
         DxV0SXrzC9P+reKiwl0d3KdHHdMIB4Cyj+LVK9BbRY7R4MelDuMKVum9KvsNlFPfDW0P
         DL8/1tkczF9/IvwvTmIZTz850beaIPjwgiWdET4LRwvI1DDsiwbMW0KDW/oN0kcVXwWW
         Kw7oa1RB9LkCl+ab+2hVuMmMjyBpnLFPUZ56cgo+lbGfwibK5tLBrIynZkwI5g6JiWEv
         +QWg==
X-Gm-Message-State: AOAM533zNzoQjj+dwAVXY5lEL0kWqxiOpbrsSOdAKkUZo/zM2O9aI+bb
        eznZYETCx+s9g/74Xn1MdoMLDy7gzxBmaA==
X-Google-Smtp-Source: ABdhPJxO/eJ0EomL6OMHOW9CruH58CFZ0Q8bMvDPGqc+HKZxkBfO/0jwu3w12ywU60Jr9Ql3GRSU+A==
X-Received: by 2002:ac8:5c87:: with SMTP id r7mr14584796qta.579.1641649651690;
        Sat, 08 Jan 2022 05:47:31 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id y11sm1067656qta.6.2022.01.08.05.47.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jan 2022 05:47:31 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 1/2] name-rev: deprecate --stdin in favor of --annotate-stdin
Date:   Sat, 08 Jan 2022 08:47:30 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <56FFAD1E-D081-4D13-A12E-DD6807375B69@gmail.com>
In-Reply-To: <153f69ea9b6cfc3fff47c91fa237cf97efd6bfae.1641425372.git.gitgitgadget@gmail.com>
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
 <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
 <153f69ea9b6cfc3fff47c91fa237cf97efd6bfae.1641425372.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 5 Jan 2022, at 18:29, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Introduce a --annotate-stdin that is functionally equivalent of --stdin=
=2E
> --stdin does not behave as --stdin in other subcommands, such as
> pack-objects whereby it takes one argument per line. Since --stdin can
> be a confusing and misleading name, rename it to --annotate-stdin.
>
> This change adds a warning to --stdin warning that it will be removed i=
n
> the future.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>  Documentation/git-name-rev.txt       | 30 ++++++++++++++++++++++++++--=

>  builtin/name-rev.c                   | 19 +++++++++++++-----
>  t/t3412-rebase-root.sh               |  2 +-
>  t/t4202-log.sh                       |  2 +-
>  t/t6007-rev-list-cherry-pick-file.sh | 26 ++++++++++++------------
>  t/t6012-rev-list-simplify.sh         |  2 +-
>  t/t6111-rev-list-treesame.sh         |  3 ++-
>  t/t6120-describe.sh                  |  9 +++++++--
>  8 files changed, 67 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-re=
v.txt
> index 5cb0eb0855f..ec8a27ce8bf 100644
> --- a/Documentation/git-name-rev.txt
> +++ b/Documentation/git-name-rev.txt
> @@ -42,11 +42,37 @@ OPTIONS
>  --all::
>  	List all commits reachable from all refs
>
> ---stdin::
> +--annotate-stdin::
>  	Transform stdin by substituting all the 40-character SHA-1
>  	hexes (say $hex) with "$hex ($rev_name)".  When used with
>  	--name-only, substitute with "$rev_name", omitting $hex
> -	altogether.  Intended for the scripter's use.
> +	altogether.
> ++
> +For example:
> ++
> +-----------
> +$ cat sample.txt
> +
> +An abbreviated revision 2ae0a9cb82 will not be substituted.
> +The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355=
dd8907,
> +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +
> +$ git name-rev --annotate-stdin <sample.txt
> +
> +An abbreviated revision 2ae0a9cb82 will not be substituted.
> +The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355=
dd8907 (master),
> +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +
> +$ git name-rev --name-only --annotate-stdin <sample.txt
> +
> +An abbreviated revision 2ae0a9cb82 will not be substituted.
> +The full name after substitution is master,
> +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +-----------
> +
> +--stdin::
> +	This option is deprecated in favor of 'git name-rev --annotate-stdin'=
=2E
> +	They are functionally equivalent.
>
>  --name-only::
>  	Instead of printing both the SHA-1 and the name, print only
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 27f60153a6c..8baf5b52d0b 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -527,7 +527,7 @@ static void name_rev_line(char *p, struct name_ref_=
data *data)
>  int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  {
>  	struct object_array revs =3D OBJECT_ARRAY_INIT;
> -	int all =3D 0, transform_stdin =3D 0, allow_undefined =3D 1, always =3D=
 0, peel_tag =3D 0;
> +	int all =3D 0, annotate_stdin =3D 0, transform_stdin =3D 0, allow_und=
efined =3D 1, always =3D 0, peel_tag =3D 0;
>  	struct name_ref_data data =3D { 0, 0, STRING_LIST_INIT_NODUP, STRING_=
LIST_INIT_NODUP };
>  	struct option opts[] =3D {
>  		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based n=
ames (no object names)")),
> @@ -538,7 +538,8 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
>  				   N_("ignore refs matching <pattern>")),
>  		OPT_GROUP(""),
>  		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all ref=
s")),
> -		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
> +		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use annotate-=
stdin instead")),
> +		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text fro=
m stdin")),
>  		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undef=
ined` names (default)")),

I=E2=80=99ve changed this back to a non hidden bool. I believe this shoul=
d be the last thing needed on this one.
Let me know if anything else needs adjustment, thanks!

>  		OPT_BOOL(0, "always",     &always,
>  			   N_("show abbreviated commit object as fallback")),
> @@ -554,11 +555,19 @@ int cmd_name_rev(int argc, const char **argv, con=
st char *prefix)
>  	init_commit_rev_name(&rev_names);
>  	git_config(git_default_config, NULL);
>  	argc =3D parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
> -	if (all + transform_stdin + !!argc > 1) {
> +
> +	if (transform_stdin) {
> +		warning("--stdin is deprecated. Please use --annotate-stdin instead,=
 "
> +					"which is functionally equivalent.\n"
> +					"This option will be removed in a future release.");
> +		annotate_stdin =3D 1;
> +	}
> +
> +	if (all + annotate_stdin + !!argc > 1) {
>  		error("Specify either a list, or --all, not both!");
>  		usage_with_options(name_rev_usage, opts);
>  	}
> -	if (all || transform_stdin)
> +	if (all || annotate_stdin)
>  		cutoff =3D 0;
>
>  	for (; argc; argc--, argv++) {
> @@ -613,7 +622,7 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
>  	for_each_ref(name_ref, &data);
>  	name_tips();
>
> -	if (transform_stdin) {
> +	if (annotate_stdin) {
>  		char buffer[2048];
>
>  		while (!feof(stdin)) {
> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> index 19c6f4acbf6..1e9f7833dd6 100755
> --- a/t/t3412-rebase-root.sh
> +++ b/t/t3412-rebase-root.sh
> @@ -11,7 +11,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  log_with_names () {
>  	git rev-list --topo-order --parents --pretty=3D"tformat:%s" HEAD |
> -	git name-rev --stdin --name-only --refs=3Drefs/heads/$1
> +	git name-rev --annotate-stdin --name-only --refs=3Drefs/heads/$1
>  }
>
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 50495598619..dc884107de4 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -659,7 +659,7 @@ EOF
>
>  test_expect_success 'log --graph with full output' '
>  	git log --graph --date-order --pretty=3Dshort |
> -		git name-rev --name-only --stdin |
> +		git name-rev --name-only --annotate-stdin |
>  		sed "s/Merge:.*/Merge: A B/;s/ *\$//" >actual &&
>  	test_cmp expect actual
>  '
> diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-ch=
erry-pick-file.sh
> index aebe4b69e13..6f3e5439771 100755
> --- a/t/t6007-rev-list-cherry-pick-file.sh
> +++ b/t/t6007-rev-list-cherry-pick-file.sh
> @@ -58,7 +58,7 @@ EOF
>
>  test_expect_success '--left-right' '
>  	git rev-list --left-right B...C > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
> @@ -78,14 +78,14 @@ EOF
>
>  test_expect_success '--cherry-pick bar does not come up empty' '
>  	git rev-list --left-right --cherry-pick B...C -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
>
>  test_expect_success 'bar does not come up empty' '
>  	git rev-list --left-right B...C -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
> @@ -97,14 +97,14 @@ EOF
>
>  test_expect_success '--cherry-pick bar does not come up empty (II)' '
>  	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
>
>  test_expect_success 'name-rev multiple --refs combine inclusive' '
>  	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/F" --refs=3D"*tags/E=
" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/F" --refs=3D=
"*tags/E" \
>  		<actual >actual.named &&
>  	test_cmp expect actual.named
>  '
> @@ -116,7 +116,7 @@ EOF
>  test_expect_success 'name-rev --refs excludes non-matched patterns' '
>  	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>e=
xpect &&
>  	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/F" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/F" \
>  		<actual >actual.named &&
>  	test_cmp expect actual.named
>  '
> @@ -128,14 +128,14 @@ EOF
>  test_expect_success 'name-rev --exclude excludes matched patterns' '
>  	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>e=
xpect &&
>  	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" --exclude=3D"*E" =
\
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" --exclud=
e=3D"*E" \
>  		<actual >actual.named &&
>  	test_cmp expect actual.named
>  '
>
>  test_expect_success 'name-rev --no-refs clears the refs list' '
>  	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/F" --refs=3D"*tags/E=
" --no-refs --refs=3D"*tags/G" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/F" --refs=3D=
"*tags/E" --no-refs --refs=3D"*tags/G" \
>  		<expect >actual &&
>  	test_cmp expect actual
>  '
> @@ -149,7 +149,7 @@ EOF
>
>  test_expect_success '--cherry-mark' '
>  	git rev-list --cherry-mark F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
> @@ -163,7 +163,7 @@ EOF
>
>  test_expect_success '--cherry-mark --left-right' '
>  	git rev-list --cherry-mark --left-right F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
> @@ -174,14 +174,14 @@ EOF
>
>  test_expect_success '--cherry-pick --right-only' '
>  	git rev-list --cherry-pick --right-only F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
>
>  test_expect_success '--cherry-pick --left-only' '
>  	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
> @@ -193,7 +193,7 @@ EOF
>
>  test_expect_success '--cherry' '
>  	git rev-list --cherry F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs=3D"*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs=3D"*tags/*" \
>  		< actual > actual.named &&
>  	test_cmp expect actual.named
>  '
> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.s=
h
> index 4f7fa8b6c03..4fedc614fa6 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -12,7 +12,7 @@ note () {
>  }
>
>  unnote () {
> -	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |=
\1 |g"
> +	git name-rev --tags --annotate-stdin | sed -e "s|$OID_REGEX (tags/\([=
^)]*\)) |\1 |g"
>  }
>
>  #
> diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.s=
h
> index e07b6070e0e..90ff1416400 100755
> --- a/t/t6111-rev-list-treesame.sh
> +++ b/t/t6111-rev-list-treesame.sh
> @@ -23,7 +23,8 @@ note () {
>  }
>
>  unnote () {
> -	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\))\(=
[ 	]\)|\1\2|g"
> +	git name-rev --tags --annotate-stdin | \
> +	sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
>  }
>
>  test_expect_success setup '
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index d8af2bb9d2b..9781b92aedd 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -270,7 +270,7 @@ test_expect_success 'name-rev --all' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success 'name-rev --stdin' '
> +test_expect_success 'name-rev --annotate-stdin' '
>  	>expect.unsorted &&
>  	for rev in $(git rev-list --all)
>  	do
> @@ -278,11 +278,16 @@ test_expect_success 'name-rev --stdin' '
>  		echo "$rev ($name)" >>expect.unsorted || return 1
>  	done &&
>  	sort <expect.unsorted >expect &&
> -	git rev-list --all | git name-rev --stdin >actual.unsorted &&
> +	git rev-list --all | git name-rev --annotate-stdin >actual.unsorted &=
&
>  	sort <actual.unsorted >actual &&
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'name-rev --stdin deprecated' "
> +	git rev-list --all | git name-rev --stdin 2>actual &&
> +	grep -E 'warning: --stdin is deprecated' actual
> +"
> +
>  test_expect_success 'describe --contains with the exact tags' '
>  	echo "A^0" >expect &&
>  	tag_object=3D$(git rev-parse refs/tags/A) &&
> -- =

> gitgitgadget
