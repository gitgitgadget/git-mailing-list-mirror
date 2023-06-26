Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD402EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjFZQzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFZQzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:55:03 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA2C4
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:55:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7659db6339eso59794085a.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798501; x=1690390501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eTif9KwD/MOGgu+hc1hezrBhI20qNupHyo3bbLsT20=;
        b=DlQ3jM9X1uG2+JqKcjfAdXFcafpvBwxiql46PHKSdjQFTXNcqw55k6TV590Div04mI
         0rvxLCG3Kcx6LRoGPUmDCmyUA06cQNAMWz5IUosJK33q5D5gtNsh5SvHa0xzds9BNqP7
         lnJkq8NOjqILHzyT87hXwzuxjIXlyHA6GJn1HcBp77BpoLWobDeWQH6Y9Jmlm42HRDWW
         7s7B43xo+3J/7Iw6/wHzUrUTQCN7Wmx/54fbtqnU+7c/Jae2CU1YCft7HaeMNyBzlJsv
         qdqDwTlouJ7DnOZHBwqfIJLpk9Jcnf+ZG76shw4WHHad9FuAelLBmdMwPq27AQeBvSXg
         Q/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798501; x=1690390501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eTif9KwD/MOGgu+hc1hezrBhI20qNupHyo3bbLsT20=;
        b=NvlxdCbjcsQb5Oz4kMEPVBbu0rIXBDFmoln/Wz4aH6fJmHtM8bcMiZ6SNh+lodM1GN
         gnH7so/R7AF8dyhJhMphad9ygbqS4KMSBwkf9MxMHqxC0/dAG65Tj021NGUeLYZ0X3aU
         qtYi5+7YslhbggZldOkI3eXQG400gouBe8WN+JxPVrec/+MaX9cDJVHN4P8Q4p/eCwFY
         YhFFgSPWysSjhEMQ8Aq5m2Bxf7vZD0WlHRQCohCgbokcQUKSLXTULn4PkqisbARWJrUp
         hM72aZl29CEvxjTO6zHyzqav9UNevHZ5k97hcZVWAhIIv0ci+TE83OYYaYe/out7Y1zB
         G+JQ==
X-Gm-Message-State: AC+VfDwS25qhI81IKRn7mNg8pYUQTlZlaaeFbZUwq5XYlP/gvonbfOqR
        TWMia/yybTQmEkudtVqt/W5PCPveFD0SJA==
X-Google-Smtp-Source: ACHHUZ5o+N4sr6I50VPVn3Vf60LX7fAX17h9ADk19OseOOeLW9XJ3zi03WsOM2qEUKP/u3sioDbiDA==
X-Received: by 2002:a05:620a:2409:b0:765:5ba6:a5c0 with SMTP id d9-20020a05620a240900b007655ba6a5c0mr5583104qkn.14.1687798501562;
        Mon, 26 Jun 2023 09:55:01 -0700 (PDT)
Received: from ?IPV6:2600:4040:266e:4d00::387? ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b0075b053ab66bsm2850856qkg.50.2023.06.26.09.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:55:01 -0700 (PDT)
Message-ID: <7392e94c-ad72-95d1-6cb7-2112aa7bf29b@gmail.com>
Date:   Mon, 26 Jun 2023 12:55:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <xmqq8rc8781p.fsf@gitster.g> <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com>
 <xmqqwmzr5yul.fsf@gitster.g> <b7181a2d-ba97-eae8-6bf4-4fc4b0db64c2@gmail.com>
 <xmqqsfae5igi.fsf@gitster.g>
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqqsfae5igi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/26/23 11:52, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> I had originally organized as you suggest, no problem doing so
>> again. What gave me pause was this paragraph I originally wrote for
>> the cover letter:
>>
>> Patches 1/2 cause git-gui to function as it has for the last decade on
>> Cygwin, but with Cygwin being detected. However, the browsing and
>> shortcut creation menu items, removed in 2012 then re-added when is_Cygwin
>> was fixed, do not work, and shortcut creation will crash git-gui if used.
>> These are fixed in patches 3 / 4.
> As you are removing (ancient) Cygwin specific code that did not work
> with modern Cygwin at all in step [2/4], it is not so unexpected
> that some stuff does still not work after that step.  I am not sure
> what your reservation exactly is, but if you are wondering if code
> to disable browsing and shortcut creation on Cygwin temporarily
> needs to be there in the same step (instead of crashing or not
> working), it may make sense if and only if it is done with minimal
> changes.
>
> Thanks.
>
Timely response ... yes, that was my concern. I resolved this by making 
the cover letter and patch 2 commit message explicit that broken code 
remains.
Thank you,
Mark
