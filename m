Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C947DD69
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365171; cv=pass; b=JDbGmfrRSshD0V8T9LrH7cAJRuseD+dNkw830mgnLNPR2TElt9sCbu8XlsRFmbiHh8Roti30bx+a+zr+0QNQ5M7nSMq1q1opf++1oLh/7tMcYqsRkDMjh80kt+YRu3LKb/TA4vswf9P3COAMZHHeFYJxtOvitf6oAjCVEg4uJio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365171; c=relaxed/simple;
	bh=ypfAJYdA88lGSVK1WT1xYbd63uTfObUUMGP8pNo9eWg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCyECsezGNApe+ftYOnYm2qACMLYzyC1opWpaqAENO5RG/ZRF3k85txvKAYOhPHVBWMG2/TaQBfnJLkvHb9M5SBgt4E1yzJgDiW5NX0iIBV/hO9lyt/Zo1wnIjNaxdfd4zNn49pneFnD9Mc489APfLv6Z7RmqNmG5jcyboa6//k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl2i8UFq; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl2i8UFq"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7a6e560f580so2709714137.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 02:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791365129; cv=none;
        d=google.com; s=arc-20260327;
        b=NJ9NDgC/Q1j7QikXnna/jbqthM/1xShzMafwhtp4vKi7hfaTTQDFEAUew7QNrhJqqu
         J0DrGBIz09qryfwUClP2jDFm8Dd2eP3XSIw7I/WsJUspZD8VW9EyWMr2mz048YoA1s4t
         pXpjP6iDjiRlObphCA6NPoQusBTP7AGj2USajzE2LmTDRQDjONKyX6nm+r/wrgxefu2i
         jn0N3z92GLMf4zU389Gz4oW41ygaQGKW5USe6EOvdxaP7/G0oLv/FlGv1uXvIK1snIhu
         E1YIMeu2ZOgRZ42q4Hp+yBRtzPq3BBHAanYji+lno210h3MxXNiyIrUVibDS5O3Ccysz
         1j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Lfvp7PXnCrg336eOInYtijf9GefkZec6ajlTLQnmK/o=;
        fh=Uv3BoY/4RM9pxrqM1sEzEr9JvpUQwCc0FATUaMK8DqE=;
        b=cH+UaxJZLtZoDOrTX/DRFUaUbtkUqVxiwnZZ4QEQk0kQ4CRzmOLcibsIo8JSIVdFDT
         NvtsLMuSJJYbQ3Sv8xs6IjLjS7VhlgJRLIdmLsE8rWck/vyNsbfvhUOQt+xGz635DywF
         PKcQJjuRwjzJcAUuZJfYha6HWoRmlcqhHdry/bF8OmPLuJn7qbSw+JZgKsexqYVIuOdY
         Hh4UCFBJy1nVBrUjhGTPEZ4MUBuFmeQZjis6QF4EWE5KFypl16XhNqhfW/ykPLDNtxxC
         7jvgDxGR/t3/e8aN1gRTDX5ckzftdDfY5fD5snKkBNTIKJ2UI2I60VLtjNuIZItElo8+
         BvGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791365129; x=1791969929; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lfvp7PXnCrg336eOInYtijf9GefkZec6ajlTLQnmK/o=;
        b=cl2i8UFqvIZIiMCxDV6YaeCuYjcdMZz6+/21uX4B5C8kwPyxkpRgRULb6v+4B+/zzU
         WG7Oy6SEJ0Xk2fjQ9OUh1VKni4kAoeXYX/9CVgnAamp1PbWIioXfMaGBiVeG6lDatsrf
         nFhA0zStQ9ufB+wtVfiJzEsvl2M3vkBJSY9TVRTruadn7hvhu+MNWl6KIQMHQc4+LtGO
         ACkFsDuB80kE8rx+9a/JPHxvtTyMggh8oFT45maJjacEu4Va7StxwFyfr9XkvGP0C3c5
         cYL/atMmDQzJRtVvh+oI+V6AYLgirE6/6xXDvLHUTXqn1m4OU0EIP7+C5+6U5WiFzNEa
         /Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791365129; x=1791969929;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lfvp7PXnCrg336eOInYtijf9GefkZec6ajlTLQnmK/o=;
        b=gOBC++q90/p0V5W2jZwySeOk/6D9KcReUP4nQJlpgWlKYnMN8jbVxYA8clJUTuncEQ
         OL2lRDbVEqEiVaOU03mzfaapF+qdH9MlqoGd+S1cTyKp9zxLhc9yKd74jBptX+0lm91Y
         LyckWtWpNYnzlWJ6ZADMJQVURQr2onZbjt33bFd1GXv2wjP9KZ6BlPpcyBYy+O4bijHt
         yRIwXMhEtlZrMtyqRViL2ikgs5Qz+KEmMOaaP5HU+Z1l4hupF5irjNkQ4PfaErBzrHFo
         Q5QEGBZmf9L+r6tJPIeg5Wg1pDCljackljRItapzmCt6cSc96XsqNwFmXs0P4L9Bc3Il
         btRQ==
X-Gm-Message-State: AFq9FYJmT6vBCenFBGx2FWvVcTyzkblSLXoJnEYH8nc1S7Rd4lZnXnOR
	QPyN4yvf9htV8LJX1cLuFxARBUQlGVXhbPzBpdvxT89g2Q/8mn+eGCfT+JtMxFhxian8npJr7ur
	c82hKRsahHEhMw0MeekIQQXUnpUpmlGWc2Q==
X-Gm-Gg: AYBFou3PJYDLM3WG3pk93g3lCRAD7dEGIQfB3jYSO911702pZ7XlQFMpziXw6/QymBh
	H/i+U90xuH6rd/D2rSASb9N1jcodEt0ABvQivFpXOrFYictxSb6SkHiRtXno59T/wYTZgiEMW9O
	d7ElrAgsDKVq9CBUtySNBq6MPA1oOuqSyCiF4PeXKK/SWLJAUxs6w3RDzAnaTfRZzYjYdohtGr6
	7e/Ooh6/oxMgWNHIwDsEnliPydIdTnmWeTp0mm4O3zKbV/VoVKkLw/OQshibWN2Rkkw3RFoQLog
	zz+oCI9wp6LQJNmvKoqghfwkYWtvoYU+l5GWNzZ3oTDcC4AKfDlLPYTS6NqDyi/Dr/PC64LqG/t
	7rA4yrZ/IC+LY33dOCWa5PTFRT3c+GjTFW94KPw0Pvd2rMA==
X-Received: by 2002:a05:6102:f9b:b0:7c3:90db:ed50 with SMTP id
 ada2fe7eead31-7ca38b3b980mr429536137.17.1791365129508; Wed, 07 Oct 2026
 02:25:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:25:28 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Oct 2026 05:25:28 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <asXUx8DBGNg7ltk1@pks.im>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com>
 <asTqPcCl3RdS8YN4@pks.im> <CAOLa=ZSbT6AHfU178khN7n9rHAmNE5HEM1acr96HXqXpRcSzmg@mail.gmail.com>
 <asXUx8DBGNg7ltk1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Oct 2026 05:25:28 -0400
X-Gm-Features: AclHuK_ol_mX0CDwx4-7RN9U9q6EIMkxTxmIEiSMWd1mOQ7LmlSXzvSSm39cNuE
Message-ID: <CAOLa=ZS0KPEmqeTKi89EL-j05_A6hweTnd3zUJqfhT1uQZ57aw@mail.gmail.com>
Subject: Re: [PATCH v3] packed-refs: use `fwrite()` when passing refs verbatim
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com
Content-Type: multipart/mixed; boundary="00000000000035330d065d3cb2c4"

--00000000000035330d065d3cb2c4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 06, 2026 at 05:11:57PM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Tue, Oct 06, 2026 at 11:18:40AM +0200, Karthik Nayak wrote:
>> >> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> >> index a73fc6aca7..43ad674cf4 100644
>> >> --- a/refs/packed-backend.c
>> >> +++ b/refs/packed-backend.c
>> >> @@ -879,6 +879,12 @@ struct packed_ref_iterator {
>> >>  	/* The current position in the snapshot's buffer: */
>> >>  	const char *pos;
>> >>
>> >> +	/*
>> >> +	 * Start of the current record, set when advancing `pos`. Used to
>> >> +	 * pass records verbatim to `fwrite()`.
>> >> +	 */
>> >> +	const char *record_start;
>> >
>> > The way this is written makes you think that `pos == record_start`, and
>> > thus one wonders why we even need this separate variable in the first
>> > place. So I assume that we modify `pos` in some cases without modifying
>> > the new variable at the same point in time. But if so, the above comment
>> > is not true anymore.
>> >
>>
>> Hmm. I only state that this is 'set _when_ advancing `pos`', Why do you
>> think that this would mean `pos == record_start`?
>
> To me it reads as "whenever we advance `pos`, then we set
> `record_start`". Which is not the case, we also sometimes advance `pos`
> without setting it.
>
> Patrick

Okay, let me simplify it and simply state its purpose, its
implementation will anyways be traceable via the code. Thanks

--00000000000035330d065d3cb2c4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2ec2e60fe093fc3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yR0VBTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFU2Qy85eFNYOVJtMTdpZzRreHNvRjVGL29qd3BzeQpaVG1QQnNxcVVt
dGRFY2FpaGdwWVRleVJjblRwcGhRc0YrbHk4NWkxRTExN0RFb0dmZ1N4bUhRYTk1ZlFwYWI1CmZi
UXB1VFErckZWaGc4NDYrdFRGMklodEl3Y0d2RGVHM01xM1ZVWXhYYnJaamQ3R2s5ZGorYTFlTUsx
eHNTWCsKMFRWekUvQ25rRFhaYWNhVFFUT0gwZ3RjQ3JXZStyZUxLVnREcjBhWlc5WWFSQjRQajV1
bElha205UGhCNk50NQpTRHdvaWlZcUliOEdKNDJEcFJoVmpjZVE0UmowOTBVN0xzVTVTdGdsZDBs
U2tUZTBwVUVqRGpwTWIzUnpHTEViCm9WQlBrYTRZU3ZmZ0VJbE14Y3NRQ1RDalkvc3ZkeVJzQnk5
R1RmWmJKczg4QzVIZXlnY0MxREhmTmdMRFc2UTkKODczTUdyNUhFalZoUFhlemJxSzhjMU9DNWV5
alVLUVdMVWJ5aUpkWXJNUEhtVlZ0cm9kZ0JKaE1RYUVpTENWRgpEWFlPNEhtcEtVSkF6QTdia1Vr
Uk1seUo1ajR1M0FUUzEvRGZTUk5IQW9MemRNS0ZnMVJEMjhyVEVoQS8xWlYyCmEwVVdVS3BQODFM
MUNhSkJkVlEvQzJSc1lZTDVERUZ5a1BXNkdRST0KPU5ET3YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000035330d065d3cb2c4--
