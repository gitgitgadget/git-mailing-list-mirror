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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A42A1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 11:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfI3Lin (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 07:38:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:51557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbfI3Lin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 07:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569843518;
        bh=yomPIDkksmu8r1ELJpVqYgnRjfOJAd0qx5llh2RE2Ig=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eh4IPyr4IcyBkDSbAGcZcSXR+74fE322eZi1nDmBFCioNiKM35nFtX+gpiPdC38eT
         NvSnn38gcm/jhM1wnQzZE8w3f2caG8MM8czjuCC8CDIOzfjyx4vKcUmjn6Oug/Zsis
         if+UAQ8FgOVMZfJQtaQQ1yvp0b+emy6kWRYh7fQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1i5rZO0zey-00zne3; Mon, 30
 Sep 2019 13:38:38 +0200
Date:   Mon, 30 Sep 2019 13:38:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] Move git_sort(), a stable sort, into into libgit.a
In-Reply-To: <xmqqftkgk9sj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1909301338040.46@tvgsbejvaqbjf.bet>
References: <pull.352.git.gitgitgadget@gmail.com> <1202809db71a7b0d06efd5e50716861ecff186de.1569400558.git.gitgitgadget@gmail.com> <xmqqftkgk9sj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:18nt5S6FxiCnFxid4/mq98aZv7h2RiV/wBL+h3iQPUVGEufFbuV
 Ooc+1NxipLzkuIvR9uLR4k1N1X507nUD9Ld5R7D0KtiSVR875wwWllPBnM5Tjrb/Hi+vgbj
 6XnmxQ7e7EVefrjdTXpIDCLpSbkQTdjJE47cRfmrRwc/By+auajc2YQ93on+IpKFa5zHg/d
 bdiXV/Zx/3lw/jsKD2Z2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZyWx/qai0cg=:FVfw9OkuN4I6io7I5oc/IC
 siKfzIeKmEoA8fX9M1B3WpkE/0/4QV49huae+kkX3+IuJl6IRPpn5tjGDP0z1Xja7bP87MG6x
 opD8DYvSEyyCOLCwVxTNDQ7gF7WqrQM+Tt9XtkoFiU9ldPTn+eyLNMx/1FC9Gj46Jagz2UhBm
 YcbmpLvs7biep/v7bmOH08oErNPlHK7jYrhp4F3u5D2To750mKibBuhikjxof3dipTJisnK0e
 r1kN6251R+zZVkZ6cz/jueU+x4UhGxaKHE9BLQmkizMwJKAbxDcbg2QT+ajXfuLyv91EGC4um
 SNAE8S1kQOy8nMM15Gu3Gs1M2PE8orvpJUxfOKmIEDGPO+/B2uzRRlS/hhYSYrxb9/SH2b8NI
 0fWG9LdaZ4oOnpuEdViLku9zUY+XGbIhUMNOZxDrQRl3oJkyic7xr4lrRi7junjUy1rTBqDug
 0Dch3X/kW8JAopZb5E0FFQJh14sRC9EwpDXbUj5HZSoJDIw4ZvZC+Q9tPLsoh6bybPu0SGVX7
 63wWgrMwE3PoOB9KPRs6WAvCn6+IIlnKzsNgGQvA/oK5Exn6jmAk4/0vNbg7/sDT54LdLFEYn
 dzo1NbcC+cdBf4B5HBeRZwHrwNs8hwGRAFybuHmCyD54rTwABMtPHb8Y2/uNvzLVcPXUZhwOl
 quWjfrcg29sExPXHsw8pMXkOe/N7mKp6EP2WvYbT93XzBram9UhF/DRvHmFYtuyvAhBYmGK3X
 IKJkFGzSSGe4Hf/ATgvjY7obCsv8GZmTNoHNT+yXkxUGy1XT5u1P8AHsyWNNUnU1uclf42vPW
 j0SYnW2hVWjUU53FjgY1FjYovKI8VtPQQ+E8nQAs5WoDIOIAy0o3jkHu0w650geYqWS971dvM
 5ROZoVCd9oRB3gZnJu2SMo2eF5jvJisu8Jyby2vD28rXHvhk7FqavWRDKdJAgkfeHHH6bmOap
 Jz2Lv9wyjIfY8ZHk1P8uZCitjhGPM4c08uBS3hxhrH/1Xmn4M3sQd1D/TGn0OW5D73maogv8O
 7l+yXebsDzuQ/W3YiRgKvFcHYyFSRk72OKFefrxfDjSlFDkKwmhDs2aYTZRS02ZooFml84ugd
 optkGiXfhPJufO7MwgTRv4MLCxj1TOUKBjXnxEVrXX4GvgLWVFoQVTd8bTqFOzqEdSP/XmIn2
 WHQGRWd/fOQ4fg+8mZH+k+XJmspEiG3X5PIomeW3J12XrSJJ3CguuamCSn3co/DzFyJmFUyZK
 6E86RcEUnobARm0xwVoggVg8/T0CdIUdqVrvhkgS9bHMUpVXgCfmOHMxgt0A=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 28 Sep 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > ---
> >  Makefile                  | 2 +-
> >  compat/mingw.c            | 5 -----
> >  git-compat-util.h         | 4 +++-
> >  compat/qsort.c =3D> qsort.c | 2 +-
> >  4 files changed, 5 insertions(+), 8 deletions(-)
> >  rename compat/qsort.c =3D> qsort.c (97%)
>
> Quite pleasing.
>
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 738f0a826a..77d4ef4d19 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1229,11 +1229,6 @@ static int wenvcmp(const void *a, const void *b=
)
> >  	return _wcsnicmp(p, q, p_len);
> >  }
> >
> > -/* We need a stable sort to convert the environment between UTF-16 <-=
> UTF-8 */
> > -#ifndef INTERNAL_QSORT
> > -#include "qsort.c"
> > -#endif
> > -
>
> Especially these ;-)
>
> > diff --git a/compat/qsort.c b/qsort.c
> > similarity index 97%
> > rename from compat/qsort.c
> > rename to qsort.c
> > index 7d071afb70..08f80eea09 100644
> > --- a/compat/qsort.c
> > +++ b/qsort.c
> > @@ -1,4 +1,4 @@
> > -#include "../git-compat-util.h"
> > +#include "git-compat-util.h"
>
> I however do not think this goes far enough.  With a bit more effort
> would make the intention of the API more obvious.
>
> What we are saying now is that
>
>  (1) some platforms do not even have qsort()
>  (2) some codepaths do care the stability of sorting
>
> the former used to be the reason why we called our implementation
> git_qsort() and aliased qsort() to use git_qsort().
>
> But now (2) is in the picture, we would probably want to make it
> more clear that our own implementation is not about having a sort
> function that behaves like qsort() and We want a lot more out of it
> (namely, stability).  It probably is time to rename git_qsort() to
> git_stable_qsort() or something like that.
>
> Macros QSORT() and QSORT_S() are about having a convenient and less
> error-prone thin wrapper that retains an interface similar to
> qsort(3) and qsort_s(3) that developers are familiar with, so they
> can and should stay the same name, and it is perfectly fine if the
> former called qsort() that in turn calls git_stable_qsort() on some
> platforms.
>
> And that way, if/when the calling site of QSORT() (not the calling
> site of STABLE_QSORT()) needs a more performant but unstable sort
> implementation, we can safely give the most sensible name for it,
> which is git_qsort().
>
> Other than that, the two patches look good to me.  Thanks for
> working on this topic.

Okay, I will make that change.

Ciao,
Dscho
