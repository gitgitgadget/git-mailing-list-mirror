Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF04BC64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 18:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBZSpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 13:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBZSpc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 13:45:32 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A317140
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 10:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1677437123; i=l.s.r@web.de;
        bh=hzeHIesu1ObRblrjkAumFP/NuHlw6i+XVX7B2WnYfrA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WuO8DanDBnbgsMyJYgduMa6ZgIz2XxSpjJHWcp4cNP5UtCbXmHprNJQQKQsawVNII
         eG81PZqclY16jfn0OqBwuWexwRuSlYCTygtaL7WOxWpVqo+19O/wrpkMhR+8gcdHqr
         sB2t7QMhsk2yz/NM42r8j7nTpUh92dbkxWEnF/il9WjPastQaTuJShYIr6tQaXWtBp
         VnzLN/ezJH3iojTvQupMt8DMXtwzADEowbWX0kw9lS5zHi7VxMyapvVFoXmQOpXeyD
         l9TusZIbznUYhWvDfyHmcHiyC628NjAABO/sNlW4HzOARovu5xRzt45Z2mr0s/nIen
         GvbdYltTs6+JA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvrq-1p5RU91M0I-00QyD3; Sun, 26
 Feb 2023 19:45:23 +0100
Message-ID: <36cd059e-c676-2aa2-68d9-41a7b0db57f0@web.de>
Date:   Sun, 26 Feb 2023 19:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/5] git-compat-util: add isblank() and isgraph()
To:     Masahiro Yamada <masahiroy@kernel.org>, git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20230226115021.1681834-1-masahiroy@kernel.org>
 <20230226115021.1681834-2-masahiroy@kernel.org>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230226115021.1681834-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QcCQxsCKjtVqb+BDxsANn0fYfSgEIKXFBJVgxmVQkzSrS0H2b9E
 /+vRa095YB2d42pRgLHc3yYpAsnHuQGilEGC7e/H3Ha3Jm+tsYcHEmp5RXsvqlTqguKng+V
 P79S5wdGwpqo1GMjK1ww2QTbvw/qMGLRX009VKDnIpM96yTe3oJfAjDp7+AEtb88sLNgfox
 gL2Q4cOdXPclO7bP2C/gg==
UI-OutboundReport: notjunk:1;M01:P0:b4nmvtSnPz4=;WlNWdtGL03lUz92h6UcQOE2+hL1
 8o76YLlpOIIKha+nu2u3hNpyZb4cOcZtCgd7OxjIZEtvMlDOysDCmIy5rHarv6Z7BR5KsmdfW
 fRf1fCgViBO38/hnsaImHNgHdLFv/CnkV5rIT1juB0q0Kdj54N1fbe0Mq2HhFz+ziej8YZPW9
 vXfDYFwt122I8nU8Va1ljii6tQEOLYAPfws53KkW8+SHyQnCmnUMq6RYW9jWaLjFvg71ZnqG9
 FmspRhB/6A4dBL513Y0SPa4WUfxj94WxblprG19979q67h8bDfa8Sqe8I+DcISxzIsq4C5JJn
 HyoxqpJTQfHR5FeIvKzSv1s4cldVLAPCbY4yctEwvLEo533FWCQv0KJIvsH55Kw4sHOv02+NZ
 YsfsMHb3Si4U+jtSB1GYbWLFL2pwrnphtipp3bQw8AQfr3Pg7Mtq4HcjAkegDIXIAfBRhwjZr
 KOoodZyrrVNlVoiJtGnbfuWspzPqGocIFuXh62uAo3HTwM9fIhaRRzG1MdOY2s2AYWvxr+eLB
 a+Lf8piWBBPBtA5obirOyAxAC34jbpvmUmXaLT10E7t5GeyUDXj8ArMPjE+o5ASULZDJglv7J
 x6mnBMjE6tko1UXgafTwz9r6Yl32mEl62cEiDSQk2+MJFmwb8cgNJ1jV94QOhWkNm8Hwcrbx9
 4MxkhScOm6frQy7LU5BLPEX1VnP1cHz/+nEJKactPbUQf1qhy+R5CA38AkzxKeCTT0UL6Z2gK
 RXFoLCeA9J4bmTEzvwzgrqrGnkV4Cq5jUkmSU3kpfyS5JjgRwRH7/xTq0VDgr5QyhwDBfHa3e
 bWU5TOcZpAMr/sm7Q7VvhTsK7E1Pobfyd4lk5ADzv68R5+y5pLl0uV3xStA90oE57i1gdHf9K
 2xmVXuQRl4LVcvxFB7iJyiCyKET/ZcfvOKDDIC9u+1sAkmBgcCZ1D9Is1FAPFejr5P7/9BlsZ
 P41aAsuxNP9gztcjFUipNWnvZMA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.02.23 um 12:50 schrieb Masahiro Yamada:
> git-compat-util.h implements most of is*() macros.
>
> Add isblank() and isgraph(), which are useful to clean up wildmatch.c
> in a consistent way (in this and later commits).
>
> In the previous submission, I just moved isblank() and isgraph() as
> implemented in wildmatch.c. I knew they were not robust against the
> pointer increment like isblank(*s++), but I thought it was the same
> pattern as isprint(), which has the same issue. Unfortunately, it was
> more controversial than I had expected...

Not sure we need that story in the commit message, but it gave me an
idea: To go back to the isprint() version from 1c149ab2dd (ctype:
support iscntrl, ispunct, isxdigit and isprint, 2012-10-15), which
evaluates its argument only once:

#define isprint(x) (sane_istest(x, GIT_ALPHA | GIT_DIGIT | GIT_SPACE | \
		GIT_PUNCT | GIT_REGEX_SPECIAL | GIT_GLOB_SPECIAL | \
		GIT_PATHSPEC_MAGIC))

But then I realized that it wrongly classifies \t, \r and \n as
being printing characters; 567342fc77 (test-ctype: test iscntrl,
ispunct, isxdigit and isprint, 2023-02-13) shows it.  So it's not so
easy, however, ...

> This version implements them as inline functions because we ran out
> all bits in the sane_ctype[] table. This is the same pattern as
> islower() and isupper().

... if you remove GIT_SPACE from the definition above you get a
macro version of isgraph() that uses a single table lookup.

> Once we refactor ctype.c to create more room in sane_ctype[], isblank()
> and isgraph() will be able to use sane_istest(). Probably so will
> islower() and isupper(). The ctype in Linux kernel (lib/ctype.c) has
> the LOWER and UPPER bits separately.

If we're out of bits then isblank() is a good choice to implement
without a table lookup, as this class only contains two characters
and two comparisons should be quite fast.

Stepping back a bit: Is using the unlocalized is* macros in
wildmatch() safe, i.e. do we get the same results as before
regardless of locale?  Junio's remark in
https://lore.kernel.org/git/xmqq3579crsd.fsf@gitster.g/ sounds
convincing to me if we don't care about single-byte code pages
and require plain ASCII or UTF-8.  I think it's a good idea to
address that point in the commit message.

And adding tests to t/helper/test-ctype.c would be nice.

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Use inline functions
>
>  git-compat-util.h | 14 ++++++++++++++
>  wildmatch.c       | 14 ++------------
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4f0028ce60..b29c238f02 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1212,10 +1212,12 @@ extern const unsigned char tolower_trans_tbl[256=
];
>  /* Sane ctype - no locale, and works with signed chars */
>  #undef isascii
>  #undef isspace
> +#undef isblank
>  #undef isdigit
>  #undef isalpha
>  #undef isalnum
>  #undef isprint
> +#undef isgraph
>  #undef islower
>  #undef isupper
>  #undef tolower
> @@ -1236,10 +1238,12 @@ extern const unsigned char sane_ctype[256];
>  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) =
!=3D 0)
>  #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
>  #define isspace(x) sane_istest(x,GIT_SPACE)
> +#define isblank(x) sane_isblank(x)
>  #define isdigit(x) sane_istest(x,GIT_DIGIT)
>  #define isalpha(x) sane_istest(x,GIT_ALPHA)
>  #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
>  #define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)
> +#define isgraph(x) sane_isgraph(x)
>  #define islower(x) sane_iscase(x, 1)
>  #define isupper(x) sane_iscase(x, 0)
>  #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
> @@ -1270,6 +1274,16 @@ static inline int sane_iscase(int x, int is_lower=
)
>  		return (x & 0x20) =3D=3D 0;
>  }
>
> +static inline int sane_isblank(int c)
> +{
> +	return c =3D=3D ' ' || c =3D=3D '\t';
> +}
> +
> +static inline int sane_isgraph(int c)
> +{
> +	return isprint(c) && !isspace(c);
> +}
> +
>  /*
>   * Like skip_prefix, but compare case-insensitively. Note that the comp=
arison
>   * is done via tolower(), so it is strictly ASCII (no multi-byte charac=
ters or
> diff --git a/wildmatch.c b/wildmatch.c
> index 7e5a7ea1ea..85c4c7f8a7 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -28,18 +28,8 @@ typedef unsigned char uchar;
>  # define ISASCII(c) isascii(c)
>  #endif
>
> -#ifdef isblank
> -# define ISBLANK(c) (ISASCII(c) && isblank(c))
> -#else
> -# define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')
> -#endif
> -
> -#ifdef isgraph
> -# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
> -#else
> -# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
> -#endif
> -
> +#define ISBLANK(c) (ISASCII(c) && isblank(c))
> +#define ISGRAPH(c) (ISASCII(c) && isgraph(c))
>  #define ISPRINT(c) (ISASCII(c) && isprint(c))
>  #define ISDIGIT(c) (ISASCII(c) && isdigit(c))
>  #define ISALNUM(c) (ISASCII(c) && isalnum(c))

