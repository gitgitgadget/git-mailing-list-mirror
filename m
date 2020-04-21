Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C0C2BA19
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E192072D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 08:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=portswigger-net.20150623.gappssmtp.com header.i=@portswigger-net.20150623.gappssmtp.com header.b="FbUQ5fkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgDUIqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUIqQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 04:46:16 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA2C061A0F
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 01:46:15 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id s5so4773288uad.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=portswigger-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05GGcsCqaS4k3bCyl9WgtTELU5vYfL0zLjct9mYGT94=;
        b=FbUQ5fkgLX420i1aOYiMcByGKIEQaZP1BHSE4g3g99wakn3iJh5rGPu5fRBQth0+7h
         ubZ4f7f/edxfoKgaL8NlndPK9IhSDQw1uv7eSmMEyDCFXOBXiLltVaUFbjwab+ByZW2z
         YhIcmsudYmgTJ7GrUDJfz4fHjUs+o62BSZxJvpTPuS8CtYAxzqc2AaPBygY13cLjI0X4
         d5p/RVTPznxJbTZzvYdTeNBoQwaWC9+dlkzChEnasHtP/skU7RcIhmrRfuN7oXF4ir0g
         Atv7jCqxq6Y8O8NzFwSS9z95sMQBLHjlkF/xCw4U0a1JAvaYsVYH3UrTFHQPKotd7Tq/
         5L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05GGcsCqaS4k3bCyl9WgtTELU5vYfL0zLjct9mYGT94=;
        b=nfXonEfn3SljPJN6iTKDT7Qk4t7mnoMOcHmjxIPsDGzRF40rgo1gGJpJMYD9A0EZbq
         3j7qZibPu30UI+PC5B08LoIUeccSy1gHRUI15iwOgzywR9tIEdvx07XX39ScVw8fhKeD
         QLFsyR9ofCmdRh/AoBnzC8PG9hbw2XAbSYtHd+I0SPhGPN3BuXriGOIaRoOhy8u/WYwC
         AUUKL/9fnEyPpWvd7EanW5WlbA/CR3TBcdPNt1MHbMvVQhEHHA/tXJ+upqv8Pyq1Ntcy
         s4Ki/388PO6DP2Kfk2pz/Mz8qh9qipDi+bUzCdmKJ3Lx27okLY9OXEtXdPuDxyD7tvgB
         SgdQ==
X-Gm-Message-State: AGi0PuZM5BCU+bhX2VBy3SByGM5zHB3/GhR5kzeu27vLbGEGNI1qvv6Y
        WfQdJlzk+fDjjm2rEC3wWijtktGL5NCVyW3TYJwV5jkHDcE=
X-Google-Smtp-Source: APiQypIwCduNeBCoWuRBlQ6Y4DZamXPlDMfTiKnPK9bU/wOmMuze3EYLBmv/c9X3/+6TtAPMmbkjyAem1XZDbd5ijks=
X-Received: by 2002:ab0:1d97:: with SMTP id l23mr9124546uak.107.1587458774515;
 Tue, 21 Apr 2020 01:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJQu+bp9SrzaMBuMv1UC8y8rJGn15MAsVogSCm_DNDKRMji1+Q@mail.gmail.com>
 <xmqqwo6g7p55.fsf@gitster.c.googlers.com> <20200415154711.GD2464307@coredump.intra.peff.net>
In-Reply-To: <20200415154711.GD2464307@coredump.intra.peff.net>
From:   Adam Bannister <adam.bannister@portswigger.net>
Date:   Tue, 21 Apr 2020 09:46:03 +0100
Message-ID: <CAJQu+boAfXKG_Kugmh+k2O_AP2LmGbZ+R5XS0rw9==7OtULEZg@mail.gmail.com>
Subject: Re: Media query - Git flaw
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forgot to say thanks for all your help and share the link!
https://portswigger.net/daily-swig/git-security-newline-injection-bug-tricked-version-control-system-into-leaking-usernames-and-password

Much appreciated...

On Wed, 15 Apr 2020 at 16:47, Jeff King <peff@peff.net> wrote:
>
> On Wed, Apr 15, 2020 at 08:19:18AM -0700, Junio C Hamano wrote:
>
> > > What is your advice to Git users?
> >
> > Release is announced and users are urged to upgrade, like you wrote
> > on your article at The Daily Swig.
>
> There's a little more detail and some workarounds discussed in the
> advisory at:
>
>  https://github.com/git/git/security/advisories/GHSA-qm7j-c969-7j4q
>
> -Peff



-- 

Adam Bannister
The Daily Swig
https://portswigger.net/daily-swig
