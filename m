Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F54C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 01:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AEBF61027
	for <git@archiver.kernel.org>; Fri,  7 May 2021 01:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhEGBrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 21:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGBrS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 21:47:18 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B33C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 18:46:18 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso6686503oti.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 18:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OYHE6HOlxvmPOfskT2v+NX4bhNIl1F21NveHClk7g6Y=;
        b=fvuOx2SR5xKPUwU+DgtTh/19h6xKglCv4bO0vCgDZet97NGuz7Jxf+ZSO8eSnRt7n4
         oSoj302k61BNLwxyZEXJ2GPY6EuMaJAA1E40JcvJsN1ikhaQ1U8REQtZGZ27TUvGyvf+
         3DSb3jBZsiC/aP2S97s+7Nyp0CKpX9vXteel3kNJvSVT+lExrt8L2e5M1VuXNM+XJHaO
         aKJy6M0rl+96js0rHzREOvfWpb+/vf9f/rmiFdujdkBrkw9HYfEhVMIQcbdq8DCnU9Bu
         2T+9PH5KAx+9t8PKpPDuh3htz7eyCqYiIwMTKOn8EcEnE53fVzwFwknn1nGpxaGrsjDN
         RuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OYHE6HOlxvmPOfskT2v+NX4bhNIl1F21NveHClk7g6Y=;
        b=gT83x/DF/YsbvoXpgHdXbgIQm0GJrtq/xFr+SqwKjwmoCAwM//hGmDrf+WTFnyIBBA
         5bPROmJdgKj35XxHCo9KHUpDaSJygxPZpI5exWSBQ8G5sYUCYaLXJn39UwWop88qblEk
         VoKE81HTK/fCUTPqPmtseFKbzhz9MSSC1KL0MTXu9fWfNFLv3xg1dMIhp1xMjtf+FKIi
         2u2svTG4l54yAsG73qBDCN/zRV3IV0AZrh4ahp+NUgIFPxiXVfQXNqe62Gh/IH8jr7PV
         iUhdiXEoWw2yTEiFGIZhvW5UeFvI+gqvbyxYbzapEsU22vgY1P+J9q4XRpXsJ1BhEaQa
         OAsw==
X-Gm-Message-State: AOAM530jTYSGPKmoECL3I9LIJnbwHFnEl05LrWKRrNxnmDmqi+XM7Ikw
        YCtjxRYxvNUBPh1HmFNcemTgV+pExBD7nQ==
X-Google-Smtp-Source: ABdhPJzmkwdVrz/LHAt7QgIk3zsX8BxiTaa9zv85OKKOwSotpooKaJ0E9v4w9zAaoFuHKclJmmsj6A==
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr6067536oto.205.1620351978064;
        Thu, 06 May 2021 18:46:18 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id x30sm457405ott.41.2021.05.06.18.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:46:17 -0700 (PDT)
Date:   Thu, 06 May 2021 20:46:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>,
        Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60949be8613c1_8c2220882@natae.notmuch>
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
Subject: RE: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin wrote:
> Currently, git-format-patch, along with the option --cover-letter,
> unconditionally overwrites a cover letter with the same name (if
> present). Although this is a desired behaviour for patches which are
> auto-generated from Git commits log, it might not be the case for a
> cover letter whose the content is meticulously written manually.

This is one of the reasons I never use git format-patch directly, but I
use a tool on top: git send-series[1].

It would be nice if git format-patch grabbed the text of the body from
somewhere, and even better if git branch learned --edit-cover-letter.

None of this invalidates the usefulness of your patches, of course.

Cheers.

[1] https://github.com/felipec/git-send-series

-- 
Felipe Contreras
