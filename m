Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E2453A57
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634780; cv=none; b=JPvD2RTLsgT96HZ2rSMpi34LOrHs89+uVKaaA31GpHIsDIPyPhGJs6uYlrGTOkBzFWhH+gL3dmhcRwkPBTi+6ZEC5t+44ZYPNPKr8kNMdJl4O7Uqr90+7/id+L4cG9Gu447Zg+JfbsR8is3kuyo6ZnT5Y0zFQMtrNSjEtUzekaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634780; c=relaxed/simple;
	bh=2DrRyACA1Ge5QEYak+Hdkt0+/i+nG2hYHOv8EgvsfRE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=qXzm6PEnmeXI9Imh/3U8EQ3NGz1vrKAMOphGRMgiUWiYE4rWBbjvLJWKRvuIcS4I4Z7DpZ69GUu9kmY6LOSrwchOYiXl37WaEz4Y5LBsWnFOsgxrFk932VO6ea+oruP1aranLinwnQ+l6NSJSzckkRUMDCH7Dg0AtpBE7bS2xU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpPFGPuK; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpPFGPuK"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66e63afda8fso1821614d50.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788634777; x=1789239577; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=65+igZW6h3RAG21vikiZjNqbluyPmMaYr1jBLnUumSg=;
        b=ZpPFGPuK3NhmP61wv53vRCEkIcdQpBAa5B0SO/Oius1AC+ypKzUNRKz2O1iQS8fAog
         1S/BmVAE3Tx3BzzYpUD2nlEeJ5PX04hOBO+vpfBOMHTnAoXZwSV0l9sayyLNsomzcDpE
         OhZpfQ3tmIVLHr4WonWi3hZ1SINxzkDOq7lbEwHav2O47wCB+2cG0CAX/Q6Ac5l9hfPm
         3sl5EILWuuD0bf81EffNlIFPLeMzO1vqs2h2bXXJMlt14V1T47dCtJ/gxJCT1TkFAWua
         UfaZSTLfOZrCoBv3uP447WZEhbu6iHs7qvW61RQ2KydGnJcMdq63n1FuYZHG920jkFxY
         DToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788634777; x=1789239577;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=65+igZW6h3RAG21vikiZjNqbluyPmMaYr1jBLnUumSg=;
        b=sdEQ6soDBNuSagoYhOhMYDT3iwSlYYoaiUTn0J1XI+5G5iTdzBhYOo7uLVr0wAhaqj
         6Cw+5HdrdC71gsWnkJeWxgEx7crSgJxC3BdL3pbdyyM16Oov+WOKm1KLPc54+yz2hzg8
         9XlBOpJHJVPzaWVjw+zLLWAr/clpSykx1iVcjKZfNg8lezxy3D+DK5Bgpc0qd3JVpyBd
         rX73ZIt7aTJEyuWQ4wN0IvvP41iKbu9HW9oGV27nF+vDDXn5G+A7aLFDZDDWBqh+L7s7
         PTQo1tpjCOH07jrIrfq3VxoyLj2LZ5nIsbED8EJUKkteqbqNkLBi9moTA9SKSK3U8dlc
         1tFA==
X-Gm-Message-State: AFuF++mwKcTbVHLJ/K+gFAIBEbuUQwzYBZoc81Umqgn2BoOiESuTEFjo
	mWBWhvOyUZAwATqL9UuLN3i3VChoMfXlgnEBxBVwOHEM7v6M0WtCzrhEoKESDp3z
X-Gm-Gg: AYBFou35aaUP7RIau9A25qIzGZX8bkfbKbdkdHcuh1KGhqc4aar3z0bOnnKUHqusqMp
	0ZU6hU/jbqQl8JTPIMqgQUttUi9v3ijYJWRo+iuJTXzYDfG6d/WpzlkapcnnyHqLHVV8/McnLZA
	SdKsw/jyREB+qAGms5Gg2AlXnacEfQlaLOf2iaE9vh1pjkzu1Ku6azcifMWMU8BH54UqF0fdwTF
	fe3P7mUvv9ih0zhyinxmIq68a/bPsEVRevHkD7+/pztW/+CHxhcluB2/gj7+8LaQBifw/wdI3Sr
	pkYdc2NbC8V0TdV+uvkoHlNoQDF0NRnHSC1VBJA7QxwSAF5qqgufJ60YLv+mIUQftG9Q57aAxgu
	StkqDX9qfxY88INqo9d5cd/DPc6d4o8vvsJGHqcbaFJo7Zv0Lfe8frsZVe9CBlPBEVRyKh+FiPu
	bl5f0CwGjphMfcehI6jmJzGm6164Dae8or/MHCW629wnh9Y2ukAjMm2VmswswvPFkpUDMaiIpTH
	6DNCfYj8CNPOUaKnbqYXgJBlGWNnET31GwNA/5W1lzIiXQ6g9A3bNm04JKcqTIJPB6lkOYhFkBC
	MZowDdIdtvxb9OiqraPSsdtjys3XkYjeT4Vh
X-Received: by 2002:a05:690e:438e:b0:668:9d0f:ab70 with SMTP id 956f58d0204a3-66fc1b0f667mr1839027d50.18.1788634777327;
        Sat, 05 Sep 2026 11:59:37 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1145:a589:6cad:356])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4641680sm5000454d50.0.2026.09.05.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:59:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] push: fix --force-if-includes consulting wrong ref
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20260904210122.431757-1-tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Tyler Cipriani <tyler@tylercipriani.com>
Date: Sat, 5 Sep 2026 14:59:25 -0400
Message-Id: <D798198C-5F97-4701-9050-7868B6482214@gmail.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
X-Mailer: iPhone Mail (23D8133)


> Le 4 sept. 2026 =C3=A0 17:01, Tyler Cipriani <tyler@tylercipriani.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF--force-if-includes has been checking the reflog of the local bra=
nch named
> after the destination branch regardless of what's being pushed. This can c=
ause
> false rejections or unintended data loss.
>=20
> False rejection has been reported twice that I could find:
>=20
> - 2023-07-26 - Stefan Haller reported local branch with a different name
>              false rejection[0]
> - 2025-05-08 - D. Ben Knoble reported detached HEAD false rejection[1]

Aha. I=E2=80=99d nearly forgotten that mail, and have since adjusted to
some intuition of when to force-if-includes.

I=E2=80=99d be grateful to not need such potentially-buggy intuition :)

> The same root cause can result in data loss: when a same-name local branch=

> contains the remote tip but you --force-if-includes push an unrelated bran=
ch,
> clobbering the remote repo. PoCs are in t/t5533-push-cas.sh -- new test ca=
ses
> fail against maint, but pass with patches applied.
>=20
> Existing tests covered refspecs with different names for --force-with-leas=
e,
> but missed --force-if-includes. New patches cover:
>=20
> - allow forced-update using refspec with different-named local branch
> - allow same as above, but with HEAD
> - reject force-update using refspec with different-named local branch lack=
ing
> branch tip
> - reject same as above using HEAD
> - reject detached HEAD
>=20
> Open question: the detached HEAD case. I opted to reject, since it seems l=
ike
> it might be surprising to allow in the case where you were just on a branc=
h
> without the the tip of a remote ref, removed the last commit with git chec=
kout
> HEAD^ and pushed with --force-if-includes and it allowed a destructive pus=
h.
> I made a separate patch showing different advice for that case (since a
> git pull won't help).
>=20
> Based on maint since this is a bugfix. Happy to split patches any way
> that's helpful.
>=20
> [0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@hal=
ler-berlin.de>
> [1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6=
Nr_O-GusGLA@mail.gmail.com>
>=20
> Tyler Cipriani (2):
> push: check pushed ref for --force-if-includes
> push: fix --force-if-includes detached HEAD advice

Thanks for the advice changes! One small nit on the first
patch you can ignore if you choose.

At first I hoped we might be able to stop rejecting detached
HEAD pushes, but some further thought begs the question:
what reflog would we use?
HEAD=E2=80=99s is too broad :)

So this may be all we can do for now.

At least I can replace my intuition with reading the error message again.=20=

