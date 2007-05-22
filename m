From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 02:38:22 -0400
Message-ID: <20070522063821.GE11636@spearce.org>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net> <20070522060302.GH5412@admingilde.org> <7v646l9xkn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 08:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqO1G-0006u0-SN
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757883AbXEVGic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756392AbXEVGic
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:38:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39151 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227AbXEVGic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:38:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HqO0l-0001d0-0j; Tue, 22 May 2007 02:38:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 56E2C20FBAE; Tue, 22 May 2007 02:38:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v646l9xkn.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48078>

Junio C Hamano <junkio@cox.net> wrote:
> Martin Waitz <tali@admingilde.org> writes:
> 
> > On Mon, May 21, 2007 at 04:02:42PM -0700, Junio C Hamano wrote:
> >> I had a feeling that some callers needed to be able to unsetenv
> >> some.  How would this patch help them, or are they outside of
> >> the scope?
> >
> > At first I had the same objection but the putenv documentation
> > told me that at least in glibc you can unsetenv by providing
> > the variable name without a "=".
> 
> I recall SysV putenv() does not remove "ENVNAME" without '=', and
> http://www.opengroup.org/onlinepubs/000095399/functions/putenv.html
> seems to say that as well.

Are we overbuilding this thing?

I thought this thread all started because we wanted to run a
command in a subproject, and did not want the parent's GIT_*
environment variables to confuse the subproject process when
it started.  That's a pretty simple concept: clear any GIT_*
environment variable that can change behavior in the subproject.
And almost everyone who is trying to use this API and alter the
env wants exactly that - a subproject command.

-- 
Shawn.
