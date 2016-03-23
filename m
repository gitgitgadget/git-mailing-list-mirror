From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 12:57:17 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603231238180.4690@virtualbox>
References: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com> <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:57:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aihPk-000636-5A
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 12:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbcCWL5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 07:57:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:59806 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbcCWL5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 07:57:22 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lkwc9-1aAjdb2kvF-00ajMZ; Wed, 23 Mar 2016 12:57:18
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:rgyCIF30+ittnr71/rv6D8admlL6bs4Yow4VxPuk/3Jc8G0104x
 GiQXl0+pplrtKMbnGlw5DILUfpRxw7GfFLF6JR60rZ1+yqMQnNwF6spPJDFrYtSIculqLKJ
 2K8LiGBjmlSMwbdPykQOx+2UfLC2lDziu/BPUcx64M+vawphzLUTEBzvNRrdpJe9jQwJRHR
 kxnEugt5372bLRt2unv2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HThsnNViQLk=:5Q0YJtAcGE/whZj8jHJTXn
 lY/W/AihF0WQPjfai5yzhJiqZGtLVoTdY2vJmCf/3FcyjSBHOPUxzamVvL6CmI8L7IeGk4u9q
 CV9BtUqEbxiqy3uY7efK8nYD8ZqmKtnNl1ER6Vy1Zz4QLq1wxqo1umbyGXGCCSk1LS1ybw0Vf
 HBvVlffrLbsYbwfOCoQjIDfocJNQ2hmuUclgy5TaWnr6/dZMRFMnTTZWynQbPRkPcEwgQBqqK
 ag/s3Z+rEoVaEdZ+IcDKGA3LX99ewt2dt9nG78MdslEh72u1YMI9rJnoR7odvfPYuexi4ZSuM
 Id9Wwxp91gUvNB7IMGuOPXPKCnyyT52+Zvqmx75cJAZlzZG1MI1+SBOM0H3lVeLMluzxM9n52
 I1jol6jkdmOhZLIzRGyoE4/gyucYDwW6t8uS74JXF9Li/JGLKex7oFNZmidDs1cL/wvyqyigU
 dhK1AjpfokcupU6M/Y1X+HQrFF7oK3/3ZsODDcvAn3wbaaXvbPmibygJUv72O7VZsuxO2FLd6
 sKdSNV7G2Eul7drV36k77O2/m+t3/tkgp9KLwcY8l1X1jj3sMhVNtfedJY/w6cshMr4bmbdXP
 7p0nSayuy7pj9ZilW0/oPX+Dj+Tr4M3u/3pnhgA4leric1L5ObibuMKJPUM1U2ib7F1tmNS9e
 FaWqCJwr1+4swzDRZ4AqV9mc26OAyGN2aJ8L2DdR9ZHWNndbaTy5b+Y9UbjS+iUJ31Hb6U0Op
 esIJuUJ/CwUlMSGuQCpVYzlazyjwNPgus71Z2kTj3xmNOdkiIN0u5q5RONdhWdDdc3A5BLYp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289653>

Hi Pranit,

On Wed, 23 Mar 2016, Pranit Bauva wrote:

> Convert the code literally without changing its design even though it
> seems that it is obscure as to the use of comparing revision to different
> bisect arguments which seems like a problem in shell because of the way
> function arguments are handled.

I still believe that it would make for an improvement to replace
"revision" by "orig_term".

> The argument handling is kind of hard coded right now because it is not
> really be meant to be used like this and this is just for testing
> purposes whether this new method is as functional as its counter part.
> The shell counter part of the method has been retained for historical
> purposes.

Well, maybe the argument handling is really meant to be used like this in
the end? Just skip that paragraph.

> Also using OPT_CMDMODE() to handle check-term-format and next-all
> because these sub commands are independent and error should be shown if
> used together and should be handled independently.

As is often the case, after some discussion a single patch becomes more
than just one change. This is what we see here, too: OPT_CMDMODE() is a
change that needs preparation of the existing code in
builtin/bisect--helper.c, and I would highly suggest to split that change
out into its own patch. It makes for a nicer story, and it is *much*
easier to review.

> This commit reduces the number of failed tests in
> t6030-bisect-porcelain.sh and t6041-bisect-submodule.sh

Oh? Which tests are supposed to fail? I do not see any failing tests
here...

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..ab3891c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> [...]
> +static int check_term_format(const char *term, const char *revision, int flag) {
> +	if (check_refname_format(term, flag))
> +		die("'%s' is not a valid term", term);
> +
> +	if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
> +	    "replay", "log", "run", NULL))

If I understood Junio correctly, he meant to line up the second line with
the corresponding level. In this case, as "replay" is a parameter of the
one_of() function, the indentation would look like this instead:

	if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
		   "replay", "log", "run", NULL))

> +		die("can't use the builtin command '%s' as a term", term);
> +
> +	/* In theory, nothing prevents swapping
> +	 * completely good and bad, but this situation
> +	 * could be confusing and hasn't been tested
> +	 * enough. Forbid it for now.
> +	 */

I see quite a few comments that put the closing "*/" on its own line, but
do not award the same pleasure to the opening "/*". Personally, I much
prefer the opening "/*" to have an entire line to itself, too, but I guess
that there is enough precendence in Git's source code to accept both
forms.

> +	if (!strcmp(term, "bad") || !strcmp(term, "new"))
> +		if (strcmp(revision, "bad"))
> +			die("can't change the meaning of term '%s'", term);
> +
> +	if(!strcmp(term, "good") || !strcmp(term, "old"))
> +		if (strcmp(revision, "good"))
> +			die("can't change the meaning of term '%s'", term);

I am still convinced that

	if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
	    (one_of(term, "good", "old", NULL) && strcmp(orig_term, "good")))
		die("can't change the meaning of term '%s'", term);

looks so much nicer.

>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -	int next_all = 0;
> +	int sub_command = 0;
>  	int no_checkout = 0;
> +
> +	enum sub_commands {
> +		NEXT_ALL,
> +		CHECK_TERM_FMT
> +	};

Interesting. I did not think that Git's source code declares enums inside
functions, but builtin/remote.c's config_read_branches() does, so this
code is fine.

Still, the patch would be easier to review (corollary: bugs would have a
harder time to hide) if the change from OPT_BOOL to OPT_CMDMODE was done
in a separate, preparatory patch.

>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_bisect_helper_usage, 0);
>  
> -	if (!next_all)
> +	if (sub_command == CHECK_TERM_FMT) {
> +		if (argc == 2) {
> +			if (argv[0] != NULL && argv[1] != NULL)
> +				return check_term_format(argv[0], argv[1], 0);
> +			else
> +				die("no revision or term provided with check_for_term");
> +		}
> +		else
> +			die("--check-term-format expects 2 arguments");
> +	}
> +
> +	if (sub_command != NEXT_ALL && sub_command != CHECK_TERM_FMT)
>  		usage_with_options(git_bisect_helper_usage, options);

Personally, I would prefer

- the usage_with_options() code to come before any sub_command processing,

- the sub_command enum to be initialized with -1, or alternatively
  hardcoding NEXT_ALL to 1,

- to avoid else clauses after an if () clause whose block returns or
  die()s,

- to order the clauses of an if/else in ascending size, i.e.

	if (argc != 2)
		die(...);
	if ...

- to avoid checking argv[i] for NULL when i < argc (it is the contract
  that argv[0..argc-1] are all non-NULL, so checking for it is unnecessary
  churn),

- use a switch() on sub_command instead of unrolled if () statements, and

- wrap the code at 80 columns/row (interpreting tabs as "up to 8 spaces").

The rest of the patch looks good.

Ciao,
Johannes
