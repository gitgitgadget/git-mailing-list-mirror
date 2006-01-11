From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem resolving an octopus merge conflict
Date: Wed, 11 Jan 2006 00:33:32 -0800
Message-ID: <7virsrupsz.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP1241F00474C3FC5C32F7A6AE240@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 09:33:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwbQG-0000NM-RG
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 09:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWAKIde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 03:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWAKIde
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 03:33:34 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19423 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751373AbWAKIdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 03:33:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111083140.FCXF17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 03:31:40 -0500
To: "Sean" <seanlkml@sympatico.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14482>

"Sean" <seanlkml@sympatico.ca> writes:

> After fixing this up though, git-commit won't see this as a merge commit
> and won't add the proper parent linkages.   I'm not sure at this point
> what the proper fix should be or if this is just pilot error.

Not a pilot error, and we do not make it explicit enough, but
git-merge-octopus has this comment:

	echo "Simple merge did not work, trying automatic merge."
	git-merge-index -o git-merge-one-file -a ||
	exit 2 ; # Automatic merge failed; should not be doing Octopus

If you need to manually fix up such a merge, that is a sure sign
that the branches you merged into an Octopus was not independent
bunches after all.  Letting such a commit to be made defeats the
point of an Octopus, which is to bundle independent tracks of
development.

This is more philosophical rather than technical, and may look
being unhelpful to you (who wanted to create an Octopus), but is
done to help people who later needs to deal with such a merge
history.
