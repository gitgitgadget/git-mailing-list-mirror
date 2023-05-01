Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A8C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 16:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjEAQWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQWp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 12:22:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0BAE59
        for <git@vger.kernel.org>; Mon,  1 May 2023 09:22:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf7067647so7973905ad.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682958164; x=1685550164;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHcbTpu+PcrOSiUV3VoRa26SJ0FBmmhZvIW1ErcaN/w=;
        b=YYkGozze/HVQYNJNX0TOnRp0E3ToVKsErg9gyYr4WzAbNBo/c39+DmX72j+VtFhGnb
         4zrhm406T9SdkCzrP/cX8NfBYpB/D0fG6cwE+MaTtMJvlrvf7jdkOBCpCMvQJJPpFvgf
         Wha6qkJ4+uB4NDIrFr1ovmVo7cfiv9KTQ6qwHEMX4NQe5ul0sWgBKfME/J6Qg/Sqjo2Z
         4FAL4/0vmGHULdszv21F/aVSOem4XUN7hlL+7pMcxYpY2/yO4xW5iLyd315C021mrjng
         QzOShAHy2s7a6t0V+wLBn9dMaeM2YxeR4BEdy8Ow+sU/fONk2/8psq9FY74xHyoNuxHJ
         3zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682958164; x=1685550164;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHcbTpu+PcrOSiUV3VoRa26SJ0FBmmhZvIW1ErcaN/w=;
        b=dFLKG2s3ZQnOn5jEFisLAQkeakuf6OpMb3DtBjOgXhKajfDbrUbhxXRew7ocPlM4ir
         oruHwVI+3BQ0eXurq9BO+XEtRfF/gtdGx0/kJsdNhRzH1mzjI+WZosGqUavC7kPCGtiT
         pA6jL8IabOobhpHByUNMAtuNqm4Rv9Y57LDuxy1G+kKKdAd56zCb69qbtDJxua7MFp8F
         I2b/vlAxO4faoBk7IzA2kPAeJxTALchN4pnrBnnqBRdIpv+/HdHMX74PCjZJg1hgU2vg
         Disw8Oxl+8BYIErOIW0/zTtTTKCdCri672sIRrNjll3LRCmkIpWST1W7mRB1WReBkGs2
         ZHFA==
X-Gm-Message-State: AC+VfDzmcbFpdUIPSNghJBaa7WunyrJsGiAXIqmoPxSp2qQMfn7eCvRo
        ht4tjx7APo1fSmKAD1TORWQ=
X-Google-Smtp-Source: ACHHUZ6v0FbXaL18jeJEaVpmWq7JeXB2qUl5IxrP5LJoMK5Bn6eLgO7cFcBjPHfe3LVkt2usTQCcwA==
X-Received: by 2002:a17:902:f649:b0:1a6:a988:b858 with SMTP id m9-20020a170902f64900b001a6a988b858mr13362309plg.58.1682958163717;
        Mon, 01 May 2023 09:22:43 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001a686578b44sm18080081pld.110.2023.05.01.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:22:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: en/header-split-cache-h-part-2
References: <xmqqzg6r9o14.fsf@gitster.g>
        <CABPp-BG7K0L11YGYmo504GK4mexFnBZPuDHhqSwqaD2nGwWfWQ@mail.gmail.com>
Date:   Mon, 01 May 2023 09:22:43 -0700
In-Reply-To: <CABPp-BG7K0L11YGYmo504GK4mexFnBZPuDHhqSwqaD2nGwWfWQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 29 Apr 2023 23:58:00 -0700")
Message-ID: <xmqqa5yo6my4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  source: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
>
> Both Stolee[1] and Glen[2] have acked and think it's good.

Yeah, I should probably have acked, too ;-)  Looking good.

Thanks.
