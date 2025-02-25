Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB391624D7
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467689; cv=none; b=u1xuKwXpJPN+5YChpaCzJ34GBzXOZe/HdFACcNCdatyD2jgunQ7fO+8vCcTy8t/H7SZ2pKEa5mfPBHMp/P1BXxxU87Z4AWioo3NXtojuWoF6XvyYSjo0v8INFJ9jh0yJWXxCbGI+1tiycollKFrbpshhpnjkQOuDZ3Ql/zJBUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467689; c=relaxed/simple;
	bh=lIoRwmAKLg0B4IQujjvZw0LmLEe9NAL8WNkjDKnYYEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQnYsRzaTeZQlyXWBS7tkmEk5PAWS4aA2nIzOl6YRytzUYS5WRYWkiMsH6jrK7pqWNljfRROgq79zJRdcgETS+15irTR4iyO/TBVU8lXvcVpIqx7sFicwe9q7uzQgwrsTaOIh0Ol1l3Wgv7ZD7c7muzVZgv46ouLt8oJq43KxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+U9Jcv4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+U9Jcv4"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef60e500d7so42477997b3.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 23:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740467687; x=1741072487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AeNzv6bQSxTFyzq4y0rURX1K8IEy08h/27T8+MRtiVs=;
        b=m+U9Jcv4gzWmJcHv/QsZJWJmbtwKzR4USabGXaMpD++rjcpgf+Dpfx4YoUhiaCUZQX
         4kkbkZokZVsA+baDIlrnoUpZBdpNtKDB4vkotzyQlfFFar5VJkCnzmupJ/8dGdfJ//kw
         ZHddqQTvN1l/70PsbNHVmJ1I+Ae+zOyOMpoTjOPchZqNBkOZCVbAaSvKZknJFcE9xJuj
         oJeVzOHZ7F6ehO/z/dCZZAMPgFmEIp4g+IdJZ4A+xTHdlsSIofPLwAK/P1brVWfiTFyt
         GZUebjYZ0kuP81gVRCaUXo/3nq1LMskpHEL0NNCeKz49QfDxoPLfKxAxi6mUDJJbll75
         ogYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740467687; x=1741072487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeNzv6bQSxTFyzq4y0rURX1K8IEy08h/27T8+MRtiVs=;
        b=nmfLjhx4rmKOnNeDvOecGFe/IpSZ/dKoBX2IhTK+JAvHCiScBo5vq+nbJzx23j2+Gq
         WZ/zCjrhfiRiX8zCToluQoxuu6Irv+jesAAb0NqS8Gafxnbrn9CsG8HOmAPUKopB2foR
         PIg/VfQUOmMrrqniRGBVBM7CZN0MXEOTiowd78OTCpQJCr7uyPcklSERXOiEth/qOTxD
         r+p9HkkMC07IY3070KL3pRGOlVJkL/qp59cCHqqlmuu6KEnrgT8AvP2HuLNAUzJZ/h6C
         99hIqJKPCyqtroUcdq60ebDKfiPj+C9hbsv3tZA/TmJLgHxwgLkVPh6Eu1t8sz/uuNH9
         O4xQ==
X-Gm-Message-State: AOJu0YzCZHXfknUH8FPnjoStytlWNW/SI/5VK8z7+FUkpQxNFxsZ6lkL
	JKfHu/Z45JesdfH9/1O0Covdl64jSs3bPsJOwPFpqBeXyxo6tSQW40B10zVBXq44CDzUBNfGZAk
	9QvH4GrSusQYp8eSDUApVksEl0cutv++c8j2y5Q==
X-Gm-Gg: ASbGnculmN4gbuZ9hysyz828BggZyLIbYwr8ISDFy0o9MfQW3TM/snvZwfXiYAVUYg6
	/ugGFGUJHaGctzSxppZfHgaEi37iS7ECvYIK/1hjgsZ9vNrcFYPfFsegbiyyAUe8ogi4HPgoZFe
	WWtKbsEcE=
X-Google-Smtp-Source: AGHT+IE9yWYBd0JxCxkHT4/KrWkFLBSYRNCdRfWCR09fa3TFFGPBrl7pBpvPAVRWheKndzdiGyp4gHvFwUHcVx+gmKc=
X-Received: by 2002:a05:690c:6807:b0:6f9:3dd2:7941 with SMTP id
 00721157ae682-6fbcc861104mr136421327b3.38.1740467686772; Mon, 24 Feb 2025
 23:14:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220082959.10854-1-kuforiji98@gmail.com> <20250224152704.70289-1-kuforiji98@gmail.com>
 <20250224152704.70289-2-kuforiji98@gmail.com> <xmqqwmdf5is1.fsf@gitster.g>
In-Reply-To: <xmqqwmdf5is1.fsf@gitster.g>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Tue, 25 Feb 2025 08:14:35 +0100
X-Gm-Features: AWEUYZn75zzT9GNStb0Fws3tz5T6yKZxyAawDs-d1mO23gA6wF9inpyH3QqWa7c
Message-ID: <CAGedMteOTewr9=m6=5NztLA_cDiuq=uEt-A26rFWRCmEw0=_UA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] t/unit-tests: implement clar specific oid helper functions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 18:56, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> > -static int get_oid_arbitrary_hex_algop(const char *hex, struct object_id *oid,
> > +static void cl_parse_oid(const char *hex, struct object_id *oid,
> >                                      const struct git_hash_algo *algop)
> >  {
> >       int ret;
> >       size_t sz = strlen(hex);
> >       struct strbuf buf = STRBUF_INIT;
> >
> > -     if (!check(sz <= algop->hexsz)) {
> > -             test_msg("BUG: hex string (%s) bigger than maximum allowed (%lu)",
> > -                      hex, (unsigned long)algop->hexsz);
> > -             return -1;
> > -     }
> > +     cl_assert(sz <= algop->hexsz);
> >
> >       strbuf_add(&buf, hex, sz);
> >       strbuf_addchars(&buf, '0', algop->hexsz - sz);
> >
> > -     ret = get_oid_hex_algop(buf.buf, oid, algop);
> > -     if (!check_int(ret, ==, 0))
> > -             test_msg("BUG: invalid hex input (%s) provided", hex);
> > +     cl_assert_equal_i(get_oid_hex_algop(buf.buf, oid, algop), 0);
> >
> >       strbuf_release(&buf);
> > -     return ret;
> >  }
>
> As you are not returning "ret" and making the function void, you
> made "int ret" an unused variable that needs removing.
>
> Thanks.

Hi Junio,

Do I send in a new patch series addressing this?

Thanks,
Seyi
