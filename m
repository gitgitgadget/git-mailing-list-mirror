Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4336EC10F14
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B2B230FE
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392424AbhASSUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392240AbhASSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 13:19:53 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C6C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 10:19:12 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v5so14381106qtv.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 10:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+zKSZU/ON1rEkmva30//HdpQJxnQ6K5jprvRyQ0SqDo=;
        b=vPUDmCjUdPMfJXccPVnpR9unE4hPfhj/gTnFZWmwuoRDg/qZqBMIeUfdjXbwLPnk3R
         HltPcexbKX81hjh98if9Eb/D3/FCQayhZnALx1H26pPvboL+mqM2+JWqCidwsjdWEgwC
         dp/16yP8sGQp9PldeuF7iWQ+LnTxV2Gg8zh/OdwUms08uJWtZHeLXtvWAtXKZfKaMYJZ
         U2Tx5tBVrGrzi0dBd2JYNzEICoBsuenlk2UbA84Pn2leSwBsOQIDmgx45vngugBEwsj/
         dq6CbCeLdPIv54BufLRcdam1DWlC+iubBCGuePMdg0vb/RAihRZijwajwqB+TdPGXauH
         vCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zKSZU/ON1rEkmva30//HdpQJxnQ6K5jprvRyQ0SqDo=;
        b=Ct90XnlHUNZflW1CGxf8oWuDN461/sQ0M7vEEZzx52l8MwdniHURMGolnIw8+qUfRO
         VNkbaupmKerL5sT+6V+YXqviQOctR3jaTzoDVQutw/HzWUMZwWFmKBDso9R2f6EVZMW+
         H08J+PU+zw8YFvIZ9rg0sYQ4jlRmRq8wCX3+ha66zN9mN+8vYT6Qc/O3j34rwOEQy93Q
         QfHSGqi3V1pUSCuWuTC3ODsuVhW2VMgW4anXCsEBxmvs+gyUe3n3Beuzb4pYoCtlKNah
         TNV0T4jQwGFmYQHCp8MyzdRfAE3s86NgMOiHKFqZdCiqj20OdaMMVpcjTSAgy1/TRpX1
         0JjA==
X-Gm-Message-State: AOAM5327sCSt96SQSNgZQKrltUMgI990ulZu1aqgqwTEIHHOd92tCIrU
        Xr8Jh+pNp82AjsQ4gkeGVZgdN3iHPx24mg==
X-Google-Smtp-Source: ABdhPJyWrC7DtHXKGDPLT51g8MFy4/tveloQ+k4Lofa+LlT5o+mfuQlQxbcn2vtaKLyQxoTsaKeXSw==
X-Received: by 2002:ac8:5dc9:: with SMTP id e9mr5384463qtx.108.1611080351696;
        Tue, 19 Jan 2021 10:19:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id f134sm13261091qke.23.2021.01.19.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:19:11 -0800 (PST)
Date:   Tue, 19 Jan 2021 13:19:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@gitlab.com, peff@peff.net
Subject: [PATCH 0/2] ls-refs: only traverse through longest common ref prefix
Message-ID: <cover.1611080326.git.me@ttaylorr.com>
References: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a series inspired by Jacob Vosmaer's recent patch to only traverse once
through the longest common prefix of given ref-prefixes in ls-refs.

Instead of a hand-rolled implementation, this uses the one written back in
b31e2680c4 (ref-filter.c: find disjoint pattern prefixes, 2019-06-26). The first
patch exposes that algorithm in refs.h, and the second patch uses the new
function.

If Jacob is happy with this direction, I'd suggest that we use this series as a
replacement for his patch.

Thanks in advance for your review.

Taylor Blau (2):
  refs: expose 'for_each_fullref_in_prefixes'
  ls-refs.c: traverse longest common ref prefix

 ls-refs.c    |  6 +++-
 ref-filter.c | 74 ++------------------------------------------
 refs.c       | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h       |  7 +++++
 4 files changed, 101 insertions(+), 73 deletions(-)

--
2.30.0.138.g6d7191ea01
