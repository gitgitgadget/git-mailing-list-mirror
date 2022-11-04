Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EEBC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKDWJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKDWJh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 18:09:37 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60F248E2
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 15:09:36 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d3so1253892ils.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 15:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12/XC1xP4j1tnOfyWMtRGDp7Nf4r7wnARbRz7pRFKps=;
        b=3UZH8U2cECL965xdvoLSVmpP5ff20ikyGqmWznO2/LhhhDbGhjG73wbq3TZyWuZ1F1
         pmPH16oQ0W60N8IxsSLLahNBDJ17oXOWmcWeNXw8nUTZegtOCWJfNMeZyknhTAxESsdQ
         NcQDD0zTfTNR5hmUZUwXp73DarM7XSSX3dcoKc+pAHf57J/aM4YiLGSsjNqRHeXlk9+D
         MGrox82qvd1eABrzSiDt9kXd/SNXImMwsPkOwgm/p0YvSiMg6REWM6d4MHLseMzvNmx4
         DfXqu6tqs6ncrfO5AQpt5DAY3Fk30U2AJoBwbUCjiDJvSMU5gpk+xWEOLnYqkstWgjzz
         9xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12/XC1xP4j1tnOfyWMtRGDp7Nf4r7wnARbRz7pRFKps=;
        b=RRZb8RTkJnkn9OjJDHmdkmbRiTDF6vDEuStCNTRzZ5teS9tfow/R/eYiHtnUnHm3H3
         kfkf9kSSYihJcXux/ORHbRqHG3rz8z9vc3ELRX2gNdlsskkjkZ5M9U+EbWu3+1Vn8hMT
         vhlV0xJrUcwtNigr0EQ9xK8/LQ7D8OSAfvdrZLQJ4rzeSTEPzUrHxX6GDSeAKGYHtqKR
         fveug+jBnDgkXIKw44XVPCZUPNQmdyoZmXPSvGmMRrE4nuFK9M1z57OrxI9QOOBmw1dW
         LeTSyQ3z3QFRz6/ZWW3jccJ8kspqs2luI7iiwe4SVwToQkP2scSGfShnSBSffSfSX1ko
         D+eQ==
X-Gm-Message-State: ACrzQf0HjT3Ou9rTLHgb0c1/97acWqM0zEODmbnybayrqV3FK0Me87g+
        6cxYojytlqsDwvn/UGoVe/vssQ==
X-Google-Smtp-Source: AMsMyM4qrHR0MmP2+PHQLXbVI671VbpZqCg0kJTiHvLgl71qKCp/VfDk2pnmVDonhRMu20gPWP/ZLQ==
X-Received: by 2002:a92:3f03:0:b0:300:ae51:4d19 with SMTP id m3-20020a923f03000000b00300ae514d19mr16842245ila.18.1667599776004;
        Fri, 04 Nov 2022 15:09:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d44-20020a02606c000000b00363362cd476sm59769jaf.101.2022.11.04.15.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:09:35 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:09:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 2/2] pack-bitmap.c: remove unnecessary
 "open_pack_index()" calls
Message-ID: <Y2WNnqOOu+1QaOPq@nand.local>
References: <cover.1667470481.git.dyroneteng@gmail.com>
 <7ac9b859f31b2b3efb4a04896892ccd094a98734.1667470481.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ac9b859f31b2b3efb4a04896892ccd094a98734.1667470481.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 11:17:10AM +0800, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> Everytime when calling "open_pack_bitmap_1()", we will firstly call
> "open_pack_index(packfile)" to check the index, then further check
> again in "is_pack_valid()" before mmap the bitmap file. So, let's
> remove the first check here.
>
> The relate discussion:
> https://public-inbox.org/git/Y2IiSU1L+bJPUioV@coredump.intra.peff.net/#t

The related discussion is good, but I would have liked to see some of
the details make its way into the patch message for future readers.

Maybe something like:

    When trying to open a pack bitmap, we call open_pack_bitmap_1() in a
    loop, during which it tries to open up the pack index corresponding
    with each available pack.

    It's likely that we'll end up relying on objects in that pack later
    in the process (in which case we're doing the work of opening the
    pack index optimistically), but not guaranteed.

    For instance, consider a repository with a large number of small
    packs, and one large pack with a bitmap. If we see that bitmap pack
    last in our loop which calls open_pack_bitmap_1(), the current code
    will have opened *all* pack index files in the repository. If the
    request can be served out of the bitmapped pack alone, then the time
    spent opening these idx files was wasted.S

    Since open_pack_bitmap_1() calls is_pack_valid() later on (which in
    turns calls open_pack_index() itself), we can just drop the earlier
    call altogether.

Thanks,
Taylor
