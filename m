Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D02EC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795556124B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347401AbhIXV02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:26:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:54944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244748AbhIXV01 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 17:26:27 -0400
Received: (qmail 19773 invoked by uid 109); 24 Sep 2021 21:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 21:24:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13670 invoked by uid 111); 24 Sep 2021 21:24:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 17:24:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 17:24:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting
 errors
Message-ID: <YU5CJC9XJvQITfr8@coredump.intra.peff.net>
References: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 12:08:20PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change the error shown when a http.pinnedPubKey doesn't match to point
> the http.pinnedPubKey variable added in aeff8a61216 (http: implement
> public key pinning, 2016-02-15), e.g.:
> 
>     git -c http.pinnedPubKey=sha256/someNonMatchingKey ls-remote https://github.com/git/git.git
>     fatal: unable to access 'https://github.com/git/git.git/' with http.pinnedPubkey configuration: SSL: public key does not match pinned public key!

TBH, I think the message as-is is sufficiently descriptive. That said,
it's not too much extra code to handle it specially, so I don't feel all
that strongly.

Maybe people care more about the translation aspect, but it feels like
that's the tip of the iceberg in terms of curl errors.

The patch itself looks correct to me.

-Peff
