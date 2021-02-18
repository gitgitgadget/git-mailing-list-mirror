Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E528C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA3864E68
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhBRGw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 01:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhBRGpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 01:45:21 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41388C061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 22:44:41 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y25so643616pfp.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mipy+MHf+LbvHUb11ezhwSbbjrgC0JRZH/InV9ZjLzM=;
        b=e/sIOE1LCj4JtjUSOydAGRiBS4A4c78hUlELt90YgvJEBuFEEMWP21nUh3xvCPOQnw
         t86IF3NWWJ7UvSp8mumcdTqyW1/s/QtkTSHesleZxdqtHPy0hCyaHw7CXkvgCwp7XtIj
         F+MwVfU76euDyQobUj/ajx50OAhqBDBQ/bynmayW9yGJstqOby/nbi2VxhaYQHXpOC7p
         mcmCZmPQReOewamdKDMOcxyYHF/h+OvyU1pzdb55ODX7uxEvvgT61u4c9YUCoXPXt8//
         v7BQn4MdTyCOQtS2LhTLUypeI+1I68B9k4vVdQS2joe+GUXDjSyLEQxCVS9x09ZwKRP1
         zfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mipy+MHf+LbvHUb11ezhwSbbjrgC0JRZH/InV9ZjLzM=;
        b=lrmZ5qw7EZXoKRw1W9INrRFWGQYDPPiqPYUQlAqHtLESk+p2eGofp8la36epTZwjbY
         OvLPZiAsoof2X+kkJKPlAhtRc/N3nvHM+w/KocV69x4dMgsIHhMaM6GRUXBxyWBC6iuo
         XImlyeD8uFaSSdgzKrkUzKt1nQar8zja++jvpIGgSxpBCSmov7uLSHB/SbZfSpVUg9b7
         1weB1zvex54vg7Kd8Y7lUb5RMaxTvCWaaVc3ZRdJJlh/UMk11ujcAEByGwpVl9i7kkRW
         2PtLnOabRWOCOgrswYw6sUjrmjBht3IF2kYRXaBLLbeAhivqP+PU4mJS2HNjUPkuItiG
         M1yQ==
X-Gm-Message-State: AOAM531AdzOmnWY0Z1MlWxgbCtV+b9QGYNgDA0vSUe7gyfNa2c9Svf9i
        hPRW6LbQRBkqM5k+68Gbm/O7vSDQEMu2kPD7MbdEW6F/oes=
X-Google-Smtp-Source: ABdhPJxrWHLfGcjq7TZl3+zDvmxjmnUXu/nccmSzx9+6Sa8hx8FKw1OOIKlpH+vETRAkVO0RIFQjxNUk4ilw8aoiRW4=
X-Received: by 2002:a65:5b43:: with SMTP id y3mr2830897pgr.415.1613630680730;
 Wed, 17 Feb 2021 22:44:40 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1legm5v.fsf@gitster.g>
In-Reply-To: <xmqqr1legm5v.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 18 Feb 2021 07:44:29 +0100
Message-ID: <CAN0heSqHLzGSZ87GLo8dm854ZOMONCv0c69YFX_=40q5wG66JQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2021, #03; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Feb 2021 at 03:13, Junio C Hamano <gitster@pobox.com> wrote:
> * ma/doc-markup-fix (2021-02-17) 2 commits
>  - gitmailmap.txt: fix rendering of e-mail addresses
>  - rev-list-options.txt: fix rendering of bonus paragraph
>
>  Docfix.
>
>  Will merge to 'next'.

Thanks for picking it up.

It looks like you didn't pick up the middle(!) one, "git.txt: fix
monospace rendering". I thought maybe you queued it somewhere else, but
I can't seem to find it anywhere. Chris, and later Patrick, had a
question about it, which was maybe why you skipped it. I hope I've
resolved that confusion, which was entirely caused by my cramming
something too diff-like into the commentary of the patch.

Obviously, that patch 2/3 doesn't need to go in the middle -- it can
just as well be at the top.

Martin
