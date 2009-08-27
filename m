From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Fri, 28 Aug 2009 01:03:05 +0200
Message-ID: <200908280103.06015.johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 01:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgo00-0000Tr-7A
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 01:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZH0XDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 19:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbZH0XDI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 19:03:08 -0400
Received: from smtp.getmail.no ([84.208.15.66]:56954 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751527AbZH0XDH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 19:03:07 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP200CSF5D80Z60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 28 Aug 2009 01:03:08 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP2009ZR5D6DB50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 28 Aug 2009 01:03:08 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.225116
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127232>

On Thursday 27 August 2009, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Yea, it was me.  I still think it might be a useful idea, since
> > it allows you better density of loading notes when parsing the
> > recent commits.  In theory the last 256 commits can easly be in
> > each of the 2/ fanout buckets, making 2/38 pointless for reducing
> > the search space.  Commit date on the other hand can probably force
> > all of them into the same bucket, making it easy to have the last
> > 256 commits in cache, from a single bucket.
> >
> > But I thought you shot it down, by saying that we also wanted to
> > support notes on blobs.  I happen to see no value in a note on
> > a blob, a blob alone doesn't make much sense without at least an
> > annotated tag or commit to provide it some named context, and the
> > latter two have dates.
>
> Yeah, and in this thread everybody seems to be talking about commits so I
> think it is fine to limit notes only to commits.

Agreed. I'm starting to come around to the idea of storing them in subtrees 
based on commit dates. For one, you don't have multiple notes for one commit 
in the same notes tree. Also, the common-case access pattern seems tempting.

Dscho: Were there other problems with the date-based approach other than not 
supporting notes on trees and blobs?

If not, I'll start preparing another series with the date-based approach.


Thanks for the input, guys. :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
