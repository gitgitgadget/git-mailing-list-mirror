Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC199C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 13:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBXNxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 08:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBXNxt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 08:53:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72D2887B
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 05:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677246809; i=johannes.schindelin@gmx.de;
        bh=cMlMu9/N+Lb6GHx1IWgvO612kCxGaJz3XvvoLkL28uA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=rEa9A8P0Q40JjyzsBL33lkSj8+otNZwA2IUVpZXL4WPFjIWGAymdk3tXrAh6WnYzE
         CEpl6E/ut9yuCyfe7ROKWzCKSYXr3yng0bwyzmVF6baXBLsMchkdhDfbugQgRhbiHf
         RpXla4UYStYqjEsMPthRrU3oZVP7i25GdLkrTmjCvDlH6x6TImoYRVAXk9ciJnuX9o
         1QKxTwgYtupvTkF9gYqUz1g4vCf2cQHF/wu/bksBJBakXk7YbSgT7bxPXkfYLiIN2P
         DHDpruAvvr9s7N3lNyRRIgDCit6vRNq6Z+AEP8Gmso+Gy3HL5CTjmEIyp95fsoZ4ug
         lzrWc1UJ5RADg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.113.48] ([213.196.212.111]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1omdvA2tiv-00lndE; Fri, 24
 Feb 2023 14:53:29 +0100
Date:   Fri, 24 Feb 2023 14:53:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com, sorganov@gmail.com
Subject: Re: [PATCH v4 3/3] rebase: add a config option for --rebase-merges
In-Reply-To: <20230223053410.644503-3-alexhenrie24@gmail.com>
Message-ID: <c918797c-75cc-80d4-c978-360388877d63@gmx.de>
References: <20230223053410.644503-1-alexhenrie24@gmail.com> <20230223053410.644503-3-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eFIqCZ3WjpcfBVUZJhzQ2EUU745XBkYpZ7ISuu7mC9VbFHrZXT9
 SuzwIVaq5tLG6aNK/Lfhrc/bKDgIik+ODkIwhkmw9s/3xpOllnjymKH1DB0ssXHV4eThnP6
 /W11Hv/P2v8VyA9C841MzcRjEYu+SrmdMJ9VIZfJd8aoCnEfPrmhk35bKTjRuR1CNKcReAH
 fFHR/74lssimO5uXyteig==
UI-OutboundReport: notjunk:1;M01:P0:ignfVRApItw=;SobGI/cC155abMoXoILi/9n4xH+
 Vc5u4IxV9Q+dMCELGfH9ZGoOQYx2zoiYoRX0YXTqRzyqQfNz+1rPiLWxxzmkU6Jt5HREjAiHF
 ZU38taIa7x/5MaFTNaa3sw7+m37HEG3B6TZVqhsIQI5sV67F/qQBlo59F6t9A5GpM79QwmPxP
 2WEhY+UZl34lazQC43arTkRR1L8atBC+iYzB6DQG1Qa4NvYxmL8ieg2HP6CUk/DnraxKq20Ln
 2bi7r9lg0naCo3d9zFl3THWnFJ/2SqWeaqBQpnGo1lJ3rZ7dVb4ivxE85ZNfrbSHOo15gSN/y
 qPITpHtQvDm7SStJGf/0CGFWa/J9Yv4cdYW86uPGoxOIIKcfyeCE3iMXkSF44P/UJ+DjGsPSR
 Hq+X6rJJG7Ain2ma+5m7Y26/Xivw7ySCrxnemxQwMcl8P5ITRYf1Ce4UcrSkud7oDq1qb5cLQ
 0TG/tYj3PwJdOqojLw6A+ptQnnXQcPQZXqA8A2KJSubvhgMw4JD/QIokYArfBawEX/VrR7mJI
 gVlKQPOAS9z0bMmaNNn2DAm+eVrUiu6otAP1v+eU3NbrLHm05/15swo2pzZqtX6VB51n1z/+7
 EyYgKEnyBZ3VV+LcUrPF4kUDzCkh35TEqyikngxcE8jtwDH+2wpUrdAuTUsOKG0bHFMoiiKXC
 lehWd/x58p6K+omBHvNaOpmRCNuAyQc4fTQ8Mr2BslRLIdCEu+yMIpE4Tpy1T4SwdXGZqvTpm
 LHopZa29m/Ds9QsgWTY4u2iYsbyCaq4t/mIsQLjbqWKycgEt29FXLXpZ9CITnofvJqeOdKRXi
 2eg2rxeQNftkVsXSNtnbwmTJzQ+pgDMAHkkG5qiWnRcVPzgOAjxKwt6vs8RNeKYzasmnHxSeN
 K0SKnSwri+KcQKYqqao5GH2XXafWZfSPyQB0Q36pK3yVRMyl2f0v6ZDLZcbS/O9uF/YdU/cDQ
 4icU2eZJgbZ1qaN0dFLzGrsH9YE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Wed, 22 Feb 2023, Alex Henrie wrote:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b68fc2fbb7..45cf445d42 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -771,6 +771,20 @@ static int run_specific_rebase(struct rebase_option=
s *opts)
>  	return status ? -1 : 0;
>  }
>
> +static void parse_merges_value(struct rebase_options *options, const ch=
ar *value)
> +{
> +	if (value) {
> +		if (!strcmp("no-rebase-cousins", value))

If you want to support `rebase.merges=3D` to imply `no-rebase-cousins`, th=
is
would be the correct place to do it:

		if (!*value || !strcmp("no-rebase-cousins", value))

> +			options->rebase_cousins =3D 0;
> +		else if (!strcmp("rebase-cousins", value))
> +			options->rebase_cousins =3D 1;
> +		else
> +			die(_("Unknown mode: %s"), value);
> +	}
> +
> +	options->rebase_merges =3D 1;

I would expect `options->rebase_merges =3D 0` if `value =3D=3D NULL`. IOW =
I
would have expected `parse_merges_value()` to start with:

	if (!value) {
		options->rebase_merges =3D 0;
		return;
	}

This assumes, of course, the parse_options semantics, where a `--no-*` opt=
ion
passes `NULL` as argument to the callback.

However, this is _not_ the parse_options callback, and if the (optional)
argument was not specified, we do end up with a `NULL` here in spite of
wanting to enable the rebase-merges mode.

However, a primary reason why you introduce the function is to support
config value parsing. And in config value parsing, a "maybe-bool" with a
NULL value is considered to be equivalent to `true`! (See
`git_parse_maybe_bool_text()` or
https://git-scm.com/docs/git-config#Documentation/git-config.txt-true for
details.). For example,

	[http]
		sslVerify

is equivalent to

	[http]
		sslVerify =3D true

But since `git_parse_maybe_bool()` already takes care of handling that
case (in which case we do not even want to call `git_parse_maybe_bool()`),
you can limit that function to handling the command-line semantics.

So with those confusingly disagreeing semantics, I see not only myself,
but other readers doing very, very well, indeed, with a code comment that
explains under what circumstances we expect this callback to be called
with `value =3D=3D NULL`.

> +}
> +
>  static int rebase_config(const char *var, const char *value, void *data=
)
>  {
>  	struct rebase_options *opts =3D data;
> @@ -815,6 +829,13 @@ static int rebase_config(const char *var, const cha=
r *value, void *data)
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "rebase.merges") && value && *value) {

Why do we require a non-empty `value` here?

	[rebase]
		merges

should be equivalent to `true`,

	[rebase]
		merges =3D

should probably be equivalent to `false`, and both are handled correctly
by `git_parse_maybe_bool()`.

> +		opts->rebase_merges =3D git_parse_maybe_bool(value);
> +		if (opts->rebase_merges < 0)
> +			parse_merges_value(opts, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "rebase.backend")) {
>  		return git_config_string(&opts->default_backend, var, value);
>  	}
> @@ -980,6 +1001,18 @@ static int parse_opt_empty(const struct option *op=
t, const char *arg, int unset)
>  	return 0;
>  }
>
> +static int parse_opt_merges(const struct option *opt, const char *arg, =
int unset)
> +{
> +	struct rebase_options *options =3D opt->value;
> +
> +	if (unset)
> +		options->rebase_merges =3D 0;
> +	else
> +		parse_merges_value(options, arg);
> +
> +	return 0;
> +}
> +

It is kind of inelegant to require a _second_ callback for the
command-line parsing, but I guess if we want a `--no-rebase-merges` option
to override a config setting, we cannot help it.

>  static void NORETURN error_on_missing_default_upstream(void)
>  {
>  	struct branch *current_branch =3D branch_get(NULL);
> @@ -1035,7 +1068,6 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  	struct object_id branch_base;
>  	int ignore_whitespace =3D 0;
>  	const char *gpg_sign =3D NULL;
> -	const char *rebase_merges =3D NULL;
>  	struct string_list strategy_options =3D STRING_LIST_INIT_NODUP;
>  	struct object_id squash_onto;
>  	char *squash_onto_name =3D NULL;
> @@ -1137,10 +1169,9 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  			   &options.allow_empty_message,
>  			   N_("allow rebasing commits with empty messages"),
>  			   PARSE_OPT_HIDDEN),
> -		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
> -			N_("mode"),
> +		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
>  			N_("try to rebase merges instead of skipping them"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
> +			PARSE_OPT_OPTARG, parse_opt_merges),
>  		OPT_BOOL(0, "fork-point", &options.fork_point,
>  			 N_("use 'merge-base --fork-point' to refine upstream")),
>  		OPT_STRING('s', "strategy", &options.strategy,
> @@ -1436,14 +1467,8 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  	if (options.exec.nr)
>  		imply_merge(&options, "--exec");
>
> -	if (rebase_merges) {
> -		if (!strcmp("rebase-cousins", rebase_merges))
> -			options.rebase_cousins =3D 1;
> -		else if (strcmp("no-rebase-cousins", rebase_merges))
> -			die(_("Unknown mode: %s"), rebase_merges);
> -		options.rebase_merges =3D 1;
> +	if (options.rebase_merges)
>  		imply_merge(&options, "--rebase-merges");
> -	}
>
>  	if (options.type =3D=3D REBASE_APPLY) {
>  		if (ignore_whitespace)
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index c73949df18..d4b0e8fd49 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -284,6 +284,102 @@ test_expect_success '--rebase-merges=3D"" is inval=
id syntax' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'rebase.merges=3D"" is equivalent to not passing --=
rebase-merges' '
> +	test_config rebase.merges "" &&
> +	git checkout -b config-merges-blank E &&
> +	git rebase C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success 'rebase.merges=3Drebase-cousins is equivalent to --=
rebase-merges=3Drebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b config-rebase-cousins main &&
> +	git rebase HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
> +test_expect_success '--no-rebase-merges overrides rebase.merges=3Dno-re=
base-cousins' '
> +	test_config rebase.merges no-rebase-cousins &&
> +	git checkout -b override-config-no-rebase-cousins E &&
> +	git rebase --no-rebase-merges C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges=3Dno-rebase-cousins overrides reba=
se.merges=3Drebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b override-config-rebase-cousins main &&
> +	git rebase --rebase-merges=3Dno-rebase-cousins HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	o | H
> +	|/
> +	o A
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges overrides rebase.merges=3Dfalse' '
> +	test_config rebase.merges false &&
> +	git checkout -b override-config-merges-false E &&
> +	before=3D"$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase --rebase-merges C &&
> +	test_cmp_rev HEAD $before
> +'
> +
> +test_expect_success '--rebase-merges does not override rebase.merges=3D=
rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b no-override-config-rebase-cousins main &&
> +	git rebase --rebase-merges HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
> +test_expect_success 'local rebase.merges=3Dfalse overrides global rebas=
e.merges=3Dtrue' '
> +	test_config_global rebase.merges true &&
> +	test_config rebase.merges false &&
> +	git checkout -b override-global-config E &&
> +	git rebase C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success 'local rebase.merges=3D"" does not override global =
rebase.merges=3Dtrue' '
> +	test_config_global rebase.merges no-rebase-cousins &&
> +	test_config rebase.merges "" &&
> +	git checkout -b no-override-global-config E &&
> +	before=3D"$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase C &&
> +	test_cmp_rev HEAD $before
> +'
> +

I understand the temptation to introduce exhaustive matrices that test all
the different settings in all the different ways they can be specified.

However, I would much prefer to keep the tests succinct, not the least to
avoid the every-increasing runtime of Git's CI. It's already taking about
an order of magnitude or two too long to be reasonable.

So I'd suggest reducing the tests to a single one instead of eight: verify
that `rebase.merges=3Dno-rebase-cousins` is heeded, and that
`--no-rebase-cousins` overrides that. That should be plenty sufficient to
prevent regressions.

Ciao,
Johannes

>  test_expect_success 'refs/rewritten/* is worktree-local' '
>  	git worktree add wt &&
>  	cat >wt/script-from-scratch <<-\EOF &&
> --
> 2.39.2
>
>
