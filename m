Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDD11F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbeGKPbH (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:31:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41508 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbeGKPbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:31:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so49937868oiw.8
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpQ7XmuOZ3GB+8Y9X1yj5vaRCc0iYA9o0GQAxZo5M4s=;
        b=P8s5LCWDOPIrKpmy5SuM/oTaj6U8Qi5ryS1o+936GiulQkSmaK7sQZvX71LzoO6UK/
         tw1LVGQpauKzahJePRiaoyrUa7/GE8NZXLb0kEbly5eCSgI1Q9qxCumyyx34ZD4MI+mg
         y5hcFRICeNt/8iMs46Ss4mKLtlp1BBwuucPDBdKD9qsTaP81M8Nucjr4W7XIGhyn0b4w
         Wson5U9NbFlQo/L9M72WeFrBspTWHmgHX1ET0yqwscoZBJlvUm/3wIAXPevCBQ+ONmYQ
         3BLXu0SMVUaBzR617LawI8tG3XlHHFPV9/0t92W9mhvYTGqblagQl8wQkmthFNfJyKWX
         zUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpQ7XmuOZ3GB+8Y9X1yj5vaRCc0iYA9o0GQAxZo5M4s=;
        b=ZxsRwHXg/bJGvNaR++qTmucrPoYo4NS9hELgJRZbu+xhaV1Sqn6Hi8g273FHK4W7BS
         yTVVBGBA3RQldJ+DY51WRNlSNybbe7Wyc9JB2Zobwx+W4bTYePv81HNUqlzI/pzIhlbU
         4Kqf8w9Gtj41aP2Z3vTfzQ6oPNYE/ewydsccRhivKjrwpoQTpUu+HoR7O9K1XyF58ze3
         IFte/skFlFabaV8bfF6zi7y2C6JSpLA5FXax5nCkK5f0X/NybZcIQuMbM9O7wqVeyrZZ
         CRsCVOqEFsx5L8bjoVSAUZkflBvH+1XsXMsgzS9EJGbjWv1VECBWxL+dxjWaOt09H1DW
         LTuQ==
X-Gm-Message-State: APt69E300m8UNscl7l3XqCbw+8zYlSFl50v/gzLTl4RM+i5ky4TSDNlD
        sOtwb8VRBM6aY5PEdBTioIMgKuss3BD2VsnZJhQ=
X-Google-Smtp-Source: AAOMgpdjeK7rO1j8tjKHbP+PJwYQGRtITM9myacI480odI50eb8SgNQsTf/5Tl/yDX4bS4Ym/bqtQYRjQVwhW/gemgQ=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr22627149oiw.34.1531322776719;
 Wed, 11 Jul 2018 08:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180615044251.10597-1-max@max630.net> <20180616051444.GA29754@duynguyen.home>
 <20180710192153.GA2050@jessie.local>
In-Reply-To: <20180710192153.GA2050@jessie.local>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 11 Jul 2018 17:25:46 +0200
Message-ID: <CACsJy8BVadBd1T2yoUhnxd21=c8SVaFqPXT8kk4NfnzGyBNOCw@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: do not fail reset because of unmerged
 skipped entry
To:     Max Kirillov <max@max630.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 9:22 PM Max Kirillov <max@max630.net> wrote:
>
> On Sat, Jun 16, 2018 at 07:14:44AM +0200, Duy Nguyen wrote:
> > -- 8< --
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index 3a85a02a77..eb544ee1b3 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1246,7 +1246,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
> >               if (select_flag && !(ce->ce_flags & select_flag))
> >                       continue;
> >
> > -             if (!ce_stage(ce))
> > +             if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
> >                       ce->ce_flags |= skip_wt_flag;
> >               else
> >                       ce->ce_flags &= ~skip_wt_flag;
> > -- 8< --
>
> I tried your fix and it is working. I put it instead of my original fix. Would you sign it off?

Signed-off-by: Duy Nguyen <pclouds@gmail.com>
-- 
Duy
