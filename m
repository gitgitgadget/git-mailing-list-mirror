Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5004C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B585206F5
	for <git@archiver.kernel.org>; Sun, 10 May 2020 20:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6vjyMN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgEJU0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729124AbgEJU0g (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 16:26:36 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C7C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 13:26:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q13so6285379qtp.7
        for <git@vger.kernel.org>; Sun, 10 May 2020 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=Tdl3rEF0VG+QdYSTLLmSIYJsE3A8KnXoLrW4C1lJg20=;
        b=a6vjyMN87JKJXuvNc1kEHua9qEPZKClXh66+AtL8r96weFAJZsHSx9Wl8zDNjgejSP
         l0fv7jWyGrarsCcWvptrSjdKgae074GGZdFprhbpdTLUq+4CZA0PX+Yp75zSHpaWunT7
         1xVWDSokOLf3/yzmrQ9wc4rROY6TD+XmWj6Wd56RMwwWhvPds9oYEDfZinwSa5u0qT7u
         8AOVaR1aQwCRh5JgVAsWYZqQwAn/79BW14Mm03gGUnX6D/cdHZAyiC37+ZhvW8/ZGPxD
         A4VrjUlOKvM7P8Ad9jSJ1D1M32SAZdVtxgZOkCwmIiscBDQ40GTYfHLVsAF0EUU9kFFl
         GHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Tdl3rEF0VG+QdYSTLLmSIYJsE3A8KnXoLrW4C1lJg20=;
        b=oRR2RKid31hpLm7Haomp2+I7l3Rc3Q3k1RN11gYDT5EqRwKhUpetvx4MpgvjXl4z0F
         2a616n1FwflCZ+YWOYZXHydW7SNCrW2SRIaMO08A9jvByA+QWq8hwrhYYyQiFB3CEef0
         /vuykiAw7quexdnU5Znpe3ci7Ea83cEnA/2KBbAhbuDVndhnRIo0Z87QtC7hWEnQINOw
         tTNVfRSJlNlmL2KMw5plVypEXFIpsb4kv5SxGcpO+aaOctR/L9rmokVqRBtzozIVrnIy
         nSw/yOeWI1X9EvkyzOwpK5znEGFJc+nYpBLNWO/uWsSX8PfgdKqdswquknr3lGWviXc0
         sXlQ==
X-Gm-Message-State: AGi0PuaLJsvGzS0qfKyqSNc5HGvdvGaBRClcYfDn1blTJEoGycbE9Lu/
        7RplhgzibLN1MkquWDbmsZ+NVXzOcCk=
X-Google-Smtp-Source: APiQypKNa//QQjMGnDTAXaK7XPlLNI9ZarjbhwESrBr4VrTjpTo4rHpug6Mu4SSICxU7bLJekNL5Wg==
X-Received: by 2002:ac8:1757:: with SMTP id u23mr13263768qtk.138.1589142395247;
        Sun, 10 May 2020 13:26:35 -0700 (PDT)
Received: from ?IPv6:2601:741:8000:12fa:e9c2:7999:c59c:2067? ([2601:741:8000:12fa:e9c2:7999:c59c:2067])
        by smtp.gmail.com with ESMTPSA id j90sm7355470qte.20.2020.05.10.13.26.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2020 13:26:34 -0700 (PDT)
From:   Benjamin <ben.knoble@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
Message-Id: <4CFBC77A-6518-4BEE-A210-6A7C818B9738@gmail.com>
Date:   Sun, 10 May 2020 16:26:33 -0400
Cc:     321.george@gmail.com, git@vger.kernel.org, peff@peff.net
To:     gitster@pobox.com
X-Mailer: Apple Mail (2.3445.104.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio writes:

> I somehow doubt that users of vim types "!git jump diff" (or
> whichever submode they want) from within vim's command prompt;
> wouldn't they typically wrap the invocation in a vim macro?

Vim-user here. I run "git jump (options)" from a shell quite a bit, but =
when I'm
in vim I tend to use ":Ggrep" and similar commands from the fugitive =
plugin [1].
I don't *think* I'm alone in this.

I'm not really arguing either side, just pointing out that other =
workflows exist
(and indeed, I'm unlikely to run ":!git jump diff").

[1]: https://github.com/tpope/vim-fugitive

D. Ben Knoble=
