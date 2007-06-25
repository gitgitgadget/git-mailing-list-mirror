From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: parsecvs fails even on simple input
Date: Mon, 25 Jun 2007 00:59:51 -0400
Message-ID: <20070625045951.GB32223@spearce.org>
References: <20070622113625.GD12473@rkagan.sw.ru> <1182720667.13289.41.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Kagan <rkagan@sw.ru>, Al Viro <viro@zeniv.linux.org.uk>,
	git@vger.kernel.org
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ggJ-0007QH-B4
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 07:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXFYFAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 01:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbXFYFAF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 01:00:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54583 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbXFYFAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 01:00:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I2ggA-0003nB-KN; Mon, 25 Jun 2007 00:59:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A23F420FBAE; Mon, 25 Jun 2007 00:59:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1182720667.13289.41.camel@neko.keithp.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50858>

Keith Packard <keithp@keithp.com> wrote:
> On Fri, 2007-06-22 at 15:36 +0400, Roman Kagan wrote:
> >  Wouldn't it be better to teach parsecvs
> > to speak git-fast-import language instead?
> 
> Avoiding fork/exec is rather important for parsecvs perforamance.

That sort of thing is the entire point behind fast-import.  Its only
one fork+exec to setup the fast-import "daemon" in the background,
and you do everything over a pipe to its stdin.  Including forcing
it to finish its current packfile and open a new one on the next
object (the `checkpoint` command).

fast-import is fast, its input language is fairly simple, and its
quite stable.  And its only one fork+exec.  That's peanuts compared
to the disk IO involved in any sizable import process.

-- 
Shawn.
