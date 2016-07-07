Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286842070C
	for <e@80x24.org>; Thu,  7 Jul 2016 00:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbcGGA4z (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 20:56:55 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:29192 "EHLO
	alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753198AbcGGA4x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 20:56:53 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id KxcYblbtaYOXTKxcZbqddb; Wed, 06 Jul 2016 20:56:52 -0400
X-Authority-Analysis: v=2.1 cv=Gfm35VjL c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=cAmyUtKerLwA:10 a=dg4UtMH5AAAA:8 a=6quJ3IGhPzApsOq1cLIA:9 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 22C6E2DA00F8;
	Wed,  6 Jul 2016 20:56:50 -0400 (EDT)
Date:	Wed, 6 Jul 2016 20:56:50 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqq60sisc8z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1607062055300.1824@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr> <xmqq60st853d.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr> <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr> <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606282047360.24439@knanqh.ubzr> <xmqq8txo54pb.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1607051625581.1824@knanqh.ubzr>
 <xmqq60sisc8z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfMoRgJTf+3n6nJmNjVz/7zRPgjsnRvUV8iuSkOP1+IYAAbf5WBO3Dg8QSySPuR91e6ib5W8GZVPVWS7x7Xn2Apr44KrOk0zlz7+ok62clK2OHGAikrzq
 pD+iDS2AaYon59MZKcgvOdv1XBzEQ6mRLplNoVlTgGyUkioweUQiojHcG2pfcvGSO7swBi11X10hENsECMik16n2EOdYF662SyM=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> Thanks; will apply with a miniscule fix.
> 
> > ----- >8
> > Subject: sideband.c: small optimization of strbuf usage
> >
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ...
> > @@ -97,7 +97,7 @@ int recv_sideband(const char *me, int in_stream, int out)
> >  	}
> >  
> >  	if (outbuf.len) {
> > -		strbuf_addf(&outbuf, "\n");
> > +		strbuf_addch(&outbuf, "\n");
> 
> '\n', or "\n"[0] ;-)

Obviously.


Nicolas
