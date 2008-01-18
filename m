From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
 characters
Date: Fri, 18 Jan 2008 11:37:04 +0100
Message-ID: <47908150.9040201@users.sourceforge.net>
References: <20080117153252.GD2816@coredump.intra.peff.net>	<1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>	<47905F70.5090003@viscovery.net>	<4790746D.1000502@users.sourceforge.net>	<47907914.6000105@viscovery.net> <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:51:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFooi-0006UL-LI
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYARKut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 05:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbYARKut
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:50:49 -0500
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:42108 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYARKus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:50:48 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0IAe2WM017168;
	Fri, 18 Jan 2008 11:40:03 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.77] (pc1077.et.put.poznan.pl [150.254.11.77])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0IAb5D00934;
	Fri, 18 Jan 2008 11:37:05 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.9.11357
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70994>

* Junio C Hamano [18 I 2008 11:08]:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> Then git-format-patch and log-family with --pretty=email -p could warn
>> about these candidates-to-be-broken patches.
> 
> I'd rather not, unless it is explicitly asked for by a separate
> command line option.  Transferring over SMTP is not the only
> (nor even primary) use of format-patch output.

Agree.

> On the other hand, git-send-email _is_ all about SMTP transfer.
> Perhaps a loop over input files upfront to check the line length
> limit, and warn if there are suspiciously long lines even before
> sending the first piece of e-mail out, would be a reasonable
> approach.

But what next? Still send the problematic patches not encoded?

In my opinion, it is more reasonable to provide an optional encoding of 
such patches. And only throw a warning message that some of the patches 
had to be encoded. Then, we would not need an extra loop over all patches.

As git-send-email _is_ all about SMTP transfer, we should be interested 
that the stuff we transfer is sent correctly.

/Adam

-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
