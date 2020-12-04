Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E97C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E4E22581
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgLDGDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLDGDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:03:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4669C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:02:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k14so4155474wrn.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHDK4rFOHlwgAAnotFgR0vfe+2+Dk0zJJeXBruW8IJk=;
        b=J/5kxMh2Qweq2oNLchVuf0G9uEYthR0Q9b8xX8RIx+J9Ze3hsPGcJr5b37QKm8nsSn
         pjEN7pheXF7vg2MSFZV2SkfVzmef85DHY4a7zoADxHm9CwG/7DTBvCbFAmRyPPIa8rG1
         Ymk25axpw1Vr/dAJ2Q2KOb0i6qAuaBB0UR7l+knKlKHc5cidMxqBFXAj3MldxCZqi31+
         IGC8UGIepyUBjObhFSS9qDtD1uUEV5z7CmDayPgKaWT7agXABwhB/B6hNQ0dT4CniDPw
         0iECaw5W+nchx6GzSmBcdiMdaYOSGeWHETbkvxC089dthMGvu8y6cAp+EqG7rAKFFXCJ
         7Tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHDK4rFOHlwgAAnotFgR0vfe+2+Dk0zJJeXBruW8IJk=;
        b=ddzZJ8YHz+CQFLH+OntthXJxy6jWDVmnYsa5vNWlINL1Y4eCz0xskNwtidgV/uMVZT
         MvlDhakUuyhTh5Stjmoccdwz+W30+dAWo6+9+fDc6eR3fDeKp5TTPqlQ59iruhKIo00o
         svy2fA1rgEVTyiLMbXjK0LSRwgPMNnafBfCPjRLu0dVOZi4mIix2q6EoeaQU5/soYCSK
         HBLdCNntf2c0Lb7AVc3zE6P+9h8j8wGQv+P4pWVmA8iAjjpYHw6M688Yb+wb2Z45JDTZ
         x8NY4veMb9xEhUoi+5wW9cWELiO94OrtDxFguLJHOqb7FrjYNtaRliVU9Zl3UJYuqAQj
         yo3g==
X-Gm-Message-State: AOAM533IFAJqEC9wW9lLdIbhx+Ua+IpRzMi12krOZ0uRemyNmrHfOi/B
        EBf3ryVs9vyzNOLAMknlejfQhS3g8CMHMZF6Ef7MaTJSMYbaVg==
X-Google-Smtp-Source: ABdhPJyV6qBYgIwuA3QJ3ADUekD3/dwT7tio4lqDhe86aH1Nc9s2LXuxBv1AwmxskBdubTcezVMO8sCMovASbgs9ICM=
X-Received: by 2002:adf:e788:: with SMTP id n8mr2935722wrm.84.1607061748414;
 Thu, 03 Dec 2020 22:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20201204055727.1165204-1-felipe.contreras@gmail.com>
In-Reply-To: <20201204055727.1165204-1-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 00:02:17 -0600
Message-ID: <CAMP44s35yk=0jCzd92s0Y5KEnmrJAKxnDDWsW3M8rT8wXEVEZA@mail.gmail.com>
Subject: Re: [PATCH 00/14] pull: default warning improvements
To:     Git <git@vger.kernel.org>
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And of course the addresses of Elijah Newren and John Keeping were
formatted wrong.

Please reply to this message, and not the original.

Cheers.

-- 
Felipe Contreras
