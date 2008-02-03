From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sun, 03 Feb 2008 02:50:14 -0800
Message-ID: <7vbq6yuxeh.fsf@gitster.siamese.dyndns.org>
References: <12019685081997-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 11:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLcR8-0003yX-Gm
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbYBCKu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 05:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753855AbYBCKu0
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:50:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYBCKuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:50:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E42105B75;
	Sun,  3 Feb 2008 05:50:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 70E2C5B74;
	Sun,  3 Feb 2008 05:50:21 -0500 (EST)
In-Reply-To: <12019685081997-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sat, 2 Feb 2008 17:08:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72349>

Steffen Prohaska <prohaska@zib.de> writes:

> CRLF conversion bears a slight chance of corrupting data.
> ...
> thing to do, while for binary file it corrupts data.

The above 25-line or so are well written and deserve to be in
the end user documentation somewhere, I think, to explain why it
is a good idea to have these warnings to them..

> This commit modifies git apply to fail even if safecrlf=warn,
> because git apply writes its changes back to the work tree
> immediately.  The user would not have a chance to backup the old
> version of the file if only a warning was printed.

I do not get this logic at all.

The whole point of git-apply is to apply the patch.  If you say
--whitespace=fix and some contents (say one of the testsuite
files in our t/ directory) needed to keep trailing newline, you
obviously are left with a broken result, and you would recover
by checking it out from index or HEAD and reapply.  Why
shouldn't the same principle hold here?

I haven't looked at the code of this round yet, but I promise I
will.
