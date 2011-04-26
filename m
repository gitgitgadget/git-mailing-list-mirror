From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] run-command.c: Fix unused variables warning with gcc
 4.6
Date: Tue, 26 Apr 2011 15:27:22 +0200
Message-ID: <4DB6C83A.4040900@elegosoft.com>
References: <4DB6BA5E.3040306@elegosoft.com> <4DB6C501.6000705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 15:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEiIe-0005el-En
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 15:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab1DZN11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 09:27:27 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:54946 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab1DZN10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 09:27:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 14A0FDE7F7;
	Tue, 26 Apr 2011 15:27:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljf-ijfgUw4u; Tue, 26 Apr 2011 15:27:21 +0200 (CEST)
Received: from [10.10.10.226] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 40E54DE7EE;
	Tue, 26 Apr 2011 15:27:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Lanikai/3.1.9
In-Reply-To: <4DB6C501.6000705@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172094>

On 04/26/2011 03:13 PM, Michael J Gruber wrote:
> Michael Schubert venit, vidit, dixit 26.04.2011 14:28:
>> As of gcc 4.6 -Wall includes -Wunused-but-set-variable. Remove all
>> unused variables to prevent those warnings.
>>
>> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
>> ---
>>  run-command.c |   10 ++++------
>>  1 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index f91e446..6e0be54 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -67,21 +67,19 @@ static int child_notifier = -1;
>>
>>  static void notify_parent(void)
>>  {
>> -	ssize_t unused;
>> -	unused = write(child_notifier, "", 1);
>> +	write(child_notifier, "", 1);
>>  }
>>
>>  static NORETURN void die_child(const char *err, va_list params)
>>  {
>>  	char msg[4096];
>> -	ssize_t unused;
>>  	int len = vsnprintf(msg, sizeof(msg), err, params);
>>  	if (len > sizeof(msg))
>>  		len = sizeof(msg);
>>
>> -	unused = write(child_err, "fatal: ", 7);
>> -	unused = write(child_err, msg, len);
>> -	unused = write(child_err, "\n", 1);
>> +	write(child_err, "fatal: ", 7);
>> +	write(child_err, msg, len);
>> +	write(child_err, "\n", 1);
>>  	exit(128);
>>  }
>>  #endif
> 
> git log -S"unused" origin/master run-command.c
> 
> shows that these dummies were introduced for a reason. How do you
> invalidate that?

Sorry, just missed that.
