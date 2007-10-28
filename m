From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH 5/7] use only the $PATH for exec'ing git commands
Date: Sat, 27 Oct 2007 23:19:52 -0700
Message-ID: <47242A08.3050503@apple.com>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
 <1193474215-6728-2-git-send-email-srp@srparish.net>
 <1193474215-6728-3-git-send-email-srp@srparish.net>
 <1193474215-6728-4-git-send-email-srp@srparish.net>
 <1193474215-6728-5-git-send-email-srp@srparish.net>
 <7vlk9nzrrv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Scott R Parish <srp@srparish.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 07:20:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im1VI-00043Y-4Q
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 07:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbXJ1GTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 02:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXJ1GTz
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 02:19:55 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:51729 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbXJ1GTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 02:19:55 -0400
Received: from relay12.apple.com (relay12.apple.com [17.128.113.53])
	by mail-out3.apple.com (Postfix) with ESMTP id 9A8531688B40
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 23:19:54 -0700 (PDT)
Received: from relay12.apple.com (unknown [127.0.0.1])
	by relay12.apple.com (Symantec Mail Security) with ESMTP id 80C472808D
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 23:19:54 -0700 (PDT)
X-AuditID: 11807135-a591ebb0000018be-94-47242a0a6273
Received: from gertie.apple.com (gertie.apple.com [17.151.62.15])
	by relay12.apple.com (Apple SCV relay) with ESMTP id 6557E2808B
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 23:19:54 -0700 (PDT)
Received: from [10.0.1.198] ([67.160.250.192])
 by ifon.apple.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JQL00MHYYX67I10@ifon.apple.com> for
 git@vger.kernel.org; Sat, 27 Oct 2007 23:19:54 -0700 (PDT)
In-reply-to: <7vlk9nzrrv.fsf@gitster.siamese.dyndns.org>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62525>

Junio C Hamano wrote:
> Scott R Parish <srp@srparish.net> writes:
>
>   
>> diff --git a/exec_cmd.c b/exec_cmd.c
>> index 8b681d0..c228dbf 100644
>> --- a/exec_cmd.c
>> +++ b/exec_cmd.c
>> @@ -29,85 +29,68 @@ const char *git_exec_path(void)
>>  	return builtin_exec_path;
>>  }
>>  
>> +static void add_path(struct strbuf *out, const char *path)
>> +{
>> +	if (path && strlen(path)) {
>>     
>
> I wonder if s/strlen(path)/*path/ micro-optimization is worth
> doing.  Ideally, if built-in strlen() is used, the compiler
> should be clever enough to notice it, though...
>   

You could always just check path[0] instead of calling strlen.

-Adam
