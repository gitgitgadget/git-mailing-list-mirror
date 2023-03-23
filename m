Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E764AC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 13:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCWNiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWNiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 09:38:04 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910FB44F
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 06:38:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bk5so6855214oib.6
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679578683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDXua4xM+v64v2px6VNyg0zVqTVu8Njyki3OWRChK/o=;
        b=hpcOkx6D5eBOZoXMDb7JkUvG7NkJeaoUZTX99XxzlWw+fEjU5SSKXYSftCtNy2iywn
         ZAaBgFt8M3VexZWlOGLAM5YPTHgWylad2UEpFZ6kd9M321sW8W0mMG8u8fVYmcB7WFrg
         h962U8wxLlIaVkPScayQPKH1bf5Ui0VAC1DAqiyzYTSf2gAuoF569OJ9Lsoy7R3osu7g
         fvjikmoKW9yDScMaimrXNFoTd+ojzWtXNBB5RftWNgftJZwyd8/1tWY7ElPo6IusAMIL
         WE+NJsnctvD1OAIGjhn20ovRX2HbuAKXmVRup9OyfVyns5aCNb5HfQxhYEQW9PUi8DLr
         7iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679578683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDXua4xM+v64v2px6VNyg0zVqTVu8Njyki3OWRChK/o=;
        b=1Eb2O5g9lSg6Udin+7uGlXTEAJwTCPahyB9dXAJ8CcD71nPw9sJwXDoZz9R7AydfVo
         LF9X5uQhsR6IuJWqTLWdlIy6bPcaWDT3T7ythNMxmjpkofQZtioSwN97UzTXU/BqEkAp
         tckT1Zfgw71WC5058n9wvyBxQ9cc2qbAA/j7gXco6PU5Gm6HsJmcJQBmAK+YJ+oVPQre
         EbHtQ8r/odmDmGyJAn5LK79NKqQffoXSSDCqpw2lLZZsuETCOkKx4RapnunzNdlY2np1
         K7/pMoA8wd/NqHecd1+uLgkwDZgCICeo79zz4aPaFEs2gtXgwSJk7U1ds3/J4YX/t5EB
         WalQ==
X-Gm-Message-State: AO0yUKVUfyl+YyYiQoqVfSXLg6tPztPpvXRg3/hL5qNlQiYALIdJoqzJ
        8/2QWnvygTiebdT/GSzPh+sc
X-Google-Smtp-Source: AK7set9ZwIbwHEOMT9Zvhg4CL2xCq6DVuyOP7p5zlO/9SLR+/PlErFYOz5++LbcJw2oSTg/tvQbSmQ==
X-Received: by 2002:a05:6808:1443:b0:387:1bf:26c5 with SMTP id x3-20020a056808144300b0038701bf26c5mr3559487oiv.16.1679578683177;
        Thu, 23 Mar 2023 06:38:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:91a9:67a3:eca8:7366? ([2600:1700:e72:80a0:91a9:67a3:eca8:7366])
        by smtp.gmail.com with ESMTPSA id 65-20020a4a1144000000b0053bb063121asm212135ooc.9.2023.03.23.06.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 06:38:02 -0700 (PDT)
Message-ID: <c1ec30b8-7659-d02d-e0ac-2db424bf4feb@github.com>
Date:   Thu, 23 Mar 2023 09:38:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC][PATCH v3] GSoC 2023 proposal: more sparse index integration
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com
References: <20230226083347.80519-1-gvivan6@gmail.com>
 <20230323063844.23222-1-gvivan6@gmail.com>
 <CACzddJq2USyx4ttdj9rjFJubkq-6GiEirrJJ-qym7ZmOPs+mOQ@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CACzddJq2USyx4ttdj9rjFJubkq-6GiEirrJJ-qym7ZmOPs+mOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2023 2:50 AM, Vivan Garg wrote:
> I have taken into account Victoria's suggestions and made the necessary
> changes to the previous draft. I would appreciate any feedback on the
> revised version.
> 
> Additionally, I wanted to inform you that I had planned to begin working
> on git describe, but unfortunately, I broke my ankle while skiing two to
> three weeks ago. This unexpected event caused a delay in my plans.
> However, now that I have adjusted to my new lifestyle, I am confident
> that I can resume working on it.

Ouch! Hopefully things are healing well and the stress of this project
won't delay that.

Thanks,
-Stolee
