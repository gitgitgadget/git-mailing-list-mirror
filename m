Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D51E20401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdFUVMJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:12:09 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33739 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFUVMH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:12:07 -0400
Received: by mail-pg0-f52.google.com with SMTP id f127so5389638pgc.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+PIeDayYdJTb5UC/GUj98Tm4ujJ0GEIqdctARjTLy60=;
        b=dp5yg4yF/U7zPL5UTpESQTrfmzNRTrXj2O97HXRtcY2PLL/kVTe61aInWC0Ff3w+7f
         mrrR56wJj8dUHu43WcacpcBP4wFzNOtFzijlXMo5ugcaNuKyzNy8EPSCGWjZPxSAzRD/
         qB7MEeu6eAsmw3Ja+maQ8paJY7eK5RS1hDpwdSpEw5inqoCdM61a9b0xeaB+b94TTpnG
         9y1ZnhxKdn5XgTFZoWF40/MuKmCs7sSjYvMEQuh7BOCmh1vwxWSHgh0WWMqJj5myQHYx
         O1Le6Nl/xwkmE6Vkkh0s9yVn+3vU3/40GE2OPiHWQjbtFLeAC7rMFJSuPKTh1q9gtFLn
         Ummw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+PIeDayYdJTb5UC/GUj98Tm4ujJ0GEIqdctARjTLy60=;
        b=UbnnwH+iqjVrQYWLiSh0iQt5ToF+Ms4POcizcdV7x23mQXgbSNMptHEc0VwwNWVXee
         6hhaCfspYMI3eCke5Qu22R4NI8WANf2a7LbwODqBcE6EzPZx3bpJ0P22MfzA8n4PY/gN
         ZxDuMAVNV9RHlYyIjdboSNhZ+pWULy6LNUvQJQoA3M7LqMWnWf3Hl9aMtXKla0mAc1eJ
         7oWY8aZ31ARNLNWzhAhY/OQZmzn4wdAr1KqnEt8uQnEkXiTo8btrIAGjggzZeRdpUEaS
         Yb9jozsM1zlZx2AN41tRsstRZJoNt0+IYlsR3+Y8UEs8rruoTWkHliq9asU+ICiXqDZm
         fcmQ==
X-Gm-Message-State: AKS2vOwbJpBH5Trv8ZI1NBj0jw84KidbpAPBA3C8oWIg6ZyRL3eoQRgt
        lkbnKHe5IszcHlLbiLhhGQLqYica4vX7
X-Received: by 10.98.49.2 with SMTP id x2mr17893077pfx.48.1498079526607; Wed,
 21 Jun 2017 14:12:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 14:12:06 -0700 (PDT)
In-Reply-To: <20170621204742.15722-1-avarab@gmail.com>
References: <87podz8v6v.fsf@gmail.com> <20170621204742.15722-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 14:12:06 -0700
Message-ID: <CAGZ79kZdksGoUyn2F+YFZKZMj8SPN3k=3EzVD6nTSmWkBq4qDw@mail.gmail.com>
Subject: Re: [PATCH v2] die(): stop hiding errors due to overzealous recursion guard
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 1:47 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change the recursion limit for the default die routine from a *very*
> low 1 to 1024. This ensures that infinite recursions are broken, but
> doesn't lose the meaningful error messages under threaded execution
> where threads concurrently start to die.
>
> The intent of the existing code, as explained in commit
> cd163d4b4e ("usage.c: detect recursion in die routines and bail out
> immediately", 2012-11-14), is to break infinite recursion in cases
> where the die routine itself calls die(), and would thus infinitely
> recurse.
>
> However, doing that very aggressively by immediately printing out
> "recursion detected in die handler" if we've already called die() once
> means that threaded invocations of git can end up only printing out
> the "recursion detected" error, while hiding the meaningful error.
>
> An example of this is running a threaded grep which dies on execution
> against pretty much any repo, git.git will do:
>
>     git grep -P --threads=3D8 '(*LIMIT_MATCH=3D1)-?-?-?---$'
>
> With the current version of git this will print some combination of
> multiple PCRE failures that caused the abort and multiple "recursion
> detected", some invocations will print out multiple "recursion
> detected" errors with no PCRE error at all!
>
> Before this change, running the above grep command 1000 times against
> git.git[1] and taking the top 20 results will on my system yield the
> following distribution of actual errors ("E") and recursion
> errors ("R"):
>
>     322 E R
>     306 E
>     116 E R R
>      65 R R
>      54 R E
>      49 E E
>      44 R
>      15 E R R R
>       9 R R R
>       7 R E R
>       5 R R E
>       3 E R R R R
>       2 E E R
>       1 R R R R
>       1 R R R E
>       1 R E R R
>
> The exact results are obviously random and system-dependent, but this
> shows the race condition in this code. Some small part of the time
> we're about to print out the actual error ("E") but another thread's
> recursion error beats us to it, and sometimes we print out nothing but
> the recursion error.
>
> With this change we get, now with "W" to mean the new warning being
> emitted indicating that we've called die() many times:
>
>     502 E
>     160 E W E
>     120 E E
>      53 E W
>      35 E W E E
>      34 W E E
>      29 W E E E
>      16 E E W
>      16 E E E
>      11 W E E E E
>       7 E E W E
>       4 W E
>       3 W W E E
>       2 E W E E E
>       1 W W E
>       1 W E W E
>       1 E W W E E E
>       1 E W W E E
>       1 E W W E
>       1 E W E E W
>
> Which still sucks a bit, due to a still present race-condition in this
> code we're sometimes going to print out several errors still, or
> several warnings, or two duplicate errors without the warning.
>
> But we will never have a case where we completely hide the actual
> error as we do now.
>
> Now, git-grep could make use of the pluggable error facility added in
> commit c19a490e37 ("usage: allow pluggable die-recursion checks",
> 2013-04-16). There's other threaded code that calls set_die_routine()
> or set_die_is_recursing_routine().
>
> But this is about fixing the general die() behavior with threading
> when we don't have such a custom routine yet. Right now the common
> case is not an infinite recursion in the handler, but us losing error
> messages by default because we're overly paranoid about our recursion
> check.
>
> So let's just set the recursion limit to a number higher than the
> number of threads we're ever likely to spawn. Now we won't lose
> errors, and if we have a recursing die handler we'll still die within
> microseconds.
>
> There are race conditions in this code itself, in particular the
> "dying" variable is not thread mutexed, so we e.g. won't be dying at
> exactly 1024, or for that matter even be able to accurately test
> "dying =3D=3D 2", see the cases where we print out more than one "W"
> above.
>
> But that doesn't really matter, for the recursion guard we just need
> to die "soon", not at exactly 1024 calls, and for printing the correct
> error and only one warning most of the time in the face of threaded
> death this is good enough and a net improvement on the current code.
>
> 1. for i in {1..1000}; do git grep -P --threads=3D8 '(*LIMIT_MATCH=3D1)-?=
-?-?---$' 2>&1|perl -pe 's/^fatal: r.*/R/; s/^fatal: p.*/E/; s/^warning.*/W=
/' | tr '\n' ' '; echo; done | sort | uniq -c | sort -nr | head -n 20
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---

Reviewed-by-and-found-no-nits: Stefan Beller <sbeller@google.com>
;)

>
> This replaces v1 and takes into account the feedback in this thread
> (thanks everyone!).
>
> The commit message is also much improved and includes more rationale
> originally in my reply to Stefan in 87podz8v6v.fsf@gmail.com

Thanks!
Stefan

>
>  usage.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/usage.c b/usage.c
> index 2f87ca69a8..1ea7df9a20 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -44,7 +44,23 @@ static void warn_builtin(const char *warn, va_list par=
ams)
>  static int die_is_recursing_builtin(void)
>  {
>         static int dying;
> -       return dying++;
> +       /*
> +        * Just an arbitrary number X where "a < x < b" where "a" is
> +        * "maximum number of pthreads we'll ever plausibly spawn" and
> +        * "b" is "something less than Inf", since the point is to
> +        * prevent infinite recursion.
> +        */
> +       static const int recursion_limit =3D 1024;
> +
> +       dying++;
> +       if (dying > recursion_limit) {
> +               return 1;
> +       } else if (dying =3D=3D 2) {
> +               warning("die() called many times. Recursion error or racy=
 threaded death!");
> +               return 0;
> +       } else {
> +               return 0;
> +       }
>  }
>
>  /* If we are in a dlopen()ed .so write to a global variable would segfau=
lt
> --
> 2.13.1.611.g7e3b11ae1
>
