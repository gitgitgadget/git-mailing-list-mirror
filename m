Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33364C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6A960F6D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhIUBpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhIUBkP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:40:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80D7C0818CD
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:44:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t6so66388484edi.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xXUOQz7cqhAJPfbnRB4pIs0n4LwNUWt0HXSYfxp3PRk=;
        b=Xx/dTz7z0Zj5IHbne8/7ReXUzmheNywhzsWALRuNNJqR161h6oBV3Gmwyd3eogjy99
         29OOXrwOGPKV0LYD9YVL4xItszpQ9kT2r5tp43xzE6ybvJwku/oXU6/eRgxU/R5w3TWZ
         NxeNVZ5Yazckg09EnHQe78J+odYbXNp/5HdQNSRInzfr+ouf6WHRXZp3wXa090mYMn4i
         VAbegL1aGs6SYfAu28c7vgh/e6/N46LBlxQIu3E/mIFYwUWm6q1juupdtZk7p85vZj/X
         RzGXCw6NPwOz7pOoCRThbjDtwJhLIV/UG/Nyex2CaU7oS9qKoHuj+JAVfVZvn+qlMf5R
         IN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xXUOQz7cqhAJPfbnRB4pIs0n4LwNUWt0HXSYfxp3PRk=;
        b=1YiOBY7Ei8ATjcWmIQ3bcDgIMsC/MgO9B2D1pj8uLOZ3aQA0k/8x4H0i6AWMVXePwB
         T+7hkL2zIxMo5gzE61GU8EnbRjOGhEW55vbGzk+SRZmY3VcESiyJbY/c/9mb45N4DgNQ
         8U47K/ybY6uaLjgtqUzNIPLCq6L4NOX7jwXQeQFOAqCriRYXcSRnVDao/DJluodawZG1
         ypbnENYyz3KujQ8zr5yhIvG3VtZID/US+/NlQqdsBu6jyi6MYHKry/4/cVS1SABz+1AW
         RsxaVPhlCp/lsHpe4RqevbMfsnJ7PTefBjsEggPcrcacXBp+gu6t8bSX8b/NAuxwRNel
         Pc4Q==
X-Gm-Message-State: AOAM531TS4frvbtT0eijSw35rMYB6jb1oDWXy0rT6IY5yfPSMfh3VTBt
        WJywzW7RzFaHLLJjOYlP4qy6NXnvSPgu5HVC4zk=
X-Google-Smtp-Source: ABdhPJxZMcXp6gFTzcxW9t3r3AVLS4Qygue8qt7C2PNakASRB6TLMJujjDymfzEpwGXwH0DEZtYX/r9EmJgsJBvmpG0=
X-Received: by 2002:a17:906:3fc1:: with SMTP id k1mr31888706ejj.44.1632174253222;
 Mon, 20 Sep 2021 14:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210919203832.91207-1-davvid@gmail.com> <xmqqmto7ay6s.fsf@gitster.g>
In-Reply-To: <xmqqmto7ay6s.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Mon, 20 Sep 2021 14:43:37 -0700
Message-ID: <CAJDDKr6m9kXKSuQhC5g_OkJa52QRMtf8s8Bd0YbRNnzAgudifQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] difftool dir-diff symlink bug fix and cleanup patches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 11:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> David Aguilar <davvid@gmail.com> writes:
>
> > This patch series fixes a regression in difftool that can lead to data =
loss.
> > The symlink-file writing in difftool's dir-diff mode has been fixed to =
no
> > longer write-through to the symlink targets.
>
> v4 with no backreference?  Do you have a message-id for the previous
> three rounds handy?

<20210919015729.98323-4-davvid@gmail.com>

v1 was dead on arrival so v2 was really the first. There was no v3 --
a different patch in the series went to v3 so I bumped the entire
series to v4.


> > Please consider patching older Git versions with the fix from 1/3.
>
> meaing 1/3 would be done on top of maint (v2.33.0), and the other
> two can be on a separate branch that starts on a commit that is a
> merge of the 1/3's branch into 'master'?
>
> Thanks.

Thanks. Patch 3/3 seems trivially correct so I won't resend that either.

=C3=86var had notes about 2/3 which can be split off to a separate topic,
so that's the only one I'll plan to resend all by itself --in-reply-to
that thread.

I see that it's already in "seen". I can send a replacement patch
shortly if that's not too much trouble; dropping "strbuf" from the
subject line in the commit message and the note about the test would
be good to cleanup. The strbuf leaks will be addressed in the
replacement patch.
--
David
