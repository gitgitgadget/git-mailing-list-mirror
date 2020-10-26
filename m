Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44645C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC79822264
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2YVlqRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788118AbgJZRk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:40:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45740 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788116AbgJZRk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:40:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id f37so8729297otf.12
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OciRgDAoVkREaA6FTxDFfXh/M58hanOLB/yN6SjYeqA=;
        b=o2YVlqRjMbLGcOfTV/pTZV9itxbrPolccCSJZt4nBR5D0QX6vXTUx0fph/MLF2oPrs
         eg0DzBce3rOziFf1PNGa4BS8lpxDDhzNPqMU4HhQAJJyuOdoYR0ugPMrFxBqua+HUMY1
         vyykl2MPEEW0+OVq8HB+cFBCA23Td/gHN+GjMXd0UJhZLGfy9kRsZ7zo8tKzkOxr52w8
         gwM53TO1MohPlqGK9JmFjIn4PDH6co+8erbRHaqtYq/qBZ/OaNKF/uN+F7Ykw3YNcZ/C
         Nr+NP3bT4ovWv701I1NzsiCpIswVsD1NuSZngdh6N6oejpjIXRJ5JmnZsNkgkMDMh33f
         eCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OciRgDAoVkREaA6FTxDFfXh/M58hanOLB/yN6SjYeqA=;
        b=ubLKeV9CLb0fq+LNr5yRBpyj2eYhBD68yGqwRDgunfYYg69adUms6ZbvW1xJybfyRD
         bkpTYxiyHX/ECAbWF4Bv+raNgYXZUBq4IFSP9l756Wgg5emD0u0Eirrw68nE1aNrxOov
         +psUWBUtsHt/epZ+xfZkvGtLggFtzox3HEm5zfwXaloyql7uoFkwCXJ0AxZURDWs4NLU
         R1hTlKmi8+GuEp0SO8uXVo2qOyNRmmFy7cm80PeYSgjkMobQ/kY5eMf8raBK+GqNLEyH
         MqufmyhsAIgxfPahiWp9cabAAqWUFM0m41NCSeEUVGv6hqgskioZXs0RADf1nLBmkArZ
         iBww==
X-Gm-Message-State: AOAM532or2GLxXdAksI4BzO+gZy+lW23S3wLjJ9RE8aBBXEvrsyHwKVd
        aLeE6LlmWa9cAkS/jsR6mL5LmgRThLYuDDmLOQ0=
X-Google-Smtp-Source: ABdhPJybJjwIThdrZXNvyjYfe/QexLChnwVYl/ZIbkCUDmATQwGO8yQVhrxmdXzunuqxkKUj1wOnIZJbzQ3HGKsKusY=
X-Received: by 2002:a9d:2042:: with SMTP id n60mr160233ota.19.1603734057395;
 Mon, 26 Oct 2020 10:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.755.git.1602762128039.gitgitgadget@gmail.com>
In-Reply-To: <pull.755.git.1602762128039.gitgitgadget@gmail.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Mon, 26 Oct 2020 17:40:46 +0000
Message-ID: <CAN8Z4-XT91FJY8sWnEp1D3kXjhrc_y9VT3LrrEwBZadmKfVGGw@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: show detailed error in read_pack_header
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi - wanted to bump this to see what folks think about this error
message improvement.
It was helpful to me while debugging - and seems fairly non-risky. I'm
happy to continue
pursuing this, or to drop it, depending on mailing list conversation.
