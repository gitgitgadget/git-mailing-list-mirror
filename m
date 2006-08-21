From: Junio C Hamano <junkio@cox.net>
Subject: Re: non-monotonic index when using http://?
Date: Mon, 21 Aug 2006 03:08:55 -0700
Message-ID: <7v1wrawgco.fsf@assigned-by-dhcp.cox.net>
References: <20060821084606.GI30022@admingilde.org>
	<7v64gmwil5.fsf@assigned-by-dhcp.cox.net>
	<20060821095419.GK30022@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 12:09:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF6iN-0000Cz-KF
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 12:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWHUKI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 06:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWHUKI7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 06:08:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:7669 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751839AbWHUKI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 06:08:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060821100856.FAYK6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Aug 2006 06:08:56 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060821095419.GK30022@admingilde.org> (Martin Waitz's message
	of "Mon, 21 Aug 2006 11:54:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25792>

Martin Waitz <tali@admingilde.org> writes:

> For some reason, I have a
> .git/objects/pack/pack-793a9e93286d6c656941977d2e5b49e28566edcd.idx
> without the corresponding .pack file.

It is worrysome why.  In the meantime you could remove it (if it
were a .pack file without .idx then you may want to try feeding
it to unpack-objects but .idx without corresponding .pack is
pretty much useless).

> At least, it should not SEGV later...

Absolutely.  The particular code in http-fetch (your gdb session
tells us exactly where) seems quite loosely written, and there
may be other places that do not check return values.
