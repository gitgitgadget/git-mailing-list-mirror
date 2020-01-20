Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB938C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ABF2073D
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 10:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9O30RzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgATKfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:35:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATKe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 05:34:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so29003516edp.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9+rPmnrpWrDwxZs5+Y8G66TWRxv/0T61bEROmaG0Zsk=;
        b=u9O30RzXpfD4gaMIfK2TisenN/3YoNSwtEqFIbA8samsULo/jrJvHI2Zu6jVsaDf6v
         06JadbKcuFNLtU8LZImRSzMUQYHIZX8dg9wmlpvM04CUl2dvILz6xakztDI4rcpd4qRu
         HyDQZBvyR81JduIay0Sp4Bb7FLjB1jhUTWzyNe0OUqLweQVq87rzuHBARFWAROnN/3cI
         bjASot0OYNStGQ8MQQ1tjzT2lzEWWYV/fADyyxFEkaZY4nfz4UXX6WQlb6ei0JsbCn1t
         LKuUTy6sfahBsIzACt7WdBHAwTdKepOHHXPwa2lnH8URQ56cN8avYvfmzZOOrUbkyp1N
         pe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9+rPmnrpWrDwxZs5+Y8G66TWRxv/0T61bEROmaG0Zsk=;
        b=BJ2lpJ8QD5Pe/Qk1z+vMsNzlHDpNIycT89dPIs38ujX8aoRQ2tvuMDf8JvYHKLMmQg
         CXuAg2d2tuTAEseDo+JItcGd1GtkQv5JPnHKJTWygIgAQ0U3Mu91AKnxndFIo+6IF55/
         7A7AiGORBI7Vn2Aqx0aANNc+Muqrct+k3l4ZIIyGmYGbu0KDIFDWhi9jBabyVcvwSGIC
         4MgqHuhfoEg1fj3d8pQpnMq9cbU5DQTCJcj/y63bNZYh0Sn3gSC0Iixul4OlHigTDOtt
         K6GIURpAcp8Lxv5d5X7pe+qeMMXUbkKfWimNqPXF3b7g/LYypj6SEpaxVZkfl03GLk7g
         gsow==
X-Gm-Message-State: APjAAAWLwOJP6I/k2+fNCO6LkEixIKyBQ2Pkjaic+iCDytLgFTwcG21y
        fj9bzYrVCZ+HFEUIwbBUKjgiSVn7FsaHOXh0CJW8SZbh1kg=
X-Google-Smtp-Source: APXvYqwFQsWI+2vEsG0rWuqp+cwi/Uq6j3OvuYhqwtBrhsHPzugR/m49G1mJ+OLksKdChbSIuqTxX6ImrIq4uodMypY=
X-Received: by 2002:aa7:c4d2:: with SMTP id p18mr16200912edr.237.1579516497624;
 Mon, 20 Jan 2020 02:34:57 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Jan 2020 11:34:46 +0100
Message-ID: <CAP8UFD06BqK=KM1CgkC_RciSmJXJvAE1O7pjiagEZ8dOSCV85w@mail.gmail.com>
Subject: Draft of Git Rev News edition 59
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>,
        Mike Hommey <mh@glandium.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-59.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/409

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
January 22nd in the afternoon.

Thanks,
Christian.
