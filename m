Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE1F1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 20:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbdJXUqy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 16:46:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46366 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdJXUqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 16:46:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id 1so32217226qtn.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vjmOC/oIQyRq1DTjyudyfXgGK/8/+NCw6rJ0qoK3+po=;
        b=YypVKP3nTD7YG03eaxOCEgEJ2k9Xmqa2q7FceSEZXJkMxjSKC3nFlhbrlI4TXJHr/W
         kY6nlXBQZWK+sRdgBOKq/7m4DhKvCAE/7vjl0RU2/TR/Y6sEQJGG1joX3weO2ejLVobP
         PqCb8EobVsEqCXxOlQ01v8fpuyaJt3iOaM7En/Y3pdlJq4J2sNRBjg1xV75WNxRDv1fG
         /NzY/4J8JQmhxZ9Gt+tmPGWvCvX0x8yiK5ug7C/KRsPyccCnvO1Bl+2TzKwReg3urodq
         vrBYfVgrzHBkwiiKGXElzjHymuF3bjfaEXfmzVX5hJocJnrLkB4Tv6RoT2Cu6rVrSGb3
         u5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vjmOC/oIQyRq1DTjyudyfXgGK/8/+NCw6rJ0qoK3+po=;
        b=jhBRZu9tLh9kHR9pogO0jUApihUS6Fc8xL1xQNlU+hzptigid3DXic7QoV1OCw8Pyp
         uj8L4rNGeJ66AWribGfmu86i/ao3e7ZGq/x9lZCT4gmXBcnVK2BNob+6ifR4LIWUTivq
         1mcbzL3Psa8b/gtk+1fuYE06zYns22c2Q97V119KZIOQT/ihtgcsbt7J7Zq8gt55+BWB
         LhA1UBV1dIcrxo8a8AJDe+QpTIeojPTZVasQ+zfaHM5yDIPtAFemO9lmUDT3i7hah+61
         F0FwPwNtEREJ0slymB3psqmjUh1+K9fTuMF2nrhHiwYCMNmLk5zuP5dWUUbglfC45kJM
         ZJ1g==
X-Gm-Message-State: AMCzsaXHS3N7aynXdJskHz2tYCq5z7L9EG6g1Z0E9nAdXe4JHkJB7Ax9
        JF48/sbfbaCc0e5a/YyTuTog/Og16XuOYgi3TU4VVw==
X-Google-Smtp-Source: ABhQp+TpswPKOQVQRYfEsxfiGn6SmLLyvy8ydvccNjdQOiEny5z3GzOrZsQWdN48uD74hOLx9ssSBALemiPka+0clrY=
X-Received: by 10.237.53.137 with SMTP id c9mr28970702qte.125.1508878013034;
 Tue, 24 Oct 2017 13:46:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 24 Oct 2017 13:46:52 -0700 (PDT)
In-Reply-To: <16718615-c5df-24dd-fa62-2b42f5d83a02@web.de>
References: <20171024185917.20515-1-sbeller@google.com> <20171024185917.20515-4-sbeller@google.com>
 <16718615-c5df-24dd-fa62-2b42f5d83a02@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 13:46:52 -0700
Message-ID: <CAGZ79kZF+kL0uCFpVE0o9cU2zgjqm=yzeCZSEWtsC1=q+8N3Yg@mail.gmail.com>
Subject: Re: [PATCH 3/4] xdiff: use stronger hash function internally
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 1:23 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 24.10.2017 um 20:59 schrieb Stefan Beller:
>> Instead of using the hash seeded with 5381, and updated via
>> `(hash << 5) ^ new_byte`, use the FNV-1 primitives as offered by
>> hashmap.h, which is seeded with 0x811c9dc5 and computed as
>> `(hash * 0x01000193) ^ new_byte`.
>
> The hash function you're replacing is called DJB2; I think that's worth
> mentioning.

I was not aware of the name. I'll look it up; thanks!

>
> Performance test results would be nice.  No idea how to find edge cases,
> though, or better: demonstrate a lack thereof.

My reasoning, though not in the commit message, is that the operations
are essentially equal, just with different numeric values, hence no impact.

I can look at the assembly and measure, too.

>
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>   xdiff/xutils.c | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
>> index 04d7b32e4e..a58a28c687 100644
>> --- a/xdiff/xutils.c
>> +++ b/xdiff/xutils.c
>> @@ -24,7 +24,8 @@
>>   #include <assert.h>
>>   #include "xinclude.h"
>>
>> -
>> +#include "cache.h"
>> +#include "hashmap.h"
>
> Ouch.  Defining FNV32_BASE and FNV32_PRIME here would be much easier
> overall.  And if that's too much duplication then those definitions
> could be extracted into a new header file (fnv32.h?) included by both
> hashmap.h and xutils.c.

I guess fnv32.h would do; it would contain the defines as well as the
static inline
function to be used in the inner loop of patch 1.

>
>>
>>
>>   long xdl_bogosqrt(long n) {
>> @@ -228,7 +229,7 @@ int xdl_recmatch(const char *l1, long s1, const char=
 *l2, long s2, long flags)
>>
>>   static unsigned long xdl_hash_record_with_whitespace(char const **data=
,
>>               char const *top, long flags) {
>> -     unsigned long ha =3D 5381;
>> +     unsigned long ha =3D memhash(NULL, 0);
>>       char const *ptr =3D *data;
>>
>>       for (; ptr < top && *ptr !=3D '\n'; ptr++) {
>> @@ -243,21 +244,18 @@ static unsigned long xdl_hash_record_with_whitespa=
ce(char const **data,
>>                               ; /* already handled */
>>                       else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
>>                                && !at_eol) {
>> -                             ha +=3D (ha << 5);
>> -                             ha ^=3D (unsigned long) ' ';
>> +                             ha =3D memhash_feed(ha, (unsigned char) ' =
');
>
> All the memhash_feed() callers in this file cast to unsigned char.  A
> macro or a function (possibly inline) defined at the top could do
> that for them.

That would go away when using fnv32.h

Thanks for the review!
Stefan
