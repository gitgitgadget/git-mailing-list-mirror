Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D89BC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 07:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B3720759
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 07:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Vitg3uLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgF3HAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgF3HAL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 03:00:11 -0400
Received: from forward100o.mail.yandex.net (forward100o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D7C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 00:00:11 -0700 (PDT)
Received: from mxback21o.mail.yandex.net (mxback21o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::72])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 2F61A4AC18EF;
        Tue, 30 Jun 2020 10:00:01 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net (sas8-b61c542d7279.qloud-c.yandex.net [2a02:6b8:c1b:2912:0:640:b61c:542d])
        by mxback21o.mail.yandex.net (mxback/Yandex) with ESMTP id p7DFXlD1ru-01wCdbJj;
        Tue, 30 Jun 2020 10:00:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1593500401;
        bh=p3/AEay65/vjfID+PaQJC6tSClNybFm8d2ThJVnMOKk=;
        h=In-Reply-To:Cc:To:From:Subject:References:Date:Message-ID;
        b=Vitg3uLiTMOpunnvnNK+jLhIUijLwXNnfIoeHqHUkYfCgGscLruVbpYNkrI8/3HU3
         +J25GiZ9YZ3+gn5WO0KJsu2wmNSlgolwcLnyv+dILs8fE4XbqSUhMGZw9G0nKsgUJf
         V2G3O/HzhKmoBUYchPhRPjnE59IFeLpnZIQBCI/w=
Authentication-Results: mxback21o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id sc35pgmg8A-00NSoApX;
        Tue, 30 Jun 2020 10:00:00 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <3e6b9431b7caa9db0ebbaea292897f8bcdcf8148.camel@yandex.ru>
Subject: Re: Listing changed identifiers with git log/diff
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Date:   Tue, 30 Jun 2020 10:00:00 +0300
In-Reply-To: <3CA60EC2-13E9-4A1A-9A89-066CFF9CA36E@gmail.com>
References: <e37cdda3b73094f4f1a929dd181a64936a649c48.camel@yandex.ru>
         <3CA60EC2-13E9-4A1A-9A89-066CFF9CA36E@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-06-29 at 15:24 -0400, Philippe Blain wrote:
> Hi Konstantin,
> 
> > Le 29 juin 2020 à 06:18, Konstantin Kharlamov <hi-angel@yandex.ru> a écrit :
> > 
> > Git is able to recognise functions/variables changed, and even allows to see
> > the history of such identifier with `-L` option.
> > 
> > But I couldn't find: how does one get a list of such identifiers in `git
> > log` or `git diff`? This would be particularly useful for projects with odd
> > requirements to have a list of identifiers changed in the commit message.
> > 
> > FTR, the diff text after the "@@…@@" does not cut it because for example if
> > the diff is at the beginning of the function, then it would have a name of
> > the previous function, i.e. not the one modified. As a hack, I tried passing
> > an option `-U0`, but that didn't help, for one-line identifiers it still
> > shows the name of the prev. identifier.
> 
> As far as I'm aware this is a limitation of the diff machinery.
> I agree with you that it would be really nice if it could work as you
> describe...

I agree, the hack I tried might be a limitation of diff. But since git per se
knows identifiers changed (as it can track changes to them by passing `-L`
option, like `git log -L :function_foo:src/foo.c`), shouldn't there be some
other way to achieve that?

