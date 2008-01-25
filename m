From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 00:21:16 -0500
Message-ID: <87fxwmv5tf.fsf@jbms.ath.cx>
References: <alpine.LFD.1.00.0801230922190.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 07:07:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIHj9-0007Xx-Q9
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 07:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYAYGHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 01:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYAYGHR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 01:07:17 -0500
Received: from deleuze.hcoop.net ([69.90.123.67]:56980 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbYAYGHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 01:07:15 -0500
X-Greylist: delayed 2754 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2008 01:07:15 EST
Received: from c-67-165-107-197.hsd1.pa.comcast.net ([67.165.107.197] helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1JIH0A-0007Xu-16; Fri, 25 Jan 2008 00:21:18 -0500
In-Reply-To: <alpine.LFD.1.00.0801230922190.1741@woody.linux-foundation.org>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71682>

Linus Torvalds wrote:
[snip]
> So what you can do (and I'd argue that we do) is to have a hash that can 
> handle almost arbitrary input, but then never corrupt the filename, and 
> always compare exactly by default.

In general, there may be a large number of comparison function options
that git will eventually support, and they will likely not all form a
single chain of increasing "strictness".

Given that the hash values aren't even being stored on disk (and if they
were, a simple approach of also storing an identifier for the hash
function to know whether they stored values are still valid could be
used), having a chain of increasingly "strict" comparison functions and
using a hash function that corresponds to the least strict one is useful
for exactly one reason: giving (possibly several different levels of)
non-fatal warnings for various types of duplicates.

But since multiple hash functions will be needed anyway to support
different notions of case-insensitivity, if the warning is not enabled,
there is no reason to use a case-insensitive hash function with a
byte-exact comparison.

-- 
Jeremy Maitin-Shepard
