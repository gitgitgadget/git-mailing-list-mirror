Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140B3203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960AbcGZM0m (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:26:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:59384 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbcGZM0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:26:41 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LjIBr-1atEvC3eX9-00dUO9; Tue, 26 Jul 2016 14:26:30
 +0200
Date:	Tue, 26 Jul 2016 14:26:19 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 06/16] merge_recursive: abort properly upon errors
In-Reply-To: <xmqq7fc94bf4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607261425300.14111@virtualbox>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de> <26f12ac5a5b8e722d81c782b32585531521c98d4.1469187653.git.johannes.schindelin@gmx.de> <xmqq7fc94bf4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5NIuWQurKkPvz4Ru93mKAKEB1zh1o7slwGJ39KrnjclpyOxo6zg
 NTMk2xvtjISvd2lhOsTTtjZUVZsVS/XD3WV2UFNeQpIsfiRYRRLtFcnQOjeRAos85BC3U69
 DG5mbeHdCQastaaLOJ8EckxN05PrJnpt6aoyjloUdTBw32HSKH66JHbrY+0PygM3K2SkhuQ
 jQIM6bswXuVPeR0d+KmUw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gDQ2AM1cwlE=:kU1XUB0fT9W/038HC8uR3k
 9AmgolAhM1s7pldgUFNtjEFkVNzt7EJrBflAroNIReDAevO6wZcBntIKrltIHwPpP8ApbmpKK
 lFXAaVGSaQ5uW0LSWK6/x342vbA7h37jUNJ24taNiA4j4AcqGbz49uNhk1YwoI7Ur2Crq6JzM
 cSe3jx45u5O4OLDoAAhOKO4ckjpAdEkqswEt7cbF2/aGzdxt+XQUjGkYldI8GWBl8tJp9j3Rz
 lbkYBuSMONppvnqCsobQASX7UUaWKaXVRngsxifQ+nez+0A8Ba3jyyqmVdLqtmKz36EUmfaFB
 IZ3clXSw7HogcTsjWw+NwhizXKPtoR905V0p3O6n3ZBZ/aojzdf7/TucHcltjAdir+iCHPdNL
 aFXiir3aH6c/eXOpKPU3QRg2xH2u9DWI9RxtZ1hSbXpTiOwlMlICL+09lNtRuMA6KEkDFqBGT
 4ZPJVxGCITCocVAt17sXWbc10f6DdFcbMud9FRvpablZji0d3uPg+Ij+yw6mLU+Isk0siGSv7
 BMX7uCqSclax2ytepaDirHgOzoPUh5cSg6fDXxxxUCCkdrIoZ8pkoZRX2u4Kyn4LKCWbf59uX
 r5mWN7zhWorOV0LAWEuYV5l70uGSiObQV4glH88hjzhYrEx/BZ4WgjWX98HRKcZ0TUyskG/k2
 mJOXY/NakD6sOgDa8raWr4lotJc98aJATAIQ5PARd+8Rc823Cx8kYpzndjviqInS7Ee4W8cM7
 XwdZ9sx56eQkt4dWjkt4v/gMOa1mj3owjTCHG7ihi0BUSjwxLcBuX4Uhtfw5btA6jm3TykZZB
 X/sFe/R
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 25 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > There are a couple of places where return values indicating errors
> > are ignored. Let's teach them manners.
> 
> That is because the return value never indicated errors before this
> series, isn't it?  A true error used to be expressed by dying, and
> the return value indicating "cleanliness" of the merge were
> deliberately ignored.
> 
> The world order changed by previous patches in this series and the
> callers need to be updated to take the new kind of return values
> into account.  That is not teaching them manners ;-)

I reworded that commit message.

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  merge-recursive.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index dc3182b..2d4cb80 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1949,8 +1949,9 @@ int merge_recursive(struct merge_options *o,
> >  		saved_b2 = o->branch2;
> >  		o->branch1 = "Temporary merge branch 1";
> >  		o->branch2 = "Temporary merge branch 2";
> > -		merge_recursive(o, merged_common_ancestors, iter->item,
> > -				NULL, &merged_common_ancestors);
> > +		if (merge_recursive(o, merged_common_ancestors, iter->item,
> > +				    NULL, &merged_common_ancestors) < 0)
> > +			return -1;
> >  		o->branch1 = saved_b1;
> >  		o->branch2 = saved_b2;
> >  		o->call_depth--;
> 
> This hunk feels somewhat wrong as-is.
> 
> There is a comment before the pre-context explaining why cleanness
> flag is ignored.  It needs to be updated.  We still do not care
> about cleanliness, i.e. 0=clean, 1=merged with conflict, but we now
> can get negative values so we need to reject and return early if
> this call indicates an error.

I updated that comment. Hopefully now the hunk makes sense ;-)

Ciao,
Dscho
