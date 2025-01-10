Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F3215055
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736541545; cv=none; b=QBIbBSbwbEUGzRjoaFVeAzIdXCEYyxyx+B7TRXQvFiS4gZ8Qn1yCXS0FM8SlZcu+QOvWacCvWs38dEwSg4kSfbsr0lq3vMHP6wcMtdejt0vE2p3Y587+ndIijZsodZTu2p+CnRZ9RDVUjoy3PDeTkkcw8gbPqFXxkgf5FYZuqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736541545; c=relaxed/simple;
	bh=gzUtdj9ETZhGjizV/NcPrB7e1l1hDCXbbyjopHfEBzk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Vga57wFsVYYR9R18GAiVI5cH8teB73zRjt8FcTw2UsqM1WsXNo/cyNi28FHTeC1XvYGJnS73f4B3lBBtLm0y+iCvFckmkNUzowL46JR5kEfIcWUYohmeETcK/haiyZoDUBJM/7TUeGaCdF4Bo7SEN4ujxR0iJWooBpor4QXP3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3sY5Ost; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3sY5Ost"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so22075876d6.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736541542; x=1737146342; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzUtdj9ETZhGjizV/NcPrB7e1l1hDCXbbyjopHfEBzk=;
        b=e3sY5OstqZsTiYq2XcnAGOE486885svVolm88xt1nNQctEMEuKWJrmUvXdUsNGf3uZ
         k4qiwJH4Gzyf7zjRTwCQlPUtXL1K8vL54osqCyuVSbeYX54lEmIzB0f6GrqFQNlRRIhL
         eegUSReNoH8SnJKOoZsACMntmu2VbE3Sm/cO2yYnj0D9B7780Ak4Yno4s1diaewl392D
         6B+ipbw/O0+G12rIveMl9WOpjQxyXPgHwrkKVZFP65KThm/M1Pt3anpc/yjQIzHnEL5j
         Lyb2YjHgHnmtbWOO8AHO2q8the+82N05M7JLmIX0wpDtrEATu8S2zwGq1TuL31Heg3O2
         qhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736541542; x=1737146342;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzUtdj9ETZhGjizV/NcPrB7e1l1hDCXbbyjopHfEBzk=;
        b=R1RNuuD2J9i8jUu+Ucq4nQ6hsSewzn2ka2TCusBiOovU7uVFov0Bc4JwuoyaFse5af
         lq5GjuzyehINYzBwPKPprJAIO+AM3eEe+t3g5UMPRe8P7BmIFQ+tPTdBn3NRn2liI5km
         THKilvlYpjDAzmObQ89ZJ76Bj7uG3HBfF5O9Ew9OMx1NbhzvCDNLlBlbmFeYw4j7YCmF
         yD04gKs9HeMiBUnEuKUu8WMGVXhS4hpVvZewjh6QFLT028g/hdoE52Qm0b7agCyt1Zr9
         Slno2yqjHcUXoN8Qt0ZnRVhccB4cZwD9plVeBFFoLShYb3SG//KCSUmyrF7yA+wW0lml
         j0dg==
X-Gm-Message-State: AOJu0YzADQzbqSoTp84j9ReHwwxTlvHQE29d9zjMcCb+Zqeb7NWY+tNy
	d9mGhuQ5qqNphfhCc6q263oYxMpcCF4EOXIBRsrkddCD6l/OicnkAty3xh+f2Ao=
X-Gm-Gg: ASbGncuhKttgynr4GCz1/d1B2POrTpc20g2kMI/FWWdq/wMYXrGnpiaCMUw33KS0bhH
	wP2stRZfjJIEtAmEgRsxxjJjsWaTZLpUgVoG4JJ7MZC/W957NMNty73gCTsK8FQV5WsYuNQShyT
	LHepcjTxXmb47yha7M89omD+bmGDzBvMFmV+t8msIuEm/65t9NpDO0W53zoqCy1d8UqBKb2sQlO
	8L7N7prGIAclaoxwnGe0DseAbv1t9204T7ZIH7ZhN+bNrpfs/4xthxQQ27aXzWHjx385ayRzTlD
	IcdME2g=
X-Google-Smtp-Source: AGHT+IHn2JZg3vI1qRNUFhjGPckw3n4LcL80zPnZtfnJA54PhbHUP8tT1swN/5CubnHT3S0fF0wfUA==
X-Received: by 2002:a05:6214:27e8:b0:6d8:99cf:d2e3 with SMTP id 6a1803df08f44-6df9b277077mr169088546d6.22.1736541542407;
        Fri, 10 Jan 2025 12:39:02 -0800 (PST)
Received: from smtpclient.apple ([2601:5c1:8380:760:c836:b3a2:b54f:dbd8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad886c1bsm12919556d6.45.2025.01.10.12.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 12:39:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Using Visual Studio Code to Debug/Trace Git?
Date: Fri, 10 Jan 2025 15:38:51 -0500
Message-Id: <A53D82B2-4F5F-4BCA-9C85-88B2A89139DC@gmail.com>
References: <vlrkbd$a0r$1@ciao.gmane.io>
Cc: git@vger.kernel.org
In-Reply-To: <vlrkbd$a0r$1@ciao.gmane.io>
To: Jon Forrest <nobozo@gmail.com>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 10 janv. 2025 =C3=A0 12:16, Jon Forrest <nobozo@gmail.com> a =C3=A9crit=
 :
>=20
> =EF=BB=BFI'm interested in using Visual Studio Code to help understand
> how git works. I'm thinking it would make it easy to see what
> actually happens when git commands are run.
>=20
> What I don't know is how to integrate git's build system into
> Visual Studio Code. Has anybody tried this? If not, what tools
> do you use to debug git?

AFAIK, it=E2=80=99s make (with some autoconf stuff) and C debuggers like gdb=
/lldb. But maybe someone has a better answer. I=E2=80=99d expect VS Code to s=
upport this pretty easily.

Best,
D. Ben Knoble=
