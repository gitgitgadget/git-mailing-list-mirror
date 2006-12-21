From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Define -D__BSD_VISIBLE for FreeBSD
Date: Thu, 21 Dec 2006 01:26:56 -0800
Message-ID: <7vk60lbnvj.fsf@assigned-by-dhcp.cox.net>
References: <11666916581935-git-send-email-pdmef@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 10:27:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxKCg-0005TI-1M
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWLUJ1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWLUJ1B
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:27:01 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60428 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965174AbWLUJ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:27:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221092657.OSZR2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 04:26:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1MSF1W00D1kojtg0000000; Thu, 21 Dec 2006 04:26:15 -0500
To: Rocco Rutte <pdmef@gmx.net>
In-Reply-To: <11666916581935-git-send-email-pdmef@gmx.net> (Rocco Rutte's
	message of "Thu, 21 Dec 2006 09:00:58 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35041>

Rocco Rutte <pdmef@gmx.net> writes:

> FreeBSD (6-STABLE) "hides" many declarations (like fchmod(), IPPROTO_IPV6,
> etc.) within '#ifdef __BSD_VISIBLE' blocks. Without this flag, compilation
> will produce lots of warnings and will even fail to compile daemon.c
> since IPPROTO_IPV6 isn't available without it.

I've looked at OpenBSD header files and my impression was that
the symbol __BSD_VISIBLE was pretty much internal to the
implementation, and the programs are not expected to set it
except by defining more public feature macros, such as
_BSD_SOURCE.  So I feel a bit uneasy about your approach.

We've changed this exact area quite heavily during the last
24-hours (not in Makefile but in git-compat-util.h).  Do you
see the problem with the latest 'master'?
