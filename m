Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F7FC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8BD207B6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgLWEYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 23:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLWEYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 23:24:22 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF478C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:23:42 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s75so17105844oih.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=b2byszrVkceTfxY2xw2HdZtEK604VSv07DBQt1B7vJA=;
        b=lsEETJdYOlbp1sBl/dP/SNYw3hNSNpX0rYpzYII5MgytT4eIK8C6woe/7YwL7/schM
         BUHyKDQkB8OYU9ZgWecAVvqsJqVNlk9MsYaG+ahn5uJKNgSn0iwd9CDyChHdXzjEoSrK
         7KekwDy4/ekns2b5U07dEOk5L5WYa/9RpHC1eHNg18FjTVRVkhiuHtEmFM3mflWODOHH
         m1PtWE18c/6M1avGorQrYfnuCQYRF7wDZIof4q/QoWvALbilJprI9CSFK+bGHyk7ut3I
         7P1f4MGG4YaZV1cpcS+HipcFt7zL+dzCMg06RA709CBVLrSjvvFl0gQLF6/iyKgvekts
         OpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=b2byszrVkceTfxY2xw2HdZtEK604VSv07DBQt1B7vJA=;
        b=sesL2wq/1GlwH71QqxSXkQWCAjJcdLXhQBBfmT7GwMiYjJWRPJkkHeAt+Q5vsbhq/n
         hxWi/6zEgEHJu11+OFIV5C0+6sGB88Tu2iYTWkPtT1WKeMe2tOA1f78VD7a2CUOP+Y8A
         a3w8whws3GLTgmApZuo7IUL6tsfEjZa0EIRV8AbJtdu1TpBJDn9CVWZA7TFQEo3D8olU
         Utvgq4SsWVWnPkO35nNcnfqUNSVHF51UuNkRE7bBU9f4/JNKfw5eH3/z0vWTV1MlomNH
         kNC/kquEDg3FzjyQt73rW2H5vOKt+bXPPaYhv8kG4IeOlMPnMAnDnP6GxQ3h2mr4MUQa
         elww==
X-Gm-Message-State: AOAM532gypZPcPkt3pCQhZOMdDEEdZ7SzJZsAFucYbo1qKbsbFIKlgQ/
        dO+4Q/JFfJF4kZuBtK0dNnZDNjSYiGTG/A==
X-Google-Smtp-Source: ABdhPJytq/ecbxUeNdginPio5lnJuod5ARiACqcEslg8eroMs3Dz+tCcpWxzoYICg1h4G1V9u8zZHg==
X-Received: by 2002:aca:b03:: with SMTP id 3mr9579911oil.157.1608697422100;
        Tue, 22 Dec 2020 20:23:42 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o49sm4914624ota.51.2020.12.22.20.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 20:23:41 -0800 (PST)
Date:   Tue, 22 Dec 2020 22:23:39 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe2c64bd3790_17f6720897@natae.notmuch>
In-Reply-To: <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
Subject: Re: Code of conduct violation?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav wrote:
> While calling someone out like this is not the right thing at all, it is 
> a good opportunity for some introspection. I do not participate in the 
> threads you do so I can't say much about these "never-ending, pointless 
> rant threads". But if enough people feel this way, maybe you need to 
> dial it down a bit.

Dial what down a bit?

My opinion is my opinion.

If they want to discuss my opinion, then we can do so.

If they don't want to discuss my opinion, they can agree to disagree.

But I'm not going to pretend I'm fine with a change I disagree with; I'm
not. Especially when nobody is paying me to do this.

> The community needs to do its part in making you and everyone else
> feel welcome. At the same time you need to do your part in making
> contributors, especially the new ones, feel welcome and appreciated.
> Being overly critical can turn developers away from the project.

Who are you talking about? I'm the one who made the contribution.

Cheers.

-- 
Felipe Contreras
