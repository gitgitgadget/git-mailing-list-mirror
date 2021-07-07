Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D9DC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E57361CA2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGGCiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGCiR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:38:17 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92ECC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:35:37 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r29so1656053oiw.13
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=vb6Ljn1ajn67xPMVNvE95u1H/v+7MoroLHwOX3Lpkbs=;
        b=lhF77lRFrxogluJ29/6F+P5EqXdVcL/xXK3bTf8Nbva2qfnucPBiencMrEByPofTUp
         CBiIH5Ahz1jSDycwIWDSx6NA+vA+aOd4FEkAUo4heRQh1s9Ovt7F19c0FLY3lVZXueRR
         wBSfe8TZC1VX+tR4DL+uQ8IFFQZLm922MhLvZl5a2jmi8FoWG4nEnqiqQX28ispLprZX
         bMPC+VFE/lAqRC2gT2SKVotMelI/4sQGbiziZCVzFDeB/U5KEoXWd+lKfbdMdOIy8Fkv
         3MIpSjM1lxOX5cIoHS6KxxRBAOMlbGFLSwBKhLWR8VBLjn1MrXkRCetPm5eI16qKwwI1
         66nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=vb6Ljn1ajn67xPMVNvE95u1H/v+7MoroLHwOX3Lpkbs=;
        b=kOPNyY3NKm//wxWSyzpr6o3/GYykyNaGP9Nfil9EwSqh9kyi2TGyebTpg27WvXfExm
         +lu4KLjQcD/rmM6wsz98KKgkAm6M3f3lGnDenUBScsdG77UHABXVyisQiH77U7FB0MQe
         NK1+36oJULEBD/WbGjj7eysdCZw+lpphYEHvDCFlIf3czt/ArkIczEuNVOkzEFkF6eYQ
         sqH8v3c5fvQKKbLaWUxwrkMuQHf5MV/RIm9Nru/VAIA7mfhbaQQqSqeKBHm3w2K8izqb
         OFr5cN6jhM8n5KV66LJ1cKO+vd0MsJQ61RCVM1NNIK947V4pW4nKPBX/kaAw7oU89jdc
         AYjg==
X-Gm-Message-State: AOAM532h/YLGDphjzE/vjBCtJ3reVfftQsWXpaOY6FjqiVnrFBZxjl72
        GgYPfBhapKRHK7vOnfGyHb788DbJujM=
X-Google-Smtp-Source: ABdhPJwg5S/OPKFCkyTgpFZwIJtUVScww2JGObWtacGpRNIjzLgyff5KZwLQrHvgKLsSIOnIPWRvNw==
X-Received: by 2002:a05:6808:346:: with SMTP id j6mr3085249oie.142.1625625337012;
        Tue, 06 Jul 2021 19:35:37 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id x26sm2905738oov.8.2021.07.06.19.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:35:36 -0700 (PDT)
Date:   Tue, 06 Jul 2021 21:35:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e512f78ad67_2fc0f520816@natae.notmuch>
In-Reply-To: <xmqqim1mgbty.fsf@gitster.g>
References: <xmqqim1mgbty.fsf@gitster.g>
Subject: RE: What's cooking in git.git (Jul 2021, #01; Tue, 6)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> * fc/completion-updates (2021-06-07) 4 commits
>  - completion: bash: add correct suffix in variables
>  - completion: bash: fix for multiple dash commands
>  - completion: bash: fix for suboptions with value
>  - completion: bash: fix prefix detection in branch.*
> 
>  Command line completion updates.
> 
>  Expecting a reroll.
>  cf. <60be6f7fa4435_db80d208f2@natae.notmuch>

I guess I'll have to repeat the same thing over and over again.

As I already stated in my previous reply to your what's cooking for
June 17 [1], and June 10 [2], I already rerolled these:

https://lore.kernel.org/git/20210608060010.1676208-1-felipe.contreras@gmail.com/

It was sent hours later.

2021-06-07 19:11     ` Felipe Contreras [this message]
2021-06-08  6:00 ` [PATCH v3 " Felipe Contreras

I've sent a v5 [3] identical to v4 [4] identical to v3 [5].

[1] https://lore.kernel.org/git/60cb5f4632d62_127fb208bb@natae.notmuch/
[2] https://lore.kernel.org/git/60c22863185f4_b25b1208e2@natae.notmuch/
[3] https://lore.kernel.org/git/20210707023146.3132162-1-felipe.contreras@gmail.com/
[4] https://lore.kernel.org/git/20210617143527.77329-1-felipe.contreras@gmail.com/
[5] https://lore.kernel.org/git/20210608060010.1676208-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
