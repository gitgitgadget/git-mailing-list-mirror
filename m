Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77617B4FA
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543473; cv=none; b=l8UIYUAqroxvLMNyr9uOTz8qRfPpD5b5Y82/QS9ztHyiMJh+twsWsOqrKVQCMZ5zxbCez57PIxVue099y5KIsK1uwYCgHZnSiUQDFOTDZyoVYad1jqkdhMifDoseiLLDHVqYFW+qZ5x0WFbqjx/JPnmkzB+vhdZqTBZQaW54hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543473; c=relaxed/simple;
	bh=2to1M3l8Wh3wr2mxdy61crfisM/j3t33zjML5/eRd/w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=kQN1rNFkpCEJbO1rOoFaN2wazZ6b191FE+yGRMAJfJHbHw4e/m8TtA7kXefuCt97pGoUfDH9i+p1FjooaGWumRXKYDbWNkloF73VksFyFygdGmSmg+mYB4ErDxnM51x4VQUZ23j+k15EwIzv5aw3vV/D8aXmX/keS5YqwKIpH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfjN3E+V; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfjN3E+V"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5da686531d3so657455eaf.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723543471; x=1724148271; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Eey6OlP/zoCeMeeEhqes8hjYbAKjNYeNAGKSD2gf5w=;
        b=LfjN3E+VG8DWpUizQOvKPYXXQhInQYC+S1BQl3aaIx+V1sra8otWLYTyit6SNQkuIu
         mQ2NOX43g9yN9fZWsgvns0T4ctPF436HLoqVuSMHaKS+O8at7ZnkpNNsqtBDdRLkYjWi
         vH6Lc5ksMg012JMxOixyIPo6R8FBVk0H+tVTEsfBrxQtQIhwvn13FNAdTANRpRJNLFZt
         7WPKZj3shf3NT8urmOwwJ//2c909mS3PmVwYPbEaRrVvhS6TgG6COYFwfSdqFD1C5dYo
         yLxxDGk5QFeYagvmPnr5px80Y2k0dLQrSUtUZVyzWJ4aWU5KpKeq44Qz91JnSH1JlcvE
         r20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543471; x=1724148271;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Eey6OlP/zoCeMeeEhqes8hjYbAKjNYeNAGKSD2gf5w=;
        b=MXKU9+br6EXgnMF2BAZzXc2ctyylCIhw/oR7Jrft+IxEX6jQcHV10mnuxOPRSWUsm1
         VDHygZFwMvZ46ebQIMeJz7wqMwzyTg88lPRg/ghbWj1n2NPO5X2urdNwLK47XpBgcU8J
         FQ2F4rfXlmmy5kmaqb+Ios0ZU554wBAmkhoIXmCf5NSOfLNEUAQK6jr1An4i4Ex3+1dZ
         8E6xx0E/2dtOJtTxdtK668hqxOQ9j2H3ceGICGAj41EA/Z7XsWC3ZSvIKR3WCXl/FWZg
         07e0btnBGS+xXK6aTmTLXXv4nSYA2xG429kUgtlH/YHGCRB6t1Ql9MjncBKGJzc2MkUw
         QWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnv0bSj/79d9oGqPG3eB6XSgFKMbMu38BAS6S30G21e95HQpuKfeLAOZaQflK7qQzbFsz1s4De4jCtRIUcADpn6BlE
X-Gm-Message-State: AOJu0YzaK/lMwAb/zVwr1AApVkZqtn1j+oW9iU7Tyf2eGYMT84kANCWY
	/dTfKq+CPpV1p1q2AldTFYVCC9VEtq+MTIs1O/EHg7FjANBL7mPaI90ee4CIZFvASOKwbkOWukj
	wAo0yJu0ROOEHCacse5dgehIN06YNXw==
X-Google-Smtp-Source: AGHT+IEKMdYd9S+f5owSYYe1/yVD+kc4WoqP5nEhOyP5m0xM3ExqO0N+ikqdAWEq9ChwI5W0YTctM8z09320HhHqTXE=
X-Received: by 2002:a05:6820:1c95:b0:5c4:57b6:ffbf with SMTP id
 006d021491bc7-5da68117bbamr3400363eaf.0.1723543471298; Tue, 13 Aug 2024
 03:04:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Aug 2024 06:04:30 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <14924604cebe20ac30d291399b0200016fa8b4e3.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im> <14924604cebe20ac30d291399b0200016fa8b4e3.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 06:04:30 -0400
Message-ID: <CAOLa=ZQ15h8bFRGGhzJUPNwkCrRmc2Y26n-0x+L_V_06xWgd7g@mail.gmail.com>
Subject: Re: [PATCH 06/10] reftable/generic: move generic iterator code into
 iterator interface
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005cbbc1061f8dbcf7"

--0000000000005cbbc1061f8dbcf7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> +
> +void reftable_iterator_destroy(struct reftable_iterator *it)
> +{
> +	if (!it->ops) {
> +		return;
> +	}
>

I know this commit is to move, but I couldn't help noticing that we
should remove the curly braces here.

Seems like the CI caught it too [1].

> +	it->ops->close(it->iter_arg);
> +	it->ops = NULL;
> +	FREE_AND_NULL(it->iter_arg);
> +}
> +

[snip]

[1]: https://gitlab.com/gitlab-org/git/-/jobs/7563308943

--0000000000005cbbc1061f8dbcf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2e534449485720d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hN0w2MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM092REFDVDBjQ28zUHIxUkxxZmZsWFdyS0p5Q3FRbApXWmpHMGltZzE4
bGxLbU02SCt0bXJ1RE44YlJ5Q3NoRjhWcTZuSlNzdG5CSkRzQ25nZjVWTUtwSExIYlJKM0hqClAy
WVlEU3BObHlYalpERThzdHBQTDFvYXhZWUp4MnBBOThBY0EwTU52UGYxSCtrY3BoQzJGYll3Vnov
WjFTcTUKbDFJeTlVMk1EanpxSU44WVV3WWZSY0FFeEVIQWtmNUFJWUlwK0hsemg4VG1ORVRrdGt1
WFc5b3JJekdhRjlzTAppbDFvWkZYRm1rNWZscWgxdzBGRXcxSVUyRXNScmovNDlQUkJaaW8ydndq
c1RkQ0tabm4wNFBkNWp1eHpJR2R2CkVDRWUyNkU2NGdkMi8yby90MzJ5Q2RZUEFkalZEN0lLUGMx
enVzTGlieG1Tc3ZBU2RyOGJ5RzZWOHJ1S1U2eU8KaCtiQnVhS2pNY3NUZXNuWmlReGtGNGVFMlVC
WW0yaDBKOVhUdG9kajZWV250RWsxQzZMTVlBT3RreFF3VFRLdQp3QXBrV0JieVNmS2Z4Qml0SE9m
ZDhIVHlJS1J1Q0N1Q2gwNDh2ZXpib2F3NUw4QkZCUFh0UHhrMTk2MktuQXMxCkZLamtwWXJUTGt1
U081bkwrTFZSaWdQblJqRU1OdVhybHB1YWhIcz0KPXYycDMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005cbbc1061f8dbcf7--
