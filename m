Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8015AD9C
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839619; cv=none; b=ICRWx67zrCp3oySMucNKfZVh3hcnAl7h4DVS4BJ555KwQ+hqA5zLt2uO2iFRG7393PjCGFYq9ghVrWaXlie60ZDDx/w+rK9sjwck98Cnz2TxOGWu7hrFsO40rt8EA4f8O8aiC4+Vc+W1cjbQLjvR019mzVDW3iNdV0k5iDfXJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839619; c=relaxed/simple;
	bh=H44ry/s/MrtJLiO1iY38V/cT1/Xq67cfrSIfc6sn0xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbsT+NcECHzugKWoSIVuHoNpkup81oqpzkq2HrRPWxraoO1lGAdKrA2stre+/jHtsK2cq3daYNoLAdZOc8osCB6kmkKmT3PBgYp+lx9HrA//waj7thNCj1YrRFRAl3LpC33kHd1F+ceOYF1UG4AULyC1K/70HC1fbO4uc9cAJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV74M3gr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV74M3gr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64a6b66c1adso26591507b3.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719839617; x=1720444417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCzlYcmkzYDAK1syn1RNSFZ+xaZVMnd4bG5bKDqFWM0=;
        b=QV74M3grnRe8v7lb6l4W7065JvxxW6i3VNJEwA+YtAl1/87V099iiE1QjZGIIHmgjG
         LWUCdtXbkCy+Oz9R3vsGlmNFJAs75EZQy29LqHKFyYfLParERpvDr/ZmlsRxz7teGOif
         4HwE9Sc96BjGyDhkONFx09dFOxCHNFMhSrkgYXLBM5+uzDA/aiJy9S6kIwgpHH+rAp7f
         7tXSBvH2AIXSGDuf9LcperKCIu72DCSXHSC7qE0PbPGjl/2HMLy64Tmq0eUY+Y6y3X7v
         S4c6wrBFwrE7ZMqR0o2TT3xdGIPktOoqsOu4CWys95CPXEUBGZ1f3nK5yehZjYkj00zo
         7bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719839617; x=1720444417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCzlYcmkzYDAK1syn1RNSFZ+xaZVMnd4bG5bKDqFWM0=;
        b=ViPlxAENr4Di2/Y2aniMpyaFLl/4JqtUiaNX7loOEy3zzm7JWomNg0y9XZqDSGOd9n
         1TnSg0lXHvOzDtAN59QXt4tFBJOQAyXNp9MV0ElDEDUv75Ql+rYn4u1mwgaBy1NIjlWd
         GmLJG25SPlqHhK8w1By+k+6z5/LMr3C23I8NcHrTQYymgTMLyVmdfde5Zi+y1iHimAt6
         cs0aZDdYfPB6LsB0eXyGRzJCfk5e2MrbJYDATFH91veOVyrS+pBChBXnKQrW5MLH2fSV
         N8X5f6bMX9g5Oy4eJQwhumknxhAlT9kXiRdaG5Yea2QQHNCqUwUySW6vV2aZxypyfkQ6
         qNJg==
X-Gm-Message-State: AOJu0YzqmrJV4pW2tGv2itV2t+RXec/iqwwG/CSGPvn1eU0mfZPqcsSY
	SXkFbs2pXGreiuLT/XygcihGurgGVil6zCzVPJMRRKVyH096keTpIP4vP9b67JKhGaQuqe2g597
	crrZG3s4cQDEove+LNvriTwh+pV4=
X-Google-Smtp-Source: AGHT+IEirRN1GLj61VsTz8DDbcV8KiBdY8K0R8rblYbUunNPheMhhnlulDmNLmNYVFKQ40y1kFdJCjcAd4+9Z1AuiGA=
X-Received: by 2002:a81:844e:0:b0:63b:b829:dcdc with SMTP id
 00721157ae682-64c7123c021mr48087507b3.1.1719839617273; Mon, 01 Jul 2024
 06:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
 <ZoKXt0jPphoM5nmJ@google.com>
In-Reply-To: <ZoKXt0jPphoM5nmJ@google.com>
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Mon, 1 Jul 2024 14:13:26 +0100
Message-ID: <CAChcVunPFBPmZ-NxBTAD56Gf_WcSXDHkFM_CzhbkULzDDo2NSA@mail.gmail.com>
Subject: Re: Determining if a merge was produced automatically
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think the documentation is quite clear. It's just that it makes that
feature unhelpful for my use case, as output from the following
command is subject to change:

    git show --remerge-diff --pretty=3Dformat:%b <merge-commit>

Now, if that's untrue, and the output from the above command cannot
change, then yes, the documentation should be improved.

-Pavel

On Mon, Jul 1, 2024 at 12:49=E2=80=AFPM Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
> Hi Pavel,
>
> Pavel Rappo wrote:
>
> > However, this bit means that I shouldn't entirely trust its output:
> >
> >> The output emitted when this option is used is subject to change, and =
so is its interaction with other options (unless explicitly documented).
> >
> > What is my best course of action?
>
> I'd encourage proposing a patch to make the documentation say what you
> wish it said.  What guarantees would you like it to make?  That will
> help with others in the project being able to decide what it should
> guarantee and what it shouldn't, and regardless of the outcome of
> discussion it would make the documentation more helpful for the next
> person.
>
> See Documentation/MyFirstContribution for some more details on how
> proposing a patch works.
>
> Thanks and hope that helps,
> Jonathan
