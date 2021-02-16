Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5B8C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F6364E7A
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBPTYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:24:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:34832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhBPTYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:24:11 -0500
Received: (qmail 14550 invoked by uid 109); 16 Feb 2021 19:23:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 19:23:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28537 invoked by uid 111); 16 Feb 2021 19:23:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 14:23:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 14:23:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-send-email: smtpserver in $HOME
Message-ID: <YCwbsKIKNHTMJJHQ@coredump.intra.peff.net>
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
 <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
 <YCvotU6KVruFuf9/@coredump.intra.peff.net>
 <xmqq35xvrgbg.fsf@gitster.c.googlers.com>
 <YCwXf1CA0Xyw/B88@coredump.intra.peff.net>
 <xmqqy2fnq0vx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2fnq0vx.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 11:16:18AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Sure, but you cannot say "does it refer to a local file" for a
> > non-absolute path.
> 
> Hmph, why not?  I would expect that this would work as a valid way
> 
> 	$ git send-email --smtp-server=./my-phoney-smtp
> 
> to test a server substitute (perhaps for testing).  The only reason
> why it does not is because file_name_is_absolute() check would not
> like it.

Ah, sure. But you cannot say "my-phoney-smtp" and find it in the PATH,
because it is syntactically indistinguishable from a host with the same
name.

-Peff
