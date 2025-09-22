Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39719315D4C
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562364; cv=none; b=U+As7jN8lxL8BdXGl4rUnsKMQrnD32BnyURvX1cRT4v7n6bYqbWuaMedBdRRXxVUZTXXnSAyKfLECb2P2zKMsA+D82Z8RTho9aQNUbknRYFomn1GFMByzN4+DjBRoaA3nbBqLDr4tFXhA6neaBigHCut2i7kxGthNua7gMJPnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562364; c=relaxed/simple;
	bh=sf41joswSBJJtPMMDjRiUGTgBUP79aJpPmoX3X5RaHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFkFalCodUHSaQ637LC/CxY0fUhODf5P82v4u5oKXJo+jFkgSW71n7R4mgJMH1gTwJreqa5xfbDF66sdrLmS6T++fxqm9GLyOrEDZsXnxPa0EOmchzkqhq7yXM79D5nmTZ/5rwdy9Q1nHVgA9kmCEAXszlPVut40lK2KO8XQ58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTRpgSsL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTRpgSsL"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so39666221fa.2
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758562360; x=1759167160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf41joswSBJJtPMMDjRiUGTgBUP79aJpPmoX3X5RaHU=;
        b=FTRpgSsLr1TJfxM69icArUL5huZ4mbl3qxhW/2Y7SmQAss4hJJz5Eoqkb/kYptFGWg
         qQwgtMFNyEOIsdvi0KLp6mDqvsN7j6uesDmqiwAyD/Q/As5Bzg1NTzjSrvuAsaMF7oDy
         m9LJ3mwoz4s3muOhxDgfxQvH2QLypd4/IVBmTskFXXIH/7ZN11tzAjN2F1vxGm5q+FCL
         XS3l1eg2bazJq5h3c0DAtXkS09jZ5js+dIAYiqqxw6RKGRfSDX6zIYs0bgt4DYjJa+Bu
         9mtKXlfQOKEf4ms8xkSGLCh4Qs/YEOdgYqCbFBTBZVBbH9WR0x2Tp6YMs6/VLWgPtuB/
         PntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758562360; x=1759167160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sf41joswSBJJtPMMDjRiUGTgBUP79aJpPmoX3X5RaHU=;
        b=GNCK/q2gX8dtJ/6LJTlvbNCo9q19sScLyaUmfzssUIdSBBf+7UKAMyo8gIkQRvcJqk
         5en7r1Vj05WpOBp1HXMcgmzMLxjnacCEmId/4/Rs7qh8s0d4WQxQmdNG/1+WCoVi89lC
         TMi3vdpw7AKanGk8+XVYx/0NS6zybqiY/BhPQr44DFXUaexJmpBHAK8AtpyE0f5gdUjd
         NxQHOOXdXTjTUQLWmGdxa5EtCjWqcpPRNRzDACLEqo1Rh7ltlRJGTwvVXldTPA5tUMkT
         NlTBbUJqv8NDwnjV1vfnRQU/qiIG0mOycActzgiw2lIrJIr06lqKnCdZoN7n/OUz2K3B
         e9aw==
X-Forwarded-Encrypted: i=1; AJvYcCWagd+tOJpbH9doLC3iRLec1rqrijPvDqU5HfzqeC+kl5kViM82ZX0EROGEQunLLqHr6vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4puH9V+euzY54ABkh6ascQ6KYdhO4lwv9FYgczTigNP6RLoH
	RvNkXGKMZAAjy33DStyPHVXuWg/gdqVoK8rE57PQDIvsQa3jHaBkMczA2kRIt1iJzLroMjI0vj+
	kZRR81GC4KTH60H0OWXr7CEaoXv0+GkQ=
X-Gm-Gg: ASbGncu4EsAS6EKL7TWT7LBtMijsTJ4bQAAiemjLn3CbZrrDVOrDp28mOf8h6ZBU14/
	qOzGQeaNjkRHCKNmSChc3bBerQNFyJxYZTs3W6UY0f0+mUNdTPod7yN2SuE8wjdOdj2/1qU/OQU
	IGKz4T8dTG0XRVAjYCa1gKXFZIXIHPKygJIbPe5l822DmuN58CykA5S851e12PtPvCkZKprC+O2
	6V9Js5v
X-Google-Smtp-Source: AGHT+IGj8Prz07hh4klZq/KUsFY25hNYrCEIwI4KYfUHy1AUPDLTim6w+970UGNKyMm5HA9/+oVYthFxCLR7++2x6Xc=
X-Received: by 2002:a2e:b88f:0:b0:36b:631e:2aee with SMTP id
 38308e7fff4ca-36b631e2dc4mr14238231fa.21.1758562359986; Mon, 22 Sep 2025
 10:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <aMpODEpyaaVhFMO0@pks.im>
 <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
 <aNFIozagGc0MoseL@pks.im> <CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
 <xmqqikhav3i0.fsf@gitster.g> <CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
In-Reply-To: <CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 11:32:27 -0600
X-Gm-Features: AS18NWCoP98saIaA1svrNIW9A7LAK2rCQWuod5YvL1UDfKGPCSz8uMFE5TZly2g
Message-ID: <CAH=ZcbC_ecyPeLS_0DfN3+w9RTqcrt6Je08RPXqb6pJVGaPjuw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:23=E2=80=AFAM Ezekiel Newren <ezekielnewren@gmai=
l.com> wrote:
> Cbindgen parse's Rust and generates C header files; If a field in a
> struct uses u16 as the name then Rust won't compile, and cbindgen
> can't create the C header file.

I just tried this in Rust and it turns out you actually can use u16 as
a struct field name. My bad. I think that's a bad idea and should be
discouraged though.
