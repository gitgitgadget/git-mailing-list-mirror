Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813BDC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 23:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEAB20734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 23:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="hU87/4Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgHJXJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHJXJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 19:09:39 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF07DC06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 16:09:38 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597100977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=TaSNC4kAMbEGjhxtjZNrOD4lUwgWcMthf7TkKPMeYqk=;
        b=hU87/4LvPtGYhE44bohAah63r2oYJ9iQj4CEyw/GZVhWwYrXiARkO6eQW1UPBvvzoR1Mdm
        +sdR4wDj5jI/WIIs4vUj5WJ4hXFbA815Nj1MVb76hAd/n6Nwa6HQBz2K0HCsI7dm+5ulIW
        D5gTbPRBOpvvBvpNtbPi2FgkmFiwqJY=
Content-Type: text/plain; charset=UTF-8
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Eric Sunshine" <sunshine@sunshineco.com>
Cc:     "Git List" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
Date:   Mon, 10 Aug 2020 19:02:33 -0400
Message-Id: <C4TOW9DJ7JW0.1QXQ173P2ERVN@ziyou.local>
In-Reply-To: <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Aug 10, 2020 at 12:23 PM EDT, Eric Sunshine wrote:
> The hard-coded SHA-1 value in the "index" line is going to cause the
> test to fail when the test suite is configured to run with SHA-256.
> You could fix it by preparing two hash values -- one for SHA-1 and one
> for SHA-256 -- and then looking up the value with test_oid() for use
> with grep. On the other hand, if you're not interested in the exact
> value, but care only that _some_ hash value is present, then you could
> just grep for a hex-string.

Loosely, all this test cares about is that it's not "index 0000000"; or
perhaps, taking another tack, that it doesn't have a "new file" line.

More rigidly, it's nice to confirm that it's a diff from the empty blob
and not from some other random blob.
