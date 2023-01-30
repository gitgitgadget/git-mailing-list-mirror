Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D977C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjA3Srf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjA3Srd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 13:47:33 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA61BADA
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:47:32 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso910535otp.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcDC3hsJ0w66Ua16oDlLV7kTzRvG7Shqjl192MOCHGI=;
        b=UKEE0QRYVDCab9lDlC/Yfaf1F56byP1+K/z0qghl2IdCHHIaYaRTDCpVA96/ey+uRJ
         BJOWKLHiLj1JrLrjmrIcnHzF+2ZzsHBFqYc9Z+hIACFt9OjRJ02jdZtWoeKpk05F8Dvq
         +bwLiVgpHSYBHFC1ptmRm6r5cx4spZM3Mk5VuOgoHI9H+gD8C+aXGjaNiP+2cSkERsxT
         mHTppzg5xeU//+b5GeqhKOsn7CjHVw4Nl6ov9D3mMctnHZilG1J/mH937r36460PulUF
         lgdBRqZctpyoVssWEOq85ccRo0N7lU257b/M9PvJRLEi4CzLN7B17359ocDVIbzdbdxz
         uIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcDC3hsJ0w66Ua16oDlLV7kTzRvG7Shqjl192MOCHGI=;
        b=1KQd8XdzVv938axwdP47NztAnkkpDje2pWTnILEdenA2zLDJkT5fJCeYgAWUEIUS3J
         kSpsfvlPytBtcsWNuykecvR+gWt0YkU1yR23NNvFt4ed6IKyTLfWtOuulUAh6QIhcu1u
         Eg5qIbj19Yj2QmsCtW+I8cY/Owj1vQytdkjd4oS79E+LRH6YgeHBCfi4uRiAq2KO3r45
         fX5/HVm45zJgi5f+DXcNATw1d1/0eBR/0lcK9Nq32MrS5NyIzQJDwxZnv7y/erty8qyB
         1d2yUbJgCGb6CH8fB/+O4eHCSM27/4COQy1Ir9yzhovniK9kOWAKAnj39cIvYAcaidv4
         NYww==
X-Gm-Message-State: AFqh2krlCw/Z9hR3ChNU6KR190Ue7ODsdtY7yf2rPMmitQ4oK0+PFXYj
        GIZiRaGn/yoYL0Ee32LZb2B6
X-Google-Smtp-Source: AMrXdXs2bVUbxeGD9Kdz4AzdFR/XANp9NwDAI+pv4ReufZF6V715CIHxorj2biqLYrXXtgvFxTVpyg==
X-Received: by 2002:a9d:4f07:0:b0:684:da63:a710 with SMTP id d7-20020a9d4f07000000b00684da63a710mr26277109otl.4.1675104452287;
        Mon, 30 Jan 2023 10:47:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68? ([2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68])
        by smtp.gmail.com with ESMTPSA id w25-20020a9d6759000000b0068bd20cf07dsm1552328otm.48.2023.01.30.10.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:47:31 -0800 (PST)
Message-ID: <d93aff7f-2fcb-1d4d-4537-c23ea7171215@github.com>
Date:   Mon, 30 Jan 2023 13:47:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 10/10] bundle-uri: test missing bundles with heuristic
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <676522615ad0e8f24099ef35a0f39367e5f688ae.1674487310.git.gitgitgadget@gmail.com>
 <b3f2992d-f614-5cc7-f606-d3607a154685@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <b3f2992d-f614-5cc7-f606-d3607a154685@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2023 2:21 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> +	# Only base bundle unbundled.
>> +	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
>> +	cat >expect <<-EOF &&
>> +	refs/bundles/base
>> +	refs/bundles/right
>> +	EOF
>> +	test_cmp expect refs &&
> 
> Maybe I'm misreading, but I don't think the comment ("Only base bundle
> unbundled") lines up with the expected bundle refs (both bundle-1
> ('refs/bundles/base') and bundle-3 ('refs/bundles/right') seem to be
> unbundled). 

>> +	# All bundles failed to unbundle
>> +	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
>> +	cat >expect <<-EOF &&
>> +	refs/bundles/base
>> +	refs/bundles/left
>> +	refs/bundles/right
>> +	EOF
>> +	test_cmp expect refs
> 
> Similar issue with the comment here - it says that all bundles *failed* to
> unbundle, but the test case description ("Case 3: top bundle does not exist,
> rest unbundle fine.") and the result show bundle-1, bundle-2, and bundle-3
> all unbundling successfully.

Thank you for reading carefully. I'm sorry about not updating
the comments after copying these checks around the test file.

Thanks,
-Stolee
