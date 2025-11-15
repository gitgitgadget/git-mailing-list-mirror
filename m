Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374353594F
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763178110; cv=none; b=HwSJRdO5RYkD+ArRhfktzjXVrtZrgFDmWWEr1M6p6EdbSgGYuxLCk4qvCM5VH3liR3XVXix+TrLLFcFu4Rh4NLpZHBZSlm6C97bSORFLnIGA4aQqPLI5j0pJzKDU+sJ7rmHvJJWv5Km2BSp1HxXznGNyUE2jsuM8cjhxFlkCIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763178110; c=relaxed/simple;
	bh=uvBX3vBv3gWINpMc62wJ0deRGFpxnBjlqrJe8lgIItE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=acabUpNhxVZYZkQ4SoXBoWFopjrs984HeZSRoRiNMxOqjE/gr8KonrGObbMdzQ4qBdCtwyCgDLIfQZgPSFd18sNmSKcgVPkIiKGSZXsNJtB9lHRuI92IJQrWjXCYHo1v4DQqErH8+GA5CIFfjsWRAL5bDIz39e5TkMiF1/YYIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP9dXggk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP9dXggk"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed66b5abf7so40824151cf.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 19:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763178107; x=1763782907; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8ncK1CNve2/SrIv9FioyCzvtwqEkJiwSnWE7RPTcrM=;
        b=lP9dXggka/UmJ+o3yeoxXPqxpcXnJdwG7AkLfuI/U4aN/R59KPo5IO5BS/nPoa9LvY
         qv7iFv44l6MYQYByylHT279XzlnA478ZsaxL2n6QYNlvAmyHv9qFTNRC9YNpSKQxwsGY
         IceA+3Ts8llKbMIILDRlOmVdSKCuycWg7oczCKR1I6py10elmsZzE1911EiXEDz0QfVX
         uuAD8EYCy5lxCp01wY+nzLSOzth5GL0214T2ChLIAu36wSCfb9+k8vsFa27i9ZfsCf+n
         TCAp7nV9ypOektFxJvKIfh14VCxkSRd8C0ZQbIdnEhOzTCHPYudnnia0tYkgR/Ex/lSz
         wDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763178107; x=1763782907;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8ncK1CNve2/SrIv9FioyCzvtwqEkJiwSnWE7RPTcrM=;
        b=WBjRg0lVQAFFao+xxEclZcXJ7+iQf2bxWIw6iah7pPkmi5PTg/+yygDcrYd+/AmxvX
         rjxRRiFoBUGIxqkGAbxVCRsyPh8wkQ2CRHtSzjl33LBPffzigHwsUNzRom/iL6BPP6ik
         Effgk2BgoRzJlZUJxz0CbUflSfa7GGQb5tTFI9fhQDm+hK2nLmICqSNPEvsOaAp2Cl7d
         Db1r47fnKI81TP5Ur0IxgISXaEfagu4A39CWpmad2YCRPIzfAD3MFptB5rlc2qod6MB5
         0WAPfbKOFNlIs1Nywlr0LDoyO6GVXZ7DoMxU+uQrYok5ENJBF2N7QkAp+tOTMvbRsaaC
         UZTA==
X-Forwarded-Encrypted: i=1; AJvYcCVcIZjY4VUd/m07DAzHRdn1oaFOLlz16ErbMKTCof9yf1QJSCWKwgItRRqEYPnokNfmcdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPVxryPc0vtKNu+k4L8sLeINDI9o4CY38Lh1CHzrLmeifjx1J
	SLk1V+VDPFJLZyRumRtw+1tI5Arkp9mTmxU1mImliAxIFVlaS82xQ53Q
X-Gm-Gg: ASbGncsNvSrDNWmFWHPJuKtR2lMsSmHPT+7OD+QYdiSkcMDsRKFbzES0CvcLoW9kF1m
	kRo/Da19Y4vh4xXJ1DZVRD1PGHW/qOZt88iqSh/tctu60nGi4jFCWIXvFTQ9/9GAIzrvLacmkWF
	HhP3KeM5B1nZeUfapcZ8XrH8mXxag7qsG/BCdTMEzKAEkEiM5ttW8kTqh1opJAp+68WVjTNU+St
	h0x6lFzKMNASkLe5rAzwthBhTbRmh9ST3UhsrY99fR/aIvJE40Vawsbg9gXEghRUJmGkfvaU9jk
	3wTyg8ecb6I9LPvnfsp3YgdguwY4hbklB46lTcXaKltp5Ij2phGqDCDWu5Jqge3XqKCSlVjnrXu
	pa2FPRhS+DDwrUgDJPmf5K/+pxcxGQPEuAe9p6VmJSR126zE6rgU9467c7PtUa3pdd+nX1n1PX/
	Qq9d7N51BFiqmzt/bun2w13aTsmg0Y
X-Google-Smtp-Source: AGHT+IEVII4NpS6BmDg13Tbb2GbNIvobYBDEnTrrg16tzVVx/t5GuRKDp3Ek/RauXmGhV04WxxYF+Q==
X-Received: by 2002:a05:622a:1818:b0:4b7:ad20:9393 with SMTP id d75a77b69052e-4edf206c3d3mr82080341cf.4.1763178107362;
        Fri, 14 Nov 2025 19:41:47 -0800 (PST)
Received: from smtpclient.apple ([2603:6081:3b00:54da:7c25:b965:6793:5546])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b3020sm42214191cf.6.2025.11.14.19.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 19:41:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C and Rust
Date: Fri, 14 Nov 2025 22:41:36 -0500
Message-Id: <5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com>
References: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>,
 Chris Torek <chris.torek@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
In-Reply-To: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: iPhone Mail (21F90)


> Le 14 nov. 2025 =C3=A0 22:09, Ramsay Jones <ramsay@ramsayjones.plus.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BF
>=20
>> On 14/11/2025 10:36 pm, Ezekiel Newren via GitGitGadget wrote:
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>=20
>> Document other nuances when crossing the FFI boundary. Other language
>> mappings may be added in the future.
>>=20
>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>> ---
>> Documentation/Makefile                        |   1 +
>> Documentation/technical/meson.build           |   1 +
>> .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
>> 3 files changed, 226 insertions(+)
>> create mode 100644 Documentation/technical/unambiguous-types.adoc
>>=20
> [snip]
>=20
>> +=3D=3D Character types
>> +
>> +This is where C and Rust don't have a clean one-to-one mapping.
>> +
>> +A C `char` and a Rust `u8` share the same bit width, so any C struct con=
taining
>> +a `char` will have the same size as the corresponding Rust struct using `=
u8`.
>> +In that sense, such structs are safe to pass over the FFI boundary, beca=
use
>> +their fields will be laid out identically. However, beyond bit width, C `=
char`
>> +has additional semantics and platform-dependent behavior that can cause
>> +problems, as discussed below.
>> +
>> +C comparison problem: While the sign of `char` is implementation defined=
, it's
>> +also signless (neither signed nor unsigned). When building with
>=20
> Hmm, this sets my teeth on edge. The C char type is not 'signless' (whatev=
er that is
> supposed to mean), it's 'sign-ness' is implementation-defined behaviour. T=
his means
> that it is 'unspecified behavior where each implementation documents how t=
he choice
> is made'. In particular, it has to document:
>=20
>  "Which of signed char or unsigned char has the same range, representation=
, and
>   behavior as "plain" char (6.2.5, 6.3.1.1)."
>=20
> (it is still a distinct type, however). Note that some compilers even allo=
w you to
> specify which you want for a given compilation! (see gcc options -f[un]sig=
ned-char
> and their inverse 'no' options!)
>=20
>=20
> ATB,
> Ramsay Jones

This was discussed briefly in replies to v2=E2=80=99s 2/10, where Ezekiel sa=
id that DEVELOPER=3D1 warned about sign issues whether char was compared to i=
nt or unsigned. [=46rom mobile I cannot reliably paste the message ID or lin=
k and preserve a plain-text email, apologies for the oblique reference.]=
