Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1DC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219A560230
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhJYS7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:59:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:46032 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232007AbhJYS7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 14:59:35 -0400
Received: (qmail 6530 invoked by uid 109); 25 Oct 2021 18:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Oct 2021 18:57:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22567 invoked by uid 111); 25 Oct 2021 18:57:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Oct 2021 14:57:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Oct 2021 14:57:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Makefile: remove $(GIT_VERSION) from
 $(SCRIPT_DEFINES)
Message-ID: <YXb9nYRWBxa7jDKB@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
 <patch-2.6-7cc3a1d7205-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.6-7cc3a1d7205-20211021T195538Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 09:57:56PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove the $(GIT_VERSION) from $(SCRIPT_DEFINES). Now every time HEAD
> changes in a development copy we don't need to re-build the scripts
> and script libraries.
> 
> This has not been needed since 2b9391bc675 (Makefile: do not replace
> @@GIT_VERSION@@ in shell scripts, 2012-06-20). On my setup this
> changes the re-making of 44 targets in a development copy where moved
> HEAD to 27.
> 
> The $(GIT_VERSION) was seemingly left here by mistake or omission. We
> didn't need it since 2b9391bc675, but in the later
> e4dd89ab984 (Makefile: update scripts when build-time parameters
> change, 2012-06-20) it was added to SCRIPT_DEFINES.
> 
> The two were part of the same series of patches, and given the summary
> in [1] and [2] it looks like this was probably a case of some earlier
> version of a later patch being combined with an updated earlier patch.
>
Yeah, that seems likely. No such version hit the list, but I probably
wrote the SCRIPT_DEFINES one first, and then realized GIT_VERSION could
be dropped, but didn't update the other.

At any rate, your patch looks like the correct thing to do.

-Peff
