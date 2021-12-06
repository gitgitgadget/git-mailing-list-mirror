Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D1C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 03:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhLFDPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhLFDPo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 22:15:44 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C0C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 19:12:16 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z8so18234305ljz.9
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 19:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oacsq3Gw0Iw9CIbfkgY2CXfVYjbplvUgWNKDy70tr4o=;
        b=OV7g9IpKQ6pjrk72o27ObBLNKlrw5oRfhQmSGxCwN8OeLS4yPTgt55kfGcX3ZQr5Mn
         zXG0cTOZtluCK+7yGMMPlSV3Y88+85/9gHPMTQQT1VhWcIiH0x1t88lGRdWyMqrzw+XM
         jql6NqD95FuPU60ZPuo9qStEmtYcjr/6w/B58hvlue2/a7GmKBqhNoM/CLKoyTi88Mvo
         RM1axwtA6mVAUHQkxftLanWxGVXTXGUgieL4bgpq/LN6TGC8go8jxs1xZwNXgjfApiMx
         RBNtHgv5kMJoRpZh82NMp9zREwSq9SsBNP7PlE66j9lUO+TGxUyna+rJ8+1zDmUhF08Q
         J8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oacsq3Gw0Iw9CIbfkgY2CXfVYjbplvUgWNKDy70tr4o=;
        b=mbDiaBOVBgEGmt2VMJ3Qng8UgbhU5BX++flQMPKBJCJM3JKZaDRs+LNTng14r9Qcyp
         v6HM2rN4iS15rDin/fKvgvfViE9ZVf3QJYWJuBchKV2CxSLPnxZh5BQFbZsSRkcP/3Pb
         fhzeLbf9MbzsZBOuTYAoaVM152Qb9VKTD9atok2/aEQyW/ViBbIC+kDt5DEplYKL5YaR
         Z36P0PpOwkSGZ2FiWkkcx40UL5DElJZh/zi8R055tMlLWrKiOFEF7SeBN6qCL4YungaO
         mhRIwBIC/49uXH1UpThOqtU7Z1ZJMmUOoOUIbS1DCu1rZZszPcWEBsGLtUzhRwTAidFj
         jK2g==
X-Gm-Message-State: AOAM531y72/ADPxpwlEBwVWI86eK7ZR6lpq/n9vu+bmYc3yq56X2Yp6x
        jhqMMHbyknB4wCfPJyqRRYjJ6jLSmUJ7/CQq418=
X-Google-Smtp-Source: ABdhPJwpODRQ3I27XOQHy/t7jv2CxX54iPemlOpPf0rV1u2ThoO/Vk/STQWmKiePUUHJeifPiYjyAgl4ShLBZd/rnBE=
X-Received: by 2002:a2e:9718:: with SMTP id r24mr33438425lji.406.1638760334600;
 Sun, 05 Dec 2021 19:12:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
 <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com> <f667cbcc47dd59d029f8712464f0551898a70b15.1638750965.git.gitgitgadget@gmail.com>
In-Reply-To: <f667cbcc47dd59d029f8712464f0551898a70b15.1638750965.git.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Sun, 5 Dec 2021 19:12:03 -0800
Message-ID: <CANQDOdfCHfJa4dFMhAKSJ2Ppp9KKYc9DnAe_VBWdZMd-bPgY6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tmp-objdir: disable ref updates when replacing the
 primary odb
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 5, 2021 at 4:36 PM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Note: This change adds an assumption that the state of
> the_repository is relevant for any ref transaction that might
> be initiated. Unwinding this assumption should be straightforward
> by saving the relevant repository to query in the transaction or
> the ref_store.
>

This part of the commit description needs to be deleted, since it no
longer applies.  We pick up the repo from the ref_store now.
