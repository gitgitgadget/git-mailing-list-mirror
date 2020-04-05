Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB8C2BA19
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 22:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADEC20672
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 22:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jh4tP/HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgDEWMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 18:12:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:38661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDEWMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 18:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586124727;
        bh=ET46i2tYbpHqnMPo3yLSB/aSkXCXT+RxWz5YIYtPI54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jh4tP/HRCXaUufrFOJtF9dFth5McM6raBMzKDZRYh5SRYsNsHo5sA2hwAmrqPOrRt
         l2UqmmC04hpmTbN046wTwcMnMdpY+8s5kfJvhmCHVIbUPEW3xdCOZgyJzokT0XjCv8
         rKqeRWa60xR1ZkKdmNzF8t+hHyMNDanhm8mNtR4s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.211]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mlw3X-1iuiAO0rml-00j3xm; Mon, 06 Apr 2020 00:12:07 +0200
Date:   Mon, 6 Apr 2020 00:12:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: avoid running curl-config unnecessarily
In-Reply-To: <20200404145829.GB679473@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2004060009200.46@tvgsbejvaqbjf.bet>
References: <20200326080540.GA2200522@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet> <20200404145829.GB679473@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ThAfFcqlQ3tv2O32IQ6YGhbqzDrtGga9cvzeo6ESOlD65ZfxDSH
 TTAjlMt3knCD1XEGMKeP5xboTb125PYP1T8oHo2GvQc1IvQnVWuM/gAlDY60S5/MNAPEeWp
 vXykrYCbJ++1sJvqgjFjZvHOxGFMnPqgkTBJAS6nStkllVfFIWdJqPxj8UF9aCcJM4Jb8DI
 T5dxGzGYraVI6IAJBn5OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jpLJMETm1xE=:LiBVS1hBTakQ+JqPIVy3xk
 Gx8JaKP1EtalfIHor/9LPwInmhFI3SJNlmMNNzkdGSTV+3eHBaiV38gkGC+AE1aGjcZvNHIoB
 tTU0PBjbqpE+Vl10cEnluhDwrIQFwZuobIzsQgd3tadMsrpAG9f+kD0PQOI1WYnqVSEvSk34p
 8kZkL7HsPr7dmim4jB7sk0zS+qs4w5iINMZjwro7lufNYuitQFeRmXj9Ndi3HdMizIWrgkKZY
 tRaFWu+jG7SF6G9VqlWFt+3LisDdhAL5Bqjx44sjgBYwE0wgrAHyiU6qiHZy4Baz9SwwBpu1C
 WIJjVRXDARD+oW43Booxg90ZTHtsye7g6NKgz94Fr6GsjKMEBxO+UaG04uQyZrEKwUXLIeOOi
 3nwbhd1eXALbgSTgonaPZyPTTqF/zbRyLxss9KZEYqGTUo1JK2KHjQdDB0ZKZax8AQxf4OdYX
 jMl5XEftiaFkFTLL7VmwYmAAxZk7x73m/C4akjcafvr2Zeat4TBqQa2SkjAZU4klsL3srpJT7
 SdGXPb09peDWrS1G2F5iQqAp6OUtV9lp1K4MCXf5oiOND4VGYbB+rAOCEFgOwYbfYp14Eh1td
 qdyoHIkHxyyoS/+Ug3/Q3o2bk3xgYWlwIN4FEYunD7EFs+PHdOdidYQb1XcrIrab/R8ZaoiIv
 lXDVTYbb81C6foRC2GHaHVgQA2X51x8Ij460rwAh70rUmWGzQ8zxi982rjAZ80gD6yfeBd9Rr
 kxOf1Z2SSsPRR+hMVkZE/uU4MLkxC7L7jS5KxIrwEPTDoR5TfxK9byt/QbApqZCVqYOGLFnJy
 6kqM7FTQRArWSO0RGIdDZiUuIJPs3nQwLefpG8sqbtRW25tzGf+pvEVjOsNGpvtu0kLBMMb2Z
 9Lzm/OHdRKko1F43SSSmjAePuesJMtQF02FQERmbaWmSKEN+8I8+VHgeX0CGrw7ndIhj31pl5
 j7JpMMgZEg0njlw1Ba1E0W8/Cmq8xMfwt9VIs+PcHNBNqrZX5aFOEXFjaHy2AC2J0ziv/Bnk9
 84XtZf05m72k0yXlOargX3cXzOUoT9cXnJHe15x61D38nXxN2obCyCyxRncsJ6ysG4kEV+8zp
 oOaikegCxGRMHeZfLH3zUxwJiiTBgDDr82oQTfSCwHa9TsnYFBQwMVswjSG4Bn84/FliCMSYb
 tnXzgQcEOTzENmMRtIEdOrEzVqoCcX9+PKBi5BmtRE64s+UZ2ZvU8bgaDeYCrApZN6wO6XAzp
 2/QjrHwevaKF6FWPI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 4 Apr 2020, Jeff King wrote:

> On Sat, Apr 04, 2020 at 03:38:00PM +0200, Johannes Schindelin wrote:
>
> > >   [1/2]: Makefile: avoid running curl-config multiple times
> > >   [2/2]: Makefile: use curl-config --cflags
> >
> > I _suspect_ that this is responsible for the build failure
> >
> > 	make: curl-config: Command not found
> >
> > at https://github.com/git/git/runs/556459415#step:4:674
> >
> > Do we need this to fix this?
>
> Hmm, yeah. It's an unfortunate side effect of the ":=3D" assignment to
> stop repeatedly invoking curl-config. Now it's only invoked once, but
> it's _always_ once, even if we're not building anything that needs it.
>
> I wonder if there's a way to expand a Makefile variable lazily, but only
> once...aha, with some help from the Internet, I came up with the patch
> below.

Thanks, that would work.

> > -- snip --
> > diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> > index de41888430a..325b4cc6185 100755
> > --- a/ci/test-documentation.sh
> > +++ b/ci/test-documentation.sh
> > @@ -11,6 +11,7 @@ filter_log () {
> >  	    -e '/^    \* new asciidoc flags$/d' \
> >  	    -e '/stripped namespace before processing/d' \
> >  	    -e '/Attributed.*IDs for element/d' \
> > +	    -e '/curl-config: Command not found/d' \
> >  	    "$1"
> >  }
>
> Yes, this works, but it's rather unfortunate that we're invoking
> curl-config when it's not needed. Perhaps using NO_CURL in the
> documentation job would be better. But if the patch below isn't too
> disgusting, I think I prefer that approach (because it helps _any_
> top-level make invocation that isn't actually building http binaries).

I believe that we do need to avoid `NO_CURL` lest we miss out on
documentation mismatches in the `check-docs` target.

Ciao,
Dscho

> Junio, you may want to hold off on moving jk/build-with-right-curl to
> next until we resolve this one way or the other.
>
> -- >8 --
> Subject: [PATCH] Makefile: avoid running curl-config unnecessarily
>
> Commit 94a88e2524 (Makefile: avoid running curl-config multiple times,
> 2020-03-26) put the call to $(CURL_CONFIG) into a "simple" variable
> which is expanded immediately, rather than expanding it each time it's
> needed. However, that also means that we expand it whenever the Makefile
> is parsed, whether we need it or not.
>
> This is wasteful, but also breaks the ci/test-documentation.sh job, as
> it does not have curl at all and complains about the extra messages to
> stderr. An easy way to see it is just:
>
>   $ make CURL_CONFIG=3Ddoes-not-work check-builtins
>   make: does-not-work: Command not found
>   make: does-not-work: Command not found
>   GIT_VERSION =3D 2.26.0.108.gb3f3f45f29
>   make: does-not-work: Command not found
>   make: does-not-work: Command not found
>   ./check-builtins.sh
>
> We can get the best of both worlds if we're willing to accept a little
> Makefile hackery. Courtesy of the article at:
>
>   http://make.mad-scientist.net/deferred-simple-variable-expansion/
>
> this patch uses a lazily-evaluated recursive variable which replaces its
> contents with an immediately assigned simple one on first use.
>
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is our first use of eval in the Makefile, but that goes back to GNU
> make v3.80, which is from 2002. I think that should be OK.
>
> If this inlining is too gross, we could probably contain it in a
> function where callers would do something like:
>
>   $(eval lazy-shell-var, CURL_LDFLAGS, $(CURL_CONFIG) --libs)
>
> That's better in the sense that there's less gobbledygook at each
> callsite, but worse in that it obscures the fact that it's a variable
> assignment. I'd probably consider going that direction if we started
> growing more use-cases than these two.
>
> We could probably also stuff this into a sh
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5099f6a8f8..97dbdcd201 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1366,12 +1366,12 @@ else
>  	endif
>
>  	ifndef CURL_LDFLAGS
> -		CURL_LDFLAGS :=3D $(shell $(CURL_CONFIG) --libs)
> +		CURL_LDFLAGS =3D $(eval CURL_LDFLAGS :=3D $$(shell $$(CURL_CONFIG) --=
libs))$(CURL_LDFLAGS)
>  	endif
>  	CURL_LIBCURL +=3D $(CURL_LDFLAGS)
>
>  	ifndef CURL_CFLAGS
> -		CURL_CFLAGS :=3D $(shell $(CURL_CONFIG) --cflags)
> +		CURL_CFLAGS =3D $(eval CURL_CFLAGS :=3D $$(shell $$(CURL_CONFIG) --cf=
lags))$(CURL_CFLAGS)
>  	endif
>  	BASIC_CFLAGS +=3D $(CURL_CFLAGS)
>
> --
> 2.26.0.410.gc279fb3cbd
>
>
