Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C72FCFFC
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772114; cv=none; b=hAVR0zov6sF79/h0ThIE3q3wAj8uf0Y93haPaytZ7ogr+Y1j3HMysnkdXxt/vlPbNKpnPZWzhyLGdfGFgi5HQazb7fzksSDhk6kNjT50/wQc01/G9Io5vXw9Y7vLPkQmE9Onj9xwQYyEjk3VQJKjb+w0rqdNaRz+x/AKE/MbXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772114; c=relaxed/simple;
	bh=eA670UfNBekWsCBHjbvrmxqZCmMM/1nZFriCN1kMNc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6J9Yt2TNr8uvFBMhIWMIid30Gx1b4hwkInWl3QL06f40MPjhMdz4zvecUJAuwhifn7+8aGIkactlZph5P7hb8eiheJyGgUdXabYKVvqsCmf/ktOKMPUmqBiRmZGgfW5b1dWPX3O0J52dCr85rUL7G2QcmZss7LDUA05moyUk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ie2LxbY1; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ie2LxbY1"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fada2dd785so12812786d6.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752772111; x=1753376911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SDBHLWLxk0kugaMdjaE1xi1rp8JROoFIZKqleb2r64=;
        b=ie2LxbY1nh1keuyWmWz/692v4H1FexZEuIhLoDF3GOrSDAIan2OQkqCoaFzO43Gtfr
         AtECIG61xyuceShVUUhusB9mQM5swmMjpcFRTtfZJPYqQv1h7GgNEDjCZ87gtK3H/EYY
         Vryw1cRa9OBkHVeTwpprh3RRmtIlhWBirtXXVFFyTXwUmRhcAjuMMIdgsD8XAw7LT4k2
         uLnoNOxh0FVJxGuFIDdHQZWw29yzkQsYxIrMhIWTa6JzrGgrDyI7uxvFy3qeSTO0cXJr
         AQDzxns1X+mhWm3+E4Qje23rQ+R9KlaE0PFGlNMfS3sw5674WLKORa/Yic3tj5lQWZHy
         Qg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752772111; x=1753376911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SDBHLWLxk0kugaMdjaE1xi1rp8JROoFIZKqleb2r64=;
        b=ghvitPosovaT0j8XJ9MShMNx8vOJrCqCVKyUUtW/JO6u9p6IrxuGcXOlYMpIxJowhX
         3fyXuvuhk/Q5QqXpJxkbHF6EA1TDiV/OjIOzcNa9kg0ubnXM5VKoDkKHGIX/k/uEr4Uz
         4vtg8RoNDWkizi+mW7zXMBcU88cnjvswcAdWj26hzdp9vs/7EDERD/llHhCUazsrYlec
         j51wTqdFqMDJxuPF26hnF5MbcsTVlkPCPwZfGP3zRa/HegbVj5siJVhBcVJXketk4bwc
         qtN7sh4V7Y+umWbWgG51oK2DDflsFiEX0hRmbGLudtQ3rQlSIEP167YHA5+CvDCZyjIy
         8T3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC0ABEOhV79TcNlsVM9b3E+gTXVGqgYkoUnSece4ZCCSVevjyQQxEHRn7Uf6epPkJsnF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wq8bZ8DU3sqTC7AI6TVGD4iGzED4st+mPAj8J4du65ibyM+o
	/pt/MIHn2H/Yxc4wUrbtEEikyq8/oUvk+zNcL7lincHhAywNxbiR9UXpeXKmfewBbMkNWzY9UOb
	vG3nOWYroZJDRepLMt5W5eEuAn3JEg8gAzvE5bU2O
X-Gm-Gg: ASbGnctYxXKpLwDFTvRNe5MVpo792vxvswb3SmnsLHWZ0+sdQc8HuDwvxLOhKH+WGF3
	b33q5lKDPOljQGeg4zH86PkwRYItJfQNBagQYeftyzgTdPDKIJKlV7ffvB9REXyg5BTMwBaB9pj
	sQzGVznp+i/cXwJ66iaz5Go/VClLpAXTKzFM+Fqy+ubo281iARgO4XkR/8o5sw73rGEbIWG2I8f
	6npLyQi17vCUuhIDJv2OlLdTE1+VP+NFXMN/dM14PjAUrAT
X-Google-Smtp-Source: AGHT+IGNu0QxQuurT9ALSA2NMxKOVtAMXs3u+maMcRuoPQ/Hsm2pJF3qUwNkvCnId9vwtDrfpJxYSRgJf8e079hIA+o=
X-Received: by 2002:a05:6214:d41:b0:704:9596:b894 with SMTP id
 6a1803df08f44-704f6afbd25mr132683496d6.13.1752772111035; Thu, 17 Jul 2025
 10:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g> <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net>
In-Reply-To: <20250717015402.GA2127425@coredump.intra.peff.net>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 17 Jul 2025 10:08:18 -0700
X-Gm-Features: Ac12FXynksuJJWO_-gsAIQ93fk86z8xxselbJCGA0ARcYXP1-_Z9J3K4etr3i1M
Message-ID: <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via '--start-after'
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	ps@pks.im, schwab@linux-m68k.org, phillip.wood123@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:54=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 16, 2025 at 06:19:32PM -0700, Kyle Lippincott wrote:
>
> > Unfortunately I can't provide great instructions for reproducing this
> > locally, because it relies on our internal build stack (which uses
> > blaze). Getting MemorySanitizer running can be quite annoying, though
> > you might not have any issues if this test doesn't invoke any third
> > party libraries (like zlib).
> >
> > I need to sign off for the night soon, but if this isn't sufficient
> > enough information to identify what's happening here, I can try to dig
> > deeper tomorrow. This run was executed on an import of upstream commit
> > 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc (Junio's merge of this
> > series)
>
> valgrind can often find the same issues as MSan without as much headache
> to get it running (the downside is that it is _way_ slower). And indeed:
>
>   git checkout 4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc &&
>   make &&
>   (cd t && ./t6302-for-each-ref-filter.sh --valgrind-only=3D48)
>
> yields:
>
>   =3D=3D2177572=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
>   =3D=3D2177572=3D=3D    at 0x3BC380: cache_ref_iterator_advance (ref-cac=
he.c:409)
>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c:15=
)
>   =3D=3D2177572=3D=3D    by 0x3B6CC3: merge_ref_iterator_advance (iterato=
r.c:179)
>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c:15=
)
>   =3D=3D2177572=3D=3D    by 0x3A9770: files_ref_iterator_advance (files-b=
ackend.c:902)
>   =3D=3D2177572=3D=3D    by 0x3B69D7: ref_iterator_advance (iterator.c:15=
)
>   =3D=3D2177572=3D=3D    by 0x3B7457: do_for_each_ref_iterator (iterator.=
c:478)
>   =3D=3D2177572=3D=3D    by 0x399B43: for_each_fullref_with_seek (ref-fil=
ter.c:2718)
>   =3D=3D2177572=3D=3D    by 0x399C09: for_each_fullref_in_pattern (ref-fi=
lter.c:2756)
>   =3D=3D2177572=3D=3D    by 0x39B031: do_filter_refs (ref-filter.c:3263)
>   =3D=3D2177572=3D=3D    by 0x39B2B7: filter_and_format_refs (ref-filter.=
c:3364)
>   =3D=3D2177572=3D=3D    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c:11=
5)
>   =3D=3D2177572=3D=3D  Uninitialised value was created by a heap allocati=
on
>   =3D=3D2177572=3D=3D    at 0x484BDD0: realloc (vg_replace_malloc.c:1801)
>   =3D=3D2177572=3D=3D    by 0x44E941: xrealloc (wrapper.c:140)
>   =3D=3D2177572=3D=3D    by 0x3BCAD9: cache_ref_iterator_begin (ref-cache=
.c:580)
>   =3D=3D2177572=3D=3D    by 0x3A988A: files_ref_iterator_begin (files-bac=
kend.c:995)
>   =3D=3D2177572=3D=3D    by 0x3A295E: refs_ref_iterator_begin (refs.c:177=
6)
>   =3D=3D2177572=3D=3D    by 0x399AF6: for_each_fullref_with_seek (ref-fil=
ter.c:2710)
>   =3D=3D2177572=3D=3D    by 0x399C09: for_each_fullref_in_pattern (ref-fi=
lter.c:2756)
>   =3D=3D2177572=3D=3D    by 0x39B031: do_filter_refs (ref-filter.c:3263)
>   =3D=3D2177572=3D=3D    by 0x39B2B7: filter_and_format_refs (ref-filter.=
c:3364)
>   =3D=3D2177572=3D=3D    by 0x18C1D2: cmd_for_each_ref (for-each-ref.c:11=
5)
>   =3D=3D2177572=3D=3D    by 0x128C90: run_builtin (git.c:480)
>   =3D=3D2177572=3D=3D    by 0x1290EB: handle_builtin (git.c:746)
>
> Bisecting doesn't tell us much, though (the first commit that introduces
> the test shows the problem). I didn't dig further than that.
>
> -Peff

Thanks for that, that helped me a bit too as it provides more
information than I was getting out of MemorySanitizer (I suspect
MemorySanitizer was producing the information it just wasn't going to
stderr or something, or maybe I was missing a flag to get it to report
more). I'm not sure what the right fix would be; my guess is that the
fix would be to modify the places where we set levels_nr and
initialize the other fields in level to also set it to prefix_state
(around lines 488 and 527 in ref-cache.c); and indeed setting the
prefix_state to PREFIX_CONTAINS_DIR (the 0 value of the enum) makes
the test pass even under valgrind. Unfortunately without a much more
in-depth knowledge of the code and the enum values I can't
definitively state that those are the correct values. I can say that
setting it to PREFIX_WITHIN_DIR causes both additional valgrind
failures and test failures even without valgrind, but setting it to
PREFIX_EXCLUDES_DIR doesn't seem to be a problem. I also moved the
`if` around like 409 into the following if, because that was the only
time entry_prefix_state was used, I'd been thinking that maybe it
needed the check for entry->flag & REF_DIR prior to referencing
level->prefix_state, but that didn't resolve it on its own.

I don't mind if anyone else picks up this fix and runs with it, but
I'm not comfortable sending this patch myself because I don't have
enough knowledge of this are of the code to know if it's right, just
that it fixes the issue we encountered, and I'm extremely overloaded
right now and can't get that knowledge nor see the patch through to
the end.


diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 1d95b56d40..24feb33fcb 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -391,7 +391,6 @@ static int cache_ref_iterator_advance(struct
ref_iterator *ref_iterator)
                        &iter->levels[iter->levels_nr - 1];
                struct ref_dir *dir =3D level->dir;
                struct ref_entry *entry;
-               enum prefix_state entry_prefix_state;

                if (level->index =3D=3D -1)
                        sort_ref_dir(dir);
@@ -406,16 +405,17 @@ static int cache_ref_iterator_advance(struct
ref_iterator *ref_iterator)

                entry =3D dir->entries[level->index];

-               if (level->prefix_state =3D=3D PREFIX_WITHIN_DIR) {
-                       entry_prefix_state =3D
overlaps_prefix(entry->name, iter->prefix);
-                       if (entry_prefix_state =3D=3D PREFIX_EXCLUDES_DIR |=
|
-                           (entry_prefix_state =3D=3D PREFIX_WITHIN_DIR
&& !(entry->flag & REF_DIR)))
-                               continue;
-               } else {
-                       entry_prefix_state =3D level->prefix_state;
-               }
-
                if (entry->flag & REF_DIR) {
+                       enum prefix_state entry_prefix_state;
+                       if (level->prefix_state =3D=3D PREFIX_WITHIN_DIR) {
+                               entry_prefix_state =3D
overlaps_prefix(entry->name, iter->prefix);
+                               if (entry_prefix_state =3D=3D PREFIX_EXCLUD=
ES_DIR ||
+                                   (entry_prefix_state =3D=3D
PREFIX_WITHIN_DIR && !(entry->flag & REF_DIR)))
+                                       continue;
+                       } else {
+                               entry_prefix_state =3D level->prefix_state;
+                       }
+
                        /* push down a level */
                        ALLOC_GROW(iter->levels, iter->levels_nr + 1,
                                   iter->levels_alloc);
@@ -489,6 +489,7 @@ static int cache_ref_iterator_seek(struct
ref_iterator *ref_iterator,
                level =3D &iter->levels[0];
                level->index =3D -1;
                level->dir =3D dir;
+               level->prefix_state =3D PREFIX_EXCLUDES_DIR;      //
FIXME: PROBABLY NOT CORRECT

                /* Unset any previously set prefix */
                FREE_AND_NULL(iter->prefix);
@@ -527,6 +528,7 @@ static int cache_ref_iterator_seek(struct
ref_iterator *ref_iterator,
                                level =3D &iter->levels[iter->levels_nr++];
                                level->dir =3D dir;
                                level->index =3D -1;
+                               level->prefix_state =3D
PREFIX_EXCLUDES_DIR;      // FIXME: PROBABLY NOT CORRECT
                        } else {
                                /* reduce the index so the leaf node
is iterated over */
                                if (cmp <=3D 0 && !slash)
