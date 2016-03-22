From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 16:09:56 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603221552100.4690@virtualbox>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com> <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 16:10:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiNwe-00020N-Nr
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 16:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbcCVPKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 11:10:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:62783 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756376AbcCVPKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 11:10:01 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MDhba-1aZ29z1ju2-00H6Ia; Tue, 22 Mar 2016 16:09:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:g+gl0uaLoy7JwJHmS7okvLQX4nR1SiBdKCeAD0MXgl+3MwdI+gf
 VYlC8zQcqYMk647NlduB0vy9ed1cFYAfP71oJJsZKVnndD5b4BDlJAnS/sM3hrWQCnaNltT
 P0KegUUWScp7AETRODdotTNoJw+/OV9M5u/Z0LB5J1/z+Gz3fVCV1K1rvevex1PaFOvVARl
 UG7c9MkIgYK9+CkXVc9Fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sYmFlJZb8cE=:NkyK+PID9PqFlRbSSFXkF4
 AbOO3n9GVJTWvw+Yc0IYb6jLFXzVhkxGATb3O0U66JE/Sw1RvwWBolD0Zk0484PvE5T7HI8kg
 0F4Vj105sryYalqdHHcoBbiR+sO7zmv6LK8seKu4SYWJgoVN8UFlTLWjIBcobI2lTblVeN+PS
 mvpaeV4iI+zjlfMI9WQgupaMWiUUCF9qbQFQiTvltXbUoHAkMGQRK4+Kb1wFqw3B9F2un5xYy
 NJGV8yh9u4IBcsaShELLi0QcNTx7CMj/GU/BSNIzbv1n69pjxmqYaPmUh5A91GlGTUAkNLCje
 57pgXN77u2ADWrTJCmizWZKwP7w/T5vurp2N86FgtpA4kSnP1rz4SYiF+dMopskujo7Cz3GBr
 LgLb27EXHk5GzondsR9mhadoGBkXGDIlCqu/QtVHmV883bJvm4st5PWzp8XeQUMeerkt+nHWw
 z7EdBllM7xOBqiPG+rTrkYCtE2efqp2rqylzd9BKOoaTrfQQUCDANPB24j9+GU6eOD2bD2316
 vUSO/iK5nOHFOSWbkurMqpuIGFZsnpQZ6rOKbFwJriNtP15NvP/E03kXqwE3kq4bddUCLvNHc
 QCFJwtsdT9j4BHYvMHiyOFATDSszQpKBgacxqKe0LpUEKGGus7cGAXhxHuODr89Z8wE/Gyc7X
 EPbSA5d7FOlVNYGCBMsY0SEAP2wiqP7TFzHU1uQCNJg3zZjuXVG3650lH2fStQQ+TTcz9x4Gd
 WJQozwk4KsO3LSjCOU2Gw6H/JcSFXeEwHAbhaCoFX6OcOF3PyJduaJD2Y/ETCO6NqamKop82 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289507>

Hi,

On Tue, 22 Mar 2016, Pranit Bauva wrote:

> Convert the code literally without changing its design even though it
> seems that its obscure as to the use of comparing revision to different

s/its/it is/

> bisect arguments which seems like a problem in shell because of the way
> function arguments are handled.

I agree that it is obscure. That is why I would suggest to fix it during
the conversion. Using 'new_term' and 'orig_term' (or something similar)
would make much more sense.

Another good idea would be to include the shell code, or at least to
provide a link such as:

	https://github.com/git/git/blob/v2.8.0-rc4/git-bisect.sh#L572-L597

> The argument handling is kind of hard coded right now because it is not
> really be meant to be used like this and this is just for testing
> purposes whether this new method is as functional as its counter part.
> The shell counter part of the method has been retained for historical
> purposes.

Still, it would make more sense (both in terms of readability and in terms
of code safety) to introduce and use a function like

static int one_of(const char *term, ...)
{
	va_list matches;
	const char *match;

	va_start(matches, term);
	while ((match = va_arg(matches, const char *)))
		if (!strcmp(term, match))
			return 1;
	va_end(matches);

	return 0;
}

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..6cdae82 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -2,27 +2,64 @@
>  #include "cache.h"
>  #include "parse-options.h"
>  #include "bisect.h"
> +#include "refs.h"
>  
>  static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --next-all [--no-checkout]"),
> +	N_("git bisect--helper --check-term-format <term> <revision>"),

Good. This imitates the existing code.

>  	NULL
>  };
>  
> +static int check_term_format(const char *term, const char *revision, int flags);
> +
> +static int check_term_format(const char *term, const char *revision, int flag) {

Since you define the check_term_format() function here, the declaration
above is unnecessary. Let's just delete it.

> +	if (check_refname_format(term, flag))
> +		die("'%s' is not a valid term", term);
> +
> +	if (!strcmp(term, "help") || !strcmp(term, "start") ||
> +		!strcmp(term, "skip") || !strcmp(term, "next") ||
> +		!strcmp(term, "reset") || !strcmp(term, "visualize") ||
> +		!strcmp(term, "replay") || !strcmp(term, "log") ||
> +		!strcmp(term, "run"))
> +		die("can't use the builtin command '%s' as a term", term);

This would look so much nicer using the one_of() function above.

Please also note that our coding convention (as can be seen from the
existing code in builtin/*.c) is to indent the condition differently than
the block, either using an extra tab, or by using 4 spaces instead of the
tab.

> +	if (!strcmp(term, "bad") || !strcmp(term, "new"))
> +		if(strcmp(revision, "bad"))
> +			die("can't change the meaning of term '%s'", term);
> +
> +	if (!strcmp(term, "good") || !strcmp(term, "old"))
> +		if (strcmp(revision, "good"))
> +			die("can't change the meaning of term '%s'", term);

These two can be combined. Actually, these *four* can easily be combined:

	if ((one_of(term, "bad", "new", NULL) && strcmp(orig, "bad")) ||
	    (one_of(term, "good", "old", NULL) && strcmp(orig, "good")))
		die("can't change the meaning of term '%s'", term);

>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	int next_all = 0;
>  	int no_checkout = 0;
> +	const char *term;

Better use the existing convention:

	int check_term_format = 0;

>  	struct option options[] = {
>  		OPT_BOOL(0, "next-all", &next_all,
>  			 N_("perform 'git bisect next'")),
>  		OPT_BOOL(0, "no-checkout", &no_checkout,
>  			 N_("update BISECT_HEAD instead of checking out the current commit")),
> +		OPT_STRING(0, "check-term-format", &term, N_("term"),
> +			 N_("check the format of the ref")),

Hmm. The existing code suggests to use OPT_BOOL instead.

>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_bisect_helper_usage, 0);
>  
> +
> +	if (term != NULL) {
> +		if (argc > 0)

Here you need to test for a precise argc, not for a range.

> +			return check_term_format(term, argv[0], 0);
> +		else
> +			die("no revision provided with check_for_term");
> +	}
> +
>  	if (!next_all)
>  		usage_with_options(git_bisect_helper_usage, options);
>  
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 5d1cb00..ea237be 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -564,8 +564,8 @@ write_terms () {
>  	then
>  		die "$(gettext "please use two different terms")"
>  	fi
> -	check_term_format "$TERM_BAD" bad
> -	check_term_format "$TERM_GOOD" good
> +	git bisect--helper --check-term-format="$TERM_BAD" bad
> +	git bisect--helper --check-term-format="$TERM_GOOD" good

The existing convention is to make the first argument *not* a value of the
"option", i.e. `--check-term-format "$TERM_BAD"` without an equal sign.

Did you also run the test suite after compiling, to verify that the
documented expectations are still met after the conversion?

Ciao,
Johannes
