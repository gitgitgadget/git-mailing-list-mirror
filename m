From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] svnimport add support for parsing From lines for author
Date: Tue, 26 Sep 2006 22:34:41 -0700
Message-ID: <7vfyedj2j2.fsf@assigned-by-dhcp.cox.net>
References: <20060925110813.GA4419@shadowen.org>
	<7v7izrtdtw.fsf@assigned-by-dhcp.cox.net>
	<4518DC11.5050806@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 07:35:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSS4R-0007Dz-UM
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 07:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349AbWI0Feo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 01:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965348AbWI0Fen
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 01:34:43 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7552 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965347AbWI0Fem (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 01:34:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927053441.KEIE12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 01:34:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id THae1V0091kojtg0000000
	Wed, 27 Sep 2006 01:34:39 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4518DC11.5050806@shadowen.org> (Andy Whitcroft's message of
	"Tue, 26 Sep 2006 08:51:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27876>

Andy Whitcroft <apw@shadowen.org> writes:

>>> Now that we have support for parsing Signed-off-by: for author
>>> information it makes sense to handle From: as well.
>> 
>> I take that you are referring to Sasha's change in ae35b304; I
>> asked for actual svn users for ACK/NACK but I did not hear any.
>> Can I understand that you use svnimport for real projects and
>> are happy with Sasha's change? --- that would be an ack that
>> would help me sleep better ;-).
>
> Heh.  Yeah I am tracking a small SVN repository which is using the
> kernel DCO.  we have From:/S-o-b: much as akpm uses in -mm.  This was
> the result of seeing that change and wanting to see if it would pick up
> our sign-offs.  It only seemed deficient in From: handling :).  It seems
> to work well in practice for me.

Thanks.

>> I also wonder instead of piling up custom flags if it is better
>> to let match-and-extract pattern be specified from the command
>> line.
>
> I did look at reusing the -S flag, such that -S would be S-o-b: handling
> and -SS would be S-o-b: and From:, but this script is currently using
> the old getopt implementation which doesn't record repeats.
>
> So you're proposing something more like:
>
>     git svn-import -S "Signed-off-by:" -S "From:" ...
>
> Again, we'll have to update the options handling to get that kind of
> behaviour.  How would you feel about -SS in this context.

It was more of an idle speculation than a serious proposal.  I
do not think there are too many different ways to record the
authorship information, so having just two hardwired patterns -F
and -S would be sufficient.  If there were, then string of -S
options that specify the header-looking strings or match
patterns would have made more sense.
