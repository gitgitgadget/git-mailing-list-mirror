Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B301C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2ED761168
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhEDUKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhEDUKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 16:10:50 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A2CC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 13:09:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i26so37086oii.3
        for <git@vger.kernel.org>; Tue, 04 May 2021 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ur5Og/fCIBNyipAUH297i8n2pqAvF6gNpzuk2QiC9Ys=;
        b=sBPvs3zS2BwQ7w6tFHoQ5fiZvTPstwCCHYgxV+JdKIQwhybDjIUMjJU/kqB1xqgj1N
         lmpfO+CyJuC3FKsyYljhBILY70oxmr1itvdAt6wpDF3scrMHyOZssPTJu86VhkrRys0F
         ZPP5nXW8FkuZWOaXu2eofqsHHcyHTwSwo63UqY3ezym/wOMDdquL5XHDmfNdRtzVyeNs
         tmpmzIe5BkJ3RuzPz1DXSddTwOCDeewlP0B9/kuPwHCeWbwX4qFas9qetFdrD21Ad81w
         oiKy16B+2l0wapntgnPB46BHR39XmlXAGMRE+1/VEFoATbn4jX3QjwwDROZGOYGqEYO6
         2IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ur5Og/fCIBNyipAUH297i8n2pqAvF6gNpzuk2QiC9Ys=;
        b=Oho6+T/zNGaJw57FvVHdAvnJYYnRw/Lr4m5Xapm2aSPPYQcVQ/8aV+KhQ8lc3s3GkP
         jb29cJqydxShBonlIojnqdIiR9OwhEEwfWjDQkwhPqR1deREIcCfSQ/8vOeBR0dcTb6h
         btvha86E8tCkzDNUeCYHV4WJYoRabV0HC234EuztVGBMSYYbUMc6DfYJ5+YCuCK/QWjF
         c8wmri0OPUNiH8zbjE6qmxbOtgTrSHgK5lS+UVoWJRv+kqAArkbYIRyX7zlc47O3V/Q8
         1ZJ/iK1gxnPcGm85QI1PrUinLSa766LPHya7JyrMTYUDG/dYxPZEuQNOZ6VYNaEoF7nK
         oSNQ==
X-Gm-Message-State: AOAM531nRM5QmiLjwn+t0pRcf6ZG1mOpTG11bWDEOx4N3YxwUsCAXrB0
        yjOOQZIyC4mn3HLZUCVuWm0=
X-Google-Smtp-Source: ABdhPJxq9akPFhS3E2oQOzOrTiEIzXsZE5DaEB2ZjpaQaKn+j5SxLENbzliHkxOaD2r/IemYaIrRIA==
X-Received: by 2002:aca:4e94:: with SMTP id c142mr15421932oib.107.1620158995074;
        Tue, 04 May 2021 13:09:55 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z4sm1044107otq.65.2021.05.04.13.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:09:54 -0700 (PDT)
Date:   Tue, 04 May 2021 15:09:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <6091aa0dee8f4_b34a8208ba@natae.notmuch>
In-Reply-To: <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <xmqqwnsl93m3.fsf@gitster.g>
 <87im45clkp.fsf@osv.gnss.ru>
 <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
Subject: Re: Why doesn't `git log -m` imply `-p`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Wed, Apr 28, 2021 at 9:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Alex Henrie <alexhenrie24@gmail.com> writes:

> > It is best to move on, writing it off as historical accident, and
> > embrace the new --diff-merges=m option, instead of wasting time on
> > pondering "why", because accidents do not have to have a deep reason
> > behind them ;-)
> 
> If the behavior is an idiosyncratic accident of dubious utility, let's
> replace it with something that makes sense and is useful :-) If we
> make -m imply -p then no alias is necessary, `git log` would display
> the log without diffs and `git log -m` would display the log with all
> the diffs.

Indeed. Mistakes in the design of the UI should not be carried on
forever.

Either all --diff-merges={m,c,cc} imply -p, or none should.

-- 
Felipe Contreras
