From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: Add simplified merge sort implementation from glibc
Date: Sat, 02 Feb 2008 22:22:44 -0800
Message-ID: <7v1w7u1ruz.fsf@gitster.siamese.dyndns.org>
References: <20080203011130.GK26392@lavos.net>
	<alpine.LSU.1.00.0802030231080.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Downing <bdowning@lavos.net>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 07:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLYGG-0007w2-S2
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 07:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbYBCGW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 01:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757537AbYBCGW4
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 01:22:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbYBCGWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 01:22:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E1CA160F8;
	Sun,  3 Feb 2008 01:22:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5936E60F7;
	Sun,  3 Feb 2008 01:22:47 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802030231080.7372@racer.site> (Johannes
	Schindelin's message of "Sun, 3 Feb 2008 02:37:27 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72329>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I would like this to go in, evidently, if only as a starting point for 
> people to play with sorting algorithms, to find the one which is optimal 
> for our general use (we have quite some uses where we put in _almost_ 
> sorted data, which seems to be the worst-case for many sorting 
> algorithms).

I do not think we want to spend arguing over the last few
percent to get anything ultra-fast.  The aim for compat/ is to
have a replacement for unusable platform-supplied stuff.

The patch looked fine, thanks.

If I may add a bikeshed comment, I probably would have modelled
the make variable, not after ssl-with-crypto and libiconv, but
after {arm,mozilla,ppc}-sha1, if I were naming it.  This is not
like an absolute must-to-have: "on this platform, libc is not
enough and we NEED to explicitly ask for -liconv".  It is more
like a choose-to-use: "we could use openssl sha1 implementation,
but I choose to use Mozilla one".
