Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21D8C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A535460F90
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 14:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhJZOIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhJZOH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 10:07:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D5C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 07:05:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so19981350ott.2
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NU5m3LMSkVHKluV59A/97RbGFp+Ca0WqoGb4kIwPk18=;
        b=WvNEtTE/tOnrSDZ7fcEvFNI/6Ca+u4VJPmri4FzsCT9a9SOefZzH9DmahMKQ1+FGA8
         lWLHmBizTW8uBT9RAbRLf8lLsOMNG6qgiT4oVOggZjm/Qm1DXgS0P1sB/p6uhpANIp6f
         XPQzYITdJyycgKqHzjFPjm8gCHn0n2TiMzVTKxgmlAoV+8S5rpUthtFR6CreWgdBj3v2
         snvq2iM5bKO92764L621kNcPMyz4BtRHgJC7yRmINFY7rqV60KxPoOqWOh3jntVKyuWw
         IBCUWNDlYWVNaIj94SzpS8zPwtJVGfOyaVDx7/jEBEXMN6pTZmKIvUsjd8UbpIhKFVHd
         o8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NU5m3LMSkVHKluV59A/97RbGFp+Ca0WqoGb4kIwPk18=;
        b=xC4DY88R2ZzOOxkS6EiiiQEFh+Sv3ZKVS0ojXgyy1FQwhSxdvnwKzECsoyFzvqGSW3
         +MmVFWU5KrkmtED5XMQ9HE4NWDfgwWqvrJMmewdVWrn3wTjhld4ePGaff3TqUbNRSFOO
         P9kbN50xmicTVX02N2aRvd/mjzZpJUpEJKy4468B3lQEWMB0IvEFfG1yOxOsl3+yiosL
         8pTZyHsHZCu7dOH999MliUC4a2PbXtXSogP64g3drGt5VMy9fOmqSulVZpszSkPBj5aJ
         Nl3t7YhDFgjMuITPF7ZX0AOfu5AiShyo7DqzNrIKx3P50Uv4VU9Y6jgeJtDlSrlBlPgZ
         Cz0w==
X-Gm-Message-State: AOAM5317Rob+ENnC3AvJhq9VfaSm4RMWBniCNz4F+ISIApxsVVlMHgVi
        ljci5Q/BQ6/x8e+H8DGerrQ=
X-Google-Smtp-Source: ABdhPJyGQLn4pN8h7MdOJ9/SEnTV/kFnX37qwvV+f1FsTFAkzRwGC2TDmRazGKasezoxNXHaOoDzjg==
X-Received: by 2002:a05:6830:164b:: with SMTP id h11mr20427534otr.244.1635257133596;
        Tue, 26 Oct 2021 07:05:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:86f:cede:45bc:10f6? ([2600:1700:e72:80a0:86f:cede:45bc:10f6])
        by smtp.gmail.com with ESMTPSA id r44sm4754991otv.39.2021.10.26.07.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:05:33 -0700 (PDT)
Message-ID: <3de22cec-55db-6ff3-c009-a150647fef38@gmail.com>
Date:   Tue, 26 Oct 2021 10:05:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 3/3] bundle-uri client: add "bundle-uri" parsing + tests
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-3.3-64224ec2cba-20211025T211159Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <patch-3.3-64224ec2cba-20211025T211159Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2021 5:25 PM, Ævar Arnfjörð Bjarmason wrote:
> Add a "test-tool bundle-uri parse" which parses the format defined in
> the newly specified "bundle-uri" command.
> 
> As note in the "bundle-uri" section in protocol-v2.txt we haven't
> specified any key-values yet, just URI lines, but we should parse
> their format for conformity with the spec.
> 
> We need to make sure our future client doesn't die if this optional
> data is ever provided by the server, and that we've covered all the
> edge cases with these key-values in our specification. Let's add and
> test a bundle_uri_parse_line() to do that.

While this implementation is interesting, and the tests available are
useful for validating the protocol, I would like to see how this
integrates into a full 'git clone' operation to be sure that the API
is correct. How much more work is it to implement the full end-to-end
scenario?

Thanks,
-Stolee
