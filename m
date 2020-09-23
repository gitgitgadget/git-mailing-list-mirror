Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C74C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620FA20BED
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 19:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZNhh75yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIWTQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 15:16:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:41521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWTQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 15:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600888583;
        bh=NcpZ5MejHYynVJRw9IvO9gIoKh7EkvIIqMJVuRfRygc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZNhh75yLJE7RIQpAzcWicKYYbqLNHQCGDs7gZBvad6ecwtRUvtowxXpVh1YVmft8k
         WFpBIhb5WItIwZZIG8OXMcePVGBtFTidPsq3UOUIk3ahH1Iiw3gOVkOwzfzqS74O1O
         faUiPoaNNy4qeTUWAWW37uCSi3+yTJhRxGaB42Ak=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1kH37x3Yut-00FDso; Wed, 23
 Sep 2020 21:16:22 +0200
Date:   Wed, 23 Sep 2020 21:16:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
In-Reply-To: <xmqq363fm02a.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet>
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-2-tguyot@gmail.com> <20200918172747.GD183026@coredump.intra.peff.net> <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com> <xmqq363fm02a.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QFi54gUsGxHPt23F/fLPYfUSF8etss0hGZgmm0a3T4WANComRfp
 4L9DRuYfoA9xvE61ncCYnFFG3CzLYrGNS3hw8DSJJFcSN3dDk06aB8C9w1/Eq6cGTYqROp8
 SBwUvpgiD6/IlMYymzdI8qPle60dF0m+lGicNSiQFUFR8XbcFYI6pYw4Oiwx0vdMSOdqLqV
 /DAjowj93QiORVXMI1dMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d3TlS759FgU=:NWfJegXMyyd2+XEGydelPK
 4AwyxsDM0ymOWj7gxabMn3slqagYYgc6Y1LWjn12IiR7EVrvPO1wi4gfwpoZCQnRwiSe/9wN6
 +oWHqUpywa4cViyHyogp3koFanE7XjZ0qFoNc9qmp8wOD7T+J9HZ0exCWZ3TzdrdUMNico+JK
 WjyGHrl/yCg8VYrEo1rpFLgT0WBmdAGxSBuTAwuRCo7MLS92P8EyO0uJFW2fcEupssNggL4gX
 K6/eLs2GwOHOR0viZQAdMW3zdAzgkgKfJ7WmI9S2hO+mcGmLe0JoZfqrNxhAjz7WjfYvwh8XC
 rqyoy+9F+NKimNmyDZbSXneBhAZP93jHex0QLSnSO5QBSkPAbzxh9+IRI+rYM6e/EDKi0xvb2
 V/JPOvAwGEH8MD24VFYAF9vfqAr8HzsxT0l2IjikrI/EGS7c7cX2zxAk5RSDrU0vhEBr3ffTK
 ErJ7dWKek09RhI0YTzdWGC50ESY77dj0FwDTZFs2A54z/3/DXAp8xXj6g3kh7+Z8IUPsr5riI
 ErTC6HYBDI/s2L6rDLcjr7CB8a698MERfrs5WaZYeUHx0oRRkoZLWJq3RLgavu9rYhxze3O0I
 HPYljQuH6bnAn9BmuolCFNN4HuFBk1Gw62zCUVmHcQq6Wi4tgHd5B8IUVEXDGNG9FN+9kSYJD
 FNpouhTj4SKhtn3jBr6Rc+XYGM+7PoD/799bGvPxxx6RvP0IqdlDFqPnhzNTQumByHKZv0j79
 knl3mMAySNpuJWqlAh8nnSyIhR/odMoTpLBY32ru0ixrByomjWN7ziCERJ/e5D1d4Ky+9R/VB
 pHnuFI2RJwAezkO3oV6hlOD1w2JPyQgXdtGn8gxGLSriMEKOlo3TzgVwDm/0QC3KqPZS3KSaA
 By/StnvgGh8wJN/Xb47kA2der9nGykmFEvsXCFy+L8LZsifIe0Qj/146luxFPA+QnwAT4ykwq
 yDRebEJSaHJGVmovOK0avaiy06w7MEfJBJGNLin7ZsJy+VXpJXR+HuQlnfd3gC4MAR/Q0TW3z
 zLaueIkRFMVAqTsOWnA1X268kCJgLl4hWrjiG78fvHctL5CsJ0Tcnc4B1wdE4zzglVehnIJA/
 XRafk9hpCrtxaFfNa5YwH5k8zCV13M/0zhSsOkp/40z+dsHvnXzwGleu99VnAZtBDzq3++6tM
 WnTBC2VEBikMOneqKwuKh5WTPZnsEoyBdNWer3AF2/ixB2KmCmtDixLgR8yhGRkU9qJZTXeFg
 ANWZ8kHzllJuyuZc1hubKMkMoRZgz3EzJefunwA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 18 Sep 2020, Junio C Hamano wrote:

> Thomas Guyot-Sionnest <tguyot@gmail.com> writes:
>
> >> > -     same_contents =3D oideq(&one->oid, &two->oid);
> >> > +     if (one->is_stdin && two->is_stdin)
> >> > +             same_contents =3D !strcmp(one->data, two->data);
> >> > +     else
> >> > +             same_contents =3D oideq(&one->oid, &two->oid);
> >>
> >> ...should this actually be checking the oid_valid flag in each filesp=
ec?
> >> That would presumably cover the is_stdin case, too. I also wonder
> >> whether range-diff ought to be using that flag instead of is_stdin.
> >
> > I considered that, but IIRC when run under a debugger oid_valid was
> > set to 0 - it seemed to be used for something different that i'm not
> > familiar with, maybe it's an indication the object is in git datastore
> > (whereas with --no-index outside files will only be hashed for
> > comparison).
>
> If it says !oid_valid, I think you are getting what you do want.

I suspect the same.

> The contents from the outside world, be it what was read from the
> standard input or a pipe, a regular file that is not up-to-date with
> the index, may not have a usable oid computed for it, and oid_valid
> being false signals you that you need byte-for-byte comparison.  As
> suggested by Peff in another message, you can take that signal and
> compare the size and then the contents with memcmp() to see if they
> are the same.

To complete the information: `struct diff_filespec`'s first attribute is
`oid`, the object ID of the data. If it is left uninitialized (as is the
case in `range-diff`'s case), `oid_valid` has to be 0 to prevent it from
being used.

I believe that that is exactly the reason why we want this:

-	same_contents =3D oideq(&one->oid, &two->oid);
+	same_contents =3D one->oid_valid && two->oid_valid ?
		oideq(&one->oid, &two->oid) : !strcmp(one->data, two->data);

Ciao,
Dscho
