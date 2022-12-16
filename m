Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A718C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 23:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLPXD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPXDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 18:03:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726E55A81
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:03:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w23so3696183ply.12
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=685xBwl/GBvFkv1S7Xz1MyjO5YpasZQdCXRqCgk4Q8k=;
        b=mNQDiMTW4WQMV7yLubjZPQVfqMBt4Nf/LdkQdExSWAUExakUnKh+a0OLCEiqaFVjXW
         YKtLfxl2/0N9IVQ5vEApXtiAwdIejQD2CN/xpgWpuBI9rxz17tGuWsLKFJZEHrtvA/YW
         pKrEgrLCylQ/fDLbEwS8nxlVrPCmfTUN/8f3JCyvst2ERHWwYcNDT6uHf2CuKCzF5aoX
         v/DChghGIp9RSsxqunueVqamjNSASYUBp6UICAWAUeCSiqD4XWdb9m2INJ9vaNaqKyiK
         kC5y7RDIEZ9xwxDRUi1t4/8St7Cp947SGLGzUqRZKEBsymXqXBBVUmpXr0lsuyfCUG/I
         upPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=685xBwl/GBvFkv1S7Xz1MyjO5YpasZQdCXRqCgk4Q8k=;
        b=5Gbl7JN8s0SirntAR+9YQ6ZJ8xxWogAxiIDFzMGDPRDRWVFIkgVwYFcB3v9CzfOOus
         eM+7CxBSFrAf+laiaApI6Xx/RFG1/7A7mqhtQ8rxoXeAjZzuuFRtceqkdL6bFernLxE6
         ygTLpHRskxUTWb3PEf7V7qtD3GiNK070Plq+VZjnBbVGOnWdsIW0mnuqBqQO95vTxJXW
         VjDO8w4GcJjTr4H8b5aF3iJVwNvgvp/79tCOTtlYwlQkWmDuAw+SYV5swDvmr03GS9zf
         qG3qEEpGzWezpQbLb1mgsdaLyTrjfUnE0yvgNqaM+5XsTgIAApfR4EfshfZk/CQB0AE9
         1gXw==
X-Gm-Message-State: ANoB5pkB+IZLeXiyBb5vletY29tuVHRA5Qspo5bW49Tbym3nkRN5ak9p
        iyBn0NAuCWpja07UQg0GvifJAAesFaBFEA==
X-Google-Smtp-Source: AA0mqf5xcyHzhe+6QQd3dtmwn6fvMJdegw2dlXZim7w4R8NS78d8xgxRvrZIr6ltiQBcpxBAcM7kVQ==
X-Received: by 2002:a17:90a:804c:b0:219:df58:eec5 with SMTP id e12-20020a17090a804c00b00219df58eec5mr34946229pjw.30.1671231804099;
        Fri, 16 Dec 2022 15:03:24 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id gt18-20020a17090af2d200b00218b32f6a9esm1872575pjb.18.2022.12.16.15.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:03:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Prajwal S N <prajwalnadig21@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Add git config variable for signoff
References: <CAC5-4e-hViTA36gg=ui5=kUsSswVe+XhRmBz56H-4PkuhYLrrQ@mail.gmail.com>
Date:   Sat, 17 Dec 2022 08:03:23 +0900
In-Reply-To: <CAC5-4e-hViTA36gg=ui5=kUsSswVe+XhRmBz56H-4PkuhYLrrQ@mail.gmail.com>
        (Prajwal S. N.'s message of "Sat, 17 Dec 2022 01:20:17 +0530")
Message-ID: <xmqqtu1vkl38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prajwal S N <prajwalnadig21@gmail.com> writes:

> I noticed that git provides the config variable `gpgsign` to enable
> GPG signing of commits by default (akin to the `-S` flag). But there
> isn't a variable yet for signing off commits by default (akin to the
> `-s` flag). I feel this would be a convenient feature to have, since a
> large number of projects today require every commit to be signed off
> for DCO[1]. I am willing to take this up, and would like to know if a
> patch would be welcomed.
> Thank you!
>
> Best regards,
> Prajwal S N
>
> [1]: https://developercertificate.org/

I think the latest round was the thread leading to this message:

  https://lore.kernel.org/git/xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com/

There was an earlier round:

  https://lore.kernel.org/git/20161229084701.GA3643@starla/

