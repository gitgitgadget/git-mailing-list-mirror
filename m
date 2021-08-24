Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B3DC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5104C61262
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhHXVZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhHXVZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:25:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB7C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:24:46 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l10so8186815ilh.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gfhELHFwQ132IRH4pxwtuCGlertQhW/dGNaHb64YTPY=;
        b=HTTLdVy2DUUO3nSCCj9zvyFyLr4+ijFcXbxmaoYxO2APgO6Ku83vHdtaQaHX/qNKyW
         0+uV4QLdLMYDDW6/jJXVPw0LoL4gbkY/KX87/w3dtRFUicfRYb01oJfLU9vlTxD/nw8/
         x3I3qCVH5rg/Q99oWz5nlATCgZTLFfdmM7TJNf3viaitF9ITOQNV3nnc21f9+GKBgC0e
         3D7cjatnhw99mOcRh21nlMudzd73J2S3qXOqe2gvHIX996OiL4kRwWBBEOf850l/66ZL
         O0at98e08ebKe27VbuqNAOEwn5Ljet2/giu5tm5mjrOi8QgObDklSlZ6d1GmDdQf/NP3
         +6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gfhELHFwQ132IRH4pxwtuCGlertQhW/dGNaHb64YTPY=;
        b=IS88P/U+EC0knElJa3wpMaoe8iaaQZYnAPnArZiKXOpurhlYen9GJsren+NLLL/oas
         ORvAW6XPIIBX5cmKeW5pTHQHXiqYxCS35sJWm6sUw4Wzyf2akiN7ZS7YTyjNQSfoEvxI
         zFtruw8K8QDZbl9Ml92gvvAqbFFJe99GHPlVmb1VM+gGnu0yG3fa1bUytDMq0rTRtOEV
         VkW3IxE7nU2UrsOpzCYIBY2MlqWZftV9qXX4ZGHk9FgzrQasgojNZkXo1LPPNH7QmXR3
         6GnQpq8vsNhdZH2pOWvTR3hHhbGcEKHDzbvQxaVNjXX8q0QNkemOTz9qobI+g6PqAOEo
         /RBA==
X-Gm-Message-State: AOAM532ugkhvf+HQcs8Xk64AspXF8WiQIjItO1z2gT86yyo1N3XAQDsj
        zBdVLcYYhDjTv3aZ4d+VBbjOvQ==
X-Google-Smtp-Source: ABdhPJx/KWlI9Rjv+PrHcrUUEecy05fbjXAEgn4Us/HuNt02BX4bk+G9wTqofsCQBB2WdmrOGkeloA==
X-Received: by 2002:a92:cb47:: with SMTP id f7mr28611607ilq.64.1629840286435;
        Tue, 24 Aug 2021 14:24:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a17sm10531486ilp.75.2021.08.24.14.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:24:45 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:24:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YSVjnSDaBXgXvT9W@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
 <xmqqa6l6oafd.fsf@gitster.g>
 <YSVX18UXh9vX+Zhp@nand.local>
 <xmqqr1eimtrp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1eimtrp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 02:12:42PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> This needs to take object_dir into account, no?
> >
> > Yes and no; clear_midx_files_ext() still takes a pointer to a 'struct
> > repository' until we pick up [1].
>
> I was hoping that [1] will become part of this series as a trivial
> clean-up and bugfix, perhaps in its early part.

Sure, that works even better. I'll send a reroll incorporating it as
soon as I finish re-testing.

Thanks,
Taylor
