Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD28C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F276127C
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242104AbhI1SC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:02:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:56824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhI1SC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 14:02:27 -0400
Received: (qmail 10578 invoked by uid 109); 28 Sep 2021 18:00:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 18:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1820 invoked by uid 111); 28 Sep 2021 18:00:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 14:00:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 14:00:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string-list.[ch]: remove string_list_init()
 compatibility function
Message-ID: <YVNYT671T5vC2qrY@coredump.intra.peff.net>
References: <patch-1.1-03c805dd90f-20210928T124939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-03c805dd90f-20210928T124939Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 02:49:45PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove this function left over to accommodate in-flight changes, see
> 770fedaf9fb (string-list.[ch]: add a string_list_init_{nodup,dup}(),
> 2021-07-01) for the recent change to add
> "string_list_init_{nodup,dup}()" initializers.
> 
> There was only one user of the API left in remote-curl.c. I don't know
> why I didn't include this change to remote-curl.c in
> bc40dfb10a0 (string-list.h users: change to use *_{nodup,dup}(),
> 2021-07-01), perhaps I just missed it.

Yeah, both calls definitely existed then. I agree it was probably just
missed (at least there is no obvious reason not to have included it
then).

> In any case, let's change that one user to use the new API, as of
> writing this there are no in-flight changes that use, so this seems
> like a good time to drop this before we get any new users of this
> compatibility API.

Yeah, this seems like a good idea. The patch itself is as advertised.

-Peff
