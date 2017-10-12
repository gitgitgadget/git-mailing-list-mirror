Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4EB020372
	for <e@80x24.org>; Thu, 12 Oct 2017 14:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdJLOWj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 10:22:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:50950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751206AbdJLOWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 10:22:39 -0400
Received: (qmail 17516 invoked by uid 109); 12 Oct 2017 14:22:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 14:22:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15955 invoked by uid 111); 12 Oct 2017 14:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 10:22:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 10:22:37 -0400
Date:   Thu, 12 Oct 2017 10:22:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Improve abbreviation disambiguation
Message-ID: <20171012142236.dw64bovrmdvv5jn7@sigill.intra.peff.net>
References: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
 <20171012120220.226427-1-dstolee@microsoft.com>
 <3261c086-01d9-42aa-5e82-002a4da37275@gmail.com>
 <xmqqr2u8y2tg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2u8y2tg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 09:21:15PM +0900, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 10/12/2017 8:02 AM, Derrick Stolee wrote:
> >> Changes since previous version:
> >>
> >> * Make 'pos' unsigned in get_hex_char_from_oid()
> >>
> >> * Check response from open_pack_index()
> >>
> >> * Small typos in commit messages
> >>
> >> Thanks,
> >>   Stolee
> >>
> > I forgot to mention that I rebased on master this morning to be sure
> > this doesn't conflict with the binary-search patch that was queued
> > this week.
> 
> Thanks for being extra careful.  
> 
> I've re-applied minor style fix s/(void\*)/(void \*)/ to 2/4 and 4/4
> but other than that, the difference between this round and what has
> been queued looked all reasonable.
> 
> Will replace.

This looks good to me, too.

At first I was going to point out the nit that unique_in_pack() is
quietly fixed in 4/4 for the empty-pack case. But I don't think it's
actually buggy. The examination of nth_packed_object_oid() would never
be triggered if "num" is 0. So it probably is fine simply to fix it
quietly along with adding the new function.

-Peff
