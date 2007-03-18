From: Junio C Hamano <junkio@cox.net>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 12:31:13 -0700
Message-ID: <7v4poimjr2.fsf@assigned-by-dhcp.cox.net>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	<20070316104715.483df0d5@localhost>
	<20070316140855.GE4489@pasky.or.cz>
	<20070316153822.5c842e69@localhost>
	<20070316231646.GB4508@spearce.org>
	<20070317195832.2af87c06@home.brethil>
	<20070318052332.GC15885@spearce.org>
	<7vzm6bp07f.fsf@assigned-by-dhcp.cox.net>
	<20070318161854.5a6a34e0@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sun Mar 18 20:31:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT16d-0007vc-00
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 20:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbXCRTbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 15:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbXCRTbQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 15:31:16 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:56696 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbXCRTbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 15:31:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318193115.NGQY18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 15:31:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cKXD1W00j1kojtg0000000; Sun, 18 Mar 2007 15:31:14 -0400
In-Reply-To: <20070318161854.5a6a34e0@home.brethil> (Luiz Fernando
	N. Capitulino's message of "Sun, 18 Mar 2007 16:18:54 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42510>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

>  I mean, if the information needed to print the error message (packfile
> name and version in this example) is available to the caller, or the
> caller can get it someway, then the caller could check which error
> he got and build the message himself.
>
>  That seems simpler to me, considering the caller has the needed
> info, of course...

It's a possibility, but that would make it much less nice to
diagnose and debug problems, as the caller does not usually have
necessary information.

The caller may ask for object A, and the error is triggered
because a different object C is missing, which is the delta base
of object B which in turn is the delta base of object A.  The
best your "caller" can say is "cannot read object A for some
reason", and it cannot say "cannot read object A because object
C is missing".
