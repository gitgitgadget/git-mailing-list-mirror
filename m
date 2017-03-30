Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D89EB20969
	for <e@80x24.org>; Thu, 30 Mar 2017 12:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbdC3ML3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 08:11:29 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34316 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbdC3ML2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 08:11:28 -0400
Received: by mail-oi0-f46.google.com with SMTP id o67so29087040oib.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZGzcrd9O/TjVEqkezzp5BdRThLphMYJBofRYzpv7Q0w=;
        b=MurznpQRJCcBqhwOfkdmod4883XSLRq02x0G6SmaNMlo8aMygmRSUq4Ay4+geIc7GJ
         xYp1OfrHPYF9n959Oh0y2cxydzwFkhjkmib9S88Kxgm1Iz+36A0p9HEX2UVd9RyB53ue
         r5ROtN4e6iv8NzAeS+/4wLyvgkV0okYABEQWTVddC8PBxzAiWzdqz3l1PwV4QcfPjXGC
         qGzHKmUCLbw7ElS4B0+pde2rN35UA3qdogExOa5KN1wwFtUCzPcnvXqi6r79SAwP0ouU
         b/klcuIItQV2RGNPND1Pq0NW4Z5dOslHBTsyvAW9ZEpvSNHdpO1C7Z/2S08QTdgGQKLZ
         y15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZGzcrd9O/TjVEqkezzp5BdRThLphMYJBofRYzpv7Q0w=;
        b=ee24wS+ONGufkHaZETWQTWIUrJtaiyWJFgldZiJ5u03TrfV0fIr111jX2u3Man6DD5
         t97bVxWPq8aZM2Ve9LP0iU83DRWbypsbD9s8Xb9r9Qq81DR25c+i6R2irYKZvvL4s5bg
         WtIOzvW046PIpxmZfoP0+AH+akbu8L2t9UpsICwJYw+NK5DjXiwAOF+KjnWMBPQjqsTE
         YZeSP/DkA+z9dC1I1oogZYPAebzxyY6gD/oOYXnJaXdyYBlXKa7OpdrgS4g3vTlLZZfh
         AF19UDE31nZRN4Q6Wo3+c1/hw//PCrYj5LtNuMho7ZM06hn5PIWWnSK5oqIL6+zcAcKm
         PhEg==
X-Gm-Message-State: AFeK/H0JmyC9F3U2QPwq1+q28nbfcvOYOy6TaNIVG9TlfM7dnZg+22nnmVhkBXvu6Dvr3udwg/AW9Cl8Diw7KQ==
X-Received: by 10.202.72.77 with SMTP id v74mr2851460oia.186.1490875887272;
 Thu, 30 Mar 2017 05:11:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Thu, 30 Mar 2017 05:10:56 -0700 (PDT)
In-Reply-To: <708a97ce-9384-f863-37db-32383dd5a984@alum.mit.edu>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com> <708a97ce-9384-f863-37db-32383dd5a984@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 30 Mar 2017 19:10:56 +0700
Message-ID: <CACsJy8Akf2QU_qUF1i2c-RnT7=vQZReTSx0kJO_Rw3dDwxb1FA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] [GSoC] remove_subtree(): reimplement using iterators
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Daniel Ferreira <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 6:27 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I'm very encouraged by your quick and constructive
> responses and especially that you are sticking with it even though the
> project is getting much, much more involved than a typical GSoC
> microproject.

I'm impressed too. The new series made me want to read it, probably
because it's so easy to get into. Unfortunately I don't know enough
about dir-iterator.c to contribute any good feedback. And other minor
things have been all caught by you :)

> It's common that nontrivial patch series have to go though many
> iterations before being accepted, so don't get discouraged. Even
> experienced developers sometimes get past v10!

Pffft.. v10 is for amateurs. Experienced devs aim for v20+!
-- 
Duy
