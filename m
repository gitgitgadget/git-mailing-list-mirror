Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7949C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 18:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F6323B3E
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 18:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgLHSBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgLHSBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 13:01:40 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E0C061749
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 10:01:00 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id s2so10839301oij.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 10:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FTU7+qBIjKK+I2y2slpJinzfHhloe0Z6jqjTd+YWAag=;
        b=b3rGgkoZ43bTj3ZMToDIvgQdr7XkXb+Lx2BzXbAx6WAzTC25QzhuEuR8XsHn7eHbgt
         +opvbxb1XRiK6w7H/sQ4k+0Tu0hco2/E2jXvI015o2zPuxGQEHbPuXH+qDKlqVI80f9X
         krwp/rohh7GH1oLkyG2/3qfJ5rD3xGd5U+bkl3rK482hXF3vJTFAsCzBsJttQww70JXW
         T57EW1Sq8JKOTu5n6InARXkwEnpiHLInnK3mwEQjqvlVMBfBEP5UardFabyd2lsHiPNB
         kegEv+U+sVK8dSiwKnLe1qedhd8CSoeAdgyZykGegp5nLIewQIoForvHl1NlKqscTWYy
         D63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FTU7+qBIjKK+I2y2slpJinzfHhloe0Z6jqjTd+YWAag=;
        b=ng0lhg4fBsyhO/58hJpyiJd4rQK7788CrlDyUR1X8HwGo7Nv9nw+hYyrlM1EKMvvxF
         P3E31BrZWVBxc2kSfiaqKz7c2zn0yNwvWMEmf9h9FmQKszVpeVgdwyScHE8xXEIYZ1/0
         tZFdZGIzSkywvYMe13SM0v+X6m6x+efW7XsDtde4oKHpqHZWZE1X9uWeivhg6jxyvC64
         pmq8AV2cXgekyS9zN08ru+Pid1Xc4sexpSQXK+zCeORTU+f7giqOew7TZ3oi0AVMQL+e
         4dR6WJtXAd8/iiM1eMWZgZbAqVNX/pKTevJoxyQfipPGvIGxhySCR+4ZSL5trj8ffJvn
         z5jQ==
X-Gm-Message-State: AOAM533jCQKB1Y8bipHYpOvQA8agoSLIzgTqI1+Zueyy2RauXWoO1069
        c8G/YGvWyTAyHXBTh6CLDmGUEQ==
X-Google-Smtp-Source: ABdhPJxXBjIZffiDmGDDremsqaG3f8Q98dIEe13oM0UXTTC1JqRDFTXn4zRze2c6pjgWQ9wGsUcE/g==
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr3626267oic.47.1607450459759;
        Tue, 08 Dec 2020 10:00:59 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l132sm3795059oia.23.2020.12.08.10.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:00:59 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:00:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 05/15] midx: add entries to write_midx_context
Message-ID: <X8+/WHBTO6GGH6Dt@nand.local>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <491667de2baef422e801df1e2c7d3173462a96ff.1607012215.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <491667de2baef422e801df1e2c7d3173462a96ff.1607012215.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 04:16:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> diff --git a/midx.c b/midx.c
> index 6ab655ddda..2af4452165 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -458,6 +458,9 @@ struct write_midx_context {
>  	struct multi_pack_index *m;
>  	struct progress *progress;
>  	unsigned pack_paths_checked;
> +
> +	struct pack_midx_entry *entries;
> +	uint32_t entries_nr;
>  };

I like that you have added a newline between the members used for each
of the two (so far) callback functions.

It may be helpful to add a comment to the effect of, "these are used to
write the XXX chunk via write_midx_xxx()", or something.

Thanks,
Taylor
