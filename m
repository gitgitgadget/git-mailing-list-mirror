Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1722018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbcF1QWG (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:22:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:51214 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbcF1QWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:22:05 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGSDw-1b4iMM0yPo-00DK9S; Tue, 28 Jun 2016 18:21:46
 +0200
Date:	Tue, 28 Jun 2016 18:21:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
In-Reply-To: <xmqqr3bh9wjh.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606281820060.12947@virtualbox>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160614210038.31465-1-lfleischer@lfos.de> <20160624153121.GA2494@sigill.intra.peff.net> <alpine.DEB.2.20.1606241942220.12947@virtualbox> <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com> <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de> <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com> <20160627161616.GA4430@sigill.intra.peff.net>
 <alpine.DEB.2.20.1606281203000.12947@virtualbox> <alpine.DEB.2.20.1606281204330.12947@virtualbox> <xmqqr3bh9wjh.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fHwXufl6NESmpKM0tqxaeCsj+KTLp+Sx8ddVUGdGHTBnhDs+Fmf
 ZhU+k4dnEnVX4tMkvZwUNpC939/RZDC85TFjAjTmPLbCkNDifP3FSNnZEUgXmX5WPHrLOqc
 X1nZZ7hU29/eEu2SqXRrhDvBBlDiveGnVHPwlIDbMJSJLpIgePqF9cOuTBuCfi/zGXFvi6m
 F4i5LotB9V6xwoibig2Jw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qv3r3eyZWdo=:hSDKLH7baMXT7SlBICtzef
 1Ups/y84ttog+t7nXG3r/CTXblZPO6CYO9mqJKWJuvrojQdomLlzeZF9jCj0YSc21LDQCc0iW
 sU0igpzAB7G3Xvcgyn9+Zj7zGZTaTBKNwou7DW4dJGjJ7ZUymtZ8Ntr2cN86emhIZvdJYwzqX
 L/HFbDAAgwZCNSVAjADPBzcLfIQ5vU0l2Li8dxI0WyiAKVrJF9f/a1++y5fQp23sl6jGA7QkY
 w39G15WQrMv7FdPS8AjG+BSDWtIFblNhC9fbRNplcCWT++3JzOw//CcETqVtAsbSgN7f1ABPl
 kZyTxDG7rFTMga6Mz9BKWKw8GRJ+UW/uRsyxvbnUH+Bs86wdU69xtNeFfu4C2WQ6EVkCR4uYO
 c8+4GmtSMMb4CWjvapCIBrmxPgKwnE9mp/nh6cUAXmQq0f+NXk77ZmeQzf0lZgx26werQwm5o
 bno8gbRyFLwnSrbmzZphWxwxGoBS+yBixGKc3MU5uEJvv3plOJ5qG+oT8i7AcmIruAXfqC9VL
 WZLJ+IWvUGCTOrsiVwDTbqEM1rCKPlFMlJu7Gk42jrTFnmqq4fEsRcliRBPu4sI9Hq84Fv3im
 2h0WNK6cME0e7aYAfrYVjcF7ci4ImEhJxTvLnpqucCplNuxxhlVjo/HNsJ4Cy/Jv5ygRsqaU5
 O9Y11cL8OlI+ri8Wv4CQ1uuz8BIzbQdt58F7rZ+0sSPKi+CL2w0ON76HCyQIpvp9qQwBout4O
 539SNvRLktY5X2oPLzy5xUrn4EWIww5FrT888tnC8xDu89QcXIhoSr1NFTVhIjHpYzDDzT6ZL
 7X2s/eR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Erm, sorry...
> >
> > On Tue, 28 Jun 2016, Johannes Schindelin wrote:
> >
> >> [...] we actually do not override fprintf() at all anymore [*1*] [...]
> >
> > ... forgot the
> >
> > Footnote *1*: In Git for Windows, we actually *do* override fprintf(),
> > thanks to using gettext, but it is *gettext* that is doing the overriding
> > now, not Git.
> 
> That's nice to know but is not particularly actionable.  

Right. It was only meant as a footnote for interested parties. In Git for
Windows, we do not need to override fprintf() to support color any longer.

> Do you mean
> 
>  - We do color correctly without having to override fprintf() these
>    days, so feel free and safe to use either fwrite() or write()

This one.

>  - Because we do not override fprintf(), we no longer do colors
> 
>  - Or something in between, e.g. "we don't override fprintf()
>    ourselves but gettext does X for us (for unknown value of X), so
>    you will get color as long as you do Y (for unknown value of Y)"?
> 
> In other words, based on this piece of knowledge you shared with us,
> what is your recommendation for Lukas's patch to do?

Sorry for having been so obscure. I tried to clarify something that did
not need clarification (it is of nobody's concern that fprintf() is
overridden by gettext).

The short version is: do not worry about using fwrite().

Ciao,
Dscho
