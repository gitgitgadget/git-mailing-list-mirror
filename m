Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16279C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C995D64E85
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBPTrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBPTrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:47:51 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704BBC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 11:47:11 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t62so10580875qke.7
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YcwTQ8aOq4b8JQrRWu9Vbk2IWGJ/WUa1mq/r3sJ6KoQ=;
        b=PDAORnJqN90xC7LBmWSL7Tv4sdjnSRsT/Kjs8MVbqHguMcl0mAMgS/g4Z6GbAcRhdH
         o4+F4mC3XiBoTb7lSmWDd6kj1C2LHUq1ACBR4Pl3z+SStC2T3ofrHd2vgWF8Urj1dmyo
         OF3YGPUfj3c71UJgJyQHeIro7P5f9GxT48zwr9I2zi3jwnwYjxQrZVY1QoxPoOGxQMJg
         dTCYgYDaf+Q1n6wLCjSxS6kvzwFwGk9Qvc6FDTTuJzvGcTnDCj/9sIQ5JaLLb2PW+6Fx
         +p2WduFVWb6ugpy7WIVtXa3fUo1xfHfouTbn+/lUu8UDxnAMnaaBwns5ks6WiRmZoT2z
         ukEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcwTQ8aOq4b8JQrRWu9Vbk2IWGJ/WUa1mq/r3sJ6KoQ=;
        b=IsGsd3z0fmgRPRTNeC1LzFJ+CJO8qnoYyWsv+YTUMKQDaYMtBd4t/fys+heTlQqDJn
         yrkXwv7Wyn330nQ33gHMZ4b+p3iQfUXA9d/Gx8kD7yRR0l5hTFsqIgbCOalkmtZpTFBI
         hGzf24v3/eOEIn96WtTlkxKjEODoXZPvywsYbUNoBMiqwXqWCaMe/jg/PbWfOBwbmIyj
         QsiNIJ9YNTO9GbhRS9KNWXLTVcfFYx2YYT/MBxBkIgIL2rwi/Hzoqp69V1qtjgnIfVnY
         +FxjAMejceOwcBgEcEp2D/4pBoMF0wt6Yhx1KmhRCKb/Rgq5V0gwHhAVDMuebonVQ/BG
         C1nQ==
X-Gm-Message-State: AOAM53339Ok+ZPPY2zL938FaCj3Tt34R7vz0vZnTvt8SukfsH+Kdz4m7
        4mcAnCikjzgRf5d9BMtYwwy/oA==
X-Google-Smtp-Source: ABdhPJwwbNjBbH+gWdTl/C3bBxS9+RL3dakfACSTvxX4BpEutrcXxvFvYnGSC7qTEKIq2sESevqiAQ==
X-Received: by 2002:a37:de11:: with SMTP id h17mr12824581qkj.351.1613504830615;
        Tue, 16 Feb 2021 11:47:10 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id o185sm4670828qkb.76.2021.02.16.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:47:10 -0800 (PST)
Date:   Tue, 16 Feb 2021 14:47:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break
 parsing
Message-ID: <YCwhPG6RaAhU9ljg@nand.local>
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
 <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
 <YCwJ8tORQg2Air4r@nand.local>
 <xmqqmtw3pzu3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtw3pzu3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 11:39:00AM -0800, Junio C Hamano wrote:
> A few comments (not pointing out bugs, but just sharing
> observations).
>
>  - if the line before "trailer: single" were not an empty line but a
>    line with a single SP on it (which is is_blank_line()), would the
>    new logic get confused?

Oof. That breaks the new test, but it makes me worried about whether
this can be parsed without ambiguity. I think not, but here I'd defer to
Christian or Jonathan Tan.

>  - if the second "multi:" trailer did not have the funny blank line
>    before "_two", the expected output would still be "multi:"
>    followed by "one two three", iow, the line after the second
>    "multi: one" is a total no-op?  If we added many more " \n" lines
>    there, they are all absorbed and ignored?  It somehow feels wrong

That's definitely the outcome of this patch, but I agree it feels wrong.
I'm not sure that we define the behavior that strictly in
git-interpret-trailers(1), so we have some wiggle room, I guess.

Thanks,
Taylor
