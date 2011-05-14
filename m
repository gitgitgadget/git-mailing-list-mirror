From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] receive-pack: Add receive.denyObjectLimit to refuse
 push with too many objects
Date: Sat, 14 May 2011 03:43:48 +0200
Message-ID: <201105140343.48741.johan@herland.net>
References: <201105131854.31540.johan@herland.net>
 <7vpqnm7cim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 03:45:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QL3up-0005Tm-AW
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 03:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759009Ab1ENBo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 21:44:57 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42246 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758649Ab1ENBo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 21:44:56 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL500DPYWUUVE10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 03:44:54 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B73161EA5E28_DCDDE55B	for <git@vger.kernel.org>; Sat,
 14 May 2011 01:43:49 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 99B231EA29EF_DCDDE55F	for <git@vger.kernel.org>; Sat,
 14 May 2011 01:43:49 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL500AOKWT1WR00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 03:43:49 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vpqnm7cim.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173569>

On Friday 13 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > The new receive.denyObjectLimit config variable defines an upper limit
> > on the number of objects to accept in a single push. If the number of
> > objects in a push exceeds this limit, the entire push is immediately
> > aborted without storing the pushed objects on the server at all.
> 
> Where does the error message go?  Can clients pushing over various
> transports receive the reason without your server consuming the data from
> them?  Don't you want to "receive-in-core-and-discard" instead?

Yes. Will be fixed in the re-roll.

> For the purpose of "preventing an accidental push", I suspect that people
> would expect you to limit either by number of commits (i.e. depth of
> history) or by the total size of the data being transferred.

Yes, I agree that limiting by #commits, or by pack size would be more 
intuitive. However, neither of those values are available to me at the point 
where I have to decide what to do with the pack data (only the pack header 
is available, and that only contains the object count).

> The name "objectlimit" sounds as if you are doing the latter and we can
> use "200MB" there, but you are only limiting by count, so it is somewhat
> misleading.  We would want to see "count" or "number" somewhere in its
> name.

Agreed. Will be renamed to receive.objectCountLimit in the re-roll.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
