Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E12D8DD6
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723907; cv=none; b=Tpjd7uvF4kQs2bP5f9IKeJHDrkxQ4wFRP28BDQeP4VEum81YyKjEC/gH+ZvyIuJKmPHguO3VQkxO6rB0SVjzb6H19BZSqdPiwlnByHBiWwKQ5DKn+/jjYqCokFHpatvO35iBjNF4/M5KuVwJDqYX+rmx8T+LXwhQGsz8jHBx/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723907; c=relaxed/simple;
	bh=cRHJgXjU9KUO9N2gJWODNqIbOj6zFx0ehSHU8CJozWA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGJ//1y9ojvk+jT11KbVwP3lWVVf5BK4ch6if6PCtIoEmojoVfCzMIUzDdGlJJGgxI48uK2nnApuFmzLRh3zJ4bkIjovbTdK/ZKsAU+I51nZDZlCS1z3vDEoCAjC3KGwKghZ4YDgczy+sqkrVDI/3AO0pnwsgTFFNiRILr9Kx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/cJ6uyk; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/cJ6uyk"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93518a78d0aso952172241.3
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723905; x=1764328705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRHJgXjU9KUO9N2gJWODNqIbOj6zFx0ehSHU8CJozWA=;
        b=j/cJ6uyk9A2srxcmE1WTsrqwt/jX73A2JxLO32U/p04tKPpL40i9eFEM0FhRWmhDCa
         Hc1h/xsVMDylThk2/MobApJcpShNfzURpP4fRJjBWJBJBecjTxQebo5n+YHTOrwkOyT8
         CQaHCiGY5ZjOLtPOJtpZJUxZZ4mR7KG0QFxWum/zrFwrXbz2UQqKwXf29Jb9bAHZbmpg
         kYSWscYeqeAG69pfo8yxyYRRsltLnI0kN2jwumtt1tMpb/KYHRJFZFFOGEeLRH59jfW5
         W6Jy1MrfEoZgZUtD1w64fL8QSIoaQ79H50EKHPZm3HIzZUzrrIqAmLKQu6ifY+tXsROl
         vuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723905; x=1764328705;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRHJgXjU9KUO9N2gJWODNqIbOj6zFx0ehSHU8CJozWA=;
        b=ZuA8Oa/uXugLBh3GLNhpTPNMiBbNTkJTKloNQueAeBjLiHkKszp+cuZomRZwlTQLJJ
         gwte5bn2Avd5insuljXTYCxRk4MyK6tkV1MLEym3njVcyKe1tKNUlxGtANBHKEKsa1/7
         fgiy8nfg88PD6Ot25z0FYGxxuFKDiO60/jW/hUdxhVaSWXhfQZa7SVETXI5upR0IxhNP
         R+5wjWHW0bmtTWJRncz7wd2wP7eNJzmgDUXwuv0NdqGA+9d8RjnFAbHCkpqhekcbPD7N
         YbpFb1hWdM/bKu7zpMw9ryZm3D3zizQPudWQk4LZVg0U0KYM8qaGAEUryZLLRSbfq8ia
         ySog==
X-Gm-Message-State: AOJu0YyHNhtuOXVTiDhG5jsKHwm4bkCiDj56OU0Jz759pq5Q4RyhlHVV
	ameKXZd9AbC794d86qLaEVYOT6lcMf35+7DRyFX32M+X6B4lzKl60zuI9XPku7K0G15+Z3YJiAr
	da/DHzEKK8P7lk3PE0o3HCKYPM+s5gg25lg==
X-Gm-Gg: ASbGncs+SUJOJODCtJjx753vENfbGPIdTQfo+18pwJo7jXfdBKv9BHHLnlxerR3109n
	JqJaIMTUE90Z2bUVprwJpsBkHAQT/7KJoKJzW65nW+UED5q97ci5jT18QUgJBanDwSNWy3c6VS5
	i7Q3AKq/dbu6TMlOxkkx82U1Qkt89ZEdP8vBoiUFQ/M+U2pObxOjUeup3fU06e6qCXux20uOsTS
	XZXPsSsGlatY3cKtmmiodPB6oI2lSBXxOXdmhCFKeKRAGdLJHH8wpZxBsafYSqSsnZ70ZnQfTp1
	j29EcVNMICLEydxxhhe/kDmXEhcUzw==
X-Google-Smtp-Source: AGHT+IGtb/QPnj4CYlzV/L+0dnmxNSEa574WYvExWF4fC4cnbwoLCh/5u5ZMIBdarbLPO4zL/rDvSYsBDos0AQ/uJ9E=
X-Received: by 2002:a05:6102:c90:b0:5db:fddb:3155 with SMTP id
 ada2fe7eead31-5e1de1de0cemr566623137.17.1763723904879; Fri, 21 Nov 2025
 03:18:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 11:18:23 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 11:18:23 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pyt5nc2v25oarqmuxld4nrknmsomjnyooj25ffjetcue5zq7xi@vglcil42as5a>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-1-4cf4a94c8bed@gmail.com> <pyt5nc2v25oarqmuxld4nrknmsomjnyooj25ffjetcue5zq7xi@vglcil42as5a>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Nov 2025 11:18:23 +0000
X-Gm-Features: AWmQ_bl0AFxWPi5YeXm4lfRWd22EU_IePMgTXJKmhm4TMwnhcPl07rEloKrh6hI
Message-ID: <CAOLa=ZTeadFsZNNxjObwrS_a4kTC3V3d6ubn=DXncEzzvWe2MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs: support obtaining ref_store for given dir
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d52c51064418f865"

--000000000000d52c51064418f865
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/11/19 10:48PM, Karthik Nayak wrote:
>> The refs subsystem uses the `get_main_ref_store()` to obtain the main
>> ref_store for a given repository. In the upcoming patches we also want
>> to create a ref_store for any given reference directory, which may exist
>> in arbitrary paths. To support such behavior, extract out the core logic
>> for creating out the ref_store from `get_main_ref_store()` into a new
>> function `get_ref_store_for_dir()` which can provide the ref_store for a
>> given (repository, directory, reference format) combination.
>
> So when we refer to the "reference directory" in this case, we are not
> refering to the "refs/" or "reftable/" directories directly, but one
> level above that which is typically just the gitdir itself. This seems a
> bit awkward at first, but makes sense since, for the files backend,
> there may be symbolic references such as HEAD that exist outside of
> "refs/" which must be considered. It might be helpful to clarify this in
> the commit message.
>

You're right, for the files and the reftable backend, this happens to be
the $GIT_DIR itself, due to how closely they are integrated with Git.
But if you build an external reference backend, this doesn't have to be
the $GIT_DIR.

I've modified the commit message accordingly

> Otherwise this patch looks good.
>
> -Justin

--000000000000d52c51064418f865
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fd3dc91bedf8153a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZ1NuMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjRoQy85UVlYZGtlalhoL2RVOGNEMDg0VTBQTXBZcwp6STBySXNVd1p5
Z2FQYnFnR1hRTW1pbCtMcUhWcHgzVElSWUNyTmhqYk03SUVjS2l3THZOc1hXT3lVTUNMdURUCmEv
dFM2RnAwV1NseStmdXFzV1JhOXZaeG5RVkFkTTJseUZvRVRJRHU3U0FDdHRPQllSL2NUMWtISWwx
a016eU8KbENXMk9wVVF6OXhCTjBZVDJsSzVuK1pleVM3ZlNLT3M5TXVvM09YVU1FV2VBM25mWXFn
RVRUOTlkWHNndEJwLwpzZjMzTkZienBDVU1jYUpyeCt5WmFPL1dzWitkRzhJNnJMTk1pNUpKaDRZ
SVFQTm9BZk9YdHBmNnVzY2Y4SzF6CnZnamRWVStQR1B1cERhWkhtTml5RW54d2wvS2o5aS9NcFlq
NllUcTBIa2lGUFlGc2l1N01lMXh0RWRIbHRjbEgKcXhPTTdwVE5saktmdlc2NjJDdWNVSmRCSmVR
MUZxcmdJLzRDMCs1U0pwMHVDc0MwRVhGTDV1bmhIK29RaEQybgpndWNrVTAwa1dVTmFKWDJ4WlVv
UFBhbjNWWjc3OHFDTVNxS0l1RUltb1loSlB1ZTBJb3ZDUExvZmZscVdMUEh2Ckw0enpkYXRxS3FY
a3lLaFVsMmJ2eXlsR1JoZEtxbmpEQ1AvR2tmTT0KPWlVQ2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d52c51064418f865--
