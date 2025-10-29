Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DB34A3AA
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754951; cv=none; b=rdmVzoqbwTVXTs+a4mblTpT6BUh1XNm6zyYDzU9Ag9AfNgGgqeRymMlRC7X/KzQ4nEdwXQDGnfueFNmoAncuFoo+1dBDooWglM8QS94dypPkXq7vbSlfeGYvOMsSOG2/cNKobsaQjdjo6Q3jq+mV0VW5hlNPJLzPy9y+tiLm/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754951; c=relaxed/simple;
	bh=w2vp7AnH669Qzjsz6wiK79DMFORBMBGtS40YMLBEH0c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Tcby/IeOCr6qqtDI8aekujcbLd1HMFkOf6MZ0IdgtklDZKtlioTTUoCcUzQCrQA4a82nboG/QFQhWYvgTu+t9+ydGls614stQQVwPlOgXJ+keiDO7hQYYyALxIP66PZL7t/uOLn2Njk8cFHtgrt7tH1ZGdFxmCBvZz2oXB3FrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTfpDbvQ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTfpDbvQ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e11347fd9so166570d50.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761754949; x=1762359749; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti7QcnQkylwdLIy2RkjTL2HimF6Txdg2MohL1sWSdhQ=;
        b=lTfpDbvQFqty4ALsTeflnDkr3kkf7/ilolOjVpb2zccpRk8TwY0zU4uVB32zaP37kQ
         rv2P6defvF2gw2xoeQ9HmJWUTiyE6rchBkQWi9QVjFc4kZujE4ROykWbfHhoQmRmsR9N
         jPNzJQ64m+CtAa/ZHlnPvJy1/SsNbVIvBwhkK3LoK+mPJ0pd0wDvu0L0QDaNjID1Tjs2
         fgzddwtDVaQlWlDgMT1w4bT9J3K2GSazExZuh+R4CHOD0D0FDAoCAMEet12E9At2YkJE
         H7mlrNk2WGBwQWG7S1XzzBd2Gv82biY7ysvBAvrDjnft5cGfVB82gXNOpjVTbF8d9KAm
         Xqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754949; x=1762359749;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti7QcnQkylwdLIy2RkjTL2HimF6Txdg2MohL1sWSdhQ=;
        b=mXtIl2xPmwgua6iPVIWbDMZ1ehuvGKSmXcattvyUiwwdTvgmpUHzbZVhV+/6YPt80t
         xBSowtjq8NKd4z/RyJr8MIZ+cqXYgFmYZXlVSA3lDaLv+bS2urX1WTWwdC1pecHIWwEQ
         hudR3/2AFhN6ixfN5NSMk9QVzkMW0hraNecLlGRrd5h8pIAcoG3pxkPwxK35mZCneyqR
         i0BVa+iYv0zSA+sT12k5p14HwJtPkT/JeGEGhiWRSSCvb/y3ebky2yuJakZptgFlpdRm
         aPnYOE+Cmq5mhe/PTNbE6QEAcc5G/M5HJ9gVP3NAQT76lAbwt0F1eHliLG0E2805+tk/
         q4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2vgJ8KxFmwznj8ZIa75pTWSugMyliE1NCZZGYdDux287M+q90cMXMYSLE4YyLijJjXXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qY6hLo1L6T1193YX3iGJaxh/sf5oD3bfEDNuHGnCVtlKKLlO
	Fyys3PfeRakQuG4Qd7sBuNvAbr8M0Ewf/hNJLtRasUd+CqGEVMJzM+Je
X-Gm-Gg: ASbGncuNDEeLGU99wPtf+7SXngzGwMEu5glz91rKr5Fixlpct+6rGO6F4DHE+1D6ENs
	80tvVwZVCIb1fu6IZW/YP7Jkx3D9Bjq9jOVx4w2Tf7sglmfCH2yr8Ma6zo54fZv6C19UUFmg6Xi
	HgfhlH0cV1aYieu9/iZ2NL7FG4J2v/we3X4esux5LQHyOqhaOTd51xkS9pi1q6sqGLMHblu/O/J
	0zb7PpeyuMrIp7Oijsu0/bunB+/Aeb00pW5QWrTCWY7bLre3pIqVnvzZfIbguiCWL/GMAeUnQxR
	F31Ce6WO7VIOYxM/Xsqjo3i5/uJzutYzmeeLt4xILBg/OMfk6UhubZY2vZJDkQzuWv6xGbzzf6m
	CO4rPcrAcVnaPXcpBcYo6hpVINdSRJPsv83xrLT8HuPWawkFspG9Y/F33laK1DIEf424YcaWdgc
	gaFbuo3z+xc4N2CMgOS9pEsR6ZMQ==
X-Google-Smtp-Source: AGHT+IEoU4hvFtzsC2NgDHBZYfYTn1RBQeVi6gyaZS6OMT3IxI4a04tLumvklCiVmhA7R1gWSS/CQA==
X-Received: by 2002:a05:690e:c4f:b0:63e:236d:abfa with SMTP id 956f58d0204a3-63f76d6feeamr2833977d50.29.1761754948945;
        Wed, 29 Oct 2025 09:22:28 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e43d:9f0:7b52:4db])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed14081dsm37223997b3.6.2025.10.29.09.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:22:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] refs: support migration with worktrees
Date: Wed, 29 Oct 2025 12:22:18 -0400
Message-Id: <598941EF-43F6-4642-B665-C0D65C5CDABB@gmail.com>
References: <85d6fdcc-cee3-448a-8bda-72791f342be3@app.fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Sam Bostock <sam.bostock@shopify.com>
In-Reply-To: <85d6fdcc-cee3-448a-8bda-72791f342be3@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (21F90)



> Le 29 oct. 2025 =C3=A0 07:37, Kristoffer Haugsbakk <kristofferhaugsbakk@fa=
stmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Wed, Oct 29, 2025, at 11:10, Patrick Steinhardt wrote:
>>> On Tue, Oct 28, 2025 at 09:00:43AM -0700, Junio C Hamano wrote:
>>> Patrick Steinhardt <ps@pks.im> writes:

[snip]

>>> * If "you must do so from the primary worktree and we convert all
>>>   the worktrees attached to the same repository" is the only mode
>>>   of operation we support (which by the way I have no problem
>>>   with---the first bullet point above was asking question, not
>>>   suggesting change of design), then would it be easier for the
>>>   user to use if the command noticed that it is not in the primary
>>>   worktree and switched to it for the user, instead of complaining
>>>   and failing?
>>=20
>> I'm not sure. The question is whether the user recognizes that migrating
>> references in the worktree would also migrate references in the main
>> repository. It might be surprising behaviour if we did that without
>> asking.
>=20
> On the contrary, as a user I think it mattering what worktree I run this
> command from sounds very weird.  (But again I can tolerate it requiring
> me to run it from the main worktree if there are technical difficulties/
> limitations.  But using different backends for different
> worktrees is very weird, again.)

[snip]

The fewer concepts we ask a user to manage at a time, likely the better. In t=
his case, =E2=80=9Cmigrate the refs=E2=80=9D should probably just work. Whil=
e things are experimental, rough edges are more tolerable of course, but as w=
e are lifting limitations towards making things official I think polishing s=
uch edges is a good idea.

In sum, it can be done later, but I think automatically changing the process=
 directory to the main worktree and carrying on is fine. The curious folks w=
ould even see that under the TRACE output ;)
