Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF2C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B912206CA
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe5sP4n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgICVWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgICVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:22:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D08C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 14:22:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z1so4726946wrt.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82bMWLnROgQ1nmD5L7kPPlWh3QwNfrBc8nuDeXBGFDA=;
        b=fe5sP4n1ZT1Z5E4v58zHGvFlgPB4XD/RfhBbjUqoub/agl5f2yOfU/RY61YpiRde4j
         lVsLpQ8DfU7J8almRTs+dLXhQsdDWtaKhM28a997LpMW5wwfbdruS9RFpkdGo9j8WzJt
         +SXnrBKBvc6ztjjdMbgZgoKc/0EIDV6lSDNQHQQhP27m5MX4uK//GNucve7hcVb2uw7h
         nqb+HMGfvYuPWZ8CJuWZUfg/AZdZSiM1eipF0Ez9lmUKa5S2vl2owxJ6rm7viOSTS1fm
         PhtHyus8H+08s+MDgl3YWiScxtTV1ys/lHf4Oq8MYv2lc2aX/1on7xEpZ0PsTQm8dVos
         jUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82bMWLnROgQ1nmD5L7kPPlWh3QwNfrBc8nuDeXBGFDA=;
        b=sZfcNN3jiGClkwFufc9uh1Rk+GUQyT8jCsyDOeB+FOUC+HUfrv1D+6M9NM5kKHgDFj
         NMTBAJ5lryLkYzw1fxyxB13B/wANWS2jbuHbtqy4NIXKearopdlDsEPdIsOVbwIzBVx0
         uZy1YSva37TQ7b/DELKUwyZv1VrTZ4+pyAkIxo9coKDWl+tQ2zALOoYZ+fgYRlCwshbY
         sqDNbrBJME8LZ51fp1eWc7eOA5riHlGNMh9NbGFeiokNpnxyYPSN6KGMejBfDLbRSJKV
         ldcNQ5dDVLHrcYJ0aACU6jNjzt1C56T4WkuyzR3MsDs3Bx0tLSaAZNBSAlP1f/SjG0/T
         xrCw==
X-Gm-Message-State: AOAM531wPhZpQLkdXtEbklIhoRM68McxLO4FGskdKaxdELNcUyg6JYon
        535+k27YOC8htdz1DDunvda6Uaf31F8VNAcn1g+ms4pc
X-Google-Smtp-Source: ABdhPJzx6umx7M72nYxvy2RU/pTql8PfgjRj9Yv0quwkl/82iidQs1kfvmwQZyfncQ1Y9UUm01XYmZH46+XitJuLFQs=
X-Received: by 2002:a5d:4844:: with SMTP id n4mr551394wrs.141.1599168149144;
 Thu, 03 Sep 2020 14:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
 <xmqqa6y6ah8h.fsf@gitster.c.googlers.com> <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
 <xmqqtuwe8t5s.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuwe8t5s.fsf@gitster.c.googlers.com>
From:   Victor Toni <victor.toni@gmail.com>
Date:   Thu, 3 Sep 2020 23:21:59 +0200
Message-ID: <CAG0OSgdT+ZCT0dN29A89XhWi65SFepwyGA0SoS22TYGrvNnWqw@mail.gmail.com>
Subject: Re: Aborting git rebase --edit-todo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
>
> Victor Toni <victor.toni@gmail.com> writes:
>
> >> I think the implementor chose the first interpretation.  The "drop"
> >> insn is a relatively recent invention, and back when it was missing
> >> from the vocabulary, I do not think it was possible to say " discard
> >> all the rest" without emptying the todo list, so that design is
> >> understandable.
> >>
> >> Now we have the "drop" verb, the latter interpretation becomes
> >> possible without making it impossible for the user to express the
> >> former.  It might be a good idea to
> >>
> >>  (1) save away the original before allowing --edit-todo to edit,
> >>
> >>  (2) open the editor, and
> >>
> >>  (3) when getting an empty buffer back, go back to step (2) using
> >>      the back-up made in step (1).
> >>
> >> Either way, the todo list editor buffer can have additional comment
> >> instructing what happens when the buffer is emptied.
> >>
> > Personally I would like to see your approach (1,2,3) implemented
> > because it is not destructive. If the user wants to achieve something
> > different he can retry.
>
> Obviously I agree that the approach would be nicer than the status
> quo.  It would not be as trivial as a microproject, but would be a
> good bite-sized starter-task for those aspiring developers who want
> to dip their toes in the water to start hacking on the codebase ;-)
>
Nice try ;) Speaking of toes ... I'm currently involved in another
project from tip to toe.
I would like to come back to your offer sometime next year when I've
completed the other one.
Especially since I'd have to polish up my buried C skills... C didn't
get GC lately, did it? ;)
