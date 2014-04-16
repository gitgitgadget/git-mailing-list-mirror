From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Wed, 16 Apr 2014 12:31:55 +0100
Message-ID: <534E6A2B.5060903@ramsay1.demon.co.uk>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com> <534985F3.6060501@ramsay1.demon.co.uk> <xmqqeh0ylext.fsf@gitster.dls.corp.google.com> <CACsJy8C_WU_-73+VF0KV1X1BLDSWH_C35jPjMcrjR2OW3s9z-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 13:32:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaO4W-0005aR-JH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 13:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbaDPLcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 07:32:01 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:52989 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755575AbaDPLcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 07:32:00 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 7F517400EB6;
	Wed, 16 Apr 2014 12:31:57 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 2B57A400E8A;
	Wed, 16 Apr 2014 12:31:57 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Wed, 16 Apr 2014 12:31:56 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CACsJy8C_WU_-73+VF0KV1X1BLDSWH_C35jPjMcrjR2OW3s9z-Q@mail.gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246330>

On 16/04/14 00:18, Duy Nguyen wrote:
> On Tue, Apr 15, 2014 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> On 11/04/14 23:22, Junio C Hamano wrote:
>>> [...]
>>>> [New Topics]
>>>>
>>>> * nd/index-pack-one-fd-per-thread (2014-04-09) 1 commit
>>>>  - index-pack: work around thread-unsafe pread()
>>>>
>>>>  Enable threaded index-pack on platforms without thread-unsafe
>>>>  pread() emulation.
>>>>
>>>>  Will merge to 'next' and keep it there for the remainder of the cycle.
>>>
>>> The commit message for commit 512ebe5d ("index-pack: work around
>>> thread-unsafe pread()", 25-03-2014) is a little misleading.
>>
>> OK.  Can we have a concrete alternative?
>>
>>     Multi-threaing of index-pack was disabled with c0f8654
>>     (index-pack: Disable threading on cygwin - 2012-06-26), because
>>     pread() implementations for Cygwin and MSYS were not thread
>>     safe.  Recent Cygwin does offer usable pread() and we enabled
>>     multi-threading with 103d530f (Cygwin 1.7 has thread-safe pread,
>>     2013-07-19).
>>
>>     Work around this problem on platforms with a thread-unsafe
>>     pread() emulation by opening one file handle per thread; it
>>     would prevent parallel pread() on different file handles from
>>     stepping on each other.
>>
>>     Also remove NO_THREAD_SAFE_PREAD that was introduced in c0f8654
>>     because it's no longer used anywhere.
>>
>>     This workaround is unconditional, even for platforms with
>>     thread-safe pread() because the overhead is small (a couple file
>>     handles more) and not worth fragmenting the code.
>>
> 
> OK to me.


Yep, this looks good to me too.

Thanks!

ATB,
Ramsay Jones
