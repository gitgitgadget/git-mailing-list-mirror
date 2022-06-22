Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE2CCA481
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377330AbiFVRSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377394AbiFVRSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 13:18:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E5631A
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:18:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s37so16681543pfg.11
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIA9mvV2b2IvExBxnH57L5CTfb/i69dEXTGh/umQzXk=;
        b=qK0/1BJG3t0xqnSu+jlpUcdxJhsaTrKobY8eplFU9VIvjGVKF1j9lq3/okdv5CEL1+
         uBhHtjYftWi2ZdTDUGllJUO5bVIcsxk9zNMUK7cR1zDBjwrgwMTk+wa1sNP8ZYajOPOz
         tkzmwhxUBMbY9Rr8W9qmRED4CDgWGXqT/+dSxMQJFKx8NApCYwtQtnu97jWsdAxVDVaA
         1WpKqhKpE1jQtWIXK045UHssUpqpyxw6Q+ylm0G/mhqLiyPm1Ry3S0iOMiV1o+SinWhg
         3rZMj1XtLnjKkxdKHrWvGhJPbPLEkZod2zZJ5z1qu5e1usH1ekBOoEBIwznpHZ8C5c74
         UeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIA9mvV2b2IvExBxnH57L5CTfb/i69dEXTGh/umQzXk=;
        b=QeMLppenehl+FvR0MQqe8AEPmEPqqfTFkz1wY5WsgocNYa8q461hsjAuTV/tKGp10Z
         +T5RjTFw0OIl+k6E4JhHzJi5tvuwepNwlQFG1vpdSGaCMmupVteneLRvPfPrCuTxxojL
         4HkleGtXvps/h6T/bcG/q6pYvsKslIyEAQqVzAqf9PvOwh5LMHVPhhSfdtJJc+HnQS7P
         3yZXvc1UEpdBGrAX8ftZCmwkcOzQRX6eEsVcnugZJtYcpiN5imrCyhoimf852j58Bn6Y
         anFFAb3elxQVffsLllo7j+54YwhdSIZm0CcTx3dvYmsWyizy8A/xjj7DFky04IVLYuzk
         cY8A==
X-Gm-Message-State: AJIora+sOysHy7xnNbG7Rh7YtvSakC2+6sYs9bgL7e7xrmDdPcXAAYN5
        x5gkYsu8uYEvy9gfQabM7qY=
X-Google-Smtp-Source: AGRyM1s+sjUqXD+GUZ7vSb92qIhAM7fKPQULUJHytMJHSwlel2etZ8BJSnJftRa3pOsWXdg6gT7XYQ==
X-Received: by 2002:a62:388d:0:b0:525:138d:74ea with SMTP id f135-20020a62388d000000b00525138d74eamr22762886pfa.19.1655918314075;
        Wed, 22 Jun 2022 10:18:34 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.21])
        by smtp.gmail.com with ESMTPSA id a8-20020a62d408000000b00524cb4aae69sm4304969pfh.8.2022.06.22.10.18.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 10:18:33 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Date:   Wed, 22 Jun 2022 22:48:14 +0530
Message-Id: <20220622171814.46313-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrNIJ6z+a4++MGQ8@nand.local>
References: <YrNIJ6z+a4++MGQ8@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> In other words, right now we have to do two queries when an commit
> doesn't have a bitmap stored:
>
>   - first, a lookup to see whether we have already loaded a bitmap for
>     that commit
>
>   - then, a subsequent lookup to see whether the .bitmap file itself has
>     a bitmap for that commit, but we just haven't loaded it yet
>
> If we knew that we had loaded all of the bitmaps in the file, then we
> could simplify the above two queries into one, since whatever the first
> one returns is enough to know whether or not a bitmap exists at all.

Hmm, agreed.

> Ahhh. Thanks for refreshing my memory. I wonder if you think there is a
> convenient way to work some of this into a short comment to help other
> readers in the future, too.

Actually, Derrick has suggested to go with iterative approach[1] instead of
Recursive approach. What's your view on it?

> Right, that part makes sense to me. But I wonder if we should still
> print something, perhaps just "Bitmap v1 test" or "Bitmap v1 test (%d
> entries)" omitting the "loaded" part.

Yeah, of course we can!

Thanks :)

[1] https://lore.kernel.org/git/92dc6860-ff35-0989-5114-fe1e220ca10c@github.com/
