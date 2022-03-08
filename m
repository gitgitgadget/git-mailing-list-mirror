Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFA2C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 13:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiCHNoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbiCHNoO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 08:44:14 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14E613E2F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 05:43:16 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id z8so15496085oix.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rVg6prbbGEgkYmZnzHDS8iJrZPYw3EDqa4MlMZvrTOc=;
        b=R1oOaEHX/Ql0Eld119BETxjOwm0NLx6RQxCx/8aSFPuMbSaRxjodoTuaDMYYSGjqDu
         128QW97+RzUEhIL9zhIITLSHG1M1SPpt/Ar4C/2iu5aX64vJlyTuu0xnmazd7BhGFyFY
         cTOf9ih5x93f3Er07h5snXq10k9F7noB6paoT6Mr8QB1UeCDTbexIsGRdUiSuZWtidjf
         hr29KBpp6Br30DXnnUja7zsJHfpZUNBq5DyjGkWtYOtzjYyvioRD173w6ULtLsyRL4Fz
         dFNkPLE/Oi/FmQSwAIEyGIuH7S/AsqdAx4xVAESPiWPqV6UBpBuqGpwzGxH3z4R9IdR1
         3tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rVg6prbbGEgkYmZnzHDS8iJrZPYw3EDqa4MlMZvrTOc=;
        b=ke8heR+8PBlfuPNo86CgHCIX5sXCgNJOMPHJoiS3Agr9d62juoq/UHaPwlWjGs2pGk
         FdrHEhsGqzzgH+HI18KVLndlSs0EZ7OZNJGFs6yjY0J3oYbJz4nXmADdNc9YQGNyIQ7w
         cHOZ/02EfJLZsk508/QbixB1sUMYbuKIx9FfR553f46Xgk39MfZ9aq3XHfTJUmgFHev1
         Yk3p56/AZX4OFvJFB1M3vOKthdozsPPmILXlwA0DGy6bxpUua/uUmXQ4w+rjE+24Vea+
         Cp6LQIVMf1udh+6wQF/k2QX4eer2QGZbW2gXO5OFX1o0EXTS5hbIc6h1m4X+ZpBtQXHg
         nk2Q==
X-Gm-Message-State: AOAM532hxYJfbqlYfVu39QaKpPAA/SxIb/rjLqNFDHhBCMxSMFUFu7hE
        tASlw1cPAKYamD6EDMu8MCVS
X-Google-Smtp-Source: ABdhPJwNn6XnvJPSQP6vnWVdg92PIsUW9crpSUiagVCeoHR/XHPD4/fHbm79Sn8zW1NmjeiTPOfO8A==
X-Received: by 2002:aca:1b1a:0:b0:2d9:7198:25f9 with SMTP id b26-20020aca1b1a000000b002d9719825f9mr2661573oib.36.1646746996115;
        Tue, 08 Mar 2022 05:43:16 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u3-20020a056808114300b002d51f9b3263sm8057418oiu.28.2022.03.08.05.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 05:43:15 -0800 (PST)
Message-ID: <e5bbc8ed-7d2e-668a-118d-7a13e3b75a91@github.com>
Date:   Tue, 8 Mar 2022 08:43:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 08/12] bundle: parse filter capability
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <898a7d945131042c48f8e99acccf26378a4c8586.1646689840.git.gitgitgadget@gmail.com>
 <220308.86lexkyelv.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220308.86lexkyelv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 4:25 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 07 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The v3 bundle format has capabilities, allowing newer versions of Git to
>> create bundles with newer features. Older versions that do not
>> understand these new capabilities will fail with a helpful warning.
>>
>> Create a new capability allowing Git to understand that the contained
>> pack-file is filtered according to some object filter. Typically, this
>> filter will be "blob:none" for a blobless partial clone.
>>
>> This change teaches Git to parse this capability, place its value in the
>> bundle header, and demonstrate this understanding by adding a message to
>> 'git bundle verify'.
>>
>> Since we will use gently_parse_list_objects_filter() outside of
>> list-objects-filter-options.c, make it an external method and move its
>> API documentation to before its declaration.
>> [...]
>> --- a/bundle.c
>> +++ b/bundle.c
>> @@ -11,7 +11,7 @@
>>  #include "run-command.h"
>>  #include "refs.h"
>>  #include "strvec.h"
>> -
>> +#include "list-objects-filter-options.h"
>>  
>>  static const char v2_bundle_signature[] = "# v2 git bundle\n";
>>  static const char v3_bundle_signature[] = "# v3 git bundle\n";
>> @@ -33,6 +33,8 @@ void bundle_header_release(struct bundle_header *header)
>>  {
>>  	string_list_clear(&header->prerequisites, 1);
>>  	string_list_clear(&header->references, 1);
>> +	list_objects_filter_release(header->filter);
>> +	free(header->filter);
>>  }
>>  
>>  static int parse_capability(struct bundle_header *header, const char *capability)
>> @@ -45,6 +47,11 @@ static int parse_capability(struct bundle_header *header, const char *capability
>>  		header->hash_algo = &hash_algos[algo];
>>  		return 0;
>>  	}
>> +	if (skip_prefix(capability, "filter=", &arg)) {
>> +		CALLOC_ARRAY(header->filter, 1);
>> +		parse_list_objects_filter(header->filter, arg);
>> +		return 0;
>> +	}
>>  	return error(_("unknown capability '%s'"), capability);
>>  }
>>  
> 
> Re the comment I had on the v1 about embedding this data in the struct
> instead:
> https://lore.kernel.org/git/220307.86y21lycne.gmgdl@evledraar.gmail.com/
> 
> The below diff passes all your tests, i.e. re using NULL as a marker I
> think you may have missed that the API already has a LOFC_DISABLED for
> this (and grepping reveals similar API use of it).

I did miss this LOFC_DISABLED use, which must be the correct way to
interpret an "empty" filter set (re: earlier concerns that a .nr == 0
was used as a BUG() statement in some places).

> I'm not 100% sure it's correct, but if it isn't that's also going to
> suggest missing test coverage in this series.
> 
> In any case you want the BUNDLE_HEADER_INIT change, your version is
> buggy in making that header use NODUP strings by hardcoding { 0 }.

Thanks for pointing this out.

Thanks,
-Stolee
