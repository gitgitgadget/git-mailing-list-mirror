Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99774C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 03:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FF2205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 03:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE7/0HkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgEMD5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 23:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbgEMD5N (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 23:57:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3FAC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 20:57:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m18so12338995otq.9
        for <git@vger.kernel.org>; Tue, 12 May 2020 20:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZH+6RNTzvbYCNc+MBpjqH1JdXyAxC0d+f8OuCmtLkXs=;
        b=GE7/0HkZRCoaxyyvsNb5WjM/WXytOgaX5qi499z1g1+UYhOTBXfQlR2KmHnchuwmyA
         oj5X8oDZ1xcBsqtx24ioZhCqr0eXv8M6tnKz9YlrubcuVGcOu0HFuNOGGkKtZS+bgjyU
         g1uZQEKPOAmPFV8B3UghS/OU2pLhq/DUyJn2Nr4eL/E/jKPtE2ZpRMp2FI7WY3f+Alxk
         NkGkaGvWb+cU2fteJAvTp49/UFRMS0laEJDsupMqlFk3HseCW3Pj+pLq/A4ub1YnM+Ac
         wM90aB6x5WaDhyDcGk87Tr3IwV1pobYVNIC/N4O5eY9i6MbtZVZnVgQ8lCPxtDTw0RLy
         gQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZH+6RNTzvbYCNc+MBpjqH1JdXyAxC0d+f8OuCmtLkXs=;
        b=dJHd/jHsePBK1CSG5oLgLmXXe9hq4NjoFWUFYNkTHKsD+fUPMyaV29JrSEsA0jwW5r
         nTU3dNSXqFFqB7zTCmVx8/Gd9Idrj8yxvsob7A4OjwIzKewZxYLz6PjgjR7D0Wr3Sw1S
         ThZ4WjJGU0KEv588HsjNipRXmD96aig1O3ul8ks6JC9JmWcr0BqA6Za6NLLlSy4guNWO
         NL/5TDxAcdWg0t+eEA5Q9wziuWMHulOt6pNGlmC0IikZuWCiAVqg3mKnaGhoDApG8lJZ
         cxGQhgdRhOvjMUmJCv4F+79vBaoSkfllyVn1t+gSEQuu9vwsoH89KxDYMweVB3UtcmjC
         uWrg==
X-Gm-Message-State: AGi0PuYgZrVgRh0a9KLBYMMB9K1lC52qed/YMFEaK4CY9tArHB89d6yV
        N0jyJpGiZRiYYezqSQpOyaBPQGYoocT80BmExHA=
X-Google-Smtp-Source: APiQypIZA/7TUUfto0y/ANSz9Ix3uUVimyIJ+jhF7W2i48XxvfRRsfzxA7Q+o17t6ZaoFUhfOXPSHYjpVuSWZpfDR4Y=
X-Received: by 2002:a05:6830:1ae3:: with SMTP id c3mr19947438otd.345.1589342232456;
 Tue, 12 May 2020 20:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com> <xmqqees6vzag.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqees6vzag.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 May 2020 20:57:01 -0700
Message-ID: <CABPp-BG2tmwTLcU1d-qgZ4fK9Rrd5wo0QjO685tpfzHjQj1n3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] cleanup ra/rebase-i-more-options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 12:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > I've rebased Rohit's patches on master and reworked them with my
>
> OK, it took a bit of time for me to figure it out, but this does
> cleanly apply on top of 048abe17 (Sync with 2.26.2, 2020-04-19).
>
> Queued, but haven't taken any deep look at it.
>
> Thanks.

Sorry for the long delay in reviewing.  I looked through all five
patches; I had the same simple question about patches 2 & 4, and had
some comments about the wording of the documentation in patch 1, but
all small stuff.  I didn't notice anything outside of those few small
comments.
