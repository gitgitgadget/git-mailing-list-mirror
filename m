From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 13:41:56 -0700
Message-ID: <7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
	<7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
	<20070728101156.20304d11.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:42:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEt6y-0000jj-6B
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 22:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482AbXG1Ul7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 16:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757270AbXG1Ul7
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 16:41:59 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54024 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482AbXG1Ul5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 16:41:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728204156.DVJG23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 16:41:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id V8hw1X0021kojtg0000000; Sat, 28 Jul 2007 16:41:56 -0400
In-Reply-To: <20070728101156.20304d11.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sat, 28 Jul 2007 10:11:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54064>

Sean <seanlkml@sympatico.ca> writes:

> I would argue that you shouldn't try to have it both ways.

You cannot have it both ways as-is, but this is solvable.  The
invocation of am from rebase needs an extra (internal to
implementation) option to use the code it patches, and the
regular am can fold what are found on Subject: lines it used
to.

The patch as-is breaks the more important case of e-mail
acceptance codepath, because MUAs are free to fold the Subject:
line when the original line is long, and what the user (the
original patch submitter) expects to happen is that a
single-line-ness of the original Subject: of the message to be
kept.  The patch breaks such a line at the place MUA happens to
fold such a long, single line, for comforming messages.
 
