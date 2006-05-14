From: Junio C Hamano <junkio@cox.net>
Subject: Re: Howto get the merge-base ?
Date: Sun, 14 May 2006 11:12:32 -0700
Message-ID: <7vu07s1nn3.fsf@assigned-by-dhcp.cox.net>
References: <4fb292fa0605141021r20cefaa0he592b9c713ede333@mail.gmail.com>
	<7v3bfc33hm.fsf@assigned-by-dhcp.cox.net>
	<4fb292fa0605141104j6c73c1eao5a8eeea9ad1b6282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 20:12:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfL53-0003uR-ED
	for gcvg-git@gmane.org; Sun, 14 May 2006 20:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWENSMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 14:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWENSMa
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 14:12:30 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29074 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751366AbWENSM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 14:12:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514181228.MNUJ27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 14:12:28 -0400
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605141104j6c73c1eao5a8eeea9ad1b6282@mail.gmail.com>
	(Bertrand Jacquin's message of "Sun, 14 May 2006 20:04:45 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19976>

"Bertrand Jacquin" <beber.mailing@gmail.com> writes:

> On 5/14/06, Junio C Hamano <junkio@cox.net> wrote:
>> "Bertrand Jacquin" <beber.mailing@gmail.com> writes:
>>
>> > I'm trying to know which commit it the parent of a merge.
>> > For exemple if I do that :
>> >
>> >   o Merge
>> >  / \
>> > /   \
>> > |   |
>> > |   o Commit D
>> > |   |
>> > |   o Commit C
>> > |   |
>> > o   | Commit B
>> > \  /
>> >  \/
>> >  o Commit A
>> >  |
>> >  o Init
>> >
> No, that's just on the following of git-send-mail-commit.sh thread (or
> something near). To make a readable merge mail with diffstat and
> summury.

For that you do not want merge-base.  If your mainline was A-B
and you merged a side branch B-C-D with the merge, then to
people who tracked your head (that's the audience of "merge
mail", I presume) they just need to see:

	git diff --stat M^1..M
	git rev-list --no-merges --pretty M^1..M | git shortlog

The diffstat is "what damage was inflicted on the branch you
have been following with this merge", so the diff between the
trees before and after the merge is what you want.  And the
rev-list piped to shortlog is to show "what commits were _not_
present on this branch before the merge, but are present after
the merge" (it could be spelled M^1..M^2 but the above would
handle octopus as well).
