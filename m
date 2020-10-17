Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40738C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065C720EDD
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="Xgp3mZcM";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="Xgp3mZcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439824AbgJQXQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 19:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbgJQXQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 19:16:24 -0400
Received: from lithium.sammserver.com (lithium.sammserver.com [IPv6:2a01:4f8:c2c:b7df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE0FC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 16:16:24 -0700 (PDT)
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 984E4312B5AC;
        Sun, 18 Oct 2020 01:16:22 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 631F41120A14; Sun, 18 Oct 2020 01:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976582; bh=8aEpWgqXyKAh+Uu3hm0rC8JqBHSl8FTvf3gR27mQJH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xgp3mZcMkt9vZ9Qi5lGfWMfheFI68Xt1xjUSzDmFvvz2siPyAsm+b4KqM/6ox8EcY
         67SPQrhHadQd5CzKKqnaBnIfzKVPvsmouFqLu7/MJjy9xOY0bkCw9mLjZA2die5cmq
         nhgagzRpAqyVzLPUaiX2op6PaJhijQPpT06aecME=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 41AB81120A11;
        Sun, 18 Oct 2020 01:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602976582; bh=8aEpWgqXyKAh+Uu3hm0rC8JqBHSl8FTvf3gR27mQJH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xgp3mZcMkt9vZ9Qi5lGfWMfheFI68Xt1xjUSzDmFvvz2siPyAsm+b4KqM/6ox8EcY
         67SPQrhHadQd5CzKKqnaBnIfzKVPvsmouFqLu7/MJjy9xOY0bkCw9mLjZA2die5cmq
         nhgagzRpAqyVzLPUaiX2op6PaJhijQPpT06aecME=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 3CB261420A90; Sun, 18 Oct 2020 01:16:22 +0200 (CEST)
Date:   Sun, 18 Oct 2020 01:16:22 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/3] sequencer: pass explicit --no-gpg-sign to merge
Message-ID: <20201017231622.afi73e62dp4yjvk4@fastboi.localdomain>
References: <20201013213021.3671432-1-samuel@cavoj.net>
 <20201013213021.3671432-3-samuel@cavoj.net>
 <xmqqd01jh17n.fsf@gitster.c.googlers.com>
 <20201017220224.o6fs5ukwqq7sqgrb@fastboi.localdomain>
 <xmqq5z788osw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5z788osw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 17.10.2020 15:34, Junio C Hamano wrote:
> Samuel Čavoj <samuel@cavoj.net> writes:
> 
> >> Now that we know that the root cause of the bug you fixed was
> >> because rebase rebase with the default merge strategy for two-head
> >> merges use separate codepaths from and all other rebases, I wonder
> >> if it is prudent to also test the same cases this series adds
> >> without giving "-s resolve".  That would exercise the other codepath
> >
> > I will leave that for someone else to tackle eventually.
> 
> We know that other codepath has been working even before this fix,
> but tests are not about showing off what we fixed, but are about
> making sure similar breakage won't be introduced by mistake in the
> future.  Leaving it "for someone", when we know what the problem is
> and how to solve it, is asking for the "evantually" not materialize
> forever.

I agree with that, don't take me wrong, but in general, people have
other things to do, than implement test cases only marginally related to
the inital patch they submitted.

Anyway, as it didn't take long in this case, I added them as patch 3/3
in v4.

> 
> > As the number of very similar test is slowly growing, do you think it is
> > worth copying (or making more generic) the test_rebase_gpg_sign for this
> > situation as well? We currently have 4 almost identical tests (counting
> > the new one you suggested for v4). Just a thought, as it is simpler to
> > just add it at this point. Thanks for the feedback.
> 
> That is a tough question.  Often, a generic test helper makes it too
> easy to do a full matrix of tests and encourages us to overdo it,
> which we probably would want to avoid.  I think what I've suggested
> so far is a bare minimum combination for code coverage.
> 
Alright, I will leave them as is.

Regards,
Samuel
