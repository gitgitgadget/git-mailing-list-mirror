Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F22DECB1
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554309; cv=none; b=iUdNZKyNJ6LK0f6wVNk2x4MQAVAHtkfRpZlnGxSF3wNz98UwKDnvyIHrqOEHUP3d3FZUoN7zHVHO6LBPV2IhSez3EljA/9/okYMYhYtnzb+Kpux0wn8T1XtT9QbtQxmKAt9opEiTj6mPQOoBYmBEQRGtMc/kPQa5GimlkbWQq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554309; c=relaxed/simple;
	bh=gxltr/mfQIoiB52oth1rM4PS5+nt5q1N2uXTLIX9eOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTCRjjt0O399Xp2IIZUdNFUcJSl4eFTBh7jpzGBieas4nDkvrsBJpht/JtaLrE3WUrmx3XNXrMCpy4I65SD+swi4lB8Wv5RkzxqebhrL7VlzcwmhKVYBt22pweWqIZh8DePdD541yyk5svyRSClPi13rik4rpeO5iJIiaxkNxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L06cbXNt; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L06cbXNt"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-361d175c97fso36205411fa.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758554306; x=1759159106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxltr/mfQIoiB52oth1rM4PS5+nt5q1N2uXTLIX9eOg=;
        b=L06cbXNtrbKG9caIhnvGgciyhChmF9GkRyKTc86sYikNr1AjwnEvpZkV9/YQR9GRCQ
         VyfQ3FQCtcTulFync8auxxeyUMr48nNaHoi6+qj/HpGq6JYPS33oIyXe9aosUunfPJuo
         nVRLJgnqGbenZg0B+lt4P4UJPQFr28su53COn9jXPTnJtiiftZ5rfy3CXjUFXi1IcZxQ
         aCTbMfHzH4q/ZKscVD0X2u6gwTX6YtHKxIs/0gIZUQe9E8xzUKmu9UOcbUGHz4QGntE1
         uBqyXZqckXTeyFxbpPdDjKdkL1nDIZpCA2U+rI8LvXJxZoE7/vp89ag7twLKyqvVvkA+
         HnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758554306; x=1759159106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxltr/mfQIoiB52oth1rM4PS5+nt5q1N2uXTLIX9eOg=;
        b=I4MJBT2vAKuZ+7AqS1+g6xwUBodFaYy6Q8mafwDEMADE/0cUcHjLJEcN97ojW8yQ3a
         vhIuwVx1r/uTUcvG5KNYBJlc925Q9UhQvaN5VS2LjBP/Nnwt9CPHUJFkxsvPcg9f8ozw
         CBWMamAope+3dbpM7uaRi9U+9ukb2vpK6wbfmXRUOmIzr/XRWx1HfGzqef31xI138I32
         MaqPscpjPtlm9SlzDx5tCJMPl4LRES58NkCaRfJkanPxSo1duzGVcSdGGzmb92FdGUo7
         qv3dFiDQb3WzZsZoi3yVPvjmNf+UH7iOfOVtslS6Om+ocV1pMbKWBGQv+pHG0LyQfyxk
         2MCg==
X-Forwarded-Encrypted: i=1; AJvYcCW4nEgd8O6LRimp6Ma1LHz7aSXATdUQwR9niNMeZPA75rpSFx4wJsXve7/e6dM4H9dvpxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrMyB+DyCQPa3aKuN4vhlKuO1mRmTFHB2KZIT3oTF6TRCLiW7
	yIzOUtJtah0Yi/T9kHnom0Hu+J48zT6bfFHCguciyJedkvU/meJWBfpnASSBDuPsM8lXcFzIZtK
	jv0WblDtxWWvSE9EPGVsHdh3Fir2P/hQ=
X-Gm-Gg: ASbGncveaIn9uszN0YuHucHWbleNgZoeIq2/UggV56s8cro8XUsty44mtFvcQuQS7d6
	atW5jqJTYb7GTJ0PxB51IedZyptPEeoG8jvzKmMUhXBJwzkvLEa4GjUPgNI5vcFCQdtHkZd+wh7
	adlYytF6skYCMGczk8DbNhhG8nV6uMp84KPNdkvnK7QtA318uukmDJA9sSJYl39gRr8TeyD17ud
	+PizE3k
X-Google-Smtp-Source: AGHT+IE31Qhz/ykWXBC3Gu7VAGWQRejXuW15GVo14Ksu9WmeDcY9LEoOK0i8VL1QcG0NRegQFUCl8bJXqczG2VB6xtM=
X-Received: by 2002:a2e:be8d:0:b0:36c:7a86:19e2 with SMTP id
 38308e7fff4ca-36c7a861b16mr3699791fa.21.1758554305814; Mon, 22 Sep 2025
 08:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <xmqqcy7pc8ix.fsf@gitster.g>
 <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
 <xmqqy0qcae6z.fsf@gitster.g> <aNFIwFD6E6Lngy5M@pks.im>
In-Reply-To: <aNFIwFD6E6Lngy5M@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 09:18:14 -0600
X-Gm-Features: AS18NWDgtmlYEdlH_yYe7Vm4FFmqVc7wpGgLgk7DOV0E844lXH8woX4EwvyUFRw
Message-ID: <CAH=ZcbDkDfc6j_gQCt_q9RLP_ozYqr09i1-xe2mvhSQRgf8MGg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> I personally think either (A) or (B) would be good choices. I would
> slightly lean towards (B) just so that we have something that we can
> already play around with while building the next steps.

I'm fine with B if you fix the wording in your Breaking Changes about
Rust being introduced in version 2.52. Rust was introduced to Git in
2.49.

Elijah points this out in 1 and 2:
[1] https://lore.kernel.org/git/CABPp-BFXRbaHk9U3BX+d12bZ+ryGOp+btR0ODMw+Ht=
D7xd+MBQ@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BEiK49f_UB5UPe3qM9O7vQGGFJ8Nshw1f6W_6=
Lw7HRL6Q@mail.gmail.com/

> By the way: I'm also happy to change attribution of some of the patches
> in my patch series to mention Ezekiel as author. I don't care much who
> is listed for the initial patches that introduce Rust, but would retain
> my own authorship for the "varint" and "BreakingChanges" commits.

My only other concern is with varint. You use usize on the Rust side
and then uint64_t on the C side, but I'm ok with fixing that later as
it only breaks 'linux32 (i386/ubuntu:focal)' in the github workflows.
