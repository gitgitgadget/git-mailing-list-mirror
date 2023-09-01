Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B3FCA0FF6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjIAVrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 17:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjIAVpo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 17:45:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A4138
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 14:44:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99cce6f7de2so315132966b.3
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693604656; x=1694209456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgLYYIcgVtz4M2/Qtrd5Q8lLNuTaoqgxWqpOq7IeAT4=;
        b=Ugh6Vo9A1sKm17Qlw4uz9GmqaoSobkeWGK3dXRYSg1IIhxuLj2lJMNDmu5xz4D5+Wz
         UxESU5lgXuoFpjh/cEdPz35xbCKwxQWfVUlKjzjIXiWCdmAFRxWmP8YsZ094ejaW14cr
         ++ptikiCQ6LMsG9F1tJNhU3Zbp12VYB0D79zEl16DzsjCPsT81modw07ffXoh36gVaV6
         MXxplWE+PabvgPgEC1teG21w9AgYyOBQbp6s25AcfI75x7QqAcZDTwQbOiOeFqNlxiGO
         9EUoCEUejQnT454wNT98kNxdMXgkftYlGGXg1R4CDZlWUUjnbHFJVcqjayhpIi518mrg
         pzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693604656; x=1694209456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgLYYIcgVtz4M2/Qtrd5Q8lLNuTaoqgxWqpOq7IeAT4=;
        b=IDl8nub7CHgY8f85JkhywE2IGx2tcac2HCaalH0v7A9kiYga584oINKM9aSwpQVRgG
         J2vPOhZtOZ5e0QFv3aeegCZWKlUFm0YxZpyLctTqk8nuGe6Mxo4jKeI4WF4c55QD4qT6
         sPua7RWSbAzUnFiB5u7A1yv2QHztgMnRYFrgYUpvjlzACrqtCuMZQfkZr1xr5Sqq6FlS
         r619amHO7cbudHDniHFU3/ShkMhE5RXhQDWh/NvJr80L7BmJOLqdEBk0CEulGYtOCBNW
         fqhKdStsoxW5awYfCqjsoEoFn4S9szC1Jkj/U+DLid5i9OAn4OfOYauyC12lEkgKjiP4
         qz5Q==
X-Gm-Message-State: AOJu0YxcOCDufAXLJntV7JjyLSS92zhCMFIkgBz6J5ag5cpCjIIOMF/d
        EZtHIg3OctgpxAvvuCLiw2B+61IA1WoJeQ==
X-Google-Smtp-Source: AGHT+IHXckExAg/dUy2qyiJbw5SZQT9+KK13cFR0ayDqOgwpH0AFaAQNNIswei0EbrBMHFVhucxhnA==
X-Received: by 2002:a05:600c:5120:b0:402:a464:1a20 with SMTP id o32-20020a05600c512000b00402a4641a20mr2515598wms.33.1693603986856;
        Fri, 01 Sep 2023 14:33:06 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b003fed8e12d62sm5967175wme.27.2023.09.01.14.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 14:33:06 -0700 (PDT)
Message-ID: <e8ff187f-9566-4761-b240-6bdc06c003d8@gmail.com>
Date:   Fri, 1 Sep 2023 22:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] pretty: add %(decorate[:<options>]) format
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     glencbz@gmail.com, phillip.wood123@gmail.com
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com> <xmqqcyz5cxy3.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqcyz5cxy3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/08/2023 22:59, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
>> Apologies for sending another version so soon, but I realized that I
>> hadn't removed the use of a compound literal from the first commit where
>> I had added it, so it still appeared in the patches. The overall diff
>> for v5 is the same as for v4.
> 
> Sorry, but I lost track.  How does this latest round of the topic
> look to folks?  Ready to go?

Unfortunately there haven't been any comments beyond v2, apart from your 
request not to introduce compound literals, which I've addressed.

I haven't got any changes to this pending.

Regards,
Andy
