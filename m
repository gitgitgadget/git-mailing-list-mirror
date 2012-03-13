From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Tue, 13 Mar 2012 10:31:27 -0400
Message-ID: <4F5F5A3F.8010102@xiplink.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu> <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr> <20120312183725.GA2187@sigill.intra.peff.net> <vpqy5r44zg7.fsf@bauges.imag.fr> <7vehswljxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=ED?= =?ISO-8859-1?Q?n_Nieto?= 
	<cmn@elego.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 15:31:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7SlD-0006p3-63
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 15:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab2CMOba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 10:31:30 -0400
Received: from smtp152.dfw.emailsrvr.com ([67.192.241.152]:43148 "EHLO
	smtp152.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab2CMOb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 10:31:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp15.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 2537A3004C4;
	Tue, 13 Mar 2012 10:31:29 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp15.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6FB6D300145;
	Tue, 13 Mar 2012 10:31:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vehswljxi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193028>

On 12-03-13 09:17 AM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> There's a rule of thumb which works very well for beginners: when "git
>> push" tells you to pull before, then pull before. This rule of thumb
>> works, but only provided "push" and "pull" are symmetrical.
> 
> I actually think the "pull before push again" was written with only
> CVS style non-branching workflow in mind, in other words, only to
> help somebody who works on his master against the central master.
> Obviously "push and pull are symmetrical" holds true for that single
> branch workflow, but that does not mean a more complex workflow must
> be symmetrical.
> 
> Even though I think 'upstream' will be a superset of what 'current'
> wants to do in an ideal world where the user configures everything
> right (hence it ought to be the better default between the two), I
> do not think that the target audience "let's change the default"
> folks are trying to help is those who set @{upstream} correctly
> point the destination for a branch they want to push to and leave it
> unset for a strictly private branch. If we choose the default that
> would primarily make it efficient for people who can configure
> everything right, we are missing the point of this discussion. I
> think the target audience to be helped is the people who do not
> (yet) do anything complex, and the point of this discussion is to
> help them avoid getting surprised.
> 
> And by "surprised", I do not necessarily mean "dangerous". While we
> should aim to avoid "dangerous", we should avoid "ununderstandable"
> even more.
> 
> Pushing 'current' from a branch 'topic' forked from either 'master'
> or 'origin/master' will create a new branch 'topic' at the central
> repository. But that is straightforward and understandable. The user
> will see what happened in the feedback from the command, and there
> is no need for the user to be experienced enough to know the mapping
> of @{upstream} to understand why it happened.  "I am on 'topic' and
> I pushed, I created 'topic' there".  Very simple explanation exists.
> 
> On the other hand, the user needs to know not just 'branch' but also
> understand the concept of @{upstream} in order to use 'upstream'
> without surprise.  When something goes wrong, prerequisite knowledge
> that is required to understand it is greater.  Also the current
> implementation of 'upstream' has some weird semantics (or undesigned
> bugs) pointed out by Peff, which would make it even more confusing.
> 
> That makes me suspect that 'current' might be a more appropriate
> default between the two. From that simple default, those in the
> "shared central repository" world can graduate to 'upstream' once
> they know what an 'upstream' is and how to take advantage of
> per-branch configuration.  Similarly, those in the "publish to be
> pulled" world would graduate to 'matching'.

Good points!

I think someone who's figuring out their workflow as they go would appreciate
the simplicity offered by "current".

You've changed my mind:  I now think "current" is the better default.

		M.
