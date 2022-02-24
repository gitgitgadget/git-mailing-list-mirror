Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BE2C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 06:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiBXG0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBXG0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 01:26:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D58269ABE
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 22:26:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1235445pjb.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 22:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHnW+MCtysrryGn3LceiGfxMD8deRwanink3BY1jxac=;
        b=oQjwSVvviCFNrN84cl/02c0sGkiFhnpw6A9x8bMbUlL36XdbrpOYJ7xPUYKmh5dJ36
         TLrWk6SWPw4GyZs4rT5tQzfLUWrKxbZs3VcKr2EaPX05/y7Lx4wJZXfk8WPFRSk1W04E
         1BuFuNmZopC8f4MGeyfWdusE1XNd75KaFZzXWrut1gjyKeOHQoBUEl6fbraaknyNg3Y2
         cIcoesHUffQSyz7xgrrtdmIdOFBpAafWS/23TdQa01q16JO2uuAv1wYXJ+SNtyu82ulW
         uaIWXNm9vQEKWOELCGFYjiVh92l3ZNOYVTV442twAaCkmSVAKqeP5nxnxtkbFSfLR1Vv
         bKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHnW+MCtysrryGn3LceiGfxMD8deRwanink3BY1jxac=;
        b=R9XqKnH8NF8Am3mqWjeP7l3PpnzK/llVQjdPXM8JpRpdEt6nGS9CpfL0bo3nPH7RpG
         y/jaLHKZM1GF/0ENqRM0nCCDCqUuZIvOvOCi0pklCcHfeJNJmDiH9Wo3wCJQFn3BEm5n
         gyCaMyrB60jxomL1citQv48qTOpT25tnu6+B2ZzslWMB7RsXnKESVCzqV0C4uKWctHa5
         5yk8cVtCcdHO8GqAwJibUopYaBaWfoQQ4z+vPKlsdcWxe6YD7hgG+/9D/fI5x4D4A27M
         W5OOxXSuEQOyzLkIKy44TdjvT3oh3f/aBZR9QGLre472W/lHC1SRzWZcuDW9dxptZMUq
         Oy3Q==
X-Gm-Message-State: AOAM532qWUV2gB7OeeDu0blAuqMEIM+i6jCbEy/R1hM8oCpwop51mcdd
        oWfLsH6vbDWjh2oZMgJpC5RvyWSvNRgeeTdZ
X-Google-Smtp-Source: ABdhPJwpS+AMx+/yC6O2jBJHyEQxblfeZug27dVog5KTzypavE01/Co+4gcuj4kADQ3hWgBTuBFP8g==
X-Received: by 2002:a17:90b:3796:b0:1bc:c077:5be4 with SMTP id mz22-20020a17090b379600b001bcc0775be4mr1312228pjb.113.1645683975148;
        Wed, 23 Feb 2022 22:26:15 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.84])
        by smtp.gmail.com with ESMTPSA id v10sm1848954pfu.38.2022.02.23.22.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Feb 2022 22:26:14 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v2] add usage-strings check and amend remaining usage strings
Date:   Thu, 24 Feb 2022 11:56:04 +0530
Message-Id: <20220224062604.1264-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqilt5th8s.fsf@gitster.g>
References: <xmqqilt5th8s.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> I notice that the real-looking name
>
>>> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> does not match with the in-body "From:" that has less real-looking.
> Please fix the in-body "From:" if this is rerolled so that both
> mention the same "Human Readable Name <email@add.re.ss>".

Okay, fixing it. Unfortunately your review came after sending the third
version[1], so this is not fixed in the newest version. But could you
review the newest version of this patch series so that I can make all the
suggested changes in one go?

> Much better than what was posted, but such a heuristic deserves some
> in-code comment to check why we see the first two.

Okay, will add comments to it.

Thanks :)

[1] https://lore.kernel.org/git/pull.1147.v3.git.1645626455.gitgitgadget@gmail.com/
