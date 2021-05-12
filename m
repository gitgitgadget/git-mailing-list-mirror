Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E3C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D275D61378
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhELAtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:49:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:51650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhELAtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:49:02 -0400
Received: (qmail 25257 invoked by uid 109); 12 May 2021 00:47:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 00:47:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30756 invoked by uid 111); 12 May 2021 00:47:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 20:47:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 20:47:54 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJslulEQFvPkyo/R@coredump.intra.peff.net>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
 <609b0017a323b_6064920888@natae.notmuch>
 <YJsDAnHcnro6Gfk4@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJsDAnHcnro6Gfk4@gpanders.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 04:19:46PM -0600, Gregory Anders wrote:

> On Tue, 11 May 2021 17:07 -0500, Felipe Contreras wrote:
> > It would be much better to have sendemail.program, and then we wouldn't
> > need to deal with these workarounds.
> 
> Frankly I agree. Should I modify my patch to add this new option instead of
> modifying the behavior of smtpServer? Obviously the smtpServer option would
> need to preserve its current behavior for backward compatibility.

Yeah, that was mentioned in the thread I linked earlier. I think it
would be a fine solution, too. It would probably make sense for it to
use the shell, as suggested elsewhere, and to call it "smtp-command" for
consistency with other parts of Git (I'm thinking particularly of
GIT_SSH versus GIT_SSH_COMMAND, where the latter was introduced to fix
the defect that the former could not provide any arguments).

-Peff
