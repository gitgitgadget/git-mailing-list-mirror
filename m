Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494EF20989
	for <e@80x24.org>; Thu, 13 Oct 2016 15:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755083AbcJMPlM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 11:41:12 -0400
Received: from ikke.info ([178.21.113.177]:45198 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756127AbcJMPlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 11:41:06 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id D09854401D4; Thu, 13 Oct 2016 17:33:17 +0200 (CEST)
Date:   Thu, 13 Oct 2016 17:33:17 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
Message-ID: <20161013153317.GA1698@ikke.info>
References: <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <vpqfuo3l4fl.fsf@anie.imag.fr>
 <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
 <vpq4m4iamfs.fsf@anie.imag.fr>
 <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
 <vpq60oy589b.fsf@anie.imag.fr>
 <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
 <vpq8tttr2ps.fsf@anie.imag.fr>
 <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
 <20161012231321.ar2csdmvhdya2q7r@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161012231321.ar2csdmvhdya2q7r@sigill.intra.peff.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 07:13:22PM -0400, Jeff King wrote:
> On Wed, Oct 12, 2016 at 01:53:52PM -0700, Junio C Hamano wrote:
> 
> > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> > 
> > >>> If it's not in the body of the message, then where is it?
> > >>
> > >> This point is clarified in the thread
> > >> http://marc.info/?l=linux-wireless&m=147625930203434&w=2, which is
> > >> with my upstream maintainer.
> > >
> > > Which explicitly states that the syntax is not [$number], but # $number,
> > > right?
> > 
> > But I do not think that works, either.  Let's step back.
> > 
> > People write things like these
> > 
> >     Cc: Stable <stable@vger.kernel.org> # 4.8
> >     Cc: Stable <stable@vger.kernel.org> [4.8+]
> > 
> > in the trailer part in the body of the message.  Are these lines
> > meant to be usable if they appear as Cc: headers of an outgoing
> > piece of e-mail as-is?
> 
> I think the answer is pretty clearly no. It's just that historically we
> have auto-munged it into something useful. I think the viable options
> are basically:
> 
>   1. Tell people not to do that, and to do something RFC compliant like
>      "Stable [4.8+]" <stable@vger.kernel.org>. This is a little funny
>      for git because we otherwise do not require things like
>      rfc-compliant quoting for our name/email pairs. But it Just Works
>      without anybody having to write extra code, or worry about corner
>      cases in parsing.
> 
>   2. Drop everything after the trailing ">". This gives a valid rfc2822
>      cc, and people can pick the "# 4.8" from the cc line in the body.

Comments, surrounded by parenthesis are allowed after the ">" according
to the RFC, just plain dropping everything comming after that would
break that support.


