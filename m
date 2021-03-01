Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE47CC433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22CF64E76
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbhCAUWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243136AbhCAUS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 15:18:28 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622BAC06178B
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 12:17:48 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l133so19441012oib.4
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xmUP7lEKc3+G+iWtAFlfMX/kT2N8UuBQvm46ArgyaRI=;
        b=tEdrIbeJf2yy024xnnj1JEaQy846xXlm+DJG0StEFKGMuuU9Ku8NKpz8pOgtnb46yE
         QeojrxmIZE6TCjgQ5duBBYrRc/XIW6yJ8g6+rHOTThOEpsWi1I3S0pEfhIl0p5X2TXBb
         0LvHyMkoxlTcYbtfJH+PtKnlMi9EY9sVEWKR/YajGAxL8xHW/iAG9JJ49SwKsimeW1/Q
         FnV0NjkUqpUhFvIqPYoHOy3TjONQxPzKOfQZEtDfq8IKm4P+3yJV+hOw0RCkN05YWB7k
         SdO1KlQyh6vH4K36gaZXbeCL/uczrVfXIPGIc3zfA56pkCthud2t6RDJZupwjd7SzAnb
         ZPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xmUP7lEKc3+G+iWtAFlfMX/kT2N8UuBQvm46ArgyaRI=;
        b=eFsHbhTPTmvYPlW8cV7R1rECwUiRU4irXXoAOv4xoRWU9Eu2Qn3MXsE3ULHTGfP3q7
         XpX/qneXGwTiMlxzrU7CKdtyvex5WxszquJXNAM3NZ4ah3OFJApmMNajr14AXLyR3X3A
         sCPnTPGnxVirXuu2YHZHw2NZ5rCkKqFRw/81QnQXU7UAUZuGbCtyYlf7KHJz3iqXMCQD
         tDDvUYVLVrfh2GMavtDtbWygoD/sGXYNNv8vwubTWeDf2s+m9IkWA70ZA4Stco/Tzgww
         e+sAiRTm9a8h3K7b8AnqGZk9YvNjGl4tABMYUUEIq81lqJWgNoi1zmvHflfS03w1necQ
         mnvw==
X-Gm-Message-State: AOAM530tapxp4IM//fhhKYRODt8JRnxS6T9ivCDykrm6wp2ptfGknD+9
        HCYVbNQ97XGS0r4m7SA7U4mrU/FZbM7jRa5+mYA=
X-Google-Smtp-Source: ABdhPJx4n5JdaolDBDv+gvnpQHgKVzqh1NM9aoAs7ihQqzGlARvz4JsOG4hPbR55MdeW20eYoBydMj711sIBQhsH7fo=
X-Received: by 2002:aca:4e0f:: with SMTP id c15mr569097oib.39.1614629867581;
 Mon, 01 Mar 2021 12:17:47 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <CABPp-BE=9wzF6_VypoR-uEPHsLWdV7zyE13FOgLK0h8NOcMz3g@mail.gmail.com> <87ft1ek5dg.fsf@evledraar.gmail.com>
In-Reply-To: <87ft1ek5dg.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Mar 2021 12:17:36 -0800
Message-ID: <CABPp-BHdtAKz_V2RhBqevMy+Hy_rHtQ7Y2chggpt1rZ9nRn8Zw@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     anatoly techtonik <techtonik@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 12:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Mar 01 2021, Elijah Newren wrote:
>
> > On Sun, Feb 28, 2021 at 11:44 PM anatoly techtonik <techtonik@gmail.com=
> wrote:
> >>
> >> On Sun, Feb 28, 2021 at 1:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> >> <avarab@gmail.com> wrote:
> >> >
> >> > I think Elijah means that in the general case people are using fast
> >> > export/import to export/import between different systems or in
> >> > combination with a utility like git-filter-repo.
> >> >
> >> > In those cases users are also changing the content of the repository=
, so
> >> > the hashes will change, invalidating signatures.
> >> >
> >> > But there's also cases where e.g. you don't modify the history, or o=
nly
> >> > part of it, and could then preserve these headers. I think there's n=
o
> >> > inherent reason not to do so, just that nobody's cared enough to sub=
mit
> >> > patches etc.
> >>
> >> Is fast-export/import the only way to filter information in `git`? May=
be there
> >> is a slow json-export/import tool that gives a complete representation=
 of all
> >> events in a repository? Or API that can be used to serialize and impor=
t that
> >> stream?
> >>
> >> If no, then I'd like to take a look at where header filtering and seri=
alization
> >> takes place. My C skills are at the "hello world" level, so I am not s=
ure I can
> >> write a patch. But I can write the logic in Python and ask somebody to=
 port
> >> that.
> >
> > If you are intent on keeping signatures because you know they are
> > still valid, then you already know you aren't modifying any
> > blobs/trees/commits leading up to those signatures.  If that is the
> > case, perhaps you should just avoid exporting the signature or
> > anything it depends on, and just export the stuff after that point.
> > You can do this with fast-export's --reference-excluded-parents option
> > and pass it an exclusion range.  For example:
> >
> >    git fast-export --reference-excluded-parents ^master~5 --all
> >
> > and then pipe that through fast-import.
> >
> >
> > In general, I think if fast-export or fast-import are lacking features
> > you want, we should add them there, but I don't see how adding
> > signature reading to fast-import and signature exporting to
> > fast-export makes sense in general.  Even if you assume fast-import
> > can process all the bits it is sent (e.g. you extend it to support
> > commits without an author, tags without a tagger, signed objects, any
> > other extended commit headers), and even if you add flags to
> > fast-export to die if there are any bits it doesn't recognize and to
> > export all pieces of blobs/trees/tags (e.g. don't add missing authors,
> > don't re-encode messages in UTF-8, don't use grafts or replace
> > objects, keep extended headers such as signatures, etc.), then it
> > still couldn't possibly work in all cases in general.  For example, if
> > you had a repository with unusual objects made by ancient or broken
> > git versions (such as tree entries in the wrong sort order, or tree
> > entries that recorded modes of 040000 instead of 40000 for trees or
> > something with perms other than 100644 or 100755 for files), then when
> > fast-import goes to recreate these objects using the canonical format
> > they will no longer have the same hash and your commit signatures will
> > get invalidated.  Other git commands will also refuse to create
> > objects with those oddities, even if git accepts ancient objects that
> > have them.
> >
> > So, it's basically impossible to have a "complete representation of
> > all events in a repository" that do what you want except for the
> > *original* binary format.  (But if you really want to see the original
> > binary format, maybe `git cat-file --batch` will be handy to you.)
> >
> > But I think fast-export's --reference-excluded-parents might come in
> > handy for you and let you do what you want.
>
> ...to add to that line of thinking, it's also a completely valid
> technique to just completele rewrite your repository, then (re-)push the
> old signed tags to refs/tags/*.

The repository in question didn't have any signed tags, just a signed commi=
t.

> By default they won't be pulled down as they won't reference commits on
> branches you're fetching, and you can also stick them somewhere else
> than refs/tags/*, e.g. refs/legacy-tags/*.
>
> None of the commit history will be the same, but the content (mostly)
> will, which is usually what matters when checking out an old tag.
>
> Of course this hack has little benefit over just keeping a foo-old.git
> repo around, and moving on with new history in your new foo.git.
