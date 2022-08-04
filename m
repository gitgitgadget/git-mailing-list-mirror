Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4CEC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiHDNaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiHDN35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:29:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9C433362
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:29:54 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h138so1143397iof.12
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LhjtneiyXkvMW5dn92j6OSI28gwaggn3TKk9EXYBB1s=;
        b=ZWLI3xs03fNnZiN/4y8nNOX1Iir89faNA+IhxSqNLK4K/4iVYeCwbXTf/l6RTEcvMQ
         E7Oi7aLRkefEzrzIv6o0PKbC9QRTegvTjn4YWZsFWnLtl8AnfGP5+pBycP8HL7RC8ZqF
         KiXc35GXQox8L/Fdn7H9kLVqIlq0umaz1vDdpOF+ODDgEZkQhte+TXN/pZBLgFhqFemf
         boNZ56DGX1Kb21PHy/UtlM8onqXB/dVuhkVPwiN9wUYD7g5CMuPn4S859i4U153oy1N7
         hmVj6fDdWbDG5Z7cKeRSEHIvJ85qwEDVT9XC6xc+IZS0yeelub3m7RrcwdprM/na9/QZ
         EcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LhjtneiyXkvMW5dn92j6OSI28gwaggn3TKk9EXYBB1s=;
        b=5lhdo0QVlZENsgVIkmQBz3o+whM2PYvY9bGNA4yEzhJoj4mzAVIjalYu9ybSS9/GDb
         g713K8oPD53SNz/oMlcMAognx/EZtiJIpjn76omUTWDmUf6kfae9X+sIR4Mhv3jT8Ja1
         aXTjuP8aUfQZKccz0wLLBr4eACwkEp18/tK3uanf1rB9KqACIZp+tc2ruZ1+gJQdMUWa
         G8VmJnEbriN5w+rWpWHUa9XqnC3EAKQPUID/pej7rCE/diZ6H5uNjrYvWkcBH5X6GLrw
         aTYVEPTvC94Ss4Neej3R6DhT8lHHEfRm2Ee/WYoNWubBAt0Pm0UaLO3+Uc5yHrfHt+z/
         e8sg==
X-Gm-Message-State: ACgBeo0K0bkgis6hNw7KzApJCvWiGHAvhYXsVMJ9GXdlb9M15v0zsJjl
        TS3orCXdQtn3CnsNtr0OYa4D
X-Google-Smtp-Source: AA6agR69P6tv1V9sXilVMwG/aMD/RYqPRARxOL2Z4P7NzqlC8qw3oA3KOnifXWUa6dsCjc+J2CGOZw==
X-Received: by 2002:a05:6602:3c8:b0:672:4e60:7294 with SMTP id g8-20020a05660203c800b006724e607294mr791324iov.17.1659619794171;
        Thu, 04 Aug 2022 06:29:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id x19-20020a026f13000000b00342a1021507sm435130jab.123.2022.08.04.06.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:29:53 -0700 (PDT)
Message-ID: <cba0dc06-9fc5-772a-53fd-3ec22c04153e@github.com>
Date:   Thu, 4 Aug 2022 09:29:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/10] refs: add array of ref namespaces
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
 <Yur5OmTAYDx0ifsp@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yur5OmTAYDx0ifsp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 6:39 PM, Josh Steadmon wrote:
> On 2022.07.29 19:29, Derrick Stolee via GitGitGadget wrote:

>> +	/*
>> +	 * If 'exact' is true, then we must match the 'ref' exactly.
>> +	 * Otherwise, use a prefix match.
>> +	 *
>> +	 * 'orig_ref' is for internal use. It represents whether the
> 
> s/orig_ref/ref_updated/ here I think.

Thanks!
-Stolee
