From: Junio C Hamano <junkio@cox.net>
Subject: Re: git reveals a bug in (some versions) BSD diff
Date: Fri, 12 Aug 2005 08:46:09 -0700
Message-ID: <7vd5ojxiny.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508121424500.24891@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 17:48:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3bja-0000Zv-Fp
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 17:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVHLPqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 11:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVHLPqM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 11:46:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62877 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932209AbVHLPqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 11:46:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812154611.SVOX7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 11:46:11 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Note the missing "\ No newline at end of file". The same happens on 
> sourceforge's compile farm's OS 10.1 server, but not on its OS 10.2 
> server.
>
> How to go about that? Silently ignore the missing line in apply.c? Force 
> users to update their diff to a sane version?

Hmph.  We could tackle this two ways.  We probably _could_
special case the trailing newline case if this problem is
widespread, but a more general solution would be to teach
git-apply '--fuzz'.  On the other hand, we could configure to
use gdiff (or whatever GNU diff is called on those hosts with
broken diff command) at the build time.  Probably it would be
the bast to have an explicit option --fuzz to git-apply.
