Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B2C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3E2077B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 23:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz7RwtLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgAGXdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:33:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43137 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAGXdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 18:33:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so1023918edb.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 15:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEOqh7sGisMwv7ZalPfdVElDVARDPtQ0o1L3zbmA9Fw=;
        b=Iz7RwtLiQmpO2rZU3//aAm1550IY8xsThRB7L5Q7qzKETSlt39uQBAv1eERC83McAO
         oqb07emGjT3zr95C+RAvC0W7+2J5fh/F/bis9TxjA1JW5CAPi2//yzafnL4V+/KsThIl
         Wck/6uy3DO8s25GRtBOdMQv2CKggwbW6o8hMnO8GF/nazFh/g7BrjBKGOKJJG5P16QJ3
         Exy09P6x7iT+0fzEPIOVgjcd3OCVaQF3y3NEDDTFpZy4CJnkUM8o+pp/RvM0ShcDjmqX
         rdMGsadOv1sWa4YxMWlcfwIl+EGGVOWKh+IEeRZ/+MvsqMpadXhgMpxNI4gT37R3+xBf
         G72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEOqh7sGisMwv7ZalPfdVElDVARDPtQ0o1L3zbmA9Fw=;
        b=gaMzEYn9UU0NRKRsql0C+oicGmtoJdC/8zyKH4L7zf9ptdk4ft9/d8Pe+NEBHphNj7
         oDOgTc/E7NpFu8mmMdWLnVwJMe6ugibHkNzubYOn1niY5mdn7Mij09wSKvLg3tlOFqvB
         5/aGA6xiJD9XeDGnwgBAAZ0TWYg6mWAmJPbW9AkH9KHDTDiO+GG9CfQLqCW6gPBnks70
         iA6NiYtEymQtYZCD5oOL3oAIZojlqGNOT0bW6odAv2YAUGYWxlRi4vk9qCdb1t4gi2Jp
         v1tWm4auvZzPYD0yvrCZVMgBcXCb8Oy+NLXWM8ajapdaMowTg0YuZyEZu9CTgaWtQciz
         dyCw==
X-Gm-Message-State: APjAAAUImvD/q8zVUtBqxvOdMGWxKE6z8P0U5lOQcxbh0rfW0hjlkmA2
        AiwBn4wLmvtIGe/Bp2y6cpJEhm3cK93ykw8Mrl0W9pOd
X-Google-Smtp-Source: APXvYqyimUMqeO/pqnV17lv1YDQZDsTEQPqdlhdmGVFsK60ImCv+1b7vid6jbjkD3fdR/LBSsy3TuOTO6r286maZVxM=
X-Received: by 2002:a50:cb8d:: with SMTP id k13mr2617261edi.284.1578439986709;
 Tue, 07 Jan 2020 15:33:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
 <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
 <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com> <xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com>
 <CACg5j27ce5BfR9RKekMEXokvCnXiXzmCVsyEKce+HORe8kL_GQ@mail.gmail.com> <xmqqd0bv6x79.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0bv6x79.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 8 Jan 2020 12:32:54 +1300
Message-ID: <CACg5j250nynzUwjfn6zOGt2-RNJxWYry6ycbm9dBUCTFo7MJ3w@mail.gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 8, 2020 at 5:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heba Waly <heba.waly@gmail.com> writes:
>
> > On Fri, Jan 3, 2020 at 11:48 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> > That's a valid suggestion, I can investigate that in a new patch, I'd rather
> > keep this one as simple as calling the existing advise function.
>
> Yeah, the side note wasn't even a suggestion for improving _this_
> topic, nor even specifically addressed to you.  Let's stay focused.
>

Sending out this patch, not only do I want the community's say in using advise()
in add.c but using it in general in more locations where hints are
displayed using
printf() or any other similar function. So when you pointed out that
it's not supposed
to be used without checking the corresponding configuration variable,
I had a similar
thought to yours, that it can be improved.
Accordingly I might be interested in looking in to this once I finish
what I have in hand.

Thanks,

Heba
