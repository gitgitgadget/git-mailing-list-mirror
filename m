From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sun, 29 Apr 2007 03:06:17 -0400
Message-ID: <20070429070616.GV5942@spearce.org>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br> <1177693212202-git-send-email-lcapitulino@mandriva.com.br> <7vabwtobpg.fsf@assigned-by-dhcp.cox.net> <20070427181326.14bbbf5c@localhost> <7vy7kbeke1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 09:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi3UK-0000D0-FQ
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 09:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbXD2HGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 03:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbXD2HGZ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 03:06:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53119 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbXD2HGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 03:06:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hi3U9-0001cz-Ta; Sun, 29 Apr 2007 03:06:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 546DB20FBAE; Sun, 29 Apr 2007 03:06:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy7kbeke1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45821>

Junio C Hamano <junkio@cox.net> wrote:
> The reason I do not like this particular one is because both
> operations you are hiding are not simple operations like
> "initialize a variable to list head" or "follow a single pointer
> in the structure", but rather heavyweight operations with rather
> complex semantics.  I would want to make sure that people
> realize they are calling something heavyweight when they use the
> revision traversal.

But in_merge_base is heavyweight if the two commits are in the
same object database, but aren't connected at all.  You'll need
to traverse both histories before aborting and saying there is
no merge base.  That ain't cheap on large trees.  But its also a
single line of code.

Anyway, my original problem with this macro was the way it was
defined.  I think Luiz was able to fix most of my issues with it
in his latest version, but I still have a personal distaste for
hiding things like a for(;;) construct in a macro, or allowing a
macro parameter to be used more than once within the definition of
the macro (unexpected side-effects of evaluating an more than once).

-- 
Shawn.
