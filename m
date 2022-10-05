Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE77C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 05:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJEFqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 01:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJEFqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 01:46:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A2C72866
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 22:46:45 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 3so14490399pga.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 22:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cvUv8JKBcyLC7vV1KlJCmMiiJs5Ltx+o2eLwUPzQfxw=;
        b=gVXgJTkjnia3PDdEgz43luDviOM/f6T4NMdf+VaKhkYQenYMhD1nOVQY4Lg1/03Pl3
         Mg7nENqsok5kUDcMRCIvNXNMK4yp6MO8kXqTAV1G8lvWLfeODeuiopXYMYZlw+r5dd9+
         vdvySxzrrutl85D0Y42zX/0QGCBJNgCsiD8tfwDXMtyKuvt10o2DNchYP/9NPX1r8pYj
         XC3NwCsn704/Nr4+/PFv26JugTIE9cCnGHFCDFQw8+ArsYQt3E4yCBXG9El6HL7l/u8W
         FDbTmzgCUTtzhhLJIrpTnZnX1Ac4XX9NbwhVpfyGJD1OT4tkd9WneXJsH3woZWmWAZIG
         gsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvUv8JKBcyLC7vV1KlJCmMiiJs5Ltx+o2eLwUPzQfxw=;
        b=47nnzqYATdCLemWD88Ku7ElBp88aVrs9fKObEYjj4mzpoHClle9ztRUC6MvyJoOJZv
         5CxuM++NZyzwU64a5LubGkpgd8lIl8nuRUzeZ/mt/r93wtFohbb+Q6H6H2rDn4c2jLfG
         4h77Xim7psLGga/d318OfSzsAcmtMQbqfCV0Z8vc24H+e7VZvdHVCPtRj5eJOemW9mbE
         DangwJaLZ9pSJ2S+KZ1Pv4m9yTXNhoZWBgN+wwWLJ9++v405Ye0dht5RsgZYkr7X1LOv
         /Cik4iQ/eH1VMd0i5EGFVMv20keKseWjbBWuyMm94otz1MWErbGgJN4cT/AR19xPzF0P
         arpw==
X-Gm-Message-State: ACrzQf3VIS/4qaPrNeca/G62odtegTQJS7OzVc45o499v32FallUoMJ+
        c4uZ/B5lm4QjmocGA9dSSeg=
X-Google-Smtp-Source: AMsMyM4p10YuczBgWpKn1j1GVyliqSzE3appiYvbungWmJxW1ERQlVd+u7ztRDnfbKqLxKZSxj0hlQ==
X-Received: by 2002:a63:c3:0:b0:439:72d7:7e1f with SMTP id 186-20020a6300c3000000b0043972d77e1fmr26047503pga.524.1664948804827;
        Tue, 04 Oct 2022 22:46:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j194-20020a636ecb000000b00434abd19eeasm9436679pgc.78.2022.10.04.22.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 22:46:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alastair Douglas <alastair.douglas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report
References: <CADTs3HEn8JQzfWGP-rq_BBLvwGD163=c2i_7vFK17g+wAVec+Q@mail.gmail.com>
        <xmqqill0voft.fsf@gitster.g>
        <CADTs3HFZjX7P=n3PpjAtt=6E9m3PUgFKXksZKuOY4t71hSSnrw@mail.gmail.com>
Date:   Tue, 04 Oct 2022 22:46:43 -0700
Message-ID: <xmqq8rlustz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alastair Douglas <alastair.douglas@gmail.com> writes:

> ... I feel like *something* could be updated
> to point in the right direction, but I really don't know what.

Yes, I shared the exact feeling.  Perhaps the message could have
been a bit more helpful by referring to configuration variables that
are potentially relevant.

Thanks.


