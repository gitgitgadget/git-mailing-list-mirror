Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9769C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEACD60F58
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbhHETHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhHETHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 15:07:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489BCC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 12:07:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x14so9811147edr.12
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=i7EQPUFCBbqSvKGD8hHvo8Ndl8YMs49qnSdDohDsuls=;
        b=CxPpmtmmxPr4z1wl8v0Ra/Kn0EcApOu3JHLFpoaZgkwEgGzfxzElXxEag53PuCG7tH
         dE2NKTkQSw5zMCJNKauijkRoPhMJ7KZP2JmeUljwf1WUTOtokCOqcCwJFLEXcvatddi+
         ALYUyJ7eh4yxMJ2tZlVLwpqyx3tKq71ZaSfBZ9nqB3WzTW1MGHqL/oxrKgyC0HoXhAJo
         zfilHEWoymZY0TogFZ8JQV4Vh4nE/5Eyn5BKvOJFvIoRwcXApt5nTwTMhDFVcxr3hhTo
         M5S5KamfoAoqRMLSLfXJGxOf5wczQZoV1YPje0Waou1hUK5++ScyzN5hgREuIo/UiYdr
         esUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=i7EQPUFCBbqSvKGD8hHvo8Ndl8YMs49qnSdDohDsuls=;
        b=jkbFTeaDnTF8EsDGFC4uD+mE4syY/r4X16mqlF8YkqXYsszi/nE1c6KQ9pIQXkEFge
         iVMRAyiumyJtAompTzt3ISQfM0Kmo2pSE3yTPUygLXjYgF3aYDAP46XayUEYgtRfMnVL
         3rup3XHdQamhHmAUZJGMGugzlkFwyr95MAtP7vQckGluqLgFh6QOO3jQVlglCPUXUiD7
         ObNZZ5QTe5W3PtNQce8/ppTB4JUwCt798EeNY7NVhFMmQtCDEuIdoEO/tdnpbXQGOe7U
         9nOw6yOkOTUWvgfxKu0q+Ex59oX2EuT6iKsuk0ehWaibg5gCtxQ0hbKhYcIULDMjaSpA
         qYiw==
X-Gm-Message-State: AOAM530ajYT9ivG63tXJECEsQ9X4GtVruYNyYpYeTs35LdVj151RmghM
        Mlc8YWy5ui532qNZU933uME=
X-Google-Smtp-Source: ABdhPJxN6HoLwdU639u7bF77lEBHsHAzI39lneTu2pgJAjgh+xYIyGmJqLSF0JU6Le3iMcvXF/0k9g==
X-Received: by 2002:aa7:d519:: with SMTP id y25mr8313201edq.191.1628190445689;
        Thu, 05 Aug 2021 12:07:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ju5sm2009983ejc.8.2021.08.05.12.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:07:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
Date:   Thu, 05 Aug 2021 21:05:59 +0200
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
 <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
Message-ID: <87y29fzp5f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Jeff King wrote:

> [...]
> If we don't go that route, there's another possible speedup: after
> parsing a tag, the type of tag->tagged (if it is not NULL) will be known
> from the tag's contents, and we can avoid the oid_object_info_extended()
> type lookup. It might need some extra surgery to convince the tag-parse
> not to fetch promisor objects, though.
>
> I'm not sure it would make that big a difference, though. If we save one
> type-lookup per parsed tag, then the tag parsing is likely to dwarf it.

Except that the tag type can be a lie, as our tests and some recent
object/fsck serieses (not yet integrated) from me show. It can be relied
upon for >99.99% of cases, but code like that needs to make sure it's
not segfaulting or whatever if that relationship doesn't hold.
