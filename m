From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Wed, 14 Jun 2006 13:04:43 -0700
Message-ID: <7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 22:05:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqbbm-0006Va-9T
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 22:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWFNUEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 16:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWFNUEp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 16:04:45 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43479 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750884AbWFNUEp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 16:04:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060614200444.QUYC554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Jun 2006 16:04:44 -0400
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <0J0V00LDT7B9BU00@mxout2.netvision.net.il> (Yakov Lerner's
	message of "Wed, 14 Jun 2006 22:26 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21858>

Yakov Lerner <iler.ml@gmail.com> writes:

> Many times, I mistakenly used 'make prefix=... install' where prefix value
> was different from prefix value during build. This resulted in broken
> install. This patch adds auto-detection of $prefix change to the Makefile.
> This results in correct install whenever prefix is changed.
>
> Signed-off-by: Yakov Lerner <iler.ml@gmail.com>

I do not mind this per se, and probably even agree that this is
an improvement compared to the current state of affairs, but a few
points:

 - please make sure you clean that state file in "make clean";

 - we may want to make the state file a bit more visible (IOW, I
   somewhat do mind the name being dot-git-dot-prefix).

 - we might want to later (or at the same time as this patch)
   do "consistent set of compilation flags" (e.g. run early
   part of compilation with openssl SHA-1 implementation,
   interrupt it and build and link the rest with mozilla SHA-1
   implementation -- then you will get a nonsense binary without
   linker errors).  It might make sense to prepare this
   mechanism so we could reuse it for that purpose.
