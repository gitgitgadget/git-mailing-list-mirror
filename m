Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E86C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 13:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiCGNun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCGNuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 08:50:40 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E098A6ED
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 05:49:46 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so17731945ooa.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3eRMED2JpIV8L14Xf5ZLYkZqwHAAAwChiAa2yez24Dw=;
        b=XPyseFdpvOA26s/F7xY7W+LIxPTKYHRgIYV+oIkglZBF27sMT7L3fkUY87ERb+VB4c
         pe4L7v5MNI5AcNeRkTy51tq+yoihWT+G73QQCeCUgn5q4qn9xVuJ5lUy8nW37+nIB9X3
         LlR8vykgL7WdYh7LdD9J7V9D/19M3RxpzoFJVBaYlM3pCwpYUewcXpcslfdyQypgZHFU
         N3nTzZR3aJ6FhNohB0MqHHgM5PFzTt8KWjehnzV0fUIpp90y6evINDxUiG594RB7nWAH
         XteqaXd0szM9I3VHRUeyAPd+Gn4MewC+hkMP66RNjXviQyRfhAkbw2vg4bQy7iOeUqYR
         Frwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3eRMED2JpIV8L14Xf5ZLYkZqwHAAAwChiAa2yez24Dw=;
        b=FHIEbIeziFSiemicoIp0aPfYfhAtpihUC5gk1mPAXZrx6in58BSNOlp87AH1MkQVDm
         pWXT2RXV+GSu4Gb+WrEbLh18+ryc+qYAI6HbYoHte6/ei8ij7UZQdBBXvudBegWVZlIf
         9zc1MVlnuhtgS1E36xicWJqmKRjhSqv7PgPSaFIf/sq81ssS02ETFsRYa6sxe/y3T7NC
         O41D8os91wDjmDlHmML0OTHClwVRXdPlIUxES7WNA06tpC1klkg0vjzNLgNhayz3djC7
         JB7091yJ5rn9JZSR2GdcxZQFupmQbWbG37ON8q7maqqBaKxhH2Fa26xEj0ckNEr1EAw8
         D0gw==
X-Gm-Message-State: AOAM532wtz3G8csbaLjepcYptpLsNeDdodt2dfuAloFzeMupZSMj1+WX
        XawaBWxDkT5BX53BghAbP48bgbClybR+
X-Google-Smtp-Source: ABdhPJzyjmgdDvSHX2S8n6WTVMFGiqYz2jaODp0JXU6KuL/IbRlYWhL58EkxyrbK8P0bDXDNo3eV7Q==
X-Received: by 2002:a4a:5a45:0:b0:320:b9ed:a277 with SMTP id v66-20020a4a5a45000000b00320b9eda277mr4531808ooa.90.1646660984704;
        Mon, 07 Mar 2022 05:49:44 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm5630345oou.10.2022.03.07.05.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:49:44 -0800 (PST)
Message-ID: <3683c549-6efc-2c67-1130-d7008100ee55@github.com>
Date:   Mon, 7 Mar 2022 08:49:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: ds/commit-graph-gen-v2-fixes (was Re: What's cooking in git.git (Mar
 2022, #01; Thu, 3))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>
References: <xmqqv8wu2vag.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8wu2vag.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2022 11:31 PM, Junio C Hamano wrote:

> * ds/commit-graph-gen-v2-fixes (2022-03-01) 5 commits
>  - commit-graph: fix generation number v2 overflow values
>  - commit-graph: start parsing generation v2 (again)
>  - commit-graph: fix ordering bug in generation numbers
>  - t5318: extract helpers to lib-commit-graph.sh
>  - test-read-graph: include extra post-parse info
> 
>  Fixes to the way generation number v2 in the commit-graph files are
>  (not) handled.
>  source: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>

After discussing the issues in detail with Patrick, it seems
that an additional patch is required (submitted in [1], though
I incorrectly numbered it "5/4" when it should be "6/5"). I can
also re-roll to make sure that the patch is visible inline with
the rest of the series, if you want.

Thanks,
-Stolee

[1] https://lore.kernel.org/git/db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com/
