Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4482BE62B
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759372450; cv=none; b=qoLHYVGAFsiujT3CrbA9yHu/Hlo1ZUclpd/WlcfLUD/gRESpQOfVXw/stkyrPK+DvWq9N22alet6+2j6vYXCcnqirdM1SgS9YVr21Bsh9sWIiTVNgfm115XXmyarKVpdBf2SdWKTSPkP5tlVZB0Xk9bt8/AGle/xcwYFeZTGurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759372450; c=relaxed/simple;
	bh=R9mAMCQmmYe7KiimQ8m54mmDMAAOn5UyVuXWPQyDRkQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FsJfWxzRpTQCp9uArm2hbYXwgP0kf/2/AHCU1Fi8NeIc9gNpJdkzsWeWJ1mxlzsHMWcoY0rMQEw+l48bxzjdF2995Zg4R0D574j7GTN1ZM50bc0645WgOEyKmBnqruIh2DM1asDyCal83Lnu9+sIM+PHrdlbvc6NQkKE8V3ldxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMlobn1b; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMlobn1b"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcab69so6407037b3.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759372447; x=1759977247; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9mAMCQmmYe7KiimQ8m54mmDMAAOn5UyVuXWPQyDRkQ=;
        b=GMlobn1boOg10GWkcHbVPuxI2b0Rujk5u4NHB8b0Vq1lmUgX1INRzLyj8oTlSDF9ij
         Jpc3yZWfqfh67hrFLh2AqVZkbYsImqEgDMEPKPCfarLgPMyvSsQCl6DXtBKuivGmL3vE
         aRJ9XJe9zqPvzQGiyHv+EkOEZhMIYB8pxp7PKcsYLk1SoQ0kNZ5eh6v8xsJNn5IVtP0a
         9Kr4NSBUeI3Gg5n8mPJ03XKkmDlJNubYZ253LG37+XqvogIyKIKDEh6qxMAz4YGQc0jG
         SLx9mCSbDt4AS3SH1dkdTRzDj/UA9tWEQuSkIObu7BYpLTXXpmi8/Qj2vCpsmY2re7wj
         JUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759372447; x=1759977247;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9mAMCQmmYe7KiimQ8m54mmDMAAOn5UyVuXWPQyDRkQ=;
        b=jw5J6D9fUQ5BLmrQWwxvs6cwjps+js9U8LqY3zRD/ZSCk9ISO4TYtdapBFC8VGzfnZ
         0xssmRQDgFkNwY6sotJs3FDYZfWhnl66MJXeiqNmGi2xrqJGNcucBoNsWwZToDCerfEm
         Tr7viVBZ7ao+MY+tsZ1PvJ+aXt4IH1TYtFm+4PApiWo0R2hofuLWq1LFL9nW3jbBNteB
         PvspdaJsy+DXV1pBdakEWiZxKh3MhftO1Qx6CEZ2JdegnigO0Xdhnf5vgoNjji5Xq9d0
         8IcRRN3ckrrvwWe2S7B88UE6KUUTcvSqORxiPvrRv7oxvV1n0+WuHDHGO/JWo/hHIeGz
         H+lA==
X-Forwarded-Encrypted: i=1; AJvYcCXkB0IHNUlBsKefOXBI9gIR1tOA1yms1if8oJuLEygnuoSu8A7C+3SWNAb8XxfR27LgJrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWGEEPjwPysdwSr3TD3PMbQXjcwOmLyyY5dXZZfRfCviqPVOZ
	NnjVMk8c+m7NRLDuu3tsZvnAF6DQDlGh8FBo7Vobn40yDFx8HNllHN3ZkgRUbGfH
X-Gm-Gg: ASbGncuX2ufEuwS1ZUsIIDsp8v6IPPt4fwbNWVMcS/B742V8lyNF3KOOnmTnQaT5Ptc
	3nxpiJO5hpEKirVSFuKvG4lLFCkFesYWMSsCGYFA4WceYedjC5DghFujRW+Ag7TIWJNs/KIQPrv
	YcR+HzWQj6wuhbjPmiCp/zkrg9EYx6Ij8FoWQizNnHccEInxae0iLvSnx33utSwEXFw2KWEVkD9
	VUKWPRDh/iYCd+RPMJR17na5Xk6njeNto4q39qzEm/hI7L1I5tdaa+EqJnb7qU3PonLIRoJZKIc
	eMLx6Tv0xoaIil16PuhKafxj5zUrIdBZdNi5r9ooBxe5WEbhuuehdD69x3FIyy1V1hjx/VisIuF
	GLxRFZkUt96q6xTtda+CggjPSt757WtuOPJPSfR0a8azB3uA+Is4KJy1r9rldrjvH2sZhQ2jDii
	A=
X-Google-Smtp-Source: AGHT+IEOS1lYZBYjze0xSwFdc5FYuKOdPZD+I2K7LswHtTGKmNEi9jkhQNPB6PFZpFDf8EK19rY3nA==
X-Received: by 2002:a05:690c:d0d:b0:735:4c38:34 with SMTP id 00721157ae682-77f6f398cdfmr87308337b3.27.1759372447459;
        Wed, 01 Oct 2025 19:34:07 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:45e0:b917:39c0:e808])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b845c3a35sm378837d50.14.2025.10.01.19.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 19:34:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What is the reason behind not hiding git worktrees from git?
Date: Wed, 1 Oct 2025 22:33:56 -0400
Message-Id: <9052874F-AC8B-4321-9762-78FCCE498D8E@gmail.com>
References: <xmqq3482312r.fsf@gitster.g>
Cc: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Jason Cho <jason11choca@proton.me>,
 "Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
In-Reply-To: <xmqq3482312r.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 1 oct. 2025 =C3=A0 14:54, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFBen Knoble <ben.knoble@gmail.com> writes:
>=20
>>> The impact is that the list of worktrees would have to be read to get
>>> status. As status is not particularly cheap operation in any case I
>>> would expect the problem to be minor.
>>=20
>> I believe status information is used for the shell prompt info, so
>> performance hits there have a cost.
>=20
> Sure, but an embedded git-controlled working tree _should_ be
> flagged as an untracked entity, _unless_ it is ignore'd, no?

Sorry, I=E2=80=99m not disagreeing with that here? Merely pointing out if th=
at proposed changes affect git-status performance for the worse I will be di=
sappointed :)

> That is how you would add a new submodule to your project after all.
> So, if you want to ignore them, just add them to .git/info/exclude
> or something, perhaps?
>=20
> Why do people even want to have such a layout, unless they want to
> make it a submodule (or deliberate subdirectory that is unrelated)?

[snip: a better way]

Yep, I agree that=E2=80=99s easier, but I shouldn=E2=80=99t judge other=E2=80=
=99s workflows (I do it all the time =F0=9F=98=85).=
