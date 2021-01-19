Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82694C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6370723108
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbhASW5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbhASOZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:25:31 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE5C061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:24:51 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id f26so21938063qka.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ApFnGERGqEpKW6m6TxZrVIQ8n8ZJ+C+ryg8LHGOEJZ4=;
        b=wuwFTRi1VF+l2PbVlQHk3IF998ZtS1S1hW8q3DBk6ycwPS+gV8p2PZtzJ9chlHCBwB
         MIhDK+wYVcfdqIXiCVDOLYvb8ytNIGSRUhm0NfS+LI2SH5ZMI2x9jIXvMujAdmuF9CZn
         t0PbBflPNEP1zq+kSjMp44lULMJXXmHZ/gqN8pBB/g4bAxZaj61eaCW4B/tarXd31NLu
         DnuCOz82SFLO+eqeukQi5yy6ADYFsamdzsCfFnwSG/DgtwSCdNHzMz34rI60rkHZ5s58
         HMulgZ3T92G6d+mIeb/f2qeKPCdoLTxzFRQG+VQ0OzATkN7kP0uUAykYJ3W49CBh3pZR
         c2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ApFnGERGqEpKW6m6TxZrVIQ8n8ZJ+C+ryg8LHGOEJZ4=;
        b=HRLTHmsesdd3EfmwBBF8PuUbXrG8q0YfpL2dXCNgP+T7qeafSH39cLSSZWyHAAiwoP
         HL7wGt6lCoa/XaKRhyjj2q6p5cAVlRPD1ZG18rrfByyPGsmU7fIoxk12xHEP6/PB9S2y
         6Bmk7aB3hpmsbQx6CdpyCN9F5UYD7W8pqpE9yKCOFz+i8yVhdJLFCn0LtXwpcsdOSQBK
         GlTbykd5yKjwdxzkSCf3GTd6Q63PxQ/W6A5D1w8f5W4+bxHVexJ8RemwQ8Miu4jNpmVy
         v3rjPRsxRjTLpgzxzMEuxJpDgqVkhxCGziD3Tg14j8QeZMiFjq2s4Yd5SejXyo3VXTNw
         HmJg==
X-Gm-Message-State: AOAM532cZ4FCalulV4ISHQKKIPut2DgdK9mig7f7NGBMqK5M20HSv5lE
        roavmYlyKLSSQdZ8LmViKauvgw==
X-Google-Smtp-Source: ABdhPJz5fCWT6lIgltKFPMkNdX9uyEAFPl2gD3FlsQekZW17bNWaQhYR1R75xz7Nb6Ga2QjIymgyCg==
X-Received: by 2002:a37:7003:: with SMTP id l3mr1395095qkc.467.1611066290909;
        Tue, 19 Jan 2021 06:24:50 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id 134sm13045684qkh.62.2021.01.19.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:24:50 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:24:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/2] Two cleanups around 'prefetch' refs
Message-ID: <YAbrsO1uIuE/CTrP@nand.local>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
 <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 12:52:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> Update in v2: deleting refs more safely for alternate ref backends. (Thanks,
> Taylor!)

The range-diff looks good to me, thanks!

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
