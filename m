Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1896C77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 12:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjDPMnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 08:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDPMna (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 08:43:30 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F785587
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 05:43:07 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l5so2363298ybe.7
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681648986; x=1684240986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bxxFYlW4pFFs0/Golou2IcJOQtFuouw+dwAON73KQg=;
        b=sxE/oyj+iCbpGWmUyq7OE7maIT+i+Y4eQJBkKyKCGlUUyhuMJSuGEB8bA471GPjidd
         RivVlr815ZiJP4kcuymKuq1tSnHV6Yug3FyR0174FVQydKAZFH0wFDa50YbdBCmIt9QJ
         f47kLG7Eq5LOy4YCQbWPvk7iQQVBjvnaYs2fuUmQUxFbkaMqWgKX3QuchpDSxBlaYVgJ
         crd6YZ+8/nscR1S+ALMIndgW2Ve394kUhbP7G0jBqigwq8YFBJLyLczOrgiQqsAnIORQ
         r+OeQVMhjjpHJhZm8bY8fMft9BBHxx5spjCbHuKZ3YAkIUTLiq/bNSRKX/dPq7FFfuSO
         lCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681648986; x=1684240986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bxxFYlW4pFFs0/Golou2IcJOQtFuouw+dwAON73KQg=;
        b=XGUydbtrATpJ6u0fOD5V1r5t/WjSIfPiwHPlVma0DzJ36VTouaxB6Porwo/LquPHI6
         7yefeLsvY2bfzCjaRoo4SwukrkEmaCekNsLCQ3/QTvzZX3pQ76LOKwrnHuwLD/7kWRSd
         qLhRzxKvV/PakX1a5jKC2RvL/mwCuOpzlQZzmgbjVjf1F6yHpEUbKiYCYkGBOEw5c30G
         jdI3YRvfG0iq4Nj3gs2Hjs6xYJXqCxoHpQgG68wG8u1f9FuRI/Xx8ZeRRHuxXBRbhY5a
         /Ob4cCKK1AO3uGj8P2aZGhjL1D/w7ovJQtYnDIMY7FVA4ZXwb6zH7/i0Kk9MJA1J9b6x
         FoYw==
X-Gm-Message-State: AAQBX9eadxbqmDMiJ83XVLEHtHjQ0bANXAZaRJ9wzmuXc90ofs8bmXNv
        QSbHkK1HvVq4DTXqOgHu9uo+M2CUV0yeBdG6Qzw=
X-Google-Smtp-Source: AKy350Y/pPm+7IScv9WaChukezv1tO6F6ywINz7r8m93EHAutQp5jjLF89gqfOm0CsVwLbVd9fkccOBl7c8DLOze5mc=
X-Received: by 2002:a25:da0b:0:b0:b8f:6f3f:ed20 with SMTP id
 n11-20020a25da0b000000b00b8f6f3fed20mr5192706ybf.5.1681648986439; Sun, 16 Apr
 2023 05:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local> <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net> <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
 <20230412074309.GB1695531@coredump.intra.peff.net> <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
 <20230414073035.GB540206@coredump.intra.peff.net> <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
 <CAHk-=wjr-CMLX2Jo2++rwcv0VNr+HmZqXEVXNsJGiPRUwNxzBQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjr-CMLX2Jo2++rwcv0VNr+HmZqXEVXNsJGiPRUwNxzBQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 16 Apr 2023 20:43:22 +0800
Message-ID: <CAOLTT8S7i2CRz0Oo6u6qMD2BD9=3UaJ0C0iNeY1B+hF6H5S94A@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8815=E6=97=A5=E5=91=A8=E5=85=AD 01:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 14, 2023 at 5:17=E2=80=AFAM ZheNing Hu <adlternative@gmail.co=
m> wrote:
> >
> > Jeff King <peff@peff.net> =E4=BA=8E2023=E5=B9=B44=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=94 15:30=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Apr 12, 2023 at 05:57:02PM +0800, ZheNing Hu wrote:
> > > >
> > > > I'm still puzzled why git calculated the object id based on {type, =
size, data}
> > > >  together instead of just {data}?
> > >
> > > You'd have to ask Linus for the original reasoning. ;)
>
> I originally thought of the git object store as "tagged pointers".
>
> That actually caused confusion initially when I tried to explain this
> to SCM people, because "tag" means something very different in an SCM
> environment than it means in computer architecture.
>
> And the implication of a tagged pointer is that you have two parts of
> it - the "tag" and the "address". Both are relevant at all points.
>
> This isn't quite as obvious in everyday moden git usage, because a lot
> of uses end up _only_ using the "address" (aka SHA1), but it's very
> much part of the object store design. Internally, the object layout
> never uses just the SHA1, it's all "type:SHA1", even if sometimes the
> types are implied (ie the tree object doesn't spell out "blob", but
> it's still explicit in the mode bits).
>
> This is very very obvious in "git cat-file", which was one of the
> original scripts in the first commit (but even there the tag/type has
> changed meaning over time: the very first version didn't use it as
> input at all, then it started verifying it, and then later it got the
> more subtle context of "peel the tags until you find this type").
>

Yes, in the initial commit of Git, "git cat-file" only needs to pass the
object ID to obtain both the content and type of the object. However,
modern "git cat-file" requires specifying both the expected object type
and  object ID by default. e.g. "git cat-file commit v2.9.1". This should
be where you mentioned the simultaneous appearance of "tag" and
"address". This design model may not be very user-friendly for users
to use, so nowadays, people prefer to use "git cat-file -p", this may be
very similar to the initial version of git cat-file.

> You can also see this in the original README (again, go look at that
> first git commit): the README talks about the "tag of their type".
>
> Of course, in practice git then walked away from having to specify the
> type all the time. It started even in that original release, in that
> the HEAD file never contained the type - because it was implicit (a
> HEAD is always a commit).
>
> So we ended up having a lot of situations like that where the actual
> tag part was implicit from context, and these days people basically
> never refer to the "full" object name with tag, but only the SHA1
> address.
>
> So now we have situations where the type really has to be looked up
> dynamically, because it's not explicitly encoded anywhere. While HEAD
> is supposed to always be a commit, other refs can be pretty much
> anything, and can point to a tag object, a commit, a tree or a blob.
> So then you actually have to look up the type based on the address.
>
> End result: these days people don't even think of git objects as
> "tagged pointers".  Even internally in git, lots of code just passes
> the "object name" along without any tag/type, just the raw SHA1 / OID.
>
> So that originally "everything is a tagged pointer" is much less true
> than it used to be, and now, instead of having tagged pointers, you
> mostly end up with just "bare pointers" and look up the type
> dynamically from there.
>

I feel that if type was not included in the objects initially, people would
need to specify both "tag" and "address" at the same time to explain
the objects. Otherwise, this "tag" can only be used for checking the type,
and this is not necessary in most cases.

> And that "look up the type in the object" is possible because even
> originally, I did *not* want any kind of "object type aliasing".
>
> So even when looking up the object with the full "tag:pointer", the
> encoding of the object itself then also contains that object type, so
> that you can cross-check that you used the right tag.
>
> That said, you *can* see some of the effects of this "tagged pointers"
> in how the internals do things like
>
>     struct commit *commit =3D lookup_commit(repo, &oid);
>
> which conceptually very much is about tagged pointers. And the fact
> that two objects cannot alias is actually somewhat encoded in that: a
> "struct commit" contains a "struct object" as a member. But so does
> "struct blob" - and the two "struct object" cases are never the same
> "object".
>
> So there's never any worry about "could blob.object be the same object
> as commit.object"?
>

Yes, if an object can be interpreted as multiple types, it will certainly
make it very difficult for git higher-level logic to handle it.

> That is actually inherent in the code, in how "lookup_commit()"
> actually does lookup_object() and then does object_as_type(OBJ_COMMIT)
> on the result.
>
> > Oh, you are right, this could be to prevent conflicts between Git objec=
ts
> > with identical content but different types. However, I always associate
> > Git with the file system, where metadata such as file type and size is
> > stored in the inode, while the file data is stored in separate chunks.
>
> See above: yes, git design was *also* influenced heavily by
> filesystems, but that was mostly in the sense of "this is how to
> encode these things without undue pain".
>
> The object database being immutable was partly a security and safety
> measure, but it was also very much partly a "rewriting files is going
> to be a major pain from a filesystem consistency standpoint - don't do
> it".
>

You're right. Git objects are immutable, while data in a file system
is mutable, so Git's design doesn't need to follow the file system complete=
ly.

> But even more than a filesystem design, it's an "computer
> architecture" design. Think of the git object store as a very abstract
> computer architecture that has tagged pointers, stable storage, and no
> aliasing - and where the tag is actually verified at each lookup.
>
> The "no aliasing" means that no two distinct pointers can point to the
> same data. So a tagged pointer of type "commit" can not point to the
> same object as a tagged pointer of type "blob". They are distinct
> pointers, even if (maybe) the commit object encoding ends up then
> being identical to a blob object.
>
> And as mentioned, that "verified at each lookup" has mostly gone away,
> and "each lookup" has become more of a "can be verified by fsck", but
> it's probably still a good thing to think that way.
>
> You still have "lookup_object_by_type()" internally in git that takes
> the full tagged pointer, but almost nobody uses it any more. The
> closest you get is those "lookup_commit()" things (which are fairly
> common, still).
>

Well, now I understand: everything in Git's architecture is "tag:pointer".
Tags are used to verify object types (although it's not necessary now),
and pointers are used for addressing. This is also one of the reasons
why Git initially included the type in its objects.

>               Linus

Thank you for your wonderful answer regarding the design concept
of "tagged pointers"! This deepens my understanding of Git's design. :-)

ZheNing Hu
