From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Corporate firewall braindamage
Date: Thu, 10 Apr 2008 19:33:28 -0400
Message-ID: <20080410233328.GQ10274@spearce.org>
References: <47FE8277.8070503@zytor.com> <7v7if5wbdd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	ftpadmin <ftpadmin@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 01:34:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk6Hb-0002wu-6m
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 01:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYDJXdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbYDJXdf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 19:33:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43213 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbYDJXde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 19:33:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jk6Ge-00076r-1c; Thu, 10 Apr 2008 19:33:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 78E6A20FBAE; Thu, 10 Apr 2008 19:33:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7if5wbdd.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79256>

Junio C Hamano <gitster@pobox.com> wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> > 3. git protocol encapsulated in HTTP POST transaction
> >
> >    git protocol is already fundamentally a RPC protocol, where the
> >    client sends a query and the server responds.  Furthermore, it
> >    tries to minimize the number of round trips (RPC calls), which is
> >    of course desirable.
> >
> >    Each such RPC transaction could be formulated as an HTTP POST
> >    transaction.
> >
> >    This requires modifications to both the client and the server;
> >    furthermore, the server can no longer rely on the invariant "one TCP
> >    connection == one session"; a proxy might break a single session
> >    into arbitrarily many TCP connections.
> 
> It would probably be a one-CS/EE-student-half-a-summer sized project to
> create such a server-side support with a specialized client.

Funny you say that.  This was a GSoC 2008 project idea.  We even
received an application from a student for it.

The hard part is either making the server side stateful, so it can
remember what the last RCP call had said it wants/haves, or doing a
stateless protocol where the client uses an exponential expansion
(or some such behavior) of its have list until the server replies
with the pack data.

-- 
Shawn.
