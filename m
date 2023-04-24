Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E758C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 15:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjDXPp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDXPp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 11:45:28 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25110C3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:45:27 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-546ee6030e5so2504420eaf.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682351127; x=1684943127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggo1BN2ihTMc36NzHJUauDA74RTO4ilM+RXkMDKka08=;
        b=ECaomDC3+O6U16/qnC9I3PDHgJnP13EBCxzsXuA55b7aXW3fyiAdhsAuReeqpTt9pz
         TCJbAsnSir5nsZHzDDljP0k4ICkCfbI/0LYA5Zf77gke7DKK9SLD8WAmsZKVaGKf8qrR
         /V/oYbg8Ugz5bbPpQOGeV8vfGsNoDVxGB6X9eCc5HrYFcvl6NurifPPD2QILE5rrurUN
         IMktVc40/lipRUa5LS4t3QwA+DfPSyGvjtTqKvkk3T0FaWkjY3gQk2jn107cGbtmS4zR
         JGgs2K9cj4yRNW5r9ntYlfnVMHyXOLDpuZO6A5N835ofK0RtrI2QWuC8gfpKWDyypyt3
         kQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351127; x=1684943127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ggo1BN2ihTMc36NzHJUauDA74RTO4ilM+RXkMDKka08=;
        b=BWHTAHDNp8nnVgSP4ZOWYVIxrIOf3WS1nx8SmsrgATfCzHiULSWxQdHzl0wDeLvEzn
         hN+HKrh8NQZrr/yQEOg3xDUKvl0LUxm4bHtsW93jlNBTTgbr1qidUH6zV/ZfU/pmaHnO
         uQZwXVDV8IRtnZ2wRq9xXIQHObHuUnjexIMBoi5Pd9iAAyUlGw91l0uv76o1/KFT2N73
         3wkzWaae57BGW8VFoSdiJL4x7v+Rwk/7H6PDBFzS8JcCNJj2E51JAXQ6QRoIDqWng7rl
         v1BY3ZX26RZZLVjU5y/U62OYJTnT2arTj/PDvfyfWtcAX49TEUpw79HypboZxA5ihw7W
         gAFg==
X-Gm-Message-State: AAQBX9fFYg/9UF/QTXvjfR5Nfhad0+H3yUO+X1OIRzqPNY3dOV9FcLQH
        p6DNpOFaOIcnVaLCU6vRMHbsbDyEX5E=
X-Google-Smtp-Source: AKy350Z47fvEadAf6i4FKUyPxaLkxFgbR0fRo5Cn+Fiz2/g4tQcgHR4GARGzjsmNXAyFRa3HQBFotQ==
X-Received: by 2002:aca:1905:0:b0:386:a30c:f16a with SMTP id l5-20020aca1905000000b00386a30cf16amr6230537oii.50.1682351126845;
        Mon, 24 Apr 2023 08:45:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o66-20020acaf045000000b00386b8b1448dsm4682912oih.34.2023.04.24.08.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:45:26 -0700 (PDT)
Date:   Mon, 24 Apr 2023 09:45:25 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Xavier Roche <xavier.roche@algolia.com>, git@vger.kernel.org
Message-ID: <6446a415925b2_393129470@chronos.notmuch>
In-Reply-To: <CAE9vp3+_PB0_rA81eWVCF=iXnWjrUVY=1G3=1JPUbcaw2u95Rg@mail.gmail.com>
References: <CAE9vp3+_PB0_rA81eWVCF=iXnWjrUVY=1G3=1JPUbcaw2u95Rg@mail.gmail.com>
Subject: Re: Reference the master/main branch with @{m}
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xavier Roche wrote:
> With git, you can reference the upstream branch with the @{upstream}
> or @{u} shorthand
> (https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches)
> 
> With master/main branch varying among repositories, it would be handy
> to have a "main/master" reference, such as @{main} or @{m}
> 
> Would that make sense?

No, it would not make sense.

The `@{upstream}` mark is itself a shorthand for `HEAD@{upstream}`, so it
depends on the value of `HEAD`. For example if the current branch is is
"hot-fix-1", "@{upstream}" could be "master", but if the current branch is
"feature-1", "@{upstream}" could be "dev": "hot-fix-1@{upstream}" !=
"feature-1@{upstream}".

`HEAD@{m}` does not make sense, because it would be the same for all branches.

We could have a "DEFAULT" pseudo-branch, or maybe even "default", but this is
not necessary, because that's something that you can already achieve.

Your personal local repository does not have to mirror the remote repository.

You can have a local "default" branch whose upstream branch is "master" or
"main" (depending on the remote).

This is what I do. If I clone a repository that uses "main", I simply rename
the default branch in my local repository to "master".

Arguably this is something that `git clone` should do by default: if I have
configured `init.defaultbranch=master`, `git clone` should do `git clone -b
master` by default.

Either way, doing `git branch -m master` in the tiny minority of repos that
don't use "master" as the default branch seems like a marginal effort to me.

Cheers.

-- 
Felipe Contreras
