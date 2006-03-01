From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-checkout-index to read filenames from stdin.
Date: Wed, 1 Mar 2006 12:56:06 -0500
Message-ID: <20060301175606.GA4190@spearce.org>
References: <20060301024333.GB21186@spearce.org> <20060301155053.GC1010@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 18:57:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEVYl-0001LT-2z
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWCAR4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWCAR4U
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:56:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46481 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030213AbWCAR4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 12:56:19 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEVYZ-0004Cy-AW; Wed, 01 Mar 2006 12:56:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B487320FBBF; Wed,  1 Mar 2006 12:56:06 -0500 (EST)
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060301155053.GC1010@trixie.casa.cgf.cx>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16999>

Christopher Faylor <me@cgf.cx> wrote:
> AFAIK, the length of the command line for cygwin apps is very large --
> if you're using recent versions of Cygwin.  I believe that it is longer
> than the linux default.  We bypass the Windows mechanism for setting the
> command line when a cygwin program starts a cygwin program.
> 
> For native Windows programs, the command line length is ~32K but I don't
> think that git uses any native Windows programs, does it?

No.  Currently GIT is entirely dependent on Cygwin.  So GIT
wouldn't bump into the ~32K limit due to the cygwin-cygwin feature
you mention.  But thanks for the information.  I had thought I had
read somewhere in the Cygwin documentation that the command line
length was rather limited (even under cygwin-cygwin calls).  Maybe
I was just seeing things.  :-)

But even if we can get a long set of args into git-checkout-index its
probably still better to stream them as you can get both programs
working at the same time (rather than waiting for xargs to build
the argument buffer) and you are saving yourself at least one fork
as you don't need to start xargs just to feed git-checkout-index.
Even on Linux where fork is cheap, that's still soemething saved.

-- 
Shawn.
