From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.5.2-rc3
Date: Fri, 11 May 2007 00:10:24 -0700
Message-ID: <7v1whnesyn.fsf@assigned-by-dhcp.cox.net>
References: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net>
	<200705111023.37676.litvinov2004@gmail.com>
	<7vtzukf0h6.fsf@assigned-by-dhcp.cox.net>
	<200705111330.54312.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 09:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmPGq-0005dw-87
	for gcvg-git@gmane.org; Fri, 11 May 2007 09:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXEKHKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 03:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbXEKHKZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 03:10:25 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61532 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbXEKHKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 03:10:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511071025.IJHK13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 03:10:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xjAQ1W0031kojtg0000000; Fri, 11 May 2007 03:10:24 -0400
In-Reply-To: <200705111330.54312.litvinov2004@gmail.com> (Alexander Litvinov's
	message of "Fri, 11 May 2007 13:30:54 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46940>

Alexander Litvinov <litvinov2004@gmail.com> writes:

> I have tried your test and found that cloning such repo does not clone 
> subprojects. Only empty dir 'sub' is being cloned.

Yes, that is pretty much intentional.  Having a link for higher
layer tools can use (i.e. tree objects can contain 160000 mode
"gitlinks" to subproject commit objects) while not considering
such linkage part of the reachability is the whole point of
plumbing level subproject support.  It allows people not to
download repositories of uninteresting subprojects.  Higher
layer tools such as clone/checkout/diff could be instructed
(currently they cannot be, though) to recurse into subproject
directories if the user wants to.

A few good pointers for this topic are:

        $gmane/44162
        $gmane/44308
