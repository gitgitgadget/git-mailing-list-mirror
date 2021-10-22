Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E7C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7148760EBD
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJVOnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbhJVOnT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:43:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09043C061767
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:41:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so2001053eda.4
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4Afk6Jvw4/x7mW8aZeRDQizKi3Jg9dEQQ3IoDtGJxZU=;
        b=BG2SCOWZLzo5gSVj7ngJK4CvMI8zMznri6Y2mXCN4jhsTP3FMs5BzfN3qzP9B/zDDP
         T17hX1zTOJH5sqesxrZ2RUyN6pG0fKKcqI+PAJbgF1urIYa61iu2Q5FFyHEs2jBiKkuW
         LkWiHJX4yWSdo/5ri5aScc0dwPu/o3WNjqTaKI+f/aKiD57+lPNv76rPuj9az3Xu5LiK
         N1zgMasMnmydgIJmaYfh+5t5lQex82l1OTdQV/MHM4cf4CxDZ7ZR/G59zMXyRovfRt/L
         9Sgxo4wUgsbxjmByuCXnT6BPgkp3V6/mY9RwL9BTho4GA+r+CFfxipPbEgca6i7VN70c
         BSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4Afk6Jvw4/x7mW8aZeRDQizKi3Jg9dEQQ3IoDtGJxZU=;
        b=geZzKcPY55sFlLqjIewU1ofm+jisUGHkbvOShXms/KQT2BZ1QuuWy5+kBcOlYu1DER
         PhBbEIWPSd1R2nHBfspnZOeJs15jtQWFRyUinwEN2G1ymwmssK+tOuZVA6Edd4uryni0
         J31B1Ts5fugOIy74qBzxq6EoCAtSYKiFyg1xPfUb55xi43lNbMamfoffvMsn5Z9I2PeW
         vzCCMr7H6duWgZmXbn/MokZL9b+PWTyOcaxWzkuH8zhRCQLy3noeBneu6Lt4Yrxhy8fo
         Onp2eDYHv4Q6DODhrBjZNdy1Wk1PnWsCOkgandY84KHLB8WYILkR2u7T4XoThOKoToZ/
         JH1w==
X-Gm-Message-State: AOAM530XYzOiIZpnMdgLM+s6J67PELUOBVAztnSc6lo+8Xael9ZVjXQe
        Qn0SmsjVZeXzOjAeQb9rfg8=
X-Google-Smtp-Source: ABdhPJxbEuhStz+/1QX+NWtoXFDn3YuWVqWmobCf2HAbVf9+t9W0I1DwPiIFM1TspIqncx4FdCntBw==
X-Received: by 2002:a17:906:48ce:: with SMTP id d14mr13135ejt.336.1634913660516;
        Fri, 22 Oct 2021 07:41:00 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f18sm2335153edd.69.2021.10.22.07.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:41:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdvj9-001FVL-Ps;
        Fri, 22 Oct 2021 16:40:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philipp Eib <philipp.w.eib@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Error in 'git clone' via SSH in v2.33.0 (related to commit
 ae1a7ee)
Date:   Fri, 22 Oct 2021 16:40:02 +0200
References: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
Message-ID: <211022.86mtn1jf5w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Philipp Eib wrote:

> Hi,
>
> Using git-for-windows, I noticed that an SSH git clone of an internal
> repo broke for me in git v2.33.0
> The exact error is:
>
> fetch-pack: unexpected disconnect while reading sideband packet/s
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack
>
> Cloning via HTTPS continued to work.
> It was also repository-specific as cloning other repositories from the
> same (Gitlab) instance via SSH was working fine.
>
> Together with the maintainer we traced the problem back to git commit
> ae1a7ee (https://github.com/git/git/commit/ae1a7eefffe60425e6bf6a2065e042ae051cfb6c).
> Reverting this commit and rebuilding fixed the issue within git-for-windows.
> (You can read the full conversation here:
> https://github.com/git-for-windows/git/issues/3444)
>
> Unfortunately I cannot give a reproducible example as the internal
> repository cannot be shared.
> I have also not tested on linux.

This is probably the same issue as discussed in
https://lore.kernel.org/git/YWX7cd5e5q84CDEv@coredump.intra.peff.net/
