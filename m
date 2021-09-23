Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D50C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B433560E97
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhIWCI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbhIWCI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:08:27 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C9C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:06:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a20so4957708ilq.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Zvo+MXdZgknfNewa/Hg858kFxxQgfTtaUkHKyThgI8=;
        b=OWI72d7WvE0dYrglfMsQeByU2uSw8rJUAPjSvHiOhb23NAXhmGFdkjX+8D5BzfRlmq
         K6HZXFuI9Oa/qSRArt3wDtJ6XkKCOud3cqM7rIEc8lolEi38p9E1vCX9smeRWW5fGUbu
         0PEY6L/pf7xv6ct2dh4B3Z7So3B7rxpR2Eyo5Im4Xkno5jGcivs3FEND2x1AWnE6h2Oo
         lpNCZif8euXISsLruznHRT/z47epylD4C7vjcPnRbt75moDV3m3ZjyRDa4FUhmMTh9Mq
         9Cs0S0Jc8KyC7c/JJYb8X/ygZPwuEQaAqzGsLQx9er9bAm7DhRkNlvlYGAjaNXfz3A6N
         i4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Zvo+MXdZgknfNewa/Hg858kFxxQgfTtaUkHKyThgI8=;
        b=qz3vdtwJSjZESZXWBaJfJwyeNUXhyILh31nVunLnmhop9c7pA5f8VnLZx8uvI0++Fd
         n1F9yVHPLp4xQMTenmUUHQNvx0WVkcPc3JotOw+ExF3KsjWq7RpWWCXFscfq3Tk4s1KH
         Pn/1feRnswSAJFkfkGTu98HtMDGDGmdU15+anhJCUgKrp1b+BwjBYhokN76SjC/KZOnZ
         R3whDrpB29xpYgeTRfk4LkRjueh1zad8h1C1+J7gYg6UdppWMdixsWoC5ZlXXjSeJewS
         dLG+/gtY22l9mnf9qckzaaLDUj5k0GnyBQT37o30p7b6n0Q7QNoZbKCtlEthgcVM+9Dk
         HCDg==
X-Gm-Message-State: AOAM532t+s7wXv6f2LoqAfx0/t9gHKx9TiiocP/aw/YP1diLCk/h9GKT
        N8FFUrehigIt6HhlysWDAPanrg==
X-Google-Smtp-Source: ABdhPJx3dzf7C38ZcGN9RizJLk6r9uHnPa/cr5jZyG3jQZYYSfL5XiCsw4QJP2dEhvr79oc9HQfyIw==
X-Received: by 2002:a92:1306:: with SMTP id 6mr1586602ilt.183.1632362815812;
        Wed, 22 Sep 2021 19:06:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y6sm1706004ilv.71.2021.09.22.19.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:06:55 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:06:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 2/8] builtin/multi-pack-index.c: support
 `--stdin-packs` mode
Message-ID: <YUvhPpRzyfBua0wB@nand.local>
References: <59556e554565120929549239f1aee5a76d80ac8d.1631730270.git.me@ttaylorr.com>
 <20210922231137.2610100-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922231137.2610100-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 04:11:37PM -0700, Jonathan Tan wrote:
> > An alternative approach
> > would have been to call that function from the `git repack` builtin
> > directly, but this introduces awkward problems around closing and
> > reopening the object store, so the MIDX will be written out-of-process.
>
> I'm not sure if the implementation direction started by this patch
> (eventually, running "git multi-pack-index write --stdin-packs" to
> replace the midx of a repository while "git repack" is running) would
> work on platforms in which mmap-ing a file means that other processes
> can't delete it, but if it works on a Windows CI, this should be fine.
> (I don't have a Windows CI handy to test it on, though.)
>
> Assuming it works on platforms like Windows, this patch looks fine.

It definitely passes CI :-). But special care is taken to handle this
case, and it works for a couple of reasons. Notably that we only call
`write_midx_included_packs()` (which in turn invokes the
multi-pack-index builtin as a sub-process) *after* repack has called
close_object_store(). That means that `repack` won't be holding the MIDX
open while the sub-process is trying to write a new one in its place.

The other reason is that the multi-pack-index process also makes sure to
close the old MIDX before writing the new one, so we can be certain that
neither of these spots are mapping the file or have it opened when
trying to write over it.

Thanks,
Taylor
