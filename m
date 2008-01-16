From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] treat any file with NUL as binary
Date: Tue, 15 Jan 2008 17:21:41 -0800
Message-ID: <7vr6gibm56.fsf@gitster.siamese.dyndns.org>
References: <1200407309-10992-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwz6-000844-Ku
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYAPBV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbYAPBV7
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:21:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYAPBV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:21:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3554312AF;
	Tue, 15 Jan 2008 20:21:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C55F12AD;
	Tue, 15 Jan 2008 20:21:53 -0500 (EST)
In-Reply-To: <1200407309-10992-1-git-send-email-dpotapov@gmail.com> (Dmitry
	Potapov's message of "Tue, 15 Jan 2008 17:28:29 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70593>

Dmitry Potapov <dpotapov@gmail.com> writes:

> There are two heuristics in Git to detect whether a file is binary
> or text. One in xdiff-interface.c relied on existing NUL byte at

"relies on" (not past tense); we may want to say that it is
stolen from GNU diff to be compatible.

> the beginning. However, convert.c used a different heuristic, which
> relied that the number of non-printable symbols is less than 1%.
>
> Due to difference in approaches whether a file is binary or not,
> it was possible that a file that diff treats as binary will not be
> treated as text by CRLF conversation. This is very confusing for

"conversion".

> a user who seeing that 'git diff' shows file as binary expects it

"sees".

> to be added as binary.
>
> This patch makes is_binary to consider any file that contains at
> least one NUL character as binary.
> ---
>
> So, please, consider it for inclusion as a bug fix.

Please typofix and apply "s/.$/, to ensure that the heuristics
used for CRLF conversion is tighter than what is used by diff./"
or something like that at the end.

Also please add sign-off.  The patch looks correct.
