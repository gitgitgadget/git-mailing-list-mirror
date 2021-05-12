Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB9C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D024C61186
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhELBxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 21:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELBxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 21:53:33 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7535C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:52:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j75so20852405oih.10
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2yCH7WVO+UlXYNKLqvPquKPVgY1PCkeOkxOtqKF5XhE=;
        b=Yjt7Z71RnYsK4HCdhYTklwn8M/dEVfIiVFiYzEz/Y0OcZw572aVEOfBvfRSGFQFafX
         +DbPg7P57uFZq/9XCWe65BcbFJLpBFmIV7TcdOze9YK8w3+70v6DXGTUtOAEFvgky0+q
         INHtWTzvaKhQUYGonzdPzMrwPY4+FloW1o2Vt+sQ0r4T22+XIAnLgOQiCdzg9VP1z2Fl
         f+M7/lC068YvnO0VwAS0p0mxPyNZaYCSELJhHPyK7ZTWJgLPSDx1CCrXb2nf5M7L7A/P
         teA/cQxiY6eHgKM4PsXOk0KBQecghEpdOozPMWfD1dGogULqNgf6vuCSSi8OeUEAS64B
         Pf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2yCH7WVO+UlXYNKLqvPquKPVgY1PCkeOkxOtqKF5XhE=;
        b=H7aKZU97uGuVdpMB3LT0Bs07LexStUWjeIm+OQOXar/Vj6IR621zYVL9/d1f1L7kQi
         2M/9Up8EZqYAk6Gyj8/j0c5TpreuwYoueyAtX4g4hCllwqOO5eOFZI7pCVVZBhaZfWmT
         yxUs9fa9/VMXk40Axtd0lgtkna8rOksW3Ibuau6ba+SsJl/ORY3jqA60bnYpYaMgKlEd
         3TTYYHXVUJr08jxVWFlR7lSaQEqQ9u551ciAnK28eDfbXwbU5nefNqH8n6lmicMCdMlZ
         LIWbPlY5RfHLWgGdPfW3jzcuJr4vniZAhxd4ZeygOHcKL68M9HUM6Mq89TzzmmP6CXtJ
         +tow==
X-Gm-Message-State: AOAM531rc1a2yR1tKgL/g86IWIdy0B2SXHd3HJw7J8rBxS/mKWIvdLTs
        MZXKUU1Mw3ysEGldvvlP+TM=
X-Google-Smtp-Source: ABdhPJxmRZ+PozhN09Vfox5VvLc0JmIelJvTVmwelidz++yUCrckHHNUoUjxjWlEYlLXmOSYVE2wyg==
X-Received: by 2002:aca:d6d5:: with SMTP id n204mr18483566oig.169.1620784344117;
        Tue, 11 May 2021 18:52:24 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id p189sm3553183oif.31.2021.05.11.18.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 18:52:23 -0700 (PDT)
Date:   Tue, 11 May 2021 20:52:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org
Message-ID: <609b34d66a0bc_678ff2083@natae.notmuch>
In-Reply-To: <YJsuYAc+NniTWBc8@coredump.intra.peff.net>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
 <609b0017a323b_6064920888@natae.notmuch>
 <YJsDAnHcnro6Gfk4@gpanders.com>
 <YJslulEQFvPkyo/R@coredump.intra.peff.net>
 <609b2aa26aa5b_678ff20893@natae.notmuch>
 <YJsuYAc+NniTWBc8@coredump.intra.peff.net>
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 11, 2021 at 08:08:50PM -0500, Felipe Contreras wrote:
> 
> > > Yeah, that was mentioned in the thread I linked earlier. I think it
> > > would be a fine solution, too. It would probably make sense for it to
> > > use the shell, as suggested elsewhere, and to call it "smtp-command" for
> > > consistency with other parts of Git (I'm thinking particularly of
> > > GIT_SSH versus GIT_SSH_COMMAND, where the latter was introduced to fix
> > > the defect that the former could not provide any arguments).
> > 
> > But it would be "smtpserver-command", and I don't think that the best
> > naming, because it doesn't necessarily have anything to do with SMTP, or
> > a server.
> > 
> > I think simply sendemail.command is perfectly fine.
> 
> Aren't there many other "commands" run by send-email, like --to-cmd and
> --cc-cmd? It probably should indicate somehow that it is the command for
> sending mail. I agree it does not have to say "SMTP". If it is meant to
> be compatible with sendmail, then maybe "sendemail.sendmailCommand" and
> "--sendmail-cmd" would work.

Yes, although I find sendemail.sendmailCommand awfully redundant.
I would prefer sendemail.mainCommand, but to me sendemail.command
implies it's the main command as opposed to all ther other commands.

Just like there's many presidents in USA (of companies, organizations,
and student unions), but when you say "the president of USA" it's
understood which president you are talking about.

Cheers.

-- 
Felipe Contreras
