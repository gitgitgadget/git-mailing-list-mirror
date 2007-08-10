From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: do up-to-date check also for strategies ours, subtree.
Date: Fri, 10 Aug 2007 01:51:54 -0700
Message-ID: <7vabszu5zp.fsf@assigned-by-dhcp.cox.net>
References: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org>
	<7v3aysxvk3.fsf@assigned-by-dhcp.cox.net>
	<7vejibu69w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 10:52:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJQDv-0007Fb-Qq
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 10:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbXHJIv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 04:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXHJIv4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 04:51:56 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40585 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbXHJIvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 04:51:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810085155.WBLM7193.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 10 Aug 2007 04:51:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a8ru1X0021kojtg0000000; Fri, 10 Aug 2007 04:51:55 -0400
In-Reply-To: <7vejibu69w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 10 Aug 2007 01:45:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55523>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Right now I do not have time to dig mailing list archive around
>> mid March 2006, and I do not recall the requestor's original
>> rationale, but I have a vague recollection that we added this
>> "no fast-forward check" specifically in response to a user
>> request.
>
> I do not think of a valid reason not to apply your patch.  We
> wanted to avoid the trivial-merge codepath, but that is not a
> valid reason to record a fast forward situation as a merge of
> any kind.

Gaah.  I take it back.  At least, subtree _MUST_ not honor
fast-forward blindly.  git-gui.git project is merged into
git.git with that strategy, but if I pull from Shawn once, and
then he has more updates while I do not have anything on my
tree, it will be a fast-forward.  I should not be setting the
git.git tree to that of git-gui.git in such a case.
