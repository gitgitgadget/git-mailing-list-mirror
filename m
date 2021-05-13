Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F03C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1093861106
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhEMPVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhEMPVg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 11:21:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A8C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:20:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l7so31456862edb.1
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pTJIhi1rkxsQ2UlhjYQdTJo+g7VNPuR011iZNGRbutE=;
        b=WBwpXyc1oGC35b7KDjD1af9kVuppMH+wcgak/i+001dJyQ2hP1qLGfiOsr+wSjSgJ3
         bWBmo9hHhEDQiu/VSFl3a5QPsdL2j8LjRf1jTMeoVdssXtdY0TH0e4EUxpvhgw5GMRvp
         5K9YGQagbV83JR6U8hkBH1S/CvKQdh7FwRrLYmZ83eq0h9xhlM8towI/4Uyt7+DGEAo0
         Oir22TdCm6HVA0W3aecY5umGjL6fMer28qH9vwMclCoR7tjKHwlgfGAJDB5H17ZHohcp
         gLCX2TDXEE/xrQD+OBWH3TppVrlqtDKra1+okeQl9vZudXM1/LYd/wlriV/JkzrhOZvT
         cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pTJIhi1rkxsQ2UlhjYQdTJo+g7VNPuR011iZNGRbutE=;
        b=P9ftDqVXfRkMd1m2MblrmhmEWYHMQyel2GL3c5X+eOe3YwtktaOqOq5kgcRyu7apSq
         elFiJZii+HB+4sILp1kOtRdbLhi4+OXPYvElgju2jdo9RiiekQ6V0ma0reP0eX4dwF+6
         4zgI5Up9NOYFWXJ1cG12fES/+Jk2tW0QOfc6CeeZdzIwUxKmM+Z+P2Q1yJpGCT97fc4Q
         In09wOVuLPSFYPFFAih0DXGhiQChT9zN0AXgt1FCYwagwkgyxjY/j9ReH/b6cNYPW4kl
         uNyAxXilk3u5fMiw45a51hOlPb2nh5WlbmxUp3+q3iqmQFl6JV8WLehebGNrPVDmQhcP
         vKQg==
X-Gm-Message-State: AOAM5314E5yFbq7sSNNN0TJrhjGzkzM2PN/juBP1fncAEbf8PvArFBn1
        NcKiVSG+ACWVXk35NP1aFww1cKdhY70=
X-Google-Smtp-Source: ABdhPJzEkBTV7QbTr5xihhF0v+GdFu8pZEdabzgr85UPpoKx7r+PITPzz0TlA5iZkmRW6C0Jwxiq1A==
X-Received: by 2002:a05:6402:cac:: with SMTP id cn12mr52634208edb.238.1620919224419;
        Thu, 13 May 2021 08:20:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gt12sm1948568ejb.60.2021.05.13.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:20:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] doc: add an asciidoc helper
Date:   Thu, 13 May 2021 17:17:33 +0200
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
 <20210512222803.508446-3-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210512222803.508446-3-felipe.contreras@gmail.com>
Message-ID: <87bl9esls8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 12 2021, Felipe Contreras wrote:

> The hacks to deal with interrupted builds is scattered throughout the
> Makefile, but not everywhere (it's not done for techical/ and articles).
>
> It originally comes from f9dae0d3e6 (Documentation/Makefile: fix
> interrupted builds of user-manual.xml, 2010-04-21), however, that
> description is not correct.
>
> asciidoc does actually remove the output file in case of an exception,
> but there was a bug that handled keyboard interruptions through a
> different path, and thus in that particular case the file is not
> removed[1].
>
> We shouldn't overly complicate the Makefile due to bugs in asciidoc.
>
> In order to keep the Makefile clean this commit creates an asciidoc
> wrapper that does the job of tracking the intermediary output.
>
> Once asciidoc is fixed this helper can be safely removed and there would
> be minimal changes elsewhere.
>
> It's written for bash, but could easily be modified for something more
> portable.

Both this and your first patch could just be made to use the
.DELETE_ON_ERROR flag instead, although that's a bigger change.

I had this and a related series for that recently:

https://lore.kernel.org/git/patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com/

I don't think anyone had an objection to using that, I didn't pursue it
because I was trying to make (among other things) AIX development less
annoying, but Junio didn't like the -o $@+ && mv $@+ $@ pattern for
object files, so I gave up on pursuing it.

But if you're trying to address this "maybe it errors" issue then
.DELETE_ON_ERROR is a better solution.

I think if we use that we should also undo your changes to use "-o file"
and instead pipe to the file ourselves, otherwise we'll probably have
cases where the program that fails and GNU make will race to delete the
file (but I haven't tested that case).
