Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9541465B4
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336263; cv=none; b=BEILP7jDe2k8nyIXkPJgxvKoEMd7AytKxz3e8a4HSo1CgrXy1fY19JTskRwwlysYNYor1YYlKFARG7c9CJfie3RL65eHQ4oDgb/VKmN2esN4u98ATQhYjVCbae+/vic+k8K+UgEu6BNKCmfkHb7v8QYtWi5DFa0/nNjBZmX580U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336263; c=relaxed/simple;
	bh=HFW8rnGPKIU6toWvvckS9fnR1XnRn42ZsaKZGFU35QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdoWg88xCEjQCb8WKqoTf+cUq+8hMKAKd92oSF30cxJm9Sdyej7AWAlHyctN8+XxdSDzMYZm2668ZlpS+HGebdARuN3AFILPRaz8zCkL9YKk24WPGHDOvMm58YyOMfBEZu2AZtSyCz2VOxRETOwYnhSgszSdlyGUyRLAq43/W68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGBXZ+mz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGBXZ+mz"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54bd3158f7bso36124e0c.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759336260; x=1759941060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uwF4FeVT0eDFHY7o7R7YHRUZJo3OI8oEnnSTk4OTCc=;
        b=dGBXZ+mzLhjoxU3LgLkA0mujdrmTQ7XDwMa24cuNkYJzGVEvOi7+2jd03fAHtD2NzV
         ihK/IkkASIeCrFGikE5BHUSDXsKLxHOJdys90RN5ZPCcgFNRKllj+qbABowiLWweVm9a
         +Owa44Ap0rxBfVfCUfHL7klEJRU3MzKiGHX1Ai6t5nTeSs9B4U4zLPTxDySMskfTaqxJ
         t9iD9hWh9RKIQC5wfj4GzDb9dOHL91j5RtwY0VHiD3WXMAVNCdud2mN+CuWcwOE/Sm18
         R1hqy3COZ4facd/TBXug44tQuC3NWWw9jRrG9EwLthRyq8JaykV/6Vxncupxnn42tkSD
         vwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336260; x=1759941060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uwF4FeVT0eDFHY7o7R7YHRUZJo3OI8oEnnSTk4OTCc=;
        b=XJFb7vn9ogvAeQuD7N4moqKVZwTl457b05VTKWJ3ZuHcvPf40C43zg63txrxMHghSJ
         3bZBxzXJunO4LQdg0z4AGYQISX8Ygo21ZW/KkHEZXP9owzdlgZxFOnGGTf4QJwqsCwlL
         3DFNHNZp2eMbJ6xmPcAMC7MQAc6np2v0D+Mmi7dypIiM2QOMkT+46LVg3XhqiYP0lnT4
         D286LpQcxhNz61YUxBlZAeIvEsMLa/jwGotYhPsOcLc+C69HiIJ7Ba4NdEzRsyohPC+B
         TLXM6/jRgcswX38rSmIUy6uyk/7SS8dLmdy6SrlcyShmFAuH0Cb3vZXjb7KbIVZtPZoL
         qhKQ==
X-Gm-Message-State: AOJu0Yw5OzUMchXcDIZXxSTHm5R0G9ePF/y9AmUuZZzIn78HuP3xdPUt
	ZSU93IQcR7rNvE/Nxwrhpk8FAf7f4B1+KpuXLgwrPNR5NPgnDgte5DVcEEfK1a6c3FJDuR5+vbW
	H//hF58YolS0Ye1KkLyGw0I+oXXpUHAM=
X-Gm-Gg: ASbGncutkFRSTn9OLMUJiNRYJJXtzl4SZ6vhQ+rpJp436R04mnruW1Y7SgGpxw0aWVU
	eqT7puycOUqS3WYEzUZSPcxA7wSWDM/QLTl6bbpX6L5MM1EKwC/IaLvJkPWTA8StAJcWN0ey3Mt
	0egbk7YazukrvhYMoZF25axAc+ZxKDlirEvPH4pG2qyEAvbwT3jE1HHmbo3y/8gVkMzLR/q2pd9
	2j6BHk8nV7yddC1NWgMCNcT9PrShZo//vl2FmAmrbimdIkQVIiRMafT5qS9iw0AV6TLFGKU1Q==
X-Google-Smtp-Source: AGHT+IEBrYp92lWOkcl8vYiE0/sCqKmKQAz79jP04zVjFingX6+pUGf4MwEFSGaaLGmmuZO9EzQjIq6HSPzxPQv9UrA=
X-Received: by 2002:a05:6122:6588:b0:535:e35d:49f4 with SMTP id
 71dfb90a1353d-5522d37a0c9mr1929103e0c.11.1759336260422; Wed, 01 Oct 2025
 09:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMWvevK2CrA_2mJC-O2HDKag4EaDVrB-0LiqQk0_gKrRaSR_ew@mail.gmail.com>
In-Reply-To: <CAMWvevK2CrA_2mJC-O2HDKag4EaDVrB-0LiqQk0_gKrRaSR_ew@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 1 Oct 2025 22:00:47 +0530
X-Gm-Features: AS18NWAXmHHxvRyu6KH323Ir6n1km8Ju_576-7lUODBJs2XnHjWEjUY2Mj7PFHQ
Message-ID: <CAPSxiM-hkh=X4rf6QvGP2JnHvP-UJQ9mcmMon91avv9AaLB3Bw@mail.gmail.com>
Subject: Re: Interested in contributing to Git
To: Vedansh singh <vedh2o2@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi Git community,
Hello Vedansh,
>
> I=E2=80=99m excited  about contributing to Git.
Glad to know you are interested in contributing to the Git project.
>
> To get started, I have:
>
> Cloned and built Git from source successfully
>
> Begun studying the key documentation: CodingGuidelines,
> SubmittingPatches, and MyFirstContribution
>
> Reviewed discussions on the mailing list to better understand project
> workflows and community norms[Past 3 weeks]
Good progress so far.
>
> Currently, I=E2=80=99m exploring suitable microprojects to begin contribu=
ting.
> Once I identify one, I=E2=80=99ll share my progress and submit patches fo=
r
> review.
>
> I=E2=80=99m looking forward to learning more from the Git community and
> contributing meaningfully during this application period.
Yeah, if you face any problem, do ask, the community will be happy to help.
>
> Regards,
> Vedansh
Thanks
Usman.
