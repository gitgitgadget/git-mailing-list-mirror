Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232AC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB3161440
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhENPkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 11:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhENPkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 11:40:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E759C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:38:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1525592pjx.1
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WAtYHEoBTuTl4cB7TSGTTBRneCmh9gRFJUThlY/TgQ=;
        b=ROuPucV5gPgLwEva69NClTzpIlvbq1YQhKbMrCGmOpWxDjBQ9VZawjOLp4yx9zFmqQ
         lvumgEfh+sCmlYi/PW+nUOWF/YFruF5bas+vO5jbo8db10OcKmxrg4+f9qQUjV306ZoO
         XihTgjDgalRBasLCfbWA8IIvfrMPhq5q7+UMLX+djAQiFVdXSpNmN2MFHiy4ZPjrjRlm
         bAPU5M/GIGzWzbVpM1JHWwq88iA48di4Y5UfaIAyRr/Rxv+K1HSQIcJtEQ++slj6iKdl
         HHXmolQ/l5J9kjCA4aeOKp1nnY1rT/s4za3dfPjsTDAGASheg0QpruL3ArAuAFrCQlFC
         WFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WAtYHEoBTuTl4cB7TSGTTBRneCmh9gRFJUThlY/TgQ=;
        b=jVoT3OGQgbro0cX1RvlYnywmm+B4r5YRFvtjP2Pc2xe7t/a+93cLkX1p4QJdE4O8pP
         voWjoQkq/F9Xg32diUeZsbR7/7ajIYX2zIkbUfrOdSb4Lo3c+e/C6XM050IDy3muKMxt
         rY2b2TwBhoq2k72HjSid7/ujUEn9gpQZDi5MZ+3mIwzRmRmAjZ/3SWvXvy4OuJPG3JWw
         NleDnSjrpmXIQNlrMeZmQmxWr+zztYQNVqAvdAT+X0mc+nSNY2rLdDOmjqTHZfndZqNg
         T5ZQ4TWpk4IFTHytusrR6lvF+ImLtN7JrQl2neq1reTnkNZwWUgxjtfjj3SGqPABnxNh
         noiQ==
X-Gm-Message-State: AOAM530auQD/lNNlBmPC7A1i/sbaWhn5XqfhqpYQU0li3bJTWBo0dFe9
        j5d9/vXeZ+X7FT4G/xIzxHB8lsVzEB+T6R3EwAM=
X-Google-Smtp-Source: ABdhPJx6vJ+sxiNHoU9RyAnz3P/6baaejCIBPw6S7gNu1VM/v7LUsizfE+KD1CmhgqUPk2p9X+kK3/W3949tEn3XscU=
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr11793456pjo.171.1621006738405;
 Fri, 14 May 2021 08:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210514121435.504423-1-felipe.contreras@gmail.com> <20210514121435.504423-5-felipe.contreras@gmail.com>
In-Reply-To: <20210514121435.504423-5-felipe.contreras@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 17:38:46 +0200
Message-ID: <CAN0heSpX53tK8Z4XSx4sp79b+XWKZg5+ABW8pmzBSHPZ+qy+oQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] doc: use asciidoctor to build man pages directly
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 at 14:14, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> There's no need to use xmlto to build the man pages when modern
> asciidoctor can do it by itself.
>
> This new mode will be active only when USE_ASCIIDOCTOR is set.

May I suggest incorporating something more like brian's patch here [1],
so that there's a separate knob for this thing?

The commit message is short on details and makes it sound like this is
it, we're done. But then there are several patches to fix up things.
Which is a good approach, so that this patch doesn't need to do several
things at once. This commit message could say something about it, e.g.,

  The doc-diff here [which doc-diff? see below] is a XYZ-line diff.
  Large parts of this difference will be addressed in the following
  patches.

About the use of doc-diff: If this commit introduces a new knob rather
than taking over USE_ASCIIDOCTOR=Yes, the next patch could be Peff's
patch to doc-diff that compares the two asciidoctor approaches [2], and
then the next few patches could diff between them. That would get the
asciidoc-vs-asciidoctor differences out of the way, so you can focus on
asciidoctor-vs-asciidoctor.

With a separate knob, it would feel like a lot easier decision to take
something like this. There are over 11000 lines in the doc-diff after
applying your series, and there's the missing boldness for literals.
Maybe those differences are all great (I would be missing the bold
literals, though). If this series doesn't affect someone using
"vanilla" USE_ASCIIDOCTOR=Yes, we could let this thing cook in master
and work incrementally on top.

[1] https://lore.kernel.org/git/20210514003104.94644-2-sandals@crustytoothpaste.net/

[2] https://lore.kernel.org/git/YJt81neO7zsGz2ah@coredump.intra.peff.net/


Martin
