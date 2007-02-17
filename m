From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support for large files on 32bit systems.
Date: Sat, 17 Feb 2007 04:49:59 -0500
Message-ID: <20070217094959.GH27864@spearce.org>
References: <20070217091310.GD21842@admingilde.org> <20070217093953.GE21842@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat Feb 17 10:50:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIMD5-0005VU-QH
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 10:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946579AbXBQJuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 04:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946583AbXBQJuK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 04:50:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35195 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946579AbXBQJuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 04:50:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIMCh-00031F-Uc; Sat, 17 Feb 2007 04:50:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6216820FBAE; Sat, 17 Feb 2007 04:50:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070217093953.GE21842@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39983>

Martin Waitz <tali@admingilde.org> wrote:
> arg, this patch is completely broken.
> I tested it by setting the macro via the command line and the
> = is still left in there.  And __GLIBC__ is not yet defined at this
> point.
> 
> However, we need to set _FILE_OFFSET_BITS for glibc somehow.
> What is the best way to do so?

I think the only way to do with this is to have the Makefile detect
if -D_FILE_OFFSET_BITS=64 is required to be added to CFLAGS based on
some rule (e.g. uname output?), then add that to CFLAGS when needed.

This is one area where autoconf is nice, as you can compile
a thousand little C programs to see how the compiler reacts by
default, and when you attempt to set this define, and then decide
if you should include it or not.

It is also the part of autoconf that's not-so-nice... as it compiles
a thousand little C programs just to figure out how to compile the
real program.  ;-)

-- 
Shawn.
