Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49972F7CEC
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780974; cv=none; b=A33pA06Q51ObkEJUrqJTXU7buw/a3Lf4+8JNR3pkcapgn0AVUuX8xN/LU9DHa56LhQ7yN36iPlDnPqif6mO3PJIajgiSTXed8dHNkMblPDLXkT6P2pNURaF4ExVk3h1+NvrmZPjWQh02VqsjsYiX9xLEXifoCq7R/RwEDsroPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780974; c=relaxed/simple;
	bh=ET6YIxJL31DyKZT0sC7o37U50UEWUDBXottTsA8HeZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XES1bRI5QGNCC7/ZM5U/mIvkNQwcfcN3fphbw7DP2Ozc4/H9u4sIsVCOhta4gZhaakZXb9yP0OXYadsmmUXqiPzIy+nwWZvGoZbOBGhqrxA39hK1upSJYr3A86H+ya0Tal73WB9iNfrG5BoeZGyaKe8kmprgj+1tAptSqGbLArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/5wOPP+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/5wOPP+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fad3400ea3so13834776d6.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752780971; x=1753385771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKcWAxuhlKK87IJ3al1kOv9gkl0JMrsse8jlRfZE01I=;
        b=O/5wOPP+eXqKWzlhm+7ZSX25pMdPjHIp29dK4jLZjciA5zzRZUzWU8dhKCKhJNmKow
         LBeNFE9kxuTblqcbgoYrpXLrCJOJtY/DMvB8fLyk42y4ae23PPnHVaJQzYWQ0VKPecQJ
         Tsxtdn5302ulQcNWqOlBLcwuHlRobWonwYE+sv45uQggTq8x26yPR9tU97kZM5RpLbmK
         9O6j+8Xq1P7xnyVyC7yZJVCCzzfFgMBlx+9/T9wvmaQj0DoRzo68xpwHN5s/k+5ORPh6
         6YL2/+cUvG8oc6g2Q9jeZb5W0fc8IqotTYlYIWIRjTND+pbmqWBTekUpMn/TM/7w/ia/
         tjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780971; x=1753385771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKcWAxuhlKK87IJ3al1kOv9gkl0JMrsse8jlRfZE01I=;
        b=JfX9iBAqys18xawJjp3IhWnOUSVIZxko/vSMH+rkf+d51hhAesA6yKOhPlsFz6Tdaq
         CPvs8OSeKGXEr1qcKT4EsToZPNhJcVdhcLxQhtuFk27JuwUNNVZWgkyHHEgXSsh+b5XR
         tR110Ip7XAHiLtNTWbtozcDTPfaxwIRImxigDZ3jS4dJaVm20GhaHfbbdRgeV9fSL4Ze
         WsviN7ONUhISjIFLpGcFg1JC75gh98uiGXlWL6mYPQ5xtIbGCcIX3EvfthQ6jWtpOQV1
         bS4ostJ85wJhsn6SAgb7udd0kZH4zzirlLSQCZTE+GPbozakhiHstKRVo58i4b1/+9Kt
         shbA==
X-Forwarded-Encrypted: i=1; AJvYcCVsL69UwMl747Ydo7tlYTvIwrmky/ACTMwnAFQafwMZMFWNnRyhLiw/TXCiCVczzkmZepY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy499hLoveVkNfUKVqscOfB4JpoBEUGtegmCCoOviuWaMkjJbez
	/vxZwZz4naBL20o5l8Zvb6nRDsvZwsyrIcTdgvRaXbJFP34NyQsWX2RDGmSLb/pdNZ+2UTyppRX
	UivxblJOk7pG0po4ZKOXzy2aObudrrM3vrmX0HliY
X-Gm-Gg: ASbGncvKg/VElYGGQKlHAJ3atC5Sy/ovyXForIOKTgFcRR/4EWVd4EqihRPCVNgcWyj
	0q3mZFcUEi3J/4q8iF/H5j2Ib78PBTdyhfSKAO1sjWWUhKdEzuR78T2xU0a9psKqq+s8jonBdLP
	jAuXTnhOmEZxvqkPaxG3ODLuFYMMF8ClwNFnZNSINbzgvqSYXhAficwUS58amyXQqNK7wavYPMX
	Qz4qYi/mKojBgQwUyjf0Eiuoo7Lzium2uJH
X-Google-Smtp-Source: AGHT+IHTIC7swXfLb9oqCLfA8ln56vNazTdFswA58ex0Xy5/8+1z3qY57ssmontjnqFlyu7qy6kW0w/nAgnpwWwoLog=
X-Received: by 2002:a05:6214:311e:b0:702:da74:d022 with SMTP id
 6a1803df08f44-705073f3226mr62857196d6.35.1752780970241; Thu, 17 Jul 2025
 12:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g> <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net> <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
 <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
In-Reply-To: <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 17 Jul 2025 12:35:58 -0700
X-Gm-Features: Ac12FXwQIf9G9dLfUaPNPymUl2b2gD-1cOxMzKhTAxjponEHusu4UGCZ1-E6zEM
Message-ID: <CAO_smVj4e0XOQyQr5sDyMZ8WPvqcBe2Y33DFHrED7C=VJnm4eg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via '--start-after'
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	schwab@linux-m68k.org, phillip.wood123@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:26=E2=80=AFPM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > On Wed, Jul 16, 2025 at 6:54=E2=80=AFPM Jeff King <peff@peff.net> wrote=
:
> >>
> >> On Wed, Jul 16, 2025 at 06:19:32PM -0700, Kyle Lippincott wrote:
> >>
> >> > Unfortunately I can't provide great instructions for reproducing thi=
s
> >> > locally, because it relies on our internal build stack (which uses
> >> > blaze). Getting MemorySanitizer running can be quite annoying, thoug=
h
> >> > you might not have any issues if this test doesn't invoke any third
> >> > party libraries (like zlib).
> >> >
> >> > I need to sign off for the night soon, but if this isn't sufficient
> >> > enough information to identify what's happening here, I can try to d=
ig
> >> > deeper tomorrow. This run was executed on an import of upstream comm=
it
> >> > 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc (Junio's merge of this
> >> > series)
> >>
> >> valgrind can often find the same issues as MSan without as much headac=
he
> >> to get it running (the downside is that it is _way_ slower). And indee=
d:
> >>
> >>   git checkout 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc &&
> >>   make &&
> >>   (cd t && ./t6302-for-each-ref-filter.sh --valgrind-only=3D48)
> >>
> >> yields:
> >>
> >>   =3D=3D2177572=3D=3D Conditional jump or move depends on uninitialise=
d value(s)
> >>   =3D=3D2177572=3D=3D    at 0x3BC380: cache_ref_iterator_advance (ref-=
cache.c:409)
> >>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c=
:15)
> >>   =3D=3D2177572=3D=3D    by 0x3B6CC3: merge_ref_iterator_advance (iter=
ator.c:179)
> >>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c=
:15)
> >>   =3D=3D2177572=3D=3D    by 0x3A9770: files_ref_iterator_advance (file=
s-backend.c:902)
> >>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c=
:15)
> >>   =3D=3D2177572=3D=3D    by 0x3B7457: do_for_each_ref_iterator (iterat=
or.c:478)
> >>   =3D=3D2177572=3D=3D    by 0x399B43: for_each_fullref_with_seek (ref-=
filter.c:2718)
> >>   =3D=3D2177572=3D=3D    by 0x399C09: for_each_fullref_in_pattern (ref=
-filter.c:2756)
> >>   =3D=3D2177572=3D=3D    by 0x39B031: do_filter_refs (ref-filter.c:326=
3)
> >>   =3D=3D2177572=3D=3D    by 0x39B2B7: filter_and_format_refs (ref-filt=
er.c:3364)
> >>   =3D=3D2177572=3D=3D    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c=
:115)
> >>   =3D=3D2177572=3D=3D  Uninitialised value was created by a heap alloc=
ation
> >>   =3D=3D2177572=3D=3D    at 0x484BDD0: realloc (vg_replace_malloc.c:18=
01)
> >>   =3D=3D2177572=3D=3D    by 0x44E941: xrealloc (wrapper.c:140)
> >>   =3D=3D2177572=3D=3D    by 0x3BCAD9: cache_ref_iterator_begin (ref-ca=
che.c:580)
> >>   =3D=3D2177572=3D=3D    by 0x3A988A: files_ref_iterator_begin (files-=
backend.c:995)
> >>   =3D=3D2177572=3D=3D    by 0x3A295E: refs_ref_iterator_begin (refs.c:=
1776)
> >>   =3D=3D2177572=3D=3D    by 0x399AF6: for_each_fullref_with_seek (ref-=
filter.c:2710)
> >>   =3D=3D2177572=3D=3D    by 0x399C09: for_each_fullref_in_pattern (ref=
-filter.c:2756)
> >>   =3D=3D2177572=3D=3D    by 0x39B031: do_filter_refs (ref-filter.c:326=
3)
> >>   =3D=3D2177572=3D=3D    by 0x39B2B7: filter_and_format_refs (ref-filt=
er.c:3364)
> >>   =3D=3D2177572=3D=3D    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c=
:115)
> >>   =3D=3D2177572=3D=3D    by 0x128C90: run_builtin (git.c:480)
> >>   =3D=3D2177572=3D=3D    by 0x1290EB: handle_builtin (git.c:746)
> >>
> >> Bisecting doesn't tell us much, though (the first commit that introduc=
es
> >> the test shows the problem). I didn't dig further than that.
> >>
> >> -Peff
> >
> > Thanks for that, that helped me a bit too as it provides more
> > information than I was getting out of MemorySanitizer (I suspect
> > MemorySanitizer was producing the information it just wasn't going to
> > stderr or something, or maybe I was missing a flag to get it to report
> > more).
> >
>
> Thanks both for raising the issue. Thanks Jeff for also the valgrind
> instructions.
>
> On a sidenote, was discussing this at work and Patrick also mentioned
> that we could try clang's MemorySanitizer. This seems to also be raising
> issues on master, so it was hard to find the exact output that valgrind
> was providing.
>
> $ git checkout master
> $ CC=3Dclang meson setup --reconfigure memory_build . -Db_sanitize=3Dmemo=
ry
> $ cd memory_build
> $ meson test -i --test-args=3D"-ix" t6302-for-each-ref-filter
> ...
> =3D=3D3275333=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0x557bd886f4bb in git_mkstemps_mode ../wrapper.c:487:27
>     #1 0x557bd886fb55 in git_mkstemp_mode ../wrapper.c:509:9
>     #2 0x557bd8100d1a in create_tmpfile ../object-file.c:736:7
>     #3 0x557bd80f1630 in start_loose_object_common ../object-file.c:781:7
>     #4 0x557bd80f5203 in write_loose_object ../object-file.c:881:7
>     #5 0x557bd80f4875 in write_object_file_flags ../object-file.c:1086:6
>     #6 0x557bd80f9f65 in write_object_file ../object-file.h:181:9
>     #7 0x557bd8101eb8 in index_mem ../object-file.c:1177:9
>     #8 0x557bd80f8bd5 in index_core ../object-file.c:1247:10
>     #9 0x557bd80f731d in index_fd ../object-file.c:1274:9
>     #10 0x557bd80f95e4 in index_path ../object-file.c:1295:7
>     #11 0x557bd831132d in add_to_index ../read-cache.c:771:7
>     #12 0x557bd8313cb1 in add_file_to_index ../read-cache.c:804:9
>     #13 0x557bd73f892c in add_files ../builtin/add.c:355:7
>     #14 0x557bd73f4752 in cmd_add ../builtin/add.c:578:18
>     #15 0x557bd7a38b6f in run_builtin ../git.c:480:11
>     #16 0x557bd7a31d54 in handle_builtin ../git.c:746:9
>     #17 0x557bd7a36644 in run_argv ../git.c:813:4
>     #18 0x557bd7a30e09 in cmd_main ../git.c:953:19
>     #19 0x557bd7a3ca01 in main ../common-main.c:9:11
>     #20 0x7f7e3f02a4d7 in __libc_start_call_main
> (/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+=
0x2a4d7)
> (BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
>     #21 0x7f7e3f02a59a in __libc_start_main@GLIBC_2.2.5
> (/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+=
0x2a59a)
> (BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
>     #22 0x557bd7352b34 in _start (git+0x5db34)
>
> Possibly something we need to look into cleaning up.

I also saw those msan issues when trying `make
CFLAGS=3D-fsanitize=3Dmemory CC=3Dclang`, but not with Google's internal
msan build. I don't know which variable in wrapper.c:487 it's
complaining about - you'd think it'd be `letters`, but if it's `v`,
then that potentially comes from OpenSSL or some other library, and
that library would also need to be built with msan (which is why it's
such a pain to get msan builds working - EVERY library needs to be
built with memory sanitizer).

>
> > I'm not sure what the right fix would be; my guess is that the
> > fix would be to modify the places where we set levels_nr and
> > initialize the other fields in level to also set it to prefix_state
> > (around lines 488 and 527 in ref-cache.c); and indeed setting the
> > prefix_state to PREFIX_CONTAINS_DIR (the 0 value of the enum) makes
> > the test pass even under valgrind. Unfortunately without a much more
> > in-depth knowledge of the code and the enum values I can't
> > definitively state that those are the correct values. I can say that
> > setting it to PREFIX_WITHIN_DIR causes both additional valgrind
> > failures and test failures even without valgrind, but setting it to
> > PREFIX_EXCLUDES_DIR doesn't seem to be a problem. I also moved the
> > `if` around like 409 into the following if, because that was the only
> > time entry_prefix_state was used, I'd been thinking that maybe it
> > needed the check for entry->flag & REF_DIR prior to referencing
> > level->prefix_state, but that didn't resolve it on its own.
> >
> > I don't mind if anyone else picks up this fix and runs with it, but
> > I'm not comfortable sending this patch myself because I don't have
> > enough knowledge of this are of the code to know if it's right, just
> > that it fixes the issue we encountered, and I'm extremely overloaded
> > right now and can't get that knowledge nor see the patch through to
> > the end.
> >
>
> Thanks for taking a stab at this, your inference is correct. Let me
> clairfy some parts of it.
>
> So the 'ref-cache' iteration logic is used to provide iteration over
> loose refs (which consists of directories and entries). Anytime we come
> across a directory, we add it to the level variable, which acts as
> stack, when all entries under the current level are yielded, we pop the
> stack to obtain the next level to iterate. This ensures we iterate over
> all directories recursively.
>
> Before this series, the seek function was used to set the prefix for
> iteration, which meant we need to find the directory for matching the
> prefix and only iterate over that level and its subdirs. If the prefix
> provided was a directory like 'refs/heads/' then all refs under that
> would be yielded (PREFIX_CONTAINS_DIR). If the prefix was
> 'refs/heads/foo', then the level would be set to 'ref/heads/' with the
> PREFIX_WITHIN_DIR flag set since only some refs within the dir would
> match the prefix. Entries which didn't overlap the prefix are denoted by
> PREFIX_EXCLUDES_DIR.
>
> This series allows the seek function to set the cursor without setting
> the prefix, which is a requirement for pagination. So there is no need
> to set 'prefix_state' for this functionality. Which is why I didn't set
> it, since the default value of '0' (PREFIX_CONTAINS_DIR) would be the
> correct setting for all dirs. This causes the issue.
>
> So the only fix required would be
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..ceef3a2008 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct
> ref_iterator *ref_iterator,
>                                 level =3D &iter->levels[iter->levels_nr++=
];
>                                 level->dir =3D dir;
>                                 level->index =3D -1;
> +                               level->prefix_state =3D PREFIX_CONTAINS_D=
IR;
>                         } else {
>                                 /* reduce the index so the leaf node is i=
terated over */
>                                 if (cmp <=3D 0 && !slash)
>
>
> The other location (Line 488), is not needed because that is the root
> directory and the 'prefix_state' for it is set in
> 'cache_ref_iterator_set_prefix()' when the iterator begins.
>
> >
> > diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> > index 1d95b56d40..24feb33fcb 100644
> > --- a/refs/ref-cache.c
> > +++ b/refs/ref-cache.c
> > @@ -391,7 +391,6 @@ static int cache_ref_iterator_advance(struct
> > ref_iterator *ref_iterator)
> >                         &iter->levels[iter->levels_nr - 1];
> >                 struct ref_dir *dir =3D level->dir;
> >                 struct ref_entry *entry;
> > -               enum prefix_state entry_prefix_state;
> >
> >                 if (level->index =3D=3D -1)
> >                         sort_ref_dir(dir);
> > @@ -406,16 +405,17 @@ static int cache_ref_iterator_advance(struct
> > ref_iterator *ref_iterator)
> >
> >                 entry =3D dir->entries[level->index];
> >
> > -               if (level->prefix_state =3D=3D PREFIX_WITHIN_DIR) {
> > -                       entry_prefix_state =3D
> > overlaps_prefix(entry->name, iter->prefix);
> > -                       if (entry_prefix_state =3D=3D PREFIX_EXCLUDES_D=
IR ||
> > -                           (entry_prefix_state =3D=3D PREFIX_WITHIN_DI=
R
> > && !(entry->flag & REF_DIR)))
> > -                               continue;
> > -               } else {
> > -                       entry_prefix_state =3D level->prefix_state;
> > -               }
> > -
> >                 if (entry->flag & REF_DIR) {
> > +                       enum prefix_state entry_prefix_state;
> > +                       if (level->prefix_state =3D=3D PREFIX_WITHIN_DI=
R) {
> > +                               entry_prefix_state =3D
> > overlaps_prefix(entry->name, iter->prefix);
> > +                               if (entry_prefix_state =3D=3D PREFIX_EX=
CLUDES_DIR ||
> > +                                   (entry_prefix_state =3D=3D
> > PREFIX_WITHIN_DIR && !(entry->flag & REF_DIR)))
> > +                                       continue;
> > +                       } else {
> > +                               entry_prefix_state =3D level->prefix_st=
ate;
> > +                       }
> > +
> >                         /* push down a level */
> >                         ALLOC_GROW(iter->levels, iter->levels_nr + 1,
> >                                    iter->levels_alloc);
> > @@ -489,6 +489,7 @@ static int cache_ref_iterator_seek(struct
> > ref_iterator *ref_iterator,
> >                 level =3D &iter->levels[0];
> >                 level->index =3D -1;
> >                 level->dir =3D dir;
> > +               level->prefix_state =3D PREFIX_EXCLUDES_DIR;      //
> > FIXME: PROBABLY NOT CORRECT
> >
> >                 /* Unset any previously set prefix */
> >                 FREE_AND_NULL(iter->prefix);
> > @@ -527,6 +528,7 @@ static int cache_ref_iterator_seek(struct
> > ref_iterator *ref_iterator,
> >                                 level =3D &iter->levels[iter->levels_nr=
++];
> >                                 level->dir =3D dir;
> >                                 level->index =3D -1;
> > +                               level->prefix_state =3D
> > PREFIX_EXCLUDES_DIR;      // FIXME: PROBABLY NOT CORRECT
> >                         } else {
> >                                 /* reduce the index so the leaf node
> > is iterated over */
> >                                 if (cmp <=3D 0 && !slash)
