Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08856C2BB84
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA86E20732
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgIPSlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:41:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58682 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgIPSlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:41:10 -0400
Received: (qmail 25716 invoked by uid 109); 16 Sep 2020 18:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 18:41:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31145 invoked by uid 111); 16 Sep 2020 18:41:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 14:41:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 14:41:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 07/15] remote-mediawiki tests: guard test_cmp with
 test_path_is_file
Message-ID: <20200916184104.GB33925@coredump.intra.peff.net>
References: <20200916102918.29805-1-avarab@gmail.com>
 <20200916102918.29805-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916102918.29805-8-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 12:29:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change a test that used a plain test_cmp to first check the file(s)
> using test_path_is_file. If some of these file(s) don't exist (as
> happened to me during debugging), test_cmp will emit a way less useful
> message about the failure.

This seems like a problem that would exist in basically every test that
uses test_cmp (well, many of them do ">actual", so it's unlikely that
the content would be missing, but it would be true of any test that
expects a command to generate a file).

Rather than annotate each site, could we teach test_cmp to show a nicer
message?

-Peff
