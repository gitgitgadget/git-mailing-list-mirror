Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC727364AE
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194100; cv=none; b=c2iWdvRsnLWyZu/T/wwr0U0VzJfyMoX5kfFuySGnPapHZd9IR25/T3mYJ6EsLMV+JMchTdZ+5rmhJlD2VPTe5uld6l6PA5N7p4+UkjaK92uPutcwWZ83odiIY5Yvi7xsXctRqaVmbQZze27/1aYeWtNJHqfWuL3N6Jo52Wov8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194100; c=relaxed/simple;
	bh=LUWbpVcxTRfu3/oDC9zCBYKWzkBuqnaYVzqCFsTqOsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQStevy5Bshy69f2hbOtHucIIEc1ZlX5vFwJMeRJJ6seJyDaldspfcdUaoTEL1KZ5wiOyg/u7W/IBnisCN/0ZjBnGRJJ8JmGXM/syEKhY0kpjzeHAFy7numKVWoLlfwJVpmDBAhbhUcLJ6QQTnBFRP4Y9XseXRYQWZOdR05Oukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+lEgpKU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+lEgpKU"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso60978501fa.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 18:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733194097; x=1733798897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wng2o3x+umPs+BcR1A5HRnUoVGpIPcOn2oDW2frF+PA=;
        b=F+lEgpKUb9QpGb0i7aaRXB+7oCP+GpElG9bpN+PFPQqYDClcOuuDHQwg0nbQif9f2m
         KvPmxCMnjbO5MJrT2DNe5GyoafRwBm+py7fwJPGzeqoeOxf0GbJaa0+aMkpyCkll2t9q
         HE+MnU7WW4GyIFbPcTcvTOczGwKrbT+ZaH8szrvIResoKlDuEm7iMNZ7zuxEvzNlRZ9y
         Z2bY9dnF5GEAfuDeJu5MHX3kVmZlptg7pK+VkQz4fE/tQ0pJsDBf2PQ8oFRqCE+7HFhZ
         sAA61g6Nq3L5+8QMrhxNLWcIv9EKVS2ya/CZ5p6tMvuuqCS/8gWvKzi3w5oJYAHlaBM7
         F6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733194097; x=1733798897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wng2o3x+umPs+BcR1A5HRnUoVGpIPcOn2oDW2frF+PA=;
        b=fuXvDodEKVx8c3zhE8RzhtQ3hoLBXiFnpMBlqzGjfNYjkex/zHj0avje0Uf9gxzNsD
         ks7XjelBxaCbEL/O5oJfsgYStlyw/HbmTcoO48Dy9lprMU8hA4+X5pFGurdgzLs505NN
         s9wwKlj9T6eOLpKtVbjcmJ5HnNihAHdPHM4wugNerbEgakwj8/o13IRykZE3rXOvS0Au
         WoTXGLnBOGUW88N/kxEPMq5Dk5XGXUmamjptHqNNgEK77BC9vkZMFo9eh8vQFkBlFa6+
         40fAzttIE2ozC1o0M7r+o5I9CojKbwKbLpf1fFjCJ+DL1lf13kDiCNRBE0ZQ5xTq7WOO
         Zi9A==
X-Gm-Message-State: AOJu0YzRht6fqFYW4ctQk9QSXB8M3J5zsv8eD8KXaXPv8yRl8icVWIsI
	vuzjg9vZxC8HOh474mK2uuHYs1VDCpCMDU1rybrFF/Kj27QbWRlv2snYMr78Vd5lSR3tFwUEj4O
	C8Cbcvt+gkhp1cvQJkelbZrv6Blc=
X-Gm-Gg: ASbGncssIGwD80P3Uh1nCjekrA3mYHnv85dnbvhtU5qWedvsiKvFbHFOtjy0hfNZN3E
	9i5KJpVNGSdO3rbMWLsN1NerUMpYX7Cw=
X-Google-Smtp-Source: AGHT+IH5Q7s1R9AM1HUnaPOefPpAUKxRscI8B2XeuElIqbuODxkF+yj0Nh0tvnp01V5pLksRETlRhoQq+DSDBPymWi8=
X-Received: by 2002:a05:651c:210d:b0:2fb:58d1:d9a3 with SMTP id
 38308e7fff4ca-30009c52ef0mr4388951fa.18.1733194096674; Mon, 02 Dec 2024
 18:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net> <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net> <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
 <20241202203451.GA776185@coredump.intra.peff.net>
In-Reply-To: <20241202203451.GA776185@coredump.intra.peff.net>
From: Dmitriy Panteleyev <dpantel@gmail.com>
Date: Mon, 2 Dec 2024 19:48:05 -0700
Message-ID: <CAJ-DG_BLtwg51UoBN4m64ejYUcS99zu54oPYGnC5p+55tNtzpQ@mail.gmail.com>
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 1:41=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sun, Dec 01, 2024 at 03:24:35PM -0700, Dmitriy Panteleyev wrote:
>
> > You are right, Jeff, I needed to run one more bisect. But it does point=
 to
> > the commit I linked above. The bisect result is:
>
> Thanks for checking. I'm still puzzled how this commit:
>
> > 04fb96219abc0cbe46ba084997dc9066de3ac889 is the first bad commit
> > commit 04fb96219abc0cbe46ba084997dc9066de3ac889
> > Author: Jeff King <peff@peff.net>
> > Date:   Thu Nov 17 17:37:58 2022 -0500
> >
> >     parse_object(): drop extra "has" check before checking object type
> >
> >     When parsing an object of unknown type, we check to see if it's a b=
lob,
> >     so we can use our streaming code path. This uses oid_object_info() =
to
> >     check the type, but before doing so we call repo_has_object_file().=
 This
> >     latter is pointless, as oid_object_info() will already fail if the
> >     object is missing. Checking it ahead of time just complicates the c=
ode
> >     and is a waste of resources (albeit small).
> >
> >     Let's drop the redundant check.
>
> could be the culprit, though. The diff is just
>
> diff --git a/object.c b/object.c
> index 8a74eb85e9..16eb944e98 100644
> --- a/object.c
> +++ b/object.c
> @@ -287,8 +287,7 @@ struct object *parse_object_with_flags(struct reposit=
ory *r,
>         }
>
>         if ((obj && obj->type =3D=3D OBJ_BLOB && repo_has_object_file(r, =
oid)) ||
> -           (!obj && repo_has_object_file(r, oid) &&
> -            oid_object_info(r, oid, NULL) =3D=3D OBJ_BLOB)) {
> +           (!obj && oid_object_info(r, oid, NULL) =3D=3D OBJ_BLOB)) {
>                 if (!skip_hash && stream_object_signature(r, repl) < 0) {
>                         error(_("hash mismatch %s"), oid_to_hex(oid));
>                         return NULL;
>
> So it is actually doing _less_, though what it is removing is going to
> just be a pack .idx lookup (or maybe a stat() call if the object is
> loose).
>
> > I am not at all familiar with the standard process for this, but the wa=
y I ran
> > the test is:
> >
> > (0. cloned test project into /nfs/proj/ and made a change)
> > 1. cloned git repo (from github) into /tmp/git/
> > 2. ran bisect in /tmp/git/, starting with v2.34.1 (good) and v2.43.1 (b=
ad)
> > 3. ran `make all` in /tmp/git/
> > 4. in /nfs/proj/ ran `/tmp/git/bin-wrappers/git commit -m 'test'`
> > 5. repeated 2-4
>
> That sounds reasonable. I'm still not sure what's going on. It's always
> possible that commit introduced a problem, but I just don't see it. So I
> still have a suspicion (especially given that your symptom is a bus
> error) that the problem might not be deterministic.
>
> I wonder if building git with:
>
>   make SANITIZE=3Daddress,undefined
>
> and running the same test might yield anything useful.
>
> -Peff

Not sure if this is useful, but this is what I got:

AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D155141=3D=3DERROR: AddressSanitizer: BUS on unknown address (pc
0x78811e863aed bp 0x7ffe9d5ac800 sp 0x7ffe9d5ac770 T0)
=3D=3D155141=3D=3DThe signal is caused by a READ memory access.
=3D=3D155141=3D=3DHint: this fault was caused by a dereference of a high va=
lue
address (see register values below).  Disassemble the provided pc to
learn which register was used.
    #0 0x78811e863aed in inflate
(/lib/x86_64-linux-gnu/libz.so.1+0xfaed) (BuildId:
bbefe2bbdc367b0c3cfbfcf80c579930496fb963)
    #1 0x563e32ec7e5f in git_inflate /tmp/git_tests/git/zlib.c:118
    #2 0x563e32bde431 in unpack_loose_header
/tmp/git_tests/git/object-file.c:1271
    #3 0x563e32be429c in loose_object_info /tmp/git_tests/git/object-file.c=
:1474
    #4 0x563e32be5348 in do_oid_object_info_extended
/tmp/git_tests/git/object-file.c:1582
    #5 0x563e32be5dac in oid_object_info_extended
/tmp/git_tests/git/object-file.c:1640
    #6 0x563e32be5dac in oid_object_info /tmp/git_tests/git/object-file.c:1=
656
    #7 0x563e32bf8b57 in parse_object_with_flags /tmp/git_tests/git/object.=
c:290
    #8 0x563e32cfbd19 in write_ref_to_lockfile refs/files-backend.c:1772
    #9 0x563e32d0196e in lock_ref_for_update refs/files-backend.c:2582
    #10 0x563e32d0196e in files_transaction_prepare refs/files-backend.c:27=
55
    #11 0x563e32ce6800 in ref_transaction_prepare /tmp/git_tests/git/refs.c=
:2266
    #12 0x563e32ce6a5a in ref_transaction_commit /tmp/git_tests/git/refs.c:=
2315
    #13 0x563e32d8c44e in update_head_with_reflog
/tmp/git_tests/git/sequencer.c:1197
    #14 0x563e326b2f51 in cmd_commit builtin/commit.c:1834
    #15 0x563e3263002a in run_builtin /tmp/git_tests/git/git.c:466
    #16 0x563e3263002a in handle_builtin /tmp/git_tests/git/git.c:721
    #17 0x563e32633ff8 in run_argv /tmp/git_tests/git/git.c:788
    #18 0x563e32633ff8 in cmd_main /tmp/git_tests/git/git.c:926
    #19 0x563e3262c6a4 in main /tmp/git_tests/git/common-main.c:57
    #20 0x78811d42a1c9 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #21 0x78811d42a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #22 0x563e3262f6d4 in _start (/tmp/git_tests/git/git+0xa726d4)
(BuildId: 197ee6cc3c63db9e10cfed4585ab78b52790454a)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: BUS
(/lib/x86_64-linux-gnu/libz.so.1+0xfaed) (BuildId:
bbefe2bbdc367b0c3cfbfcf80c579930496fb963) in inflate
=3D=3D155141=3D=3DABORTING
