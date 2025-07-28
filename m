Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC73221283
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733673; cv=none; b=gGtvgPAJKDNPMmV+kDB01JqkGAcUB0c/cfI977uYLCKdwGACu3Hel41FIUCg3A+Zr4qYNjqOZO32FL7sN5roFSpjWV3CM6pmZHWXq9vQMpyPOL1I4KIkphCezzZJQHvI6nIp6y9+Shb/OPrVKQxUfGTWSPDpRTPzFj1jaBmp8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733673; c=relaxed/simple;
	bh=HM+ZpWuQIsvNh+iF0ajMSY6ZKoNrxEqfGLE2SNH/MvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgGg7HKUXYdmyMCJwbrzAeTc3f7apMaTO52YGQA+SxvdyBjUC02KbNULO2iQdXWSaEuPL9/t37XE7td8mOU5c1KLOBRb+ynPlLmN7Zxs8EA2LP/xvHObW0ikg8DgEiInX9q7p+5mVG8xy+bR7oK8iqk+Uz1lBL6PO3D6Id3f5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4SLCpdJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4SLCpdJ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b3b250621so47305661fa.2
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753733667; x=1754338467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvex0uHjS1w21O84LGiiXHjW0x2xRxYKDk+9329wS50=;
        b=U4SLCpdJRCApBxIicfiVkBhOjqZjbelBxvq+4tZyr2b8XIkNk1VcRYD8HjJzCTskQz
         /hC/65JIpATRrODZr0Xp7CSoNM7pKGOkyicAUlR4lB209OGrphA8NQ4WE7rbtQiGVgQr
         JQLn4SrKmAAQtBLAyaAhRc/9yi/0Hsqb8I7MKr1ZM6sULU6EAGQTgN7cuppirQvTbVfB
         aMZVNqZgeUiGDULWdlNPIgoXGrOQuipEX+6FAaJ5GLUZoYXhOMQ7yjK3hcnUtgcI6muU
         SwloLPAjXQKeZIficPJvc169bP2LH0tPiakSauCgtVm22cNEvhjL6110jeLBFCCIavBQ
         Eceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753733667; x=1754338467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvex0uHjS1w21O84LGiiXHjW0x2xRxYKDk+9329wS50=;
        b=dIZmWOa7Sga59g7mEJcSbVIMdAkl++Emyewhtys51lgWzy/AcSZ08EyxzNvE/T61vE
         p4M27CuAoBB5/JAcyj3nXZQJ/uxcuXePcCO5DPTSHryKoAX1gldLd1yN6ivlGrtypyu5
         41QRFb8bDVuFmxAz78DtSwwr5LCSm2FNX+Wj0TItA5KaS+VVBstGc/JAsMYIaqaHK1Pq
         hf6q4r34JFOpFmbXpsolhtUHWwJQZJmXH0y1vEWQpcg2ROTCL9x5KBcfXbTid1+wdPH5
         wUIG4J59F6sREmlDS5JR1MbI9BdO57bwb3dr7ZYANoZLmARG4vpjzgBKt2s89SbgGj/R
         DKFg==
X-Forwarded-Encrypted: i=1; AJvYcCXZoYI8kEAwe9tHCRy93GtELGMPd1XogrSqvOGh0QU4quqrssBgUh2Kh/2WIGZIK7ULk/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6oEjpff2uMhWydvHYN23oNSI9fdLPbDRNZTw0f9joiS6j/9gY
	JvxPU5GCY9nmiIzASKtmnyZIzewo6yo0iYkzTA9qIQcoAOKen71x7qHwi2qnz/4H/9dtv21I1lo
	olWEtbrhmdLF2eekN5tluwNMrFkLoTII=
X-Gm-Gg: ASbGncsb6MUfyBzAQQJ9JTsmZoer0zbFJruQWSyGQkyE127mNpsmGoT0ywjbpFrhzdi
	ETYUwsbSWK6cV1K09/wLTD+Dsivx1A9DP/fUL9fMOIEQzXFnxgtxauDH+dl9auXCSNusJ1aqBXM
	rQGyjrpBuUVmIrZ+bAtg6nXeJklvj2Kq5Qq7HCqOh5Nuc24iSknpwj6nakWluv6FXcnih1pQrur
	8LptqvQ
X-Google-Smtp-Source: AGHT+IHEwz8xpWRt4MAzznF6zbHxX7DAWum36K6rGzTUQoyt5MPUqhwda1QUCAHjYMfL0rBACNTVCb/09N7P0TIio2U=
X-Received: by 2002:a2e:be0e:0:b0:330:95c1:d3c7 with SMTP id
 38308e7fff4ca-331ee72701cmr36280721fa.18.1753733667170; Mon, 28 Jul 2025
 13:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com> <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
 <a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com>
In-Reply-To: <a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 28 Jul 2025 14:14:15 -0600
X-Gm-Features: Ac12FXwcb857HtEmsMfCzuYtJReokUWJZVx-VSOqjiWERHpyWf7xjM16yQE4Cv4
Message-ID: <CAH=ZcbALsQqTrvNJ4ZKmVWc6PHtTA+8k8p6_D=x=BfMXxnayfA@mail.gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:52=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 28/07/2025 20:34, Ezekiel Newren wrote:
> > On Fri, Jul 18, 2025 at 7:35=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >> On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
> >>> From: Ezekiel Newren <ezekielnewren@gmail.com>
> >>>
> >>> A few commits ago, we added definitions for Rust primitive types,
> >>> to facilitate interoperability between C and Rust. Switch a
> >>> few variables to use these types. Which, for now, will
> >>> require adding some casts.
> >>
> >> How necessary is it to change char' to 'u8' so long as the rust and C
> >> sides both use a type that is the same size? Also what's the advantage
> >> of using these typedefs rather than the normal C types like unit8_t ?
> >
> > Rust defines char as 32 bits. C treats char as signed 8 bits. What git
> > really means by char* is treat everything like a byte string, and u8
> > is how raw bytes are handled in Rust.
>
> Right - we need to use u8 on the rust side but I'm trying to understand
> why we need to change the type on the C side and why do we need typedefs
> like usize and u32 on the C side when we already have size_t and uint32_t=
?

Ah, I misunderstood the scope of your question. I could not fit an
example of why this design pattern made sense into this patch series,
so I'll explain with an example here:

If C defines a struct like below then it's obvious how to translate
that into rust for ffi purposes. It also makes it clear that this C
struct is expressly for the purpose of C <-> Rust interoperability.
struct some_struct {
    u8* ptr;
    usize length;
    u64 counter;
};

This is how that C struct needs to be defined in Rust so that it can
interoperate with C, and making C use the Rust types reduces the
chance of copy paste, and primitive type definition mismatch errors.
#[repr(C)]
pub struct some_struct {
    ptr: *mut u8,
    length: usize,
    counter: u64,
};

The Rust function would look like:
#[no_mangle]
unsafe extern "C" fn do_something(data: *mut some_struct) {...}

And C would have a forward declaration like:
extern void do_something(struct some_struct *data);

void some_c_function() {
    struct some_struct x;
    do_something(&x);
}

> Thanks
>
> Phillip
