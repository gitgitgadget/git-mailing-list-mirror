Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169F7C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 19:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiCGTuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbiCGTuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 14:50:52 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF333896
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 11:49:57 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso19179304ooc.7
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 11:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kYH7QHogScKIUyltp3JzaMGomz6gLe4F8jM6wj1imbw=;
        b=Tgdjvt6bSK18/A5+ZX50xyw+126HCBh8e++6pNn1LbJqKKFsTlOD2G/2h0TRbRvocV
         6c9AuB1PoMYg9wahcOXCOd1IvROc17M0tlodAz/6ZLn7sjbaSc+NJyYWsz1ODKgOW49a
         VryUPe05G+83ZsTaLjlP2Twa7ZXmETazFBW6XlulVr2CJVEeA95xy+vrvlRxMDJre0RI
         vLgastl9hPAmtcUZudz0XsZUtchCt96yeZsA4mDV457+bM/Hpvc5atvBcIgdZaOpg0J3
         UxGA8LOtmjHdgNzT1SvhgNskR+34ONi4NHOC1ieDFnQ0bhOBKn/ksHWoGvWg6+p3YuLY
         0DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kYH7QHogScKIUyltp3JzaMGomz6gLe4F8jM6wj1imbw=;
        b=kcdDmpwzcPHxKktNa7i3c4ETLCyWe6IgiXNaqtj5R0MqapmXier6/ZaKObUhvBN+f2
         eaSJF94MkmDum6D18kzsmtEY8d91Rj50qK0ihshJ79sFtdzuho11afwQuotytfba/VpL
         84LVXZXN7EoNY0cAB9wiieeqdKKX5HIEYogoAhQ5qxJvWC9Y7vK26MowuWkGxg93S9T/
         zWRe9sMHpjHJvMAnM+tCsQrTzKHGorVfaDPkqxxVpHGwOGIKt86y3MLyRkgtJzWKlqkO
         fsZZbxzbm9XyDhfEQoQngCT0PlogjaXjvIQgvlGYGUGAaVMHKxuDrVXNa3VJvUL8lVqR
         Iiog==
X-Gm-Message-State: AOAM533E8trT6BZ4gkkjmGOo0nZJ59V2SK2TLzm6pzPWdGh+LCvq25vy
        SlxelhRoWmjYwzsBpv7y1WOk
X-Google-Smtp-Source: ABdhPJxmZdLZkuTpKHNGSi9dE6JDWCTxv2FlShJ6E0fu7QQwK7CrihWnq/id3klHEKR5MCPZTksVow==
X-Received: by 2002:a05:6870:46ab:b0:d9:cbf6:855c with SMTP id a43-20020a05687046ab00b000d9cbf6855cmr340125oap.156.1646682597032;
        Mon, 07 Mar 2022 11:49:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o10-20020acaf00a000000b002da04e165a4sm452388oih.23.2022.03.07.11.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:49:56 -0800 (PST)
Message-ID: <51fabaef-4849-2d9f-285a-3f442f803717@github.com>
Date:   Mon, 7 Mar 2022 14:49:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
 <xmqqzgm5wafu.fsf@gitster.g>
 <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
 <xmqqv8wpu2fq.fsf@gitster.g>
 <85d434f8-0eb1-c6f7-dfd4-99bffbfbba57@github.com>
 <xmqq8rtlsg9h.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8rtlsg9h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 2:40 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> I also had some struggles getting this to work since local clones
>> were actually ignoring the filter. I didn't think it was worth
>> setting up an HTTP or SSH server just for this test.
> 
> Does "clone --no-local $path" work as a workaround?  It should do
> the same thing as "ssh" codepath except that it uses "sh" instead as
> the process on the other side is running locally.

I've been trying this:

 git clone --no-local --filter=$filter "file://$(pwd)" cloned &&

which "succeeds" with this in the stderr:

 warning: filtering not recognized by server, ignoring

>>>> I also attempted doing a "git clone --bare partial.bdl unbundled.git" to
>>>> get the 'git clone' command to actually place the refs. However, 'git clone'
>>>> does not set up the repository filter based on the bundle, so it reports
>>>> missing blobs (even though there is no checkout).
>>>
>>> Understandable, as cloning from a bundle, if I recall correctly, was
>>> done as yet another special case in "git clone", differently from
>>> the main "over the network" code path.  And from end-user's point of
>>> view, I think updating it is part of introducing the filtered
>>> bundle.
>>
>> The reason I did not include that here is because of the lack of
>> repository-global promisor/filter config. I do want to loop back
>> and make those updates, but perhaps for this series we should add
>> an error condition into 'git clone' to say "Cannot currently clone
>> from a filtered bundle" to help users understand the issue?
> 
> It would be a workable stepwise solution, I would think.  It is not
> like we are robbing an existing feature from users---it merely is
> that the support of partial cloning over different "transport" is
> uneven, which is to be expected, especially in earlier phase of
> introducing a new feature.

That was my understanding, too.

Thanks,
-Stolee
