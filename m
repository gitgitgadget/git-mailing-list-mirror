Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FAD23AB86
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548440; cv=none; b=rj8YeFt+kdAmYIbgor4UiyFdp9w06Qz9Dd29lvA5FujXGuTr4/MTfOXnkUL9L1NZyLmIcD38GXuVIW0Fmnbr22+HnpPjHqtVid++RuCjgIzuZGUmcJRpAu2wKVeA91Oz2uSJjt6FGowh8GOcQEfOZjFol/itlX3i6Pivvm7DqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548440; c=relaxed/simple;
	bh=sSCZzgJlyTSNZQ7W9hiva37uR83u2cnJXXCGnTXJ7c4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=mwKKNfyBKjuA0IBbnfiUGSKGBx8pSxquIKPhDfUKr9iNODenAS3A8cmV7bI4qjiVIes35lumBKPLPd102ZAqlToB3Gbhh5H7T2QmVZZnaabBtiPhi9i2kqkG7Cc/YHVX1JPsdFnFKPNJjNilwH6jE2NMrFf1AQSiMManlL267+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S80mYZsh; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S80mYZsh"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e812fc35985so6467753276.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751548438; x=1752153238; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMLnC95MPSvSnTdWvBT+uyLa58HiIRME/h47Nfw9/6k=;
        b=S80mYZshyR3s11w44QGnkv+caF6ws98mD8CIb8BXN81wNhlNUu2JTWWH9DawYFzROo
         JyeEINCGLAA113eFV3yzirQ+/4avlqLs8eL0NTPHB5M3Z34fAim77fC8klh6rp6+f1hF
         ExYtuSEcO3l2Wx3KkfM1stYxFU6XgR9gFqlVVGOD14W8kToJpJpsAfnoc3hkxCz8LicL
         3QGSSHxz1Vc0ApSWzoHLW2MDnI/cQkpAGLsqwMmIXesWe4FSUzuAdPTG/0NLcOtEKd2l
         pCCEyJXR1n8+oGCbrX7tKqFoFWxu90jlqGhi+MA+eTThIRtr5Z3uhjGjSKV+p6o2o/UV
         F05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751548438; x=1752153238;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMLnC95MPSvSnTdWvBT+uyLa58HiIRME/h47Nfw9/6k=;
        b=ZrqbQyJmRfsEUIK1/erXma9Ooq03aU3nvIpIsvdZ2EFOFfYsVMrxuxUaHVA19xdArf
         t5ye7zYCcpP9N/g+JZw7L3JL10MNy9QL5qwUVhl19e0gbvzH4HLX9OyofeyHI45O0p4K
         Zs5F0cVYpG+7Vqjj1j5QXiRHYUBOfINGcdmJor95J1PcYtKEaw1t5idJsG/3fQ4K0Kno
         Xe7D0270QQ3aIz+FnDPwMTEjfrGEJoj5yjdns/XqWAayP6kdLRV04xpGxDmFuFGI+U2+
         M+Zz8cVQzrDkKw2OWHkloWZewulJGBX7C4ALgGELjaPQ0fHNG1iQqOEt6EdgM1p3tYCq
         imSw==
X-Forwarded-Encrypted: i=1; AJvYcCXAKLOw9r40dpLVwbFf9zWsoONQ461r6uS1YmDr4sKMNiG3OwyDSERLaGDpEuVY/vehxhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmx1h+RZwIBxlG3xviMV6hFsimA/F8t+n2fUniTlvBf/kDjBZx
	m7Meh1v33fOeAVR0vxUxNtZHTDDJ3LFtaHwmvQursf8ZXD8tCUea95fJ
X-Gm-Gg: ASbGncuNVhaDwDeQ74KmOSSxhPSZnpsneRM2bQ3LcnUimt261LyZ3G0hSZVAkzERFzH
	cXCbuhK5UMt84YLCmE2ku3Q+g2KCdDsQvJ53oJdzDLfGPDe8qpm9QzRR6A6m7d/dkPSERLMvwM6
	5U3x45rQxGnVwfssgQQrzI+eNL03XThdo0bXl21n9BmiCUDjgZZo2CfpasqrcO3JjOV39c3zo1Z
	e8hGGTKvHxquYAZHqL7UAnnDcPhKSjb0nDVn963p8wKjr2q10NboYmN4IMt6Fp0gi/1UiN9t65l
	GbQvzOFqmQZWqWw8n9EC4IDiPVmV/6Uou/J721gjNmJcDApBLUAcyfilk2tmEu02cKasUXRqava
	np5en6n+TtLxjmAxxBmRUdQM=
X-Google-Smtp-Source: AGHT+IFhsjmKXW8QqoieKeMsEkBcliwEKWUJW2TOPrOkGmJKkFyKH4wZEttQm81AZfFjRx3pr/oRsg==
X-Received: by 2002:a05:6902:100d:b0:e84:37e7:490b with SMTP id 3f1490d57ef6-e897e26007bmr8499193276.34.1751548438075;
        Thu, 03 Jul 2025 06:13:58 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:d474:ea:3b09:dc6b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6b6c543sm4365422276.23.2025.07.03.06.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 06:13:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Feature Request git snap, Lightweight Commit Workflow for Iterative Development
Date: Thu, 3 Jul 2025 09:13:47 -0400
Message-Id: <88CDEF6D-A01C-46BB-A394-CE0E3C3F9B87@gmail.com>
References: <aGWq7vBSYuuKW69o@fruit.crustytoothpaste.net>
Cc: Suraj Bhadrike <surajbh2233@gmail.com>, git@vger.kernel.org
In-Reply-To: <aGWq7vBSYuuKW69o@fruit.crustytoothpaste.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: iPhone Mail (21F90)


> Le 2 juil. 2025 =C3=A0 17:56, brian m. carlson <sandals@crustytoothpaste.n=
et> a =C3=A9crit :
>=20
> =EF=BB=BFOn 2025-07-02 at 18:30:17, Suraj Bhadrike wrote:
>> Hi Git contributors,
>>=20
>> This proposal introduces a new command git snap  designed to support
>> highly iterative development workflows nowdays  influenced by AI
>> coding assistants.
>>=20
>> The rise of AI assistants and agentic AI workflows has changed the
>> pace and nature of coding. A developer might cycle through dozens of
>> variations of a function or component in a short period while
>> collaborating with an AI.
>=20
> I mean, I do this too without an AI.  I frequently want to make changes
> until something works, and then snapshot it and modify it to polish it
> and make it more presentable.

Yep. I think of this as =E2=80=9Clocally I do whatever I want; polish before=
 publish.=E2=80=9D

>=20
>> This feature would provide a soft commit or snapshot capability,
>> allowing developers to save their work state frequently and create a
>> new commit every time as a snapshot or checkpoint without a commit
>> message and flag where We can provide an option for developers to
>> include files at the start of snap Session.
>=20
> I think a lot of this is achievable with current functionality, just in
> a slightly different way.

Agreed. My variant is something like

Repeat: { hack && commit -m wip --amend }

The first commit omits the amend option, of course, and I can inspect previo=
us snapshots with the reflog.=
