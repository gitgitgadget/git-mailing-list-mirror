Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE0C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjATPrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjATPrL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:47:11 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F869742
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:47:06 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so3275408otk.13
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfeQ1rP/xW9BldjN/rwnMq3FbJmiKHP1urUjFecM15c=;
        b=Ds3/1Y9x3Kn8cuT0jV49prqp+k3wFHWaWJhWj2tK28oeN2YElFxq3kPgH8JdDcHP0Y
         sKm1MuNbCLCJnKUbeYb79/7uUgnpmqkf/XHXlvooefLKiqe/OT3MlDT5sfBY69DtC0T7
         8uKIpO5u+dqUL6jhhSfZ9q1POJbbpWpsjtlGgqUPd7QVO1C/rD1NBfLTzBJy248kE6g8
         zHrrQVilqWxwl1kJdGIHcAj5kmhPKNc3rs4wTuS2UURkdLlD9qjBPFrd5WjU5eWJeolJ
         YLFqB+Bi9fAdzAuhEzA/uj5iNc/eeTX+FimyYsiLYi/YL8REAUqxx6VtzcOPVkqCmPrQ
         I1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfeQ1rP/xW9BldjN/rwnMq3FbJmiKHP1urUjFecM15c=;
        b=DUPQDq/2t9BKxLBOXUfyKjCk4nOGM160t8+Q2uAFV1Ac3MMFjJLm/vzdVuz02S/Dl7
         FfM+pYKml+M9cCmg5S6w1UA1kq4/ESEvz4rmEW6WknMW0VkTulB4wgYrqw/8L+IHi58S
         HNSY9tjGPsyvhknCVLWmV03VCwlAtYDGpNYGi5tdkX06x7ajx3kV3g2i1kVPeoB2TmHR
         CI88f1wNxe8sSzXNRP4Nzli9I9WHOnNfsPC/ounUY2GdiNR3ePrZXas+GFXKnUttOWwW
         u0c6IDXdpj9swnI+neLhHWxLGyUjKxXo+FaGnTzEjVgR2aFkydpWRpva4zNcpX7jLm7i
         JhEg==
X-Gm-Message-State: AFqh2kpkCXvyRl5YlspTYm4Zlw4DGZrYKneuAxJDqQKhPh7ZBWsktHBw
        YDRSGVz7Rk1mzvuJY8XOtueT
X-Google-Smtp-Source: AMrXdXtqMtHFVnMOmjdUo+Bha00vXL9WkJi9RLP28U1LUcYSSowH3IKYlEommngRjcfJ2O3JGwTftg==
X-Received: by 2002:a9d:6959:0:b0:66d:e67c:6455 with SMTP id p25-20020a9d6959000000b0066de67c6455mr7504503oto.28.1674229625732;
        Fri, 20 Jan 2023 07:47:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ede7:6bce:9af7:733c? ([2600:1700:e72:80a0:ede7:6bce:9af7:733c])
        by smtp.gmail.com with ESMTPSA id l15-20020a056830054f00b006864009705bsm7436888otb.55.2023.01.20.07.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:47:05 -0800 (PST)
Message-ID: <4e2ac966-0f45-8018-ff8f-3831ea0c3c2e@github.com>
Date:   Fri, 20 Jan 2023 10:47:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 7/8] fetch: fetch from an external bundle URI
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <1627fc158b1e301a1663e24f9f21268b4f1caa55.1673037405.git.gitgitgadget@gmail.com>
 <58269fe6-ebe1-7b12-4cd9-2110a94543e5@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <58269fe6-ebe1-7b12-4cd9-2110a94543e5@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2023 3:34 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:

>> +	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
>> +	    !starts_with(bundle_uri, "remote:")) {
> 
> Maybe a silly question, by why would the bundle URI start with 'remote:'
> (and why do we silently skip fetching from the URI in that case)?

Thanks for catching this. I originally was going to include fetching from
lists advertised by a Git remote, and use the same `fetch.bundleURI` config.
However, it makes more sense to make a `remote.<name>.bundles` config
instead, so I dropped that functionality from this series. I forgot to remove
this `remote:` case, but will do so in v2.

I've locally fixed the "objects" typo you pointed out, too.

Thanks,
-Stolee
