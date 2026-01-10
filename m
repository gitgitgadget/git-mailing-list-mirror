Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0B500963
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768062807; cv=none; b=aFYTwwLQnbo3GUklNVFAZ3jxPs4FKsBNCXldjf+bF4Nt6pe0OnTz8/4sKWI5oyOyVQ13yf6CV2ornImcY3mSvOYNzXfnG88DuaaXOuNS9pfok1wgT24z4Xg85WxI9MwFl8J8osEhzDIhn7WbR9AMyF39UBdve7z5Z6HlX6fpStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768062807; c=relaxed/simple;
	bh=iCS/sg52dCstfwd7A9TOis9mRJw99U458+OUyHS4/Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNm7lIRk4jsCL/q5qEQd9YkzjNVbpKek5h7HY+QRVp1yixEf8APmmmKDbAc/TXUMc3ZsKJHXY3Cly2WNAVGkk5MyHB+jwCbd+C6c2e40F3IU6a2iGz/c0+vhn3K3UY7H7altrlcAnnKx3QSTxNoLOjOYLr/J6UrbmFZpTFjLOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7iep+OB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7iep+OB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79af62d36bso915161166b.3
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768062805; x=1768667605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCS/sg52dCstfwd7A9TOis9mRJw99U458+OUyHS4/Zg=;
        b=B7iep+OBDXCxl428yMiLJbtgpyHz9TEKGIVeRh5WIhMyeIuU7s/XPXQ35kKgojdPHx
         /fcDyn0ru5hJ6OMZAP0W5Y26CKpdchb6qA1gyHS6oxZO1XBeQdJQuF040TkxCbiHHc3P
         H9uWxQQSWZ/YTnHuOMWIOPT+7+uPXC3I6a2GUJYmfa76YK35Tp2gaelhw/6ylnsDpeag
         8zePnVRJxYk+rE8R1IE4J5UcR9KyuYLFQhYGoSGecA0MvPNx0l/17210kp0Sp1CtziGK
         /TU7W0iZU46FJBF5ssiZamgxxUOACPV/cjutHpclpAcYjcQtPQ2esZEk61hIyqWkbMR1
         L8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768062805; x=1768667605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCS/sg52dCstfwd7A9TOis9mRJw99U458+OUyHS4/Zg=;
        b=n9NU+BOikvq9VAVAtlNviU2T1+CU0kp/0KuHMmG558JjpeU7OeO5XjSSeX5+/g1MOu
         +LyEpWgk94Vihq8JdUMTceOCzIrgDiqMywL97Qauvbh/mcEHInBssOoM9mqhJ6zRlIhJ
         HlfMJ/1i7I1xZzaBFxY9yhslOKY6QHDU9qPNKcLLt66Z2Bi5LTs4J9Dxi6RMTkPYPhd4
         KUcP4zejrYySbfs22wQcPJAFVtggtHIX6xUTPNIsAFWhrRKhSV8yyuilFGqQCGXuy24O
         SsNmrWX/beFDEbPVjjiCRBF2jCluXj5WyJKy7TfLOxt53ElcLv3KKE2ri3aiWWdfs/Vv
         0xqA==
X-Gm-Message-State: AOJu0YwjMDK83wIcOCSD14E0AOXYUS9pWyJGNrEWrGaJGuuz1IJImIKC
	wvL333jxyVmdrfcxA2MxLksG+QF4XnT/tJgbX+7PKXM00MzcjuC2Y9DG9ssfPYJIZWp98g3vkhR
	QkSHB+d8KCuLqj425am+KcQnLOHnJN3oDmDUb
X-Gm-Gg: AY/fxX5wbM7ZYhVJkF6Vv/YWYi1/HD1HiOwzm3TbDlJ1CRc0nx2THHqcQhy9I6bOljE
	TILPQltkL0nf5QYnpWKAty5i24kEgUgaS/T8+kdEOJ33rmiaqyZpgKPWDGhU9paXAK8szzpfe2I
	/Lo5hmro/WkLxG2jhgkBXZIDNrHLNP158PJ8p26dJTa/48izE0chBTInDtgH8RcsGfcdtAT8sT2
	Kwg5S09PZqRUy559KgekM6bgofdwUdAokP6DqD4U8YEFFLre/mpBp2ZQkf7ScmwwHG+qr+I7Pa8
	qzHCPgJDyj4orr+zy7IBJFXPw2McUqqgEF3uXNXTcguA+EHM8KxqAi5L
X-Google-Smtp-Source: AGHT+IEpM0qPz/0IOJFgom74XjROmI9/rJz4ItHO8WOgM9ZrciK4g18dDagORZl0mBTG1TyV/OAmLyrYTByHtfUqeMk=
X-Received: by 2002:a17:907:1b28:b0:b84:42e5:2b8a with SMTP id
 a640c23a62f3a-b844516bffbmr1202678166b.58.1768062804441; Sat, 10 Jan 2026
 08:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWG8DT3swDVJLS8m@lorenzo-VM>
In-Reply-To: <aWG8DT3swDVJLS8m@lorenzo-VM>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 10 Jan 2026 17:33:12 +0100
X-Gm-Features: AZwV_QiVZsOmoU5PxJn4cFeUuuuN-WNmZz1nMic8FyZ0_1TVWIWR3aWLdv1Bpm0
Message-ID: <CAP8UFD176zCSj3SBQXXPs5qAvXR7OzD8YpQdXOia9vpk5-Xtrg@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Sat, Jan 10, 2026 at 3:41=E2=80=AFAM Lorenzo Pegorari
<lorenzo.pegorari2002@gmail.com> wrote:
>
> Hi everyone!
>
> My name is Lorenzo Pegorari. I am a 23-year-old student from Italy,
> currently in the final year of my BSc in Computer Science and
> Engineering at Politecnico di Milano (Polytechnic University of Milan).
>
> Last year I had the privilege of participating in GSoC'25 with the
> organization BRL-CAD, where I took my first steps into the open-source
> world.
>
> This year I want to take my shot at becoming an active contributor to
> the Linux ecosystem, hoping to participate in the Linux Kernel Bugfixing
> LFX and the GSoC'26 with Git.
>
> Right now I'm learning how to make my first contribution by following
> the "Hacking Git" and "MyFirstContribution" pages, while also looking
> for a possible microproject, #leftoverbits, and/or bug to tacke.

Great! Thanks for your interest in contributing to Git and welcome to
the community!

> I hope to become a valuable member of the community.

We are looking forward to your contributions.

Best,
Christian.
