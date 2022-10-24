Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC470C67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJYA7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiJYA7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:59:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7C278141
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:50:51 -0700 (PDT)
Received: (qmail 4555 invoked by uid 109); 24 Oct 2022 23:50:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Oct 2022 23:50:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12465 invoked by uid 111); 24 Oct 2022 23:50:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Oct 2022 19:50:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Oct 2022 19:50:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: use strvec_pushf() for --super-prefix
Message-ID: <Y1ck2p6ykHRo5cCg@coredump.intra.peff.net>
References: <7a4e2fc6-3e01-5683-2be5-13b7e67c7fe5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a4e2fc6-3e01-5683-2be5-13b7e67c7fe5@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2022 at 08:47:35AM +0200, René Scharfe wrote:

> absorb_git_dir_into_superproject() uses a strbuf and strvec_pushl() to
> build and add the --super-prefix option and its argument.  Use a single
> strvec_pushf() call to add the stuck form instead, which reduces the
> code size and avoids a strbuf allocation and release.  The same is
> already done in submodule_reset_index() and submodule_move_head().

Nice. Unlike some of the earlier discussion around child_process args,
this one seems like a very clear win.

-Peff
