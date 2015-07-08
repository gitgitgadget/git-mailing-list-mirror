From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 1/7] refs.c: add err arguments to reflog functions
Date: Wed, 08 Jul 2015 12:59:13 +0200
Message-ID: <559D0281.6040908@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>	 <1435609076-8592-2-git-send-email-dturner@twopensource.com>	 <559AA490.3080605@alum.mit.edu> <1436308882.5521.15.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 12:59:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCn4d-0002hv-9a
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbbGHK71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 06:59:27 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64318 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758232AbbGHK7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 06:59:24 -0400
X-AuditID: 12074412-f79a76d000007c8b-a3-559d0283c8a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 71.4D.31883.3820D955; Wed,  8 Jul 2015 06:59:15 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0310.dip0.t-ipconnect.de [93.219.3.16])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t68AxDK6002667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jul 2015 06:59:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436308882.5521.15.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1G1mmhtqcGGtmsX8TScYLbqudDNZ
	/JtQ48DssWBTqceC5/fZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzuiYcY+poEOw4tKOBWwNjJd5
	uxg5OSQETCRePOhmhLDFJC7cW8/WxcjFISRwmVGio+UzlHOGSeLd1iMsIFW8AtoS2xc/Ywex
	WQRUJdreHgOLswnoSizqaWbqYuTgEBUIknj9MheiXFDi5MwnYCUiQK2zj/SwgtjMAnYSXfuX
	sIKUCwt4Sqw5YAWx6iKjxMTzW5lBajgFLCT2P9rCAlGvLvFn3iVmCFteonnrbOYJjAKzkKyY
	haRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCAldoB+P6k3KH
	GAU4GJV4eD9EzgkVYk0sK67MPcQoycGkJMob9wgoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3
	1wWgHG9KYmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwMB4eSBK8B49xQIcGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQpMYXA2MVJMUDtDcUpJ23uCAxFygK0XqKUVFK
	nNcZJCEAksgozYMbC0tHrxjFgb4U5s0CqeIBpjK47ldAg5mABi/XnQUyuCQRISXVwDhx7Qa+
	OVzn1jA/yI389kap4JX3j9lfXL5ErvMyF/jv89bv/tWt3nqdhuZb4rV/Xauc5qAfzrWFYT7j
	wQtpfKYWfn0eWl9fFNffWfLUWS6rislIt2PKipeKro0+gg3TZCu9DJRV428dTLzN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273668>

On 07/08/2015 12:41 AM, David Turner wrote:
> On Mon, 2015-07-06 at 17:53 +0200, Michael Haggerty wrote:
>> On 06/29/2015 10:17 PM, David Turner wrote:
>>> [...]
>>> @@ -3317,7 +3322,8 @@ static int commit_ref_update(struct ref_lock *lock,
>>>  					      head_sha1, &head_flag);
>>>  		if (head_ref && (head_flag & REF_ISSYMREF) &&
>>>  		    !strcmp(head_ref, lock->ref_name))
>>> -			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg);
>>> +			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg,
>>> +				      err);
>>
>> Here you don't check for errors from log_ref_write(). So it might or
>> might not have written something to err. If it has, is that error
>> handled correctly?
> 
> That was the case before this patch too. But I guess I might as well
> check.

This isn't about fixing a pre-existing bug. Your patch introduced a
regression.

Before this patch, commit_ref_update() didn't really need to know
whether log_ref_write() failed, because it didn't take any further
remedial action anyway. log_ref_write() would have already written an
error message to stderr, and that was all the error handling that was
needed.

But now, log_ref_write() *doesn't* write its error message to stderr; it
only stores it to `err`. So now it is the caller's responsibility to
check whether there was an error, and if so write `err` to stderr.
Otherwise the error message will get lost entirely, I think.

I think your v7 of this patch goes too far, by turning a failure to
write to the reflog into a failure of the whole transaction. The problem
is that this failure comes too late, in the commit phase of the
transaction. Aborting at this late stage can leave some references
changed and others rolled back, violating the promise of atomicity.

The old code reported a failure to write the reflog to stderr but didn't
fail the transaction. I think that behavior is more appropriate. The
reflog is of lower importance than the references themselves. Junio, do
you agree?

If so, it might be that adding err arguments to the reflog functions
does not bring any benefits.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
