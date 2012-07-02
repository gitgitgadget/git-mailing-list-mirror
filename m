From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Tue, 03 Jul 2012 00:43:42 +0200
Message-ID: <m2vci5n5r5.fsf@igel.home>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
	<20120702215736.GA5790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 00:43:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpLU-0001De-TO
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab2GBWnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:43:47 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36445 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab2GBWnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:43:46 -0400
Received: from frontend4.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WR3Rf2v4fz3hhXB;
	Tue,  3 Jul 2012 00:44:14 +0200 (CEST)
Received: from igel.home (ppp-88-217-119-150.dynamic.mnet-online.de [88.217.119.150])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WR3R30S7pzbbrW;
	Tue,  3 Jul 2012 00:43:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B0CB0CA2A4; Tue,  3 Jul 2012 00:43:42 +0200 (CEST)
X-Yow: I need to discuss BUY-BACK PROVISIONS with at least
 six studio SLEAZEBALLS!!
In-Reply-To: <20120702215736.GA5790@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Jul 2012 17:57:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200888>

Jeff King <peff@peff.net> writes:

> It's very odd for pread to report ENOENT (since it is always operating
> on an already-opened file descriptor).

It doesn't, but gettext will clobber errno:

		n = pread(pack_fd, inbuf, n, from);
		if (n < 0)
			die_errno(_("cannot pread pack file"));

There is nothing that saves errno.  This isn't limited to i18n though,
any function call in the arguments may potentially clobber errno.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
