From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-checkout-index to use file suffixes.
Date: Wed, 1 Mar 2006 10:06:29 -0500
Message-ID: <20060301150629.GB3456@spearce.org>
References: <20060301044132.GF22894@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 01 16:08:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FESuW-0004x6-Oz
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWCAPGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWCAPGf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:06:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33250 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932193AbWCAPGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 10:06:35 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FESuI-00079r-Qg
	for git@vger.kernel.org; Wed, 01 Mar 2006 10:06:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6494A20FBBF; Wed,  1 Mar 2006 10:06:29 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060301044132.GF22894@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16977>

Shawn Pearce <spearce@spearce.org> wrote:
> Sometimes it is useful to unpack the unmerged stage entries
> to the same directory as the tracked file itself, but with
> a suffix indicating which stage that version came from.
> In many user interface level scripts this is being done
> by git-unpack-file followed by creating the necessary
> directory structure and then moving the file into the
> directory with the requested name.  It is now possible to
> perform the same action for a larger set of files directly
> through git-checkout-index.

Junio mentioned in his ``What's in git.git'' email that he's not
sure of this command line interface:

Junio C Hamano <junkio@cox.net> wrote:
> I am not sure about the command line interface of this.  Would
> it make more sense to checkout three stages in one pass?
> 
>     - checkout-index --suffix (Shawn Pearce)

I thought about the same thing myself when I submitted the patch
to the list.  I probably should have talked a little bit about that
in the email.  :-)

I thought about using instead:

  --stage=all --suffix1=\#1 --suffix2\=#2 --suffix3=\#3

but then thought that the performance gains achieved by only forking
git-checkout-index once, scanning the index once, etc. were not
that big of a difference compared to the rather horrible looking
command line syntax that produced and required one to use.

If anyone has any suggestions for these options, please pass them
along.  I'll rebuild the patch to pull all available stages if we
can come up with a suitable way of describing such.

-- 
Shawn.
