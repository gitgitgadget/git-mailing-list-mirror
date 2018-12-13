Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A6120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 06:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeLMGBB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 13 Dec 2018 01:01:01 -0500
Received: from elnino.lfos.de ([46.165.227.75]:41901 "EHLO elnino.lfos.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbeLMGBB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 01:01:01 -0500
Received: by elnino.lfos.de (OpenSMTPD) with ESMTPSA id 015c20ac (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256:NO);
        Thu, 13 Dec 2018 07:00:59 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <xmqq1s6mi30u.fsf@gitster-ct.c.googlers.com>
References: <154454625546.29948.6229097078125430492@typhoon> <xmqq1s6mi30u.fsf@gitster-ct.c.googlers.com>
From:   Lukas Fleischer <lfleischer@lfos.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] A global mailmap service
Message-ID: <154468094076.20389.13548760312672321478@typhoon>
User-Agent: alot/0.7
Date:   Thu, 13 Dec 2018 07:02:20 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 Dec 2018 at 03:17:21, Junio C Hamano wrote:
> Lukas Fleischer <lfleischer@lfos.de> writes:
> 
> > The basic idea of the service I imagine is simple:
> >
> > 1. You register a primary email address and specify a password. You
> >    receive a verification email to confirm that the address is yours.
> 
> I would do so with my current, reachable address, I'd presume.

Correct.

> 
> > 2. At any time, you can add additional email addresses and link them to
> >    your primary email address, using your previously specified password.
> >    You can also update your primary email address. Any new addresses
> >    obtain verification emails such that you cannot steal somebody else's
> >    identity.
> 
> With this, I won't be able to add my ancient identities that appear
> in our history.  I would imagine that one of the common reasons
> people use different identities in a project is that people changed
> e-mail providers or jobs.
> 

Well, this is only a temporary issue. It holds for your current ancient
identities but won't hold for your ancient identities in the far future
because ancient times have always been present at some point in time. If
we agreed that most people register their current email addresses from
now on, we'd limit the issue to email addresses which were abandoned
before 2018-12-13. As projects grow, this will become a small fraction.
Projects started in the far future won't be affected at all.

As a short-term solution, we could keep the current mappings as
complementary mappings in the local .mailmap files.

That being said, I also had the idea of importing old mappings to the
service. There are two approaches that crossed my mind:

1. Link email addresses according to the .mailmap files of popular
   trusted projects, such as Git or the Linux kernel. One of the issues
   with this approach is that "topic email addresses", i.e. project
   specific preferences, may not be mapped correctly. Maybe it doesn't
   matter too much.

2. Add the option to register a "dead" email address to the service.
   Instead of sending a verification email, the service sends a warning
   stating that the email address will be linked if no action is taken.
   It contains a link where the user can cancel the request and block
   the email address from further requests. Another such warning is sent
   after a couple of days. After a grace period with no action taken,
   the address is linked. Not optimal but with additional measures such
   as rate limits to prevent from abuse, this might be good enough.

Best regards,
Lukas
