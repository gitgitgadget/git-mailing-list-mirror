Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758B21F404
	for <e@80x24.org>; Mon,  2 Apr 2018 23:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbeDBXvs (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 19:51:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46924 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDBXvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 19:51:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id 59-v6so3618221plc.13
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrlyGAsTZ0oy4fku8//G+SsYIiugdjOOJe0UqN+p/T4=;
        b=rDJGD45N3vHynmj6sCMWeR5wbysXa25llGqRGXk1fhVXmhjI6ZdaCT4wJuyTnikuxb
         BT/CoUnHrBxCtZMldC1KQT/T8ibDeevd32iyS1tniC4Cmk6JzLl0BOugCA9m68uR9f+Y
         6kQMT7vBWNr1D69LTi+/h0p3SU3ejCve3Nc//bgxXn5TwtuyGM4sYR9npAi5uZ43FlLK
         5WSSeDeOrkWVCnv/mTCKimjvMgsWQVkW4ys8rO/cjzVlEoyXGpl06vDIm8J7X/cejDeK
         5xU7IM9kSJQdTzIYIYm2SBdX34ZKo97j5GXUskbW3IyOx0r7TnjOztGf9Swe52/sjqee
         WxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrlyGAsTZ0oy4fku8//G+SsYIiugdjOOJe0UqN+p/T4=;
        b=BB8lB3rtpoD+h/IrWMk8rEaKwdq7p92Prm5Kp5PtTt16Kpc2kbdzu008U/hTLhLYej
         Jscli+WJ9jp5SQ1zu9vRHSVFF8hgxNpErTljPA21t4Wbi84P2c4VpvbkXRwFJ/ZersoI
         LneM8mqbCMsCgrDd/4xAltjvIVbe4v6oAJkIJLSUK/DBrKoMEb5L7MF1uoZVwtqrcOEU
         W7fYLDiDA+7jnqhQuYGZuNWuCmZwqV9uPH5wL1GuHeJcajcXlmCLxAStO2jnM6+97XB0
         YnDhC1RgJdjJgWgb/XHsCkxi/Y3nywlde2IGnBsB5N2aYWK5dbiAEHotcyS54zsRzIBJ
         sJqw==
X-Gm-Message-State: AElRT7EkscZJnqLEd9FDfkEHISQ471s4bLBuy8bbtlgHut4Uys2DSlxv
        pM7V3/8NHaxh2JAldCKvu+HMFA==
X-Google-Smtp-Source: AIpwx4+Iz1y/G/k3mwr5owftXNp8MlfGJxTm4mKM/ieQqE7d+P2OD3QVdPkaDCag131H2QFlPGQf7A==
X-Received: by 10.99.168.13 with SMTP id o13mr7539749pgf.198.1522713106879;
        Mon, 02 Apr 2018 16:51:46 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x1sm2664353pfa.134.2018.04.02.16.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 16:51:45 -0700 (PDT)
Date:   Mon, 2 Apr 2018 16:51:44 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jacob.keller@gmail.com, simon@ruderich.org, git@vger.kernel.org
Subject: Re: [PATCH 5/7] diff.c: refactor internal representation for
 coloring moved code
Message-Id: <20180402165144.73e701d7816ddfcf00006d95@google.com>
In-Reply-To: <20180402224854.86922-6-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
        <20180402224854.86922-6-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  2 Apr 2018 15:48:52 -0700
Stefan Beller <sbeller@google.com> wrote:

> At the time the move coloring was implemented we thought an enum of modes
> is the best to configure this feature.  However as we want to tack on new
> features, the enum would grow exponentially.
> 
> Refactor the code such that features are enabled via bits. Currently we can
> * activate the move detection,
> * enable the block detection on top, and
> * enable the dimming inside a block, though this could be done without
>   block detection as well (mode "plain, dimmed")

Firstly, patches 1-4 are obviously correct.

As for this patch, I don't think that using flags is the right way to do
this. We are not under any size pressure for struct diff_options, and
the additional options that we plan to add (color-moved-whitespace-flags
and ignore-space-delta) can easily be additional fields instead.
