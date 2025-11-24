Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AA1F9F7A
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990761; cv=none; b=rCJ5mp9k7qNaPzzBxuoCY4mvQEBBqiEdAHBqwz4riMxdO3VA0DWetkoB0OZPHOiplA7//bq2nlbpk9gBo9YbSvk5SGIjOBgxc3Oyww9FLnhyUk1Gp/llhEE2pX+gH6BKomFDc7ntcPlwhjeGYsY7hXdES7yu/jHEJQqAyceiLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990761; c=relaxed/simple;
	bh=OWSQ3if8mWDOoznpyesjZrhbsdJehlF2t0emZF3wWm4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGiTktaI+FYHgQP8ylSaD/neHCAWT6EGyFw25Vwp9GEQEjKrRzxuMR06J0MLdzXdfXTmOrOb3g2q9sr8Ya328tQbK4AgjQmeZrRt/8alOmOiYE972+88u0++vo+s7Eb2JhS4wvRQ/3nwr3pu6+K2NZnZVyWuwhrFt4RIW6Fu11g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSxKIq3H; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSxKIq3H"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so1767095137.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763990757; x=1764595557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtswvUDPvr2cPQ/fma5BJNVDo6mJIkl69UZo58tSN3o=;
        b=BSxKIq3HH+UFEIK7DpJuWpiQZAdbNMRQzp+YBDMYIwRNIkXKJQCmJfwOMpYQ7ObFKQ
         52jo24R+a7agroRh9VKj8TmfDzO47S0WpRrRQY6fqBTnSQJygFvddmzYyWqenAtSC4Uf
         05Bm+UnKws/Ur1/66IKX2SmBjxztonpcsmgNPlE/GeaarfVtAOlLxeaEq5nwHew7tPkD
         pWyH0sPd1eHx6ZevmUmme76DxMsE9SwPQ0mjrX98sFINR/eTpPtGte/ja7M+sTL+Pe5R
         RmQ/uF7VWWkmIOJd0yRicl+sp9vGwEXdJeT9df1GmQiwFJ80yy4CqiYcjX2y0+/lElz8
         N00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763990757; x=1764595557;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtswvUDPvr2cPQ/fma5BJNVDo6mJIkl69UZo58tSN3o=;
        b=UUByoTRmOmxuqAc3AIOMbU8TNZ4KM68boN1u9BxsMhIqtabJcqZYH+fP0OrGsgLQYl
         8yW7nI9jhTlp6isAicvrO2lD+mGjbUCZT7UHkKTxxI0548y5tjS87QvbKBTr185j+XeI
         A9ztB+29dbV2oA+K4eMyCJY1EzGGLxayr3i8VCgu+YdRPtMjy60XRK8YoaRNFYaJhm84
         turo43GpxtN/Lhn3tvHeHxQuIThBugKbqWoMpbuQDvnVr+sVL7WIIjvQn/CUkp798FFa
         xJ/yGAZ4EKKEpPSZkH6Nw0gZgEiTU724zEXvvWckWTRzPYUGN7pyyDAP2zWWgQLYe9nz
         qCQg==
X-Gm-Message-State: AOJu0YxIApdfzN2HKUAbkyGh8ZEpzzQ+6++dLsKiGixnRDCKky8PXO3P
	V8IknY8NiGVvRKnbnHdk/6Gz+MwVFg2ymt+MzvC3ms7B7lh0uYtdSfXW6usf3qN/hLSfFzSUyOV
	kOE144iXIC9yCVFLcDiXO29r746o/wkg=
X-Gm-Gg: ASbGncvuooPbLTy6hpKZvv4E0S/Bv3tNeBH3UrcngaZ1QKNweUUySowziGT3mOq831V
	SZ/PCukDosd2cVufDU2Mb/uNxg9nCr5Gh7lQp35Uu8RrMCRAgQkW2vRiJTR1kZArTALtJ9wkxhe
	Rq9auRvMaMI1V9QWqpQyEq1UN03fHoZa9wiV+HQvQpIOuHLpxULJmdPbuojzRcOUT2lnyEmdTnK
	JTN1DgU9q3e4PcHkHyAipr0Wl2wLNy8bqbdX4WhWb5nliGNZdwtEXkgHR19sWGzRE3DY5fRga2M
	vLvxIwdsv1PnmFWzv9XjywD5r9jpkw==
X-Google-Smtp-Source: AGHT+IH35R2+ptW/s9UIk7aZPZRqR0wTsOuKuCK4Xp7FRbgFuweB7kViAtuVBfJlukI4y0j0uBlYjFxyl77+8JEk520=
X-Received: by 2002:a05:6102:5107:b0:5db:ef30:b74f with SMTP id
 ada2fe7eead31-5e1de0c07b0mr2888296137.8.1763990756962; Mon, 24 Nov 2025
 05:25:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Nov 2025 05:25:55 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Nov 2025 05:25:55 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq34675pz1.fsf@gitster.g>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
 <87pl9b5wos.fsf@iotcl.com> <xmqq34675pz1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Nov 2025 05:25:55 -0800
X-Gm-Features: AWmQ_bko-XiFjrNpT9bHij6esBssRzspBzGa1PdEhMIZRndADGDkk6DlltcjX-k
Message-ID: <CAOLa=ZTn5UEqifJrJcVfCt=YyVOa3CMdLRsLpG=g4x2vmDPeKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000074cda50644571a8c"

--00000000000074cda50644571a8c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>>>     <ref_backend>://<path>
>>
>> I like this idea. This would allow us in the future to also do something
>> like:
>>
>>     reftable+nfs://10.11.12.13/ref-dir
>
> I actually thought from Karthik's definition that what you are
> trying to say is spelled more like this:
>
>     reftable://nfs://10.11.12.13/ref-dir
>

You're indeed correct.

> IOW, the underlying URI to "reach the resource" is in the <path>
> part (i.e., "nfs://<addr>/<directory>").  And I found it somewhat a
> strange syntax, because the "to reach the resource, visit this" URI
> may not necessarily look like <path>, and I also wondered if
> spelling it like <ref_backend>:<URI-for-resource> is more
> appropriate.

This is a much better way to state what I was going for, I was
considering the entire <ref_backend>:<path> as the URI since currently
we only deal with FS paths (for files and reftable). But that could
potentially change. As such, it makes sense to state it as
<ref_backend>:<URI-for-resource>. Will modify accordingly.

Thanks.

--00000000000074cda50644571a8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7c2fff1569ba913e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ra1hPSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEhGQy80MWI1SStia2dTek93SzBtck5OK2YyYnV2dAp4R1d5L1FBdys4
enptanljc2pKd1EvaCtLam02VUVieWxZdHVxUmlsSHMwRnpTZS9IT3JWYzQ5Q1o3RmJENTJtCmFE
Nmk4QmtVUDBNeDV4aXd2UDhON2wxT3kxelROb0djWXBrMWpkaXFBNEVQUkwxTWd0SVAzUEUrY3Vj
ODYrMW8KQzNlc2JEUy81R3lsbkJjaTI5ZWxERVFQMWZ5aG1wK1U2bEJZRm5VMGtGeTFpUzN2VWds
NkFOWGtkMUJZbUMrcgpHUndFYWZJMTFrbndxcDFWZVludFpQN3QwVVo2RVUzb0JvRnVNNEU2WFNk
a2ZZRjhQNGlrVUswU3h0eWlnbHRWCnFxQ0U0dVNicWZjUHBMZVk5dzY0TGJxNEY4RHUveWpOV25v
QmZweFR1N2FwWTdSYTAwK3FXWWZUUXd3aWluSGsKZWJvaUVCaUZqYkxxWC95VDEvZ3NEWTNOZ2FY
SklDR09vc3lTVnBlQmtFazNyNE5EUmNoSnl6OTNLZ1cwSFRreAp6enJZZXZOdnN1Y2JYUEdSRlA4
MW9KbEp1amtkVERhTWxudnVma3BNWmdVTWRnN3N1RCtubFdaVS9JalhaQXhNCktvMzNoVUJUNDFL
TXpyR3k5dHNUa2hjYS9OVE02RldCNVczQytwRT0KPUlTUTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074cda50644571a8c--
