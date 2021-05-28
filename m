Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3DDC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EC26135C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhE1V7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE1V7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:59:11 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E0C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:57:34 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x15so5648601oic.13
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qnyK4/+y48ncebBJnHg7JlL+J90NE3jW8NuEIKq7MuM=;
        b=H2+CO5aAWJhOMgSZw5WgMqEW2U6hcpiQzFARlpjetsxPQN2qxnHjgT0NKyvAOd0gkZ
         Z2cHJmIHsCvhpobxr4pbYPPB8RVgwNomYXqm4VqYf/tmrZweLE+wxdkpvTiEs0me2bUg
         BTgIBIk/lIxpzYJi/IgCHjiVU9Z6kJSIjkIgDO2L0IfJouoYDoawn6daKy1WEY3Ge4w/
         gh4w4hHjtw/YW1gYlMDg0jTORxXe8AexQBnvNuZlohBGxCkI3nh1/ZODXBW52yR858aG
         FRwSqlJO+iCquSLoFP5uGJ6TFV5l5mSLNxrQjR3gps90ePeRdChYdS5UXc4GMySwbUpu
         RDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qnyK4/+y48ncebBJnHg7JlL+J90NE3jW8NuEIKq7MuM=;
        b=JhhKfdif2IJoQGC3/EZ/Fs16ZqG6GkzmRV0AuZdGmTf5LoqDobw9x0P9w9JnfmmUup
         qgDUQNWYFCXOftbSzUjDmnve7UtTus2QSzMmpBw93LX5IBLtGJF2oxuEn1D0Z/3hbNUz
         tW0S7S43pkpGj5NS2KeWGafqGMJMXHrJbhHXlDx01XWBuAmkG+PZyV11UGLIy2aXlnOg
         T6TCCnobejbkEKgcuQy5j1b28QqSm9vrHQr+etTZygx7bBGAHwmUVMXj3njEksoTp/Pz
         Sd4IiY63fcB/QU2iprbuNiD3HJQQ6yzBibGG2VNHYAulUdJJFlrr77VnvCgSNAYDRNVz
         LZFQ==
X-Gm-Message-State: AOAM533VneZbvrRpwPFxoOR9KU9MGs4LVqBFCxmCs/yKhlbYrTjaGVer
        VZnlmtyPatQfrXl4S88ZbCo=
X-Google-Smtp-Source: ABdhPJybTmIRal5VdnBH/CW2A484SU2h1INCNP1dQYqntIko/tQ1xvSa5adovOeOvLyQ7B048+kI7A==
X-Received: by 2002:aca:d409:: with SMTP id l9mr7532665oig.77.1622239054342;
        Fri, 28 May 2021 14:57:34 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b18sm1391375otk.62.2021.05.28.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 14:57:33 -0700 (PDT)
Date:   Fri, 28 May 2021 16:57:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b1674ca4f58_2a3717208ec@natae.notmuch>
In-Reply-To: <CABPp-BHs_id3kOHgBWCK0QjviuRu7Dgbq5iB7z5=RZDOX-ontA@mail.gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
 <20210528201014.2175179-11-felipe.contreras@gmail.com>
 <CABPp-BHs_id3kOHgBWCK0QjviuRu7Dgbq5iB7z5=RZDOX-ontA@mail.gmail.com>
Subject: Re: [PATCH 10/11] push: flip !triangular for centralized
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Git is a *distributed* version control system, centralized workflows are
> > the uncommon case, where we do need to do extra checks.
> 
> The commit message seemed slightly funny to me, though I'm not sure
> why.

I mean, in my mind I have present two facts:

  1. Linus Torvalds explained that the whole point of Git was to have a
     decentralized VCS [1]. It's not just an important aspect; it's
     crucial.

    If we never get past [the part where I explain distribution], I'd be
    fine with that...

    If you are not distributed, you are not worth using. It's that
    simple.

    I think this is a huge issue and that *alone* should mean that every
    single open source [project] should never use anything but a
    distributed model...

  2. Git doesn't actually have great support for "triangular workflows".

So I do find it funny that the boolean is called "triangular", when
that's supposed to be the whole point from the creator.

Maybe some of that spills out into the rhetoric of the commit message.

> ...I think the code is slightly easier to read and reason about since
> it removes the double negative.  In particular, when someone reading
> the code sees !triangular, and doesn't know or remember the meaning,
> they have to translate that to !(remote != remote_get(NULL)).
> centralized and !centralized do not have that same problem.  So, I
> like the newer version.

To my mind it's not a slight thing at all. Every time I read if
(triangular) I have to stop and translate... Oh, they mean using git in
the way it was the whole point of starting the project... So they
actually mean not using it in that *other* way.

Cheers.

[1] https://www.youtube.com/watch?v=4XpnKHJAok8

-- 
Felipe Contreras
