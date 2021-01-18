Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4272C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803AA22BE9
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390757AbhARQQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:16:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:44827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406552AbhARQPv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 11:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610986458;
        bh=sbXIJwQpl2XAS9fAhZC0EM5mEq0FJTytqCGAzBeIe88=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Phx3pcBqwKxW0d7kVThQnle0JyhUayRyxfZiNAQLOfT5y4rzpQk/6r+0bJxhcbJri
         ZPd7FKPK9uSByNZGRwvwmyYqhll0wRDInp5EhZM2e68G10ppllKtXKVl4Babec0NMM
         977KAbiYRWifNFBQh7Wpc437xNzlpOqbTzFVGgPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1lzOqW0z3i-00y8zt; Mon, 18
 Jan 2021 17:14:18 +0100
Date:   Mon, 18 Jan 2021 17:14:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 6/7] bisect--helper: reimplement `bisect_skip` shell
 function in C
In-Reply-To: <20201221162743.96056-7-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101181707580.52@tvgsbejvaqbjf.bet>
References: <20201221162743.96056-1-mirucam@gmail.com> <20201221162743.96056-7-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R8o5bISXvwbIHWqnNyWsHRayYiSBl9oSrOG+AlICBrNlYLFy3aD
 HyhpxXR0ZrpyeYRGnpeu/v4RkgAancl8wKiHZyX39TtpofG4/nwpgSTDTQXgB8qUtFNIpPA
 EKhLG8pX7uziCKBi4yDFJc4JQuITlukDYAyrv/rzglT41lTHZSOSj0qbokbykJfFP44eZVR
 kTB+cdrCBNSIA8aPzFIHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kybTOvNjN6U=:8QEZ1bNZokeJFCMhuKsCrU
 GQDFQ4ObPd9oIJLCtxZdbGDHxc8Zwdh7T3h1NnWQrzUAbPKBVGQkzyogyGH+gko+MQqJ5c2Tv
 nAmI2T6BndfA/mDhhrmMrag0H/AQAYa2vr0IsjWKFXxKWhIUnPVfZw2aHAKD5d3KMhryliUie
 0GDF4Gf6Jlq6IJ3Gh7LF6/PypVRwhAl7wS8/a67wuP5q6WYHeldB1UKmofsiMGCflVmgtLjoE
 4ad88SiboS3uE0UMhIRL+cHZP7FsfmOVKhIFjM1xmEBUhjQ/Fjy3Mf1cux9SqdKZXUF4vIQFS
 lFnco8mBv84NO7C+324Kbml4CEgaU/EapO9tgzAPXfdcZScsuYjUIZ0oyt32FW/teo+BF7jhW
 /igdRjHE+anXhXouL4Jh9BXnnWWSaB3SYg99Yw14OvaQfO20Bcs8Dfg/Vm35JKoZ0+VP/kEOj
 pPPpRsHjEoX6YTkjn5B41dXtZJWdwf5H2yFK7twlT6UAWpYBJiJFGcphbjjy+9RRZR6cXk6xx
 mpah43IF/uT1PZ2R3rBajodvT9qa5lENeEaNjKraACTzvqnJ8JkdVVOGDt60WXMGTSjjraV95
 kGYVibj6ToFE059oH0NUenZkp5vWvEPnBbtJTIDt8RGcD0Qm/8631ixCMcyKne61N7lUzRpTQ
 YZ71FaCbZcZXy1Nl33QzkZmTh1syBlBXCv9ly9DpTqFM1dqf0gfWvfA3r7ovUVjGs+Rbh4mLJ
 GDc1hdb+jZuvWI7C+MoOwba7kJ40kvFRb1CRDI+52jgIJ8u8M+NbDNHCIU5C3cDjBOyohdqbe
 TH7l5U+eE8HWsmXSlNkNs5+y0l5cdIJg0GHQ/gN1N1AEJWQ9qYUGGex72IIWFO3Y7GREQcdAK
 iV3ZaS0SW+u6h87lv2u49Mx0V6gFfPBvvSsJ4tghY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 21 Dec 2020, Miriam Rubio wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index d570a165de..1a6c75183a 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1030,6 +1031,43 @@ static enum bisect_error bisect_replay(struct bis=
ect_terms *terms, const char *f
>  	return bisect_auto_next(terms, NULL);
>  }
>
> +static enum bisect_error bisect_skip(struct bisect_terms *terms, const =
char **argv, int argc)
> +{
> +	int i;
> +	enum bisect_error res;
> +	const char *pattern =3D "*..*";
> +	struct strvec argv_state =3D STRVEC_INIT;
> +
> +	strvec_push(&argv_state, "skip");
> +
> +	for (i =3D 0; i < argc; i++) {
> +		if (!wildmatch(pattern, argv[i], 0)) {

Better use `strstr()`:

		const char *dotdot =3D strstr(argv[i], "..");

		if (dotdot) {
			[...]
		}

> +			struct rev_info revs;
> +			struct commit *commit;
> +			struct strvec rev_argv =3D STRVEC_INIT;
> +
> +			strvec_pushl(&rev_argv, "skipped_commits", argv[i], NULL);
> +			init_revisions(&revs, NULL);
> +			setup_revisions(rev_argv.nr, rev_argv.v, &revs, NULL);
> +			strvec_clear(&rev_argv);

Since the first argument passed to `setup_revisions()` is always ignored,
you can avoid all that `strvec` business altogether thusly:

			setup_revisions(2, argv + i - 1, &revs, NULL);

Other than that, this patch looks good to me.

Ciao,
Dscho

> +
> +			if (prepare_revision_walk(&revs))
> +				die(_("revision walk setup failed\n"));
> +			while ((commit =3D get_revision(&revs)) !=3D NULL)
> +				strvec_push(&argv_state,
> +						oid_to_hex(&commit->object.oid));
> +
> +			reset_revision_walk();
> +		} else {
> +			strvec_push(&argv_state, argv[i]);
> +		}
> +	}
> +	res =3D bisect_state(terms, argv_state.v, argv_state.nr);
> +
> +	strvec_clear(&argv_state);
> +	return res;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -1042,7 +1080,8 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  		BISECT_NEXT,
>  		BISECT_STATE,
>  		BISECT_LOG,
> -		BISECT_REPLAY
> +		BISECT_REPLAY,
> +		BISECT_SKIP
>  	} cmdmode =3D 0;
>  	int res =3D 0, nolog =3D 0;
>  	struct option options[] =3D {
> @@ -1064,6 +1103,8 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
>  			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
>  		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
>  			 N_("replay the bisection process from the given file"), BISECT_REPL=
AY),
> +		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
> +			 N_("skip some commits for checkout"), BISECT_SKIP),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> @@ -1126,6 +1167,10 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res =3D bisect_replay(&terms, argv[0]);
>  		break;
> +	case BISECT_SKIP:
> +		set_terms(&terms, "bad", "good");
> +		res =3D bisect_skip(&terms, argv, argc);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 79bcd31bd7..016cc34e03 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -39,21 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=3Dbad
>  TERM_GOOD=3Dgood
>
> -bisect_skip() {
> -	all=3D''
> -	for arg in "$@"
> -	do
> -		case "$arg" in
> -		*..*)
> -			revs=3D$(git rev-list "$arg") || die "$(eval_gettext "Bad rev input:=
 \$arg")" ;;
> -		*)
> -			revs=3D$(git rev-parse --sq-quote "$arg") ;;
> -		esac
> -		all=3D"$all $revs"
> -	done
> -	eval git bisect--helper --bisect-state 'skip' $all
> -}
> -
>  bisect_visualize() {
>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || ex=
it
>
> @@ -162,7 +147,7 @@ case "$#" in
>  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
>  		git bisect--helper --bisect-state "$cmd" "$@" ;;
>  	skip)
> -		bisect_skip "$@" ;;
> +		git bisect--helper --bisect-skip "$@" || exit;;
>  	next)
>  		# Not sure we want "next" at the UI level anymore.
>  		git bisect--helper --bisect-next "$@" || exit ;;
> --
> 2.29.2
>
>
