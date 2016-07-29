Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD0E1F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 06:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbcG2GlE (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 02:41:04 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44627 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcG2GlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 02:41:03 -0400
X-Greylist: delayed 24458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jul 2016 02:41:02 EDT
Received: from mfilter23-d.gandi.net (mfilter23-d.gandi.net [217.70.178.151])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 87CA3FB883;
	Fri, 29 Jul 2016 08:41:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter23-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter23-d.gandi.net (mfilter23-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id oijiNrEZUWyI; Fri, 29 Jul 2016 08:40:58 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A12A9FB88B;
	Fri, 29 Jul 2016 08:40:57 +0200 (CEST)
Date:	Thu, 28 Jul 2016 23:40:55 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160729064055.GB25331@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I'd like to announce a project I've been working on for a while:

git-series provides a tool for managing patch series with git, tracking
the "history of history". git series tracks changes to the patch series
over time, including rebases and other non-fast-forwarding changes. git
series also tracks a cover letter for the patch series, formats the
series for email, and prepares pull requests.

This makes it easier to collaborate on a patch series, distribution
package, backport, or any other development process that includes
rebasing or non-fast-forward development.

A patch series typically goes through multiple iterations before
submission; the path from idea to RFC to [PATCHv12 1/8] includes many
invocations of git rebase -i. However, while Git tracks and organizes
commits quite well, it doesn't actually track changes to a patch series
at all, outside of the ephemeral reflog. This makes it a challenge to
collaborate on a patch series, distribution package, backport, or any
other development process that includes rebasing or non-fast-forward
development.

Typically, tracking the evolution of a patch series over time involves
moving part of the version control outside of git. You can move the
patch series from git into quilt or a distribution package, and then
version the patch files with git, losing the power of git's tools. Or,
you can keep the patch series in git, and version it via multiple named
branches; however, names like feature-v2, feature-v3-typofix, and
feature-v8-rebased-4.6-alice-fix sound like filenames from corporate
email, not modern version control. And either way, git doesn't track
your cover letter at all.

git-series tracks both a patch series and its evolution within the same
git repository. git-series works entirely with existing git features,
allowing git to push and pull a series to any git repository along with
other branches and tags. Each time you change the patch series, whether
fast-forwarding or not, you can "git series commit" a new version of the
patch series, complete with commit message.

You can rebase a patch series with "git series rebase -i", format it for
submission with "git series format", or send a "please pull" request with
"git series req".  git-series knows the base of your series, so you
don't need to count patches or find a commit hash to run rebase or
format.

If you're interested in trying git-series, see
https://github.com/git-series/git-series for installation instructions
and a "getting started" guide.

I've also documented the internal storage format of git-series at
https://github.com/git-series/git-series/blob/master/INTERNALS.md ,
including the details for how git-series ensures git can always reach,
push, and pull a series.

I'd welcome any feedback, whether on the interface and workflow, the
internals and collaboration, ideas on presenting diffs of patch series,
or anything else.

- Josh Triplett
