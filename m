Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CE81F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 08:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbcHAI7k (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 04:59:40 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34258 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbcHAI7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 04:59:38 -0400
Received: from mfilter48-d.gandi.net (mfilter48-d.gandi.net [217.70.178.179])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id CDA3B41C080;
	Mon,  1 Aug 2016 10:59:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter48-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter48-d.gandi.net (mfilter48-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id sjn1lS4aYD_r; Mon,  1 Aug 2016 10:59:33 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4C9F241C0BE;
	Mon,  1 Aug 2016 10:59:30 +0200 (CEST)
Date:	Mon, 1 Aug 2016 01:59:29 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Eric Wong <e@80x24.org>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com, Omar Jarjur <ojarjur@google.com>,
	Harry Lawrence <hazbo@gmx.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160801085928.lw3ltdksyrjujutu@x>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <CAP8UFD12Jk0s0HPPWS3CqFcB37gzhzZZi-V0PfqrRhZO4zhHOA@mail.gmail.com>
 <20160801075554.GA22222@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801075554.GA22222@starla>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 07:55:54AM +0000, Eric Wong wrote:
> Christian Couder <christian.couder@gmail.com> wrote:
> > On Fri, Jul 29, 2016 at 12:10 PM, Richard Ipsum
> > <richard.ipsum@codethink.co.uk> wrote:
> > > On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> > > [snip]
> > >>
> > >> I'd welcome any feedback, whether on the interface and workflow, the
> > >> internals and collaboration, ideas on presenting diffs of patch series,
> > >> or anything else.
> 
> > > I'm particularly interested in trying to establish a standard for
> > > storing review data in git. I've got a prototype for doing that[3],
> > > and an example tool that uses it[4]. The tool is still incomplete/buggy though.
> > 
> > There is also git-appraise (https://github.com/google/git-appraise)
> > written in Go to store code review data in Git.
> > It looks like it stores its data in git notes and can be integrated
> > with Rust (https://github.com/Nemo157/git-appraise-rs).
> 
> I'm not convinced another format/standard is needed besides the
> email workflow we already use for git and kernel development.

Not all projects use a patches-by-email workflow, or want to.  To the
extent that tools and projects use some other workflow, standardizing
the format they use to store patch reviews (including per-line
annotations, approvals, test results, etc) seems preferable to having
each tool use its own custom format.

> I also see the reliance on an after-the-fact search engine
> (which can be tuned/replaced) as philosophically inline with
> what git does, too, such as not having rename tracking and
> doing delayed deltafication.

Storing review data in git doesn't mean it needs to end up in the
history of the project itself; it can use after-the-fact annotations on
a commit.

> Email also has the advantage of having existing tooling, and
> being (at least for now) federated without a single point of
> failure.

Storing review data in git makes it easy to push and pull it, which can
provide the basis for a federated system.

- Josh Triplett
