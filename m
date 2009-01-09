From: Andre Przywara <andre.przywara@amd.com>
Subject: Re: [PATCH] allow 8bit data in email body sent by send-email
Date: Fri, 9 Jan 2009 15:16:24 +0100
Message-ID: <49675C38.8060208@amd.com>
References: <20090109072814.GA21180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andre Przywara <andre.przywara@amd.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 15:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLIOs-0003UU-Ef
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 15:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbZAIOa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 09:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZAIOa0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 09:30:26 -0500
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:31869 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752622AbZAIOaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jan 2009 09:30:25 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jan 2009 09:30:25 EST
Received: from mail118-tx2-R.bigfish.com (10.9.14.250) by
 TX2EHSOBE004.bigfish.com (10.9.40.24) with Microsoft SMTP Server id
 8.1.291.1; Fri, 9 Jan 2009 14:15:22 +0000
Received: from mail118-tx2 (localhost.localdomain [127.0.0.1])	by
 mail118-tx2-R.bigfish.com (Postfix) with ESMTP id 271C61B20159;	Fri,  9 Jan
 2009 14:15:22 +0000 (UTC)
X-BigFish: VPS-57(zz1432R98dRaf6W936eQ1805M3117K9fePzzzzz32i6bh43j)
Received: by mail118-tx2 (MessageSwitch) id 1231510517411095_27399; Fri,  9
 Jan 2009 14:15:17 +0000 (UCT)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])	(using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate
 requested)	by mail118-tx2.bigfish.com (Postfix) with ESMTP id 32E451A60052;
	Fri,  9 Jan 2009 14:15:17 +0000 (UTC)
Received: from ausb3twp01.amd.com ([163.181.250.37])	by
 ausb3extmailp01.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 n09EF9e5001918;	Fri, 9 Jan 2009 08:15:12 -0600
X-WSS-ID: 0KD7JL5-01-GEZ-01
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2399049C010;
	Fri,  9 Jan 2009 08:15:05 -0600 (CST)
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Fri, 9 Jan 2009 08:15:11 -0600
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Fri, 9 Jan 2009 08:15:11 -0600
Received: from [165.204.85.38] ([165.204.85.38]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Fri, 9 Jan 2009 15:15:08 +0100
User-Agent: Thunderbird 2.0.0.14 (X11/20080508)
In-Reply-To: <20090109072814.GA21180@coredump.intra.peff.net>
X-OriginalArrivalTime: 09 Jan 2009 14:15:08.0772 (UTC) FILETIME=[AD5E8A40:01C97264]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105014>

Jeff King wrote:
>> when sending patch files via git send-email, the perl script assumes
>> 7bit characters only. If there are other bytes in the body (foreign language
>> characters in names or translations), some servers (like vger.kernel.org)
>> reject the mail because of th?t. This patch always adds an 8bit header line
>> to each mail.
> 
> This should be done already by git-format-patch when you generate the
> patch to feed to send-email.
Well, this could be discussed, after all the problem lies in the actual 
transportation, which should be the responsibility of git-send-email. 
But I am OK with putting this into format-patch.
 > What exactly is the workflow you use to generate this problem?
I use git format-patch to generate a patch file for a single-mail patch 
(not a patch series). Then I edit this file manually to add questions 
and comments and include my signature. During this step the umlauts came 
in. If you have a suggestion to improve this workflow, I am all ears, I 
am fairly new to git.
> Does it matter where the non-ascii characters are
> (commit versus patch, etc)?
Oh, right you are. If there are 8bit characters in the commit message, 
git-format-patch adds the appropriate headers.
 > What version of git are you using?
Version 1.5.5 on one machine and 1.5.2.2 on another. I know, i know ;-) 
but I haven't had time to compile a newer one, yet.

> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 77ca8fe..68a462c 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -793,6 +793,7 @@ To: $to${ccline}
>>  Subject: $subject
>>  Date: $date
>>  Message-Id: $message_id
>> +Content-Transfer-Encoding: 8bit
>>  X-Mailer: git-send-email $gitversion
>>  ";
> 
> This fix isn't right anyway. For one thing, if you're going to include
> C-T-E, you should also include a MIME-Version header. But more
> importantly, we are already handling encoding elsewhere. So
> unconditionally adding this means that you may conflict with existing
> MIME headers in the @xh variable.

Ok, so what about adding a flag to git-format-patch that forces the 8bit 
headers on? I think a workaround would be to add a --subject-prefix with 
a special character and later remove this, but this is not really a 
long-term solution ;-)

Thanks and regards,
Andre.

-- 
Andre Przywara
AMD-Operating System Research Center (OSRC), Dresden, Germany
Tel: +49 351 277-84917
----to satisfy European Law for business letters:
Advanced Micro Devices GmbH
Karl-Hammerschmidt-Str. 34, 85609 Dornach b. Muenchen
Geschaeftsfuehrer: Jochen Polster; Thomas M. McCoy; Giuliano Meroni
Sitz: Dornach, Gemeinde Aschheim, Landkreis Muenchen
Registergericht Muenchen, HRB Nr. 43632
