From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Enable "git rerere" by the config variable rerere.enabled
Date: Sun, 8 Jul 2007 17:36:39 -0400
Message-ID: <20070708213639.GB4436@spearce.org>
References: <Pine.LNX.4.64.0707061303450.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:37:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7eR6-0003nj-Eh
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbXGHVgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbXGHVgx
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:36:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:32897 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534AbXGHVgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:36:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I7eQp-0002S2-Dy; Sun, 08 Jul 2007 17:36:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D8AB220FBAE; Sun,  8 Jul 2007 17:36:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707061303450.4093@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51924>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Earlier, "git rerere" was enabled by creating the directory
> .git/rr-cache.  That is definitely not in line with most other
> features, which are enabled by a config variable.
> 
> So, check the config variable "rerere.enabled". If it is set
> to "false" explicitely, do not activate rerere, even if
> .git/rr-cache exists. This should help when you want to disable
> rerere temporarily.
...
> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index f9791f6..578bef8 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -331,9 +331,7 @@ A rescan will be automatically started now.
>  
>  	# -- Let rerere do its thing.
>  	#
> -	if {[file isdirectory [gitdir rr-cache]]} {
> -		catch {git rerere}
> -	}
> +	catch {git rerere}
>  
>  	# -- Run the post-commit hook.
>  	#

While I applaud the idea of someone else doing the dirty work for me,
the patch above to git-gui always runs rerere, even if the user has
disabled it with rerere.enabled=false.  Not very nice to do.

The master branch of git-gui will (very soon) have a change that
actually honors rerere.enabled, as described in the commit message
of git.git's b4372ef136b0a5a2c1dbd88a11dd72b478d0e0a5, aka the text
I quoted above.

-- 
Shawn.
