Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A2148850
	for <git@vger.kernel.org>; Fri, 30 May 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748637990; cv=none; b=tb92we738EGoxvqW9bI+Y2YLDOGCt6QZWXgOdrK3IXP/wXfhtzZIqmxZ/jCSikmndn0rziECfBrPGeieNwaubIE4ZgVDrY+0MEo5ues+EW8TJTIuX0ASnxsmXq4vPsfy71W6cGNmu+TffIVpBNffge156/1NYbj4oRUw9QGG0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748637990; c=relaxed/simple;
	bh=vV/shtLgRbhx0uMLEvoR+MSqv6O3akq/1m2G1KnOkqI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=XTQD4Gana/rWmzIHzm3Rg7YtmJrVd34SrjF/2JrELJkPcwnIKiooWbXNKpFIhMR9c9YQj2twH1D/WuiIYzXiSrvhGOFELrd3UlBR0Uoo+pRuu6t5DPNuTE6e/DUIkmBxyHSo+jH3ljJMxp4BT0t9qVtb2z+GViwfZoJiw+20mII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ9ZuCp5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ9ZuCp5"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8a70fe146so41298756d6.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748637988; x=1749242788; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOc8K80uqIZmRjK5hd3C5DsOUcF/rs8PWoMNlwTb7kQ=;
        b=PQ9ZuCp54yEOyPNzRY8C+a/C/dNWVztdixoyq2W17YP3Mt6YHmyLpanvPkK19hrZjH
         QSbmFF4QSdIb3OXNhoTi5gNewDuomDdBmyqdtWGkRVzRoRHPYylOjYmL7rNjEyio1a+n
         5UoPdz8zD5h063WTvYyHWQ29457Ekm15O2cjx/+QGN3p418brnjP8/ejcb5kSO4AquNZ
         XseBmr5tznRocvopHys+eHOEgn271moC/6lsOAT5/q7eeLvlzdSy7TzdXEqWlausbBUk
         DqZr+lyY+xs5I6ks7wPCTkv7SkJMDic7olJPbEbfiZQ4AWgWNX3tYPiya9UZJHuZRtLJ
         L0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748637988; x=1749242788;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOc8K80uqIZmRjK5hd3C5DsOUcF/rs8PWoMNlwTb7kQ=;
        b=vjT+Lp8MyKrSsQ+PoFnSzNr6gxzihctfxq1UqaHytBQf+mCRk1J+eod8ABr2ymEZ+p
         4dOdELH1G7/NTekFdPaqRQ7MGnw6iYPYRJHQu6IO1F4LSPy/nakhgq0dwIEjFZWmMiFW
         AnrXiDeHnEN1UIMNq66ffPMirSL9TvFOwidqZ+cyZbFBNE0sWvI2aQkQOoqZxfe8m9b0
         wO9wTS5Dy4+VtmMp1T6g9D0Fucw/Q5Pp083BWFt3hJQJ7Bw1pus2mOevF7rFFxADjQrN
         kL0TCgP2Q/lhmNVuDbskcWOQ1cegkM5OrSmxfB954U38V5iiaMRASQrfKRWPmq+tKN+8
         vZ6w==
X-Gm-Message-State: AOJu0Yz37fUtjIRmuFtOmsHGAkormoRnMZp3opNC+MT8iDSwOMyLj84s
	BaxHeWjHJHoiVs7JRi3obcAR2Jkurh1sYhow3oMPFs0f4RUrRok9C9OfElTiMjt7
X-Gm-Gg: ASbGncv2Kljwvd4x7OGmVTKjPLKCvaAEgQ6a8kePA0ATtabxO5eD5MmNvOuv70a1glR
	dSySWWJLtSG1fItjzlPa8n0MFEdpKHM29/EBTY+ORAlNNCzH0eDG64Zh2HQr9vnSfUjd3EekkbR
	8FNoaYJEzKMoNplmA5wrPda2q/CrW1ZMFnYDPCYRTAfqSMKa9xw+A/X4IPXxr8o3mTrSBB2mxUe
	RC/X6mCBBFxmvP76VkTUocrDLCfJE8OITzXeAjoed/vp6KxA4bZojNkoPaaSByGGGOkb41GWqrO
	kVeZ7d1aany/6aW4mhwIRIQYvR96/tKnA3CG8rJqdjdPR4TOVS0HmtA54dg+Sehtjvx+6X7AhDN
	130E=
X-Google-Smtp-Source: AGHT+IF6G0r+quSQ2YpnyMpOW9Wps0PYNI6YKKPNflN2/yzKE92XPUUmqZcaPeS0qxH2/uGpSkThJg==
X-Received: by 2002:a05:620a:172a:b0:7ca:eb5b:6de9 with SMTP id af79cd13be357-7d0a4e5268emr466507385a.42.1748637976550;
        Fri, 30 May 2025 13:46:16 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b113:7ee:3564:854c:29ec:6765])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a3736esm25555871cf.50.2025.05.30.13.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 13:46:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 11/11] builtin/maintenance: fix locking race when handling "gc" task
Date: Fri, 30 May 2025 16:46:05 -0400
Message-Id: <06B496C9-BC0E-479E-A5ED-BC00004E2368@gmail.com>
References: <aDnNuGvargGZtubY@pks.im>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
 david asraf <dasraf9@gmail.com>
In-Reply-To: <aDnNuGvargGZtubY@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 30 mai 2025 =C3=A0 11:31, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Fri, May 30, 2025 at 11:10:27AM -0400, Ben Knoble wrote:
>>=20
>>>> Le 30 mai 2025 =C3=A0 10:05, Patrick Steinhardt <ps@pks.im> a =C3=A9cri=
t :
>>>=20
>>> =EF=BB=BFOn Fri, May 30, 2025 at 08:55:49AM -0400, Ben Knoble wrote:
>>>>> @@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenanc=
e_run_opts *opts,
>>>>> else
>>>>>     strvec_push(&child.args, "--no-quiet");
>>>>> strvec_push(&child.args, "--no-detach");
>>>>> +    strvec_push(&child.args, "--skip-maintenance-before-detach");
>>>>=20
>>>> I suspect this would be more obvious to me if I had the manual
>>>> available right now, but if we are not detaching (=C2=AB --no-detach =C2=
=BB) why
>>>> do we need to skip something before detaching (that presumably won=E2=80=
=99t
>>>> happen)?
>>>=20
>>> We have two levels here: git-maintenance(1) and git-gc(1), where the
>>> former executes the latter when the "gc" task is configured. What is
>>> important to realize is that in this setup it is not git-gc(1) which
>>> detaches -- it is git-maintenance(1). So git-maintenance(1) runs in the
>>> background, but any tasks it invokes itself must run synchronously in
>>> the foreground.
>>>=20
>>> The flow thus looks like this:
>>>=20
>>> 1. git-maintenance(1) starts.
>>> 2. We perform the pre-detach tasks from git-gc(1) in the same process.
>>> 3. We detach and thus the main process exits.
>>> 4. We execute git-gc(1) in the already-detached process.
>>> 5. We wait for git-gc(1) to exit.
>>> 6. The detached git-maintenance(1) exits.
>>>=20
>>> So because (4) is running in the already-detached process we ask
>>> git-gc(1) to not detach again. And because we already ran the pre-detach=

>>> tasks we also ask it to not run those again.
>>>=20
>>> Patrick
>>=20
>> Aha, thanks! I thought I understood the sequence, but I was wrong
>> about some details.
>>=20
>> I was wondering if not detaching should just imply skipping work
>> before a (non-existent) detach=E2=80=94if there=E2=80=99s no detach, shou=
ld we do any
>> pre-detach work at all? But presumably that does the wrong thing for
>> (non-detaching) invocations that come from outside git-maintenance,
>> doesn=E2=80=99t it? Hm.
>=20
> Yeah, we always want to do these tasks no matter whether we detach or
> not.
>=20
>> Maybe the flip-around for me is that =C2=AB pre-detach work =C2=BB here a=
ctually
>> refers to =C2=AB foreground work =C2=BB, which we obviously want to do ev=
en if
>> we aren=E2=80=99t detaching, and which maintenance (which has already don=
e
>> this) needs to skip.
>=20
> Hm. That's actually a better way to put it, agreed. Too bad I already
> sent out the new version a couple minutes ago :) I'll have a look on
> Monday and rephrase this part.

Aha, no worries :) thanks for taking the time.=20=
