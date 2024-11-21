Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2121D47A3
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201608; cv=none; b=SYqLtUPJKOHRPZ9c146Ymd+0xR4RPpHCinAJHSYwMeYWpu1FnPOaq4un4MytG8jBoAXPJNsqXDMuzhs2XXPUHnXUjqORZB5WTaxGFn74IwU9/OphN5Ee7GuiFCd3lzNVtL9kRaKXMeLJ7o1iAjrsUvjeC3wBPXHZXtIcpu8zoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201608; c=relaxed/simple;
	bh=v8FXkjBw/LeprhyStj1ZhFd1cI6VnLVgqQWslUYZ/wc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7R3u21OeWaq18kPsBDc8WvaydVjMJKTpJuRxKA/uopqiGfBT4uCWM8ClqM/Z5+DcYzfvDOXwT9jvI64u6mNtsLMHRnTBMJP0gSl3Z/NkLLDNj8SrixsnNfDBGlbjtwfIPVMhGpZ3S/GaRw+kmH+io2U1zbxNUowybov0JLfNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa5VXvvi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa5VXvvi"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460c0f9c13eso8086011cf.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732201605; x=1732806405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=su+gactrCp1rFTeV7NbGONJMIYjFl1aGr01op0q1yF0=;
        b=Xa5VXvviWPAkH/gPtbFvHzZl7s698wDIjgMYjQWplMiMdYHBKX04kD1J2LqWhRzOFQ
         gipReeB2ybMmLzjVAzk0ncOYC3hmt6JH2132tNI3WoTq4cibxuHsI5WHMyCn2nw/Oavg
         A68SKjk95KcqSUzWNFERi2CGHuzfZsomWY5iWIhLrF4rYpj1nGWAR01iK7IJx1LgM4vM
         rwxGc4ShL24JSfGxENmRbnCflOF4GZmoOAQVEOo7uLH05Gl7Wr2jvFtjGNgn/kDNcAsu
         Tci8wfJSqRy3yuCB0smdA+7qgbmR27Q614Q+aIOzlQvjJCJ9NxSY5SQjO0JBOzjRuxT2
         wvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201605; x=1732806405;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=su+gactrCp1rFTeV7NbGONJMIYjFl1aGr01op0q1yF0=;
        b=CDeBo4wAITXip/fl4pTfDQGZkPbuR+nf9lMwwzi9tvK53Gm4RUSWz4JJYbiy9P1eMp
         CC5cJe8fkqSz3VE70NwH5Jvyo1XydTegSeyak9EnRdqTWj5WWz09b/yZempLt7+h1gtp
         aqdvCpj3eVrrYP6UD4uEQuGp92Lt4ZLsnIJ42luppKl8NCQHw3+KIUgMc2cmnep7dbez
         Wx4gg7UhhZk9rEPprOV4QA4VZyW8gR7/aDM1oEUgaCjnlEkh3R6JJv3QWmzlyVzuiZ3W
         6fOYQwyVR8CgqwgjEv59FXqGpRm3E6qArvEffWTSQT6aMqoLNuNkZSTvi+kmpLD5wQKB
         1i4A==
X-Gm-Message-State: AOJu0YxnC6MBHnv6VL7/hII6Ebxe6RmfTTz6CENnssW/IALAkmhQRYl1
	j+m9qIwvY4ovXD3x/IpB+6Me22WZQxmZy702bSuVvll6jO9iwYIgzr7//6oNuoAla4IoVxZi5WO
	l3xRoypIJynDyWUGyAHz8EqseNvm8gAIz
X-Gm-Gg: ASbGncsSELI7g1RnrezYp/NQpYK7JtH6tShUyc/FAcMDWn8mgkkCPV2EJ2+vPk5pm2H
	vJdeOcwBHJzN4JI/P1ahs3W/F8aTpgC3KtBxdqWK1o9aYUhIEjyAzkkdj9LNKvxmSXQ==
X-Google-Smtp-Source: AGHT+IGS5G6e5GtpEqT+1HDwif5RqucsG8X8qLwC06dzCiApCXonJTF+1WwnJb7CeECa5znavqAGXYNMilcaAf3ZwbQ=
X-Received: by 2002:a05:622a:18a6:b0:463:1257:86f with SMTP id
 d75a77b69052e-4652f4a193amr53246191cf.28.1732201605621; Thu, 21 Nov 2024
 07:06:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 10:06:44 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zz472iMq3nZMoRMf@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>
 <Zz472iMq3nZMoRMf@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 10:06:44 -0500
Message-ID: <CAOLa=ZQhjPRnfUhsZOir-a=djC523waw8qn3E8rk0ou7pdH8Hw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] midx-write: pass down repository to static functions
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="0000000000006245d206276d9de2"

--0000000000006245d206276d9de2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Nov 19, 2024 at 04:36:41PM +0100, Karthik Nayak wrote:
>> ---
>>  midx-write.c | 57 +++++++++++++++++++++++++++++++----------------------=
----
>>  1 file changed, 31 insertions(+), 26 deletions(-)
>
> This patch all seems reasonable to me. When reviewing it in this way, it
> is a little unclear to see which functions need just a repository, just
> a hash_algo, or the whole write_midx_context structure.
>
> I think I might have erred on the side of just passing the
> write_midx_context structure throughout the midx-write.c internals. That
> exposes more of the implementation details than is strictly necessary,
> but it does so to the benefit of making the code (and this patch) easier
> to follow.
>
> I don't feel strongly about it, and I trust that you modified the right
> functions to pass the right data. I just wanted to mention it in case
> you hadn't considered an alternative way to structure this patch.
>

I remember doing something like that and it seemed a lot more noisy than
the current iteration.

Regarding `write_midx_context`, I wonder if all these functions need to
receive it. Passing only what=E2=80=99s necessary might make the functions'
requirements clearer, instead of bundling everything into a large
struct.

But then again, if you feel otherwise, I'm happy to change it, I don't
feel so strongly about it :)

> Thanks,
> Taylor

--0000000000006245d206276d9de2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 37d0db0568425158_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL1RJSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWVsQy85YUQxSGJwemp1R3diL3laS0d3Q1h3OGdzNgpUQS9iYkNoc0Rx
dnA5aWF5MkViQ0xydk1HSWFrblBuTkxmWTB4S0pUdVVlRkhtU1VmNStENjVWbmdQNDl2SkpZCnEv
S29CUDdxR1lzWEVtNHNwM0VZcG9aazBkQ2ppM0UrMDJ5b2hNWlBjejYxQWRlOHFuVko0d3hNOUFy
bExNNXQKV1E3N2xTT2gwNllscDZRMjBYTTJ1Y2pEUk1JeG1rZ1BoeHI5ZGw1NFBBbDhnS0lFR3ox
ckdYdCtLd29ERG1SSAo5RXRHNmRQZ1dicnREdnZvUis3ODg4b0VCS2p5bDR1d1dsN2hUeUFzdXdQ
NVdxMjJsWU9IVXZLYU5uT0c5SzVYCkpzWFh4M1NpcmR6RmFCTnZHVzM5d3dFZ1VLcWw4RjYyamsw
bnEzU2hEamVOTUdya0x4dXFLWTFTZStJWjBTWWQKRnZkY0VkTTJaQmk4bTgyYXYyVDM3TmVtdkhU
RGpLNTRXUGVaeHRhUEM2VVpyU3V3S0ZONld1SXY0N3VsdXdxTApQZDFxUEtpRlpyUlYwYVJWUG9v
MkRhY3d3d2xudXRYb0hudWpOQ0RjelVYbnBLSXZmallCTkxvRzFQam9xOWpzCmtUZXJoZjB0d2hu
NlQ2WllBNWorcmtEckNJR0ZiazhiZlBsazJaOD0KPVZmQ0EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006245d206276d9de2--
