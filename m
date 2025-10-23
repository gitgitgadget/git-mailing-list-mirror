Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74332D77F7
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232459; cv=none; b=YbALUWGLy4aVXrn+2NG9h5Cbhzr6I9IWnTGcusBCdUUjlqV6R4hiWS4qnbRKuHZQ11Yvik9iNoSN85uS30eFTGjhkgdpvIQPTKQhjeXkNXqj8ICrtdxzJEDyzi2yoQDnFRnkqI8UP6V1F8X0JCT6F4Dq7dC7WGwIH7HzQ+A9alM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232459; c=relaxed/simple;
	bh=gkeG5xnUP+dmfpgfYYTjnugLej/jFqblCAajxSA4weU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=LTKhR/Vb1UrTuQ3xPaMI1Ra6TLgfGMhjX+Fep1gE4KSwFh8QgqqbypBglFrR/TWn8rvAhudDtv6cBsqpRA6kWx+9kh3zsvI6vVgibKZMavtDWeFeeLNQlNfgnpc4ijnEjMG5owYIHgMY6PN1Y4r071go0L1C6H+ReLBybgtx55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdySOoYg; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdySOoYg"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-783fa3aa122so12440297b3.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761232456; x=1761837256; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLcRrlHConI853eGsY5/6hPs52YKG+fywXEVISaluJc=;
        b=NdySOoYghWaBsNPk+JmR1T/H7ZxPmtNQY6AVC46WXKWxtbv5FCKPay/EUfUOFgTlYn
         6tS64GT3WkQGGuKyMxJ3drhFDVjdYDrah6BL6+2vB2X4GeDzC/pYReK+Yw3X/Tcciw3k
         v5YtvwH7XQuRmakXckW4vJpMA81OZuLVET9Qk6x3P6F78P+mjJBUOj8wF0cNzTS7xAhF
         Up++KZKILHOTaRGYr3dYNN/oc9a5AhJJ/OAJVligpr91DygvvP2VwT6MQ6hf+efUEBu9
         1PSVCMA/nWEP7GLmmMTFDqz7HlBtfZhhYgoeVvjHo1Y4g/hTVXKdQGN5bse1SYfiITO2
         fCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232456; x=1761837256;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLcRrlHConI853eGsY5/6hPs52YKG+fywXEVISaluJc=;
        b=I3Fe0++AmBsP7yfvb6OOeGlSu6I3D/X/HAVC8Nhz1aNWvZ7p8tpvmhYVIb2MNJXfsn
         dehBxlCkuN/nHWKTDbYY8mfkIOnzOYMTHcmWaFbcKr2tnHCunZjhpdWog+Lja99t9N0/
         FfmOczlN9kU2tul817ONeUOuiEutMQQaOxYq58wbSnvM4NfkLwjdSc+RZUrFuNtqyplu
         NmcFHHLII6n85TiJgZxF37ABV2dRNGa28AJMJwIT2Bdse4PLpa1wQVLvajJgovBV8QTC
         e1EPZNM/QwIlRJNacWlV/rYoi/7yXNhDZseED+zmBGP1LVI1Sdpax6nX9/cK3pA6Na8q
         oGAg==
X-Forwarded-Encrypted: i=1; AJvYcCXCfhgoQE1I3EGpJMbfCFRdMXmm5wNl80Nw+IWriVT5VK7N4pm3PXP/d9g9ahJjuMPheHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1L0aPQdZ1FdizyplnK9DVXsZCVqUN5h4aRA66PbcHykwiB26
	ONV6hpe89Cw8/qUoxabghIoZBdDZighhWxKCXdYHoHAnWjqB0TIPSTDF
X-Gm-Gg: ASbGncvrCnZz5x1ikRaQRdAbqZWgM5+GSZqv/qnoS9at43hYVbvvJZIDfhWlwirrGXv
	uQ57Ff1QitI/oa66reBM3hyLNGHrw7VLP8h05NQ9j7F57vZdzbrVpsMhFHMNP/HSYNAOQuuEPHA
	etJATSNq4d+3NgaV5Mi2wgja14Sb0apJoGtEdDOr/kkAbZ5yDLbGpz2VDZwk8Embwva/p/t8rYP
	aI8kspeR4gYdJgnKGmwEaTrGSboRWHVnUsJgbI87swrtKLjqt4HI/sOwer4soI0hV/z+6lB5px7
	WwlytPMcKPAUODXsbQ5rWb+N3zHXDsnNBObwBT6ORQZEFMsGh6R/B/L+b4RrsvjkmgHyiNd3XPG
	0pKjFOd7a8+sXauDBuWBW9BbHHCxjZOJI+rw6vFysSmdrjU98x4V++BGEz/C3aJYi0qStEKZWv3
	yYWrtAL8I4hYu50UpsWlaMlOtPjJSy8+we9KjMuKom1ZjDIKfGn8FsXpM=
X-Google-Smtp-Source: AGHT+IF1Vc5YZ1QCI7WudC3OmeVvexRajGAj2b/k1R4eRmXAQsLPYhi9mbgh/pGhLxioGeQ6497OZg==
X-Received: by 2002:a05:690c:6108:b0:781:8b44:1f57 with SMTP id 00721157ae682-785c4b50c51mr51607487b3.17.1761232456289;
        Thu, 23 Oct 2025 08:14:16 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e533:8431:ab8d:e62d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd5a5a35sm6364657b3.3.2025.10.23.08.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:14:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] bisect: fix handling of `help` and invalid subcommands
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <DE6BAECC-9A60-490C-AEB4-0958177A1588@outlook.com>
Cc: Ruoyu Zhong via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Date: Thu, 23 Oct 2025 11:14:05 -0400
Message-Id: <FA7FE583-1EDB-40D4-A839-3AC78A9666DF@gmail.com>
References: <DE6BAECC-9A60-490C-AEB4-0958177A1588@outlook.com>
To: Ruoyu Zhong <zhongruoyu@outlook.com>
X-Mailer: iPhone Mail (21F90)


> Le 22 oct. 2025 =C3=A0 16:15, Ruoyu Zhong <zhongruoyu@outlook.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFHi Ben,
>=20
>=20
> Thanks for the review!
>=20
>> On Oct 23, 2025, at 1:52=E2=80=AFAM, Ben Knoble <ben.knoble@gmail.com> wr=
ote:
>> Good catch!
>> FWIW, in this project we describe the buggy behavior in the present tense=
 (=C2=AB is broken =C2=BB, =C2=AB Running git bisect shows =C2=BB, etc.)
>=20
> Thanks! Will keep this in mind.
>=20
>>> diff --git a/builtin/bisect.c b/builtin/bisect.c
>>> index 8b8d870cd1..993caf545d 100644
>>> --- a/builtin/bisect.c
>>> +++ b/builtin/bisect.c
>>> @@ -1453,9 +1453,13 @@ int cmd_bisect(int argc,
>>>     if (!argc)
>>>         usage_msg_opt(_("need a command"), git_bisect_usage, options);
>>> +        if (!strcmp(argv[0], "help"))
>>> +            usage_with_options(git_bisect_usage, options);
>>> +
>> =46rom an extremely quick look at the code, this might be better handled w=
ith a new OPT_SUBCOMMAND, though that might mean making the options array st=
atically scoped to this file rather than the function.
>=20
> I intended to keep it simple so I did not make it an OPT_SUBCOMMAND at the=
 first
> place. Given that Junio is okay with it, I'm going to keep it as is for no=
w.
> Still happy to turn this into an OPT_SUBCOMMAND if you would like.
>=20
>> It would also be nice to update the usage to match the manual while we=E2=
=80=99re here, which presumably in turn affects the test between command usa=
ge and manuals.
>=20
>=20
> Thanks for pointing that out! Yes, I think so too. Will do in a separate p=
atch,
> if you agree, in order not to digress too much.

Separate is fine, although it might have been nice as part of a series with t=
his one. Since Junio has already marked it to queue, no reason to revisit al=
l the above for this patch. Thanks !
