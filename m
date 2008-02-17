From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] start_command(), if .in/.out > 0, closes file descriptors, not the callers
Date: Sun, 17 Feb 2008 03:20:49 -0500
Message-ID: <20080217082049.GT24004@spearce.org>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org> <1203183399-4813-1-git-send-email-johannes.sixt@telecom.at> <1203183399-4813-2-git-send-email-johannes.sixt@telecom.at> <7vmyq07bqe.fsf@gitster.siamese.dyndns.org> <20080217074252.GO24004@spearce.org> <7vodag2egp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 09:21:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQemJ-0003J7-Jb
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 09:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759135AbYBQIU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 03:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759127AbYBQIU4
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 03:20:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53616 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759111AbYBQIUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 03:20:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JQelU-0000Vc-Vl; Sun, 17 Feb 2008 03:20:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 36D1120FBAE; Sun, 17 Feb 2008 03:20:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vodag2egp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74105>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Of course the same argument can be said for fd 0; if the parent does
> > close(0) before some other open/socket/pipe call then its obviously
> > possible for the parent to get a fd that it wants the child to take
> > over and close.
> >
> > We're basically assuming that the parent will always keep its
> > own stdin open if it will be spawning children.  We all know what
> > happens when we assume (we double close file descriptors) but I
> > think its a reasonable safe assumption to be making.
> 
> Ok, that unwritten assumption was what confused me.  We
> definitely need Documentation/technical/api-*.txt before any
> more code, don't you agree?

Yes.

I'm far too tired to write it tonight.  Maybe I will find the
time and energy tomorrow.  Depends on how it goes at day-job
(yes, must go back for yet another day this weekend).

But this API is messy enough that we need explicit rules of
how it should be used, and then make everyone match that.

Unless Johannes Sixt beats me to it, my next patch to you will
be for a proposed documentation improvement.

-- 
Shawn.
