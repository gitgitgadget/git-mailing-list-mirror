Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BE24677B
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683004; cv=none; b=eXacNmbTmU9iAAEluJK7vZA/+8iovbHxolcJroic40hDFneZcxtiRdhmIcpS+MJPCAHtiYX+NjLKAL3tKKWhQcw2bDYoj3CR1wLJnvY3tSHH3aXSk63zHNFE/DRRXYjZNQ0fAbtlJ/lH6qIR3Av/DaYHXygRC4qthsXQiW8ODnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683004; c=relaxed/simple;
	bh=TsiA7+t9aRDV7hWsbTgtf4bEpay2G9UKtiP0qwU+nrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMKTg6Rd+SRG0fzcnSZouQ5YdTPxn3FO7DTU7os9/kK01GF4XKyD0j8n7hL1pjzoM9Uc8P0Ixp8SwhdxZcmlyf2NmGWSjI1nl5r4HcMjkZh5ov33gG+AUxsnwxqIgda3hGk7EFKPCrkrwcGJkBJjANuQ4AFozpMKn1K1l5vxnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI3mkLGk; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI3mkLGk"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dbd150efe8so941920137.0
        for <git@vger.kernel.org>; Sun, 09 Nov 2025 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762683001; x=1763287801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LVJAIrfma5zFbN68SaHkVUv1HBLiEbkAxBALLdn9aZg=;
        b=ZI3mkLGk3tDA+saWLUquTZwqTwLV87m/1O8fZFCm33m/SQCofzEkxGrsNTc8KV50rw
         zCmUcXN7aiQOA+xwLhYdyMKsex1y4NRBKl2NwxbErDWJ9oRqmXwwJbVqYgvqsj8st8W3
         ueZxB2CYbtnQ/YshwJVCDLHUEt7S1js6IlKty3YhDYKD43rjWvmB+cQupIGhGaLNVdfL
         pX1FonN+s1q64qwlAAlb300/nXBf3bixMXx87dB0fjDNXvw7lpGNiL4jRbR35yi9umMO
         EjFSV18QkS0eg3qG20ZMaiB+G2Fr/T1KfEZJ6R+0mJ9HpYXBMD+Bvu+kRrhWMpdGpGL5
         PYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762683001; x=1763287801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVJAIrfma5zFbN68SaHkVUv1HBLiEbkAxBALLdn9aZg=;
        b=qvFkmQNHb1h+Rhjg3DJJ9GErmGDqCdVsmulyWMdYKyTpqzUQjP4iDHzfB6cQqBlrJa
         mPh4b9EA3DAsvZyflMq8O0l+2Nz7om0JdNCn42MZV1Z5liRaNOMB+y9weJEUiZh9NNRE
         3a5e0COdbvg4hZ/Wi6agyQ6QyJouLXfiZSwy4PkoQpYcBjfW5o1wwrN1e8Oko4EV+Bdf
         sHW/MHUhkQI/5+s7zVjFwYeyfSdLnlafa68PJpQgzkf6GVE6Mim223k2fYWZnzuhwAtM
         F6Q4Bra4+9Ivba7pZFOYtZyFKq8ScXCdc9jEgQuGpWV77ag3odBvw2vq1vP2M2gWmyY/
         C2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWLPOAUFV/zH4xKGHqUDZbnVgJRY+1Z0YM9qSPfl1mu7zQ+8GKjFhZfmXVMBbH7g6CW3Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSUopE0UQf9RD51kgzB7GGT+CX9HMUpmo9IacG+GsBzcQwScO
	HDKkNKgvhZt/xYSfD0qkV47uUNp3WinvHpTeyVFA+fGYpQ9LRnh6JbxEPbvT2oG3km5s/S8OdEn
	zKjx7AMR9hjJDNVvwk8azXlVojkAwqlA=
X-Gm-Gg: ASbGncvABUmOsBl4DX/teSOLhleQceS229P+jU+KTiHrihvwg1V90gVOMPDHB6pnEWM
	nHYKy4r8l9EngCmOfiR3PmYSDM0LBQOuTdhmIdLEq6hjFsPP/6d3nNxPa+ofa+Yip3zbcwYE+KD
	h8TBViBDVygnlJskXjzBKeYloS5zFPQguiEz5o2Z7MIB8xGIsUmb1yByIbe7f8GnjzWe8lSz2p+
	W4ki6O/zFB0z+YkcgomNDyRn/k/04a0D072r+tat0ZjnNKmTBm0QchXIzrxlWyjnzgN1Jo=
X-Google-Smtp-Source: AGHT+IGWAdKJl9SKY2W3xDgJM6P43OKwqpMP51n1BMitEWR7cZWmBaJO+sa5MV/+NeiRqZSkblptHYrC/h1DSjzAWUk=
X-Received: by 2002:a05:6102:32cd:b0:5d5:f40a:4cf1 with SMTP id
 ada2fe7eead31-5ddc47d646amr1390446137.24.1762683000802; Sun, 09 Nov 2025
 02:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
 <e1fede83-bed0-49e9-84a0-f026b9df6039@kdbg.org> <CAEyHQXWd4kN=ehWh0Y7xNnPGk3ofXEc4=PvSYaZM91TFyLtnpg@mail.gmail.com>
 <CAPx1GvcwAj5k0QEwxS8h=VNBNTgtxAaXGAf1a38Sb18COuSHEA@mail.gmail.com>
In-Reply-To: <CAPx1GvcwAj5k0QEwxS8h=VNBNTgtxAaXGAf1a38Sb18COuSHEA@mail.gmail.com>
Reply-To: bhavikdbavishi@gmail.com
From: Bhavik Bavishi <bhavikdbavishi@gmail.com>
Date: Sun, 9 Nov 2025 15:39:49 +0530
X-Gm-Features: AWmQ_bmq396SXoBl0aXLjcgPEX0-750YGaKxMCD-eE23WGHx7sbOLnpwo0KkSeM
Message-ID: <CAEyHQXXKdVNRKzrTPJ1uVYVkpdMfCbSeXFW2TQJx6GNa4xStPw@mail.gmail.com>
Subject: Re: [Bug report] git cherry-pick silently ignores error whereas git
 apply fails for hunk apply
To: Chris Torek <chris.torek@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the explanation this helps.

On Sat, Nov 8, 2025 at 4:28=E2=80=AFPM Chris Torek <chris.torek@gmail.com> =
wrote:
>
> On Fri, Nov 7, 2025 at 12:35=E2=80=AFAM Bhavik Bavishi <bhavikdbavishi@gm=
ail.com> wrote:
>
> ["git apply" fails, "git apply --3way" and "git cherry-pick" succeed, and=
:]
>
> > I've compare the file content of `mango/utils/apple_utils.cc` for `git
> > apply --3way` and  `git cherry-pick` is same
>
> This is all entirely normal.  You're seeing the difference between a
> "patch" and an actual "three way merge".  The cherry-pick command does a
> three-way merge using the complete information available to it.  The
> apply command applies a simple patch, or, with "--3way", searches the
> patch for auxiliary information that may or may not provide the extra
> detail needed for doing a three-way merge.
>
> To understand this, we need to illustrate the difference between
> these two ideas.  Let's start with patches.
>
> A "patch" says "we expect the file looks something like this, and
> we would like to make certain changes in these areas".  If the file
> *does* look "like this" in the indicated areas, it's easy to apply
> the patch:
>
>    --- lines 15 through 19 of file.txt used to be like this
>    +++ lines 15 through 20 of file.txt should now look like this
>       we expect the file to
>       look like this
>     + and we should add a line
>       and then the text
>       goes on as before
>
> If file `file.txt` has the desired lines at lines 15--19, and we
> add the indicated text in the middle, we've "patched" the file to
> match the new desired result.
>
> But what if the file, at lines 15 through 19, reads:
>
>       we expect the file to
>       look like this
>       and we should add a line
>       and then the text
>
> Well, it sure looks like that patch was already applied.  We
> can *guess* that it was in fact already applied, or we can search
> for lines before or after lines 15 through 19 that read the
> expected way.
>
> Patches can add, remove, or (depending on the kind of patch)
> change lines (or characters within lines, or whatever: the
> more general form is "symbol by symbol, add/subtract/replace").
>
> A *merge*, by contrast, takes two separate sets of patches:
>
>  * First, there's a "common base version": a version both you
>    and they, whoever they were, had that's absolutely 100%]
>    identical in all respects.
>
>  * Second, there's an "ours" version. By comparing the "base"
>    version to the "ours" version, we find out what *we* changed.
>
>  * Last, there's a "theirs" version. By comparing the "base"
>    version to the "theirs" version, we find out what *they* changed.
>
> This time, if we already have the change at lines 15--19 / 15--20, we'll
> see that they and we have the *same* change.  We can silenly discard
> their duplicate change!  We don't have to guess whether we have their
> change, or whether the lines moved around somewhat in the file.
>
> This same method handles removals (and if they're in the difference
> format, "changes", which are just "remove and add" combined into one
> block).
>
> The way "git apply --3way" works is that it looks for a text line in the
> patch of the form "index <hash1>..<hash2>" before the diff listing
> (which has only add and remove, in Git's case). The first hash ID in
> this pair of hash IDs is the Git-specific unique identifier for the
> original version of the file.  Git then looks in your own Git repository
> to see if you have that version of the file.  If so, that's the
> "common base version".
>
> If Git can find the base version this way, Git can then apply the patch
> diff to the *base* version, which produces the "theirs" version,
> guaranteed, because the change *must* apply to the base.  That ID is
> *unique*, across the entire universe of every file in existence
> anywhere, in any Git repository.[footnote] If you have that ID, you have
> *that version* of *that file*.
>
> Now that Git has the base version and the "theirs" version, Git can do
> its own three-way merge: diff the base vs your version to see what you
> changed, and diff the base vs their version to see what they changed.
> This can still have conflicts, but now at least they will always be in
> the right places.
>
> Chris
>
> [footnote] This is clearly nonsense, due to the pigeonhole principle.
> And yet, Git depends on it successfully (modulo carefully engineered
> hash collisions, currently possible for SHA-1 but not for SHA-256). With
> some clever mathematics we can show that the chance of failure of any
> given Git repository is quite small -- far smaller than the chance that
> your computer will just randomly explode into flames while you're using
> it, for instance.
