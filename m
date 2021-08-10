Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECACC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A97261019
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhHJN7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHJN7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 09:59:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DCC0772AC
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 06:58:56 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y9so5170261qtv.7
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f/AGlXjF9GmLVzwgof62VWVZ05fr+zL2OKchAdi2eYo=;
        b=qYwEURkfxNIjA1Yz5RxzN+F03AtWHNiL26LvEJEVnfQsnqmEOQlbUXzjiGc9+qW1I+
         znfoK+x+03FGR4UydPuyaYhZgkJTkEYQz4boFGN4T7yfF7PUEXyYtwohzxYUxDIkBzTk
         kG1cv6NsYDoUi7eYUOT58VlZxITLI8ERiMWIb+vcb4ot4fqjsUrt6haijJFEymrnBzQy
         GBF4f5PN5a37b8ivRdrC0DNt2671hh7TrAWHlqu8pdBJrag1PN+2HM8AOH71gZY+AjDs
         d8ISVi03S8wbFaXX0qoYZvc9rp8n62EfyFHhubSIrug0taQQC09nxhHVQLZjdpHPM/Qb
         QDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/AGlXjF9GmLVzwgof62VWVZ05fr+zL2OKchAdi2eYo=;
        b=FZ4vzYBNYAiJ2PFbAIrLz228iZKheClgQna7ZcjN1L5o3Au2vWeUAWkyYj8NfXYaio
         c9Z0jsGbEuI0q6+cVMnBJV5ZT8451qUNG/p8rw5cfQPfhRviCgG1u8CC73yy8HQMhXq+
         8X2W1zKpzt/lw/XY76XB4qvC5G/y6uRF4L7z4L0p7wr8cqhpgIjxoPmboEeyhRAUQVeO
         N5TQ+dPfVUwHwZooDq+EloJPTGMI5kkUBkE99HEz3xCqZSeZTTJXeARAspMKI6u4CJSP
         AtiLSzI4/9uyJi2wDa6w85Bb3PV8AMgrau88OmzKNSLO6p4YP9JzJ1BMkjcuYzFtNi7O
         Jdug==
X-Gm-Message-State: AOAM530mctZXQTAXGiWqEvUjgytchf+8ir5jHuEYdxA3PQ16a/cIWq1T
        23fwmb/Q8m8RPUrXubQs4sY=
X-Google-Smtp-Source: ABdhPJwfDE6hdLZI9sBXtcgqpQ1aOqx9YpCFZi2SRVIKXlAOd12LzyVT7DMiV7eeQo7s/38+VzQrtw==
X-Received: by 2002:a05:622a:1a1b:: with SMTP id f27mr10292693qtb.361.1628603935621;
        Tue, 10 Aug 2021 06:58:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:eca1:9959:196d:81ab? ([2600:1700:e72:80a0:eca1:9959:196d:81ab])
        by smtp.gmail.com with ESMTPSA id g145sm4014986qke.25.2021.08.10.06.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 06:58:55 -0700 (PDT)
Subject: Re: [RFC PATCH 01/13] serve: add command to advertise bundle URIs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <RFC-patch-01.13-4e1a0dbef5-20210805T150534Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c7ba048f-86a9-6f29-476a-7d546e477285@gmail.com>
Date:   Tue, 10 Aug 2021 09:58:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <RFC-patch-01.13-4e1a0dbef5-20210805T150534Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/2021 11:07 AM, Ævar Arnfjörð Bjarmason wrote:
...
> +bundle-uri CLIENT AND SERVER EXPECTATIONS
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The advertised bundles MUST contain one or more reference tips for use
> +by the client. Bundles that are not self-contained MUST use the
> +standard "-" prefixes in the bundle format to indicate their
> +prerequisites. I.e. they must be in the standard format "git bundle
> +create" would create.
> +
> +If after an `ls-refs` the client finds that the ref tips it wants can
> +be retrieved entirety from advertised bundle(s), it MAY
> +disconnect. The results of such a "clone" or "fetch" should be
> +indistinguishable from the state attained without using bundle-uri.
> +
> +The client MAY also keep the connection open pending download of the
> +bundle-uris, e.g. should on or more downloads (or their validation)
> +fail.

The only technical thought I had (so far) about this proposal was that
leaving the connection open while downloading the bundle would leave
unnecessary load on the servers when no communication is happening.
There is a cost to keeping an open SSH connection, so here it would be
good to at least have the Git client close the connection after
getting a 200 response from the bundle (but not waiting for all of its
contents).

Thanks,
-Stolee
