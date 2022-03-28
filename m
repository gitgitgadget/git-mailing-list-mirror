Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8764C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 07:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiC1IAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiC1IAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 04:00:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD4220CE
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 00:59:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s11so11837122pfu.13
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pc4Oy7BBCFuyOxVfZqyH8aYbjZFezBWCgn34xw8aGHM=;
        b=dzfNWWzOdv3ctlEXy7kB8btnmLvOmJyi9v2TLH2yBTfP01KGpExgO3qByVDVkTXpJm
         4UoWX4Lk5gCgqIesiOXihj9A2m5mNViT03uyCZsUvAwJDrHRtsr9FnIoD3q2gUfsrjLv
         jH2EeFC7CQ7586L1bLC+bF/drUwDdslxKonP6/3XQD54vFNP4CEMzi8FdKNpxsgoDmSy
         NirlNGdEgv5TaMuzKfjTHI3x6UIN+v6YoGjqMY5yAS7hqYAZWz7lJtrer4PrXoMY2AXf
         lisw8ztqtDd9w8cgRFlSwdbmtTycKNA6Xd/KdvG1ySHCL7FoJ4DWXayNBfUv4tP94Zwn
         pomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pc4Oy7BBCFuyOxVfZqyH8aYbjZFezBWCgn34xw8aGHM=;
        b=gXLo5c43ngfbtmpj7H99DIECcQCUwVzfZ3foS1Gt1TAOr0n2fYhqBjLGdQGEQj2mV/
         E8gr6OKkm57gYx0oeD9OUNCFcK/BBIr54nC9mXJPVZKYIWN1zVIdwr4/dKs+K6C+k5Ry
         RFI6HmZbB7u1B+m2FqQZZJSTzqJhoAtAfmVD2dPJnuIU9L/ymDLO15suvyO4HFsif2KP
         vFyuX3VvysUjyuy0JrG0ZGfD0ivtkTv0z7ibbLzazlcuxP1fgyo2NmK+C0Ig7oASxm0q
         iXbUG49lIwkFO4JcJMqIVZB8F0px0OMnkaDuC8UbQ1rNymA4HDo4NlGAgQFb/1MkoT4j
         Ahxw==
X-Gm-Message-State: AOAM530E7ST6bdkCgFaJBwmfPwI/SM0KbA6owAa+5CLBTliPj5EAX/27
        W8T5B6e5c8fRfx3XpG0Q4Y0=
X-Google-Smtp-Source: ABdhPJzdHzg6ziopytHpdFNh/J6I+5LygDSgHQxRk3J7HvPL1tLF/eSQ3runo9dcUKwWFIshX0F/lw==
X-Received: by 2002:a05:6a00:1488:b0:4fa:ac61:8b11 with SMTP id v8-20020a056a00148800b004faac618b11mr22572129pfu.58.1648454351087;
        Mon, 28 Mar 2022 00:59:11 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.35])
        by smtp.gmail.com with ESMTPSA id 135-20020a62198d000000b004fa9a8f73casm15054555pfz.99.2022.03.28.00.59.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:59:10 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/3] pack-bitmap.c: use "ret" in "open_midx_bitmap()
Date:   Mon, 28 Mar 2022 15:59:07 +0800
Message-Id: <20220328075907.75529-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.580.g9912450fc1.dirty
In-Reply-To: <YjzCTLLDCby+kJrZ@nand.local>
References: <YjzCTLLDCby+kJrZ@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 24 Mar 2022 15:11:08 -0400, Taylor Blau wrote:


> But thinking about some of my comments on patch 2/3 here, I think that
> we don't want to break out of that loop until we have visited both the
> MIDX in our repository, as well as any alternates (along with _their_
> alternates, recursively). 
>
> That _is_ a behavior change with respect to the existing implementation
> on master, but I think that what's on master is wrong to stop after
> looking at the first MIDX bitmap. At least, it's wrong in the same sense
> of: "we will only load _one_ of these MIDX bitmaps, so if there is more
> than one to choose from, the caller is mistaken".

I'm a little wondering that what's the practial meaning for _ do not _
stop after looking at the first MIDX bitmap? 

Although all MIDX bitmap are scanned, only one of them will eventually work
, and there seems to be no guarantee that the last MIDX that works is the
most appropriate one? (with the same comfusion applies to non-MIDX
bitmap's behavour...)

Thanks.
