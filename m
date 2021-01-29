Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42495C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2C964DDB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhA2X3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhA2X3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:29:13 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13756C061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:28:31 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t14so7994015qto.8
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fw53/9iJu1PXYuug80JMN7SqVYK3oGNAqZsPdIFrjXM=;
        b=oLUPx7EXJqI70Pcvq4A1lWIPYQ7kaKPjxqIgYJNlYXU0tYk1yIyjH/LLMSy9V9XrK9
         3gPwnhMYpMyqospihhpKCsdPsBF6qNMsNIyozbkh83pWgF9O0ghxbXM9+WG3yRwBviAV
         z0e21IPtrUKdbBOI/Infz1O0a3XgnvQfK/YHMRfqe3qKQyBBKf0LFVzzP+xAitp4AUX+
         A0n1fC6YURmasDc5xPRX0RJHrO3dHAUQPcHp+W/DSiONff3vfG5MtCpymqBxsnkIP7ol
         KcZlEw15PupbttOMKdmIcKwiHZkpqSVAs2F83oj77YfHAawdIr51cEjPlYjwcGTZkL11
         B9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fw53/9iJu1PXYuug80JMN7SqVYK3oGNAqZsPdIFrjXM=;
        b=JhNFEBlnBiFzXjeqsreWlPW+P25gd6/g2uuLa0wHMXVnFzDX0ht8QLv2bAuXcrXaM5
         mQSCw6FPS7zAZDfY1dSGOwP7CpHFZUcs1fegTMxZY5wmCEvg0OS2aTjUxT8ssDQgjUe+
         o0D240565ECYXJ2A0eisAh9FPlMLjQThSVrKr7jXGcpPbBEHjnrZXS4rtPLkRNiOy+cW
         Pdl4tCNwLbem5o5Zvj1IKT+Z54mB07IYtliV8scOgFkvgRjhDN13XnUy9QPmk3fcTZ7S
         KuOIawcXvZvTTs/sdHv6YEjQhGLZWJb1e2kfjgRwjm3nq6I0UWjVv+NDVMDR8o0y0m8C
         yb+w==
X-Gm-Message-State: AOAM532/eruK70hQA2KmInRwEAYVPUQviJfAMFpfUfCXHSLpjpnD0xH7
        6Cgn+yxahfviQvAK5K7VmlrU/g==
X-Google-Smtp-Source: ABdhPJwGJGqLbKzrQ+z/8+lU/jBulfxz9AtZDDsWfpnM8PiUadNhVyoIKzQOHdT43dwXTp7fL8pFtw==
X-Received: by 2002:ac8:1482:: with SMTP id l2mr6590431qtj.301.1611962910900;
        Fri, 29 Jan 2021 15:28:30 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f05a:e493:9aaa:4c8c])
        by smtp.gmail.com with ESMTPSA id 202sm7310735qkj.92.2021.01.29.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 15:28:30 -0800 (PST)
Date:   Fri, 29 Jan 2021 18:28:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBSaHHKV5ncjjJum@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <YBRprCmIX4IrHAi0@nand.local>
 <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
 <YBSHzG9T72nYYVt4@nand.local>
 <xmqqh7mzs5w3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7mzs5w3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 03:03:08PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > So, I think that teaching pack-objects a way to understand a caller that
> > says "include objects from packs X, Y, and Z, but not if they appear in
> > packs A, B, or C, and also pull in any loose objects" is the best way
> > forward here.
>
> Are our goals still include that the resulting packfile has good
> delta compression and object locality?  Reachability traversal
> discovers which commit comes close to which other commits to help
> pack-objects to arrange the resulting pack so that objects that
> appear close together in history appears close together.  It also
> gives each object a pathname hint to help group objects of the same
> type (either blobs or trees) with like-paths together for better
> deltification.

I think our goals here are somewhere between having fewer packfiles
while also ensuring that the packfiles we had to create don't have
horrible delta compression and locality.

But now that you do mention it, I remember the reachability traversal's
bringing in object names was a reason that we decided to implement this
series using a reachability traversal in the first place.

> Without reachability traversal, I would imagine that it would become
> quite important to keep the order in which objects appear in the
> original pack, and existing delta chain, as much as possible, or
> we'd be seeing a horribly inefficient pack like fast-import would
> produce.

Yeah; we'd definitely want to feed the objects to pack-objects in the
order that they appear in the original pack. Maybe that's not that bad a
tradeoff to make, though...

> Thanks.

Thanks,
Taylor
