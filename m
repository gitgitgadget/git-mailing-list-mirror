From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
 characters
Date: Fri, 18 Jan 2008 11:01:56 +0100
Message-ID: <47907914.6000105@viscovery.net>
References: <20080117153252.GD2816@coredump.intra.peff.net> <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net> <47905F70.5090003@viscovery.net> <4790746D.1000502@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFo3Z-0006KH-8Z
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbYARKCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 05:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbYARKCE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:02:04 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17399 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbYARKCB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:02:01 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFo2o-0000vI-JH; Fri, 18 Jan 2008 11:01:51 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8703569F; Fri, 18 Jan 2008 11:01:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4790746D.1000502@users.sourceforge.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70987>

Adam Piatyszek schrieb:
> * Johannes Sixt [18 I 2008 09:12]:
>> Is it good to die() in this situation? If you are sending a patch series
>> and one patch in the middle triggers this condition, then only half of
>> the
>> series is sent. Maybe it would be better to warn here only, collect file
>> names of the suspects, send the patch nevertheless, and write a
>> summary at
>> the end?

> IMHO it does not make much sense to send such patches nevertheless, if
> we are sure that they will be broken after SMTP transfer. Such a
> situation is similar to spamming. And sending only the ones that can be
> sent is not an option as well.

You are right here. My thought was that even though the recipient gets a
broken patch, he would be able to fix it up. This may be acceptable for
peer-to-peer communication, but not for a development style that involves
many recipients.

Then git-format-patch and log-family with --pretty=email -p could warn
about these candidates-to-be-broken patches.

-- Hannes
