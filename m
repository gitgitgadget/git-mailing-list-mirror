Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56581EE7D5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780395; cv=none; b=VlRpuLWcYrMrNfSkcCy9SfCS4JVjAeGNvMCn32usK3Y+kss8gjSyLhKp+baPcPLsTYF7MVE+NQ9DaLWqJ72o4fvADNDSdoO4h2QADblZ3zn+2bzeBs7VUVBAy9onxhC3mzb2ECQ1JBwiIfENweduBN7rHo2Ezbw2odNNlXIwIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780395; c=relaxed/simple;
	bh=CFoPTqc3QHScdVXOzmBvxCP9RMDzTb2GmiX/V1oyQKw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQUBNLzhyhc1O2bbtu7reqRXo0Q4n3RjWO2tFmA0IhJNNPKKiGcOhWiE3wqs6yUtQxgFylbmwLfW/Rmnf/sp4sNibh9AhLOjWBHC9xb1BqHe9ds/Q95HriEEeaqcIIriBKHiHSKR3xghBeNdk7Wd9hmluPtPr63/QArse8Pfd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5l492F0; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5l492F0"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-532f9127978so660586e0c.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752780392; x=1753385192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCHhxrFLgGJnErK38DJiqiv8Wn7d2yj+s1+EdX2UiRU=;
        b=a5l492F0HhZGJBLYwTaQGudiVg+Ml11WdqaScnx4fe2a5B3/C6EUxelrmzOC1o5CYg
         s38891Ji3HidrK5MCkqwCpxQngOmRIQK7V9qVSqXjxjTLx6SCDt1KvufAivo5iRARbTx
         WoLASpsjtxJ9J+g4wX8+epwUP55SPt1hsSdaqd/CNPEnVAEvA4ZOsQ35xWqE8W19xCD6
         mRarm8R+NhNiA3aHSbGEXV83qp7cXSQgV+Cv2f8Yrjpt+hb8wb15HDlDH2CxsZlqLoaq
         iJ5sKyGpmOOYE2kW7U9AnYv/zkXB+5ufMR4JICApfeSm6cYQqVTEmZVgpqMIbcO/es9s
         GSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780392; x=1753385192;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCHhxrFLgGJnErK38DJiqiv8Wn7d2yj+s1+EdX2UiRU=;
        b=hp+XiuQEueemetX3u7CmpPk1RM7JXi4yk190idWuISeW1mX49OPZ14tVX3YAX4tuNv
         2ntVAJdMVAKDNj1O5czR81rp3y0odLkflF9jyeb9dK4yuJ+fIPoZkxJtz9hthCukPkIZ
         U/xefQFVldnA3LkuYDE2ytHMVlP02qpT/yG+Z7YBmCvklP4XL6sMfxAvXcUQoeMfUjvb
         eSymk62JnKoiE1lHQFqx4mjpbZAKafl1Bwht6BFUDnJ2ZZEohecj9zsCJtWmMbMdXFJm
         zcHdHKjaatVnn7Wo60ZqnWc3iCIZSUAbcdgPqoxp417vfy1DnwE8X/rQMsTMmfP/FvGV
         CTIg==
X-Forwarded-Encrypted: i=1; AJvYcCXfv0PDwKAsOugrh+GBqbTY5bHhyNmpyKhIXtZVisSnb8BmGEEP1a204A778IPDqZcTcVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJ8KFgAAHivGyXiex4cyp0G4PINXtj9dM9ha5AgCeB2YKj3oM
	kI6FdaRkUQ1IgubosHzAYxaX/buzFwNpl81WJ5+OwR+3QS6P4OVpyfAQvFjS8Cln9J78zGfDeOk
	e5z6X5/6nUp5IFAsPkQKG8LbyVh0dyDU=
X-Gm-Gg: ASbGncuBB1gamfnfdqB5sO6hWvQ8lh5fZAfIvbFBfWzXWS/oeY5j96sWU23/0RQuk9s
	Kb0Q4A3rkmWuJBh/b9DOKgXDEQlMm8nzRW2Xquw9iAsgZdewbaN11cMW/YzdUdo9oDaRgFKK+/y
	KuD3yPK5XRyjP657k+aj3HGo8i2m6bZQn3MYEps9eBU7vHZXgYaPKh3r3cpvBjKiXIwSAL60g3f
	bVH6WI5/hFC0m60QtCwI3mgtjlogxoE5QqmMujMDw==
X-Google-Smtp-Source: AGHT+IH8I22KQBxfHNX+K+ZzUf0LZ/9BEnKGWkq2luG8i5tnyiyveWCWAyQnF+iyz4KskRHqW3jSoDIicizhQXZnA0k=
X-Received: by 2002:a05:6122:321f:b0:520:4996:7d2a with SMTP id
 71dfb90a1353d-5374f701ab6mr2230282e0c.10.1752780392364; Thu, 17 Jul 2025
 12:26:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 12:26:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 12:26:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g> <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net> <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Jul 2025 12:26:31 -0700
X-Gm-Features: Ac12FXwPhP3UMlYYMCeiDDb2Qdq9ii2HctvokKa3zoSHpX9ryEYKk5844apDYeY
Message-ID: <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via '--start-after'
To: Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000a81514063a24fcc7"

--000000000000a81514063a24fcc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Wed, Jul 16, 2025 at 6:54=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>>
>> On Wed, Jul 16, 2025 at 06:19:32PM -0700, Kyle Lippincott wrote:
>>
>> > Unfortunately I can't provide great instructions for reproducing this
>> > locally, because it relies on our internal build stack (which uses
>> > blaze). Getting MemorySanitizer running can be quite annoying, though
>> > you might not have any issues if this test doesn't invoke any third
>> > party libraries (like zlib).
>> >
>> > I need to sign off for the night soon, but if this isn't sufficient
>> > enough information to identify what's happening here, I can try to dig
>> > deeper tomorrow. This run was executed on an import of upstream commit
>> > 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc (Junio's merge of this
>> > series)
>>
>> valgrind can often find the same issues as MSan without as much headache
>> to get it running (the downside is that it is _way_ slower). And indeed:
>>
>>   git checkout 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc &&
>>   make &&
>>   (cd t && ./t6302-for-each-ref-filter.sh --valgrind-only=3D48)
>>
>> yields:
>>
>>   =3D=3D2177572=3D=3D Conditional jump or move depends on uninitialised =
value(s)
>>   =3D=3D2177572=3D=3D    at 0x3BC380: cache_ref_iterator_advance (ref-ca=
che.c:409)
>>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c:1=
5)
>>   =3D=3D2177572=3D=3D    by 0x3B6CC3: merge_ref_iterator_advance (iterat=
or.c:179)
>>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c:1=
5)
>>   =3D=3D2177572=3D=3D    by 0x3A9770: files_ref_iterator_advance (files-=
backend.c:902)
>>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c:1=
5)
>>   =3D=3D2177572=3D=3D    by 0x3B7457: do_for_each_ref_iterator (iterator=
.c:478)
>>   =3D=3D2177572=3D=3D    by 0x399B43: for_each_fullref_with_seek (ref-fi=
lter.c:2718)
>>   =3D=3D2177572=3D=3D    by 0x399C09: for_each_fullref_in_pattern (ref-f=
ilter.c:2756)
>>   =3D=3D2177572=3D=3D    by 0x39B031: do_filter_refs (ref-filter.c:3263)
>>   =3D=3D2177572=3D=3D    by 0x39B2B7: filter_and_format_refs (ref-filter=
.c:3364)
>>   =3D=3D2177572=3D=3D    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c:1=
15)
>>   =3D=3D2177572=3D=3D  Uninitialised value was created by a heap allocat=
ion
>>   =3D=3D2177572=3D=3D    at 0x484BDD0: realloc (vg_replace_malloc.c:1801=
)
>>   =3D=3D2177572=3D=3D    by 0x44E941: xrealloc (wrapper.c:140)
>>   =3D=3D2177572=3D=3D    by 0x3BCAD9: cache_ref_iterator_begin (ref-cach=
e.c:580)
>>   =3D=3D2177572=3D=3D    by 0x3A988A: files_ref_iterator_begin (files-ba=
ckend.c:995)
>>   =3D=3D2177572=3D=3D    by 0x3A295E: refs_ref_iterator_begin (refs.c:17=
76)
>>   =3D=3D2177572=3D=3D    by 0x399AF6: for_each_fullref_with_seek (ref-fi=
lter.c:2710)
>>   =3D=3D2177572=3D=3D    by 0x399C09: for_each_fullref_in_pattern (ref-f=
ilter.c:2756)
>>   =3D=3D2177572=3D=3D    by 0x39B031: do_filter_refs (ref-filter.c:3263)
>>   =3D=3D2177572=3D=3D    by 0x39B2B7: filter_and_format_refs (ref-filter=
.c:3364)
>>   =3D=3D2177572=3D=3D    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c:1=
15)
>>   =3D=3D2177572=3D=3D    by 0x128C90: run_builtin (git.c:480)
>>   =3D=3D2177572=3D=3D    by 0x1290EB: handle_builtin (git.c:746)
>>
>> Bisecting doesn't tell us much, though (the first commit that introduces
>> the test shows the problem). I didn't dig further than that.
>>
>> -Peff
>
> Thanks for that, that helped me a bit too as it provides more
> information than I was getting out of MemorySanitizer (I suspect
> MemorySanitizer was producing the information it just wasn't going to
> stderr or something, or maybe I was missing a flag to get it to report
> more).
>

Thanks both for raising the issue. Thanks Jeff for also the valgrind
instructions.

On a sidenote, was discussing this at work and Patrick also mentioned
that we could try clang's MemorySanitizer. This seems to also be raising
issues on master, so it was hard to find the exact output that valgrind
was providing.

$ git checkout master
$ CC=3Dclang meson setup --reconfigure memory_build . -Db_sanitize=3Dmemory
$ cd memory_build
$ meson test -i --test-args=3D"-ix" t6302-for-each-ref-filter
...
=3D=3D3275333=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x557bd886f4bb in git_mkstemps_mode ../wrapper.c:487:27
    #1 0x557bd886fb55 in git_mkstemp_mode ../wrapper.c:509:9
    #2 0x557bd8100d1a in create_tmpfile ../object-file.c:736:7
    #3 0x557bd80f1630 in start_loose_object_common ../object-file.c:781:7
    #4 0x557bd80f5203 in write_loose_object ../object-file.c:881:7
    #5 0x557bd80f4875 in write_object_file_flags ../object-file.c:1086:6
    #6 0x557bd80f9f65 in write_object_file ../object-file.h:181:9
    #7 0x557bd8101eb8 in index_mem ../object-file.c:1177:9
    #8 0x557bd80f8bd5 in index_core ../object-file.c:1247:10
    #9 0x557bd80f731d in index_fd ../object-file.c:1274:9
    #10 0x557bd80f95e4 in index_path ../object-file.c:1295:7
    #11 0x557bd831132d in add_to_index ../read-cache.c:771:7
    #12 0x557bd8313cb1 in add_file_to_index ../read-cache.c:804:9
    #13 0x557bd73f892c in add_files ../builtin/add.c:355:7
    #14 0x557bd73f4752 in cmd_add ../builtin/add.c:578:18
    #15 0x557bd7a38b6f in run_builtin ../git.c:480:11
    #16 0x557bd7a31d54 in handle_builtin ../git.c:746:9
    #17 0x557bd7a36644 in run_argv ../git.c:813:4
    #18 0x557bd7a30e09 in cmd_main ../git.c:953:19
    #19 0x557bd7a3ca01 in main ../common-main.c:9:11
    #20 0x7f7e3f02a4d7 in __libc_start_call_main
(/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+0x=
2a4d7)
(BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
    #21 0x7f7e3f02a59a in __libc_start_main@GLIBC_2.2.5
(/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+0x=
2a59a)
(BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
    #22 0x557bd7352b34 in _start (git+0x5db34)

Possibly something we need to look into cleaning up.

> I'm not sure what the right fix would be; my guess is that the
> fix would be to modify the places where we set levels_nr and
> initialize the other fields in level to also set it to prefix_state
> (around lines 488 and 527 in ref-cache.c); and indeed setting the
> prefix_state to PREFIX_CONTAINS_DIR (the 0 value of the enum) makes
> the test pass even under valgrind. Unfortunately without a much more
> in-depth knowledge of the code and the enum values I can't
> definitively state that those are the correct values. I can say that
> setting it to PREFIX_WITHIN_DIR causes both additional valgrind
> failures and test failures even without valgrind, but setting it to
> PREFIX_EXCLUDES_DIR doesn't seem to be a problem. I also moved the
> `if` around like 409 into the following if, because that was the only
> time entry_prefix_state was used, I'd been thinking that maybe it
> needed the check for entry->flag & REF_DIR prior to referencing
> level->prefix_state, but that didn't resolve it on its own.
>
> I don't mind if anyone else picks up this fix and runs with it, but
> I'm not comfortable sending this patch myself because I don't have
> enough knowledge of this are of the code to know if it's right, just
> that it fixes the issue we encountered, and I'm extremely overloaded
> right now and can't get that knowledge nor see the patch through to
> the end.
>

Thanks for taking a stab at this, your inference is correct. Let me
clairfy some parts of it.

So the 'ref-cache' iteration logic is used to provide iteration over
loose refs (which consists of directories and entries). Anytime we come
across a directory, we add it to the level variable, which acts as
stack, when all entries under the current level are yielded, we pop the
stack to obtain the next level to iterate. This ensures we iterate over
all directories recursively.

Before this series, the seek function was used to set the prefix for
iteration, which meant we need to find the directory for matching the
prefix and only iterate over that level and its subdirs. If the prefix
provided was a directory like 'refs/heads/' then all refs under that
would be yielded (PREFIX_CONTAINS_DIR). If the prefix was
'refs/heads/foo', then the level would be set to 'ref/heads/' with the
PREFIX_WITHIN_DIR flag set since only some refs within the dir would
match the prefix. Entries which didn't overlap the prefix are denoted by
PREFIX_EXCLUDES_DIR.

This series allows the seek function to set the cursor without setting
the prefix, which is a requirement for pagination. So there is no need
to set 'prefix_state' for this functionality. Which is why I didn't set
it, since the default value of '0' (PREFIX_CONTAINS_DIR) would be the
correct setting for all dirs. This causes the issue.

So the only fix required would be

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 1d95b56d40..ceef3a2008 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct
ref_iterator *ref_iterator,
 				level =3D &iter->levels[iter->levels_nr++];
 				level->dir =3D dir;
 				level->index =3D -1;
+				level->prefix_state =3D PREFIX_CONTAINS_DIR;
 			} else {
 				/* reduce the index so the leaf node is iterated over */
 				if (cmp <=3D 0 && !slash)


The other location (Line 488), is not needed because that is the root
directory and the 'prefix_state' for it is set in
'cache_ref_iterator_set_prefix()' when the iterator begins.

>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..24feb33fcb 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -391,7 +391,6 @@ static int cache_ref_iterator_advance(struct
> ref_iterator *ref_iterator)
>                         &iter->levels[iter->levels_nr - 1];
>                 struct ref_dir *dir =3D level->dir;
>                 struct ref_entry *entry;
> -               enum prefix_state entry_prefix_state;
>
>                 if (level->index =3D=3D -1)
>                         sort_ref_dir(dir);
> @@ -406,16 +405,17 @@ static int cache_ref_iterator_advance(struct
> ref_iterator *ref_iterator)
>
>                 entry =3D dir->entries[level->index];
>
> -               if (level->prefix_state =3D=3D PREFIX_WITHIN_DIR) {
> -                       entry_prefix_state =3D
> overlaps_prefix(entry->name, iter->prefix);
> -                       if (entry_prefix_state =3D=3D PREFIX_EXCLUDES_DIR=
 ||
> -                           (entry_prefix_state =3D=3D PREFIX_WITHIN_DIR
> && !(entry->flag & REF_DIR)))
> -                               continue;
> -               } else {
> -                       entry_prefix_state =3D level->prefix_state;
> -               }
> -
>                 if (entry->flag & REF_DIR) {
> +                       enum prefix_state entry_prefix_state;
> +                       if (level->prefix_state =3D=3D PREFIX_WITHIN_DIR)=
 {
> +                               entry_prefix_state =3D
> overlaps_prefix(entry->name, iter->prefix);
> +                               if (entry_prefix_state =3D=3D PREFIX_EXCL=
UDES_DIR ||
> +                                   (entry_prefix_state =3D=3D
> PREFIX_WITHIN_DIR && !(entry->flag & REF_DIR)))
> +                                       continue;
> +                       } else {
> +                               entry_prefix_state =3D level->prefix_stat=
e;
> +                       }
> +
>                         /* push down a level */
>                         ALLOC_GROW(iter->levels, iter->levels_nr + 1,
>                                    iter->levels_alloc);
> @@ -489,6 +489,7 @@ static int cache_ref_iterator_seek(struct
> ref_iterator *ref_iterator,
>                 level =3D &iter->levels[0];
>                 level->index =3D -1;
>                 level->dir =3D dir;
> +               level->prefix_state =3D PREFIX_EXCLUDES_DIR;      //
> FIXME: PROBABLY NOT CORRECT
>
>                 /* Unset any previously set prefix */
>                 FREE_AND_NULL(iter->prefix);
> @@ -527,6 +528,7 @@ static int cache_ref_iterator_seek(struct
> ref_iterator *ref_iterator,
>                                 level =3D &iter->levels[iter->levels_nr++=
];
>                                 level->dir =3D dir;
>                                 level->index =3D -1;
> +                               level->prefix_state =3D
> PREFIX_EXCLUDES_DIR;      // FIXME: PROBABLY NOT CORRECT
>                         } else {
>                                 /* reduce the index so the leaf node
> is iterated over */
>                                 if (cmp <=3D 0 && !slash)

--000000000000a81514063a24fcc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 817093e8109766ec_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oNVRtVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUl1Qy8wZnhHeXVCYmN5elhjMVJITkxHZ3VCelQ4VwpuSWlMWEJUSGlw
TWp1OCt0NUlSa2xPWml0cTVxS253NHkwUThucE9xT2dhb3FsVFZhZ2RlWjVJQ1BsWkswb0ptCk9h
QzMweHN3bEVsUEhVaWZTQ2Fmc0tvTVlEcVdrVUFkbUJQOHpuZzEwaGNoZUM4Z1dHdEQydHNMclk4
WCtzZ08KWmRXZWNCVjFmTHo5ZEpFcGVlMjBvMm1aQm9hbVJnYWtWZEdNdWtDeWsydE5aOXpLUWN6
WkZ0TEJvZ3RKUVkyNgpFck11Zmk1YW5QM0Jpd1kxOUIzSEYyQTJBK04waUs5QURRT0xkMXdYUE9M
aXVhckV1aG1CdDZ4ZHNualVEMkUxCmxxZXJ1WnBjZWo5Y1VYOFEvVGxrRUlhWUM2T0pSQVJrZ0lq
elBGNW1VYmROcWxvdzdWdE1IUWVMWks0Yi92M2cKbjZBa0tEOVU3R253eGFIaVBpZkptRzR0SGRX
YXBEZGt0eE5ITi9DTnZZNVNEZm9IKzhFUFh1TVMvdUxvT0g0QgozelVNeStjU3Fmc0RBQ1ZMNktz
K0lINWxKYWFCd3NuSFo4aDJFWUwrNzF5UFZkcjJhdm1lYTFXV0djdWFVbUFmCnUwaVVvNnBtYjNr
Tmh1aUdINlAxeTIwQVZXbzZDdEdpcFJtR0Flcz0KPUtFVHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a81514063a24fcc7--
