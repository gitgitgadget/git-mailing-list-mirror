From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Build even if tclsh is not available
Date: Wed, 16 May 2007 22:49:11 -0400
Message-ID: <20070517024911.GZ3141@spearce.org>
References: <20070517020616.4722.33946.stgit@rover> <20070517021448.24022.8282.stgit@rover> <20070517021858.GY3141@spearce.org> <20070517023614.GL4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 04:49:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoW3P-0006Oq-Mv
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbXEQCtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757793AbXEQCtS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:49:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45429 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbXEQCtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:49:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HoW33-0000Mo-Bt; Wed, 16 May 2007 22:49:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EDDE120FBAE; Wed, 16 May 2007 22:49:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070517023614.GL4489@pasky.or.cz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47491>

Petr Baudis <pasky@suse.cz> wrote:
> On Thu, May 17, 2007 at 04:18:58AM CEST, Shawn O. Pearce wrote:
> > I have a couple of problems with the patch as-is.  The first is
> > of course that the patch needs to be split into two; one patch for
> > the git-gui subdirectory itself and one for git.git.
> 
> Hmm, why? It's an atomic change, one part doesn't make sense without the
> other.

Because git-gui is actually a project maintained external from
git.git.  It just happens that Junio pulls various versions of
it into git.git to distribute it along with git.git releases.

I deal with these sorts of "atomic changes" by making an evil merge
in git.git and asking Junio to pull the evil merge.  But we've only
had one such case thus far.
 
> > git-gui won't work if lib/tclIndex is missing or invalid.  So not
> > installing it means we should just disable git-gui entirely.
> 
>   (i) Makefile will autodecide on whether git-gui will be
> built+installed or not
> 
>   (ii) ./configure will, people not using configure and building on
> servers will be left to tweak config manually
> 
>   (iii) ./configure will, git-gui will default to not to be built and
> people not using configure and wanting git-gui will be left to tweak
> config manually

(iv) if tclsh is not available then create a simpler lib/tclIndex that
loads all of the lib directory, even if it isn't needed.  That makes
tclsh being available strictly an optimization, and yet git-gui still
is installable.

-- 
Shawn.
