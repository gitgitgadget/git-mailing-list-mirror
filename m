From: Romain Francoise <romain@orebokech.com>
Subject: Re: [PATCH] mailmap: avoid out-of-bounds memory access
Date: Sun, 28 Oct 2012 14:21:33 +0100
Organization: orebokech dot com
Message-ID: <87k3ua3f6q.fsf@silenus.orebokech.com>
References: <87k3ub4jjg.fsf@silenus.orebokech.com>
	<20121028110207.GA11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 14:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSSoN-0007WO-ES
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 14:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab2J1NVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 09:21:35 -0400
Received: from stringer.orebokech.com ([88.190.240.207]:60541 "EHLO
	stringer.orebokech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab2J1NVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 09:21:35 -0400
Received: from silenus.orebokech.com (silenus [192.168.1.4])
	by stringer.orebokech.com (Postfix) with ESMTP id E44FA1880033;
	Sun, 28 Oct 2012 14:21:33 +0100 (CET)
Received: by silenus.orebokech.com (Postfix, from userid 1000)
	id A12D9A034C; Sun, 28 Oct 2012 14:21:33 +0100 (CET)
In-Reply-To: <20121028110207.GA11434@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 28 Oct 2012 07:02:07 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208544>

Jeff King <peff@peff.net> writes:

> So you could also check for "left == nstart" before the loop even
> begins. I think your fix (to just make the loop more robust to that
> precondition) is better, though, as the rest of the code does the right
> thing with such a value of nend.

Yep.

> It looks like t4203 triggers this problem. Curious that valgrind does
> not find it. I guess since it does not have compiler support, it cannot
> find out-of-bound errors on stack buffers. Does the rest of the test
> suite turn up clean with AddressSanitizer?

I tested your 'master' and your 'pu' with expensive tests enabled and both
are clean after fixing t4203.

Thanks!
