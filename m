From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git files data formats documentation
Date: Sat, 5 Aug 2006 12:22:33 -0400
Message-ID: <20060805162233.GA19909@spearce.org>
References: <44D42F0D.3040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 18:25:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9OxY-0000JN-V9
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 18:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWHEQZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 12:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWHEQZE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 12:25:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38827 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932632AbWHEQZC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 12:25:02 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9OxK-0001yo-Qx; Sat, 05 Aug 2006 12:24:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BF63920FB77; Sat,  5 Aug 2006 12:22:33 -0400 (EDT)
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <44D42F0D.3040707@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24920>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> This information may be useful for reading and writing the various Git 
> files.
[snip]
> 	#	/* -  -  -  -  -  -  -  -  -  -  -  - *\
> 	#	 | This reflects version 3 pack files |
> 	#	\* -  -  -  -  -  -  -  -  -  -  -  - */
[snip]
> 	#	/* -  -  -  -  -  -  -  -  -  -  -  - *\
> 	#	 | This reflects version 2 pack files |
> 	#	\* -  -  -  -  -  -  -  -  -  -  -  - */

Thanks for taking the time to write these out.  The pack delta
formats were particularly helpful as it caused me to go back
and look at the unpacking code in jgit.

Apparently I wasn't handling the version 2 pack file correctly as I
didn't support copy-from-result; I had an infinite loop if the base
didn't decompress in one read (never happen right now, but could
in the future); and apparently my insert opcode implementation was
causing an infinite loop.  Nasty bugs.  I need to get more unit
tests written apparently.  :-)


-- 
Shawn.
