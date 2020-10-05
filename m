Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE91FC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813F620774
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7bTd7je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJEHqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgJEHqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:46:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58250C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 00:46:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so5485285pgl.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYoSz+qGOSuLVwW7ln/inK3SRSvZmEGoF3msdE68o70=;
        b=C7bTd7jeNZLK7ABpQdskdXeAd5Lm+EuGykfuQFysqRdmqNWqQO/ELVpfYfe1bC8YU4
         yMY8x09a4Gycj8YDay7VVBMnTlayKet9IRgcPOUJZZxlto8xl463VmFaxL02hivGG69I
         CBVZb5r38jg/TnJE9SxOTv/rOlx7k66AYrNbohlExM+nYA10/0aBbgyEJ6xRVzx/MJFp
         gj+6JDyLTZPSEWM6qssOSotsvPG9DZcsKqCnkReHUkSGZvPocAEiNZUSxwIhAczwrYC8
         Q3SNfsPZp6HKD3CZeQB1dCwH0BZbMkLZC5YQ+0iwFeVP/1Ec+rGZAfe+GU5MsXgHC0q9
         IOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qYoSz+qGOSuLVwW7ln/inK3SRSvZmEGoF3msdE68o70=;
        b=b+NFzfXsMR0Od3Y0slLcmvvmyhHIcd+aKgWzk2zo/2tu76/Nw6Q/eMFUkPEq7khLzD
         Bljxxiz6e2fWp9zf5p0CgqgZpsvrm4hm/PJ+R1NbMJI2LQ1KIeQr2uvfRQGf2BBeWJqa
         pV8SQ+PJwzICwSKi225mmU/FOOCD5Iz3TOl/VrSHY8fuytYWUT4n92sKooq+fCGsyPuu
         IJR4sWUDHTmbvqvqKs5aJE8v7SO69KJssDUv3M6Zz/Nwa/aB/TezjROwlWDtevF0EDpc
         AqQwmrYiLGzoZlYO0mcsbahAgm0EeZgjWFot8l9E19PHMZWMwNfLdxQdzr3g1Dl4dVZg
         P/vw==
X-Gm-Message-State: AOAM5321SECo+i87Asw9qM4Wnrl2z9rTbJKTiKrNsaZ3PkJkJXWguA10
        tobpTMkGl0gRlX1YFtTvU+0=
X-Google-Smtp-Source: ABdhPJz5t0OWMTnkyoDXvjOjS6pcQ9RLFj+P0UgeofVg0qxnhrbvZIF6Vjk4+wDnBRUiZonRjnHyUw==
X-Received: by 2002:a63:1f0f:: with SMTP id f15mr12998073pgf.312.1601883989918;
        Mon, 05 Oct 2020 00:46:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id v1sm6622095pfi.122.2020.10.05.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 00:46:29 -0700 (PDT)
Date:   Mon, 5 Oct 2020 00:46:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/7] fsck_tree(): wrap some long lines
Message-ID: <20201005074627.GE1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071935.GB2291074@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005071935.GB2291074@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Many calls to report() in fsck_tree() are kept on a single line and are
> quite long. Most were pretty big to begin with, but have gotten even
> longer over the years as we've added more parameters. Let's accept the
> churn of wrapping them in order to conform to our usual line limits.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fsck.c | 48 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 12 deletions(-)

"git show --word-diff" and "git show --check" show nothing obvious
wrong (which in particular means there's no functional change); eyeing
the patch, it looks good, too.  Thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
