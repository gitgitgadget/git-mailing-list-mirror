Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB9AC54EED
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 13:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjA3Noa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 08:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3No2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 08:44:28 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084D15552
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 05:44:27 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso2640511otl.11
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xaLceTrLxUHhb55NHwpqbrkq4ZxF7dhGWksVkJIjqc=;
        b=Fil5Me8i89tJOG7KEY1JH7NWyvHQfL1xm3QE/4sNDXeNgh8+7DFjKfEiOKrL5B0Zb9
         M9lvAgbeya4eOmlSmDBEL2r2K8crZoSZmL2RQzyu2MXRq96A4tqYrTB10RiER7CGbWOA
         gcdm52OerZ5cTydN0FyDmKf4k2iJ7K7GYNGoVpfZMNxElhMIM/xVufSV3Cty2FyiCPt6
         WEuOXTvLb1txB8HR0NrdOCjIi9u+veb6g4jqPWojFRzLHvPYQ9h6SHfceU96ScjHp214
         vybfUMZLkBpQMbVc3x+CSwI/antj8oFXiyWEh8WAIaudhLmCdaqLfbOoSmQB+U3tqjxb
         Ng6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xaLceTrLxUHhb55NHwpqbrkq4ZxF7dhGWksVkJIjqc=;
        b=KMY6sIsjh3wB1K+z3nJRYWQ8Dr8LTkjlMTwbXyxu3Uyo6d1W1eyF+UlNO4LSWX7szM
         EejTc4RjDvCncl7uPDi7x9PGezVhCfso0Wq/Vj12CXA5pYbv9v9RDz9TKa+mYFjFTS4a
         QN0r1FSEQ95hXJ+am4MuSRTCngB5fzZ/3LBzReHsEnbaDMo32bVRQyt5HZ+yFY2sgYY4
         acHhMT5u80y2ABxKNnY7rR5neEcIciPFCPJxF7tITmxr54xNeeFPg0sRqWnaDeq3lrEr
         K2I0rN6JzUiuwlrKCFPgztmplF2x50TGbpz3UrqKdd/jnfTM8L6YTkRY1miYMFkdIiwn
         Jefg==
X-Gm-Message-State: AO0yUKVNTWMIkmIMU19xQO/A4wc7MTpslUbb5G8FcTJ5G33/OKaeUHDv
        1c9KimwBQ2kXSbOvVJoU07c3
X-Google-Smtp-Source: AK7set/aYMQyaBWGSfSQAr8o3bvTx3dV9yA0/zAty2I/19/KQMFXCVB5hvGT2WgXYKcUklKIYjL8mw==
X-Received: by 2002:a05:6830:18ed:b0:66e:ab30:6ab with SMTP id d13-20020a05683018ed00b0066eab3006abmr4609779otf.20.1675086267275;
        Mon, 30 Jan 2023 05:44:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68? ([2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68])
        by smtp.gmail.com with ESMTPSA id bg12-20020a056808178c00b0035ec1384c9esm4679789oib.23.2023.01.30.05.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 05:44:26 -0800 (PST)
Message-ID: <b63611dc-a889-8900-403a-ec7c42a89705@github.com>
Date:   Mon, 30 Jan 2023 08:44:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
 <xmqqleln90ka.fsf@gitster.g>
 <4913381a-769f-aba0-c04d-559d103e8396@github.com>
 <xmqq357v8poc.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq357v8poc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2023 7:32 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>>  The "maintain
>>> their clone" certainly should include running periodic maintenance
>>> tasks without them having to worry about it.  It feels like this is
>>> calling for an explicit "disable periodic maintenance tasks in this
>>> repository" option to help these esoteric environments that disable
>>> cron-like system services, while keeping the default safer,
>>> i.e. fail loudly when the periodic maintenance tasks that the users
>>> expect to happen cannot be enabled, or something.
>>>
>>> Perhaps I am not the primary audience, but hmph, I have a feeling
>>> that this is not exactly going into a healthy direction.
>>
>> Here, we are in an environment where background maintenance is
>> unavailable in an unexpected way. If that feature is not available
>> to the user, should they not get the benefits of the others?
> 
> That is not what I was saying.  I just have expected to see a way
> for the user to give scalar an explicit "I understand that periodic
> maintenance does not happen in this repository" consent, instead of
> demoting an error detection for everybody to a warning that users
> will just ignore.

Ah, so you'd prefer a --no-maintenance option for users who have
this problem instead of just a warning. I'll do that in v2.

This could be a good time for me to upstream the --no-src option
while I'm messing with arguments in 'scalar clone'.

Thanks,
-Stolee
