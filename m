Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E4C19F21
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiHDURV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiHDURT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:17:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764020F63
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:17:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h8so431310qvs.6
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AI2jO33x5aelrxNuBlxdmf3+oMI1vy1VaCvtrjzjvro=;
        b=WiTTLghNVoYrWmuBoxgmNFsJSPG+wbnx0/aTPf5/4msibFvac7u8P+7FCIrecsZC72
         F1hvXryklYozjrJiLwKto0lpazkAfKjoF/Uk04mhLk51RQpsbf0bQOZtwkGiW6IxyH4K
         PHXxnXNr2q5GwG/jQr0/VDDQY8oj1V/oyIGfDSCjluFrEdMdWE2onO3uzc/U/2euna3Y
         MaiYL3wkskzNwQLGPeifGJzUuUNR/tPSXtvOtA8DBgqwMU+Mod/eU79EHWFJ3998qrxY
         zjHKs5eZupW2nZ0uPgeNjvZV7S8n0CTMRzzIJ9eeEeBt6l0cQZCgGWjs5mti8JB86DwR
         mNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AI2jO33x5aelrxNuBlxdmf3+oMI1vy1VaCvtrjzjvro=;
        b=kMxX/VnkjbINIE+AqReoYwa/2N8e7r6CklUgSNFckUkG8tyC81gMKBKqjPyNzv5HIi
         ohgrqJ96o21xucSsigf15wnBrkXmVjgCDNsZwmUWDAUWNLqBgtwSb1ctyM7Cq4RzqODa
         OEMVgg3uQ27Hj3hHebfxUF8Nf91KtHHpyqUs7hX3frsi33pjkEhZpsDx0YDq3H5FXeho
         zn1DE617Q2zfp94nERaHGvJmuiKwdskGF+sGxYwGivXuALbxQGSZWJMvAF7sV1YYh2G9
         9jxpAbReiapnyzTGmAL05cWzRZjzl68B2/ZfKKWfpMHvC+rw1671xb2N/vRi/iiG47ML
         Wc3w==
X-Gm-Message-State: ACgBeo00IaAY6ab7ekzqfVOtG0gwmeruh/GB9pw2nm0O/2FlZK1guVnt
        YBbUxinqip9pIQoEnNXAvRzI
X-Google-Smtp-Source: AA6agR7LcWnFDwm8NQ2bVDwyxbAsupYbjIKx/EZx/myoPSPaBcbNMOCwEQtDAtvQPZe+HjhseZlXtQ==
X-Received: by 2002:a05:6214:767:b0:476:d5e7:e0cb with SMTP id f7-20020a056214076700b00476d5e7e0cbmr3122007qvz.93.1659644236127;
        Thu, 04 Aug 2022 13:17:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id k13-20020ac8074d000000b0033aac3da27dsm1216413qth.19.2022.08.04.13.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 13:17:15 -0700 (PDT)
Message-ID: <94705746-809a-48ee-2aae-6f2878222f95@github.com>
Date:   Thu, 4 Aug 2022 16:17:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/10] log-tree: use ref_namespaces instead of
 if/else-if
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
 <xmqqv8r9dei7.fsf@gitster.g>
 <b4f07dd1-b59d-864b-f881-110c9bf87202@github.com>
 <2d24b539-a5b8-ed7d-2320-97588854eb5b@github.com>
 <96cf691b-5190-5ba7-d612-e8473055c45c@github.com>
 <xmqq8ro36h5i.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8ro36h5i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 1:40 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> My current workaround is to define the size of the array in the
>> header file:
>>
>> ---
>>
>> enum ref_namespace {
>> 	NAMESPACE_HEAD,
>> 	NAMESPACE_BRANCHES,
>> 	NAMESPACE_TAGS,
>> 	NAMESPACE_REMOTE_REFS,
>> 	NAMESPACE_STASH,
>> 	NAMESPACE_REPLACE,
>> 	NAMESPACE_NOTES,
>> 	NAMESPACE_PREFETCH,
>> 	NAMESPACE_REWRITTEN,
>>
>> 	/* Must be last */
>> 	NAMESPACE__COUNT
>> };
>>
>> /* See refs.c for the contents of this array. */
>> extern struct ref_namespace_info ref_namespaces[NAMESPACE__COUNT];
> 
> Because there is no reason why we want to keep the size of the array
> opaque in this particular case, it may even be preferrable over the
> original ref_namespace[] array of unspecified size.  Nice.
> 
> BTW, I prefer to name my arrays with a singular noun, when the
> predominant use of it in the code that is an API customer is to name
> an individual element and use it.
> 
> In this case, many API users do things like
> 
>    ref_namespace[NAMESPACE_NOTES}.ref = ...;
> 
> so a singular name would be more appropriate.  thing[4] that means
> the fourth thing feels more intuitive than things[4], at least to
> me.

This makes sense to me.

> On the other hand, when API customers mostly pass the whole thing
> around as an almost opaque collection to the API function, then a
> plural name is more appropriate.  The reason why I focus on API
> customers is because API implementation of course has to go in to
> each individual element of the array and work on it at some level,
> and "individual access means singular name" rule would become non
> workable.  The names are mostly to help API customers, so if an
> array is perceived by them as mostly a collection of things, then
> naming it in plural would make it more natural.

Understood. I think this array does not seem to fit this second
case, so I will change it to be singular.

Thanks,
-Stolee
