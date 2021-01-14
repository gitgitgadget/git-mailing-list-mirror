Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E61FC433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3BD23B55
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbhANSNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbhANSNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 13:13:51 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4FC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 10:13:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id a6so4187133qtw.6
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L2MoBNt0sBn2Kcg16uYEYN35E7MrqIwGek1O0V5a/fs=;
        b=eYW+nZk2GvOv0SXLKJpx86pkN9Xd7W05wVUkwU0v51pkfj0C2EdjY0Gfx4IyaZIp0V
         pKTJNKCoAT1gEfUVb+4gLcLKZ9bfEubW174JyscqtfykSdT7dcEU+QBcn+Namvrivvj/
         J2unF6CMsQc+dEGrvG8XtHts2LS2pPkJtzs3iS4NiShAwiR6UCRCPpVtSG5zIifTTi35
         SsObmCDO+S4OvTLPkzUYdVi8pQjMXfvSzzmYS/B24kE9lq8exyc7pfm3DluLIvvo47lE
         ZYkRFBm6kL7TlhqpLSVAwULUEy8rLgEWyoK2vgjsjHNPwh7cVIrt1vs0e5iG5uUn578h
         t2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2MoBNt0sBn2Kcg16uYEYN35E7MrqIwGek1O0V5a/fs=;
        b=NXLE58iDCImnc6HKgMC4cp2HhlsT/Pj03lszX2CvNzfTaM33XhKo4pXyk4Ym1kjlpa
         /apmkDvFAXX/rhIEod7oGx1+SeqJRIrdd0gJGKq2z5ZtHvfRdS18dKeO/BBdOhYmX7C2
         vIhJcvcvri00n8eilXFWZaEcfWmbLO9emjFxC/3m/YYTyHIYCstlpSIa2LPHDkXy+djN
         cW9W/DWtrOMumWSrOOqPJGYLMDvGpgqci/Cq0d5JxM/TBrTLW4w7yfej1tc41W6qvNOu
         /ORpizsC55HtdE+Xg/sJMwFaSh1qPCJpdcE60fiy+lb9mSI1HQzOwCCjPBSkPu3xaotb
         FRug==
X-Gm-Message-State: AOAM531TGgiPGheTmsSto/usU49NhyRjeXzMEjIxJ62Xwbd/1VtinSNE
        LJzkz/N+prCbsb0URK1ijwW8aQ==
X-Google-Smtp-Source: ABdhPJw/Gpw512ZYxBJWzknMtjJRfsksGvgulTqJovF4No6fHU6PjdWmW9ZLNGspQfuI1EZpiE+JAg==
X-Received: by 2002:aed:3701:: with SMTP id i1mr8120144qtb.74.1610647990650;
        Thu, 14 Jan 2021 10:13:10 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d2a9:3030:291b:4b4])
        by smtp.gmail.com with ESMTPSA id h25sm3436924qkh.122.2021.01.14.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 10:13:09 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:13:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YACJsdDToLQ24p/Y@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
 <xmqqsg74x9ks.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg74x9ks.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 11:26:59PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Specify the format of the on-disk reverse index 'pack-*.rev' file, as
> > well as prepare the code for the existence of such files.
>
> We've changed the pack .idx file format once as the file format is
> versioned.  I wonder if you considered placing the reverse index
> information in the same file, with version bump, in the .idx?

Funny enough, I couldn't remember whether I considered this or not.
Peff reminded me off-list that he and I *had* considered this, but
decided against it.

The main benefit to introducing a new '.rev' format is that we can have
packs that can be upgraded to write a reverse index without having to
rewrite their forward index. It would also allow us to avoid teaching
other implementations about a new version of the index file (since they
can ignore it and continue to build their equivalent of the reverse
index file in memory by reading the forward index).

(Peff reminds me that dumb-http does look at remote .idx files, so this
new format would leak across to clients, whether or not that's something
to be concerned about...).

Of course, having the contents of the .rev file be included in the .idx
file nets us one fewer file to manage, but I'm not sure that's a reason
to do things one way or another.

Your response did pique my interest, since I was wondering if we could
improve the cold cache performance if the .rev file's contents were
included in the .idx, but after giving it some thought I don't think we
can. Reasons are:

  - If the reverse index's contents appears at the end of the .idx file,
    then in any .idx file large enough to matter, we'll almost certainly
    still be evicting cache lines back and forth when swapping between
    reading the forward- and reverse-indexes. So, no gains to be had
    there.

  - If, on the other hand, we included the reverse index's contents by
    interleaving it with the forward index's offsets, then we'd be
    worsening the cache performance of the forward index.

So, I'm more in favor of a new .rev file rather than a v3 .idx version.
Apologies for not including more of a rationale "why" in the cover
letter (had I not forgotten that I'd even considered it, I would have).

Thanks,
Taylor
