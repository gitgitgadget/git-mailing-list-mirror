Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D3C43381
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825442226A
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbhAYXrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:47:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:38326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732556AbhAYVRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:17:40 -0500
Received: (qmail 9716 invoked by uid 109); 25 Jan 2021 21:16:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Jan 2021 21:16:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21898 invoked by uid 111); 25 Jan 2021 21:16:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Jan 2021 16:16:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Jan 2021 16:16:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v2] upload-pack.c: fix filter spec quoting bug
Message-ID: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
References: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
 <20210125170921.14291-1-jacob@gitlab.com>
 <xmqqlfcgyf0o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfcgyf0o.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 11:48:07AM -0800, Junio C Hamano wrote:

> I suspect that 0b6069fe (fetch-pack: test support excluding large
> blobs, 2017-12-08) sort-of fixed half of the problem (i.e. the half
> when there is no hook used) while leaving the other half still
> broken as before.
> 
> But because .use_shell does not affect if we should or should not
> quote, we can unconditionally drop the use of sq_quote_buf().

Yep. That was the same conclusion I came to in my earlier reply:

  https://lore.kernel.org/git/YAs2RMT1rEH%2F2LSp@coredump.intra.peff.net/

> > This commit removes the conditional quoting and adds a test for
> > partial clone in t5544.
> > ---
> 
> Thanks.  Missing sign-off.

Aside from the sign-off issue, this version looks good to me.

-Peff
