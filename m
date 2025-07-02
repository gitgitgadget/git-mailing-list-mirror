Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157D1EEA5F
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475233; cv=none; b=cfEFRZpvEGozOt6mY9kX7fYylhC08VanY1BcX01Ebxdn+tzLSKHjrwHvtAY1nIrwLUymYxtoAAYWWck/0lqulS5oBZLM0maR5wRB6JC8MqillMDDag6/oM6pi6XUmYzWRMf7VyogKAIbCCVzP17Uy5/IzHPSSVXhTinVqWM1VKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475233; c=relaxed/simple;
	bh=e2Y2BCs53AqZrxV/O/vTJV8BGCC2hH8Ik9jR0Ou4Wb4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=qD1DO3jiU6vkgGxKmNaKGPQlxXW4c9lk+wwnffUIGUZdoiYRa30B/XC6d5XkbGXBfHGHBPwTmNqBn8r7uHwfHN9Jceul2StBcfD2/yK/pDTNDE0ou3qJgOpRsEDXUEcWArcTEI+rQytYWkWtC3XUtB9NTX9zMRNZ7khTaHshwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UklGHMXx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UklGHMXx"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-708d90aa8f9so72932127b3.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751475230; x=1752080030; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fbd0B6wk/D+4XRRSrt3BosvMLR52NPRBMoAE+2k90A0=;
        b=UklGHMXxBQPsOpkGfnn1vujC6CqMNnL5J6dtkds6FgPiL48d9Lh6BkhUQQtxXmk7kt
         dbP51CxbqvJrdrZphAcRRkUc+HLoCOcACxvWzLGdBmsdE7NrttbV+v+0iC4g/JTGTbhE
         yfMB7pOnmBATe2ao1y0vjE43ACx3D/HqHqMd0obUZomOyBKCSd8wwgP2/7nlTq8xxW41
         31Ku5FXSsdwAVc11U5ptPcoNzTjv0Dki/cQfrvlJtUxRd4n2EMwAMZmZBmODi3OeV9RD
         5Y+qPEtKmCQyR8Xt1nSdPSx4OLd/irwxjXbiPOZJmwsPQoNvvrHTzbc/kY9la9SfLgal
         lUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475230; x=1752080030;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbd0B6wk/D+4XRRSrt3BosvMLR52NPRBMoAE+2k90A0=;
        b=TuDJ7yjE+M6jVfM9n6LdD+9pFpD9RqGOacGaophZp+I0SsukOeJH4L15oNmTdIPoGO
         HxnbcKfLAfWKaRMg217PXVxVoek20P2+s8RF/DxfxOSvFXo/c+3n+bvUyZcTw01afSi9
         wWURUrPzF/SX9kf4pRSzHuafXWDCp3vSJrXjBAku0uyVhbVohpxaCwoD0imYn6ka3PsF
         dISWafQm1/DICnWa7lpU1oCsKm5oH2EhqlUmQw6wisZ9TV3/lKoyxr3kbfaDWARmmhtX
         cgVgXPxxOr2buLxAcGlZ7CV56Ze40ri8I575l9KF/mTz1c1DmHcAoOAVxriwpxSeoPj4
         6MrA==
X-Forwarded-Encrypted: i=1; AJvYcCWvrc/Hn0RJQV7Fg+z7IqlnKWCboThsVvpEXNrCshxm6YWtho2n2rcaLoDIfKmsHv17qSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJnguDhFQd0FcAuvC0M0R5wh8xQTCIy5eUVCfUiq+oKxDdfeY
	9dPC6v+A5aQh/eMI7+A/PMO3F4KemopA/vqct2CHlLoGleUfk4RDNHsLrxzXqTS7
X-Gm-Gg: ASbGnctmc9OB7TlNAv/bGWd9P22tgtwP28vWs874aHGBlpWyyPNiJ1Pz/f0VEe0z7qo
	QgftkVtMz6O37tC7tlhpclFWy7QAAocxr3a0g4fCwewZlmC1Q66NSg7JNXAopXuP57MuRIO44jx
	YcSVKbfMxPtgE7pAke9NGS9sHim/pxWv/V2FZ1qoqq+gkgkHwA1xGum3IpAAo4xpds4685hkK+d
	/F8Rq3nuJZlt+bNot28eUEnH5LaNUswLFCIkq6rkaNstsSQ2xyu4juipFBS7v2mhvg++uDHz/AS
	VwobGHkR4OcJhRRapJX5fWnDRALMCbxz4CMOsT/o6wUCIGDsBhbFtW49gL85vJ0Rwy88SUjA4Jg
	sS7I5tSDp4jRd7n1XRGJpcWD8kg==
X-Google-Smtp-Source: AGHT+IFXwC7LVkb/Bv/5dzkgytp83B1zYMy/0VNgFm0MMlwnhJTz3RYt1TdKFR5VXpltpLgkBq66SQ==
X-Received: by 2002:a05:690c:3801:b0:70b:6651:b3e2 with SMTP id 00721157ae682-7164d303420mr55159597b3.6.1751475230514;
        Wed, 02 Jul 2025 09:53:50 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:1001:c7c7:8205:abde])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cc3c37sm25180497b3.106.2025.07.02.09.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 09:53:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on 'the_repository'
Date: Wed, 2 Jul 2025 12:53:39 -0400
Message-Id: <3CBFE196-1666-497D-B92E-5272736E8B94@gmail.com>
References: <CAPSxiM9ahAPEr5fj_A1RpgYjJQmv9kZ2jYfR2Knat5yHZNDkEA@mail.gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com,
 git@vger.kernel.org, shyamthakkar001@gmail.com, shejialuo@gmail.com
In-Reply-To: <CAPSxiM9ahAPEr5fj_A1RpgYjJQmv9kZ2jYfR2Knat5yHZNDkEA@mail.gmail.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 2 juil. 2025 =C3=A0 07:18, Usman Akinyemi <usmanakinyemi202@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BFOn Wed, Jul 2, 2025 at 4:17=E2=80=AFPM Patrick Steinhardt <ps@pks=
.im> wrote:
>>=20
>>> On Tue, Jul 01, 2025 at 11:39:48PM +0530, Ayush Chandekar wrote:
>>> On Tue, Jul 1, 2025 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>>>=20
>>>> Patrick Steinhardt <ps@pks.im> writes:
>>>>=20
>>>>> On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
>>>>>> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
>>>>>>     expire =3D TIME_MAX;
>>>>>>     save_commit_buffer =3D 0;
>>>>>>     disable_replace_refs();
>>>>>> -    repo_init_revisions(the_repository, &revs, prefix);
>>>>>> +    repo_init_revisions(repo, &revs, prefix);
>>>>>=20
>>>>> Does this work correctly when running outside of a repository? In
>>>>> general `cmd_prune()` is not executed and would instead die as it is
>>>>> declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the us=
er
>>>>> asks for help we may still execute the function with a NULL pointer.
>>>>=20
>>>> Good eyes.  "git prune -h" would safely exit in parse_options() in
>>>> such a case, but this part happens before the parse_options() call.
>>>>=20
>>>=20
>>> Thanks for pointing that out, Patrick. Right now, `parse_options()` is
>>> called just after the `repo_init_revisions()`. I can move the call to
>>> it before this.
>>>=20
>>> Although when I tried running "git prune -h", it still gave me the
>>> expected output.
>>=20
>> Well, as long as it works and as long as we have a test somewhere that
>> ensures it keeps working I'm happy.
> To add to the testing part, I noticed that there is no test for
> checking "git prune -h".
>=20
> You(Ayush) can add that in "t/t1517-outside-repo.sh" there is a
> similar test for that also in the file.
> "test_expect_success 'update-server-info does not crash with -h" You
> can check it out.

Aha, TIL! I=E2=80=99ve been working on an (unpublished) series to make help-=
all work outside repos, too, and I am going to add tests. This will be a nic=
e place.=20

>=20
> Usman
>>=20
>> Patrick
>>=20
>=20
