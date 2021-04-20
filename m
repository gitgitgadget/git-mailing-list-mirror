Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F095C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0151B61003
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhDTQXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhDTQXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 12:23:42 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E9C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:23:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so6160830qkv.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pOzyUdzWufYwXQuKaCtX/IRtRdKlKCVlb4c3AmfAeL4=;
        b=wR6Gk2Dp1ThRxqc7RsZxouN7OrsLKO+yMUZ3SJro1k8FA9nctuGye9YMuyLYlrL3QJ
         9LjT3K8S78MjvjRsa6qd2aVQTDEMUXxcF08Olkkw3Mq2C5gPTLOlhJxqekCxCKR7ywCE
         PdVVdojWdZlhevTIekDaEjQtJNhSDo8ZWxSB/MSzoH4XOu2aWLCUGpoi3bw4ipVw70/V
         GIJgVFtzlRHtEwHRoJYBAzcIWzjy6qlfcAay2mMmGshrAuKQrW+6BEuOXdOHY1pzrcp4
         MIeNk2JegKamhPSZLrmtdQKO3Ci0LEsYeP0h8qVnOkb9z6C6MKtM8lKCYkMRWCEPvSNi
         OPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pOzyUdzWufYwXQuKaCtX/IRtRdKlKCVlb4c3AmfAeL4=;
        b=oSIWhtApywHNS8SHyFtOPEO7xLwREgoUUl30c3wxiLJ7Tc8OQbiliZD1DeovkUOga+
         dtZleUQuEHxmXxFrJmB92e6Vlk4H1Grq6dSzdVV0e2nixY+DGZon2PfodtbeS6B9SDGA
         YO2Cocp0LmyjdGObclzbxTUeE3q3xuKzkUn3wirCZmitaKGliKLKcdQMsknFhd5lqYaJ
         vzavEZVb0yMdLTfFDK0C7AZdEzfCJWLgd/H/j7pNq623dqLJXSlBX3iBYYoGWsmZDc9/
         W6NcG+op7Ml/Skz/A/C8HmYjCd3knsshBbWRdnBpgxURh5Ikf6Ilt7+63nohtXKgvG8+
         lgCw==
X-Gm-Message-State: AOAM531u6s/sMIkjDcKga/4V/bXd6AlGX4QbfitK3CLtluYQj1mNMbdm
        2r8+R7RJdHFrlYD7OkWJf/gnyA==
X-Google-Smtp-Source: ABdhPJwOB6e4XLmLqDilMihg7pwFn0ZkRAtZzcnYcN133PGD1XcwihbvDPUp4uhMiou1ZAliKB4bKQ==
X-Received: by 2002:a37:5b84:: with SMTP id p126mr18809872qkb.142.1618935788878;
        Tue, 20 Apr 2021 09:23:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b323:36c3:bfb7:a769])
        by smtp.gmail.com with ESMTPSA id d4sm506067qtp.23.2021.04.20.09.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:23:08 -0700 (PDT)
Date:   Tue, 20 Apr 2021 12:23:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Random GitHub Actions added to git/git???
Message-ID: <YH7/62atD652Txnl@nand.local>
References: <xmqqmttt7q8f.fsf@gitster.g>
 <YH4jPMPrLA+a85RH@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YH4jPMPrLA+a85RH@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 08:41:32PM -0400, Taylor Blau wrote:
> On Mon, Apr 19, 2021 at 05:29:36PM -0700, Junio C Hamano wrote:
> > I suspect that these other ones come from "pull requests" random
> > people threw at us that never hit our tree, with changes to the
> > .github/workflows/ directory in these PR.
> >
> > I find them quite distracting.
>
> That's what I'd expect, too, but I'm not sure. I asked the people who
> would know, and I'll reply back here once I have an answer.

The answer is that every workflow that was run in either (a) any branch
of a repository, or (b) in any pull requests against that repository
will show up in that list.

As Dscho noted lower in the thread, all of the ones on git/git are spam.
From my conversation with the Actions folk, it sounds like we don't hide
these currently, but they are planning on doing it soon. So they will
disappear eventually, but not before it's implemented.

Hope that helps.

Thanks,
Taylor
