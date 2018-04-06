Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156A21F404
	for <e@80x24.org>; Fri,  6 Apr 2018 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDFW1k (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 18:27:40 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:45714 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeDFW1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 18:27:37 -0400
Received: by mail-pl0-f48.google.com with SMTP id v18-v6so1459957ply.12
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xu9FKnOvReGffRYytZHyvdWan5qhaIbMH3TmN5UcRmI=;
        b=WKpjubFT0OGdJqyktwGPmdxZJe4DOTP5HMQbeJF27Z5651wfHxjGcpGoCqsiDiuGlC
         z/7YgGN9lwBc5nB3zTaGVON8NZXrOv3AunfzZCjCzwtGIbOelOGAtDh8mp/zMgUm1NDW
         YVGHBiGiwGGB3sFIAJttZl2vO21EVNp0u3g6P9Zwji9eZbdLJ2fDdohkX8hpH91Nf2KQ
         oC8cS9GlKGzbm7C42NYmv/PszYNDGkLFfmGoSTjHa4PNyJWbrvz2ornaB+iYkVJYz8x1
         O70IlFyR0xUshE5mIl5echyD6Mv2hSNYrP0eEQuXeQyL3xCCzWueUrce6sFM2yKUbbeN
         x6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xu9FKnOvReGffRYytZHyvdWan5qhaIbMH3TmN5UcRmI=;
        b=t3acEFzmo2RKCrtfhetyRo7KUVKdwXpHjPBg4X8jGKyxZ7zLt0s1dZckETfGeIv0co
         nRJLOEWG+OukiKXLZL2WGZ3my2dPOUa77cmvx/CIZvwkxWL25UV7ocmEEH01sv3QMQSw
         eB34tvzubmZEt2ZD7CdUYOPYLCoFNmvGrCw6qE7NH3gdWkVaHjTliqDi2SSBhf3RKQW7
         t6XLj00w7mTxhuRBsPrLlzsUg12LFIMvVPd4HjHk2EXI7lGQ8lG2kvlePYSgApn6JtkE
         4zl2PavFWIeQ10WwHMb4UewykW8m/L7c6AGzvz1kMQZOEo66zquLU4MzrSIMXaI22KF/
         tRAw==
X-Gm-Message-State: AElRT7FU5GmnPC/IqlHVFORDkZ3HcJwi9k49V4oFngx0POk9Yb25WOwJ
        6/Hdv59uC0agRoX9EiJngYiI6Q==
X-Google-Smtp-Source: AIpwx49hYzoSm9K2Q+vgY7C76HacvRoZ3J+8gKE0rGY6U0oizV2ufoFGKCvVVrer6Po1nMPNYMM8bQ==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr28754225plz.56.1523053656844;
        Fri, 06 Apr 2018 15:27:36 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id n73sm22780777pfb.108.2018.04.06.15.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 15:27:35 -0700 (PDT)
Date:   Fri, 6 Apr 2018 15:27:34 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Simon Ruderich <simon@ruderich.org>, git <git@vger.kernel.org>
Subject: Re: [PATCH 5/7] diff.c: refactor internal representation for
 coloring moved code
Message-Id: <20180406152734.b36d1301fb49fb6db7307b51@google.com>
In-Reply-To: <CAGZ79kZe1SEy2PkYGe200KwZHZVieAJJaiWYLD7GadOCCcmeOg@mail.gmail.com>
References: <20180402224854.86922-1-sbeller@google.com>
        <20180402224854.86922-6-sbeller@google.com>
        <20180402165144.73e701d7816ddfcf00006d95@google.com>
        <CAGZ79kZe1SEy2PkYGe200KwZHZVieAJJaiWYLD7GadOCCcmeOg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 6 Apr 2018 14:28:40 -0700
Stefan Beller <sbeller@google.com> wrote:

> Now that I redid it another way[1], I have the impression that this was the
> right approach, because it allows for a short
>   if (o->color_moved)
> condition. If we treat white spaces separately, then we'd have to
> have implications such as:
> 
>   if (some white space option)
>     the enum = default if not given explicitely.
> 
> which we do not need in case of a flags field.
> 
> [1] Keeping the enum around and having an extra variable for the
> white space related configuration.

Ah, I think I see what you mean. In your way, move detection can be
activated either by explicitly setting a color-move pattern (e.g.
zebra), or by setting a move-detection whitespace option, both of which
will set bits in the uint32.

As opposed to my proposed way, where you either have to set the default
explicitly (like you describe), or write "if (o->color_moved ||
o->color_moved_whitespace_handling)" instead of "if (o->color_moved)".

I don't think such an implicit dependence (whitespace option to
color-move pattern) is reason enough to use a bitfield, and I think the
opposite actually - this dependence should be in fact explicit, not
implicit. But I'm open to opinions from others.

> > We are not under any size pressure for struct diff_options, and
> > the additional options that we plan to add (color-moved-whitespace-flags
> > and ignore-space-delta) can easily be additional fields instead.
> 
> The  traditional white space flags would want to be a field and occupy
> the same bits in that field for ease of implementation, and the new option
> would just fit in by picking a new place in the bit field.

If we were to use bitfields, this would be the way, yes.
