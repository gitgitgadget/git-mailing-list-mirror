Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F75AC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD9764D73
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBOTH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 14:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBOTHY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 14:07:24 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6893EC0613D6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:06:44 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t62so7318463qke.7
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a8j/JfwazEi447YdQ7VniIsahhfKClajcCCn3mSFV/s=;
        b=dd81EPNZEPg35lb5KBHCiqGxEZJrXMOj4gdVNmA7GOZx/49jj9foQWLcIFYcycX548
         +JtvXTbZ0qBEX2wtuUIlc1z1B44S0B5S75mk3K5Ukk5GcdZko27nqYZcntGoJXf3Lbgb
         1rFdsBaJnNwWr/GY7g9Kzq8WsFbHI//ANdvTJ4BCXHtk/5b26Ka40IFZ+g7YXhyN5oh9
         heRfBentDLuCpgiAB+0UxPM5+e49KIf0x0bxzyfhzOKzdHvXsimpCrntkdK7RjPCut9R
         8JqnU4vFxz02M93CXEYgYMffm/ZRtrE4kiUx+r/5nDPBn0A26VmXPHFH6A8Le/pHQDg1
         277A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a8j/JfwazEi447YdQ7VniIsahhfKClajcCCn3mSFV/s=;
        b=X1SkudZlUN2nyX7Aezf2IkTwdGG31pKNfqr1lIEXKE8Eu6Yhot1g/hJPySqOS4qcOS
         J7/c1FaS32yx3htEVbarNMFDGVQzjgeturC+N5WiRTHnATxr1WS9gyaAMIjp2PDzNk+o
         US/v6lNgNYwodpUu5WTgAQCbomLTMBSxENezdrxP1cvRUAXjGjG1y6f8Sxnvn8kTuXIj
         wp1mxHUJEBryOPIIPdVLXWcCxbngn++wYnPv4IGomgh0BkF9dEHe1N8ZyfsquL6NRKIo
         X7fQVzTFwSb/kkXF88L1fzSzCbtRdC6v+yLGttq/Q2yTplM+bk6So9PW4wFJ6uWRV5ai
         3sBw==
X-Gm-Message-State: AOAM5316MS3hO7UKY0IonXuWbAcRLeV1lnJ8W9YUPNJM1ms2JdNJak+X
        Srhv1s2ISeRIhcPe933ukcuF3Q==
X-Google-Smtp-Source: ABdhPJx6H2md1vwI4HGRroyVHPCJDrJPX45u7bY6vUl/mpdTwvhavZz1h5a3Iz2KoXm6sPi5dIsF9g==
X-Received: by 2002:a05:620a:908:: with SMTP id v8mr16798051qkv.201.1613416003694;
        Mon, 15 Feb 2021 11:06:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id m7sm11869628qti.33.2021.02.15.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:06:43 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:06:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH 5/5] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Message-ID: <YCrGQPaAs2KGeCBG@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210215184118.11306-6-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 07:41:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change the parse_options() invocation in the commit-graph code to make
> sense. We're calling it twice, once for common options parsing, and
> then for the sub-commands.
>
> But we never checked if we had something leftover in argc in "write"
> or "verify", as a result we'd silently accept garbage in these
> subcommands. Let's not do that.

...Implicit in all of this is that we need to pass
PARSE_OPT_KEEP_UNKNOWN to have the sub-commands' call to parse_options()
leave extra cruft alone so we can check for its existence with an "if (argc)".

Makes sense, thanks.

Thanks,
Taylor
