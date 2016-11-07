Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8532022C
	for <e@80x24.org>; Mon,  7 Nov 2016 10:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbcKGKEY (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 05:04:24 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35580 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbcKGKEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 05:04:23 -0500
Received: by mail-it0-f65.google.com with SMTP id b123so3113519itb.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 02:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dck0TU3qquxZ9dRKoYitdY47EFu60NVuReYSXqbirBc=;
        b=kRlGUpfucgEt0K7Nm1k7xnW7GwyeKojOWYwlVGL3x/jDZ/GXJRO2SQ/R82wLSFu/xi
         SuXxUQrcR4EYTlPj3R1NnYltXcTqbVxPfzOlJpRyxSrfh54thM1PwoQobZ/QW3FUJNpE
         rjWnXcrSmI1s7Kwfjcoc+bQMvUuubvw2TscP37uIBWlMqpD2c+0ZkEjhS5AY8ti0k6VS
         yOGXFbrbauzLlz9VGNprItkRoB5HdKt8z8IK+fU0b4kSH4D1h2ORKSsklm8w8YTR+FCD
         aEYI/sCrK34rd+CphDB4L2F814+y5bNLr9jhAcWvqo3+KGvLPSlTTG9IH/WZ+kY0ajBc
         0Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dck0TU3qquxZ9dRKoYitdY47EFu60NVuReYSXqbirBc=;
        b=D9siQ3vTKQFxonPWyGChp2tQjEz96XvMNZmJsHkhFwwDw8YVdmXhNlB+GsYCYavKoA
         +fFqYxSM07IZFLEeoeJP5NgxmKGTYWojzEHSFh8eQ5GcNAaWyCeAnL95BxpLagy+tYKE
         a9OIgiCDJx1PApwhG1tyDS0ENWzahGSq/gHOYr264ODQbl+fv0pxCP8pGUYXWCrPl03L
         ETnAQywNGyMz0qIB4u0H0p5qzI1r8NZslP781d025Jzfr1eQwoxmOUsPw3kg1AG5/tM8
         0ShC92sLZBu2soiDZjB89RzuhDqwyXGpg0yLWMJi+yHGRzZQ/nao2859oT9icy7j9z8T
         WKsw==
X-Gm-Message-State: ABUngvfk4jXbnZr+YB4+gfareKyakXz8Y0E7nKcBT7VSUn+7ZMnfrKTSRlZFFBxoLtrBw/LrGK1FHX56OPoruw==
X-Received: by 10.107.44.137 with SMTP id s131mr6384469ios.212.1478513052984;
 Mon, 07 Nov 2016 02:04:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 7 Nov 2016 02:03:42 -0800 (PST)
In-Reply-To: <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net> <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 Nov 2016 17:03:42 +0700
Message-ID: <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2016 at 8:08 PM, Jeff King <peff@peff.net> wrote:
> The attributes system may sometimes read in-tree files from
> the filesystem, and sometimes from the index. In the latter
> case, we do not resolve symbolic links (and are not likely
> to ever start doing so). Let's open filesystem links with
> O_NOFOLLOW so that the two cases behave consistently.

This sounds backward to me. The major use case is reading
.gitattributes on worktree, which follows symlinks so far. Only
git-archive has a special need to read index-only versions. The
worktree behavior should influence the in-index one, not the other way
around. If we could die("BUG" when git-archive is used on symlinks
(without --worktree-attributes). If people are annoyed by it, they can
implement symlink folllowing (to another version in index, not on
worktree).

The story is similar for .gitignore where in-index version is merely
an optimization. If it's symlinks and we can't follow, we should fall
back to worktree version.
-- 
Duy
