Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D686C77B7F
	for <git@archiver.kernel.org>; Wed, 17 May 2023 13:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjEQNKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 09:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjEQNKb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 09:10:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5F5B9A
        for <git@vger.kernel.org>; Wed, 17 May 2023 06:10:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso7561795e9.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684329022; x=1686921022;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RflLKpEjeHbZTNidpZ6EfJIWtHn3Zp0Y0cYw4EqRb4g=;
        b=jMSeT+AYz8vl/+NTNwHTbKYIK3Lg83QGpnOaq9A+suGXOKZLS13JhUSJ5qgjjPhE6s
         jprIEP2lLLVnlBz6tI8KRV8vdolU+0zrW7XCQiTcJltnQTx1kLlKXuPFflvdUAArPgnO
         2ywwgjxOVA4ev/lmATuaqiiGWCcjIhjzXuCplw+z+lbSsGqbZAK283dG7dSprUquREDa
         YyIT+jkXkk3zOe+U/y438dKAI+Z5AXaku2Uaf8rLzMOXGLBGzZv5Xly9moz1k2fPm+yw
         4E1Z2e2FF50P7ACej/MnEkVElqt/MlvEwq12FmeyOhGIhxzmgq5Iz0e2arx1IgoL65wx
         Ec7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329022; x=1686921022;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RflLKpEjeHbZTNidpZ6EfJIWtHn3Zp0Y0cYw4EqRb4g=;
        b=heZuscTqJFlTrtDX8cX5F4O4rFWurOAi+fIjfZNs7X3FOOA4aGu2p5GWXFClNGyF/F
         msq0J2E5GxzkToXFt8x0f9Ou/ASNH7Jzv94qBRiebeog6RWgKB60NRxJpj3ZoGNpj5Hu
         f8H3wa/kGjTfDjnYMmLDxxhWyj0wRARKounWce8Tyq/E2jD1aIp3b+tu+Um61DKravvg
         xUMkLbQ84BCS8a1N9XmcdBTbCcleszFQmySMIpIYUcy3zN+PwhmLe/vZiASDNhRf+AQy
         0wjsolTanrYa9Y2O580ROSU3z1we63+/AbcL8D+LraKh+MHfu0AF6uLPnq4MWIP4+sM4
         rjrA==
X-Gm-Message-State: AC+VfDxO6BzCjFC3INWXdeiPdKAHfsulZnLq0jy3MS+/lM8rEj9EB1JW
        bfQQr7uoRXJ+yEap8dTKtcKi6DPN6nU=
X-Google-Smtp-Source: ACHHUZ7ujYflBmQUgmmii/v60pdaIeF1PTX/y72cns9RN5nysyQsJhg9uEq1iVTsy1SUHmBtJiuefw==
X-Received: by 2002:a1c:750a:0:b0:3f1:72fb:461a with SMTP id o10-20020a1c750a000000b003f172fb461amr27408030wmc.2.1684329021986;
        Wed, 17 May 2023 06:10:21 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id p24-20020a1c7418000000b003f42456c490sm2253872wmc.33.2023.05.17.06.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:10:21 -0700 (PDT)
Message-ID: <a6e31eb9-81e7-4d7f-28cc-73b5e46525a4@gmail.com>
Date:   Wed, 17 May 2023 14:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/8] sequencer refactoring
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> This is a preparatory series for the separately posted 'rebase --rewind' patch,
> but I think it has value in itself.

When you re-roll this I think it would be worth splitting it into two 
separate series.

Patches 1, 2, 4 & 6 are simple clean ups which don't need much work 
beyond making sure that (a) the commit messages have a good explanation 
of the reason for the change (try "git log --author "Jeff King" for 
examples of good commit messages) and (b) the code follows our coding 
guidelines (mostly no '//' comments if I remember correctly).

Patches 5 & 8 address real problems but are more involved and it will 
take more time to consider the UI changes and get them right.

I'd rather we dropped patches 3 & 7.

Best Wishes

Phillip

> 
> Oswald Buddenhagen (8):
>    rebase: simplify code related to imply_merge()
>    rebase: move parse_opt_keep_empty() down
>    sequencer: pass around rebase action explicitly
>    sequencer: create enum for edit_todo_list() return value
>    rebase: preserve interactive todo file on checkout failure
>    sequencer: simplify allocation of result array in
>      todo_list_rearrange_squash()
>    sequencer: pass `onto` to complete_action() as object-id
>    rebase: improve resumption from incorrect initial todo list
> 
>   builtin/rebase.c              |  63 +++++++--------
>   builtin/revert.c              |   3 +-
>   rebase-interactive.c          |  36 ++++-----
>   rebase-interactive.h          |  27 ++++++-
>   sequencer.c                   | 139 +++++++++++++++++++---------------
>   sequencer.h                   |  15 ++--
>   t/t3404-rebase-interactive.sh |  34 ++++++++-
>   7 files changed, 196 insertions(+), 121 deletions(-)
> 

