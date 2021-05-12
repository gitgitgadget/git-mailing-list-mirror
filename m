Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD2C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDCF60FDB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhELB2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 21:28:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:51712 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhELB2T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 21:28:19 -0400
Received: (qmail 25381 invoked by uid 109); 12 May 2021 01:24:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 01:24:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30992 invoked by uid 111); 12 May 2021 01:24:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 21:24:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 21:24:48 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJsuYAc+NniTWBc8@coredump.intra.peff.net>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
 <609b0017a323b_6064920888@natae.notmuch>
 <YJsDAnHcnro6Gfk4@gpanders.com>
 <YJslulEQFvPkyo/R@coredump.intra.peff.net>
 <609b2aa26aa5b_678ff20893@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <609b2aa26aa5b_678ff20893@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 08:08:50PM -0500, Felipe Contreras wrote:

> > Yeah, that was mentioned in the thread I linked earlier. I think it
> > would be a fine solution, too. It would probably make sense for it to
> > use the shell, as suggested elsewhere, and to call it "smtp-command" for
> > consistency with other parts of Git (I'm thinking particularly of
> > GIT_SSH versus GIT_SSH_COMMAND, where the latter was introduced to fix
> > the defect that the former could not provide any arguments).
> 
> But it would be "smtpserver-command", and I don't think that the best
> naming, because it doesn't necessarily have anything to do with SMTP, or
> a server.
> 
> I think simply sendemail.command is perfectly fine.

Aren't there many other "commands" run by send-email, like --to-cmd and
--cc-cmd? It probably should indicate somehow that it is the command for
sending mail. I agree it does not have to say "SMTP". If it is meant to
be compatible with sendmail, then maybe "sendemail.sendmailCommand" and
"--sendmail-cmd" would work.

-Peff
