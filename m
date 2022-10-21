Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB27C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJUXvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJUXvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:51:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F61F12344F
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:51:35 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h203so3636848iof.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BpMHmBXieK/wdyT1m6bWvr/EZTvQxL6eamuuNpuxEsI=;
        b=YjjNeZxr9R1xF/fucipf/UXCuknQrS05xdsrzpJmb0MxMsghysJoanT3uSCpJH625g
         l3pjYV09xTiNywGwUdpSgLKVGYVwsic/sCjsjakeJoq1RSQUEjc5Dd6/ml1hKXZr0tiU
         G42PFsWgQLAbf3yVwzIDt8wArouF7XCei+eMWy/4JFBR7zN/ikkjRUgf66zj5rmcx3Fj
         0f5nTrdczRbAMumfZ4hxN24P+ZNavLcEpri/xOFn0EmRNs6RKd+9Ag/hWUO6iVpwepfE
         /g0G7nqioEfIhn9wk5SaMi56sxUzP7sp6iMLhDy5dSS+KnBzh3tpR3dxEMj5dA+CBfqi
         b+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpMHmBXieK/wdyT1m6bWvr/EZTvQxL6eamuuNpuxEsI=;
        b=uxuhlznlPyBWk0h/CCZQH/cEYq64X8Aaidvi/NPzW4vls//nz56Rr3yawVyYWpbO2K
         n65WxsRTWTy+wnYdz2aktakqxl8mSZDr0kWpKXGDbE88iSHaQto3K7owwaGfQDUaougq
         L1MHiDVO+Qe2PG99CoqSg3eQFfVmuGt04Uni5LBDJy2hqgS5TSZEWMt5EKwFBOyKRV7D
         SPGeXnsGe42fGzJtgw3c2cBrhO3pzZHbDX2baaXJEpbd6WbBlRyHE6mLSqww/rLlE27c
         ngkcoWgV53mKJYl+DmmKlbYXpz4FBJTyRoHyTF8fkAUqYi89lUzrBtdgM4WjNP5ckM1Q
         PQgQ==
X-Gm-Message-State: ACrzQf2mJ4fGd3ucIUmo8ToYFga/9goDydqlvZA4iNHZkmZDmkKfk6so
        7+gTQwlcxqAIjZApTIgoYE6chg==
X-Google-Smtp-Source: AMsMyM4LrRULs9xkvmUvs5k4nATwMSG9/fAGx8A/W6i7o70wIBgz4hgo4s4HMBDr43+pAZz7Jru6cQ==
X-Received: by 2002:a05:6638:19c4:b0:363:afc3:b403 with SMTP id bi4-20020a05663819c400b00363afc3b403mr17365035jab.144.1666396294633;
        Fri, 21 Oct 2022 16:51:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o69-20020a022248000000b00363d6918540sm4682756jao.171.2022.10.21.16.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 16:51:34 -0700 (PDT)
Date:   Fri, 21 Oct 2022 19:51:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 4/4] repack: drop remove_temporary_files()
Message-ID: <Y1Mwhdn83MzNMsUx@nand.local>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MTtgOOWNovPawH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MTtgOOWNovPawH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 05:48:38PM -0400, Jeff King wrote:
> The one case that could matter is if pack-objects generates an extension
> we don't know about, like ".tmp-pack-$$-$hash.some-new-ext". The current
> code will quietly delete such a file, while after this patch we'd leave
> it in place. In practice this doesn't happen, and would be indicative of
> a bug. Leaving the file as cruft is arguably a better behavior, as it
> means somebody is more likely to eventually notice and fix the bug.  If
> we really wanted to be paranoid, we could scan for and warn about such
> files, but that seems like overkill.

I agree, that would definitely be overkill.

> There's nothing to test with regard to the removal of this function. It
> was doing nothing, so the behavior should be the same.  However, we can
> verify (and protect) our assumption that "repack -ad" will eventually
> remove stray files by adding a test for that.

Thanks for adding such a test. This patch is beautiful :-).

Thanks,
Taylor
