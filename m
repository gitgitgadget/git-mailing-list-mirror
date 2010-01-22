From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/4] misc. msvc patches
Date: Fri, 22 Jan 2010 19:28:31 +0000
Message-ID: <4B59FC5F.8010901@ramsay1.demon.co.uk>
References: <4B57573E.2050006@ramsay1.demon.co.uk> <7vmy081okq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 21:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYPlZ-0004AQ-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 21:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0AVUFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 15:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282Ab0AVUFp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 15:05:45 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:58790 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752710Ab0AVUFo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 15:05:44 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NYPlH-0003W8-d6; Fri, 22 Jan 2010 20:05:43 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vmy081okq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137778>

Junio C Hamano wrote:
> I only looked at regex/regex.c and it really is a real bugfix as the
> structure fields are of pointer type ;-).

Hmmm, well ... I would call it a typo fixup rather than a bugfix, since
(luckily) there is no actual bug here.

The expression on the rhs of the assignment is a valid null pointer
expression; since regoff_t is an alias for int the expression amounts
to '(int) 0', so the cast is a no-op and is equivalent to an "integer
constant with value zero". In C, an "integer constant with value zero
(or any such constant cast to void *)" is a null pointer constant.
(Many people wish it wasn't...)

Having said that, I would be *very* surprised if the original author
had intended to type anything other than '(regoff_t *) 0'. Hence I
suspect this is a typo.

[Hmm, I haven't actually looked at the assembler to check that the
generated object code is correct, but not even msvc could get this
wrong ... :-P ]

ATB,
Ramsay Jones
