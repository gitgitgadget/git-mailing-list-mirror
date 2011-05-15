From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 2/2] receive-pack: Add receive.objectCountLimit to refuse
 push with too many objects
Date: Sun, 15 May 2011 19:42:29 +0200
Message-ID: <201105151942.29219.johan@herland.net>
References: <201105131854.31540.johan@herland.net>
 <201105141517.45324.johan@herland.net>
 <BANLkTimQD5JFeOeF48cbMjDL3+WMfsmPtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 15 19:42:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLfKz-0002u1-FH
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 19:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab1EORmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 13:42:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48508 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab1EORmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 13:42:36 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL800FHRZUU4700@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 19:42:30 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2978D1EEFC08_DD01086B	for <git@vger.kernel.org>; Sun,
 15 May 2011 17:42:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E711F1EEF9F2_DD01085F	for <git@vger.kernel.org>; Sun,
 15 May 2011 17:42:29 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL80063GZUTRR40@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 19:42:29 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <BANLkTimQD5JFeOeF48cbMjDL3+WMfsmPtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173642>

On Sunday 15 May 2011, Shawn Pearce wrote:
> On Sat, May 14, 2011 at 06:17, Johan Herland <johan@herland.net> wrote:
> > I'm planning to add a new capability collection/namespace, called
> > "limit-*", where the server can communicate capabilities to the
> > client, like so:
> > 
> >  limit-object-count_100000
> >  limit-commit-count_1000
> >  limit-pack-size_500000000
> > 
> > (I'd prefer to s/_/=/ or s/_/:/, but according to pack-protocol.txt, a
> > capability may not contain "=" or ":")
> 
> I forget why = and : are forbidden here. I think its just because we
> wanted the options to be "simple". I agree, I would prefer = here too,
> and probably would have written the patch that way myself. There
> shouldn't be a technical reason why = isn't allowed here. Its just
> documented as being not a good idea because at one time someone wrote
> that down.

Ok. I'll use '='.

> > However, you say:
> >> For older clients that don't know this new advertised capability, they
> >> should fail hard and not transfer all of this data.
> > 
> > AFAICS this is not the case. If a client does not understand a
> > capability, it simply ignores it, and carries on doing its usual
> > thing.
> 
> By this I meant #2 below (the initial patch).

Ah, I see. Will use that in the re-roll.

> I don't think its as bad as it sounds. Its not a great user
> experience, sure. And we maybe should also look at changing the
> send-pack code to check the pipe for received data from the remote
> peer if pack-objects dies (today it doesn't)... just in case the
> reason pack-objects died is because an error message was written and
> then the stream was closed.

This will be in the re-roll.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
