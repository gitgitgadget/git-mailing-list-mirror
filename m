Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8FC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 10:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384502AbiEGLB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiEGLB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 07:01:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93732EE3
        for <git@vger.kernel.org>; Sat,  7 May 2022 03:58:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c12so3788808edv.10
        for <git@vger.kernel.org>; Sat, 07 May 2022 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hhzFri+umKGqsjlPPoYc/+Cc98MC69t0wlXD1xqg8FE=;
        b=FcAODRdH1tLa5KNVxu4Rr6gsKGZ5J8heZ7tVC5021vXNCCxvbmFoGl1kMFw/2+fQV1
         Iz/E5nOeHqsDFmr+d4gqM7eF51xRq7SwKF64C/qCNgG/fMCVe319koam8FsXZUUd034G
         Ts6K0KWn5eh3Mw5rYXB6OVwDBX51vYL4dTt20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hhzFri+umKGqsjlPPoYc/+Cc98MC69t0wlXD1xqg8FE=;
        b=YgNJZXYBe4f8R1kzvGbT5FEgX/HkUfklg5INa541feO8r0soyxykVptIQHeJQaU0FI
         EHVsOIN7bLR2weldlSHPbIdK8Lyu02HysIbpVaH9T34KD6PGbfYWaXsQIXILoHdRGBUy
         vo5ogKl5BLrQ9urA714hfL8meJqBVmWhmbMQQt8v/ZLgbVjdY+iMk3PPYUWoMtCVwLIf
         9bv2VS3fBYsx3kKZxkjpifhuQ18MzKHmIsDGISCXgtMZU6eG5nAJnSNqh0xmPe41pvjT
         3o11fDq5rH92WQB38GOB8wGIFQhegutdMyERkJ2AHkzk83H3sQFsdOy0oBg9Z8TFJOly
         A8bA==
X-Gm-Message-State: AOAM531ASYT13CZMAt15tmtEtaz5ErcYRg1eYQzOmFdKBeaCe3mpYJe4
        hU5IY2w3Kx43W7E2nss4JNGRskpL2NET5w==
X-Google-Smtp-Source: ABdhPJweJ/94ROAL08rG/auCARIn+o7xDspe0zvUiOUna8t6rMZIHmmjvA2VEa9v+IF+twZ8E5STkQ==
X-Received: by 2002:a50:c014:0:b0:41d:5ee9:f354 with SMTP id r20-20020a50c014000000b0041d5ee9f354mr7999025edb.257.1651921087998;
        Sat, 07 May 2022 03:58:07 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:8c3])
        by smtp.gmail.com with ESMTPSA id d2-20020a170907272200b006f3ef214e21sm2903046ejl.135.2022.05.07.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 03:58:07 -0700 (PDT)
Date:   Sat, 7 May 2022 11:58:06 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] bisect: status improvements when bisect is not
 fully fleshed out
Message-ID: <YnZQvuyeu/WZLhXH@chrisdown.name>
References: <cover.1651796862.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1651796862.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio and Taylor for reviewing. I have the following action items for 
v3:

# [1/3] bisect: lowercase "Bisect:" to "bisect:" prior to wider use

- New patch

# [2/3] bisect: output state before we are ready to compute bisection 

- Fix multiline comment style in bisect.h
- Zero-initialise bisect_state directly, don't use memset()
- Pass the bisect state struct as an argument into bisect_print_status
- Change from "status:" to "bisecting:"

# [3/3] bisect: output bisect setup status in bisect log

- Use strbuf in bisect_log_printf
- Change `git bisect log' use an output file in tests instead of piping

I'll wait a bit to see if there's any further feedback and then will send v3.

Thanks!
