Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC573C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBF60F4F
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhI0XGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhI0XGU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:06:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDFC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 16:04:42 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l6-20020a17090a850600b0019eea39702aso1136872pjn.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ii+xjQX5eFOeN2Ubr9FN3zJDPEi2/e/sADiOYflzHiA=;
        b=YGFKDR4mNASAs7o53u4WQ/tgUgz2NZBaIbEhekbliEGowyBWwHgPxAOmV3IEGd3dSM
         wDzkJHFld8wIiVDXhKvoxLgsvChcYdpYd1r3CAIjDVcg4jgxSfhjb/ehi82zI5goN6k0
         jhl4s8UUCiroDW5zHspWca5YRh6AT/FoqQYg+jYH6OqYeFY+qA9AOEKTDEok3kYF7nM1
         oSyk5a7fAl4r/ga7F+tuyGM9QjE4Z4mwMRg4hD61ErXKWJSP8lbr3wVRd3ZN9KOSK9yw
         pFC0VrSi1R+m7yuG9jHlOMwqsZDe20wLtHCQFd7t61e+N//xecpxR8tODtDp92PvY91x
         qz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ii+xjQX5eFOeN2Ubr9FN3zJDPEi2/e/sADiOYflzHiA=;
        b=VjnHTRwXxIGV6PqaW9cIeeb92qXEtxqbh4xbgviT6Gb3qSudYw4jl3GEYL8uC1yOpC
         16cI44BQCT0xFVqOiadxCbLPcddkINNmPXd0YR3pKVlKi5e5enViq3WcyYOF6me239IP
         QQhgtFyyn6A1LLV4eKBJQ60dcmvPoJ30g962VXB/HBSRnKHzxiWXqJ9W+TnhU50ofRCD
         4iNYEx5eo17U8VZhk7Dce9fue0tU+KawFwdUegh8wNOheZf9+3Tme9IqZtpPfSx8sU5p
         VFG57bWZP0fjTZoJerlEMYVSC/5gkkg1drmiQLCSkhDZ3IPlabvFkB6j0pJUDEbxrVrX
         YdKA==
X-Gm-Message-State: AOAM531mfZc7e+sTAxFGhUs8VTzOH4mmMyGRPSrtmq7XmduI8UtoyrK7
        Z2JLdnfk3TsjRv8gP0DA5a1YhpohWhik0IVj5DaC
X-Google-Smtp-Source: ABdhPJxpuTJulhVvY/yurOXgZN1Jk5R5k3G5ANvMIMOZ0aEV8wSK58VSnM4IfX6VPkKi9BxpuhujLxw+oyhqa09J0ZEH
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1141:b0:440:3c27:807c with
 SMTP id b1-20020a056a00114100b004403c27807cmr2393430pfm.71.1632783881688;
 Mon, 27 Sep 2021 16:04:41 -0700 (PDT)
Date:   Mon, 27 Sep 2021 16:04:38 -0700
In-Reply-To: <20210903170232.57646-3-carenas@gmail.com>
Message-Id: <20210927230438.3759964-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210903170232.57646-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
From:   Jonathan Tan <jonathantanmy@google.com>
To:     carenas@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
> +DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
> +endif

I noticed today that I wasn't warned about some incompatible function
pointer signatures (that I expected to be warned about) due to this
line - could the condition of adding this compiler flag be further
narrowed down? gcc -v says:

  gcc version 10.3.0 (Debian 10.3.0-9+build2) 

On my system, if I remove that line, "make DEVELOPER=1" is still
successful.
