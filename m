Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC85C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 14:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbiEPO7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 10:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiEPO73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 10:59:29 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0838BFA
        for <git@vger.kernel.org>; Mon, 16 May 2022 07:59:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y12so7848386ior.7
        for <git@vger.kernel.org>; Mon, 16 May 2022 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=odx/9PHbo57I84nD8LkhHvHae2MOEdVogz0SDWlKjpA=;
        b=iZGoQGQmyfKiEWF0T/8ziWOAPuZEflZcUGitBDIcVIBhYaVvbDdZBgrtD0h8EHRNwX
         nYfpkTtSMWfIXMRsS1rn1jRECtH/HACVI4wYadcZcrkcgLMS4Kp5bxFRDxpuDpKnHv7J
         ZZJNT24AmIGgwyL33JVANNTRJeZhncIFWwoEmVYPn/hvVbUp28uc6fAT+f53sUOR5NZU
         DheDel4U4EizWNhy3T+gWz9154hWD889EF/ijEtJY064oiWfflMz5baYYr19zk3yytFm
         jWnP+DpD9k9U/QRZPbOqc3NTkutAiXUyS+xn4NYPa2Zt7Ri+1bJI+H7zVu0eMkVfrUB0
         uk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=odx/9PHbo57I84nD8LkhHvHae2MOEdVogz0SDWlKjpA=;
        b=wqGF0AJEY4/JagVn7xyOjFyeJbWUSi6gPa4UEx92uPzIL+2OGkl5vDrF+IOQDWC0Ek
         GQnARNgsmoBnXWC3eBrd5lVrfB83GizvkIGB2T3IB2Byu7G2IuWzqnRav5Bfp64wERrt
         gNV//4fgD49sB4sW4c9arEI7sGQx0VydB1NzoxG49/PbZjmgqikFbhFkMjae4kR+yr13
         T9Cri3qfV31WvqMjtAfsBwU3P3o98uR8jnlufHQ/ClY/aennXIoC3ClSTU2gCr9wHBHA
         DyE6MIJZlwhRYKLPttGPRP7OLtkrAdLQV+Us6Ub98I9q/wX1+m7DwUjIqFn6bh80Bwdu
         i0Ug==
X-Gm-Message-State: AOAM5332SwfSaMPoaqhpr8vcHfSx5XJur+7v8WXH6xMEtlDnkVJoxtU7
        CQRDGajppTygFgrnVL5y0mJg
X-Google-Smtp-Source: ABdhPJxN/vX2m0CJpT7nltKOAnMWY6TdOr2UltlUnVakcoKZhJjnNVE440PBSGwy1alxZ8ZVrrvXwg==
X-Received: by 2002:a05:6602:1584:b0:65a:cf4f:c93a with SMTP id e4-20020a056602158400b0065acf4fc93amr8006703iow.52.1652713168405;
        Mon, 16 May 2022 07:59:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a875:ee72:945f:af93? ([2600:1700:e72:80a0:a875:ee72:945f:af93])
        by smtp.gmail.com with ESMTPSA id l6-20020a056e0212e600b002cde6e352c6sm2599020iln.16.2022.05.16.07.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 07:59:28 -0700 (PDT)
Message-ID: <377be0e9-8a0f-4a86-0a66-3b08c0284dae@github.com>
Date:   Mon, 16 May 2022 10:59:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/4] object-file: fix a unpack_loose_header()
 regression in 3b6a8db3b03
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
 <20220512223218.237544-1-gitster@pobox.com>
 <20220512223218.237544-5-gitster@pobox.com> <xmqqo802codb.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo802codb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2022 7:39 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> diff --git a/object-file.c b/object-file.c
>> index 5ffbf3d4fd..b5d1d12b68 100644
>> --- a/object-file.c
>> +++ b/object-file.c
>> @@ -2623,8 +2623,12 @@ int read_loose_object(const char *path,
>>  		goto out;
>>  	}
>>  
>> -	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
>> -				NULL) < 0) {
>> +	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
>> +				    NULL)) {
>> +	case ULHR_OK:
>> +		break;
>> +	case ULHR_BAD:
>> +	case ULHR_TOO_LONG:
>>  		error(_("unable to unpack header of %s"), path);
>>  		goto out;
>>  	}
> 
> Regarding this hunk, since we only care about a single "did we get
> any error, or did we unpack OK" bit, I think this should be more
> like
> 
> 	if (unpack_loose_header(...) != ULHR_OK) {
> 		error(_("unable to..."), path);
> 		goto out;
> 	}
> 
> It is true, as Ævar mentioned, that there is another place in the
> same file that uses switch() in loose_object_info(), and it should
> remain to be switch() on the returned enum because it wants to
> behave differnetly depending on the kind of error it gets.  But that
> is not a reason to make this part that only cares about a single
> "did it fail?" into a switch and force future developers to add a
> useless case arm.
> 
> I left it there as posted in the previous round because I was too
> lazy ;-) and also it is something we can clean up with a follow up
> patch outside the series.  As my today's focus has been to reduce
> the number of topics waiting for a reroll, I'd rather leave things
> that are not outright broken but needs clean up as they are for the
> sake of expediency.

Taking a look at your new version, I agree that this use of 'switch'
is out of place and can make things more confusing in the future.

Here is a patch doing exactly what you recommended, which you can
choose to add or squash. I made you co-author, but I expect you to
add your sign-off after mine.

-- >8 --

From 85cd37b4f23e06980ea95311067d735144fe932f Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Mon, 16 May 2022 10:53:27 -0400
Subject: [PATCH] object-file: convert 'switch' back to 'if'

This switch statement was recently added to make it clear that
unpack_loose_header() returns an enum value, not an int. This adds
complications for future developers if that enum gains new values, since
that developer would need to add a case statement to this switch for
little real value.

Instead, we can revert back to an 'if' statement, but make the enum
explicit by using "!= ULHR_OK" instead of assuming it has the numerical
value zero.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---

 object-file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index b5d1d12b68a..52e4ae1b5f0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2623,12 +2623,8 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				    NULL)) {
-	case ULHR_OK:
-		break;
-	case ULHR_BAD:
-	case ULHR_TOO_LONG:
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				NULL) != ULHR_OK) {
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
-- 
2.35.3.vfs.0.0


