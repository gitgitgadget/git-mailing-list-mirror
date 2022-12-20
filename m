Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47D8C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiLTN5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiLTN5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:57:10 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B81AD8D
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:57:09 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id x11so10909298qtv.13
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZReEnepLhav0GfPdYq6SdcknLe/8w4Vjw1eyXErLNg0=;
        b=OX2nhmXb5/xH0hf03+9d8QaQVmxCJwDUhRWo40PFkCqXcel5zgYy8u0slWmbYCTXUO
         Um5dVilUIwynubnwzjoUUK/Xa+UeyBnHXLAnuftTVantKMQPIGVTIMX3XvT1Un0hJ+0I
         dII/v0l7Xz+NSG4uD1EcvGBuf3cfA2sAyDQsj59s4ZC+USOgvKnn7io9qRNs4p2zCoot
         I+Ee/PDgzsKQ4MLHo1DKHy9RGQzBj88T2nrTuOrWuafgz1md1qdQ3NB6buePNWJ1B2xG
         VC52rEbPsLrRnc/Z0FE8HFR5TEOUeDEF4TCE7oDJqqg38wx+jq236qymmJiIZqNadHAh
         HxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZReEnepLhav0GfPdYq6SdcknLe/8w4Vjw1eyXErLNg0=;
        b=1zXpBGBvO0KXNNcb6DGgZT8fv9fL4lvPKQIwon7efM+NaDj9huAt7oq+tRsg/fSgiK
         +9xpfJB+2fZHO6Uw7+e+MNTZqIHi3I/pXyiIVwXLaIeVXmVD99rQdSs4n7ZZgqlmpHXt
         6TeP0pvx6+W0TbPeKxXXTVG64tIOY1B3Dw12nL1wlpGJDij894cejdsCVHidi5kwtzz3
         cb7HG7IIoGcteIJNBk1TKNIsn7mbWOU6zbnIaE5lgoF6c9GSU42PqumwW3gn4V/I+1Ur
         +rJekb6NMJdIyxQy+T4F23vVEcV1QneouFnfUKhUCJ6I+JJPB+xPZamcFb+yGTFIOz/U
         WAwA==
X-Gm-Message-State: ANoB5pn63Pp+iWQfxXSMODmAcYFKvTTzHto8lKsJU0Km9gxZjNRfc+yT
        AA4WRil+6SSCb93zTQ+z0cIK/gRr7calINw=
X-Google-Smtp-Source: AA0mqf7zEL77W5DdwQxF5whXM5j1FRB7sjdWsMqeR/saBqs8xojGR2YFmZfcbEmCoYOmK3g8AGRVWA==
X-Received: by 2002:ac8:51d2:0:b0:3a8:171d:2414 with SMTP id d18-20020ac851d2000000b003a8171d2414mr47133530qtn.15.1671544628909;
        Tue, 20 Dec 2022 05:57:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6103:2a44:3e02:702f? ([2600:1700:e72:80a0:6103:2a44:3e02:702f])
        by smtp.gmail.com with ESMTPSA id de26-20020a05620a371a00b006cfc01b4461sm8853462qkb.118.2022.12.20.05.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:57:08 -0800 (PST)
Message-ID: <75107325-bd28-1adf-b260-ba8846c63229@github.com>
Date:   Tue, 20 Dec 2022 08:57:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] bundle-uri: drop unused 'uri' parameter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
 <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/22 5:57 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:

>> @@ -112,10 +112,10 @@ int fetch_bundle_uri(struct repository *r, const char *uri);
>>   * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
>>   * bundles according to the bundle strategy of that list.
>>   *
>> - * Returns non-zero if no bundle information is found at the given 'uri'.
>> + * It is expected that the given 'list' is initialized, including its
>> + * 'baseURI' value

> The same goes for the added docs, that we "expect [that] 'list' is
> initialized" may be true, but that would have been true before we
> removed this unused parameter, so let's not stick that in this unrelated
> "UNUSED" change.

It is _not_ unrelated. The 'uri' parameter looks like it should
be used to determine relative URLs for the included list. However,
this reasoning around the 'baseURI' value points out that we are
using that value _instead_ of the 'uri' value, which is why it
is safe to remove the parameter.

Thanks,
-Stolee
