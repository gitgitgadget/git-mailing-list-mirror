Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9852047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdHGSav (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:30:51 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36557 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdHGSau (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:30:50 -0400
Received: by mail-vk0-f46.google.com with SMTP id u133so4867876vke.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MVaLQz7os8D9CInlQTJ88rQBvOQbCHG1C4RR/Fsi9w0=;
        b=WdK0DfAlhPck/R1SCyksheiEyW82WNsNrhmnNDLOVdn2/VJcxnsgfYdNuLUsfdnSq5
         RW79EBWOYhUFqvLA3ctIqVR86C/hllZlfagsJXUsFnyUfSsiiGlo0uFMLWf4+CDL5ZgA
         8poXL6gVpgBWn2LFxZ9qd1+NNHTI9WhGXxvnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MVaLQz7os8D9CInlQTJ88rQBvOQbCHG1C4RR/Fsi9w0=;
        b=XAAwR0FDNURkogNNxwe6kDXd/dQVhcS6cMcxJBK+fe+NrmxeE1/AEFO6QvXGMddPB7
         /h6R9IGO7l4EtHVF3Wy5hvX0FuQR8UbIzI7/uNnDfP1uOcYkwWkPSegAG9jYrZpy5BBU
         3F8Ur+mTva3F4+5BzFLObdsXxZRb8p9WM6cngTeRRWDN7dehkjzh2lD+ceIjJLK3oDN2
         8lnOKUtjoXfPcorDOcZsvyrCsS3NSd5a2K9rzd2GtVoGjZ9+KJpOMRS2Un9X4SLoXFBf
         ylketo2PvgjkazfBe2uIkHfJF/jyMHCHT+SOmvWc8ZbMbgaWm/gwWEW/T64yEcGFl0Jp
         I7Nw==
X-Gm-Message-State: AHYfb5hcCfdyjfKTuyJK4yc4NMzWZF0TwF6NILE9DPIlvJORHDKNcv6V
        mvQcH+wYk5s7LeWNHXiIYc+87kGLIJEa6k0=
X-Received: by 10.31.211.70 with SMTP id k67mr903927vkg.129.1502130649654;
 Mon, 07 Aug 2017 11:30:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Mon, 7 Aug 2017 11:30:29 -0700 (PDT)
In-Reply-To: <CAGZ79kZO517Bg+O2z3dr+oHqO_av1__FU3h9bP=rhXJUSDnRjA@mail.gmail.com>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
 <CAGZ79kZO517Bg+O2z3dr+oHqO_av1__FU3h9bP=rhXJUSDnRjA@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Mon, 7 Aug 2017 11:30:29 -0700
Message-ID: <CAJo=hJvsdkrv6uELF0BHxqk4+as8-tr1bdYNHiQ3paTmn=2sRw@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 7, 2017 at 11:27 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Aug 6, 2017 at 6:47 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> 6th iteration of the reftable storage format.
>>
>> You can read a rendered version of this here:
>> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>>
>> The index may be organized into a multi-level index, where ...
>> which may in turn point to either index blocks (3rd level) or ref blocks (leaf level).
>
> So we allow 3 levels at most?

No, its just an example. Large ref sets with small block size need 4
levels. Or more.

> The file format structure marks the indexes '?', should that be
> rather '*' to indicate there can be more than one index block?

Will fix in the next respin of the document, thanks.
