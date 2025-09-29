Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77A33F9
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180661; cv=none; b=JnE44UVuJjsQudWFgcv3R3i90xHEAguUO1/rWD8Be+fgS7QeQqDEKXuWtYCe6UdrPb4HfsNrSXsO0HrkkgVOr4FYhdcD/OyxsoM8yogEMdWsNajQYA8hr7YU7g9Z2bRTAQEDSMYUeQtxKPGEC0zCEItJcAkSrePLnThdeE9uCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180661; c=relaxed/simple;
	bh=erqUuL9pY3bhIlIBSeB8eOrDlUvhuB3ig5XGiwMSWus=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Se/EahXRYGFp8JBhudYFbncrlqD+LhH+6VV6vUZZO1825LT7B4yDOKsGjAehiFl6/VdWg+hrVKgnz388NwqfO0lKaM3IVWVclamgNzsoBxZRSV4iD0ERjo/u9hZNrHVyE579gTWcGX7XcMjBTjTqcW/OFlJKXVFjKUWY8Ceq+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvW2kmLv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvW2kmLv"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-72ce9790aceso53544647b3.3
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759180659; x=1759785459; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erqUuL9pY3bhIlIBSeB8eOrDlUvhuB3ig5XGiwMSWus=;
        b=OvW2kmLvMNryv8vU2TVGnUuJCW0sbYDzt4igOkn+UGnjssb3OO/3O846wM1oE+WJ0f
         1PUZxfRxOv3Ri7iSBT2YMleOrEN/WhbI658FnZkAG5eXuznEbrtLmRBGSIjCfICgzbrl
         wwYyGQdd/w2XpvwF2+UBW35VbhFt+OGAJTWGVIx7VNOPmY01jFVBSJYtM3pQSDOdQh9x
         UISUtVZ3m5L/VibhN3yrMwaWRVwSDJi+O4KWN1Hj5uZxNT7Ue4FQD+byaMJzRjta9goO
         QTNlhrp0RIGv15mYC6GouJMH+ExUTXTtyXNUJOQQfcKkVaAXi3Is+8/egNT/t0hUczqB
         VCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180659; x=1759785459;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erqUuL9pY3bhIlIBSeB8eOrDlUvhuB3ig5XGiwMSWus=;
        b=algSNuL9xmh6xVLNAow4VdW/wPDy5Gi0hQID4HHRm2oEqv+nyAHxxq469FQ8uy7/aM
         rruuPiXHP+6Bk67Aa0hqss8zucV/Z2FAQrF2mvnXOC3apPh/vQtVEgsrZwWDJvZuzqTZ
         Fd/nkZkqN07YxqhFVkomcmqRsG9AYEeyyFje5J7aQIpVR3CzKnYBR+7WdaZKBO5EIobL
         T+dm/W1dHO87MqRIrxyYq6BdXLt51yXhD6eR6UEeGc2SKZnbxWso123IvoJ+xgv7HUa0
         A7A4hv8CID2eHuUHGhFqgvDmrNnDieGGDx9fN5h1+3XQjjaVoEOfNnMJec8UGsvUQ7zC
         E+nA==
X-Forwarded-Encrypted: i=1; AJvYcCVJgYLnEKku+izxLM8Rzkw9ZjJ1Hp/mkjpW8bx92rpBfQi9sMx082O/UTs/Y5Hnmm+kwlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57+0/Kc+DK4JWlLzPYwlGjtUroSs1FS9EVMh3vW0+oQzgzTjo
	zHpw1KG3hsFIfYG8lq5wYz+0cyyi+mKfJ6X83qWR4J+ljH7OX+TxFqJ8K0yzUvgA
X-Gm-Gg: ASbGncvmNw2lYepfrKA5v/BPj8c4xIW+ILQZsjIv96nJIf/lcsyI4eauIuWp7Q5qSsr
	E7su3Ceap8OTt1H8AP9DGWIbQYTn2r2FkSyjWyQRHcffWCfw6wOK62MGKkQ77JZxlBLfbPOzgKs
	0ktYMZN7JCRKEYCuKx9dXA9ebDzFZxg86lfQhx3mJ78PPucbaO6FsPpxX/I11VSt7eoBX3ZYWzb
	LWRQm4lpNAgyN5yTuYWmdgwgggnPHtfVmQ47l/54QBrZ40ybc9C4SiFFXhLDeduXHgPwz2bFTX2
	p/GQ3ufGcWh/mFcKDKLok6iwrHYPFjzjNqw1pwHtKa1zAWm8nQRIEJdYoO8y+5GUteLEk+NLLpU
	HH9FVMcNmyr5ETCbufAq34EecdsIleZVmj2xS1SvRMOXMSSe1L4D8IcdUEoJtWw==
X-Google-Smtp-Source: AGHT+IE1L0n/K8ZGcDm3OVSDN8LFDxUJiCDhoV6+i9qqiUyQPe7FPWiAlsxqky3J7HYgsYdko5U4Mg==
X-Received: by 2002:a05:690c:4513:b0:72f:d215:60a2 with SMTP id 00721157ae682-763f9e7663bmr186496697b3.7.1759180658743;
        Mon, 29 Sep 2025 14:17:38 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e8c8:f46d:5858:5703])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c60b7ac1sm31815237b3.44.2025.09.29.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 14:17:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Feature Request] Support for sharing root-level files across repositories
Date: Mon, 29 Sep 2025 17:17:27 -0400
Message-Id: <8C362D63-3EF1-4042-A825-7DAFA9A51B22@gmail.com>
References: <03d601dc3166$0f302170$2d906450$@nexbridge.com>
Cc: George Ogden <george.ogden.human@gmail.com>, git@vger.kernel.org
In-Reply-To: <03d601dc3166$0f302170$2d906450$@nexbridge.com>
To: rsbecker@nexbridge.com
X-Mailer: iPhone Mail (21F90)


> Le 29 sept. 2025 =C3=A0 13:25, rsbecker@nexbridge.com a =C3=A9crit :
>=20
> =EF=BB=BFOn September 26, 2025 4:33 AM, George Ogden wrote:
>> Hello Git developers,
>>=20
>> Firstly, apologies if this has already been discussed or if there is a wa=
y to solve this
>> problem that I am not aware of.
>>=20
>> Motivation
>>=20
>> Git submodules are very useful for sharing directories between repositori=
es.
>> However, in some workflows, there is a need to share a single file that m=
ust live in
>> the repository root.
>>=20
>> A concrete example is .pre-commit-config.yaml. I maintain a standard temp=
late
>> across many repositories. When I add a new hook or update a version, I ha=
ve to
>> manually update the file in each repository. I could use a submodule for t=
his, but
>> submodules always appear in a subdirectory =E2=80=94 not at the root wher=
e tools expect
>> this file.
>>=20
>> The same issue arises with other configuration files that need to reside a=
t the top
>> level of a project (linters, CI configs, licenses, etc.).
>>=20
>> Proposal
>>=20
>> It would be helpful if Git provided a way to share a file across reposito=
ries so that it
>> appears at the root of the working tree, without requiring a separate bui=
ld step,
>> symlink, or copy operation.
>>=20
>> I understand there are alternative approaches (subtrees, packages, extern=
al
>> tooling), but they all involve extra indirection. Having first-class supp=
ort within Git
>> for this use case would make it much simpler and more consistent.
>>=20
>> Thanks
>>=20
>> Thank you for your work maintaining and evolving Git! I would greatly app=
reciate
>> any feedback on whether this idea has been considered before, and if ther=
e are
>> technical reasons it may not fit Git=E2=80=99s model.
>=20
> I have been thinking about a current use case for this RFE. Consider
> GNU/Configure-based projects where we have config.guess and config.sub in t=
he
> repository root. These two files are independent of the project itself and=
 truly
> should be shared and managed from a single authoritative source. It can be=
 a
> real delay/pain to wait for the project to manually update these two files=

> from an upstream to get platform support for their project.
>=20
> In order to support something like this, we might need a submodule concept=

> That supports something like a link upwards. Or this might be something
> That could be part of the sparse-checkout infrastructure. I'm not sure, bu=
t I
> Do think there is merit to this. It could also apply to organisations that=
 have
> cross-application root certificates that need to be in the same directory
> as the application root.

Sparse-checkout made me think of some kind of =E2=80=9Crepository overlay=E2=
=80=9D: as long as there are no conflicts (or perhaps for later versions, co=
nflicts are resolved by higher-layers-win), each layer (i.e., repository) kn=
ows only about its own files.

Adding untracked files would need some work to choose a layer.=20=
