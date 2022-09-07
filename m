Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB7CC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIGT0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIGT0o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 15:26:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183A947BA1
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 12:26:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y136so10665903pfb.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=PdGpYNbmfugu1UoUBWPptR50syLOg5pJKfOSk7wmqdE=;
        b=LhC/MIVeoeDyuWm30PdzLZldTDEe+1u7PT4b7H0nPtK7dSgbagMqKvlGssJY3AHxNm
         cVJpzRkhvK4q4MgkFshTHdRa026x3Df6hd+L+uajPFs/90TFMFItkBA0/P3WQO3R9ZXH
         YtTPnypUToz33e+bSJj92dITBpllKn/s1WtKZfNQyvp4AvH3WSFcl7yoGRoJh2dFZxGE
         jj3kuos6WRdDA6gh2SoJKnQ/sw9ZsEDE1BQ0z7hhRgzouTzIUuOlhf/vx8wq/5kgPcd+
         6u1pf/7D8rh4xriD4HUBWRvTbcGhAEJQJnqiSpp3t4sQnqM2YzFGg2M7IacgIHZVdRVW
         CV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=PdGpYNbmfugu1UoUBWPptR50syLOg5pJKfOSk7wmqdE=;
        b=YRToPKVzK/xk6yARNEx0GfZvNcFhJILGwFfm92RkqFpXpVNaODv4w9MFFbGV6bN4az
         wyF4KNDmUkLPa63riNzbZAsgTzmhSUJ6FmgWHftQgpWLeH0ofcMXkMJkO/x6NmF2TDs1
         eXRLMNmyNjcpYnk0mSFdKm53VI9SkT/ajewzBR1jLiyPRqxhHtqvL3LHObZs+X/40RMd
         zYilg3HYmOtdYPLZXkOd85KHnnWcwH0osvn1udK+kGJTRAQRtRIgNjD3i1pEOzmtox8g
         MZAjU1hzAW3nrFlCt0rXG+IYBKkY25RRjF1DojjAvIpCTXkxLrjT8n8ulDEwztHLH1x0
         Qnuw==
X-Gm-Message-State: ACgBeo0VmHWOR9/Qcn7RCJiBeWrAQqww4pA6Wg+jDAQoqmus3xDDyKu8
        db5KfZaL4lom3Fy//tAjjHQ=
X-Google-Smtp-Source: AA6agR5z6arj07Y7MYfHbIlzUZuCIjHo0ShkLVb53demgiB3ESJSHVl3kalk6zCL/dQ2N6AYxwBnrA==
X-Received: by 2002:a65:6b95:0:b0:420:2cb1:68e5 with SMTP id d21-20020a656b95000000b004202cb168e5mr4584069pgw.220.1662578802301;
        Wed, 07 Sep 2022 12:26:42 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b00172eb493487sm4446365plq.167.2022.09.07.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:26:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ?= =?utf-8?B?5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
        <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
Date:   Wed, 07 Sep 2022 12:26:41 -0700
In-Reply-To: <YxfSRkEiiP4TyZTM@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 6 Sep 2022 19:05:42 -0400")
Message-ID: <xmqq1qsnugsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The exception for both is if --verify-objects is used. In that case,
> we'll skip this optimization, and the new test makes sure we do this
> correctly.

I wondered if we want to test the change on the "upload-pack" side
by going in to the swapped-commits repository, running upload-pack
manually and seeing that it spews unusable output without failing,
but it probably is not worth the effort.  We have plenty of tests
that exercises upload-pack in "good" cases.  What might be a good
test is to try fetching from swapped-commits repository and make
sure that index-pack on the receiving end notices, but I suspect we
already have such a "fetch/clone from a corrupt repository" test,
in which case we do not have to add one.

Thanks.


