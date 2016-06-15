From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 08:18:44 -0800
Message-ID: <7vsleic0t7.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<200701100904.32077.andyparkins@gmail.com>
	<7vbql7cjk8.fsf@assigned-by-dhcp.cox.net>
	<200701101010.46269.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 17:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4gAL-0002KQ-UW
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 17:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbXAJQTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 11:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbXAJQTB
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 11:19:01 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58842 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932AbXAJQTA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 11:19:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110161859.UMXC3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 11:18:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9UJ81W00X1kojtg0000000; Wed, 10 Jan 2007 11:18:09 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701101010.46269.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 10 Jan 2007 10:10:44 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36516>

Andy Parkins <andyparkins@gmail.com> writes:

> No I'm not.  Linus's suggested check is "git checkout will refuse to switch 
> AWAY from a detached head unless the SHA1 of the detached head exactly 
> matches some other branch."
>
> My question is what use is that?  In exactly the situation you describe HEAD 
> doesn't match a branch.
>
>   git checkout v1.0.0

You are taking it too literally.  Read what Linus wrote again.

    So if you do

            git checkout v1.4.4

    you'll be fine, because even though you got a detached HEAD that isn't 
    attached to any branch, it still exists as a tag, so checking out 
    something else is fine - you've not lost any state.

The version in "next" does that, in a quite straightforward way:

	git show-ref -d -s | grep "$old" || { barf }

which should be fairly fast in a repository with packed-pruned
refs.
