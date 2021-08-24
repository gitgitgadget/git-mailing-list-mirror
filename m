Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCFBC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AFF61176
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbhHXOAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:00:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:34289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234695AbhHXOAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 10:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629813561;
        bh=pAXIgRZcx0Q6aVaz7OK0QcEiZeciFWaiAKU+KX6pe1k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jm2858p1GV7FT8gm0qs3GdztJKECw52ySodBzy/RmV9bygPBlswdQ8Kqs1HuRcOiZ
         1O4AGby+CgoKH8CcHdxeLa5yr8V4WKWWNbBwhMvkR/mBtyl/CxC/dPSqlLzEguAq+i
         Hx2LEdO0ZQ147mRYNJ0HYj90AXT1vRs4EljL08xk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1n31jG3fgo-012bm8; Tue, 24
 Aug 2021 15:59:20 +0200
Date:   Tue, 24 Aug 2021 15:59:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
In-Reply-To: <20210820172148.2249-6-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108241541190.55@tvgsbejvaqbjf.bet>
References: <20210820172148.2249-1-mirucam@gmail.com> <20210820172148.2249-6-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dWoyJM2TgwQaxdTOOEVreavkvtLyMUsUD+QXxkrDNt/Qy22wv/Y
 HjXt+SD62PveelMM4Ok4WDcdoeztX54KCD6Vz9Y2NQ4GSPSUtdbnKCch6h2+b6rIsKOgPgX
 6x3Fbw3Q2c2nHLQkCty5IEJFn9yN+wYWqaSqYgePLbKG3/+iBtyk+HZboOeeryPHkTIXLZE
 Dv8AwahqeZnXHEhtDrohQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Veq9CejO3w=:mA0+rSSQHc7yUH7L1CGoj4
 KXfsgW1vEsXfQt/eqLdus6wI1Y7Eua2x7HOC6tGpd4CXIrh7iT1d105bLaj1eKhl4LYIsqAsR
 GJmS57z8Dnh6bt5Sa3fL8OIFUrclEGedWICsqhp9UIeZqC63vKRNlRPR0jSa+SmGQFl4FxLVr
 5wTXQY6PYkhxuVAfXCSFXZ+70e91E6restF+JNqCKDb/84zeenGcKNnJRMsoYlKZBmQm6RYH6
 MQ8k0ps0vShJB/IQLP8B4VLbH+g2w6/l+jO3K6X8PTAC4khXt1tD7N80qpRgyZstngImsdBl3
 nbijVVsKLeACDoSpgTHnKKYNXJ5cfTlvSBmXLRgSJkMID+nbyvOWup7GSQ8At9UAJKs91KkT4
 laaFOT9kdEX+ZRgludTOaXundDxLlhtSIoaN4IR1LQ3VO6xu6CvNRDhkSTCgg0aPGvtUnAgup
 z3DOXanRL4eB+Ax78In46hlGiUQnY6YmUpVMOjCydxKjQxqMGHNCgltY0gbSPc204QQ5qCC9D
 +UuxDY9lurBlhUaOo7CY0bAbiIISU7tjvY3xiZMzA7TI46WKYLJeQpvQx/aAwMY3MUeNIgf16
 D+49cwklqGoQ/4zq09XW1Z3468dYEJTv1YcUtW/09qx1Brb4/21dMdLavcJrzVAf6ri7Bs7u6
 l0R8sTmrEdttZ92jOZ8qMplXbixAZgQiE4RJ63OFMwj7uj4cvFPnG/wFnrrXYDREHaZNlNi8X
 5S7xK7bWISV4Qh1wncxZCNzb9HwF0ssyxMW2MuA6BjXTlljwIEdcKuwWo6eI/PaIr8KjLCxwE
 NhFZ+iveTQH6GhOU/L8BFvkgY8yzipsb0G9CnYK2JF6s3KezNo/bTwp9EYI7OsHmatXfOdSYE
 yRA1GFb95Q9hvGOpk5Dl/wWK4EGbQLzScUq3rh+2VUlFB9IY6cIJ5jPOAqi2m001l27KBKCzB
 kktcxJJlHJeY1FVMWvtQ9o6MjORdu5kNGLbT7nXPQI437pYly8hzPyr11+KcSJCemlxGXW7l0
 tdjF/48f1vdgDJtNagxQagMCfHeDfEcR4PXiQ52B+ROz+w+fReUHUvIGXVgLcfAYYpHs8xYMF
 nSxkfIP1+snOiL6rsuy6mM97GgSz5lpy7+xSzseQkibnE9iu9CTq0sSmg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Fri, 20 Aug 2021, Miriam Rubio wrote:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> Reimplement the `bisect_run()` shell function
> in C and also add `--bisect-run` subcommand to
> `git bisect--helper` to call it from git-bisect.sh.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 102 +++++++++++++++++++++++++++++++++++++++
>  git-bisect.sh            |  62 +-----------------------
>  2 files changed, 103 insertions(+), 61 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1e118a966a..8d33c809aa 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -18,6 +18,7 @@ static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG"=
)
>  static GIT_PATH_FUNC(git_path_head_name, "head-name")
>  static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>  static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT=
")
> +static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>
>  static const char * const git_bisect_helper_usage[] =3D {
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
> @@ -31,6 +32,7 @@ static const char * const git_bisect_helper_usage[] =
=3D {
>  	N_("git bisect--helper --bisect-replay <filename>"),
>  	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
>  	N_("git bisect--helper --bisect-visualize"),
> +	N_("git bisect--helper --bisect-run <cmd>..."),
>  	NULL
>  };
>
> @@ -144,6 +146,25 @@ static int append_to_file(const char *path, const c=
har *format, ...)
>  	return res;
>  }
>
> +static int print_file_to_stdout(const char *path)
> +{
> +	FILE *fp;
> +	char c;
> +
> +	fp =3D fopen(path, "r");
> +	if (!fp)
> +		return error_errno(_("cannot open file '%s' in read mode"), path);
> +
> +	c =3D fgetc(fp);
> +	while (c !=3D EOF) {
> +		printf ("%c", c);
> +		c =3D fgetc(fp);
> +	}
> +
> +	fclose(fp);

Rather than reading byte for byte (even if buffered), how about using
`copy_fd()`? Something like

	int fd =3D open(path, O_RDONLY), ret =3D 0;

	if (fd < 0)
		return error_errno(_("cannot open file '%s' for reading"), path);
	if (copy_fd(fd, 1) < 0)
		ret =3D error_errno(_("failed to read '%s'"), path);
	close(fd);
	return ret;

> +	return 0;
> +}
> +
>  static int check_term_format(const char *term, const char *orig_term)
>  {
>  	int res;
> @@ -1075,6 +1096,78 @@ static int bisect_visualize(struct bisect_terms *=
terms, const char **argv, int a
>  	return res;
>  }
>
> +static int bisect_run(struct bisect_terms *terms, const char **argv, in=
t argc)
> +{
> +	int res =3D BISECT_OK;
> +	struct strbuf command =3D STRBUF_INIT;
> +	struct strvec args =3D STRVEC_INIT;
> +	struct strvec run_args =3D STRVEC_INIT;
> +	const char *new_state;
> +	int temporary_stdout_fd, saved_stdout;
> +
> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_FAILED;
> +
> +	if (argc)
> +		sq_quote_argv(&command, argv);
> +	else {
> +		error(_("bisect run failed: no command provided."));
> +		return BISECT_FAILED;
> +	}
> +
> +	strvec_push(&run_args, command.buf);
> +
> +	while (1) {
> +		strvec_clear(&args);
> +
> +		printf(_("running %s\n"), command.buf);
> +		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
> +
> +		if (res < 0 || 128 <=3D res) {
> +			error(_("bisect run failed: exit code %d from"
> +				" '%s' is < 0 or >=3D 128"), res, command.buf);
> +			strbuf_release(&command);
> +			return res;
> +		}
> +
> +		if (res =3D=3D 125)
> +			new_state =3D "skip";
> +		else new_state =3D res > 0 ? terms->term_bad : terms->term_good;

I do not care _all_ that much about formatting, but I think others on this
list do, and might point out that the `else` wants to live on its own
line.

> +		temporary_stdout_fd =3D open(git_path_bisect_run(), O_CREAT | O_WRONL=
Y | O_TRUNC, 0666);
> +		saved_stdout =3D dup(1);
> +		dup2(temporary_stdout_fd, 1);

This temporary redirection looks a bit iffy. I wonder whether there is a
way to tell `bisect_state()` to print to a given file descriptor, _in
addition to_ `stdout`? That would also make `print_file_to_stdout()`
obsolete.

What calls exactly are making that print to `stdout` anyway?

This is my only remaining issue with the current 5/6.

Thank you,
Dscho

> +
> +		res =3D bisect_state(terms, &new_state, 1);
> +
> +		dup2(saved_stdout, 1);
> +		close(saved_stdout);
> +		close(temporary_stdout_fd);
> +
> +		print_file_to_stdout(git_path_bisect_run());
> +
> +		if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT)
> +			error(_("bisect run cannot continue any more"));
> +		else if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> +			printf(_("bisect run success"));
> +			res =3D BISECT_OK;
> +		} else if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +			printf(_("bisect found first bad commit"));
> +			res =3D BISECT_OK;
> +		} else if (res) {
> +			error(_("bisect run failed:'git bisect--helper --bisect-state"
> +			" %s' exited with error code %d"), args.v[0], res);
> +		} else {
> +			continue;
> +		}
> +
> +		strbuf_release(&command);
> +		strvec_clear(&args);
> +		strvec_clear(&run_args);
> +		return res;
> +	}
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -1089,6 +1182,7 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  		BISECT_REPLAY,
>  		BISECT_SKIP,
>  		BISECT_VISUALIZE,
> +		BISECT_RUN,
>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -1112,6 +1206,8 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  			 N_("skip some commits for checkout"), BISECT_SKIP),
>  		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
>  			 N_("visualize the bisection"), BISECT_VISUALIZE),
> +		OPT_CMDMODE(0, "bisect-run", &cmdmode,
> +			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> @@ -1177,6 +1273,12 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>  		get_terms(&terms);
>  		res =3D bisect_visualize(&terms, argv, argc);
>  		break;
> +	case BISECT_RUN:
> +		if (!argc)
> +			return error(_("bisect run failed: no command provided."));
> +		get_terms(&terms);
> +		res =3D bisect_run(&terms, argv, argc);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 95f7f3fb8c..e83d011e17 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -39,66 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=3Dbad
>  TERM_GOOD=3Dgood
>
> -bisect_run () {
> -	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || ex=
it
> -
> -	test -n "$*" || die "$(gettext "bisect run failed: no command provided=
.")"
> -
> -	while true
> -	do
> -		command=3D"$@"
> -		eval_gettextln "running \$command"
> -		"$@"
> -		res=3D$?
> -
> -		# Check for really bad run error.
> -		if [ $res -lt 0 -o $res -ge 128 ]
> -		then
> -			eval_gettextln "bisect run failed:
> -exit code \$res from '\$command' is < 0 or >=3D 128" >&2
> -			exit $res
> -		fi
> -
> -		# Find current state depending on run success or failure.
> -		# A special exit code of 125 means cannot test.
> -		if [ $res -eq 125 ]
> -		then
> -			state=3D'skip'
> -		elif [ $res -gt 0 ]
> -		then
> -			state=3D"$TERM_BAD"
> -		else
> -			state=3D"$TERM_GOOD"
> -		fi
> -
> -		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
> -		res=3D$?
> -
> -		cat "$GIT_DIR/BISECT_RUN"
> -
> -		if sane_grep "first $TERM_BAD commit could be any of" "$GIT_DIR/BISEC=
T_RUN" \
> -			>/dev/null
> -		then
> -			gettextln "bisect run cannot continue any more" >&2
> -			exit $res
> -		fi
> -
> -		if [ $res -ne 0 ]
> -		then
> -			eval_gettextln "bisect run failed:
> -'bisect-state \$state' exited with error code \$res" >&2
> -			exit $res
> -		fi
> -
> -		if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BISECT_RUN" >/=
dev/null
> -		then
> -			gettextln "bisect run success"
> -			exit 0;
> -		fi
> -
> -	done
> -}
> -
>  get_terms () {
>  	if test -s "$GIT_DIR/BISECT_TERMS"
>  	then
> @@ -137,7 +77,7 @@ case "$#" in
>  	log)
>  		git bisect--helper --bisect-log || exit ;;
>  	run)
> -		bisect_run "$@" ;;
> +		git bisect--helper --bisect-run "$@" || exit;;
>  	terms)
>  		git bisect--helper --bisect-terms "$@" || exit;;
>  	*)
> --
> 2.29.2
>
>
