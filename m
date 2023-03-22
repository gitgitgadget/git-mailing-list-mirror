Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F5C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCVQun (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjCVQuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:50:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFAA61880
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:50:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o11so19855408ple.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503825;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcGK4PPw4b4N9FO6u0JaHkyCbFGGlV7rc7lqXARJ9JU=;
        b=bbzxLasl+/oLb7ulrJv6TJ8rDDseMNumBrzQHutgsNfBKv+eLavcUmgIrApwEDSi7T
         b/oxzXdvQBpHURctdmygIRJTVyGMl2H/BYByRSkg8hDimIhUgCTCjc4GH7+XcD+ZuRwi
         OIJY/eGSBh7jWiSUUg1rgzb+LTgAda7evymsLNcTYemmP3Vhzf+7iI6NZON+nVbUDEnx
         kBsYUJ24bLiiwzb0uDo8lqtYValAt8mNqDRMZiB0LLPLD/5BtlSgLreW4HVly/ni4AZ2
         L5vM0RKvnOmFbjPhoHLxksY9lGZz8Ab1rEBsVsZG1mRyJHgKsgeSOUVfIOJjDzgbWCNL
         WlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503825;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PcGK4PPw4b4N9FO6u0JaHkyCbFGGlV7rc7lqXARJ9JU=;
        b=OX2rztpEVZoMb6oLfXcw4xfyb8a+O0WLF8wr6eAmrvClEawv4UBfoVpamPFXNkF0HB
         bepvLLbLffIXt1o2oBhCTkXbic/lxd5Mbe/lrLHBhGJUWFrRp9SU/PM8UvF/roIqMj7V
         LsgFiDhnsolPuhL7wvyZr4fvTK/26QQF3qAbRzdoNk1SKDnqIwteci3HrFL0fhyY0v+v
         171EgUnn8UBpVsZfHYSG8z2d5E0vfXl4pe35h349ScAb8GWf8rG1JSOxepPtmo9BBxXV
         aoLnKvXFjKxWWxIshEORFcJPpsxIV9/Dp+aDuBnrG0Mf9z24hpjrO2zAKOApzNflfs26
         Bg0w==
X-Gm-Message-State: AAQBX9fVv2KH74uchhrrjGawEUoafZ8szu/hT8+g8IVvCQur4r7vjQqs
        y0PxtyYTWij0xXpjnsDOdvQ=
X-Google-Smtp-Source: AKy350an6RQvpWwSGoQA4W64SiMiG9gKGpCxoogj8rS3zVDbDw6IUAb3O9OI2yBdcAiyESB/J8tsZw==
X-Received: by 2002:a17:902:c94e:b0:1a0:6bd4:ea9a with SMTP id i14-20020a170902c94e00b001a06bd4ea9amr2919333pla.16.1679503824808;
        Wed, 22 Mar 2023 09:50:24 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709028f8800b001a053b7e892sm10756926plo.195.2023.03.22.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:50:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH v2 1/2] Update show-ref documentation for internal
 consistency
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
        <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <4408b518810501139a8c7d2f7e2240eabea2839d.1679478573.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:50:24 -0700
In-Reply-To: <4408b518810501139a8c7d2f7e2240eabea2839d.1679478573.git.gitgitgadget@gmail.com>
        (Sean Allred via GitGitGadget's message of "Wed, 22 Mar 2023 09:49:32
        +0000")
Message-ID: <xmqqsfdwenn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +The output is in the format:
> +
> +------------
> +<OID> SP <reference name> LF
> +------------

The same comment for <OID> and <reference name> from my review for
[2/2] applies here.

Other than that, looking good.

Thanks.
