Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD22C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1477C2075B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 10:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jij7LUWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgFEKjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgFEKjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 06:39:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC5C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 03:39:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so9527522ejd.8
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFB79y11YP95LdnVdAMxnUaIhQKB0kQWVIGmI7bJJvA=;
        b=jij7LUWpbNVMCLALrBakWAOHWjBL1qVQoQBRdz269iGo03ij8MG4cROHWjWrkod5TI
         k2Q9oJQrIgp2kNsypqvIkdg+3v6rlO82QmvqZK2JHxNbMMu/6w4hyL47fwUvl5Yufvq3
         WgMzlb4KOrMnprn7bNbsY7KzeURTF6bQtA2073RIt8GKv3QkA6vcucYPF+yiZo++Vvft
         O9+9fzVqXXbaIk+1C/9ckH21qwJBu4DFl9rP1mn79tNd4eJInPUqbxgitIK5OrIBn7mT
         sG93/MfRlOxykbYWo9sUKugLuFd0M1LVPZx14kxu/IGNZFHMTccskXTdJ04NCPWDGtuM
         DWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFB79y11YP95LdnVdAMxnUaIhQKB0kQWVIGmI7bJJvA=;
        b=DD18S129XmYqh6WMrzXY2vWBBuYFWlffcddeoUJevITW6rE5yj75/czz/XPnqFVhBf
         TXrnzSjiRBXNznGFu6Qo1agwunAEtD0nfHNXFa3lr3Ljj2ulvSSFj8MdSJsM2z5Td87a
         9EsmiHP15ifvMTisWeEtinqfUhi1YFh/SKV69fpavGV/ijxNNkvn0LSUZhRI/LJ8asgw
         /5rPH2y2Hjo267sgN4gxRPJWvm4Zh1z7ikBzG3t8Fn7yYxGtrcx1+WIP4b+2DXNt1LmC
         grxMSZiBrlXw7yvZn3uWKvYr5+xXhn6Norb6BDlk2YXndU8r4JmJXxjrNqn+XvXyYnKd
         eF9A==
X-Gm-Message-State: AOAM531eCkjysqbF6eBrHVH/jefStHfXFkBUD4YXn1/zxNedHN4zCNqj
        5mZVgIxv9WK7rfcXi/JeEBf2PQDago8b0BfZ7/4=
X-Google-Smtp-Source: ABdhPJxxAbv9EIMsFjR3wmdpXdZVbdg4/+c0a7fWrYOmnzhoRy+CP4j8XP4y93pKmXYghaNqSWHMCXXbGZeSkilq11g=
X-Received: by 2002:a17:906:5210:: with SMTP id g16mr8285436ejm.197.1591353540080;
 Fri, 05 Jun 2020 03:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
 <20200604175450.17385-1-chriscool@tuxfamily.org> <xmqq7dwmpuwa.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dwmpuwa.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 5 Jun 2020 12:38:48 +0200
Message-ID: <CAP8UFD3tnNxs3LVyyZtkZY7h_fJ8_+T1vV_j3sDJmAypKQ534Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 4, 2020 at 8:07 PM Junio C Hamano <gitster@pobox.com> wrote:

>
> Christian Couder <christian.couder@gmail.com> writes:

> > There is a lot of noise in the range-diff with V2, because V3 contains
> > Peff's 'Acked-by:' and Junio's 'Signed-off-by', but here it is:
>
> Would it work as a "trick" to fetch what has been queued in 'pu' and
> compare against that lets you avoid such a "noise", I wonder?

Yeah, probably. I will try it next time.

> If it
> works well, it would have an added benefit of having the
> publically-known commit object names on the left hand side
> (e.g. instead of e5c31f30ec, you'd see d293806610 as the patch 1
> from the second iteration) of the range-diff.

Yeah, thanks for the suggestion!

By the way another issue I had was that for some reason send-email
inserted a "From: Christian Couder <christian.couder@gmail.com>" line
at the beginning of each patch. Sorry about that.
