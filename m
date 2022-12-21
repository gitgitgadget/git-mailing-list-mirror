Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A510AC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 12:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLUMqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 07:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLUMqB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 07:46:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86D115C
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 04:46:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so2141659pjp.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 04:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a22E9jtuxUuRoNbPTygtjafVmOcdfc6ZGME6vf9JZPM=;
        b=Ey6BTqUFCFTkTxiOJtU2V2e7UxNl1e2bcnXXvtwyPkzM0HqBfJ1PuE3omP38CfO4bb
         H3f4L8VBlYC2rCyBuWHLUP2B0pKIkv2u5uFLeOd6lJQ/p67JjitUbgPWpSpYcLPDaJbd
         W2Hv88uGOHVYampPoUwmk6cBm5L0d/s5WXEUS/LtbIGrhqQSzRrV/KCyeST69yExIMt9
         UwCY5eHMSo8zJPrGECD4pahzHagYgb6V3iHUxdVKAvJvmeYpbYtUeVK29W4Xgt9LtLEx
         BBx48pSzw2RiTOBszAQCCx6y/+2ZfKhfwLTIkujLnLuQqCGQfDTjj4hUcsCRkGV/uB0s
         S93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a22E9jtuxUuRoNbPTygtjafVmOcdfc6ZGME6vf9JZPM=;
        b=8AJAGfAQBRFH1QXZp2zG20/9iR7YrW4rNHIl11PnMtx39aNBPsvZ1JySmxxdFmLVr+
         VHtTR9iKRnzOjjMVx3WLKJBZe1sgiQ3ZRnqSlCgoZ9T3ueD/LFwAB0nRwarM2zPEu/M3
         4+wSJye/vXElu2YTdXPa5gr1CW/jrND3Mu6Z23JJtMWI4uRKj3a6HtDXC0TlAbprnPnb
         UHWZPi+cF9/XVLAXgJyJxmrsOiej3DFVZgA+JkCGuBlQt7+LOu75TJihYQH4EZVA1JY0
         8Ij4ElF82rl/ZRhowPhNPrfImCLOHCMYF00JJCwqVeibGRXOYKtiwrui+R2uYzBtHn6X
         Ordw==
X-Gm-Message-State: AFqh2kpddhwarl6b1T4yLoqwE76YgKtG9qT6peTQj97wbkVodW96SceR
        eiOoHDHdodGVgdkz4B1/nuY=
X-Google-Smtp-Source: AMrXdXtoDbPzZ6Pth+rIqTDUMJy+QodOSZy2rCLWt8DUZ58l1VUpJy2LbzdNWa26Mt7RuMKmtC6B6A==
X-Received: by 2002:a17:902:8d95:b0:189:5265:a647 with SMTP id v21-20020a1709028d9500b001895265a647mr2002404plo.41.1671626760145;
        Wed, 21 Dec 2022 04:46:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902c65200b00190eb20377bsm11344796pls.189.2022.12.21.04.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:45:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #06; Sun, 18)
References: <xmqqh6xtw4uw.fsf@gitster.g>
        <b3e0db14-6c57-4188-7217-b38b5b0acdde@gmx.de>
Date:   Wed, 21 Dec 2022 21:45:59 +0900
Message-ID: <xmqqcz8csz5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Are there more regressions that would maybe merit a v2.39.1? How imminent
> do you think Git v2.39.1 is?

As fewer eyes on the codebase and the list traffic toward the end of
the year, I was aiming for January 5th (even though officially I
would be on vacation around then til the week after).
