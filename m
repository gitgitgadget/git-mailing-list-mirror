Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF18C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 08:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbiCHITm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiCHITj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 03:19:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B523EF1A
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 00:18:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso1718756pjq.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LohRX14ekgWWOOw0XBDIhwdXY9QkfqPpNqL4ikTXBsY=;
        b=UJXhkUxloMtRKgDxkdhRQmyuFmjkaFemqHH7KpyXaYbCaYUGNtVHq2qXTpMtApOueP
         uzUTqhDV363CCfE11WUknzRGsVmaToD/TTOjROwQNIQk8VERODczd3AkBmt64gRVWSmW
         tVw8bc8cV7YJfvSV7Y/HFctQj6ELUC5cUAvKTVbVbm8y7UMp6BdUdPv1GBxBZt+w1TzL
         roOrkwy8fRZl8haTnS9Zy1DNFrwu/yk0t+IPBBNBvlS7ZfnaDHymHPJlL6uWqsRVtcvM
         T/2ebwcE+fN4KD3j+S8ehlwoqBqA+GzFEzO53F5veklfxteA3C3RlFCyxIFYDX+DPcgF
         PJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LohRX14ekgWWOOw0XBDIhwdXY9QkfqPpNqL4ikTXBsY=;
        b=z7iSocaV/PbNE+Tkl01RIJ2xyKRyQeeXWNNyJ1fMyfoVhvnEV8cJ2DK9C9BYk1P2na
         9rluAaGORQHtpFGgmKqBDI54yxrWOcvgd6mi19q/hpeDEub3QeWFrhVooWogbFaTthOO
         ZWozJG/Rx6bxMWB6GzPWJmY8wdzY2tGJW2+7QCka4GrmG31MVSYb+mrusWOi8jc0B6BU
         vqGUsz9I7R+9FOc73JWr8b4c0OqAYtMMZfWO+ZjGh8p6ItZ+co8S2FVGeddoeU+V+Wwj
         LGEYemQI8n+Y+xfMbTeq/gVoGq4lZ6jsv2qbEGJbAYiTv2kdMg8ranvLwaksfiSe9fzT
         ew/A==
X-Gm-Message-State: AOAM530C6UWMjWXRvXUp02tgeXG3MSr04xNOQIDc1GANafPf6IMBihM7
        aPfQqSjOeR12yh+MuzFD2z0=
X-Google-Smtp-Source: ABdhPJz7ueyfruyw4AT2sQY7XylN69ttCJBKF6+7dhX7O+04+c+Xu81bt8Nzby6pdVnazcUBhH3RRw==
X-Received: by 2002:a17:90a:9a85:b0:1bf:3048:45be with SMTP id e5-20020a17090a9a8500b001bf304845bemr3371450pjp.141.1646727523124;
        Tue, 08 Mar 2022 00:18:43 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.56])
        by smtp.gmail.com with ESMTPSA id g20-20020a056a000b9400b004f705514955sm6750205pfj.107.2022.03.08.00.18.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:18:42 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        konstantin@linuxfoundation.org, me@ttaylorr.com, newren@gmail.com,
        robbat2@gentoo.org
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Date:   Tue,  8 Mar 2022 16:18:38 +0800
Message-Id: <20220308081838.29282-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
References: <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote on Wed, 23 Feb 2022 23:17:22 +0100:

>[Note: The E-Mail address you CC'd for me (presumably, dropped in this
>reply) is not my E-Mail address, this one is]
>
>[Also CC-ing some people who have expressed interest in this are, and
>would probably like to be kept in the loop going forward]

Appreciate for the CC. 

I'm attractive on this for a while. On a earlier time, I had posted a
patchset about to extend "packfile-uri" for common or similar reasons,
but after I saw the idea and RFC from Ævar Arnfjörð Bjarmason, I suspended
it.

Really looking forward the solution after you guys reach the consensuses and
I'm glad to attend and listen to your meetings, if possible (I looked at the
context a little bit late, maybe already missed it).

Thanks.
