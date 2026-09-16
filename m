Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF983B8BBB
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581210; cv=none; b=qUqo3is4/8t9/bBMQkqaNiXkaPSKb787Q30BE4cfsWDXATFoxBBVGUdNqahSGpki47Gx3mSn+Mz3asy2SeHlmerrJTj/H05gki6r/xheDXwEe/C1w/kzJAkyni3wRXnUyVcoJlssb88lJie9l/K9EP5y7W/YRPbX8l47EN06AZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581210; c=relaxed/simple;
	bh=PRsjJmZ62TUV/CzfIF8wudrbP5w7L1hT44uTkf6aFq0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=qx9BC0Zrck0ytx4OmwXZnq7Ki461FPUmb1QBXzkvC2Prf8VcSI93+0aBjoE/VMgG0W8JEgnLZfyLs1BXiJ/1QF1/Meqx3q3z++/ciUAZq9n8h+MZGL846SrfqZj0AKOXRTXtmIiKvSijdzzknOTP4gWoQTb7LElVPU3UJp5r+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnJ+8auF; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnJ+8auF"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939ca12ab70so126471985a.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789581196; x=1790185996; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRsjJmZ62TUV/CzfIF8wudrbP5w7L1hT44uTkf6aFq0=;
        b=pnJ+8auF7ju6SA+M0almEGa4jH8DEQgUElovdanMyQxbBIQG6d7IrUraRS9ttbZKo4
         x1P4hbRkE9ta6jCBd69r7arwaDFPGSjh3yj9dTpZfRvsBbfC9Uhfgxm0du0qo+y7Nb0D
         0aPLi6ABtr3exL+/004ysyxoKQd467j1qsroH/VLuBeZe7vRg4BK+K0m8FNIuU95vo/4
         +x0VTeCF9CnRVIVoBP0K6XdfGDUi5DpqLg7P5UvrcpDbl3ecJ0frCVRbItRb64bLrlMj
         RHyFnYzjzqw+ARP2cyZqXwWTIJEMY2cO6fkldpVg/3AByuP8tYb9JzMPmVOgb2UZvdpA
         x6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581196; x=1790185996;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRsjJmZ62TUV/CzfIF8wudrbP5w7L1hT44uTkf6aFq0=;
        b=Y9hZJJLic5aUbMvScVfh/duC6zwW9NVTiLa42ZF6gbru6nFcYRq5q1MiP59r5D5rx8
         1yZsitGGu+m2N2scLwN8OCtFOfsfgNSCKlMgnws2sQev7Gz0gVIinM867n4x0IPoCJHN
         +HBOQQsPr3HUp/axz3PZ5v0tMQEVXJwzcOtmlHgB17MSWmE9JOi1NA1suk8npHoZa6sW
         9n4R1xaUr7aKJzWbvBE1wcvekLN0iQvV2CZPiLH9wqsTXegmN8kiT05ysgzFWtNPSkHI
         in8W3aPhd0/6JQfUIw9Srj5cTIoja/a7apkMZVQIGNZuSCiEq5pR8wMVsFHHcAkmQS3m
         bLFA==
X-Gm-Message-State: AFuF++mprPEFlMjyvw54NebCOLh+M8gRT3loJL/1K5twJ2YC6efXWuST
	8j9ZmZABRoRse9fGk9SwPFqqlAjmEpZIaH9v3BsKwpyMTMwTG883iD9K
X-Gm-Gg: AYBFou1AhcbsWgVc8EA7wyw/7XFNmhTjsr69fwya9LqBMw5oYAeTGCYG5YBIjibN713
	tuWhhSYvmrE9EK+/UWU8xqmUL8wY8ccrq/lcg6eN+x+FSomdMNrepllupx/Ck0noSMPCqXSTgmr
	PDFup4nFgtVFAfq+zgVvjvDezYLvw1M/KP/JUMjPlF5E1ayAqI5wYx4gkdRgHBfGYy1sCi+zfQF
	9alKRQC72pQUi099xQZ26UXQcGrVRZWhOilK8eXcnz0f69tbQHidRr+lERHcTw/wsSwDtC9zj1L
	ZhZubRkdoMYtNagHYRoCLIs6Qva65SYyWsP1T7hTNzpdae7R15b5d7vwUVWGiyWZ35v+VISPuRe
	4/jyEvJzLPcNpOFiQQ3XpcN1Daizk49NLRxpn54HmZcceIMh6I7HzV0TruZ0Egz24RYMXhGwHbk
	YO5WHUiFtPvzMpnMrKlJm2+WjTiUpwkdMEOTfB9Vpy8MiNq8QTuGq2tGBOu6OQ6sDBryugmr2iX
	sPhCwj51uIn2oRs2mLsNJ9olIK4evg3JV3+a2yFmek1FnNaEJEaEKhm1CYNagFTi8t4bQp0u43+
	bdxh9co+p+iUlV8fz/yFsvBoVcZV+MdLBMwoW+BOlMdv+GoW7Q==
X-Received: by 2002:a05:620a:8087:b0:939:e71c:7740 with SMTP id af79cd13be357-93bb727a33amr529123585a.0.1789581195505;
        Wed, 16 Sep 2026 10:53:15 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b000:ef72:79ad:d487:eea6:8511])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d18e5asm274945185a.44.2026.09.16.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:53:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 3/3] push: --force-if-includes should allow fast-forward
Date: Wed, 16 Sep 2026 13:53:03 -0400
Message-Id: <1BCA7C21-AC51-4706-9F2B-27BF2E94A13B@gmail.com>
References: <CAHLx=On9sSTR+Ei2FmV7YSDtJ85SAzL3x=ALns1vsotn6c8Fiw@mail.gmail.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <CAHLx=On9sSTR+Ei2FmV7YSDtJ85SAzL3x=ALns1vsotn6c8Fiw@mail.gmail.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 16 sept. 2026 =C3=A0 11:52, Tyler Cipriani <tyler@tylercipriani.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Wed, Sep 16, 2026 at 6:29=E2=80=AFAM D. Ben Knoble <ben.knoble=
@gmail.com> wrote:
>>=20
>> Hi Tyler,

[snip]

>> Perhaps we want to
>> make "deferred_reject_reason" more clearly indicate that to save
>> future readers headache if they insert code around here? I'm not sure
>> the best way to do that, though, so maybe blaming to the log message
>> will suffice.
>=20
> I tried to indicate the rationale with comments, but I'm open to
> changing the variable name, too. I felt that the "deferred" in the
> name captured it, but the name also feels a little broad vs. what it
> does.
>=20
> Before I take a stab at a reroll for commit message updates + variable
> names, I'd like to gather more feedback on the direction and
> implementation of this series.

Yes, I think that=E2=80=99s a good idea :)

> Thanks you for your thoughtful comments, Ben! I've appreciated how
> you've helped me think about this feature.

You=E2=80=99re quite welcome, thank you!=
