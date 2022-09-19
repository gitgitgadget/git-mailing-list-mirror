Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D1C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiISRzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiISRzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:55:40 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA59C6585
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:55:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i15so278240qvp.5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=H9cfEMJZxJoJoQFeoXKKusOprc4uVl0JraOgi4RImFY=;
        b=ipqNCnM/ci6VIVGw18Maib0WjKPgtJNXkF03X3KeKFthovhxOZiEAm85gOLWYe69ZU
         jJe8XKYUy7gOw85H+Y8FaLZM64iy2KKRNyF99QpP9fcT1MLScpueq5Hul42qLUn7bS3W
         nfWwub++wbTI0kkgxyU7asR5KeT80GurzpL7Tpf8AuVZVJspOa2qF+JjFMdDLxvahBeS
         I7W8h0+ZoV6jcgbPfSU2zAcwckEYaJjoZ7ZB1k4kWaszTff4b4ta6z+2u4coNPBg49RN
         zi2H028/NIuE8GFfJI4hJgQHOncvYErGHBBI6r7GSaKhmy49FFH7+jimFF83QUsa344e
         1Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=H9cfEMJZxJoJoQFeoXKKusOprc4uVl0JraOgi4RImFY=;
        b=cZRqSurwtGdGCLA3hU6ITNdG+M2s9q6Tk5NjBctRT+PF8NvVnc7FwEyoBAs2kWIgXG
         fjNCiJnXyLB74vd4CNfqUeKbLri7e1qzhEs+f0pif79MIVBsvGaXp/boKVxGZrxfdTx3
         k73DHQhMRxhTbNvbMyUs95R8OGvPGzzppKe6l4wXohvLiI0nfZeCvFdyiZ7hMr5iLO6n
         hh3yJtmhCw1bgd4hkp2hhpd4v9EfhY9FP5V5hV6qhoZyCWaG6c5lqtIU718nyyXRUp8s
         3vHhe/YnSvRx3c7txL3HP6+tHED6c5Ktx6ETWbEDBhVgOoowurHlrd3QvcFypzjUNwQ7
         1ugw==
X-Gm-Message-State: ACrzQf09zrT6Be2NI2fRxHHpaII7vt8hcTzDeFULJF5kLAmcBA0psHFR
        vgUM+cNDpzzShP9Bes7ZVJBvPfH0K9fBPCo=
X-Google-Smtp-Source: AMsMyM4pwX3bmXdmexKAmRSW4vXUYxdQts3CU3JqP82GoECvFIF+235t7unO648UIcpnGea0KhXoQQ==
X-Received: by 2002:a05:6214:20ed:b0:4ac:b2b4:39af with SMTP id 13-20020a05621420ed00b004acb2b439afmr15655609qvk.57.1663610138971;
        Mon, 19 Sep 2022 10:55:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id f10-20020ac8464a000000b0035cf0f50d7csm1099414qto.52.2022.09.19.10.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:55:38 -0700 (PDT)
Message-ID: <c40247c6-d925-af1a-4ce2-6dcec7fb748d@github.com>
Date:   Mon, 19 Sep 2022 13:55:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/9] bundle-uri: short-circuit capability parsing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
 <2ca431e6c377f42d70ea9ce0ac74058fc983ea2c.1662734015.git.gitgitgadget@gmail.com>
 <xmqqleqslauq.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqleqslauq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2022 1:24 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When parsing the capability lines from the 'git remote-https' process,
>> we can stop reading the lines once we notice the 'get' capability.
>>
>> Reported-by: Teng Long <dyroneteng@gmail.com>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  bundle-uri.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/bundle-uri.c b/bundle-uri.c
>> index 4a8cc74ed05..7173ed065e9 100644
>> --- a/bundle-uri.c
>> +++ b/bundle-uri.c
>> @@ -56,8 +56,10 @@ static int download_https_uri_to_file(const char *file, const char *uri)
>>  	while (!strbuf_getline(&line, child_out)) {
>>  		if (!line.len)
>>  			break;
>> -		if (!strcmp(line.buf, "get"))
>> +		if (!strcmp(line.buf, "get")) {
>>  			found_get = 1;
>> +			break;
>> +		}
>>  	}
> 
> Hmph, is this safe to do?  Who is feeding child_out?  Aren't they
> get upset if we do not slurp what they write to us?  Are we
> expecting to read more from them after this part?  Aren't we get
> upset if we leave some other stuff when we read from child_out after
> we saw "get"?  If we respond to child_in without reading all from
> them, do we not get into a deadlock?
> 
> Perhaps these are all silly questions, but the description above
> does not quite answer them.

In my testing, this has not been a problem, but that does not mean
that it is safe to do. I'll drop this patch in v3.

Thanks,
-Stolee
