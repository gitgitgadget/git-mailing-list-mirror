Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD6920450
	for <e@80x24.org>; Sun,  5 Nov 2017 06:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbdKEGq2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 01:46:28 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56055 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750775AbdKEGq1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 01:46:27 -0500
X-AuditID: 1207440d-853ff70000000f42-b3-59feb3c05903
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 54.53.03906.1C3BEF95; Sun,  5 Nov 2017 01:46:25 -0500 (EST)
Received: from [192.168.69.190] (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA56kLaS013819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 01:46:23 -0500
Subject: Re: [PATCH 1/7] files_transaction_prepare(): don't leak flags to
 packed transaction
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
References: <cover.1509183413.git.mhagger@alum.mit.edu>
 <b8e61183ad5d5c046a9eff75ea0401cf2c2567c6.1509183413.git.mhagger@alum.mit.edu>
 <xmqq60ax6y95.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4d2e6a29-e612-2eab-1b20-0c97a8871c5c@alum.mit.edu>
Date:   Sun, 5 Nov 2017 07:46:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq60ax6y95.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1D20+V+kwfeDjBZdV7qZLBp6rzBb
        nHnTyOjA7HHxkrLH4gdeHp83yQUwR3HZpKTmZJalFunbJXBl/Fz9gKngpXDF3uVXWBoYP/N3
        MXJySAiYSGxd2cHWxcjFISSwg0ni0q5lTBDOOSaJO2cXsoJUCQvESbz5/IkRxBYRUJOY2HaI
        BcRmFnCQmLPgBStEw05GiemXf4A1sAnoSizqaWYCsXkF7CX+nX3MDmKzCKhIdPffYQaxRQUi
        JJ43v2eFqBGUODnzCdhQTgFrib4vR5ggFqhL/Jl3iRnCFpe49WQ+VFxeYvvbOcwTGAVmIWmf
        haRlFpKWWUhaFjCyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICWneHYz/
        18kcYhTgYFTi4T3h8S9SiDWxrLgy9xCjJAeTkijvlZd/IoX4kvJTKjMSizPii0pzUosPMUpw
        MCuJ8AYtBirnTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwHtsE1ChY
        lJqeWpGWmVOCkGbi4AQZzgM0fClIDW9xQWJucWY6RP4Uoy7Hs5mvG5iFWPLy81KlxHn3bwQq
        EgApyijNg5sDS0WvGMWB3hLm3QoyigeYxuAmvQJawgS0ZDbHH5AlJYkIKakGxgXH1Iq4OC+1
        HHV/sc/X8s4n76vu7E0SiopGer3rWMR/SfUbM8QI+CydfF3jF/fDcO+y1uP5GzxXNdXae5j8
        2qQz505mlYLQTKEKc8/wXistw00LXHc78vhN1JklqxIhYWJv+yz4kMkenfXiXvXre3ZoFK6b
        oa9/9eE9e4XsSy9Nrbc8S+hQYinOSDTUYi4qTgQAs2rDFyADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30/2017 05:44 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The files backend uses `ref_update::flags` for several internal flags.
>> But those flags have no meaning to the packed backend. So when adding
>> updates for the packed-refs transaction, only use flags that make
>> sense to the packed backend.
>>
>> `REF_NODEREF` is part of the public interface, and it's logically what
>> we want, so include it. In fact it is actually ignored by the packed
>> backend (which doesn't support symbolic references), but that's its
>> own business.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs/files-backend.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 2bd54e11ae..fadf1036d3 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2594,8 +2594,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>>  
>>  			ref_transaction_add_update(
>>  					packed_transaction, update->refname,
>> -					update->flags & ~REF_HAVE_OLD,
>> -					&update->new_oid, &update->old_oid,
>> +					REF_HAVE_NEW | REF_NODEREF,
>> +					&update->new_oid, NULL,
> 
> Hmph, so we earlier passed all flags except HAVE_OLD down, which
> meant that update->flags that this transaction for packed backend
> does not have to see are given to it nevertheless.  The new way the
> parameter is prepared does nto depend on update->flags at all, so
> that is about "don't leak flags".
> 
> That much I can understand.  But it is not explained why (1) we do
> not pass old_oid anymore and (2) we do give HAVE_NEW.  
> 
> Presumably the justification for (1) is something like "because we
> are not passing HAVE_OLD, we shouldn't have been passing old_oid at
> all---it was a harmless bug because lack of HAVE_OLD made the callee
> ignore old_oid"

It's debatable whether the old code should even be called a bug. The
callee is documented to ignore `old_oid` if `HAVE_OLD` is not set. But
it was certainly misleading to pass unneeded information to the function.

>                     (2) is "we need to pass HAVE_NEW, and we have
> been always passing HAVE_NEW because update->flags at this point is
> guaranteed to have it" or something like that?

Correct. `REF_DELETING` is set by `lock_ref_for_update()` only if
`update->flags & REF_HAVE_NEW` was set, and this code is only called if
`REF_DELETING` is set.

Michael
