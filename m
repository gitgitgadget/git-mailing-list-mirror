Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215C2C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4D061A55
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352600AbhJAHwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352547AbhJAHwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 03:52:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357BC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 00:50:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dj4so32545211edb.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 00:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LA0Uipf/9ju9K3K0+LTYSyLiR1qiQ0ntJv0wuZ9JV6k=;
        b=B3SAEZ9xTlp+i/p5LUgODiEYDo95+7ULMJAVLJ6vn99ehv5FpR3ODoEkGxSXGX0hwb
         zHFxpNgxQlB07ao8OmFEXMG/VKzAbOT6J5e1PcT2lPok2NR1nKUDlTMEU4chqX+BsHs6
         YvSYzJPxWb/VqkkfRdNZ2eJN2NRRO9ohvMOWEx5WRqDqFnxWhgJtiKZJ82vH64azpSDA
         iuiXIAQhafvlidnOLRYIREIJgN+/SuUfVRHRAn1SnnUu4da6m5A0tRMKjfADRFCHvteR
         X/RMtk9ufpoAKw/U2R+GZu7VgNJoYl1Mnl8mIqgDp32xiMMDNsi+ZXh5yTzHNhtTOH6E
         sNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA0Uipf/9ju9K3K0+LTYSyLiR1qiQ0ntJv0wuZ9JV6k=;
        b=v+1Smv2yZaXwp+36lj4k3/Jb4jd7Cvx2WKP+YRkbG51BSn83b6l5CzsnXhvYhDfpMZ
         7IRcHGq7ylHu/skvk3Ej3W5oHws7Ydg9S8+JahjuhUJvcm5EbEfl4xnJ85SR8B78w8Hx
         /T6O80b8EMk3vWomaS8Q/oRcYFD6+Zvh6iBWfQuZqk5iJoaNu8EOWrD0vHvQNAs6ZfEo
         eshE6wPo/wDY11ARL+8BGqmY6GFEj87VmS7JbVTCidPIgNNnjpQUl6q//Nj1bQBR+8Oj
         /75T489RX6Oylegf19SUb4ILtfRiCt+ft/xdMxvsOQ+QOXfwtlFOaQPdJV62SyDTZ5g2
         +5yg==
X-Gm-Message-State: AOAM531AUIJXyXfRgt6ZaUJPEXpqdcFDeElaE5K1fAWofnGnkiP0tCTo
        p7+zloLrxjpezygUQ7HXZP8JodNnA3PNMjnKCiw=
X-Google-Smtp-Source: ABdhPJziuQsvqsAhSwfWpqN09csdyu7Anpap9hKvF/8KnXKXycP5c+lVfZXmZfZZ0f3FDpw0uKnkF/+cO92autKRe/I=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr4453722eje.341.1633074626858;
 Fri, 01 Oct 2021 00:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net> <20210929184339.GA19712@neerajsi-x1.localdomain>
 <YVVyUkwYNfkEqNfU@coredump.intra.peff.net>
In-Reply-To: <YVVyUkwYNfkEqNfU@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Oct 2021 00:50:14 -0700
Message-ID: <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Jeff King <peff@peff.net>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 1:16 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Sep 29, 2021 at 11:43:39AM -0700, Neeraj Singh wrote:
>
> > It seems to me that one problem is that the new "primary" objdir code doesn't
> > disable ref updates since the GIT_QUARANTINE_ENVIRONMENT setting isn't set.
> > If we fix that we should be forbidding ref updates.
> >
> > I've included a path that fixes my test case. This is on top of:
> > https://lore.kernel.org/git/CANQDOddqwVtWfC4eEP3fJB4sUiszGX8bLqoEVLcMf=v+jzx19g@mail.gmail.com/
>
> Ah, right, I forgot we had that "forbid ref updates in quarantine" magic
> (despite being the one who added it).
>
> I do think this improves the safety, but things are still a bit more
> dangerous because we're handling it all in a single process, which sees
> both the quarantine and non-quarantine states. I wrote more details in
> this reply a few minutes ago:
>
>   https://lore.kernel.org/git/YVVmssXlaFM6yD5W@coredump.intra.peff.net/
>
> (sorry, it's long; search for the paragraph starting with "Whereas doing
> it in-process").
>
> > When creating a subprocess with a temporary ODB, we set the
> > GIT_QUARANTINE_ENVIRONMENT env var to tell child Git processes not
> > to update refs, since the tmp-objdir may go away.
> >
> > Introduce a similar mechanism for in-process temporary ODBs when
> > we call tmp_objdir_replace_primary_odb.
> >
> > Peff's test case was invoking ref updates via the cachetextconv
> > setting. That particular code silently does nothing when a ref
> > update is forbidden
>
> Oh good. I was worried that it would generate ugly errors, rather than
> silently skipping the update.
>
> > @@ -2126,7 +2146,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
> >               break;
> >       }
> >
> > -     if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
> > +     if (getenv(GIT_QUARANTINE_ENVIRONMENT) || !ref_updates_are_enabled()) {
> >               strbuf_addstr(err,
> >                             _("ref updates forbidden inside quarantine environment"));
> >               return -1;
>
> I think the overall goal of this patch makes sense, but this
> conditional, along with tmp-objdir reaching out to the refs code, feels
> funny. Should we perhaps have a single:
>
>   int tmp_objdir_is_primary(struct repository *r)
>   {
>         if (the_tmp_objdir &&
>             !strcmp(the_tmp_objdir->path.buf, r->objects->odb->path))
>                 return 1; /* our temporary is the primary */
>
>         if (getenv(GIT_QUARANTINE_PATH))
>                 return 1; /* our caller put us in quarantine */
>
>         return 0;
>   }
>
> Then it's all nicely abstracted and the ref code does not have to know
> the details of GIT_QUARANTINE_PATH in the first place.
>
> If you do got that route, the strcmp() might need to be a little more
> careful about whether r->objects can be NULL (I didn't check).
> Alternatively, I kind of wonder if "struct object_directory" should just
> have a flag that says "is_temporary".

Actually, wouldn't this be the safest approach, for my particular
usecase?  By having the quarantine in place, no refs will be updated,
which removes the risk of new refs mentioning objects that will go
away.  The only issue that could arise would be from new objects
referencing objects that will go away.  But the new objects are also
written to the temporary object store when it remains the primary, and
thus those new objects will also be deleted when the temporary object
store is.

In contrast, moving the temporary object store to the end of the
alternates list would allow new objects to be written that reference
the objects that will go away.  Using pretend_object_file() will also
allow new objects to be written that reference the objects that will
go away.

Said another way, I don't think anything should be writing a critical
file that needs to be durable when we're in the middle of a
"read-only" process like git-log.  The only things written should be
temporary stuff, like the automatic remerge calculation from
merge-ort, the textconv cache optimization stuff, or perhaps future
gitattributes transformation caching.  All that stuff can safely be
blown away at the completion of each merge.
