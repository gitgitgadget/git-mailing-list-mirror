Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6B1BF2B
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836275; cv=none; b=ikdY/F9AFrDbk+4FasJA9FcxvFxPnTFxa0HHO+7MSBHxNFp67WhVv3BQIYdVE4n5dsq1QvywLLrRVaJgzBa/bdtZaDlPLdQwtTwE7WLwkbPXhI8hEmGdnBDqNvX+uOK+gQsuncJwsY+IcqoIm2mb0V0qxIJjk1ZQiZ/rT668R1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836275; c=relaxed/simple;
	bh=80N9QygPvcb61OwJthtsma0Qt9Tmg4YQoh19hmYdvj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3K8tMo5HiKrDhl2Pc//NBpibgYcZjWNd4LLIS2BNHD7+p2gjkZRZFzWVSWkXY9htrwS32Cl8D56YnNfmZNF04/dEmjzxRh5US/xj5OAmAT9xlvHQ8uHhM9zVpChwbyLJq2CheC1FQslHOVssQ6DGlFaS0+IHAOsJDvaZmTGcAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NY3+PtQM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NY3+PtQM"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1106740a12.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729836272; x=1730441072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80N9QygPvcb61OwJthtsma0Qt9Tmg4YQoh19hmYdvj8=;
        b=NY3+PtQMIXJxYqaHL0HKhsX+JxrY4nXHO+DMpnHW0Oxp0i2y5jh6jLFX3nDOflqrc2
         Vq+KYdO7ATRvpQkWsTd/ScmR9fkwBZmSig794HZM/ecbshICb2XPqTgnr1hZWypT9qc1
         AsxA0gWAWK04/H2ceZG6B32nmvxwCYEj3T/l78bcTBcZwR0sqFs1kdoD36DI9g9Jb8+g
         bJ/5F1deDyeNw1jb9aRm5Bbk/MET5m4PISghLptV1FakzRb1xbXi5h7nQt+SVwmlD3sF
         OoUyBdrApHOjR0akZ4gNRqOuH+CYBl9m1bum6MqZlO50ZOjSsEo6Iox02C2Y5EqT+aau
         nqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836272; x=1730441072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80N9QygPvcb61OwJthtsma0Qt9Tmg4YQoh19hmYdvj8=;
        b=dWIVCrELgnNAOYVpY2GYgz6ADyNlP6NB9Pr8fvmjvY1HlWfcqcBJO0Mg6te+gRalfT
         Oqj3RBsRFjH9DfgPEJKOyi7Lb7Uc3OavyzxZn6YNgbxtARJ4J53oLVeqKVS0GBxtaSR+
         CTZs7aaARROwMRrOeda8vb5i2vvu8MV202ZxFGg5IgPtKwpFV7i7L3NZAANC+eoIWUUi
         u2RpySAZELIGKvPOOnIFvDg5c3BMp0dEw99FU2SYkOEmq8pnzNVsekyS1qX1ink2nZpK
         GqbBz2juzPCyqiz4Ntx3lbI2s60bXJ18KlcEtwk2SxhOeFt1Gq9J/cOj/P7uf4eOSpzU
         vNsw==
X-Gm-Message-State: AOJu0YzSrb/ih1ePBqTeAWHnU8nO4ik2e+u8wDb5Q9zEjkGg+/Bemfkz
	idUlOXHz+RLEWHffI9UgnUul00uiPPrRNQRrCUZRG84MpRRuUfcj0KbYDqWZCQrIVEkdJeewl1j
	5g48p4hu6Xv4dGyFJOAheElOD4j9j/YQnDOWIhw==
X-Google-Smtp-Source: AGHT+IGbvSvnk2k6poc0Kbwa+p1ImqYKPEreOAhuEczNJoOr+jmRxAMV033/kKgFzBcEp4Zv73rFqlNOKov7DmbZFlQ=
X-Received: by 2002:a05:6a21:e8c:b0:1d9:69ca:6b24 with SMTP id
 adf61e73a8af0-1d978b2d8f1mr8858342637.23.1729836272661; Thu, 24 Oct 2024
 23:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com>
In-Reply-To: <cover.1729792911.git.jonathantanmy@google.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Fri, 25 Oct 2024 14:04:21 +0800
Message-ID: <CAG1j3zHXThL_JXP=9xqvg=wg0R1wZYnA-okfFxqmcUQ9w0M36g@mail.gmail.com>
Subject: Re: [External] [PATCH 0/5] When fetching from a promisor remote,
 repack local objects referenced
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:09=E2=80=AFAM Jonathan Tan <jonathantanmy@google.=
com> wrote:
>
> This is a polished version of [1], also with all the test failures
> debugged and addressed.

Thanks! I think I can drop my "repack all" patches now. :)
