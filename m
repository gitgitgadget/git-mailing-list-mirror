Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F1B1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 19:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbcHATrQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:47:16 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:47069 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbcHATrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:47:14 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id E7F9847FB13;
	Mon,  1 Aug 2016 20:38:59 +0200 (CEST)
Received: from mfilter47-d.gandi.net (mfilter47-d.gandi.net [217.70.178.178])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 41FAF1720A5;
	Mon,  1 Aug 2016 20:37:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter47-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter47-d.gandi.net (mfilter47-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 2M-daNVHjHSB; Mon,  1 Aug 2016 20:37:54 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DBB0B1720A9;
	Mon,  1 Aug 2016 20:37:52 +0200 (CEST)
Date:	Mon, 1 Aug 2016 11:37:50 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Stephen Warren <swarren@wwwdotorg.org>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Glass <sjg@chromium.org>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160801183750.ivwue4mxm5ilgzqz@x>
References: <20160729064055.GB25331@x>
 <b7bd1464-1412-1feb-fe10-9ecb6018e122@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bd1464-1412-1feb-fe10-9ecb6018e122@wwwdotorg.org>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 09:14:54AM -0600, Stephen Warren wrote:
> On 07/29/2016 12:40 AM, Josh Triplett wrote:
> > I'd like to announce a project I've been working on for a while:
> > 
> > git-series provides a tool for managing patch series with git, tracking
> > the "history of history". git series tracks changes to the patch series
> > over time, including rebases and other non-fast-forwarding changes. git
> > series also tracks a cover letter for the patch series, formats the
> > series for email, and prepares pull requests.
> 
> Just as an FYI, I wouldn't be surprised if there's some overlap, or
> potential for merging of tools, between this tool and the "patman" tool
> that's part of the U-Boot source tree:
> 
> http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README;h=e36857dedea1d0dbafa41732aaf9bf0988d63f38;hb=HEAD

Interesting tool; thanks for the link.

As far as I can tell from that documentation, patman doesn't track old
versions of a patch series; you rebase to modify patches or change
patman tags (embedded in commit messages), and nothing preserves the
previous version.  And it tracks the cover letter and similar in one of
the commit messages in the series, so previous versions of that don't
get saved either.  If you wanted to track the history of your changes,
you'd have to use branch names or similar.

In addition, tracking metadata in commit messages only works with a
patches-by-mail workflow where the messages get processed when
generating patches; that doesn't work for please-pull workflows.

patman does have quite a few interesting ideas, though.  git-series
needs some way of handling To/Cc addresses for patches and the cover
letter (beyond just scripts/get_maintainer.pl), and more automatic
handling of series versioning (v2, v3, ...) and associated series
changelogs.  Suggestions welcome.

- Josh Triplett
