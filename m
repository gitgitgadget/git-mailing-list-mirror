Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2870CC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69F720795
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECC+Y3Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJEHuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:50:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD98C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 00:50:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a200so1466352pfa.10
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FHXdRx57kSvFPvkgpiMpnBSvUIm3dh5lfCLA0sRRGNg=;
        b=ECC+Y3XfjEJtijsly/2yIOMRPYsm36WPOc5H2FRvnSblRqZXISK3BR1VIHpSsOFs2j
         nWcgLnSOUlQo3sUuPgFnehggJltjXZrz5d3l9dS/qIE/VmqbQceSNNDDZgmeHHJ/Zgjo
         czfd9Mk6ztJiff4vDgi1k7xtqZ8UliooOnPzr2jIInw5fEiSe4xonCkDkYdj7CeY9q4m
         MRfc4A8TfN09/FNiwSe3waW7hzcpWpRkwiCrP2G0tV7eN+mrTnMsW17kowr0BjkviV1K
         jjC2Flos5Li39MnJE2R/AKVKBT/lH977NBSMRpjboDrAC/cvwwqDNXzo4QFLgOO8wPxx
         qF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHXdRx57kSvFPvkgpiMpnBSvUIm3dh5lfCLA0sRRGNg=;
        b=PI6gHBvBkqTiirjqXqIwmtnJGo5Kl9lnRRk9cyxXiO4lIrntDIHN+GNM0doqSA3mX2
         EjbuJu3Uizq5TM42Y93p3IZ3TiQc5Jcml4B+R63sNAHCHiws03ZNHxz9df7EAl/ug2x8
         r5QKkp6c8GYanwbCk8F02fp0LH3LWOsyaDvaaOwdqRfWyH6sDkYhnobH6TtxBNi1XrBQ
         963hmUugv94DVWmrwY87mblSq/dMZfzlE+6o0Ewx7E+7aO7kgvXPCQZu3OdTr93STxq+
         ZoJ9XlMD6+kpMgfCqBo4EwKII2zT4JlE0T6VBPIcw5SP15prqs2qtmlQGnZX8ldGYtak
         6DpA==
X-Gm-Message-State: AOAM532ojb/z/JFgJOK04vhpD0+N/riZJFR3LLOdFL5mgOlTawyF6pa3
        bk7tXYv0w/fUVv9knaeEywU=
X-Google-Smtp-Source: ABdhPJxMu26PemgQVnpa9FYf1L9jWe9rHTM4xuO2RbyzMvZeJt+02covce+gJhElxvX7ODKgUY20HQ==
X-Received: by 2002:a62:1d57:0:b029:152:47a7:e04b with SMTP id d84-20020a621d570000b029015247a7e04bmr11507401pfd.48.1601884222737;
        Mon, 05 Oct 2020 00:50:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id o134sm11456075pfg.134.2020.10.05.00.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 00:50:22 -0700 (PDT)
Date:   Mon, 5 Oct 2020 00:50:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] t7415: rename to expand scope
Message-ID: <20201005075020.GF1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071954.GC2291074@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005071954.GC2291074@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> This script has already expanded beyond its original intent of ".. in
> submodule names" to include other malicious submodule bits. Let's update
> the name and description to reflect that, as well as the fact that we'll
> soon be adding similar tests for other meta-files (.gitattributes, etc).
> We'll also renumber it to move it out of the group of submodule-specific
> tests.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ...5-submodule-names.sh => t7450-bad-meta-files.sh} | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>  rename t/{t7415-submodule-names.sh => t7450-bad-meta-files.sh} (95%)

I've never heard of a "meta file" before, but I don't tend to discover
test scripts based on their filename anyway. :)  Thanks for updating the
test_description.

t7* is "the porcelainish commands concerning the working tree".  Should
this go in t1* (basic commands concerning database) instead?

t745* is unused number space so this at least won't hit any conflicts,
so fwiw

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
