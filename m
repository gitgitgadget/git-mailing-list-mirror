Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE8C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFATuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFATuy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 15:50:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF5518D
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 12:50:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565de553de1so20778757b3.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685649052; x=1688241052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFIlO3mbxXIeTXC3BhNawLUqJS21OG5nkQSlZRPCz18=;
        b=P3sukYYbpfWo1+VRLsEaCIsvftqoQXyNoXH2UwZ5Yo+wTTci7Bih1Xn9+S089oQgbW
         56YjdFkaVl6Yt24B7lF+6a5Ll9jvT0Yrs5k4rIeKrf6titFP+hawNnsJLAF2D9oFcFoZ
         92t5rjHkCNRMr8wIK6TARzyx0jrDagBZ4pHvlmqJzPRrAKXaLiInWOtt+s+utI47zqfA
         h/V7LcWIEFQcOhnKp0F9eSwb/vrj9F8UnRIza5EvLDeqnVqPP7kKdyn5QmCLbeiii3WQ
         cM1kPzv/MGwDdbe0ph7C5jKWHWDqmi56bW9dVaeTbKiqOKGc2a3Zu6PkRHL73SWMJh/D
         rZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685649052; x=1688241052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFIlO3mbxXIeTXC3BhNawLUqJS21OG5nkQSlZRPCz18=;
        b=DPN0iYMBUsJeyk0OavC3XbWIRrPEwr5Kq42g+Xr2xayhoJ3j+Tlsg+jpsfvEterPJT
         pGQkhtaRoinx6vWSwJfRZ+tLdAcvxf0dBVRm3LgteaYpZJoPlsRuIf4P5Dx3kjdOf3se
         Or/AKiU8T7MX9he8/pqd75Cnoke9uZk0hhTMJRFL+D0gAqFwbXqfJf4MZ67l2pA7BeeM
         7s3LAyFBSddC3cpPCu5Kty5OKxYma9mM5X1ZVCqGQ6roRA2OyL4IYBGmUEew5ZoyY99U
         6dcrUNUnmB0YZ/8HrxZfC+8rUmiJ81Zro88uXNnxKrZMrpv1KDOhAfIOPnIWb4XGwIYg
         J6aw==
X-Gm-Message-State: AC+VfDxo29OWfKrUXOxdncfuGDnMxXtFARY4gtEVARXQp+mrg1wutDUM
        Rvsnhr4KpsgPx9SjSMtKKRs2
X-Google-Smtp-Source: ACHHUZ7gXdIDZ7rTIBe21OsGy895fMzRkhD3eSDbrns9CdmV3tuM/u1OEU3bkTeOTABnBlycjw4Opw==
X-Received: by 2002:a0d:d743:0:b0:565:de18:4589 with SMTP id z64-20020a0dd743000000b00565de184589mr3339975ywd.4.1685649051841;
        Thu, 01 Jun 2023 12:50:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c920:7fe5:ab49:f151? ([2600:1700:e72:80a0:c920:7fe5:ab49:f151])
        by smtp.gmail.com with ESMTPSA id h204-20020a816cd5000000b00568c29c3c4csm2562841ywc.38.2023.06.01.12.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 12:50:51 -0700 (PDT)
Message-ID: <72fb4420-2492-e644-58cc-b9b3dbfb8037@github.com>
Date:   Thu, 1 Jun 2023 15:50:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/3] replace-objects: create wrapper around setting
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <5fc2f923d9e6aa13781d7d6567c9bd38a9dd1f0e.1685126618.git.gitgitgadget@gmail.com>
 <49ea603b-ebbd-4a14-e0dd-07078e56de0a@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <49ea603b-ebbd-4a14-e0dd-07078e56de0a@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2023 12:35 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> diff --git a/replace-object.h b/replace-object.h
>> index 7786d4152b0..b141075023e 100644
>> --- a/replace-object.h
>> +++ b/replace-object.h
>> @@ -27,6 +27,19 @@ void prepare_replace_object(struct repository *r);
>>  const struct object_id *do_lookup_replace_object(struct repository *r,
>>  						 const struct object_id *oid);
>>  
>> +
>> +/*
>> + * Some commands disable replace-refs unconditionally, and otherwise each
>> + * repository could alter the core.useReplaceRefs config value.
>> + *
>> + * Return 1 if and only if all of the following are true:
>> + *
>> + *  a. disable_replace_refs() has not been called.
>> + *  b. GIT_NO_REPLACE_OBJECTS is unset or zero.
>> + *  c. the given repository does not have core.useReplaceRefs=false.
>> + */
>> +int replace_refs_enabled(struct repository *r);
> 
> Since the purpose of this function is to access global state, would
> 'environment.[c|h]' be a more appropriate place for it (and
> 'disable_replace_refs()', for that matter)? There's also some precedent;
> 'set_shared_repository()' and 'get_shared_repository()' have a very similar
> design to what you've added here.
 
That's an interesting idea that I had not considered. My vague sense
is that it is worth isolating the functionality to this header instead
of lumping it into the giant environment.h header, but I've CC'd
Elijah (who is leading a lot of this header organization stuff) to see
if he has an opinion on this matter.

Thanks,
-Stolee
