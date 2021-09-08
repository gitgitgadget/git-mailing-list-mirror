Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC6C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8902761108
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhIHT21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:28:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:42346 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhIHT20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:28:26 -0400
Received: (qmail 25994 invoked by uid 109); 8 Sep 2021 19:27:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 19:27:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32565 invoked by uid 111); 8 Sep 2021 19:27:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 15:27:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 15:27:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 3/5] http: correct version check for CURL_HTTP_VERSION_2_0
Message-ID: <YTkOlcfx8qwSBZ4A@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-3.5-d8192164937-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.5-d8192164937-20210908T152807Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 05:31:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In d73019feb44 (http: add support selecting http version, 2018-11-08)
> a dependency was added on CURL_HTTP_VERSION_2_0, but this feature was
> introduced in curl version 7.43.0, not 7.47.0, as the incorrect
> version check led us to believe.
> 
> As looking through the history of that commit on the mailing list will
> reveal[1], the reason for this is that an earlier version of it
> depended on CURL_HTTP_VERSION_2TLS, which was introduced in libcurl
> 7.47.0.
> 
> But the version that made it in in d73019feb44 had dropped the
> dependency on CURL_HTTP_VERSION_2TLS, but the corresponding version
> check was not corrected.

According to the curl manpage, if we use CURL_HTTP_VERSION_2_0 instead,
it goes all the way to 7.33.0. I don't have opinion on whether that's
worth covering or not.

-Peff
