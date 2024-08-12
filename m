Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030C53370
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474255; cv=none; b=G0SCR8C5VN4G9AF5BCzf8UDnQVY7yxFRknedWKX1aoDvleuxAN0RUBEfVpu0se1XeRQo9jo5OTo0pnQFs9g4Q+iY16mY7mPWwi/ZFweL+ny2XP9HDdRTHzaHUZV/AVp1zqPK2wBkETAp0nokJFslx/3JaHdiAzlqpTLCnoH9gfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474255; c=relaxed/simple;
	bh=l5h8hSodUv9HK3gw3MaOJt4HsrnNJWmu05Qi/zDKrgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPC0h58tx8xzBLkt/Eb7H5MTr4/4++PMd0ixVkBwVe4dvcyDoDI8H+qrovz2goCeS7RePpLMpBr4z2/m7ntuK81BExiXydCp+7wEPfIIV8R7BEzSY9uZ+oUDPUc2jUbDEPb6Rx8ZOqd/p1wh4N1oMXl6n0AkXFtbVvvfdC/LrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLryiAyj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLryiAyj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so484039866b.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723474252; x=1724079052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhNuXOsaZXhFDADw38+xrjX4Eia5FNcaNpPHQ3A9ykY=;
        b=KLryiAyj1kDlWiVOD1WghK268PjgenavoM3U2LnekhYjGGtUkclx1eFIJUo4hGET56
         AXbg10ZodSOGENn/SI8ZTNqQw5Z7tfTsbwraU28WRWGx4rUucd7Ek8DqMG6Po2oRdNXV
         QUlm7wsEfJS/Z+NQe7HCpOTHzULmth1xYCcJKeRRAQQnpQzeEVP91/ITahzshoGtlpT4
         MkqM9Nx+domyUc1kI5a/vWbvMgCWGuWBTuGe5qNvEdtapX6Vl7uIHGpu8vsHPtlE2DM6
         7mz5K7T9fMHaqEfn2j8Ch/TN4UOS4AU1qUA48j6XNKb5y0uJFUe7Woh1TJoKzxuNS9/j
         uaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474252; x=1724079052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhNuXOsaZXhFDADw38+xrjX4Eia5FNcaNpPHQ3A9ykY=;
        b=Ib9JDFN+g5t/efX7s+umA1etmEBC9zfPC8WW5D3+16sFsjqmggIfQrFlJE3Bbe2eb3
         cIr+9bcukKQ2KQTYODYBQrOwZYiHaYiY2FfaJ0pN1fszWC4LkaJSqtmuai7439Rsz0B/
         uKv24uBb4QUy6r2ms1/CxJa5LXy5rDsXhY4mY2Nc+Kzfpjj1c5t/tq2vHwRd6mcfXwPV
         i7h/VljeNeLa/6/kASt3xu7GGP4ACZpVWIkHgAN4j/7ub9MUSlTD1AEprRGBd54lSzPT
         WSzs+9wjFSlUXKARzV6s6apxBzQAaWjs2lZgNZ6uB1928pdGVKMeCN228BKXIpqyxm81
         K9Aw==
X-Gm-Message-State: AOJu0YzFibMy4ricxOwOy3tgGGjZiXbQLivAmPAx5XepDXrnwinFvgT6
	uNYM7erB/RVdJw1bv+rRE22IzDJVyBc9cUQAdzUq7gdSeV1RatMcpRH68dv65aCKWO3eobt9czN
	LeHcT4dkzIC8+DlYoZyoUy35knwE=
X-Google-Smtp-Source: AGHT+IEu2NrP9Rfl00qf5LtctZrWr0xQ86MCwzdqDvGOp0z/uYsj4GXdWLrqBtpzfw+deyephUj0JP3lcIukAn7B/34=
X-Received: by 2002:a17:907:1b05:b0:a7a:abd8:77a6 with SMTP id
 a640c23a62f3a-a80ecf8db89mr52511666b.0.1723474251915; Mon, 12 Aug 2024
 07:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240809111312.4401-1-chandrapratap3519@gmail.com> <20240809111312.4401-2-chandrapratap3519@gmail.com>
 <xmqqwmkpd0qs.fsf@gitster.g>
In-Reply-To: <xmqqwmkpd0qs.fsf@gitster.g>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 12 Aug 2024 20:20:26 +0530
Message-ID: <CA+J6zkRTRQ9o=CDgsFbJx5csjDxLfQC_E+dw+Csz3hp=_c8Ueg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] t: move reftable/readwrite_test.c to the unit
 testing framework
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 23:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > reftable/readwrite_test.c exercises the functions defined in
> > reftable/reader.{c,h} and reftable/writer.{c,h}. Migrate
> > reftable/readwrite_test.c to the unit testing framework. Migration
> > involves refactoring the tests to use the unit testing framework
> > instead of reftable's test framework and renaming the tests to
> > align with unit-tests' naming conventions.
> >
> > Since some tests in reftable/readwrite_test.c use the functions
> > set_test_hash(), noop_flush() and strbuf_add_void() defined in
> > reftable/test_framework.{c,h} but these files are not #included
> > in the ported unit test, copy these functions in the new test file.
> >
> > While at it, ensure structs are 0-initialized with '= { 0 }'
> > instead of '= { NULL }'.
>
> OK.
>
> > -             EXPECT(buf->buf[off] == 'r');
> > +             if (!off)
> > +                     off = header_size((hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
> > +             check(buf->buf[off] == 'r');
>
> Why not "check_char(buf->buf[off], ==, 'r')"?

I wrote this series quite some time ago when this functionality
was not yet introduced to the unit testing framework. I'll commit
this change in the next reroll.

> >       }
> >
> > -     EXPECT(stats->log_stats.blocks > 0);
> > +     check(stats->log_stats.blocks > 0);
>
> Why not "check_int(stats->log_stats.blocks, >, 0)", which you used
> in the t_log_write_read() function?

Looks like a case of too-mechanical-a-translation to me. I'll fix this
in the next version.

> While reading this step, I looked for use of check() that is not
> rewriting EXPECT_ERR(x) to check(!x) as suspicious.  The above two
> (and a !memcmp() that is OK) were the only three such uses of
> check(), I think.

I went through this series again and I agree on not encountering
any other subpar translations of EXPECT() to its counterparts in
the unit testing framework. I'll reroll the series with only these
changes until someone else finds any other corrections.
