Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E51EC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 19:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiCDTLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 14:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCDTLr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 14:11:47 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10C20DB0C
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 11:10:58 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so8162211otl.12
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 11:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rFsnHouLl4oeHwVkUj7tMG+KYjlpThlwg9CB3ECgLMs=;
        b=DAgH1Uk9+Btk0RLpUEjnFBG+GicHMJWO8OT2vQAz5jI7rHH1UhTcdwW7920Yc09S0a
         PzHQaRYCsN7Ut/5hAWM6LWspBYSpEIRSHp0YpsinU99yJbTIYuDl4VGvQTwr8xscf/hD
         O51u0BgxF1Yts2EuBE8rzKhZbnp0F0pL33e1hcjJmuXeRwloRixxbJZDfn3X7VGPGmyZ
         3pIEZgR67o3etAmsKGds/1NemfbUI8g0umzoe1xVu/zKnJL9DwJiZbKj+2c7BgVjogXS
         +VNRjsKq3oJffk08UNRA8w2dNP7Q8wdgkEa+pLYBlDtYgQhIePt1diknssCcNecsDLu2
         VSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rFsnHouLl4oeHwVkUj7tMG+KYjlpThlwg9CB3ECgLMs=;
        b=c1bmU/Njcz420VonWj+8xlopYq0Ylw32CKcfRca+repTbrLEmeK/WUQ6CKGfErIufI
         g/ZgAFEOH/vK46tUCsmAyLsn6BPY2I6+7+Gkv//o6q8Ox134xWdnO9XJvgoBX7Rpr3pN
         OhnFdZDLd2G0X+MFzmfSAhR7Y+HCLx1IWLHvH/NMKmx0LdEHs2ECYUCwnYrH8M7ccVJu
         kyEaYGDkxVbsbpPhv7vNvLPRRtGp2KudUi0weKXc4e5H+f/ZYmnMlz4kERazvBemYnGy
         PQCudPwmFtB5v6XhjIjb06nanXhUR+A+eDYJxahED1YeYbd8LJRtcrJfAPo3CMCEUPxA
         02Ig==
X-Gm-Message-State: AOAM532t+tK96c+tjt0VHOm0ZngJdrzMB7yvAskk8P8qKIeSMNyfC8pg
        YwzJhXesHysNClQ1BxZJCR55
X-Google-Smtp-Source: ABdhPJxQtXTPLVqsFVRlEb7nde9Nl0G66vSy+VcG8eKrKvrgi5lz4jjSFFKCu/+aYz9K2a8uJaG01w==
X-Received: by 2002:a9d:8e6:0:b0:5af:60ec:da70 with SMTP id 93-20020a9d08e6000000b005af60ecda70mr85378otf.165.1646421057485;
        Fri, 04 Mar 2022 11:10:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id kz3-20020a056871408300b000d75f1d9b85sm2617453oab.50.2022.03.04.11.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:10:57 -0800 (PST)
Message-ID: <70a882d2-5a57-696a-b079-ee738df57eaa@github.com>
Date:   Fri, 4 Mar 2022 14:10:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 07/14] transport: stop needlessly copying bundle header
 references
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
 <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
 <patch-v2-07.14-b3f7753a790-20220304T182902Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-v2-07.14-b3f7753a790-20220304T182902Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 1:32 PM, Ævar Arnfjörð Bjarmason wrote:
> Amend the logic added in fddf2ebe388 (transport: teach all vtables to
> allow fetch first, 2019-08-21) and save ourselves pointless work in
> fetch_refs_from_bundle().

> -static struct ref *get_refs_from_bundle(struct transport *transport,
> -					int for_push,
> -					struct transport_ls_refs_options *transport_options)
> +static void get_refs_from_bundle_inner(struct transport *transport)
>  {
>  	struct bundle_transport_data *data = transport->data;
> -	struct ref *result = NULL;
> -	int i;
> -
> -	if (for_push)
> -		return NULL;
>  
>  	data->get_refs_from_bundle_called = 1;

The inclusion of this line dramatically changed the shape of the
diff (different areas got selected as adds and deletes) so the
range-diff looked strange, but the end result is good.
  
Thanks,
-Stolee
