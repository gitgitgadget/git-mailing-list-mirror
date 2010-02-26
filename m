From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Fri, 26 Feb 2010 10:32:31 +0100
Message-ID: <4B87952F.1000902@viscovery.net>
References: <1267143154-5020-1-git-send-email-lznuaa@gmail.com> <4B87797D.7030905@viscovery.net> <7vr5o84erv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:32:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkwYw-0002Y3-6h
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 10:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935708Ab0BZJcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 04:32:39 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8453 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935611Ab0BZJch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 04:32:37 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NkwYi-0004ss-6J; Fri, 26 Feb 2010 10:32:32 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E24F71660F;
	Fri, 26 Feb 2010 10:32:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vr5o84erv.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141116>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> OTOH, it may be worthwhile to set
>>
>> 		pass.use_shell = 1;
>>
>> to allow commands that are not just a single plain word. But perhaps this
>> has security implications - I don't know.
> 
> How does SSH_ASKPASS gets interpreted by other programs?  I think we
> should follow that example.

openssh treats SSH_ASKPASS as a command name and uses execlp, i.e., does a
PATH search; no shell tricks are possible. Hence, we should *not* set
use_shell.

http://www.openbsd.org/cgi-bin/cvsweb/src/usr.bin/ssh/readpass.c?rev=1.47

Of course, we could define that GIT_ASKPASS is different from SSH_ASKPASS
in this regard, but I haven't followed the discussion to know whether this
is necessary.

-- Hannes
