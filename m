From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 09:23:42 +0200
Message-ID: <483E59FE.80707@viscovery.net>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com> <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com> <483E4E3C.90805@viscovery.net> <483E55C1.1000900@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu May 29 09:24:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1cVA-000162-Cn
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 09:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbYE2HXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 03:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYE2HXq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 03:23:46 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15331 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYE2HXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 03:23:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K1cUB-0005Vc-5o; Thu, 29 May 2008 09:23:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EC2F16D9; Thu, 29 May 2008 09:23:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <483E55C1.1000900@trolltech.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83180>

Marius Storm-Olsen schrieb:
> Johannes Sixt said the following on 29.05.2008 08:33:
>> Junio C Hamano schrieb:
>>> This is not meant for application to the mainline.  It allows your
>>> git to
>>> refuse to create a blob whose name is "nul".
>>
>> It's not just about "nul"; these won't work either: "aux", "prn", "con",
>> "com\d+", "lpt\d+", neither do "$one_of_these.$some_extension". And
>> all of
>> that regardless of the case!
>>
>> See http://msdn.microsoft.com/en-us/library/aa365247(VS.85).aspx
>>
>> Definitely, we don't ever want to have such special-casing somewhere
>> in git.
> 
> They _can_ be used by using the UNC notation:
>     \\?\<drive letter>:\<path>\nul
> Do you think we should special-case that, or simply fail?

Rhetoric question: What's so special about those files?

"foo/nul" is a file you don't have permissions to write to. Period. We
should fail the same way as if you had 'chmod a-w foo/nul foo', or as if
there's a bad sector on the disk. Junio's patch series is the way to go
(without 6/5, of course).

-- Hannes
