Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FEFC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5467964F21
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhCQOuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhCQOuT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 10:50:19 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9DC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 07:50:19 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615992617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuwmXhRWVTjYG8ko7tsZh35vCYBLowxql504NMM1SMM=;
        b=WJEwGhfRXLa8WaISXAUS/RUQx5vOc73JjT6bieNImaIwf1N+Zj881GhgmiPaCh3m1CAyGA
        ycdV5F/3Qc9VJjL9dUL5JYsLXjsiCF2IO8Zjx/NIVG3wzmKpvUwTc3CoJGlmFUHgW6BOYV
        sy72Deu788zo9H9I2QzQWtvu+dSVkxax9XEkZ4JDnSY7KZ8TzlqYPvCKchjyMLYCdGkFUt
        2YLmdma0RMyAMh0cwX593OdjSNrfP8LX2OyHyfQUAdbkK6564xmu6SKxbZoYLJSUmnA6GV
        5vm8Qdrw6eRw/yFZBaPgRRYSVq6C7OOf1glj8VlAm5tqc4FdCAEOqskCoy4FZQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 17 Mar 2021 10:50:15 -0400
Message-Id: <C9ZPKMPKCQ9Y.X7U9IVV4A7NU@taiga>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eli Schwartz" <eschwartz@archlinux.org>,
        "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Jeff King" <peff@peff.net>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
 <YFEjCU1jgrsPIhvk@coredump.intra.peff.net>
In-Reply-To: <YFEjCU1jgrsPIhvk@coredump.intra.peff.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Mar 16, 2021 at 5:28 PM EDT, Jeff King wrote:
> Git remotes are most definitely not just URIs. Some valid remotes are:
> ".", "foo", "/tmp/foo", "c:\foo", "example.com:foo". The parser inside
> Git has rules to distinguish these from actual rfc3986-compliant URIs.
>
> Now I don't know much about the parsing code in, say, git-lfs, or how
> much of pain it would be to add a new scheme for something that _does_
> conform to rfc3986. But it's not necessarily as easy as "you should be
> using a compliant URI parser".

Sorry, I meant to say that git remotes are a superset of URIs, so a
conformant URI parser already has to be involved - I didn't mean that
all git remotes are URIs.
