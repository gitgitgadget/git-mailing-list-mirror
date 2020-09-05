Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCCAC43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B5A20760
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAeLX/GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgIERun (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgIERul (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 13:50:41 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988E7C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 10:50:40 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so9135407ilp.7
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8WGJy3Ldd4JcU+S/1IwLBun8yJkhWrMcXOBquKJD400=;
        b=HAeLX/GU0E49yVbg0CXDGImVc4v721XF+BXhAHC821DsG6Icnnvt6QEh+VcnUplweB
         3wjpSHKK+pjFTvCRf7wYa/7wfBFzO+aOsXICPCXc7+m5DajDLdcMpOhOjOtc1ffo1vti
         58ThSH5TWieyrpinNbcErCJWg/8pcOz+tVG3dAaWG2pniXMKxFyJJ5DxYgfS7SPuLNGN
         f7911eLCgcNrlzg5bQgXWpXM9tgA/6Cou9ptrFAJIe0tS0TaVCnvdV1Gi4byyyDVqa0l
         lu38eLSGNMYh7oSfStDjuk9SN0dA4ZvOj1zSAl8hvR0eXmUmQpBpT5QcD3uzHjvDX+qi
         kNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8WGJy3Ldd4JcU+S/1IwLBun8yJkhWrMcXOBquKJD400=;
        b=B8JRVOCjYsSoc8k0fCkutKMS5vawkRRefo9JMkUKxv9JL/dtdXAtqWRDMY7G1MrOQ3
         LRyeqZd+l2565oaZXx+o9PZ8DhMf8CyGiLZZ34VYLrSTZ+G+kuHHiDIHYj1hFCUzHh2O
         lFsuY8sRvRpGr/kQFUjzGV5Gfp/HdhCWiLGankoY0PW1VNWkqjDTj32HEHaLosVRlq4n
         0kDPBCp+RsKohVhzyWh0NT3bFhaMnGxz0x5NnAM5GrbKFyUg4tH0D60IbJwAbgxYEp+l
         9YyWaMgfqqkH0UF1J0GL/4Yr6EJG95ZrGM1j0HZdnIHI9oNs5BaYk0NjEOzCi4s9fS+m
         AUDA==
X-Gm-Message-State: AOAM532XhlAXMNBKr/YnXXv+TBuRQpyKxbfMw42y64bDtdo8XqAEmx4k
        nYzEwF3+twRR/iXCBf1ZI4CSk5My+SLrODTZg6I=
X-Google-Smtp-Source: ABdhPJyVQXAdkuyYLRwfkLeZu+j7gSmtnehvRtDe0WoWqixYEhnOo9IDBw1YExpGl+1M0nS4uBeUoYVi9/FU0FKURis=
X-Received: by 2002:a05:6e02:690:: with SMTP id o16mr12408421ils.220.1599328236528;
 Sat, 05 Sep 2020 10:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596480582.git.me@ttaylorr.com> <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com> <20200905173825.GA6820@nand.local>
In-Reply-To: <20200905173825.GA6820@nand.local>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Sat, 5 Sep 2020 19:50:01 +0200
Message-ID: <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Sat, 5 Sep 2020 at 19:38, Taylor Blau <me@ttaylorr.com> wrote:
> On Sat, Sep 05, 2020 at 07:22:08PM +0200, Jakub Nar=C4=99bski wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > How do you distinguish between no changed paths stored because there
> > were no changes (which should not count as *_found_large), and no
> > changed paths stored because there were too many changes?  If I remembe=
r
> > it correctly in current implementation both are represented as
> > zero-length filter (no changed paths could have been represented as all
> > zeros filter, too many changed paths could have been represented as all
> > ones filter).
>
> Right, once we get handed back a filter from
> 'get_or_compute_bloom_filter()', we can't distinguish between (a) a
> commit with too many changes to store in a single Bloom filter, and (b)
> a commit with no changes at all.

We could change how we store either no-changes Bloom filter (as all
zeros minimal size filter), or too-many-changes Bloom filter (as all
ones, i.e. max unsigned value, minimal size filter). This change would
not require to change any user of Bloom filter.

> It's unfortunate that callers can't pick between the two, but this
> implementation is actually an improvement on the status-quo! Why?
> Because right now we'll see an "empty" Bloom filter and recompute it
> because it's "missing", only to discover that it has no changes.
>
> With this patch, we'll say "this filter looks too large", and stop
> computing it, because we have already gone through the effort to compute
> it once (and marked it in the BFXL chunk).

Can we use this when computing trace2 values?

[...]
> > This is a minor issue, though.
>
> Thanks for raising it. I don't think that this is a show-stopper for
> this series.

I agree.

Best,
--=20
Jakub Nar=C4=99bski
