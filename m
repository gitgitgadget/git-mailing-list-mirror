Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1254EC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 15:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbiESPXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiESPXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 11:23:48 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F25EBE5
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:23:46 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p3so4817407qvi.7
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SIJYWMeGNE6gqAIbqqZELYZ37fjSLwxb75Jam3Ey0xY=;
        b=TsnG9ILtuaPiw8sUyyREF7IeBYIhlNLKO0bpKgNVMLUNQaX8UcYIGbSXf2NmbsQXDB
         Y6ytK+LUkNM+SmwkZctXIxhLOC2S4M8EbdkAkRaaGqBa7IYc6fGpx9ghUIv3bT7JQf9T
         zuwRNVlbHthjDzArFqd0E9ieGL7dpZ8ypaYzqup2xf/uAWQXoTEXQ9VqjE2yZvq/6J+X
         l72rAqb/ibEziR/lXeyoqHrDEwhKSmEkvrgLwXs5chkNAW2DbXVAG1aKoykrPbMMpnFI
         gTH9Y1hSZY+jATb9mtN57m/+ESoZpCMCcz5oA8riY9PMezQJ8ZvL4BB9vYeW2y31dH2r
         rrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SIJYWMeGNE6gqAIbqqZELYZ37fjSLwxb75Jam3Ey0xY=;
        b=CM99HsLR0Op7X5z1sKOiG9ZbGMJ8qV0TPhCwJHGoRlAt60oVklvtKO548iw/XvHuMK
         lnCjlww2LQOOKKYh4yL398uxVnE2WslkLfbj9rVZ8tTdpvJeKRkQSj9P80Q9RgzrEygN
         P1UgiUbZTb0LF4moXUmdZ24mEQYO1bBfRplISG6vKlkT1M/suEX07PwYo9YRwMZ7ZMH+
         kd+5qmHNQRcK6AIBeiQG7A9I11G/YU2aBb6rY4R/ntTmiYvLIM5cQSsvNl/Q7hv+Dkpk
         fkwHaDNh5bOPV/+0ByjDBXEeEE0kqElDMtAwMzAC33Hft8gkO+OyHPaK8Uf2rb218Ijq
         XP+g==
X-Gm-Message-State: AOAM532FLNgtN2MLBwm5rVVzzkRQXYs6fkmrF5vLCrVKQ7Kp4lenhkAx
        uThBC+PW8bhsJJ7hhNVSBZcKnnWPtMI=
X-Google-Smtp-Source: ABdhPJxCf99JBW7/J9u8trW30pOJQiONIyJ8KQWgbIe+1SIcKnHNL6RcBKS2qL6taXx119tJNVx8Dg==
X-Received: by 2002:a05:6214:764:b0:45a:98a0:ddb0 with SMTP id f4-20020a056214076400b0045a98a0ddb0mr4543607qvz.15.1652973826026;
        Thu, 19 May 2022 08:23:46 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([50.221.51.195])
        by smtp.gmail.com with ESMTPSA id u16-20020ac858d0000000b002f3d52d57bcsm1548138qta.26.2022.05.19.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:23:45 -0700 (PDT)
Date:   Thu, 19 May 2022 08:23:44 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2022, #05; Mon, 16)
Message-ID: <20220519152344.ktrifm3pc42bjruh@Carlos-MacBook-Pro-2.local>
References: <xmqq5ym4zpmn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5ym4zpmn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 16, 2022 at 10:37:04PM -0700, Junio C Hamano wrote:
> 
> * cb/path-owner-check-with-sudo (2022-05-12) 4 commits
>  - git-compat-util: allow root to access both SUDO_UID and root owned
>  - t0034: add negative tests and allow git init to mostly work under sudo
>  - git-compat-util: avoid failing dir ownership checks if running privileged
>  - t: regression git needs safe.directory when using sudo
> 
>  With a recent update to refuse access to repositories of other
>  people by default, "sudo make install" and "sudo git describe"
>  stopped working.  This series intends to loosen it while keeping
>  the safety.
> 
>  Will merge to 'next'?
>  source: <20220513010020.55361-1-carenas@gmail.com>

I am obviously biased, and probably confused, since this is already in the
"cooking" section, but I think this is ready and should be merged to next
without the optional patch 4.

That MIGHT helps us understand how bad of a regression it is in the real
world for not being able to access a repository owned by root by a root
user that got there by doing `sudo -s` and then browsing around (which IMHO
we shouldn't be encouraging people to do, anyway).

and if there is an outcry, it will be easily "fixed" by getting patch 4 in,
which ironically might had been the only patch almost no one commented on so
far, but I think is less likely to have issues that might need to be fixed
before doing so.

Carlo
