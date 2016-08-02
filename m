Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508E12021F
	for <e@80x24.org>; Tue,  2 Aug 2016 23:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbcHBXT4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 19:19:56 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:59038 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756247AbcHBXTy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 19:19:54 -0400
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
	by resqmta-po-07v.sys.comcast.net with SMTP
	id UiqVb70SGqbrLUiqWb1yYT; Tue, 02 Aug 2016 23:11:36 +0000
Received: from mail.gonehiking.org ([73.181.52.62])
	by comcast with SMTP
	id UiqVbDeTMfrcyUiqVb5IQm; Tue, 02 Aug 2016 23:11:36 +0000
Received: from [192.168.1.87] (shuah-xps.internal [192.168.1.87])
	by mail.gonehiking.org (Postfix) with ESMTP id BBE109F232;
	Tue,  2 Aug 2016 17:11:34 -0600 (MDT)
Reply-To: shuah@kernel.org
Subject: Re: get_maintainer.pl and .mailmap entries with more than 2 addresses
References: <1470155781.3998.181.camel@perches.com>
 <6A56763C-D795-4943-AFE9-8A53ECD61AF6@mickler.org>
 <1470176777.3998.203.camel@perches.com>
To:	Joe Perches <joe@perches.com>,
	Florian Mickler <florian@mickler.org>
Cc:	Mauro Carvalho Chehab <mchehab@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
	mchehab@s-opensource.com, Shuah Khan <shuahkh@osg.samsung.com>
From:	Shuah Khan <shuah@kernel.org>
Message-ID: <57A128A6.4040303@kernel.org>
Date:	Tue, 2 Aug 2016 17:11:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1470176777.3998.203.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGf96KY/ykVHJi3muyd+AWcCDxQITeZSYJ9mDQNJiSYuDXrkYhBG9uzoFQlcXF9LGL3JdyZcir9PTpMJuJRzTifisnzcp8v38XkGhfxUVuEZvzxH+Zem
 wyY80HisQDufEyzuXr1cAO0w8fwT7D67VSgCyK7EAJJ5XGHwGbj7A4065waHMEmzLDnS9UcU+ZRvVyU4gFJDgq8KR7SVoF+SBrCQ+ufsiXjUUkWFE0d8gMaT
 tfH2geRNlIJtJCpus0DYcQLdpw6hx76Y1yCU0d4ReZMXZRwWR4y02JwfgNnWUjsZ0wtXHVQQW8/C/k389EZGf0QpqaChSClkHpPEK5uUNKUnQYIeUomHo7LK
 gQCpybAY7GS3M7hrHv5gjN8TwvS2tA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/02/2016 04:26 PM, Joe Perches wrote:
> On Wed, 2016-08-03 at 00:17 +0200, Florian Mickler wrote:
>> cc'd mchehab@s-opensource.com  (Mauro, is your kernel.org address up?)
>>
>>  Am Tue, 02 Aug 2016 09:36:21 -0700
>> schrieb Joe Perches <joe@perches.com>:
>>
>>>
>>> Hello Florian.
>>> There is at least an oddity with get_maintainer handling of a
>>> .mailmap entry form.
>>>
>>> For instance:
>>>
>>> Mauro's .mailmap entry is:
>>> Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
>>> <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com>
>>> <mchehab@osg.samsung.com> <mchehab@s-opensource.com>
>>>
>>> Is this a valid form?
>>>
>>> get_maintainer output for Mauro is:
>>>
>>> $ ./scripts/get_maintainer.pl drivers/media/ -f
>>> Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
>>> <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com>
>>> <mchehab@osg.samsung.com> (maintainer:MEDIA INPUT INFRASTRUCTURE
>>> (V4L/DVB))
>>>
>>> I believe the Mauro's and Shuah's .mailmap entries are improper and
>>> should be changed, but I'm not completely aware of git .mailmap
>>> handling and the documentation seems weakly specified.
>>>
>> Hmm.. looking at Mauros last .mailmap commit it seems like your patch is
>> ok for Mauro. 
>>
>> Although <mywing81@gmail.com> and <mchehab@brturbo.com.br> are probably
>> missing? (@Mauro) 
>>
>>
>> $ git shortlog | grep "^Mauro C"
>> Mauro Carvalho Chehab (4404):
>> $ git log | grep "^Author:.*Mauro Carvalho Chehab" | sort | uniq -c
>>       2 Author: Mauro Carvalho Chehab <maurochehab@gmail.com>
>>     146 Author: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>>     645 Author: Mauro Carvalho Chehab <mchehab@infradead.org>
>>     794 Author: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>>    2015 Author: Mauro Carvalho Chehab <mchehab@redhat.com>
>>     448 Author: Mauro Carvalho Chehab <m.chehab@samsung.com>
>>     353 Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>>       1 Author: Mauro Carvalho Chehab <mywing81@gmail.com>
>>
>>
>>
>> Anyway, from a technical viewpoint your patches seem to fix
>> the .mailmap entry as the author intended. (See Junio's Email for the
>> documantation part) 
>> But I would wait for the ack from Mauro and Shuah. 
> 
> As far as I understand, a single entry with just their
> name and preferred email address would work too because
> the name parts are all spelled identically.
> 
> 

I am fine with change to my entry. Thanks for fixing it.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

thanks,
-- Shuah

