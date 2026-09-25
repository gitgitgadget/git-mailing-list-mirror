Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E74E66BF
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364772; cv=none; b=tuLB4IjtZ6WCXlAG9wILIqyscqNUqirahy/ghuu9LtJzdEfgbi7FuZz5/NBeWqWt5haUu1hOqDT3wqZUDYwyiv62+PkJ6i0B+1LPqDG8bk3x4ynzQob13daatyL5i0VIIBgGQo5Pl6PNaaYFlyOuOl4CQO5io5Od7CtVsYxvuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364772; c=relaxed/simple;
	bh=5+oRpP7sfVrG7IfRr0eempUlDe3LJT+UlRRRgxH+d08=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Y/A31nGP5XI+nZ/jfERQDtff5jjhLR0Rx7xqWnrmWrHEfVpLRLq0ttmfEuMLcQBKw5yQXbHSzF7cmPb2IBjGa5XxgUSx54oprhGgCWpAjSldIb9yYuqI/0j2W6xYTQ2pbLw2rZWkcsA5+C+Ke2c3VCcIXEaWBxsFnlwyPrRvKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmFsbovP; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmFsbovP"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886df36f6so5021777b3.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364767; x=1790969567; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDeyAvjrOhE5twOVdlf7+6evnNVFu/0TUiy9vmzO330=;
        b=qmFsbovPJpnPoAt6aerjkPpQUsOKiR7IelkFMmnD+tUntt7fFT19m2y24/ATjkGawJ
         TNUwjrwOqrq4GHVA+Sc7d16cq87RlYuOpt/0uFey08uQZoKNh5xpljOOgQUwvfaNyU2P
         WSvfn9S0bIivswPn1VVfi8Ys4UhsKx+8sj6wn2+gtdCqXIPjAVKBVd4uHQVGXIM6enSu
         c0/7yb/E0H6o1cpBZLWqfb8OBuVzpGHZy/xjNUcVA6ZErLIh9xri4qjiz/q3zegGzJBv
         KznDqv15XLQmsqCKEVnWvm0jMP1OHIIeilPxWksAU+4P4uPNPkNbK0lsjAGHIdE3tfGB
         dmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364767; x=1790969567;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDeyAvjrOhE5twOVdlf7+6evnNVFu/0TUiy9vmzO330=;
        b=RdFfeaLPRwIIElX9cMIVU8Z97YoC06CurbrQD5Yl1jr5oclc/nenUGzfYppIhD3cSM
         /tBToGmthmF1RMw4EUPA7Zjgl+XEGNgzCq1OEGoPByOYvkY+n3fRf/MAJKzNaLzlHGG1
         NcmQpo5sPn80W7Wm9iWnGt4vO4OaAAuKTXu7CBdZ9W2UeHwRhp3nDifONfCVeUQy6uMz
         P04F+FWHZQ6uB9/kIpuWvpAM093WFINptP3thY6gUIP2KpNWvbmyGo44Dp03ugv8OcmB
         eFUBJ9tfmrk6/79MIP1Up5LEKAed0lAF4ga7qj++qKJDM+iCDF3Jd9huhBZOW0YyGhpn
         WD8A==
X-Forwarded-Encrypted: i=1; AKwUvBwXwx8O2mSXq3Knh57AzyTzOu4PpeByOqvYGFJRihSapdebHGQ4wMmox0ZAa4sk3XeypcM=@vger.kernel.org
X-Gm-Message-State: AFuF++mgTOYcJp1SBbuT/Yn3kprjzQJ5sO8BR2OxnX3Pb89/WaLhuury
	o2kcxIBBnOrG9nmZrKxTFYcah6fcGOLlxyeb3xQTF4C3LX4kLNNLeZaH
X-Gm-Gg: AYBFou0GnS6MCnT11BWVYNCshSePxYhP0BdkjiiuFhTwp+kMtBuELy7TH/gyRKWfRD0
	BBioGh+JxoLTCj5ENWiSnDf/1r7sJOtV7OgVppF507a3NKis6TXo67wgSiscCJbpMERao/FFSBT
	bWZUI5+ErhKJtOj7xKJo4nfscMfRkey5lGAILj66LnX1+8atZtDsy3wYHHhfPH2qySlVt8+nNIX
	u5XQ8VEWug9tOG3i4/jc1J/10qwm8gXPkw6m3GEYBsQ8RpOJy2rT3gXG8Ker2tFFqZg3+yfhEZL
	awCEwoRyoy7TZz4bGF09MnwY2HBJUP4wTXEQKwUS/8YcL+gP1h/GQQExlFtdNST1INRHakyu67f
	AGGKDWXR6ojHoIbsqFRP177z+FUZ5n40EDwPYNPrlo+7Imc4bxfKAEqmVlrWZIdDJUAVA9r8Swg
	pMaAqMvpeSrsCFZ2BuXCmIHFyj1e/8RWaG8N7dBDUPJ2jTsRgc+5qOk5+1q4ckepG0IHKr2Hhon
	WTFg2r6SZgQEklETPKjShgxU40h3rTYqkXVbCuOq1ioL+vyITuXHzg7cCYv9XQrTdlhK0g8A/BC
	NXHQdVwn6h+WQDbVemUADNr17l3NShn/rURvA7ESnfIRki02
X-Received: by 2002:a05:690c:6d82:b0:895:8474:3c6f with SMTP id 00721157ae682-8a6472779bamr39449897b3.0.1790364766962;
        Fri, 25 Sep 2026 12:32:46 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:f9a9:65f6:303f:ab61])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860ff8099sm12949777b3.33.2026.09.25.12.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:32:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
Date: Fri, 25 Sep 2026 15:32:34 -0400
Message-Id: <7EF35E41-8DB6-49B4-BFC6-6BE335047E60@gmail.com>
References: <xmqqld8purb8.fsf@gitster.g>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
In-Reply-To: <xmqqld8purb8.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 25 sept. 2026 =C3=A0 14:19, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BF"Julia Evans" <julia@jvns.ca> writes:
>=20
>> Thanks, I meant to flag this: the reason I deleted it was really
>> just that I couldn't understand what `git log --merge -p <path>`  did
>> from the documentation and so I removed it until I could figure it out.
>=20
> It looks at the index to figure out which paths we got conflicts on,
> and then does "git log -p <those> <conflicted> <paths>".  You can
> give a pathspec from the command line to further limit the output.

This explanation omits the manual=E2=80=99s =E2=80=9CHEAD=E2=80=A6<other>=E2=
=80=9D argument
that the merge option implies, which is important for
understanding the option and my alias ;)=
