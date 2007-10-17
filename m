From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-cherry-pick no longer detecting moved files in 1.5.3.4
Date: Wed, 17 Oct 2007 03:33:57 -0400
Message-ID: <20071017073357.GA13801@spearce.org>
References: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com> <200710170035.12482.barra_cuda@katamail.com> <cac9e4380710170018p26ae8935xc4d3218f4db5411d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Richard Quirk <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:34:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3Q1-0000JU-7O
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbXJQHeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbXJQHeE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:34:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60815 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbXJQHeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:34:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii3Pi-0006r7-Mb; Wed, 17 Oct 2007 03:33:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5BEB320FBAE; Wed, 17 Oct 2007 03:33:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <cac9e4380710170018p26ae8935xc4d3218f4db5411d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61347>

Richard Quirk <richard.quirk@gmail.com> wrote:
> On 10/17/07, Michele Ballabio <barra_cuda@katamail.com> wrote:
> > It should be
> > diff.renamelimit = 0
> >
> > to set the "unlimited" limit.
> >
> 
> This doesn't work either. Cherry picking is not triggering the loading
> of this value at all.
> 
> This is because git-cherry-pick turns into a git-merge-recursive. This
> calls get_renames() in merge-recursive.c, which calls diff_setup,
> setting the renamelimit to -1, then calls diff_setup_done(), which
> sets the renamelimit to diff_rename_limit_default since rename_limit
> was < 0. diff_rename_limit_default is the hard-coded value of 100. At
> no point does merge-recursive call git_diff_ui_config() in diff.c that
> reads in the diff.renamelimit user defined value, so in the end the
> cherry pick uses the hardcoded value of 100.

That's an "old" bug.  Lars Hjemli fixed this in df3a02f612 back on
Sept 25th.  You can get the fix from either Junio's or my git tree
in the master branch.

-- 
Shawn.
