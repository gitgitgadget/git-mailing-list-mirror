Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B436C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 21:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiKQV6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiKQV5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 16:57:41 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA97A37D
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:57:09 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id x16so1635812ilm.5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/99go28p/v1c206jgVZwjP9v35Be1INRq/BwT7j9gFM=;
        b=YasBSVi9FEfHcr78KoCTZNCGFgSRU68IZ5GG0xqg3mnG48UnSGMuwlSh6B2yKx8lKV
         V1Xo0qun3m8knOHytyYJtQofPZGdq1CQSPGphe1km5o25TQYNosQo3hJRE/r6731lfEq
         XhWFYbaML5Nv08o2QyLGHxdkq9pcPJh2FHtNkEmaZJG7237/YBePFZ6u621t1+4HkMFu
         bjlSgNCsNNO8SELC9kHHx8+K9FZ1S7AOxmWzskZ4pbfZZOwPD+GxDIJa/xks8gRfZIpn
         Y8YHRxg9RW1q0gunLmAKDTE6HCjqLxfFTEAZ6acqyqKVgcvW169PY4Q3LRI+gQ7qE6/F
         zVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/99go28p/v1c206jgVZwjP9v35Be1INRq/BwT7j9gFM=;
        b=mOY5vEFrvKhcYMRqMeoxmIAy6Py2G2mF7179YdiKhBHvIWYEX/nJZABowgrw2clMG5
         NS1G4T6WKgnE+FnBHiDJk+ugIfdsf9q4Io2WNznM7Wz/gFAa0uElug63abFrN7zarfb4
         uPOL2A87ako5VNF7BUTThc+Lw+eDTR+hberUeitjzR/rNq5SKSRHoacBRbQF5VBKjZCf
         VqqEPSg2VKxKGku+rSzLoxRKoCkr89HavnmZEyJzlmHCCFqHN9dEL0vRJn0W62jyOrBn
         ejm+4PIcTN0o/FCUmSVprLltektfkzRpZqYZnZccS/y7Bp2qsCe3B6yg08pVigooOt/Z
         09eA==
X-Gm-Message-State: ANoB5pmpVfM2EEewh/PJ7ka6b68ttYAwDu3LMxOOcgm6nnlsCiXvWtEM
        rIHBYVKhlwz3coj4MjXePDo5IQ==
X-Google-Smtp-Source: AA0mqf5CKzC++Nu03XxDsFmemAiaulfoMMQ8V22yI1A+sqGzt1RP726gKzCcLULGptaaxpbrkPFWAQ==
X-Received: by 2002:a05:6e02:b4b:b0:2ff:dfa7:f306 with SMTP id f11-20020a056e020b4b00b002ffdfa7f306mr2118691ilu.9.1668722228857;
        Thu, 17 Nov 2022 13:57:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b11-20020a05663801ab00b00349deda465asm628916jaq.39.2022.11.17.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:57:08 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:57:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y3auMxCWJW6Otqhy@nand.local>
References: <Y3K//kO3fxD7Pl3/@coredump.intra.peff.net>
 <20221117141933.73790-1-tenglong.tl@alibaba-inc.com>
 <Y3ZNKhr3kMZLmQnh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3ZNKhr3kMZLmQnh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 10:03:06AM -0500, Jeff King wrote:
> On Thu, Nov 17, 2022 at 10:19:33PM +0800, Teng Long wrote:
>
> > > I doubt this buys us much in practice. After patch 2, looking for extra
> > > bitmaps is much cheaper. It's one open() call per pack (which will
> > > return ENOENT normally) looking for a bitmap. And while it's only 2
> > > lines of code, it does increase coupling of assumptions between the two
> > > functions. So maybe not worth doing. I dunno.
> >
> > I agree and I think it's reasonable.
> >
> > So If I bring it into the patch how about the commit message:
> > [...]
>
> Both the commit messages you proposed look accurate to me.

Yep, ditto. Teng -- would you mind sending them as a short series to the
list so that I can pick them up? Otherwise, I can do it if you don't
have time or interest.

Thanks,
Taylor
