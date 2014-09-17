From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 05/35] rollback_lock_file(): set fd to -1
Date: Wed, 17 Sep 2014 17:02:49 +0200
Message-ID: <5419A299.2010700@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-6-git-send-email-mhagger@alum.mit.edu> <20140916203852.GE29050@google.com> <20140916203957.GF29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 17:03:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUGl1-000621-FW
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 17:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbaIQPCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 11:02:55 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58346 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754363AbaIQPCy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2014 11:02:54 -0400
X-AuditID: 12074414-f79446d000001f1d-1f-5419a29df6fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 69.82.07965.D92A9145; Wed, 17 Sep 2014 11:02:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C15.dip0.t-ipconnect.de [93.219.28.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8HF2na7019148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 17 Sep 2014 11:02:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916203957.GF29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsUixO6iqDt3kWSIwdujohZdV7qZLBp6rzBb
	PJl7l9ni7c0ljBY/WnqYLf5NqLHo7PjK6MDusXPWXXaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdMXdXecFvloqT5y+zNTC+ZO5i5OSQEDCR2HNkOTuE
	LSZx4d56ti5GLg4hgcuMEo+bW1khnHNMEnMfzGMEqeIV0JY4uPoRmM0ioCqx7sJKMJtNQFdi
	UU8zE4gtKhAg8aHzAVS9oMTJmU9YQGwRAQ2J55++gW1gFvjIKDH3+klWkISwgINE88y9zBDb
	jjJKLNy+HWwSp4CBxOq1EJOYBfQkdlz/xQphy0tsfzuHeQKjwCwkS2YhKZuFpGwBI/MqRrnE
	nNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJBYENnBeOSk3CFGAQ5GJR7eiIsSIUKs
	iWXFlbmHGCU5mJREeQ/OlgwR4kvKT6nMSCzOiC8qzUktPsQowcGsJML7vh0ox5uSWFmVWpQP
	k5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwftmIVCjYFFqempFWmZOCUKaiYMTZDiX
	lEhxal5KalFiaUlGPCha44uB8QqS4gHaOwmknbe4IDEXKArReorRmKOl6W0vE8e6zm/9TEIs
	efl5qVLivEdBSgVASjNK8+AWwZLgK0ZxoL+FeV+DVPEAEyjcvFdAq5iAVp3tEQNZVZKIkJJq
	YGTXW9Z58MG08ruyUw0fi+4LOKjOubHc9F1V7L6H/SFy137n9dRMVTue+kIh8XHc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257223>

On 09/16/2014 10:39 PM, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>> Michael Haggerty wrote:
> 
>>> --- a/lockfile.c
>>> +++ b/lockfile.c
>>> @@ -276,7 +276,7 @@ void rollback_lock_file(struct lock_file *lk)
>>>  		return;
>>>  
>>>  	if (lk->fd >= 0)
>>> -		close(lk->fd);
>>> +		close_lock_file(lk);
>>
>> Doesn't need to be guarded by the 'if'.
> 
> Err, yes it does.
> 
> Why doesn't close_lock_file bail out early when fd < 0?

OK, I will change close_lock_file() to exit (with no error) when fd < 0.
Then this "if" can also go away.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
