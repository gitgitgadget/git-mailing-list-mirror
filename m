Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552A7C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D5E613FB
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhENU1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 16:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhENU12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 16:27:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE70EC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:26:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u144so623978oie.6
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YGChUY+BKzCg970y7Jlf7JMbWhFLgNFAfANOLrsXpTY=;
        b=RoqeiuFU9nhh6cHeTyAgaOEYX8okX0rLYhBlp4aGG/X+LN3YJMe3vtjhyF2wL6TvvS
         +BBbFVZnZpxIBGFe42yURSF3Y2tQhCkrWQhCelDvZ+ZSK4RTPbvAi4FCysSbVFo0tGq4
         rKBIAZO01IIdHXZM1BD+3PvvRaK5yswji6j7HY8svKOBx3fmpRi/CvcK15yeHPe+YJRu
         Pgf54sVPlNSY+QnHCJrPrax5u3dVZALesN8W+Xtq59BjOqgEZXKavKQpgKiyGjQlwNhh
         AoUtnT9fhBpMaSt3gEUkAh6PB8P3xUmJ6Ne5+oxhJ4DAbNb3AvjLl5vVq7a6nl7UFFqM
         PSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YGChUY+BKzCg970y7Jlf7JMbWhFLgNFAfANOLrsXpTY=;
        b=pJjCEoYxBkvuOJq5EK/l46ZiY/6YFY6LOueuo6MnUE2xIlRXLq5OkbcYFb0l2a98fY
         J6m03udlfR6ggckhpbeouCZ1iK1AORcyCYo6JwZ0eVvWSWQ/KCs3KkNcgvtfakFXxG3F
         rcKA6dh1ClvRALb9+2Na/8HUdd6z7np1xNnUFP99EZq/o3QIvevNzHR2Xneeo0HhEgkJ
         xkJydJrycc/gsMEbatT3h8ROe2HfpEcSTBB2hqdx8Zu3RB2F1HiAixl9Eb2f/Gh3GoAU
         zJNKgEmdMYBNgZAVjKSEWEyAYWB4oEegBmoxQsHkCFzVQK6LanIipKV+LQw8tCADmmn6
         n7oA==
X-Gm-Message-State: AOAM532lAekN0XA5VXnp7dLrXt3ih8jce9iHWFOsqODlXxxpgDkpWAje
        mnZN/Wxfpn9jAHUDRk1ZF/M=
X-Google-Smtp-Source: ABdhPJzBDRo9fqQOU6wKnTeFW5GS+ybxC1GgrQAMm5swDY87xGV1m07JU2jOfpmGCD4GrBKMd3KALg==
X-Received: by 2002:aca:eb57:: with SMTP id j84mr8263690oih.131.1621023976130;
        Fri, 14 May 2021 13:26:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i18sm1504151oot.48.2021.05.14.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 13:26:15 -0700 (PDT)
Date:   Fri, 14 May 2021 15:26:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <609edce68cff1_43127208aa@natae.notmuch>
In-Reply-To: <CAN0heSpX53tK8Z4XSx4sp79b+XWKZg5+ABW8pmzBSHPZ+qy+oQ@mail.gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-5-felipe.contreras@gmail.com>
 <CAN0heSpX53tK8Z4XSx4sp79b+XWKZg5+ABW8pmzBSHPZ+qy+oQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] doc: use asciidoctor to build man pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Fri, 14 May 2021 at 14:14, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > There's no need to use xmlto to build the man pages when modern
> > asciidoctor can do it by itself.
> >
> > This new mode will be active only when USE_ASCIIDOCTOR is set.
> =

> May I suggest incorporating something more like brian's patch here [1],=

> so that there's a separate knob for this thing?

Sure. Do you agree with the name? (USE_ASCIIDOCTOR_MANPAGE)

> The commit message is short on details and makes it sound like this is
> it, we're done. But then there are several patches to fix up things.
> Which is a good approach, so that this patch doesn't need to do several=

> things at once. This commit message could say something about it, e.g.,=

> =

>   The doc-diff here [which doc-diff? see below] is a XYZ-line diff.
>   Large parts of this difference will be addressed in the following
>   patches.

Right. I'll include that.

> About the use of doc-diff: If this commit introduces a new knob rather
> than taking over USE_ASCIIDOCTOR=3DYes, the next patch could be Peff's
> patch to doc-diff that compares the two asciidoctor approaches [2], and=

> then the next few patches could diff between them. That would get the
> asciidoc-vs-asciidoctor differences out of the way, so you can focus on=

> asciidoctor-vs-asciidoctor.

You mean [1]. I think that belongs on the same patch. It's important
that if we do have a new switch, doc-diff is able to use it.

However, I personally don't need such switch, I want to compare
asciidoc-vs-asciidoctor-manpage wholesale.

I want to see *all* the diffs.

> With a separate knob, it would feel like a lot easier decision to take
> something like this. There are over 11000 lines in the doc-diff after
> applying your series, and there's the missing boldness for literals.
> Maybe those differences are all great (I would be missing the bold
> literals, though). If this series doesn't affect someone using
> "vanilla" USE_ASCIIDOCTOR=3DYes, we could let this thing cook in master=

> and work incrementally on top.

I did notice the missing boldness for literals, and I know how to fix
it. It's a small hack. I also noticed a few small rendering issues.

But from my point of view after my patches this is 98% done. Most of the
remaining diffs are fine, for example:

-GIT-CHECK-REF-FOR(1)              Git Manual              GIT-CHECK-REF-=
FOR(1)
+GIT-CHECK-REF-FORMAT(1)           Git Manual           GIT-CHECK-REF-FOR=
MAT(1)

That's clearly a bug in asciidoc+docbook. Others are things asciidoctor
renders better, and most are whitespace noise.

Cheers.

[1] https://lore.kernel.org/git/YJt1%2FDO1cXNTRNxK@coredump.intra.peff.ne=
t/

-- =

Felipe Contreras=
