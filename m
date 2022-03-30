Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BDFC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbiC3WpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiC3WpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:45:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147A92DE0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:43:17 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l6-20020a17090a150600b001c95a6ab60cso661459pja.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=aTYtdVbwCLWw3h2kzyHpYwdpO0aBktekuE640OUxymk=;
        b=gM1uCR+l6OH22hPLGbNyJaWTbVPqVxM+9isRhDkWf9HzBKF4rEzQI7HGAhCJXAHgJp
         3Gw9ho/4LIw2ax65LsgeVNFF4rTD8uL6Xh6dai5JYoQmJOiyMET9VLUoEDGo3/v+L6se
         EYMu1Th50TlqEScyro8xAezFGOynHjplHxc76c4kXykAp7dEhdYMNfPeT1Pu/dwAwaho
         /CkYtVcd2zPE9NPO7qlC75ZkCIlwmHlYYYRfbVIJsUz5XjWDmC5Iqiv+rvoD/YxRrb0g
         2snGO7P0uhG3/DQuka3lUOyk8BNid+laoks6MghGb/PbNwlCytpRAj5F2vCWBfG96ztA
         6J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=aTYtdVbwCLWw3h2kzyHpYwdpO0aBktekuE640OUxymk=;
        b=242K9F6793U1WAxMGCGhWiihVtzUnaksr7JyQtIqmojl6cExju7v0Fxk81Fn4ro/Xb
         1029nm6h4iBdloJmh2tm/k0lwxSCuf1/MfhlG4QA0ZpAu44Zwd1Yo1iy15b8fmcpiyZj
         qIi63vrzg52TYfqKZl3fuQsPejh9xDFoRCMVsFdtUtWd7UWdCoL2cxYpC/hC4ilNdQ9J
         heP1/KI3z+tod2CC+cQ/686cpxD8RRRoPyk9bzeAQR9+j8tCKa22Zcx/K/v14Qknk+/+
         t4s1mIpKkwCmQlOuN7hiRMSICYKdKApc5Iug2ktgq/9vNN0cMTIMDtkdhv1htSnMc9Uj
         sBQg==
X-Gm-Message-State: AOAM533PhRu4MxKD8piNY3VqGhB+L5FjnTNqkj3ovQxG6s8hmaUsoLjb
        nmcEoh56qRwVEOvnARCa1MKG7wmYIZbw98CTMPtc
X-Google-Smtp-Source: ABdhPJyL6GmDQiy5gvhXdi6lfbFAHJX275d/bSKiPxYHt4Z/CBZYVneoczr78GGfOuHwmwyrif8Gs1ajGWZ25M5rL/+B
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:9a02:b0:14f:2d93:92f4 with
 SMTP id v2-20020a1709029a0200b0014f2d9392f4mr2147582plp.160.1648680196577;
 Wed, 30 Mar 2022 15:43:16 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:43:14 -0700
In-Reply-To: <xmqqmth8qsiv.fsf@gitster.g>
Message-Id: <20220330224314.2310534-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Calvin Wan <calvinwan@google.com> writes:
>=20
> > Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows=
 the client to
> > make an object-info command request to a server that supports protocol
> > v2. If the server is v2, but does not allow for the object-info
> > command request, fetch the objects as if it were a standard fetch
> > (however without changing any refs). Therefore, hook `fetch
> > object-info` into transport_fetch_refs() to easily fallback if needed.
>=20
> Sorry, but I do not see anything common between "git fetch" that
> fetches history and associated objects and "retrieving only object
> info".  Other than "the way I happened to have chosen to implement,
> what is used to implement fetch has the most commonality".

Calvin and I discussed details of implementation before he wrote these
patches, and my thinking at that time was that to get the relevant
information, we're prepared to fetch the objects themselves from the
remote if need be, but prefer to fetch only metadata if possible, so
putting it in "fetch" seemed reasonable to me. But I agree that it's
probably better to put it somewhere else.
