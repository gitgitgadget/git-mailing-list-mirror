From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] log_ref_write() -- do not chomp reflog message at the first LF
Date: Sun, 29 Jul 2007 11:47:18 -0700
Message-ID: <7vsl77m4i1.fsf@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
	<7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
	<20070728101156.20304d11.seanlkml@sympatico.ca>
	<7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net>
	<7vzm1gnhin.fsf@assigned-by-dhcp.cox.net>
	<7vvec4nhfk.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707291248560.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 20:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFDnZ-0006md-Po
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 20:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765723AbXG2SrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765122AbXG2SrV
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 14:47:21 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41592 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457AbXG2SrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 14:47:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729184718.HNUM1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Jul 2007 14:47:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VWnJ1X00Q1kojtg0000000; Sun, 29 Jul 2007 14:47:19 -0400
In-Reply-To: <Pine.LNX.4.64.0707291248560.14781@racer.site> (Johannes
	Schindelin's message of "Sun, 29 Jul 2007 12:57:09 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54132>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is not like the reflog messages have to be very verbose; they only have 
> to give a hint what the commit was about, and the commit name is the 
> important information.

I've considered it, but decided against it because:

 (1) I did not like the information lossage;

 (2) this is solely to help log messages coming from outside the
     recommended convention, and having excess will not hurt the
     normal usage;

 (3) it is not known if messages from outside the recommended
     convention have enough information on its first line of the
     first paragraph; the result of s/\n.*/.../ may not be
     sufficient "hint";

 (4) log output are by default piped to "less -S" so extra
     output gives the user chance to inspect more if he chosses
     to, without hurting the end user display; and

 (5) the code was simpler and less error prone to go wrong.
