Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E111FC352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 00:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D7320715
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 00:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFueQy7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBKAJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:09:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42332 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgBKAJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 19:09:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so2542758edv.9
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 16:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPJgfTpl8iMr2nyb/GaA0/BECxZv9+p/MVcjk+l3jz0=;
        b=UFueQy7NnIse2HuO0L+W/xixEFTiFclfpeHVN5admF/dFQ+7YPP3WOpFTiMhmy+WT9
         paEPCDetEV3WMIfi2ICSCF8WaXZdoCkTYt1dGS27umfdupR4F5cB7DxHBCV6Iwn3sQIx
         y1Un9eC7hDPYWAdaiWXZuvaLOMFd2xIqsvzvrz0sSsfSpwU03J0P2qTa9gbUTZ76OUax
         0HXjDusg+9qvR+6Gukiv7YfAQRnA7HifhUEPEkxl0exDQxY+0RRt0SLAq4uKY4wnh46F
         ohpeMIbufPava2LDciPg5tJ29BnRjq5D5L6tb8ihDYELdQb9Bb5RtpFDrB/lppaMss+v
         TeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPJgfTpl8iMr2nyb/GaA0/BECxZv9+p/MVcjk+l3jz0=;
        b=QVkd0lKYY1f3pn9NQfbY8/ApksS7qTiE0HF//uTvGF/5EjTVYZ5ngqcT5ODhxBEvCw
         i5mJiS2rWb0ZRCfcOkFo+nXLfwoCRTrMzXxGg/HL5VfKXUUFYaCVJZQZ3QHuvXiBgZ43
         cjd7jn2AWG9I7v8JXg7qyhi/DHZqBzZUFEOpw7Jel0YX+418dGOIOWEMO9scyOQlMlRq
         Pw4qd8lVQ4IBvIXjmeK9347DVDAo/WKSdaB0eOz7SyqLi6k/TWMz7IhnnrfV9VARsZbY
         J6SE5IiQRWQ/YGogRBKliLHqCsM07h8eNYxl2TFdhFThFsx6823Owx9T/shnOHFeO8xy
         MsQA==
X-Gm-Message-State: APjAAAWkM8hfcv7Qd1TGKvNbow8YUEP7habdoXWeUSa5TV6GrL7Ks3+l
        fhbSMMSMbPMb97wDF/pmNvhIBjFlr5iLcbKRZyM=
X-Google-Smtp-Source: APXvYqwE1Wl+kj8XoY4AcrvuquKMD9JhMb8HQ83fKPWivyaMC+GIwS1mV9TdkWdyEycFSkbI3qoYGWs8U8UT/ZUJxhk=
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr3522984eje.276.1581379739425;
 Mon, 10 Feb 2020 16:08:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com> <xmqq8slaz1cp.fsf@gitster-ct.c.googlers.com>
 <20200210194253.GA46461@syl.local>
In-Reply-To: <20200210194253.GA46461@syl.local>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 11 Feb 2020 13:08:48 +1300
Message-ID: <CACg5j26ROdUAqCNPMRoORweEEDaUyeZvSPKS0bYLt9qYART4bA@mail.gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 8:42 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Feb 10, 2020 at 11:30:46AM -0800, Junio C Hamano wrote:
> > Another thing.
> >
> > advise_ng() may have been a good name for illustration but is a
> > horrible name for real-world use (imagine we need to revamp the API
> > one more time in the future---what would it be called, which has to
> > say that it is newer than the "next generation"?
> > advise_3rd_try()?).

As I mentioned earlier, this patch is meant to be used as a transition
between the current advise() and the refactored one.
So the name is just temporary and it'll be renamed to advise() once
the transition is done.
But if we want to keep both functions, or want a better name because
it's an open-source project and the author might not complete the
transition, then I'll try to think of another name.

> What about calling this new API 'advise()'? The first patch could call
> it 'advise_ng' or whatever other temporary name we feel comfortable
> using, and then each subsequent patch would update callers of 'advise()'
> to use 'advise_ng()'. Once those patches have been applied, and no other
> callers of 'advise()' exist, a final patch can be applied on top to
> rename 'advise_ng()' to 'advise()', and update the names of all of the
> callers.
>

Yes, that's what I would like to do.

> This makes for a rather noisy final patch, but the intermediate states
> are much clearer, and it would make this series rather self-contained.
>
> On the other hand, having a version of 'advise_ng()' on master makes
> this topic more incremental, meaning that we can pick it up and put it
> down at ease and have more self-contained projects.
>
> I don't really have a preference between the two approaches, but if we
> go with the latter, I do think we need something better than
> 'advise_ng'. Maybe 'advise_warn'? I don't know.
>
> > Thanks.
>
> Thanks,
> Taylor

Thanks,
Heba
