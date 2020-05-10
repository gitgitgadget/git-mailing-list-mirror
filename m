Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D53C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E42D2080C
	for <git@archiver.kernel.org>; Sun, 10 May 2020 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmd4Ljmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgEJSeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgEJSeX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 14:34:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF74CC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 11:34:21 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so5804897otu.1
        for <git@vger.kernel.org>; Sun, 10 May 2020 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Buvn+xWygdq8WTon7RL+ciwaLjt70YUf16P2XgqZWZ8=;
        b=mmd4LjmcUEPat0zv7msCQ5p4MHlGcngyqlaEipRH0mdHM7iW3my/gD3Ck4dZqZWjpK
         0LSyvd0RZeq1T2uGKpzCT4Zfoptub8zF/RkDCWtfaIR3p4xjYPguLYh3ocFixwod7ScA
         V+OLL9ao+vCg6mtqTlnOWHTQcBCj8IB0ePYL6ZfQHsCwTdcP7vZQXmvBmHpopzRC7r6j
         drc4n7iONsZR8Inog6T0NyJn4EwXxoqn8ltE6cC+Udp9wytlHUsV/zYBJinB0kpp5scN
         SFX9tFblF6FMnqQ9tus0hx/gx9i0jLK0RpQ2zNticl1QZjbuer3yZe8rQGzszlpocJIU
         kTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Buvn+xWygdq8WTon7RL+ciwaLjt70YUf16P2XgqZWZ8=;
        b=QVD5F0SsU0gpnv8XQm9rn8ZwbbubmEezHaPA5FtYiHS+Yb8cy42ngBLSLmpZkOHg3V
         +rdgkn7t0uAAodLKki4goKqhAdHt3r4W2TSQXFOYsEjGtN0ujsQklF480BEdRPNpjs/3
         26NHusCY53XdLTsISyylpnTJiLQnmi8ORqRikmLhQ925mA3WbwfgwbDRnDdU0ZRixgmI
         k/LOhV4BxM87gkzpqMbdEjgL8OtyCZJ7tmxqGga87wErCRAaQ2+HQ+ebeh0Yoad0hB4k
         qhTX04aUzFnmQicaJR2Dy6rnt0ImQunDkhUMAryoH7Y1hskGYZmX3zf0Zn161ckH60XE
         xkOQ==
X-Gm-Message-State: AGi0PuYz3ALKWkQ713x7LPUpK+3gPJgPpjuf0gdaZLEwjUfdde3XK0+U
        sA/8JaA1BuDmtk6Oz6ubNB7YIzMTyxpWsj5BSNWZ+1Sp
X-Google-Smtp-Source: APiQypJSGjrNN3BzMpbGaKhU018Q3FTKvLfg7nwKqfJqg9NLMVg4hAMHIXlyUeGATTEKG4ATTLtUUvJzG+b36b2OI4g=
X-Received: by 2002:a9d:1eaa:: with SMTP id n39mr10388920otn.238.1589135660950;
 Sun, 10 May 2020 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
 <xmqqd07cvl9b.fsf@gitster.c.googlers.com> <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
 <xmqq8si0vfp3.fsf@gitster.c.googlers.com> <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
 <xmqqwo5ju47t.fsf@gitster.c.googlers.com> <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
 <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
From:   George Brown <321.george@gmail.com>
Date:   Sun, 10 May 2020 19:34:09 +0100
Message-ID: <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think with this change all editors can benefit. The format "git jump"
is producing is something easily consumed. I think consumption of output
from tools is far more common in editors than communication between
multiple instances.

As an aside the fact that as is "git jump" invokes "$GIT_EDITOR" with
the "-q" option makes an implicit assumption the editor will be Vim or
something very much like it. To be very clear I don't mean to say this
means only Vim should be considered. However it's also making the
implicit assumption that passing the "-q" option is valid for any
"$GIT_EDITOR" and does not cause an error like that seen when trying to
override "$GIT_EDITOR" with cat. This change means other editors can
invoke "git jump" without fear of such a situation, increasing
usability.

Arguably the most interoperable way for "git jump" to work would be to
output the formatted lines and do nothing else, leaving it to users to
choose how to operate upon the output/invoke editors. Of course such
a change would break the workflow of anyone who uses "git jump" today
and isn't a valid option.
