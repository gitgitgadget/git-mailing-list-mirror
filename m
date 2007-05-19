From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sat, 19 May 2007 11:19:45 +0200
Message-ID: <20070519091945.GA2462@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163061588-git-send-email-skimo@liacs.nl> <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 11:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpL6T-0000cs-8T
	for gcvg-git@gmane.org; Sat, 19 May 2007 11:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbXESJTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 05:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbXESJTs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 05:19:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:37732 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbXESJTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 05:19:48 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (klopstock mo10) (RZmta 6.5)
	with ESMTP id 7046afj4J6NOSK ; Sat, 19 May 2007 11:19:46 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E7856277BD;
	Sat, 19 May 2007 11:19:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 77B88D195; Sat, 19 May 2007 11:19:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47731>

Junio C Hamano, Sat, May 19, 2007 05:59:48 +0200:
> 
>  - figure out what commit should be checked out from
>    superproject index;
> 
>  - make sure the named commit exists, or fetch to make it exist.

What if the fetch is not possible? You can't checkout? What about the
other subprojects, where the checkout succeeded? Will they be reset to
the previuos state?

To me, the fetch sounds pretty dangerous. Maybe the checkout should
be two stage: first - we check all subprojects to be checked out if it
is possible, second - either fail (default) or checkout what possible,
warn the user, leave the incomplete subprojects changed (but not
update the index with them, so that they wont be accidentally
committed).

>  - go there and check out that commit; this implies two things:
> 
>    1. if there are local changes, it will be carried along and we
>       checkout the named commit;

Shouldn't that depend on "-m" option given to git-checkout in
superproject? Sometime the user have to be sure he can checkout
everything as it were, but without breaking the local state (like what
current git-checkout without "-m" does).

>    2. the repository's HEAD becomes detached;
> 

Universally agreed upon
