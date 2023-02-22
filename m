Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E9C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 17:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjBVRpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBVRpj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 12:45:39 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995C36FF8
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 09:45:39 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a7so5119196pfx.10
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 09:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvBijuopTTmoD5Jz2jqlVpDIw1IJVePo4Sz7yT/f8BQ=;
        b=IprdMSWC1sSZ0pOsnFNpPfndxksnfx9kQH9ZYttER2JMyvh6oPbRQVjBOA50RYm2Ez
         V4xaeR91eHCG6ar1Qk/xJz34ipA7Tt8CiDBP7so4MHmzWBAR/KluBwP/89jIP1dE+z+D
         bbWmYzWLLWEEGSXSEnzenqAPvkr/o7J8nTNgIxE4XTRPl25ZJZXW7MGVkX92Ig4IhBE1
         Bhn1pUe2UGx3P6x0tmBqJC0Kirad+BNZuTSt4GI82khUybfvEfqFRgEd+ZnMi73wutbB
         FZBz87ElxXypCtqLIBp+iJ0Qx0hTPd87Lr2jGuTZZcF1RCybXWIa4AA1lvB/YjSR7Fp3
         au2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvBijuopTTmoD5Jz2jqlVpDIw1IJVePo4Sz7yT/f8BQ=;
        b=ybEHc0DLwRhmt1ih70Aan6rWr61EPy9kYWmOq+aZcxJ6tpNZb51EA3CFXWM2200dOe
         Mv8mDwDCwvtGh2mk6qO+cWRW6XPysP66TAqeSq+gerkyNgNJHKB+ytbXnChUSmllaFp1
         LZFuqdN8AAKNHE3YzBMb+QgnV7pgZWA0uxCJTGFovgukX/cIZODBD7bbaMwmbxd9kpuo
         PgZY1ZiB5oGYhT8Iz216XwPwARlDaO7/Hju3V9xiLl1csoRV1tO7LWRJdrzx67cnuZsW
         inxJKa3ZNpUPmY8E5NeFM6Icjri2QTK/7I74dflDdFMcwbh8diH/RiP868tYVsowKgHh
         BL9g==
X-Gm-Message-State: AO0yUKVVAzCrpuuAiLTBd8Z4sbb2RZ6gyUdFy+5uTW1SCUasYhDenYlw
        Km5tYfThx3yosiHo0mUWIDXV3eL7uRIthg==
X-Google-Smtp-Source: AK7set+7UFNQHYnNU97kNeYpEHXlboTclLVLkCVHxdUQG7ktryB1xXcFYSEYI7MpImtTFLtc/N226g==
X-Received: by 2002:a62:1948:0:b0:5d9:27a5:60bf with SMTP id 69-20020a621948000000b005d927a560bfmr1103696pfz.28.1677087938520;
        Wed, 22 Feb 2023 09:45:38 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.145.13])
        by smtp.gmail.com with ESMTPSA id p20-20020aa78614000000b005b0853a1a3esm5772092pfn.159.2023.02.22.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:45:38 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     jonathantanmy@gmail.com
Cc:     git@vger.kernel.org, five231003@gmail.com
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
Date:   Wed, 22 Feb 2023 23:15:20 +0530
Message-Id: <20230222174520.21795-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507194354.33347-1-jonathantanmy@google.com>
References: <20200507194354.33347-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, it seems that I misunderstood the whole situation here. I didn't
realize that the problem was on my end and not something to do with the
code. Please ignore the above email except for the last question, which
I still don't seem to understand. So, I would be grateful if you could
clarify.

Thanks,
Kousik
