Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D52CC4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BA1206F8
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2x3Y3yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgCWTWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:22:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43612 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgCWTWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 15:22:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id bd14so3801153edb.10
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v5T9D1Mrp1IBlJZEeqf6cTQ8VYW171+IyKG+X+hH95A=;
        b=c2x3Y3ykaKyfN7F7upGRvCyBLv2uTRdX1xVS4OB1+AaTMXEKFw8AOU51Qz4/i++ZFO
         mDC2dC8D3YkMUjQadZ/CXizQcqur4ydQT3p8VgDjf2+YfUxFFlemvLva/wD9eKAvLLl4
         9Y1nnVmV7OITwYTdxZyxTcOZ5yZv1gepupeenKGReG3ho2077xAHCEU5BKawPIHLWg23
         7xtnnl7MebthAjAozKIQvTBYgL1x21OvPPp1Wwa4wxe0Sa+pTZ81BxgqZ1r2/hrWOcyj
         HFxwOBNN+0ex6J+MGIF1pt6GtK8mDluoXMe07AP/mJ+O1cXDUfGzZnh4wSY0vXXtZO73
         p7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v5T9D1Mrp1IBlJZEeqf6cTQ8VYW171+IyKG+X+hH95A=;
        b=ME2+Wt5TOYWcpZsfPlbIQYxGO3qyQSof0kOXcfQkdH8/IwCbwXxZfpzYqgRQi3BBhC
         v8EgvDMrQNSMDrcMhyU1kgKFCNZfJQG+HCgoWSXcMSikdwA9yuxf37KuuV977MUDuIEB
         4lqhTPvKy84LgJ1fzG9RmHSMRAehwLqGQkqkCuFko5aOuglkShIKsxvUMVeTal91OfCz
         psBWQBzds5mwmp8hp97Qexd3oLvEZ2AkQlgqNzHYPQY9odCEIhOzKdmX0etZNAgjx/8Q
         RjsS84VZS9ojbrH22r7LJizNOe97mVKiHzk5l5EjiBMYxqPee8uxeidEHxL9TyJ91+zH
         sTnA==
X-Gm-Message-State: ANhLgQ3YGqqdrRxsBKzuNNIjbNm1CIFyfvudCpbw+CY+iTC9Lw81nvO+
        cZjJNrHpALtCBFrLVmUP7BOT77Ivuf9pvFr5mmvrWrkPGZ8=
X-Google-Smtp-Source: ADFU+vs1+lk40tM7O2sfo+gLkn7qxDR5LplZdRC00ios5Z1qAlu5SMJMhH0dIxTgbJoARQr8Uh4msd4iUYESSM6JdH8=
X-Received: by 2002:a17:906:af57:: with SMTP id ly23mr6815128ejb.6.1584991347620;
 Mon, 23 Mar 2020 12:22:27 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Mar 2020 20:22:16 +0100
Message-ID: <CAP8UFD31gx6TrifGwOKJL-uZLphqo--=zoqiZb5Y-QstQxTmPA@mail.gmail.com>
Subject: Draft of Git Rev News edition 61
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        "Miriam R." <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-61.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/417

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
March 25th in the evening.

Thanks,
Christian.
