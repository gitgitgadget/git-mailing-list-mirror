Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94852B660
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072984; cv=none; b=bNjt+RuNJGh/sGBO5Hcpa2i/NtHAJKL+rk9Mudf2nbXn3PmcRFCy6BBpkPheLRwhuPTc5vDAYfihmq8yoFWPeY+yjt7rsHdksm0zNkMPKfeQz0xSniB+zlB39wwY14CG7BZ6EcDtaePvYvtvqj9pbbFqSRI08yodlbTFfstKOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072984; c=relaxed/simple;
	bh=FHU829YyKoHLEWM1aslVtL5/Q8TmQAJcZH7NBFm7o1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+b9nFPq9O0qC7eoVy1/4xoK7Ar8l+uKIo4N+j6s8gxIXBc5KpJtobaj51h83tVdaPOOh8+ukyy8pm66dWNopzW/efys0v7OBOTtZThAD3Wt4Is4rxNa5GAFPPcwfPWBmcwmGvbNgET1wvo+ZciugOnPr9CW4hbPVHHRMaAWtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAdxrzCI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAdxrzCI"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad69e4f2100so42351266b.2
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749072977; x=1749677777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHU829YyKoHLEWM1aslVtL5/Q8TmQAJcZH7NBFm7o1k=;
        b=eAdxrzCIBbZ5lxVNQtNr9E79vOZ7YdEqTqXGRuu5JShkMK4XBkFLSH75vl4ccpc7BA
         S7mDbdyvPjOyeOaZ7nr5rJezPAbsjtm3LzNs/8QHi6s7rljZXNa3Mwhc+Dq4Quj+lmBc
         0xL1RbrZAyjhAlH/iGo4/yhv94mRfafvpQocGzg6RVOgOjzJ7vbogRLHmGL4lCv6iVHt
         8wFbaOC19ADbIRLE7Gt80q94Lv/BOMkx/Rr6Cu73FmP2C6wshexZ41ffZVowVXfs+VuW
         IgBulDzyq7+9afov3jf46F0EnWV1fxznNlR2f3HJBEhoDuB2v+Bu69VzWbNVARtup8Mq
         FaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072977; x=1749677777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHU829YyKoHLEWM1aslVtL5/Q8TmQAJcZH7NBFm7o1k=;
        b=GiAM+mYCxoaaYP83RJySITGbllZFk4cS8vaqyGX4nRgkLLVW/uM9CoTw4XQZSfFUfp
         q2C0T/EB8ir1NkQe+RbarCsRuVFqjGYljn0Uo6Jl3G8Pr7bdk2Umvioy1zpZumzrrSIE
         QIUhVXI2bIK5zlBiB/+jI1OwNEC5PP3AB0XZ5tGmb1CELTxWbT8FZWBcGUUQv34hLGJp
         St3fvsqEzqZ/hR4tIQtxOzFhm/JFU80EB91VQwSW/SyKyvZj65y00zepImb2dYYHd727
         /1CuyoH0PKeZVUcQU7R3/rV7tNMhDRNV3sszQf1hcW3ZZItk7f3VbYkmbyF90fnakFMi
         sSvg==
X-Forwarded-Encrypted: i=1; AJvYcCWOe65dUPkEl0gBd9EJMa2DOV1PGC46cIfor/+u+VxO+IDg+Vt+9W51HcI/K2kZWjPQ19Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTQ1qyJMiFhoO5l95i2pLn+mVtqbGlYoK/FE05YmFY4R7ecvL
	qMFlrPClSfKcgyw1Fvbi4x5ymSV3VPaOfPUCpAlcwtjBJIq2Qnm7xB6QVeIbUSF+nwiCyqg3Nqr
	aC/7IJOSgkU9duFGBBCqR4cIFb/Spv1Q=
X-Gm-Gg: ASbGncthx6E8wdmVSy2tL+IopAr2tt/+vkE4p1JziYQDu6xsC2dHK8sD3PFVkZRWg7W
	+JqOEIrDetI6UNy0Kd0KzVYohnrASjUYoMBeDTY6cz0DqXy598k27maPcSxfJqjwpjG7ieCye0d
	kQi3/ugjZ5M7x/B8qUHaYxjiqhGZ+CBjFRrmVm+1D0bUp4EdMDtlRQ/9C3YfKPrGCirw==
X-Google-Smtp-Source: AGHT+IGr6MRkd8KiGXdfKZsnte75keibJWyCzbqiGgN5X9oudZ4MWgnPRS/5T5OdsnHO/hbUrs6tYTgRrAO8VR7h76o=
X-Received: by 2002:a17:907:940f:b0:ada:abf7:d0e1 with SMTP id
 a640c23a62f3a-addf8f25697mr357852666b.37.1749072977110; Wed, 04 Jun 2025
 14:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521232917.2333291-4-jacob.e.keller@intel.com>
 <374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com> <f41be4aa-b16a-4072-8999-3c5874f2bce5@intel.com>
 <xmqqcybjb6pk.fsf@gitster.g> <04ea6073-16fe-43b6-919a-08187de030ba@intel.com>
In-Reply-To: <04ea6073-16fe-43b6-919a-08187de030ba@intel.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 4 Jun 2025 17:36:06 -0400
X-Gm-Features: AX0GCFu9IwYIRKJMsPd-fFbOMu4mpK8WQD6APe5G7ucz8terORgY3nHd2p_UpDM
Message-ID: <CALnO6CDUVpn-G20sFJviwjXX0xfjkG=HiUAMnWw96JCX+qyqgw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 5:05=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
>
>
> On 6/4/2025 1:19 PM, Junio C Hamano wrote:
> > Jacob Keller <jacob.e.keller@intel.com> writes:
> >
> >> Would you like a v5 with an updated commit message?
> >
> > What we had was already plenty readable to me, but if you think you
> > can improve it further, I do not mind waiting for another round of
> > update.
> >
> > Thanks.
>
> I'm fine with it as-is. I think the minor nits from Ben aren't worth a
> re-roll since there is no functional change, but wanted to confirm my
> opinion :)
>
> Thanks,
> Jake

Fine by me as well, thanks.

--=20
D. Ben Knoble
