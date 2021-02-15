Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFEAC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B28264E07
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBODho convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 14 Feb 2021 22:37:44 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:38278 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhBODhn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 22:37:43 -0500
Received: by mail-ej1-f46.google.com with SMTP id bl23so8937444ejb.5
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 19:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4qtzsyBugpIQEpv51nfAzzx47GM6TdMF1ReIY9hmXGg=;
        b=tT3fPk+INy3ZynBk4oRMeBkcvGXVjfCHYhp/B13aMHjU2osA3IpmSKJDIRZxhMBDrE
         9X2K3PYit5ncnaR+RncFNDthL0ap+JsRfnJQ8ll0KNl6+U92EPm4XPC+/dHTpwVhlPjo
         xP0LTCDN7yr7ITV/l9unCHsoYTIRpePeqVtcIJAgnA5Q2n3cp7h2xnRRS8Ga28KnAcEq
         yPXeZLLz8ahqoXnmIo0hwrNc+//9iMUydP4cjRxGQxeEDSSCbHZClFZcZm3gLovVUScl
         acHdf1lvUZkkAg/thfS29V1HdLsG8/x3dze38x3YSWmIhNQe0LB3QFbc4zlNDiUATzBe
         tLnA==
X-Gm-Message-State: AOAM531LvY0vsEMuunT8Oyp3ITV2d1lURWMJGeavRwQW90SNJOFYNpSj
        +Zq5I0YGbYQBary0iECQQLrsENjjtOo9+4UqojoagOuYBcY=
X-Google-Smtp-Source: ABdhPJw7Xp9eSQrGDOPy2JUQKsQKAmeJmheHyCYwL36bcmj6o/dYmRfrm6IEeiG5DztqHH3LhairMZpwJK3Qo8AYMTc=
X-Received: by 2002:a17:907:1191:: with SMTP id uz17mr13720455ejb.371.1613360221048;
 Sun, 14 Feb 2021 19:37:01 -0800 (PST)
MIME-Version: 1.0
References: <87tuqebj6m.fsf@evledraar.gmail.com> <20210215005236.11313-16-avarab@gmail.com>
In-Reply-To: <20210215005236.11313-16-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Feb 2021 22:36:50 -0500
Message-ID: <CAPig+cTUAWoDMf-SYhBZiptccX8hSAsT+oODxSwH5jxws+_p4g@mail.gmail.com>
Subject: Re: [PATCH 15/20] gitattributes doc: document multi-line userdiff patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 14, 2021 at 7:56 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Document the multi-line userdiff patterns and how their matching and
> the negation syntax works.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> @@ -794,6 +794,23 @@ backslashes; the pattern above picks a line that begins with a
> +Multiple patterns can be supplied by seperating them with

s/seperating/separating/

> +newlines. They will be matched one at a time and are compiled as
> +separate patterns, and thus the first capture in each such pattern is
> +`$1`, see further discussion of captures below.

I found the wording "separating them with newlines" ambiguous. I
couldn't figure out if that meant that there must be a blank line
between patterns. Would it be more accurate to say merely that the
patterns must be listed one per line?

> +Patterns that begin with "!" are negated (to match a literal "!" at
> +the start of a line use e.g. "[!]"). A matching negated pattern will
> +cause the matching line to be skipped. Use it to blacklist otherwise
> +matching non-negated patterns. The last pattern must not be negated,
> +we'll error out if that's the case.

The parenthesized comment makes it difficult to follow the discussion.
Moving the comment to the end of the paragraph would make it easier to
grok:

    Patterns that begin with "!" are negated. A matching...
    ...error out if that's the case. To match a literal "!" at
    the start of a line, use "[!]".

I think, also, you want s/matching line/matched line/.

Chris's comma-splice comment also seems applicable for the last
sentence in this paragraph.
