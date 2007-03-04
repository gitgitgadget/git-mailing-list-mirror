From: Junio C Hamano <junkio@cox.net>
Subject: Re: Memory overrun in http-push.c
Date: Sun, 04 Mar 2007 00:31:58 -0800
Message-ID: <7virdh76kh.fsf@assigned-by-dhcp.cox.net>
References: <20070228151516.GC57456@codelabs.ru>
	<200703011931.32170.andyparkins@gmail.com>
	<Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200703021005.13620.andyparkins@gmail.com>
	<Pine.LNX.4.64.0703040234510.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Alex Riesen <raa.lkml@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 04 09:32:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNm8Z-0000cr-7q
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 09:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbXCDIcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 03:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbXCDIcH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 03:32:07 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46460 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbXCDIcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 03:32:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304083205.TDZK24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 4 Mar 2007 03:32:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WYY31W00J1kojtg0000000; Sun, 04 Mar 2007 03:32:04 -0500
In-Reply-To: <Pine.LNX.4.64.0703040234510.6485@iabervon.org> (Daniel
	Barkalow's message of "Sun, 4 Mar 2007 03:17:31 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41350>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Actually, how about doing keyword expansion just like the new CRLF
> handling?

That part is true, but practically speaking the only thing you
can honestly replace is $Id$ with blob object name, and nothing
else.  Trying to put anything that is available via commit would
at best telling a lie and at worst ending up denying the index
(and denying the index is denying git as somebody said).  You
could fake the values for $Author$ and $Date$ from HEAD commit,
but your index may or may not match HEAD commit when you check
out path from it.
