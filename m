Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F55C43460
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DE2613C6
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbhDFLVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245451AbhDFLVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 07:21:17 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34155C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 04:21:09 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v25so14690810oic.5
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Vk+b2+6kqsuCoNODtUXDUS5xY3C2Crx7o6ZNKaEHcA=;
        b=hYftPbr6QehNiWIhi8Vwmb1SIr3UTwWUR+P7tfqoePL/cjxRc1U9mWBXFKCuANSgoC
         8b1S5AoJzb2/Q43YINs+/u2JePpX0hPjsX//ujuU5YTyCJeOj0x+t/Ltunx+orwUyenO
         +mjoFYPx5uxBD5BVg17SWgZBnBrsvX78RaKCnB+hShm6DqHXr0Dvdpfsv7389sn5Uf3C
         AHG0l28XgP6B2DJ8V5wkfzzHzVKGSxlo1vNTTbIJQAGa266O3yWjPsJUNqYT1XjCKA8Y
         Xce07BLIvQ9Oe+sl2d7dvh02qUd4lFB5WD66nBX6lWWxhiPP5SGynL9YIYql4vVSD60Q
         qq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Vk+b2+6kqsuCoNODtUXDUS5xY3C2Crx7o6ZNKaEHcA=;
        b=TgEqb6F4FwmN83RsNNQaKbihYOVthSDtEDf54FLWDQNujWGKhALzz6EnsH0NakmPyr
         /Yt9BomXFAO75BMrl7VLmi+9cp/+QrqRW1w2MEvMxrbYK3USay+GKt5RiSRoTQnS21ot
         pyvtJT1dN8Y016vsdPRxx2er8BAeNCXye0QnNKCjgaXqOjy9Fmp5F19KyfTyEug3XCez
         e9kIQEaXwHkTgrGe3c6yeDlWVbMCNKuHFSmM03PSbyvA6A3QEzU9LNEUqjumf6sA9X2k
         pHMS4s10xAB+3A+NGakZyaOLZlioMH+oq8ObG+s8VaS9yCjCHxkuAh7uMP5pxhphSvZm
         IUMA==
X-Gm-Message-State: AOAM530cCZ6cz6oB4LWprILBug1MlUjtuTiFKCTqtMSr93Y0UL8x/WBg
        WdxemU2H1IzDLuGE4/Ex9ag=
X-Google-Smtp-Source: ABdhPJwbTOvZlE3MM38VZf6kZ4ZUSqBujc8eHkY9LuF1QvITpd+v4EbyolD9hycGmQFt8Tl2AAzFmw==
X-Received: by 2002:aca:aa41:: with SMTP id t62mr2900236oie.84.1617708068595;
        Tue, 06 Apr 2021 04:21:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id e12sm4080920oou.33.2021.04.06.04.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:21:08 -0700 (PDT)
Subject: Re: [PATCH 3/5] refspec: output a refspec item
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
 <20210405165740.brevvzc7hiyg2wj4@brm-x62-17.us.oracle.com>
 <CAPig+cSfzpynO5es+B4=7_Dz-qTHNXpDeUVxs7z5yffQFgWU=A@mail.gmail.com>
 <xmqqzgyc62yl.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <37f0ff6c-b493-35b5-5ca0-92703f82e333@gmail.com>
Date:   Tue, 6 Apr 2021 07:21:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgyc62yl.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 1:44 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Mon, Apr 5, 2021 at 12:58 PM Tom Saeger <tom.saeger@oracle.com> wrote:
>>> On Mon, Apr 05, 2021 at 01:04:13PM +0000, Derrick Stolee via GitGitGadget wrote:
>>>> +const char *refspec_item_format(const struct refspec_item *rsi)
>>>> +{
>>>> +     static struct strbuf buf = STRBUF_INIT;
>>>> +
>>>> +     strbuf_reset(&buf);
>>>
>>> is this even needed?
>>
>> This is needed due to the `static` strbuf declaration (which is easy
>> to overlook).
>>
>>>> +     if (rsi->matching)
>>>> +             return ":";
>>>> +
>>>> +     if (rsi->negative)
>>>> +             strbuf_addch(&buf, '^');
>>>> +     else if (rsi->force)
>>>> +             strbuf_addch(&buf, '+');
>>>> +
>>>> +     if (rsi->src)
>>>> +             strbuf_addstr(&buf, rsi->src);
>>>> +
>>>> +     if (rsi->dst) {
>>>> +             strbuf_addch(&buf, ':');
>>>> +             strbuf_addstr(&buf, rsi->dst);
>>>> +     }
>>>> +
>>>> +     return buf.buf;
>>>
>>> should this be strbuf_detach?
>>
>> In normal circumstances, yes, however, with the `static` strbuf, this
>> is correct.
>>
>> However, a more significant question, perhaps, is why this is using a
>> `static` strbuf in the first place? Does this need to be optimized
>> because it is on a hot path? If not, then the only obvious reason why
>> `static` was chosen was that sometimes the function returns a string
>> literal and sometimes a constructed string. However, that's minor, and
>> it would feel cleaner to avoid the `static` strbuf altogether by using
>> strbuf_detach() for the constructed case and xstrdup() for the string
>> literal case, and making it the caller's responsibility to free the
>> result. (The comment in the header file would need to be updated to
>> say as much.)

Yes, we could get around the return of ":" very easily.

> Very good suggestion.  That would also make this codepath
> thread-safe (I do not offhand know how important that is, though).

I was not intending to make this re-entrant/thread safe. The intention
was to make it easy to consume the formatted string into output such
as a printf without needing to store a temporary 'char *' and free() it
afterwards. This ensures that the only lost memory over the life of the
process is at most one buffer. At minimum, these are things that could
be part of the message to justify this design.

So, I'm torn. This seems like a case where there is value in having
the return buffer be "owned" by this method, and the expected
consumers will use the buffer before calling it again. I'm not sure
how important it is to do this the other way.

Would it be sufficient to justify this choice in the commit message
and comment about it in the method declaration? Or is it worth adding
this templating around every caller:

	char *buf = refspec_item_format(rsi);
	...
	<use 'buf'>
	...
	free(buf);

I don't need much convincing to do this, but I hadn't properly
described my opinion before. Just a small nudge would convince me to
do it this way.

Thanks,
-Stolee
