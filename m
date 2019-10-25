Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8641F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfJYLiA (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 07:38:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:51069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfJYLh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 07:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572003470;
        bh=dmylmp0OuOsNqaCkk43liC6CVY0Up/gQGdqCCfVv/A8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A9ecjO9oTCj0Qr8mCgoUeisUb0SjkCyXJfHMt31235RKvKjofbpUZnGvBSBnQDNo8
         G6R2wsv2Nowa2SHKtiXNqnE7Ti2ppiLdtVXl2nFrHsdFBLyvwLRKiSFAEy8rqGaWrO
         UNKIm2o+tlY5q1J9q1FjQtoae4xawkLIntVulPVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1i4kny2R27-00zWU8; Fri, 25
 Oct 2019 13:37:49 +0200
Date:   Fri, 25 Oct 2019 13:37:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
In-Reply-To: <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>        <pull.407.v2.git.1571755538.gitgitgadget@gmail.com> <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Nj4jmF+t5p9JB0f9gAsWM0tSzN9it3VIOW0QbHTQorpxvnELEF/
 mmii7dEoKkyMBGHVOUpw4UiR/Pk+ErDKeo522ruIcOz5+mqVO4Bn7ePR+skIU/3HhClos+M
 it754+NfnOGy85tdch0gE8GOOVz8qfaL6MYCgwFdHImqJnIuYqnYo6S2cA8zHmbXyVSvoOn
 wHbL4LrBGoy28lMnPRHhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RSoBIzXkDTA=:zc7D2h7Tm/cknKf7oeU7Xp
 /f8iYKeG/vEP+ey4Uph5WgETbGqtvDt0Rg7VCwxLuSvK90scst+dSwxfkMnVKmE4IXKIC4GWm
 GegFhx3nx4sQet1GPT0a7oLahbkBudK+rRqI9TseQcJAm5SlCbbukZL4s3GlDu3sjhezoAxzI
 xhhW02P3rcCcZzka+Zc68zY7GOIBNs07rRrfial/e/Jr8q5kRKfl1hIgeab130HdgqcSIMDIP
 HQBAQbC+QA5lgEQFHyLYPvCpao9A3te6BpFsrmDAKj0rHXFv5QD4jJXHISUmMITvmBtSFDlmA
 f/MrUqziJ1NJUxfdknobTRAN7HbF0FHhRQ23ZTfGdtY87th/GCijBuCxeEXPm0ykaYKaMkxPu
 2orqGtIUj85GN/4PFXtyCJOwqjMk2z/ISIok4/pbyOk5sccirM1+LXVbyzgb7izl5tND1hNRj
 yiPage9lbuFjzZerlOA1p06AxPZ2WphcbOa9X5XB4eLTN70s5VSpgQ2sNjbP7OP4XYP9tWxE/
 cpQ9Ai1O/9vX/cEPM8qJBH9u8Dk5niYJlTAZS9yIHhZhcREqaTf3Kl9eHWFpy5Zqcc4UQapOA
 Y71fhwByEQOP1EQNAe8Xqs9pnfVXZZ5pl8uys1Mp8eA9V2hzeA68vGOcG6ZHcUZnod8cd7kon
 2/R7lHwVTBAK3qayYK+eM9P/Negw3QNb2/eqd+Rsty8OwO7o/AQ9LInpO6+UdOctUJP0Q1Pq8
 t2aOTxmoUugdXnDc9hVWo9xMkovqOTT8egFwGTK8CgdiMid591Fm3TujnHQHRn45RKyikS75z
 VivrGHNjhGTP/0DUny+fK6qD2z+ioreEdK68nfEkGRF7f7bKAi56OrhELhq10Zmklmv5/eXX4
 9KuFzj6MduGVJ/8w8blsLGxX1XQ3HNbvp20flHhxmL/ulO8gxPvJu3To/M50EPAb2OnrYoAep
 1biMIdfvV7qvp0muOPCpNcoQDRd32d6tdKNuGVf31UZj9ZHM/zkwzDeaEhakg82o8/79oIUNK
 Ta8MS2ZZAOHrNhpDkKUbzxMHbsmHFyEThYqiS3jl4wUlVx6dEnJlaRJ6RhKtK8qMoh2RMcJcS
 x9zEfdBUYIolb7d8YNzW2+Njj1GuuuXvy8Ys29zWyfAe7AOjLMcItqs4ssAgcqEhGTwMRfrAJ
 JnNb2ApaCg7mT+hO+4VrazEDDBYN/nawJZU4OXaXvsK8QBzcKt0tDu9M0AAYHa0ZtVQsSz6Xs
 NjV9zbOBdUtmVkQqsdThYkH4qF4QqHIrbrxHs++w1auH6DA0iDB6rGduxwAE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,


On Tue, 22 Oct 2019, Alexandr Miloslavskiy via GitGitGadget wrote:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> This also fixes t5516 on Windows VS build.

Maybe this could do with an example? I could imagine that we might want
to use the log of
https://dev.azure.com/git/git/_build/results?buildId=3D1264&view=3Dms.vss-=
test-web.build-test-results-tab&runId=3D1016906&resultId=3D101011&paneView=
=3Dattachments:

=2D- snip --
[...]
++ eval '
	want_trace && set -x

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir" &&
	! git env--helper --type=3Dbool --default=3D0 --exit-code GIT_TEST_GETTEX=
T_POISON

)'
+++ want_trace
+++ test t =3D t
+++ test '' =3D t
+++ test t =3D t
+++ set -x
+++ mkdir -p '/d/a/1/s/t/trash directory.t5516-fetch-push/prereq-test-dir'
+++ cd '/d/a/1/s/t/trash directory.t5516-fetch-push/prereq-test-dir'
+++ git env--helper --type=3Dbool --default=3D0 --exit-code GIT_TEST_GETTE=
XT_POISON
prerequisite C_LOCALE_OUTPUT ok
error: 'grep remote error:.*not our ref.*64ea4c133d59fa98e86a771eda009872d=
6ab2886$ err' didn't find a match in:
fatal: git upload-pack: not our ref 64ea4c133d59fa98e86afatal: 771eda00987=
2d6abremote error: upload-pack2: not our re886
f 64ea4c133d59fa98e86a771eda009872d6ab2886
error: last command exited with $?=3D1
=2D- snap --

It is quite obvious that this `fatal:` line is garbled ;-)

> For detailed explanation please refer to code comments in this commit.
>
> There was a lot of back-and-forth already in vreportf():
> d048a96e (2007-11-09) - 'char msg[256]' is introduced to avoid interleav=
ing
> 389d1767 (2009-03-25) - Buffer size increased to 1024 to avoid truncatio=
n
> 625a860c (2009-11-22) - Buffer size increased to 4096 to avoid truncatio=
n
> f4c3edc0 (2015-08-11) - Buffer removed to avoid truncation
> b5a9e435 (2017-01-11) - Reverts f4c3edc0 to be able to replace control
>                         chars before sending to stderr
>
> This fix attempts to solve all issues:
> 1) avoid multiple fprintf() interleaving
> 2) avoid truncation
> 3) avoid char interleaving in fprintf() on some platforms
> 4) avoid buffer block interleaving when output is large
> 5) avoid out-of-order messages
> 6) replace control characters in output
>
> Other commits worthy of notice:
> 9ac13ec9 (2006-10-11) - Another attempt to solve interleaving.
>                         This is seemingly related to d048a96e.
> 137a0d0e (2007-11-19) - Addresses out-of-order for display()
> 34df8aba (2009-03-10) - Switches xwrite() to fprintf() in recv_sideband(=
)
>                         to support UTF-8 emulation
> eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emulati=
on,
>                         so it's safe to use xwrite() again
> 5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again

So far, it makes a lot of sense, and is well-researched. Thank you for
being very diligent.

>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>  usage.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 148 insertions(+), 6 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index 2fdb20086b..ccdd91a7b9 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -6,17 +6,159 @@
>  #include "git-compat-util.h"
>  #include "cache.h"
>
> +static void replace_control_chars(char* str, size_t size, char replacem=
ent)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < size; i++) {
> +    		if (iscntrl(str[i]) && str[i] !=3D '\t' && str[i] !=3D '\n')
> +			str[i] =3D replacement;
> +	}
> +}

So this is just factored out from `vreportf()`, right?

> +
> +/*
> + * Atomically report (prefix + vsnprintf(err, params) + '\n') to stderr=
.
> + * Always returns desired buffer size.
> + * Doesn't write to stderr if content didn't fit.
> + *
> + * This function composes everything into a single buffer before
> + * sending to stderr. This is to defeat various non-atomic issues:
> + * 1) If stderr is fully buffered:
> + *    the ordering of stdout and stderr messages could be wrong,
> + *    because stderr output waits for the buffer to become full.
> + * 2) If stderr has any type of buffering:
> + *    buffer has fixed size, which could lead to interleaved buffer
> + *    blocks when two threads/processes write at the same time.
> + * 3) If stderr is not buffered:
> + *    There are two problems, one with atomic fprintf() and another
> + *    for non-atomic fprintf(), and both occur depending on platform
> + *    (see details below). If atomic, this function still writes 3
> + *    parts, which could get interleaved with multiple threads. If
> + *    not atomic, then fprintf() will basically write char-by-char,
> + *    which leads to unreadable char-interleaved writes if two
> + *    processes write to stderr at the same time (threads are OK
> + *    because fprintf() usually locks file in current process). This
> + *    for example happens in t5516 where 'git-upload-pack' detects
> + *    an error, reports it to parent 'git fetch' and both die() at the
> + *    same time.
> + *
> + *    Behaviors, at the moment of writing:
> + *    a) libc - fprintf()-interleaved
> + *       fprintf() enables temporary stream buffering.
> + *       See: buffered_vfprintf()
> + *    b) VC++ - char-interleaved
> + *       fprintf() enables temporary stream buffering, but only if
> + *       stream was not set to no buffering. This has no effect,
> + *       because stderr is not buffered by default, and git takes
> + *       an extra step to ensure that in swap_osfhnd().
> + *       See: _iob[_IOB_ENTRIES],
> + *            __acrt_stdio_temporary_buffering_guard,
> + *            has_any_buffer()
> + *    c) MinGW - char-interleaved (console), full buffering (file)
> + *       fprintf() obeys stderr buffering. But it uses old MSVCRT.DLL,
> + *       which eventually calls _flsbuf(), which enables buffering unle=
ss
> + *       isatty(stderr) or buffering is disabled. Buffering is not disa=
bled
> + *       by default for stderr. Therefore, buffering is enabled for
> + *       file-redirected stderr.
> + *       See: __mingw_vfprintf(),
> + *            __pformat_wcputs(),
> + *            _fputc_nolock(),
> + *            _flsbuf(),
> + *            _iob[_IOB_ENTRIES]
> + * 4) If stderr is line buffered: MinGW/VC++ will enable full
> + *    buffering instead. See MSDN setvbuf().
> + */
> +static size_t vreportf_buf(char *buf, size_t buf_size, const char *pref=
ix, const char *err, va_list params)
> +{
> +	int printf_ret =3D 0;
> +	size_t prefix_size =3D 0;
> +	size_t total_size =3D 0;
> +
> +	/*
> +	 * NOTE: Can't use strbuf functions here, because it can be called whe=
n
> +	 * malloc() is no longer possible, and strbuf will recurse die().
> +	 */
> +
> +	/* Prefix */
> +	prefix_size =3D strlen(prefix);
> +	if (total_size + prefix_size <=3D buf_size)
> +		memcpy(buf + total_size, prefix, prefix_size);
> +
> +	total_size +=3D prefix_size;
> +
> +	/* Formatted message */
> +	if (total_size <=3D buf_size)
> +		printf_ret =3D vsnprintf(buf + total_size, buf_size - total_size, err=
, params);
> +	else
> +		printf_ret =3D vsnprintf(NULL, 0, err, params);
> +
> +	if (printf_ret < 0)
> +		BUG("your vsnprintf is broken (returned %d)", printf_ret);
> +
> +	/*
> +	 * vsnprintf() returns _desired_ size (without terminating null).
> +	 * If vsnprintf() was truncated that will be seen when appending '\n'.
> +	 */
> +	total_size +=3D printf_ret;
> +
> +	/* Trailing \n */
> +	if (total_size + 1 <=3D buf_size)
> +		buf[total_size] =3D '\n';
> +
> +	total_size +=3D 1;
> +
> +	/* Send the buffer, if content fits */
> +	if (total_size <=3D buf_size) {
> +	    replace_control_chars(buf, total_size, '?');
> +	    fwrite(buf, total_size, 1, stderr);
> +	}
> +
> +	return total_size;
> +}
> +
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
> +	size_t res =3D 0;
> +	char *buf =3D NULL;
> +	size_t buf_size =3D 0;
> +
> +	/*
> +	 * NOTE: This can be called from failed xmalloc(). Any malloc() can
> +	 * fail now. Let's try to report with a fixed size stack based buffer.
> +	 * Also, most messages should fit, and this path is faster.
> +	 */
>  	char msg[4096];
> -	char *p;
> +	res =3D vreportf_buf(msg, sizeof(msg), prefix, err, params);
> +	if (res <=3D sizeof(msg)) {
> +		/* Success */
> +		return;
> +	}
>
> -	vsnprintf(msg, sizeof(msg), err, params);
> -	for (p =3D msg; *p; p++) {
> -		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
> -			*p =3D '?';
> +	/*
> +	 * Try to allocate a suitable sized malloc(), if possible.
> +	 * NOTE: Do not use xmalloc(), because on failure it will call
> +	 * die() or warning() and lead to recursion.
> +	 */
> +	buf_size =3D res;
> +	buf =3D malloc(buf_size);

Why not `alloca()`?

And to take a step back, I think that previous rounds of patches trying
to essentially address the same problem made the case that it is okay to
cut off insanely-long messages, so I am not sure we would want to open
that can of worms again...

> +	if (buf) {
> +		res =3D vreportf_buf(buf, buf_size, prefix, err, params);
> +		FREE_AND_NULL(buf);
> +
> +		if (res <=3D buf_size) {
> +			/* Success */
> +			return;
> +		}
>  	}
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +
> +	/*
> +	 * When everything fails, report in parts.
> +	 * This can have all problems prevented by vreportf_buf().
> +	 */
> +	fprintf(stderr, "vreportf: not enough memory (tried to allocate %lu by=
tes)\n", (unsigned long)buf_size);
> +	fputs(prefix, stderr);
> +	vfprintf(stderr, err, params);
> +	fputc('\n', stderr);

Quite honestly, I would love to avoid that amount of complexity,
certainly in a part of the code that we would like to have rock solid
because it is usually exercised when things go very, very wrong and we
need to provide the user who is bitten by it enough information to take
to the Git contributors to figure out the root cause(s).

So let's take another step back and look at the original `vreportf()`:

	void vreportf(const char *prefix, const char *err, va_list params)
	{
		char msg[4096];
		char *p;

		vsnprintf(msg, sizeof(msg), err, params);
		for (p =3D msg; *p; p++) {
			if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
				*p =3D '?';
		}
		fprintf(stderr, "%s%s\n", prefix, msg);
	}

Is the problem that causes those failures with VS the fact that
`fprintf(stderr, ...)` might be interleaved with the output of another
process that _also_ wants to write to `stderr`? I assume that this _is_
the problem.

Further, I guess that the problem is compounded by the fact that we
usually run the tests in a Git Bash on Windows, i.e. in a MinTTY that
emulates a console (there _is_ work under way to support the newly
introduces ptys, but that work is far from done), so the standard error
file handle might behave in unexpected ways in that scenario.

But I do wonder whether replacing that `fprintf()` by a `write()` would
work better. After all, we could write the `prefix` into the `msg`
already:

		size_t off =3D strlcpy(msg, prefix, sizeof(msg));
		int ret =3D vsnprintf(msg + off, sizeof(msg) - off, err, params);
		[...]
		if (ret > 0)
			write(2, msg, off + ret);

Would that also work around the problem?

Ciao,
Dscho

>  }
>
>  static NORETURN void usage_builtin(const char *err, va_list params)
> --
> gitgitgadget
>
