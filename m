Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC5C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CEA64DF1
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhA1Wfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 17:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhA1Wfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 17:35:52 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21450C06174A
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:35:12 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a19so7038649qka.2
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HV/eaBWg27Aw/i4uMh+E7Lh/Pwl0pIp7akAyrF1HrA0=;
        b=JHnLJc3Mu8/shF3+mO+GNQK8r0/i2oC7N+TEfIWiMWsc0DiLCgIkB3DwiqNzLfYP/+
         wXl2ZrPPoLJLm3JZba9TffMQnq86FBsqO9/1vm53c/at5m/AmPPFAOMDI22WtGN9oNf2
         zfuaGZNWWWoshobzn12cEhk63MZxQRdtO9obiUxkMsZARzSO8oqWs/IAK3x17bPG6m7r
         ul+Lwb6aBFcbbNMqa0Kx0jVNxrRJDOPutLpLvLHyYkxhIHGCRJMMiky8zt2SrKChcIea
         VO6d5kbG/xLrqNK0LtznslLUgu/BiA2ojLLlFPQz4aRwU6eJvhQ17hY1aRnCs4HcnZrB
         bAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HV/eaBWg27Aw/i4uMh+E7Lh/Pwl0pIp7akAyrF1HrA0=;
        b=NirgZH44AadCEjhWz6Zfi7vcwPdrmW5Ey/33ydf5Z+RWpF/f0WE2vD4wdWzk5Eox3g
         7st6IaCdlo9bam3Vs8Ai+NGcLVmtLPeRbk/nL4aTe/yY+d8PSsw+HuqI1lh4k0dTYMkA
         rwfumPfsXpAHMqCIgf5RKCtzfEk4+y9vRxdSaOcXOASFxJOm81NWb5pA/ONSAePEyGi8
         e/lB9kWVA/549BWgR+aqyvGKdFp6sL7MkUYZrmeokqBL7NcHMHyXZaoO1SYkLmeGFTXD
         jX6U5kLZWSS3ulz4Ystv2U2DAwkvELdLVm9Wk7kIgE8M+2f5U241fYta9Z7BECI9S1w8
         ofuw==
X-Gm-Message-State: AOAM532K0TkcJx3BpoAIK7aHO0khc5GMQ+ALHyzaEew2eMolSAZ1ivRD
        goanOYrCTp8LiDbkYgiks9qrjeQShq71nQ==
X-Google-Smtp-Source: ABdhPJypoQ6obO6MZuPk4HUEIsuCvaMLVzDEBzF7WhKjvwohqhym6lEp59a8GDdXfCFUkK2CQtK0iA==
X-Received: by 2002:a05:620a:2239:: with SMTP id n25mr1557216qkh.46.1611873311360;
        Thu, 28 Jan 2021 14:35:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id z22sm4255231qtq.31.2021.01.28.14.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:35:10 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:35:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] rerere: tighten rr-cache dirname check
Message-ID: <YBM8G/N/Oo1BMWKa@nand.local>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
 <YBJW0gRn9SnP6N9d@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJW0gRn9SnP6N9d@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 01:16:50AM -0500, Jeff King wrote:
> Note that "get_sha1_hex()" is a confusing historical name. It is
> actually using the_hash_algo, so it would be sha256 in a sha256 repo.
> We'll switch to using parse_oid_hex(), because that conveniently
> advances our pointer. But it also gets rid of the sha1 name. Arguably
> it's a little funny to use "object_id" here for something that isn't
> actually naming an object, but it's unlikely to be a problem (and is
> contained in a single function).

Not that it matters, but I think the argument would be that having "oid"
in the function call probably isn't ideal, but it's closer to the ideal
than having "sha1" in the same call (which isn't always the case).

Likewise about advancing the pointer, since everything is pass-by-value,
modifying the stack local copy of path doesn't matter to callers of
is_rr_cache_dirname().

So I think that this change is an improvement over the status-quo here.
Thanks,
Taylor
