From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Wed, 25 Jan 2012 08:12:01 +0100
Message-ID: <op.v8moybu10aolir@keputer>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
 <20120124232421.GH8222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 08:12:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpx1g-0001e6-F3
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 08:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab2AYHMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 02:12:06 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57674 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2AYHMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 02:12:05 -0500
Received: by eekc14 with SMTP id c14so2488245eek.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 23:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=rbUEa7C8OIkr5Gn+BggOguOScFMa2G89au8sothr4QY=;
        b=tq+u5Wz6h74sQrGQiXVrjnoJFfPjHqAp/F2ZWrla6911Xsfr6XKJjuP7mfp8OIvU7z
         /oSvwTGtNcMkGHsUKDywjM3pS6/1UuqDBwut3/QTYFZVkdHA773TK8B7q5gqR0STRpgn
         LChBSiavjs5wHKADHHWojo4rHYApjVosJXxoc=
Received: by 10.14.9.155 with SMTP id 27mr5510355eet.75.1327475523931;
        Tue, 24 Jan 2012 23:12:03 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id y54sm14305134eef.8.2012.01.24.23.12.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 23:12:03 -0800 (PST)
In-Reply-To: <20120124232421.GH8222@burratino>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189102>

On Wed, 25 Jan 2012 00:24:21 +0100, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

> Frans Klaver wrote:
>
>> --- a/t/t0061-run-command.sh
>> +++ b/t/t0061-run-command.sh
>> @@ -76,12 +76,12 @@ test_expect_success POSIXPERM 'run_command reports  
>> EACCES, interpreter fails' '
>>  	grep "bad interpreter" err
>>  '
>>
>> -test_expect_failure POSIXPERM 'run_command reports ENOENT,  
>> interpreter' '
>> +test_expect_success POSIXPERM 'run_command reports ENOENT,  
>> interpreter' '
>>  	cat non-existing-interpreter >hello.sh &&
>>  	chmod +x hello.sh &&
>>  	test_must_fail test-run-command start-command-ENOENT ./hello.sh 2>err  
>> &&
>>
>> -	grep "error: cannot exec.*hello.sh" err &&
>> +	grep "fatal: cannot exec.*hello.sh" err &&
>
> Thanks.  I'd suggest using "test_expect_code" rather than the detailed
> wording of the message, since that is what scripts might want to rely
> on.

OK, makes sense.


> What happens on Windows?

I didn't plan anything to happen on windows. Doesn't POSIXPERM rule that  
OS out? I guess it could use similar code to this patch series to tackle  
all this.
