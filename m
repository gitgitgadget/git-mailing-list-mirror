Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195A80BEC
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365292; cv=none; b=A+HxsWII8dQmAgGi3YTKVurSrVAcoVrum2RYgYUtHiT7IWOXrHXb/8lByWb22guO5yp0i3AMd9eBNrg1sIHVZe2UuTowdXRe2oVEa3Jzvvf2+aH8BAE2DzGXcpLaAugZ6NavMb3yMyEMb8uGYnGNcmYOjm8jIUr8O/S3N010ltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365292; c=relaxed/simple;
	bh=Fr+GtI1XWzJmKCQZreQD1AQBe/X7rCc0pYC/XXSkQYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcGKLIdeUXeS3tu4ZrB6uvKyxQlduXHoW63/RIIus5+pipzHFJtxCxiT7F4xbG4db9Fj4UsKDXPnDUyp11WT8HUJ0iGFzpb+I7YPbf5N4rXeJ9ICeBZONr3XEkXW6TvHsa3TKyPuvfzi/ly923jfHiDebirktKzWjGhqVVtIohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFZp8G+6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFZp8G+6"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffbea0acc2so3825631fa.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 18:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733365288; x=1733970088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18vD0WsC/DImQfxJZIByentZK599hzUEumgTEGl1i4k=;
        b=aFZp8G+6d7A4HRuuTUdHyCL2HejZyl8uNiIJYr7DalPz0Q3gmfVu24c4ydY+a0tWcU
         5FTkF9Wk//uZ/Dnq9qNihL+ypG17UtBnz29x+5KfP8F2gb+yEkYcknSp7fzcacCrlRI7
         be8HMSMbq8ciSACLOTLJxGyk0/5NV+/tlyQ/g7uR9KlkX5dN18RgfUQpo8gcBN6pGLQp
         rX4rTqPeHDqClM9JCbwXhGLVnYhdMSc+gDX9D6VFRdTurQ5AKnpFUUnJIsBtCsZP6a2i
         kTWE/M+EAVbxwWaO7Hgv41VU0fR+paX3FpqpQTYAmTaImA09zq/2GtwXfhUDOflvQZIS
         Lghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733365288; x=1733970088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18vD0WsC/DImQfxJZIByentZK599hzUEumgTEGl1i4k=;
        b=aXL9+OHqYfCNYikYkEDMv2uTIP1WUXla092xY2AYdSsv8It3afiolR5Dc+whnY0odT
         dTRZoaRS9H2Rr3LoFvMwCA2XjWTGsPGXGgkcuit85P5OgBgT47guNtlkF02jL3x4aRZ0
         BXfN23jM18v/OMLwn9lILL0fW307yAK3UxGLz+5CX2R8kt0mCo8T+KzHm9nZOHWAJy+i
         mKMiHs5tt0qe5P/5LnG95Erw9W5wfoafmn8PEB1zA/ca9MynK2q8MnkMS1tui3TPce3H
         vnVueV/UYdOwf2EztZDJNjU1c9+/8q5uD0W2pnRPY72zYQmuE/eWyfPDixXeOzCtCkll
         zAIA==
X-Gm-Message-State: AOJu0YxCw90Yanjez0rthi7Tn6YotdcDV9EIK0uiZCN8rVQU0s2+OPAP
	hbOKNOK1qr5CPKifXfvU7U5NIhKItFlXexY5qRTsNA89CRagZyIChp6TWPbSDBwtemk+34bqMcm
	IxoZpeK57hOFl8a1p9qQDYw+cF560Z5ML
X-Gm-Gg: ASbGncuaHwcnt0ii072ESbNCuXaVce7gBqBFbTdHI3wY0oZavEHQbKj35rDOV7KcqTc
	9t9nfMAuWl+NL64/RiEmCYgiP17bwIVs=
X-Google-Smtp-Source: AGHT+IH80Ce6ShK0BYWx5DJm42HvYxIJQq8QzVfMKtl4CLluICdGAzqRiOCbFKfCDMDKw0Ts5sOyznnQICED7DegFYc=
X-Received: by 2002:a2e:968c:0:b0:300:16d7:456e with SMTP id
 38308e7fff4ca-30016d7485dmr24773181fa.22.1733365287361; Wed, 04 Dec 2024
 18:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net> <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net> <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
 <20241202203451.GA776185@coredump.intra.peff.net> <CAJ-DG_BLtwg51UoBN4m64ejYUcS99zu54oPYGnC5p+55tNtzpQ@mail.gmail.com>
 <20241203211830.GA1423791@coredump.intra.peff.net>
In-Reply-To: <20241203211830.GA1423791@coredump.intra.peff.net>
From: Dmitriy Panteleyev <dpantel@gmail.com>
Date: Wed, 4 Dec 2024 19:21:16 -0700
Message-ID: <CAJ-DG_AU8cFdLqfAnEE8N2KSqnQgJ47YJszyXWOvXuuKreAbCw@mail.gmail.com>
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:18=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Dec 02, 2024 at 07:48:05PM -0700, Dmitriy Panteleyev wrote:
>
> > > I wonder if building git with:
> > >
> > >   make SANITIZE=3Daddress,undefined
> > >
> > > and running the same test might yield anything useful.
> >
> > Not sure if this is useful, but this is what I got:
>
> Thanks. If you bisect with that command, does it end up on the same
> commit?

Yes. The immediate parent commit works just fine.

>
> > AddressSanitizer:DEADLYSIGNAL
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D155141=3D=3DERROR: AddressSanitizer: BUS on unknown address (pc
> > 0x78811e863aed bp 0x7ffe9d5ac800 sp 0x7ffe9d5ac770 T0)
> > =3D=3D155141=3D=3DThe signal is caused by a READ memory access.
> > =3D=3D155141=3D=3DHint: this fault was caused by a dereference of a hig=
h value
> > address (see register values below).  Disassemble the provided pc to
> > learn which register was used.
> >     #0 0x78811e863aed in inflate
> > (/lib/x86_64-linux-gnu/libz.so.1+0xfaed) (BuildId:
> > bbefe2bbdc367b0c3cfbfcf80c579930496fb963)
> >     #1 0x563e32ec7e5f in git_inflate /tmp/git_tests/git/zlib.c:118
> >     #2 0x563e32bde431 in unpack_loose_header
> > /tmp/git_tests/git/object-file.c:1271
> >     #3 0x563e32be429c in loose_object_info /tmp/git_tests/git/object-fi=
le.c:1474
>
> Hmm. So we are inflating a loose object. It's mmap()-ed, so presumably
> that is why you get the bus error (the underlying nfs system for
> whatever reason is not able to provide the bytes).
>
> I'm still super puzzled about why this would start happening, or how it
> could be related to that commit. The rest of the stack here:
>
> >     #4 0x563e32be5348 in do_oid_object_info_extended
> > /tmp/git_tests/git/object-file.c:1582
> >     #5 0x563e32be5dac in oid_object_info_extended
> > /tmp/git_tests/git/object-file.c:1640
> >     #6 0x563e32be5dac in oid_object_info /tmp/git_tests/git/object-file=
.c:1656
> >     #7 0x563e32bf8b57 in parse_object_with_flags /tmp/git_tests/git/obj=
ect.c:290
>
> shows that we are coming from parse_object_with_flags(). Is it possible
> that calling stat() somehow primes the nfs system to be better able to
> serve the mmap'd data? That seems kind of weird.
>
> Maybe one other thing to try. Build with:
>
>   make NO_MMAP=3D1
>
> (optionally with SANITIZE also). That should replace the mmap calls with
> a compat wrapper that just reads into an internal buffer. I suspect that
> will make your problem go away, though I'm not sure it gets us any
> closer to understanding what's going wrong.
>
> What's the nfs server in your setup? Is it another Linux machine, or is
> it some other implementation? Do you know which nfs version?
>
> -Peff

NFS server is on a linux bot on LAN. nfs-kernel-server 2.6.1. Client
mounts shares as vers=3D3.

After trying NO_MMAP=3D1 with and without SANITIZE, I get:
"fatal: mmap failed: Permission denied"

~D
