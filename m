Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCC2135B8
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941466; cv=none; b=bxAJhLbnWHnXf5SM/Wy58zJZjHxrrz/sNARzh3s80DoXeUqRhMoeNtw07dHiqnj7Yt7WqPVMz1JR3PLcoKnQx1PRvoiCnSt8CrEc+kOLX3UUUv57YMKPie+lj3aXdvjUQSTSZmpHrzq4lmOjIs5vpqiJV06OJovRe+Gb821n3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941466; c=relaxed/simple;
	bh=8TZCSkP3WqualUz5Er/XmPE911CYjPtWeXIDIpaMUQQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=r7lB7EAx08Cg/oD1qG/tYIuuWNyEKRZHV6GfNm+P+YO/Tdx/HpALrV8vberHoRoWzEb5uw/AsJtWdCpzVpi4VAwrbiik3ZsVoIY9bNQQHBXm0uyhPKFylsQAqxGEBiWEavnN83H5MFnsegrCFpsp0LgYPb3ByYOaURCoFg/W3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GinItCx9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GinItCx9"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d601859f5so29859847b3.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941462; x=1758546262; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5le8SqYP1VuuW0eKPWts3mHTE4AXN6gxR9zYV5xq6k0=;
        b=GinItCx96Otg08GNWeAaT3FGC4qIrszoMElIX1tn+N4HGHBs4q5OyhziOlYfOgyV+R
         vK1ZND2OcDA1NR5N9YzqidqIApWRbqCJwVxnnsseAQr3xo2TwGw8vmfy9XysCRFxz8Pa
         NnsZtlzbqXLtSVcOVKDY7Aljh+Wh57VRkdOTLjBNLKaA3S/cWzgClc70tTmVPmQhlDNQ
         SrCYDyciluuogAWlKG79B1nZCUg68EWaEJCT0Jisx1j6FGdU0vNUHJ4mExpLja5YihKz
         OgDyLqTvDJ4z3Mxi2IQR3z4yOl+GOoyFhrmPMUs6Y6Im/+/q89YT1C3O8ciJYkyvFRfP
         QLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941462; x=1758546262;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5le8SqYP1VuuW0eKPWts3mHTE4AXN6gxR9zYV5xq6k0=;
        b=HtLsox9tv/XWxoiQ8Qel9Ed2ubEPR28rTC9sLFOIq4GcwqlGwwNXBR2GUzWB3MSnjj
         q6xg4aOkJpZZyShbW6wxr9M3qYZ72cM5hIJLM2QI45DI/jY+/InlijbS6AxeB+SmDXqr
         d8FT6e7UufVVJ2d4bkbWqsDwfOZxr829VpEFoO+RGHTIny7WW7D43/eM430Z4q6BHXuF
         UztPzPIApkg8wUp33TJItW9rvrTYYCEW+skY4mUjfl9zybZfuENc+Hy6f3mH8uY3QGr1
         0Ma1dofrWVqoo7wUfYckImTGh8+10jGJWTA8fRYdXBvot0sWNPN2N9Q9Tx2Cup/VGp6Z
         E9wg==
X-Gm-Message-State: AOJu0Yzc2UwuwqocBfufQo1+Q4vSzHtwuLvaHVX6830fNSgzmTNcQ2WU
	Sc1Bvd3LfETixHyAJXVl89ZMo60OT3aAHVUEt24+zkVydQ5D4RrU0btHOxjRRAc1
X-Gm-Gg: ASbGncsYRaxPttuvd3j43DEafmF44vBIygocC1okhzXU7Iwp49bfYyr4IAkkGJL1xUi
	xEqJbc0nDHlySeVq0dV42Uy83ZC9a1GR6+Wt9EC9Zs8s90MR0c0L+iqDIKfzW07oUU7Yeooj1uD
	9Trj7huXqsh+iFbKSsEAOBiLnzvCDWZumD1j1mR75gBf5KgBgeU6h308jSYSW0we7GScb3MWycF
	isuA6akF0PH5+uQ+wiVXUen1Mz0plZV9GYNHmrJ6h8iaZE7YBGweykpkMHidNOb3XyUf4wOAKx/
	ZadKzj6W75IM18wivW7mXOsdG2sC0DXHX1h/emPMrRETqe6v7qqyWGi8VtzGTPalABM92yzu8Ls
	ZJVIja7VPInD/RwinFihOHUOWPmhhIQ1L2CaI6EddfvuSQNWELryg9xsu3+Ob
X-Google-Smtp-Source: AGHT+IF9S3VfrCJljePlhvLRAfXNzb7bUsWmY6wo4Rj26Wp8QX6zB5jaGTE2R/BbSR6PfmdGSUFHvw==
X-Received: by 2002:a05:690c:6104:b0:72c:54a3:f051 with SMTP id 00721157ae682-730626d26c7mr115101347b3.1.1757941462173;
        Mon, 15 Sep 2025 06:04:22 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:8cfd:9a71:b61e:9f6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a4605sm31596907b3.45.2025.09.15.06.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 06:04:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split" subcommand
Date: Mon, 15 Sep 2025 09:04:11 -0400
Message-Id: <492931C5-AC12-4C5D-9321-340C2A4842CB@gmail.com>
References: <aMfdGTQWT1ES1jbm@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Sergey Organov <sorganov@gmail.com>,
 =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
In-Reply-To: <aMfdGTQWT1ES1jbm@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 15 sept. 2025 =C3=A0 05:32, Patrick Steinhardt <ps@pks.im> a =C3=A9crit=
 :
>=20
> =EF=BB=BFOn Fri, Sep 12, 2025 at 02:26:04PM -0400, D. Ben Knoble wrote:
>> Hm. I've pulled down v3, built it, and pushed to the same branch. The
>> tip is e91e23546b (builtin/history: implement "reword" subcommand,
>> 2025-09-04).
>>=20
>> Now, a heavier-handed recipe:
>>=20
>>    GIT_CONFIG_NOSYSTEM=3D1 GIT_CONFIG_GLOBAL=3D/dev/null bin-wrappers/git=

>> -c commit.verbose=3Dtrue history split @~5
>>    <input y,q> # once I even used "e" and added new diffs to the patch
>>=20
>> I see the usual instructions:
>>=20
>> # Please enter the commit message for the split-out changes. Lines starti=
ng
>> # with '#' will be kept; you may remove them yourself if you want to.
>> # Modifications qui seront valid=C3=A9es :
>> # modifi=C3=A9 :         add-patch.c
>> #
>>=20
>> And finally I might know what happened, ha=E2=80=A6 if the "modified file=
s" is
>> the status information, then it has been there all along! Meanwhile, I
>> was expecting a _diff_.
>>=20
>> I'm actually _still_ expecting a diff with v3 and commit.verbose set,
>> but I apologize if I've led you down a wild goose chase for the rest
>> :)
>=20
> Oh! I didn't even know this was a thing Git supports, I've never seen it
> before. For the sake of simplicity I'd propose to keep this as-is for
> now, but to amend that mode once the initial couple of patches have
> landed.
>=20
> Would that be fine with you?

Sure! My apologies again for the =C2=AB commit.verbose =C2=BB red herring.=20=
