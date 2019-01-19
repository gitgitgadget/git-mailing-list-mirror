Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715801F453
	for <e@80x24.org>; Sat, 19 Jan 2019 01:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfASBrU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 18 Jan 2019 20:47:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38751 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfASBrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 20:47:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so12589312ede.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 17:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MWUUoDqp+MOO5c8cqWo3Co0KMJ0jZzAfnHG5BryL2h8=;
        b=N4qCo7/BVWTgniT1J9g6AiRw8rd7OG4oTtB0V+5AKD9VufdofX/n0QPtzGqILrjwaw
         76ww7Bbmq9kGpBCGf2jJjihog5KG7DlEO75UuUlVEHoQRVkfbP6erRAidnFMnH6dB5f1
         Mf2kLLyKGWbw20XsQ2rmJtnM1GrD9Qgx20kiSXjy6EW6MngTHbDtGfs3dxAt4zwvuaKE
         wq0XjN7Z9O7xON/VVUKvOuHYf7KOlm8bYexo1NKBdvajT8dIe/3nMUssr6/IPFz7S1D0
         CGCU/bEX9576yaAoaxTxRgdfPUPcO1wKQPZT0tOew/wki0Vb9U23pRQhzGRNxrx1rqYt
         QWPQ==
X-Gm-Message-State: AJcUukeen9J9E3rGwZK5te4oAsM88GyxgDHPSjBVNk5ErocxsT91dq8B
        JybL72WlB7sJLD/Ns/380BBlNFLZLQ==
X-Google-Smtp-Source: ALg8bN5P7Dc8SilG0bKHl82ZUEdzyyi5xJ44KRZ/YjLn8nkCmJXYXMGFsgagNSzo8ObI7jR9wDQnsw==
X-Received: by 2002:a50:9665:: with SMTP id y92mr17482181eda.282.1547862437976;
        Fri, 18 Jan 2019 17:47:17 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id o6-v6sm4179254ejs.32.2019.01.18.17.47.17
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:47:17 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id b14so12575504edt.6
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 17:47:17 -0800 (PST)
X-Received: by 2002:a17:906:33d9:: with SMTP id w25-v6mr16519096eja.190.1547862436757;
 Fri, 18 Jan 2019 17:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20190118022736.36832-1-phogg@novamoon.net> <CACsJy8CRQdzMTZU0Khno+r+kqrzu-iG5J_fKnPfVMWe55azD2g@mail.gmail.com>
 <CAFOcBzmCWBjng_HqFthSrg3eKcEHpQLaa5buKAcm8JHt7EsGdA@mail.gmail.com> <CACsJy8A-kk9DEPZKWR26ye5tUHjny_18xf69CUevpRLJrs19PA@mail.gmail.com>
In-Reply-To: <CACsJy8A-kk9DEPZKWR26ye5tUHjny_18xf69CUevpRLJrs19PA@mail.gmail.com>
From:   Patrick Hogg <phogg@novamoon.net>
Date:   Fri, 18 Jan 2019 20:46:37 -0500
X-Gmail-Original-Message-ID: <CAFOcBzmPAfq2ihF191KQAu0-_hz8DLdeAwDO-+gA-dR1sdND8Q@mail.gmail.com>
Message-ID: <CAFOcBzmPAfq2ihF191KQAu0-_hz8DLdeAwDO-+gA-dR1sdND8Q@mail.gmail.com>
Subject: Re: [PATCH] pack-objects.c: Initialize read mutex in cmd_pack_objects
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 8:10 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Jan 18, 2019 at 8:04 PM Patrick Hogg <phogg@novamoon.net> wrote:
> >
> > On Fri, Jan 18, 2019 at 4:21 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >>
> >> On Fri, Jan 18, 2019 at 9:28 AM Patrick Hogg <phogg@novamoon.net> wrote:
> >> >
> >> > ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> >> > 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> >> > introduced oe_get_size_slow for thread safety in parallel calls to
> >> > try_delta(). Unfortunately oe_get_size_slow is also used in serial
> >> > code, some of which is called before the first invocation of
> >> > ll_find_deltas. As such the read mutex is not guaranteed to be
> >> > initialized.
> >>
> >> This must be the SIZE() macros in type_size_sort(), isn't it? I think
> >> we hit the same problem (use of uninitialized mutex) in this same code
> >> not long ago. I wonder if there's anyway we can reliably test and
> >> catch this.
> >
> >
> > It was actually the SET_SIZE macro in check_object, at least for the repo at my company that hits this issue.  I took a look at the call tree for oe_get_size_slow and found that it's used in many places outside of ll_find_deltas, so there are many potential call sites where this could crop up:
> >
> >  [snip]
> >
>
> Ah, yes. I think the only problematic place is from prepare_pack().
> The single threaded access after ll_find_deltas() is fine because we
> never destroy mutexes.

I'm a bit confused, I see calls to pthread_mutex_destroy in
cleanup_threaded_search.  It's true that only
prepare_packing_data(&to_pack) is called and there is no cleanup of
the to_pack instance (at least as far as I can see) in
cmd_pack_objects, but aren't the threaded_search mutexes destroyed?

>
> > (Sorry if this is redundant for those who know the code better)
>
> Actually it's me to say sorry. I apparently did not know the code flow
> good enough to prevent this problem in the first place.
>
> >> > Resolve this by splitting off the read mutex initialization from
> >> > init_threaded_search. Instead initialize (and clean up) the read
> >> > mutex in cmd_pack_objects.
> >>
> >> Maybe move the mutex to 'struct packing_data' and initialize it in
> >> prepare_packing_data(), so we centralize mutex at two locations:
> >> generic ones go there, command-specific mutexes stay here in
> >> init_threaded_search(). We could also move oe_get_size_slow() back to
> >> pack-objects.c (the one outside builtin/).
> >
> >
> > I was already thinking that generic mutexes should be separated from command specific ones (that's why I introduced init_read_mutex and cleanup_read_mutex, but that may well not be the right exposure.)  I'll try my hand at this tonight (just moving the mutex to struct packing_data and initializing it in prepare_packing_data, I'll leave large code moves to the experts) and see how it turns out.
>
> Yes, leave the code move for now. Bug fixes stay small and simple (and
> get merged faster)

I was looking at this and noticed that packing_data already has a lock
mutex member.  Perhaps I am missing something but would it be
appropriate to drop read_mutex altogether, change lock to be a
recursive mutex, then use that instead in read_lock()/read_unlock()?
(Or even to directly call packing_data_lock/packing_data_unlock
instead of read_lock/read_unlock?  Strictly speaking it would be a
pack lock and not a read lock so the read_lock/read_unlock terminology
wouldn't be accurate anymore.)

I have the change locally to move read_mutex to the packing_data
struct (and rename it to read_lock to be consistent with the "lock"
member), but it seems redundant.  (And the lock member is only used in
oe_set_delta_size.)

> --
> Duy
