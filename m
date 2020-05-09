Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD2BC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696EF208CA
	for <git@archiver.kernel.org>; Sat,  9 May 2020 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV/2Ppzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEISAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 14:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgEISAk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 14:00:40 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE6C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 11:00:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e20so4177849otk.12
        for <git@vger.kernel.org>; Sat, 09 May 2020 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8K5yEgqLCTNd3t5juVzIqSs0x+eyTYWtbcsKWl+zDQ=;
        b=TV/2Ppzo+kg0urL0LeYYUQBEZGqaML4A4112oOiXRbhk3ZVaazWV/AGt96kEHlNPgp
         XxJzfpL1+kk6bailsxBWGuO2FzdsAi9/2RRpIUEJ1TrujtNoBTJWe2R9Mo/cIxUDAC24
         wARxnUJXsCukoUcxfcYSSm6vd5Uhlcd+0hLvlpRMqbXsowE9NGaWd6NzycqgStxMStJ/
         JoJo9fDY22bY2KLe4zMlAf/GwP+UxdxkfFa6V3NzSRhi9k//WLJpuzC/KT1bdtXWo36a
         PD/YqOkVetk6TdNmVY7UNoJfUGev+xbajbkHWlOyzuy3Vg2bNv+O2dQrCpVofsMdGUHA
         +W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8K5yEgqLCTNd3t5juVzIqSs0x+eyTYWtbcsKWl+zDQ=;
        b=k8GQ9sZyFjicLW8m4gvnJbqWAxL+LUTT0lmu3l8Cj6G/I1auVj+OVnePGKYRv7+N+2
         mrreh6K/UiLREzU0YJ6Pnuz+XJaQ+AkYhO5hZrdMUdlqWVS7po4V7FtmuwUS9mjBGbs0
         38t4oascXJ5Xk3FWQfdEgxIq0ZbKJwr6w2vzwCl76n/jre/reU/fmgzp/UkIUEmHthVR
         ZlH5pM261L8TSZK9+X5x3/V6UsUCz5mClGu20cxnEHyODFjCcl6ShGwN16/Q5ehOHSzu
         x6SE3SJ7wB1NDvrgMIvgz/cW5I1Ps0RZnTXrIAE9ZpKIzCZWqFyVloLPBO1mlCkJwJ/W
         352A==
X-Gm-Message-State: AGi0PuYTH+bXue5G8d+2EjPMkETJ6+oQuw/Rjoj/PgghBxp8t/2h+CG1
        nEoi3VApMULUOL5YmEcHgucIyGPA9KO7qvxUje06jgN7
X-Google-Smtp-Source: APiQypJGJ3yGLPAirJeULzAJzEHSe9NorqM6EZeX/lshc2M4Ypcor9VGxJHU6HAYbSHP29Ech7VVp7u6n748XJm88Bs=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr6998689otn.281.1589047239536;
 Sat, 09 May 2020 11:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
 <20200507194354.33347-1-jonathantanmy@google.com>
In-Reply-To: <20200507194354.33347-1-jonathantanmy@google.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 9 May 2020 23:30:28 +0530
Message-ID: <CA+CkUQ8fa=osCunE2Nj1ezzci_qEkv7mRwX=9Cg-kkMYcDHx=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 8, 2020 at 1:13 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> As Christian said [1], please include tests like in the commit you
> mentioned. For a change like this, I think that the test is the most
> important part.
>

I will definitely add tests.

> Also include a justification for why it's safe to remove
> fetch_if_missing=0. You can probably cite the aforementioned commit to
> say that it covers the fetch_pack() method, and then go through the rest
> of the code to see if any may inadvertently fetch an object.
>
> Also, the fetch-pack and index-pack parts can be sent in separate patch
> sets, so you might want to concentrate on one command first.
>

Thanks, Will split and concentrate on one at a time.

>
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 1734a573b01..1ca643f6491 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1649,7 +1649,7 @@ static void update_shallow(struct fetch_pack_args *args,
> >               struct oid_array extra = OID_ARRAY_INIT;
> >               struct object_id *oid = si->shallow->oid;
> >               for (i = 0; i < si->shallow->nr; i++)
> > -                     if (has_object_file(&oid[i]))
> > +                     if (has_object_file_with_flags(&oid[i], OBJECT_INFO_SKIP_FETCH_OBJECT))
> >                               oid_array_append(&extra, &oid[i]);
> >               if (extra.nr) {
> >                       setup_alternate_shallow(&shallow_lock,
>
> Hmm...this triggers when the user requests a clone that is both partial
> and shallow, and the server reports a shallow object that it didn't send
> back as a packfile; and it causes another fetch to be sent. This is a
> separate issue, but Hariom, if you'd like to take a look at this, that
> would work out too. You'll need to figure out how to make the server
> send back shallow lines referencing objects that are not in the packfile
> - one way to do it is to use one-time-perl. (Search the codebase to see
> how it is used.) This is probably more complex, though.

I'm clueless about "one-time-perl" thing(till now!). Will surely going
to learn about that.

Thanks for the nice explanation.

Regards,
Hariom
