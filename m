From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 17:17:09 -0400
Message-ID: <20070403211709.GJ27706@spearce.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:18:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqOf-0002kV-3m
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945962AbXDCVR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945963AbXDCVRz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:17:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51510 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945959AbXDCVRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:17:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYqNC-0002xA-Nm; Tue, 03 Apr 2007 17:17:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E91A720FBAE; Tue,  3 Apr 2007 17:17:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43667>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 3 Apr 2007, Shawn O. Pearce wrote:
> > If its the missing-object lookup that is expensive, maybe we should
> > try to optimize that.  We do it enough already in other parts of
> > the code...
> 
> Well, for all other cases it's really the "object found" case that is 
> worth optimizing for, so I think optimizing for "no object" is actually 
> wrong, unless it also speeds up (or at least doesn't make it worse) the 
> "real" normal case.

Right.  But maybe we shouldn't be scanning for packfiles every
time we don't find a loose object.  Especially if the caller is in
a context where we actually *expect* to not find said object like
half of the time... say in git-add/update-index.  ;-)

-- 
Shawn.
