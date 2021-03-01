Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8F7C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3306C64FAE
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhCASKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbhCASHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 13:07:38 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99058C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 10:06:55 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id f33so17327770otf.11
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 10:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mEY6XEBNd8TH6laIRI8u0+LBG2vGQilwivB/1xHUnK0=;
        b=RD1urtohuQPTyq6v5DsFVMBddkuEemZPoy/m2tkcR14xp3J7UcG5VurkUZjauzuloq
         UgF5SDaEsSPGyzo+bHXAPH6nA6bXk87biN6wZI1X2N9fcUuPVFr8MMA0IeE8aj2i+HxQ
         X4Vx401EshbcP8/TkJB9XHJ1pYY6qQoJKRu4YBKtSF+3/IhyxNhOPLoi56kGNoyFCy37
         uZvpSZ7q94RRscwcHwfLeI91EOmvAxnctpxCjGBWiw3dQ5ObBmVROlgtxmn9yZpJ3K03
         0/ec5neaTM8xNbWpcElQwmVK91pAJNn0bQrBCjg/glAsRSudDdiXZstOhxC9IMyCj+Fm
         DE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mEY6XEBNd8TH6laIRI8u0+LBG2vGQilwivB/1xHUnK0=;
        b=D4pCTaCv9cFLlF+8lFpn5ygI5IdI4R8cH83psOkXcSbY6tJuMKwKjc4FTYpdJaNtKf
         ZS1GwgcQ2W//+j+nLlhUrML6/uo6sszUUINpx66vCl5u7W5RacgwsHlWcXa+6FOxERk9
         U9OkODeXbwFtAfnNOGUL96tbz0B/I0kZB4ybAbrO/sJgbx0IgxvOquRsWlb6ucisxjrQ
         fpBFPJxuhJ9C6DQS4HydFWzKKx3STLRS3i1OIoP+6SM4js2QiGkFGuX6bqQnzUcCXVSP
         mItwcJtyVRuoucdSPj+I5kK2k0vL7jtXLAILrLE9knUfgUFbMD3/b2iXJcPab37GKSJG
         nPJQ==
X-Gm-Message-State: AOAM530mhquAr4NmWbY67pkAnr4f+xUjop9nAVACyw7mRncqg4t3K02M
        LSvF3zqnPZCBvzEsHC2X1RUSunHuVdJUzssuGTzJyGeSRdg=
X-Google-Smtp-Source: ABdhPJxDae1X/WrwxF/En/FycGcscBBNExR6OWYrbgEhbA7J9HPuPaAH/5MyZGhso7YlG/4ssZcVNZS7/SYpmbk4xxo=
X-Received: by 2002:a05:6830:100c:: with SMTP id a12mr14881669otp.345.1614622014945;
 Mon, 01 Mar 2021 10:06:54 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
In-Reply-To: <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Mar 2021 10:06:43 -0800
Message-ID: <CABPp-BE=9wzF6_VypoR-uEPHsLWdV7zyE13FOgLK0h8NOcMz3g@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 28, 2021 at 11:44 PM anatoly techtonik <techtonik@gmail.com> wr=
ote:
>
> On Sun, Feb 28, 2021 at 1:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > I think Elijah means that in the general case people are using fast
> > export/import to export/import between different systems or in
> > combination with a utility like git-filter-repo.
> >
> > In those cases users are also changing the content of the repository, s=
o
> > the hashes will change, invalidating signatures.
> >
> > But there's also cases where e.g. you don't modify the history, or only
> > part of it, and could then preserve these headers. I think there's no
> > inherent reason not to do so, just that nobody's cared enough to submit
> > patches etc.
>
> Is fast-export/import the only way to filter information in `git`? Maybe =
there
> is a slow json-export/import tool that gives a complete representation of=
 all
> events in a repository? Or API that can be used to serialize and import t=
hat
> stream?
>
> If no, then I'd like to take a look at where header filtering and seriali=
zation
> takes place. My C skills are at the "hello world" level, so I am not sure=
 I can
> write a patch. But I can write the logic in Python and ask somebody to po=
rt
> that.

If you are intent on keeping signatures because you know they are
still valid, then you already know you aren't modifying any
blobs/trees/commits leading up to those signatures.  If that is the
case, perhaps you should just avoid exporting the signature or
anything it depends on, and just export the stuff after that point.
You can do this with fast-export's --reference-excluded-parents option
and pass it an exclusion range.  For example:

   git fast-export --reference-excluded-parents ^master~5 --all

and then pipe that through fast-import.


In general, I think if fast-export or fast-import are lacking features
you want, we should add them there, but I don't see how adding
signature reading to fast-import and signature exporting to
fast-export makes sense in general.  Even if you assume fast-import
can process all the bits it is sent (e.g. you extend it to support
commits without an author, tags without a tagger, signed objects, any
other extended commit headers), and even if you add flags to
fast-export to die if there are any bits it doesn't recognize and to
export all pieces of blobs/trees/tags (e.g. don't add missing authors,
don't re-encode messages in UTF-8, don't use grafts or replace
objects, keep extended headers such as signatures, etc.), then it
still couldn't possibly work in all cases in general.  For example, if
you had a repository with unusual objects made by ancient or broken
git versions (such as tree entries in the wrong sort order, or tree
entries that recorded modes of 040000 instead of 40000 for trees or
something with perms other than 100644 or 100755 for files), then when
fast-import goes to recreate these objects using the canonical format
they will no longer have the same hash and your commit signatures will
get invalidated.  Other git commands will also refuse to create
objects with those oddities, even if git accepts ancient objects that
have them.

So, it's basically impossible to have a "complete representation of
all events in a repository" that do what you want except for the
*original* binary format.  (But if you really want to see the original
binary format, maybe `git cat-file --batch` will be handy to you.)

But I think fast-export's --reference-excluded-parents might come in
handy for you and let you do what you want.
