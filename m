Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545E41F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbeGKRns (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:43:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36825 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbeGKRnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:43:47 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so50788439oie.3
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KGC3uLaiJEUI8LsbZsNFozpEFGrk7eqz2Zqlg2o5Dk=;
        b=evDfSWC5Sa3CPVs+PjY4sR2fd0cjH2JzgDq0n/gtbJG89WAliJBcNFUEkptr9t1Nyr
         lt7qQrsaH0ld595e+renKML7brKonNwdPrKMy2PA6yqy+b0e0d8gOanOS9XsGCmWrgMO
         m7T5uHQuO/DoWFZD94HzKhcQfk+Cra1NgW/piRDzvjn5lgxRUZNCvWK5riTr02orXC6V
         eEbV7PWhDxHJujZfC2bR/Opcdjr/3COHDZ9Tsqh+HGccdG9XHmYlsqRr3nR88yl4FJZ8
         v9bgvbPocnxmA+47axnqndQkQAr1jQcuz4tQ9fVPwMr/AMkNMllb37xnLGiMRNEzys3O
         9X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KGC3uLaiJEUI8LsbZsNFozpEFGrk7eqz2Zqlg2o5Dk=;
        b=ICZnwGJ84S0LED2/j3uyMrl1CGhN4xZ8fDcu5gv24Euq1DvoPrb3QOutWaXBscazmI
         MHN+8qo+IDAO+uf6YO7uV7BD38c4MaCOL6Jr9sph9sLIcvMns5zPUbxkdFMyEXo2VYe9
         OSrXYSUuqAxU80Ccf8CeodNEhqcDFkNVgpLNZc75QXsPOwTeNegozkIUlom6ZNIuO4vu
         lzLxpzA+AxG5o7AP6z8KVD2hYiQJv0Ux5B+DtQGxE6XUHrsB6clsii4CFKHDUtr0Y945
         Dge4QuQrL/KRWKbvpcNwvvXMXFqVNhpwkUEeXfA1NGpBWjGA2tZo8jJ9ud39qVipVRxu
         9c8w==
X-Gm-Message-State: AOUpUlGtq5rFY6m9uqm9gonxxr7cbKneksQbAGRVX5w/kWSG+/1RxXKI
        d3QMXRU8ScAjAGcgco8GCepG3f/YtnTfcQHNjZA=
X-Google-Smtp-Source: AAOMgpfM0dQK7wBypeOZUSIir4dutblOuClSdAeBsyTa72wdoM8bmcblnKByxhYnFswgzBw1qyxd97vOoU64F762h+M=
X-Received: by 2002:aca:d452:: with SMTP id l79-v6mr241216oig.222.1531330704977;
 Wed, 11 Jul 2018 10:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180710154106.5356-1-wchargin@gmail.com> <CACsJy8CBJvpKAAtVjrdcuO06WossxcMmqwmSRL9Shr7g+qVySA@mail.gmail.com>
 <xmqqfu0p3czt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfu0p3czt.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 11 Jul 2018 19:37:58 +0200
Message-ID: <CACsJy8AMwKHUyUe-4-MKLn1D3x-+iiFW-Wdjj+HeX_JZ=MkO+w@mail.gmail.com>
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Chargin <wchargin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 7:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> diff --git a/sha1-name.c b/sha1-name.c
> >> index 60d9ef3c7..641ca12f9 100644
> >> --- a/sha1-name.c
> >> +++ b/sha1-name.c
> >> @@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
> >>                         struct commit_list *list = NULL;
> >>
> >>                         for_each_ref(handle_one_ref, &list);
> >> +                       head_ref(handle_one_ref, &list);
> >
> > When multiple worktrees are used, should we consider all HEADs or just
> > current worktree's HEAD?
>
> Does for_each_ref() iterate over per-worktree refs (like "bisect",
> perhaps)?

No.

> If so, then looking in different worktree's HEADs would
> make sense, and otherwise not.
>
> I would think that the whole point of detaching HEAD in a separate
> worktree is that you can avoid exposing the work you do while
> detached to other worktrees by doing so, so from that point of view,
> I would probably prefer :/ not to look into other worktrees, but
> that is not a very strong preference.

Yeah at least for me worktrees are still quite isolated. Occasionally
I need to peek in a worktree from another one (e.g. if I want to run
tests on current HEAD but do not want to wait for it to finish, I'll
make a new worktree, checking out the same head and run tests there)
but it's really rare. So yeah maybe it's best to stick to current
worktree's HEAD only. At least until someone finds a good case for it.

> If peeking all over the place
> is easier to implement, then a minor information leaking is not
> something I'd lose sleep over.
>
> Thanks for bringing up an interesting issue.
-- 
Duy
