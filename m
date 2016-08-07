Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99141FD99
	for <e@80x24.org>; Sun,  7 Aug 2016 22:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbcHGW3F (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 18:29:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59860 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbcHGW3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 18:29:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885451FD99;
	Sun,  7 Aug 2016 22:29:03 +0000 (UTC)
Date:	Sun, 7 Aug 2016 22:29:03 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 4/9] status: collect per-file data for --porcelain=v2
Message-ID: <20160807222903.GA462@starla>
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
 <1470434434-64283-5-git-send-email-git@jeffhostetler.com>
 <xmqqbn16vnlf.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608071026120.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608071026120.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 5 Aug 2016, Junio C Hamano wrote:
> > Jeff Hostetler <git@jeffhostetler.com> writes:
> > >  		}
> > > -		else
> > > +		else {
> > >  			d->index_status = DIFF_STATUS_ADDED;
> > > +			/* Leave {mode,oid}_head zero for adds. */
> > > +			d->mode_index = ce->ce_mode;
> > > +			hashcpy(d->oid_index.hash, ce->sha1);
> > > +		}
> > 
> > Not a big deal (no need to resend for this one alone), but let's
> > make the above properly formatted, i.e.
> > 
> > 		if (ce_stage(ce)) {
> >                 	...
> > 		} else {
> >                 	...
> > 		}                        
> 
> Do I understand correctly that your objections is against having the curly
> brace before the "else" on its own line?
> 
> If so, when did our coding style change? I vividly remember that we
> strongly favored putting the "else" on a new line after a closing brace,
> to make diffs nicer in case the braces were removed or added.

AFAIK, Linux kernel CodingStyle has always been what Junio
suggested (just w/o the trailing spaces :),
and we inherit from that.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/CodingStyle

> BTW your suggestion has 24 extra spaces after the final closing brace ;-)
