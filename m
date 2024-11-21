Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06C55C29
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203721; cv=none; b=PT9gAoO47icvDSsvCVJ0CZ/OsZLMpLTHI/p3cGzsOMBpUF1K91IjIJnuLKok+JqeppcAeRIV5qzrztZ9c56pav5EY+YVdPwt56waxaKqFvmeZpc8YFyr/cSalzVVN+Fhr/ahZYFAM3NjJG8sAP7V/DMLQ3w7t2AJe5myXBUW15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203721; c=relaxed/simple;
	bh=CX2mrqqdm9yqc2WaNBhqCtt8R2loD5ZpPUNqXXmh4m0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSankv/m5MAmXbwnVxI5R23yZ2MoOEleCGZIHvXX4V0ctlIJybGizHCXlEnaykC7MhG7D9ACMmsLTbzOFeQIezg4LF2g3kWEcMqDl2+qPr/eRw8Q3uMI6qI7WI4US5LdXLd7mjghflfJMSSookmzK3crUFu0sEZey/8DWAbzYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INMBM/Gc; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INMBM/Gc"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5eede9695ffso576448eaf.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203718; x=1732808518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CX2mrqqdm9yqc2WaNBhqCtt8R2loD5ZpPUNqXXmh4m0=;
        b=INMBM/GcijhDBbu03IvpIzokGbozTP4fq1GjkcaBZaD5nAHsqFmQbWG/N1l+CKPb6V
         7/6Ee9wGL8TjGCKvAFSbzNTAblm5vdWiKzX1k5MCJhrGQgsDjRnZM5gmtwcRJlH+v/RA
         78thij1V6OWuEWVtHTvILuV5VlMAtr4ttVFtfI4S/tzNabMY9g/SM14O1g8x9Gcfcp1K
         jueO9nuaIy7E4n8isJVi/hAWx2m0afl8QTl8q5Y0QPq+BTPRjPucPiTwugPVq50jVrb4
         9/hIG13zkMJZe7ivAR1YZleQJKrHobKEhj/XioqjQEkPt2FD2TIBcYzCeCljId7UuBYZ
         Sjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203718; x=1732808518;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CX2mrqqdm9yqc2WaNBhqCtt8R2loD5ZpPUNqXXmh4m0=;
        b=Ya2GULoRgFiiu9gfTXU5PKq0yGiF1Nv8+vBwiFC8KJfHxEJ1Ci/Qk0o1Qz0G60mjo+
         d/IL5jOvToS/UIgoLUhV5B21Da3Vda0eCGzGye4urJMHHyJthtTIlHvNSPu7GpfkB2+z
         oeKcRtPrPwM6/ptmcczVJLLuxn9Lvk0Mo4yWKYrif9LluVMsR8Gw1zHYCyNOTvQ8Cq3l
         5lThX/0sZHE1F6ZF5Nx79Vv/k6HQwa7ZE7mlLI5BxKz+ooivPVwJoyOQ32RgUAAM51Cs
         zkkXMyHICzYF9AniXGUSwrqFAAE/w9hyNEaSLnvR9Zxhw0TSjNApCibDAGHHkUOOWj5n
         jBNg==
X-Gm-Message-State: AOJu0YylvvtTQ6X3YInEyBFBwIrDBm7PoWdANHvbC4/pU4ctIDfGZpHc
	k6Hx8OVPN+YYXKAb33XCg7YWED5qMeZP+MEr1Qf57QqBVpJWQvOGCRSwssudfq/rypWrqs43Vde
	vYD9M69ZGZaE36w9dJqPdig29v7k=
X-Gm-Gg: ASbGncuFTUx0ZyWSsDHoC6fdJ1PSAi1yqwJRRGpwHr5fE4u1jqU26FPRADBXwQrik5K
	hhlwtJl8DiwXgpczn6mp24NpeP7D9A19OQ6rJNA7JMfNdYh53dz23OV1+IGt8LKbJWg==
X-Google-Smtp-Source: AGHT+IGoAVJmVKt5afcIR2uXe4RxkdPxWRCMgfzy6PaMzS5+NSt6nWYd3BMBhq4C7sX0CeJXLPQ4/yGxkdXHqb1U2/0=
X-Received: by 2002:a05:6358:5291:b0:1ca:665e:943b with SMTP id
 e5c5f4694b2df-1ca665e965emr468670155d.4.1732203718484; Thu, 21 Nov 2024
 07:41:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 10:41:57 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zz3gguyjTKJ8RY-z@ArchLinux>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-10-e2f607174efc@gmail.com>
 <Zz3gguyjTKJ8RY-z@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 10:41:57 -0500
Message-ID: <CAOLa=ZQ-u6H5P5Jpk8W-SU=u5-XPxYe7_XX84w5R2obmLnE5iA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] midx: inline the `MIDX_MIN_SIZE` definition
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000052b90d06276e1b04"

--00000000000052b90d06276e1b04
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Nov 19, 2024 at 04:36:49PM +0100, Karthik Nayak wrote:
>> The `MIDX_MIN_SIZE` definition is used to check the midx_size in
>> `local_multi_pack_index_one`. This definitions relies on the
>
> Nit: s/definitions/definition
>

Thanks, will fix!

--00000000000052b90d06276e1b04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 260b8baa719af88d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL1ZNUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMm9EREFDWVN4bGdGUzFPeS9YSTBBWk5WZFVLclBJNgpZc1hSZU1saW5l
MCtqQ2R1ckxrVDViSU1DclpWaEhTamE4OHdWb21mSSt5KzAwWWtoU3R2RC85ckxaTEFTQXorCm5y
eWJhdXV0MnVndkZGdW83ZnY4c20vMklleUh4bDlEUXFtYi9CUEo3NDh6TGhneUlUb0VzTWdUK1E1
TjBObkcKcnVKdGUvMlI4N0trOGVnZWp1SjdhMVlacVhaVVpnYmI3VVg5WDdLd0FuY3ZmWXdmVUpT
RlZncjJpNFp3NlhoZApuSHBLQlBkZkUycEUwVzl1UkNyeklLRVdqdEVvaUp6RDdJYXpJd0I0bTA4
Y1hqd3d5eHEzZm5PSU9IaDhPVVpDCi9IQlV3M3RibTFXVFZoSXlXM04yc1FPRVdEVytjRFgwblZX
RW5sZEZVa2JaY3ZyR0FZWENndWpwSDZNR1FQZ0kKeWpQTHNTQi9EQ29uVXVNMWNwMnZCY3orbnNo
S1Z2NUp4SkcvTEJsQzE4TTJ3aGNDSGxhWU5aTFczcTZTbjBiUgpvQXdWQUNRQXM1em81NS9RQURa
TXBFMXBneXB2RHg4TXByWUZPQlp4a3ViOTNmMnp4T1lxV0RnZWhlT1BXSUlQCjJNbjE1d1dkOGJG
U29MN1dxYWVGbjNpbGh2WkNxb0lIZ2Y3dlFPWT0KPTJqVjQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000052b90d06276e1b04--
