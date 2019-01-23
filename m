Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B251F453
	for <e@80x24.org>; Wed, 23 Jan 2019 22:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfAWWdX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 17:33:23 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:55306 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfAWWdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 17:33:23 -0500
Received: by mail-yw1-f73.google.com with SMTP id q82so1945681ywg.22
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 14:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x+h0nwx2ZhA/K7HA35O9FTe156ZF9YRb7Z4GDExObgQ=;
        b=AfjAnGWYHyGIZw2kGtl8QSbyMrKQAN4HtNYVu0teImHiKSBqQFdyUwUwLY9FAksfGO
         dOrua2AyOoNCGcLZO0N2AmQX1CaDABd02Y5HK9dBd+h9eyasBNstBd+dcJJR3gs/hJiT
         RXq2JN14AtDhgWbPCvHCgtk/pzm5suNmVUQnmf0nbKHEbQpMdW2uYe+CC23fjazqXHj0
         ZLU30J9/SbZxGw+MowmxZ2jgqaJZmqmK7DWOYV6UYQrhEnub+gB2EMw6YHSuuEbdhE2P
         Ij922pFSs4qMHJDyZzojQMcCd/TEXf2JNykotF10/mVtLrCuvXcmVpMD4iol16lN3tkq
         oIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x+h0nwx2ZhA/K7HA35O9FTe156ZF9YRb7Z4GDExObgQ=;
        b=MNcX6b7n4OFBuptxkeQPagaRS02vy81hJqpByVsU2SnVmWoN38eHCqBKL4AcXlSDvC
         szc3LH87SH03KyuaX55IMR917wDH62wHaM76YXFCLsjuB2xaKlZ6/Dtadz/i1Aa9W9NC
         LXX+u+JLd4NRitNQdo8Np0isdBmUP0QMWJ+do38Q2LCKAn7pUYh2/LIN6EH78oFY0g+k
         fZYvwlwGX93n8hmfOND70fp4wrjdtnuhihDzV+IRLmRN0N6/ryZ9QpxS/oa7Sb3UHhmi
         zleEMQ8EfKBewJusKRA0MuSdohXJOiNgTtMmas5TlOccfMbFbjhGW94gtX6wDtrJDqlJ
         DSqA==
X-Gm-Message-State: AJcUukfFvDKyDoBZQZDfPni4erBUUnc4xa4IuccWNRyu9b6GBzUO4OfG
        9FNTFLa/gswCfCZbK72eWaajD1czBXMxsbp+Z9k5
X-Google-Smtp-Source: ALg8bN4lMDsJi2iSGr/S/VvKHpfX7GeEc/bmct9u/BhLeGnTxUs4c2mPPFUA6WYSUpvG/dDkXH2m0/+xfz7Achl83RrX
X-Received: by 2002:a25:cec8:: with SMTP id x191mr1853408ybe.4.1548282802501;
 Wed, 23 Jan 2019 14:33:22 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:33:18 -0800
In-Reply-To: <a4c2d5a8e16f888f9a3d1090fa92d986919f0162.1547047269.git.gitgitgadget@gmail.com>
Message-Id: <20190123223318.146120-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <a4c2d5a8e16f888f9a3d1090fa92d986919f0162.1547047269.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 8/9] midx: implement midx_repack()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> To repack using a multi-pack-index, first sort all pack-files by
> their modified time. Second, walk those pack-files from oldest
> to newest, adding the packs to a list if they are smaller than the
> given pack-size. Finally, collect the objects from the multi-pack-
> index that are in those packs and send them to 'git pack-objects'.

Also mention that we stop once the total is at least the batch size.

> +test_expect_success 'repack creates a new pack' '
> +	(
> +		cd dup &&
> +		SECOND_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 2 | tail -n 1) &&
> +		BATCH_SIZE=$(($SECOND_SMALLEST_SIZE + 1)) &&
> +		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
> +		ls .git/objects/pack/*idx >idx-list &&
> +		test_line_count = 5 idx-list &&
> +		test-tool read-midx .git/objects | grep idx >midx-list &&
> +		test_line_count = 5 midx-list
> +	)
> +'

Can there be a test_line_count of the output of ls at the beginning, so
that we do not have to look at the previous test to indeed see that the
5 is greater than before?

Also add a test to check what happens when we have 3 packs below the
batch size, but taking 2 of them together is sufficient to exceed the
batch size.

> +test_expect_success 'expire removes repacked packs' '
> +	(
> +		cd dup &&
> +		ls -S .git/objects/pack/*pack | head -n 3 >expect &&
> +		git multi-pack-index expire &&
> +		ls -S .git/objects/pack/*pack >actual &&
> +		test_cmp expect actual &&
> +		test-tool read-midx .git/objects | grep idx >midx-list &&
> +		test_line_count = 3 midx-list
> +	)
> +'

Same comment as above.
