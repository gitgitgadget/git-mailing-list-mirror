From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 11/12] t5524: test --log=1 limits shortlog length
Date: Thu, 07 May 2015 21:12:58 +0200
Message-ID: <554BB93A.3090000@kdbg.org>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>	<1430988248-18285-12-git-send-email-pyokagan@gmail.com>	<05adfac12cb9a7ad183281974d991e00@www.dscho.org> <CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 21:13:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqREK-0002ul-SV
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 21:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbbEGTNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 15:13:04 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:15106 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751021AbbEGTNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 15:13:02 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3ljPZL4nRkz5tlQ;
	Thu,  7 May 2015 21:12:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 45378524C;
	Thu,  7 May 2015 21:12:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268581>

Am 07.05.2015 um 19:06 schrieb Paul Tan:
> Hi Dscho,
>
> On Fri, May 8, 2015 at 12:28 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Hi Paul,
>>
>> On 2015-05-07 10:44, Paul Tan wrote:
>>> @@ -32,4 +35,18 @@ test_expect_success pull '
>>>   )
>>>   '
>>>
>>> +test_expect_failure '--log=1 limits shortlog length' '
>>> +(
>>> +     cd cloned &&
>>> +     git reset --hard HEAD^ &&
>>> +     test `cat afile` = original &&
>>> +     test `cat bfile` = added &&
>>> +     git pull --log &&
>>> +     git log -3 &&
>>> +     git cat-file commit HEAD >result &&
>>> +     grep Dollar result &&
>>> +     ! grep "second commit" result
>>> +)
>>
>> I think it might be better to use `test_must_fail` here, just for
>> consistency (the `!` operator would also pass if `grep` itself could not
>> be executed correctly, quite academic, I know, given that `grep` is
>> exercised plenty of times by the test suite, but still...)
>>
>> What do you think?
>
> Yep, it's definitely better. Sometimes I forget about the existence of
> some test utility functions :-/.

Nope, it's not better. test_must_fail is explicitly only for git 
invocations. We do not expect 'grep' to segfault or something.

Cf. eg. 
http://thread.gmane.org/gmane.comp.version-control.git/258725/focus=258752

-- Hannes
