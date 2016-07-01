Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053B720FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 10:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbcGAKRB (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 06:17:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:62791 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932144AbcGAKQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 06:16:44 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LeBPM-1bgEAu0MQO-00psTH; Fri, 01 Jul 2016 12:16:32
 +0200
Date:	Fri, 1 Jul 2016 12:16:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 4/9] merge_recursive: abort properly upon errors
In-Reply-To: <xmqqvb0r3gi4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011215010.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <81a74b02ac714a4fa3734dfb774cff6dea3a3471.1467199553.git.johannes.schindelin@gmx.de> <xmqqvb0r3gi4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+cVcyg34otLbXbMlDR2clEVzW+YXT3MkTuk1j60qasBmYZPJStG
 VH4wkgkf4x9S8iTuTivV7nNSYc8PYHwcUQoJjATfUxUgZT6Dn+Tncg+vrpm2BpwcYpI4BO7
 Vgxou1xghEY4SGjFR7HnyjagnR355wch4N6QrLhUEOV9o4b0LGdZvsuRDPWwwQSaET/3VgS
 Mk7zOH7Z/C6ZHKpvLCcgw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pC246rCgaQM=:XJ2vx2gs7fjV9zlWZC5Hmj
 db1fgnkj6Ua/CPbvAC1UINk9AvcLvFoyF+1bRtPwxU6IWVfGiuJQC/JCd3fFY98pR5XaAnc2U
 Jgfip9T5V+wAUrFATe3i8cW1/w1SIYjiK4ffxRSDbI2eVzCD55Ey9gF5gRUEz+hCHJneelByb
 Jd1XB0AtqP7obhvNbp10wv5VE/5lnpQeBQMF9EKXOpCRfEEolsujIecgMwryKVg6yFcRQMGhJ
 60gpi8PcgyL9/AMyAqtSkO+0BAaWi6oywh/HbL21feRG/Ht/sLUTSq7cwkQOjk8CDYLX38mr3
 V5YkEQBE1cxTPvzY01ONDe1wA5Q/5cFNhEA3iIPxIcJYeG02lTK1z+VFYUomSxxUp6P31X+DR
 2PE4F6cd/Sg1M8zvR2o8uuOJbH1aL/Z2+KuT9guZlWKBd+iPkZPoVI/AufTxPF4grAVOUOXt5
 c4yur7Ex++V/TyFVU3VuX7wEtBdGgQqquCynkLAzU74ph9YpWS2oBRIx0uphItR04N1pcflSw
 +ptznIi/YDKtVcgAHNn8XCBWKmbbq0jTbnmomFLmFvKJoDZRni/JJ1kZPCRFAB+IpA0Cuj0PO
 tTFk+rDFPImd/t2inhtVTnT43O1lg4+j/eyen3ZlpYCdPKDHyXsshUokHvJTXnhxZFXMj33Sw
 BLgeY6bCkCA2mQXFwLWkXXIU+DNVPgVLBRkWwZPSilwDewEvMneFj7SSng16Od+Fr6KxwZTbS
 HVJrVp4WIfLT78aqTHlM+3e5Qgoq4cirMbdBC6af38cW2jzUrYIbF0j2DXJ4Zul1x5U3CAopT
 sbykPR8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > There are a couple of places where return values indicating errors
> > are ignored. Let's teach them manners.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  merge-recursive.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index bcb53f0..c4ece96 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1944,8 +1944,9 @@ int merge_recursive(struct merge_options *o,
> >  		saved_b2 = o->branch2;
> >  		o->branch1 = "Temporary merge branch 1";
> >  		o->branch2 = "Temporary merge branch 2";
> > -		merge_recursive(o, merged_common_ancestors, iter->item,
> > -				NULL, &merged_common_ancestors);
> > +		if (merge_recursive(o, merged_common_ancestors, iter->item,
> > +				NULL, &merged_common_ancestors) < 0)
> > +			return -1;
> >  		o->branch1 = saved_b1;
> >  		o->branch2 = saved_b2;
> >  		o->call_depth--;
> 
> OK, this early return (and others in this patch) are only for
> negative (i.e. error) cases, and "attempted a merge, resulted in
> conflicts" cases are handled as before.
> 
> Which is good.
> 
> I wonder if o->branch[12] need to be restored, though.  The only
> sensible thing the caller can do is to punt, but would it expect to
> be able to do some error reporting based on these fields, e.g.
> printf("merge of %s and %s failed", o->branch1, o->branch2) or
> something?  In addition to that kind of "state restoration", we may
> need to watch out for resource leaks, but I think there is none at
> least these three early returns.

I do not think that the caller can do anything sensible with *o after we
return an error: it means that we failed *somewhere* in that operation,
but does not say exactly where.

Ciao,
Dscho
