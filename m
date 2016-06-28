Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E1D1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 10:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbcF1KEg (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 06:04:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:49584 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbcF1KEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 06:04:35 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LZz01-1blyV70awH-00lown; Tue, 28 Jun 2016 12:04:12
 +0200
Date:	Tue, 28 Jun 2016 12:04:11 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
In-Reply-To: <20160627161616.GA4430@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1606281203000.12947@virtualbox>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160614210038.31465-1-lfleischer@lfos.de> <20160624153121.GA2494@sigill.intra.peff.net> <alpine.DEB.2.20.1606241942220.12947@virtualbox> <20160624181414.GA25768@sigill.intra.peff.net>
 <CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com> <146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de> <xmqqr3bibpap.fsf@gitster.mtv.corp.google.com> <20160627161616.GA4430@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:h4gleKqswdT1awM8ZMVAnC71MODCdSFntYMGYzf/K6lFEHfuN04
 tw0XFzSSVeaC27OWMOBvKKfjxWAa2VxcAgtsEZ5JYlhsKFgHEemdMtsJ//mcDUienZZQhXK
 S79Y9ZSHw4PLeWxzmcbVrLlWUvtUpy0KOU3NH8K1+J78XAVZDXtbR6sBxzGYT2FWdq5/gMm
 g6XfnHOI/z30K/cY0q5BA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:75EUFj4DjMc=:f0gRZNlJyqM3/XaM4YAwTF
 9eSZYr3IxnVRpNeaMgJwwsWpEFOXI4d7TDBwlMNfjb/UVNXqoSakFSBLHKQL8qHCjT62F9hj0
 svtd6qvzUD2FLpL7Sh0h/9nVgxf9n/QSesMxhGXTIHf1pN5KHWcv5vwEgFSX91Ieepr4jtn8G
 C3o8jpyhfpmCKkmwQovMgeV+sFXjH6LZymi0m2myywX49+ydEovDfYGw4wAMADz+R56Pjsk8F
 K3PcS4j/Qj0aKXX4vkybp5DfmV8rSyDYHen0M+82yhOPjrfMxF1GZLO2yP/jvAUljgN+Gg2vb
 /6UIlq5etC6YIPIbgTOsS8mWWObGH9WH3+bWaZfYOEbuFUxdq9hcQc1wYw4tqx9unrJdByoSt
 yIn4Fv6Arck3hnQDnUV4DYAJFxbKKCfCPpVrPXGGAq04R5aIw6zrxTWCKGCrhtsOClkPbqhx2
 2Fmdwh3WbKOxuZiz8xE3hA9Z5JgJ8X7nUxNA33j+eThvhi7DwaJy8kFzLJI/3cKRZCjIabCPT
 X6EOCh4laEHCrYwubfrKPAlktBr6YmA7MLC/+LbvIniAVFy+Ot+SLVjbG/IbaMf62fA0th5bc
 bMrmUlRY/88bP7hmknVCewkUBDF+oMb+AeK1o+vVMhric0mNOJx+Hsp+cb3sq4I8ieGVX6QAI
 WixQHIwecWRswzYFoHjaD1ruNk4JyCnqKoE1PrsEpU+FPibpKVh3JbEOVzRSed+16dlJoNC1l
 G4DtAeh71Z0GFbZNiyp/8wKfMr6m02z4bJ8eAnL5B42dKlyY3srfPDIclv4IAlubYd9eU5G+R
 NuiE34B
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Mon, 27 Jun 2016, Jeff King wrote:

> On Mon, Jun 27, 2016 at 08:54:22AM -0700, Junio C Hamano wrote:
> 
> > It's just you used xwrite() there that introduced a different issue.
> > Wouldn't replacing it with fwrite(stderr) without changing anything
> > else solve that?
> 
> I am having trouble actually seeing how the ANSI-emulation code gets
> triggered, but the comment in color.h implies that it is only printf,
> fprintf, and fputs that have the desired effect. So fwrite() may not be
> sufficient, and we may need fprintf("%.*s", len, buf) or something.

I meant to clarify how fprintf() works as oposed to fwrite(), so I had a
look and came up empty-handed. I dug a bit further and it turns out that
we actually do not override fprintf() at all anymore [*1*], so I just sent
out a patch to remove the now-obsolete comment.

Ciao,
Dscho
