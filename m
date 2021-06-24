Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CABBC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726B9613AD
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhFXXpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXpG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:45:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2313C061756
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:42:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so10921616edt.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ACd6SSVF3/VXiW/wueWgelcMR3a2bzP+T+ZlVuHmNAc=;
        b=d1jopbKEJLH4c+F//n2d75VTIcB1jRd6QtwYR/sTtKrdAqfCT1DboKbNTa4vkRTw/X
         kKsirV6I6YXculzFqhCKIov5jXaYVcMpiDY/PJ6YUU2fti6ha7tIKrt9pfAqjwXXfjVC
         P3G5mC1VeLkCaHx85+sO6KG1yfl7D54tjyq51nKATcYIyWpBDaNndE5bsAh95ZOkezmL
         ij/ozV8YARbo2d/QQ2HLoxGWINE5olzu5k2a2eH+aUmz3ZNZCIyAJThCVo5I/Hn+ddIm
         niIw/97NbcRrnUvaWIf5g4Xt2PesB4b+ik0rge260HFh5ALv4bRvw0zuRpXm4864AfCK
         Q45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ACd6SSVF3/VXiW/wueWgelcMR3a2bzP+T+ZlVuHmNAc=;
        b=IRSU5noeSxbSn5V08eSBePQjLSSy9KensNxoy83BwnBcBvfWlNx1JKx9A5ja5jyPKh
         6j3kFKhi+/t5Edcl9GjvEGoV8dN2U4BBufLVLk5+3JKMiw50UhyG9Oi2NyGVVMnvjlvQ
         G6ncRGvteoTWDj2v1Kq2NJ+mQTRHwzPHBwHgiFOZVh35sv4SPAvMBAVMTCE1KuVE/7Yt
         8NZmfCjA9YS8F6OlRxFCyjbdDU8ojoq4keEfpLcmItQxM0pkuiERhipu9tM+pilcbb8J
         VjOvFk9KvV0HoRSbV5wXp55SpqMmghzv8axWONzgF7pGUMp6fP70Q/8o3gYPfX+R+Nc8
         fHdw==
X-Gm-Message-State: AOAM530x/g+kJG6vM/PfcVhDV/S+s5N3xThf9anfmIOzXLcCtwHt8gFR
        fZNNDIUXF0CMr2PwnoqW8aM=
X-Google-Smtp-Source: ABdhPJyNNNQPeod38J4BAzViIZe3Mpj8spGRu/3cCr3mP3iNM6LlkS4RG3u+edlQHPvKbCgt4GkWNA==
X-Received: by 2002:aa7:c997:: with SMTP id c23mr10736668edt.42.1624578163135;
        Thu, 24 Jun 2021 16:42:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id aq12sm1802902ejc.77.2021.06.24.16.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:42:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 06/24] midx: make a number of functions non-static
Date:   Fri, 25 Jun 2021 01:42:06 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b3a12424d78e80553741f5c7a0672490a59b6f7d.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <b3a12424d78e80553741f5c7a0672490a59b6f7d.1624314293.git.me@ttaylorr.com>
Message-ID: <878s2yzv65.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> These functions will be called from outside of midx.c in a subsequent
> patch.

So "a number" is "two" and "a subsequent patch" appears to be 13/24. I
think this would be clearer just squashed into whatever needs it, or at
least if it comes right before the new use in the series.
