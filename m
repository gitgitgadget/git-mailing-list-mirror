Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D93C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F2F60F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhHPSgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:36:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:48766 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhHPSgt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:36:49 -0400
Received: (qmail 22299 invoked by uid 109); 16 Aug 2021 18:36:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 18:36:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17219 invoked by uid 111); 16 Aug 2021 18:36:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 14:36:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 14:36:16 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRqwIAL/JgJp+RyI@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
 <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
 <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 02:31:34PM -0400, Randall S. Becker wrote:

> >33 - reject long lines #
> >#               z8=zzzzzzzz &&
> >#               z64=$z8$z8$z8$z8$z8$z8$z8$z8 &&
> >#               z512=$z64$z64$z64$z64$z64$z64$z64$z64 &&
> >#               clean_fake_sendmail &&
> >#               cp $patches longline.patch &&
> >#               cat >>longline.patch <<-EOF &&
> >#               $z512$z512
> >#               not a long line
> >#               $z512$z512
> >#               EOF
> >#               test_must_fail git send-email \
> >#                       --from="Example <nobody@example.com>" \
> >#                       --to=nobody@example.com \
> >#                       --smtp-server="$(pwd)/fake.sendmail" \
> >#                       --transfer-encoding=8bit \
> >#                       $patches longline.patch \
> >#                       2>actual &&
> >#               cat >expect <<-\EOF &&
> >#               fatal: longline.patch:35 is longer than 998 characters
> >#               warning: no patches were sent
> >#               EOF
> >#               test_cmp expect actual
> >#
> >/
> 
> I should point out that all 6 failures in t9001 have the same characteristic - signal 34.

Oh. Then the notion from my other mail of "if it's die(), then other
tests would presumably see similar failures" might be true. ;)

-Peff
