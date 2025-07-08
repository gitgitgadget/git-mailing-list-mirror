Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3635963
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935690; cv=none; b=n5wIMClBOYjj9w9THC6/e21bXuvsr5b3vwC3X1hSmZOCTkP/bvpdsCx6KXDXaFMY5IoJslxaXhmq2F7SapRPKBQAJ07ZCewbUFszs3s+n3Y47PwCv6ClX4/84bZsjTrsuDXSWw6zeogvOGkVpbXngBOnXrsrbftMZzxQOIse984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935690; c=relaxed/simple;
	bh=vR07fBQFPoPGM1mDdJAL+QMPvc+5/3rd8OcUxnBsD/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plK3g0C0apftRi1rtuATjStSU18MBkgp71Te25Ec6VpscPkp1s84FjnzfNoSECRm0gdC0/m1vLejPoMEUIW/obO7sxZzu8dWH2Q2R+msDxUNuE+xSxIwqbL09tRLnoa4Mx5OlAtHrBjbOCOhxqtVkt3GLoOOVbDZ3/7j8NIVDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd9Myf6i; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd9Myf6i"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso1987310a12.0
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935688; x=1752540488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sxjlmLWbtUh876GsypXkgOkDrKaIXGfHKVMgd9AuPc=;
        b=Vd9Myf6i+WCwVookFav1D+9xXFtLACBPgDwkOe+4pvX9wCA+LRWDBpwhw27aPO6zVo
         Wb9B0SS0Vp7dRb6vp3VLl7pQLEQ072Ayj25n5qkixBAbEnWrnrA6do3+fTXHxzYRFiKF
         FJpUZTTTBKwCwC9U+1dhv0AMhoVUe7VMi5WWWgRMDkp0UpX3Vb8gB+6cy5SiL7RKZjI7
         Pnlc+z/OBSyGEfvrY5PZ2J0v1B1Zqk2C+hAVDM9xH9bUeYZnR0Pht6rhnuXc2KF/JpOY
         liRvqShtkoHbgC4JOuzgPk+v+QgdANfShs59Lz/r+0ZYpA3UToVqL0KaoGPQ5LpoSJuo
         kyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935688; x=1752540488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sxjlmLWbtUh876GsypXkgOkDrKaIXGfHKVMgd9AuPc=;
        b=DhJOcisUUJntoJDNh6OIlXt3r0eRnoxQzPFa/WXa5LKkrYcegO3/l+YOgA5VzCcnI2
         u8/AfOzalWo5tKidFzmJQD9A4kV+IQrNg0N44fJ8sB5hBdWkqUNgn8cZNz6ovTF94Z3G
         t89qPrG/jL61ISIGPvESOyDLQd01v38oK8Rr7G/bIcZDL4wXU2Jsk0V9YhRXNlEQbCyL
         XXf89ZGoSuvGPROWtWaEhfHIxY5oZ+10iIn+FodqNvhsFKUR6UalIs2BYGkPpyEqefZ3
         HwAzpzNvWQZbH+mJ22knP/sB9fkQWiZJkOZGx0Ri2iJWyp6d0ZdSC8GgjgsNAYfAlCX6
         0kDA==
X-Gm-Message-State: AOJu0Yx7iMCaDO6NlelMcf0wIxRLCR+Bp8oMw9Sviz8rSUJW05kYQ/kE
	LNDzy8MUIljFb9/n4TVguwEhYmXRTFx0RKC3eB7MVnoiDk1pNsMGIyvNq/wAQ5w0gAIKt3jR3JO
	ApeTL8dqlxg3LuoUojvyYVMxyaMDE3x9Aui6n
X-Gm-Gg: ASbGncvHB16NDr8iRDKO3llCeCkaOEHG5bkYLbfcMoIixgP273/h9zza8nHMhCyv69M
	SChx2XnrBTSFFx2+jqzi3MElniEL+y+JizwInqzGqiKxdE539snTQ7HgYD61oLVTVMlTmtNqBrp
	/vl54RYur/GfZQMi601OaZ6qbHmfxpXi3jTll/idYacm/p8jpj+WfecLbbEvCm390IHKQICkveb
	4UeNg==
X-Google-Smtp-Source: AGHT+IFXP+Bvij8F9qx2r+W7NdaB6JuqNVzm4A5vCRD9csxjtI81Ig5beeD/8UPeec89aOTQcPQBm8K+Af/hXz8sRfk=
X-Received: by 2002:a17:90a:d60f:b0:311:e731:523a with SMTP id
 98e67ed59e1d1-31aadcf75cbmr23767564a91.11.1751935688138; Mon, 07 Jul 2025
 17:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqplebzgm7.fsf@gitster.g>
In-Reply-To: <xmqqplebzgm7.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 8 Jul 2025 06:17:57 +0530
X-Gm-Features: Ac12FXzaawfSGWXcZccT9tnx0OVSJNCKS1N3v1rwpOeaE52MTa1eT1mlnSgyxhU
Message-ID: <CAE7as+YC9kP57hz+6TxuXq1c72mcvEdzwZ1Y3mNTTH5Dfh0mJQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, Jul 8, 2025 at 5:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>

[snip]

>
> * ac/auto-comment-char-fix (2025-06-30) 1 commit
>  - commit: avoid scanning trailing comments when 'core.commentChar' is "a=
uto"
>
>  "git commit" that concludes a conflicted merge failed to notice and remo=
ve
>  existing comment added automatically (like "# Conflicts:") when the
>  core.commentstring is set to 'auto'.
>
>  Expecting a reroll.
>  cf. <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
>  source: <20250630182527.69167-1-ayu.chandekar@gmail.com>
>

I sent an RFC related to this recently: [1]
I will send an updated patch once I receive some feedback on it.

Thanks!

[1]: https://lore.kernel.org/git/CAE7as+YXwesgk2tna4kEC34EbQ=3D-eA+thQBqU3q=
nveDh9rbt8g@mail.gmail.com/
