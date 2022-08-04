Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D112C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiHDNbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiHDNbn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:31:43 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A370539BA7
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:31:42 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h16so9949222ilc.10
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i3rzJbRsCvDwDCI5ZUl7Yu8faC4+tVJuFOqIEEmC1to=;
        b=iJck0fPIowGooQ1cAjnb3g/AEb22wjySx86CMsWNU8X/v8zad0XgYU2OJzKyNlZRUz
         oMsITXKj8iVLWwtysql8XvrlkItcHEOQSWhQGcgpW07jcIzC725ksI1tBmMqDZvv3bPg
         tTCw4vbYI2IrUoGiOCE2ZWRp/Qmrj8zGxfvGnbtu+dFGulVyQNY4EZfRFZ/CyotUMu3q
         0NW190y4Xu6grEQNS8Dtd7ryn6f/eKZlW7VaL8NRdQ9U2z5Kn8hDItQFs2CzwIcR7tlg
         aOfeg+R94BF1GQ5cMH+GCIbsHfsvi1ITQjTZK7TqmvA660mpti8rGNmPCvq+MOEcDZCt
         KhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i3rzJbRsCvDwDCI5ZUl7Yu8faC4+tVJuFOqIEEmC1to=;
        b=bIkbrFQmGSgUXi4WwNSo6aoqVwv4e3LXZTx7PYqyEMTfcnP2LHeiXStiZd4IT2Cwhq
         spYlQi/yp/M3mZW5G2Z+hh8g3uAZJVEVG3ndwA4j2V72IHDZC2G0sDTSPf68ntC8ttbH
         c8CYnbOFYX8dPQN7E24BPTbmSenqi1j/zTbqF6OH2fybhKdBQFJ3fg6bsidnyqOlMilF
         r6Un9uSip/PmNfbgHh+XvSEuJRg2mB0hwVuiGI38QzAreXEFkBLeUtty7nKqbXyv7gTY
         txnrTloJvv28G9E/hWLXRjn3svFXW6mISkdhQJfg2HvyEZBVWas5vSLzRKHdLuVH7Yyz
         /ADw==
X-Gm-Message-State: ACgBeo3lw4STSpYh90ogKm1cxlihEJQJ02w8L9Ai6oKeXrt49rTgVdtt
        V6RmkK2axWXuqYrkGau9qwVh
X-Google-Smtp-Source: AA6agR6F5brsD35GvaJF7rKk98CVnNp2YlOekrdUMiA834YEMsaNO5IyMz+FkIIFdZaAMTFS3tlT3g==
X-Received: by 2002:a05:6e02:1845:b0:2de:42f0:b03c with SMTP id b5-20020a056e02184500b002de42f0b03cmr884367ilv.260.1659619902055;
        Thu, 04 Aug 2022 06:31:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05663819cc00b0034294118e1bsm441751jab.126.2022.08.04.06.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:31:41 -0700 (PDT)
Message-ID: <b4f07dd1-b59d-864b-f881-110c9bf87202@github.com>
Date:   Thu, 4 Aug 2022 09:31:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/10] log-tree: use ref_namespaces instead of
 if/else-if
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
 <xmqqv8r9dei7.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8r9dei7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 2:31 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> +	for (i = 0; i < NAMESPACE__COUNT; i++) {
>> +		struct ref_namespace_info *info = &ref_namespaces[i];
>> +
>> +		if (!info->decoration)
>> +			continue;
>> +		if (info->exact) {
>> +			if (!strcmp(refname, info->ref)) {
>> +				deco_type = info->decoration;
>> +				break;
>> +			}
>> +		} else if (starts_with(refname, info->ref)) {
>> +			deco_type = info->decoration;
>> +			break;
>> +		}
>> +	}
> 
> Very nice.  The double-dash in the NAMESPACE__COUNT constant somehow
> looks strange.  As we scan through ref_namespace[] array densely,
> 
> 	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++)
> 		...
> 
> without having to use the constant would probably be more in line
> with the way how the rest of the codebase works.

Ah, I did not know about that trick. Thanks!

-Stolee
