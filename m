Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394B9C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiLLRGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiLLRGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 12:06:11 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B27A1056C
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:05:53 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id i20so2907344qtw.9
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSo03PPxo0StPEDXfZJ1QxknWIHzN9PZI56LpwZVvJg=;
        b=Jf+qEE8PN5yhCtQEDt08f/qqcHJqOYHfyFwMCshLgYsKbsdmIuqDeJmQ0nef/Cq0wu
         pvcGz3KDK6y1ZAUA40xd8G7EbnAxq2g8h3r5OWUK4C9P5KsxC1l3rtnBuF6pGeroHEPI
         58aXcRP+xxejjuNWRboOKZ9WDA1s2vhuLFrSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSo03PPxo0StPEDXfZJ1QxknWIHzN9PZI56LpwZVvJg=;
        b=cqW7bNpQWe3fFTw+EJspGMv5c/hgDbFfmvmW0qFz0nI88Kg68bCoq7XG1phGrd/yBy
         mDHsFaWOeklfWPUub1SKAvCxpMnqTrQce7F49GGIHbOkt+OFacO9m4ReMFldlb1Aa6r5
         i8a9V/Hl/OeBBwL4/7u6mBWyWsuL1rNKow4GcYLNqgtoYyRvZAvlCnELPkJBjgk2mpNS
         2svIlIF/ZA82vFXOKng3LU6m7ULLpiIu6Vgw8rTEmRkFYBPxkXCr6acNiZ2RPlTgqK18
         Ywg7aou6deUGpsdo1JdxNjB7ZkZHZA6dDa4ZHyUaqNp0aUUpuNsutzZrWHvxoQTkwyE1
         hxAg==
X-Gm-Message-State: ANoB5pkeI3Njn3CRz+Bu7YeF3ui3ZlIZ8BhASZ/yDXAKm7lz7/rVzyRh
        a/Un/fEUJIN/UPiGb2DEuoZTDw==
X-Google-Smtp-Source: AA0mqf5ik2q7U/8xr5E2EArhPoRgb9A1u7zE1t86VlTENaLIF+W9QtWMMZov5xCLyhuG8i9Kpmpxkw==
X-Received: by 2002:a05:622a:1309:b0:3a5:258c:d6a5 with SMTP id v9-20020a05622a130900b003a5258cd6a5mr31696171qtk.12.1670864752592;
        Mon, 12 Dec 2022 09:05:52 -0800 (PST)
Received: from meerkat.local ([142.113.79.147])
        by smtp.gmail.com with ESMTPSA id o2-20020a05622a008200b0039cc0fbdb61sm2286182qtw.53.2022.12.12.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:05:51 -0800 (PST)
Date:   Mon, 12 Dec 2022 12:05:47 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     mark.yagnatinsky@barclays.com
Cc:     git@vger.kernel.org
Subject: Re: feature request: git clone --branch should accept commit hash
Message-ID: <20221212170547.a23nyw6j7sco3n4b@meerkat.local>
References: <MN2PR12MB3616CCD1EDC3EB976CE32546F9E29@MN2PR12MB3616.namprd12.prod.outlook.com>
 <MN2PR12MB3616C1F2E97A18547740651DF9E29@MN2PR12MB3616.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR12MB3616C1F2E97A18547740651DF9E29@MN2PR12MB3616.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 04:44:49PM +0000, mark.yagnatinsky@barclays.com wrote:
> Never mind, I see, feature exists but server needs to allow it.  Sigh.

There are good reasons for remote servers to not allow this by default.
Imagine the following scenario:

Repo 1: officialrepo.git -- official project repository
Repo 2: forkedrepo.git   -- a random fork by someone

Frequently, these repositories will use a common object storage backend, which
allows saving a LOT of space on the remote server. So, on the backend these
repositories will be organized as:

Repo 0: sharedrepo.git
Repo 1: officialrepo.git (with alternates to sharedrepo.git)
Repo 2: forkedrepo.git   (with alternates to sharedrepo.git)

So, if a random developer pushes commit abcde into forkedrepo.git and the
backend server pulls that object into sharedrepo.git, you are now able to
"see" commit abcde from officialrepo.git. It's just a "loose object" and if
you clone officialrepo.git, that object won't be in it, because it's not
connected to any of the heads or tags.

This situation is frequently abused for silly reasons like making it appear
as if Linus committed something that he actually didn't:

https://github.com/torvalds/linux/blob/ac632c504d0b881d7cfb44e3fdde3ec30eb548d9/Makefile#L6

For this reason, Github prints that big warning at the top to tell you that
what you are viewing isn't actually part of linux.git.

However, there's no way to print this warning if you issue "git clone", so if
this feature were to be allowed by default, it would make it easy for someone
to trick you into cloning malicious commits by making it look like you're
cloning an official repository.

I go into it in some detail here:
https://people.kernel.org/monsieuricon/cross-fork-object-sharing-in-git-is-not-a-bug

Best regards,
Konstantin
