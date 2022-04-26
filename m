Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D2FC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352535AbiDZPxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352544AbiDZPxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:53:16 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2D27677
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:50:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f186so573244qke.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bZXjEhv60adem4kwsZNmp+c2uojuIwaC4gHcds3HSro=;
        b=x90hB9N5I4y0v0fnIglj83sk22sjHs3fsUzMJoEvP0TPaplmnIhAw+pM5q31YPdZDb
         Re5r6il8xwqj7P+0T1jx1BIt4eur9/ff3ixfyiacqx6OpeizCjap0eYHYSBu9XCZ5RJW
         YDm0l1fzUp8uSPC+VzM0BN6m4H/n1zXjQBo+XMy3pJhl91ShSCLoOZTjGMD2zfYWvRkw
         6V7Puj+UjTuC84hfjxelvoNM4jx8gB+BhPXgEmhQ705PbH9yiiC29+L+NUUSSxe0ZSlO
         5W7zNnJhm1zPnHYwP8e1d/t+MmogLLTcR0zW3gUBLGaDsKtVHflF9xLLYjZ3lQgLQKzi
         QEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bZXjEhv60adem4kwsZNmp+c2uojuIwaC4gHcds3HSro=;
        b=ttX1kitHZ2E9ev9h7n2Vfhpjn4faL7gKuTANiLWBLyYTBmhwbPaHn1Tx/WK7kFGfOi
         e60OUEv2wyGey8cqxZVb+g6qnn3R6z7ZY5aGZQoOeqn/bDeDyaAk18DAw1GdrNHnjQji
         GInjbzMftod8z8tFx8LHAhx8pJEDUWS/hsIvKccP2fwS72blgh4Ui+N/X8aOnAehy866
         sn7fHS15nwuT8B/UaYWPBvUU/6+8OiMQeAI7a5dzPuL1TuNFWPndASzyA0ft/9tn28wV
         rM0iQD1+ygZL7i4jEQgTRhl123V2sklJccoYPBztRB3214N4auMg1YYlY7MRIngyi2XI
         eg8A==
X-Gm-Message-State: AOAM532UdqRzV+XYuP6i/oyl77xcEdiHyTCTgAqK2bimkOGx/seePO7d
        hr87dJkhzzl1FpBQFxNGdNKLcw==
X-Google-Smtp-Source: ABdhPJxsDK8V+6WkX9Xy0VSOYw2VlXo5NiOPoyPWr6kYsS3LGu372vo+jL1bUWuhkKRNJml7WaJtUg==
X-Received: by 2002:a05:620a:2886:b0:699:bab7:ae78 with SMTP id j6-20020a05620a288600b00699bab7ae78mr13319470qkp.618.1650988204550;
        Tue, 26 Apr 2022 08:50:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t22-20020a05620a451600b0069f4d952f8esm3925477qkp.0.2022.04.26.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 08:50:04 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:50:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
Message-ID: <YmgUqbawbHGRTNBD@nand.local>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
 <xmqqczh73hns.fsf@gitster.g>
 <YmdQcrl/uu7HFBlc@nand.local>
 <nycvar.QRO.7.76.6.2204261730210.355@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2204261730210.355@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 05:41:36PM +0200, Johannes Schindelin wrote:
> This idea to disable "just the unsafe parts" has come up before, and I do
> not really like it. It would change Git's behavior in inconsistent,
> hard-to-explain ways. For example, we would have to disable clean/smudge
> filters, which would then break, say, Git LFS.

I share your sentiment on the "don't read the unsafe parts" bit.

I think replacing our behavior from 2.35.2 from "bail on every execution
of Git in an unowned directory not listed in safe.directory" to "emit a
warning and don't read config/hooks in an unowned [...]" is a little
friendlier in the sense that it would avoid breaking too many workflows
without opening us up to the attack described and mitigate by that
release.

A warning is definitely appropriate to tell users when we are and aren't
reading config. I strongly dislike "read some parts of config and not
others" though, since it seems (a) even harder to explain and
inconsistent than this, and (b) extremely error prone and fragile in the
sense that we are unlikely to completely enumerate every possible config
-> execution path in git-config(1).

Thanks,
Taylor
