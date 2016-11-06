Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23DC2021E
	for <e@80x24.org>; Sun,  6 Nov 2016 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbcKFQeT (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 11:34:19 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52828 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbcKFQeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 11:34:19 -0500
Received: from mfilter48-d.gandi.net (mfilter48-d.gandi.net [217.70.178.179])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 7719EA80D0;
        Sun,  6 Nov 2016 17:34:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter48-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter48-d.gandi.net (mfilter48-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id zvVMsWmkoQYZ; Sun,  6 Nov 2016 17:34:15 +0100 (CET)
X-Originating-IP: 50.39.170.172
Received: from x (50-39-170-172.bvtn.or.frontiernet.net [50.39.170.172])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B8CCAA80CE;
        Sun,  6 Nov 2016 17:34:12 +0100 (CET)
Date:   Sun, 6 Nov 2016 09:34:10 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161106163410.ilysej5r6qd3744e@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
 <20161105151836.wztypzrdywyltvrc@x>
 <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
 <20161105202553.migx75gfuujakqyk@x>
 <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2016 at 09:50:07PM -0700, Jacob Keller wrote:
> On Sat, Nov 5, 2016 at 1:25 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Sat, Nov 05, 2016 at 09:21:58PM +0100, Christian Couder wrote:
> >> On Sat, Nov 5, 2016 at 4:18 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> >> > On Sat, Nov 05, 2016 at 01:45:27PM +0100, Christian Couder wrote:
> >> >> And with what Peff says above it looks like we will need ways
> >> >> configure and tweak commit reachability with gitlink/gitref anyway. So
> >> >> the point of gitref compared to gitlink would be that they just have a
> >> >> different reachability by default. But couldn't that be replaced by a
> >> >> default rule saying that when a gitlink is reached "this way or that
> >> >> way" then the commit reachability should be enforced, and otherwise it
> >> >> should not be?
> >> >
> >> > Any version of git unaware of that rule, though, would consider objects
> >> > only reachable by gitlink as unreachable and delete them, causing data
> >> > loss.  Likewise for a server not aware of that rule.  And a server
> >> > unaware of that rule would not supply those objects to a client pulling
> >> > such a branch.
> >>
> >> Yeah, so you would really need an up-to-date server and client to
> >> store the git-series data.
> >> But anyway if we create a gitref object, you would also need
> >> up-to-date servers and clients to make it work.
> >
> > Agreed, but gitrefs have the advantage of failing safe, rather than
> > failing with dataloss.
> >
> > - Josh Triplett
> 
> Isn't the "failing safe" only true if the client disconnects when a
> server doesn't advertise "i understand gitrefs"? So couldn't we, as
> part of the rules for reachability advertise a capability that does a
> similar thing and fails safe as well?

We could, but if we (or one of the many third-party git implementations)
miss a case, gitlinks+reachability may appear to work in many cases with
dataloss afterward, while gitrefs will fail early and not appear
functional.
