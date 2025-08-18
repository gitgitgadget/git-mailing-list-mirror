Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316B2737FB
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560504; cv=none; b=K8apYFAuNvkzmf2oJGd3GAgLhJsR33OUcpcBLzZBrnCSKtz8J3oYRoiPvHjMXRfy8K5TpUeE4WxMuseTM5efU3CMDlTL/SnZVEp18mK39fLol5CyX/37eZBBcDJwKrWVFTUVwm+FtHF4AnYsnlWEJsADNPmxl/kpBImJ42kT3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560504; c=relaxed/simple;
	bh=+y5yn/d3jAORBKvnv060/yb+9E0VeBvjcUCIVE4btn0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=S5C+b8WQ7bLbyHW3O4hIK51fHQZrHzusMVTl8sCegeRQ0K0bZBwgVrLkP2113KP3wZVtfzAvLNQJ9jAuTA2lLpaCrE1eaUO7moxrdDoGM9ubpKt8jIA9KaA0z4c/Ze+7k0r+3Da0+nHIG1rTPjoDdtogH0uziIYVg3Ob7RlmyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ren83MDp; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ren83MDp"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6083cc69so38799417b3.2
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755560501; x=1756165301; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTlag84nMlT/yu51eLhzFduBWdgEtJEeCVdqqBk0baI=;
        b=Ren83MDpFn7PAqDx3yTEYhXEPbzJKSXOHGgw5YmzQCoSb/3rgEGBcOUTuQEdJLnVHJ
         b7rdOJtVQxuX+kwd9at7Zr80xIj1QqjWgFXNbwEoJzeOp4Wc8UonCLcBd+TZk6f+y9up
         sugOukZP3RKyvQTjy/Vl0KiP8IX48c0R8mj4bgu7di61uzNo/6B4jmQUkyAAckIyqhtL
         UdpvIYoBE/q7lhqwGJXWO2M9EVSpx5NmIqIC9oPEvFsFxpxvdte6Rkn/qA9kdCYGkz/x
         oFRPhr+bwfA5NVkEUcZTBBHXiNynpKS40mYG8PmzITze7kWVyQAnZYl4CbIsyoUyoOsf
         W6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560501; x=1756165301;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTlag84nMlT/yu51eLhzFduBWdgEtJEeCVdqqBk0baI=;
        b=pQtSOgVsJAnQjWQpH0pOvpqlXgjIrRhAlpiKzWtpGSdLGYp1X1A67HLboRpElTAB1+
         mWMHIQJ2wXG5lv4BHGNQ4ovE8gzmciZhRFC4Y/WbzT6oiP/IIO4ASsBv/pYuc7UD4bWg
         TGbFaiMg5L5euu1YmvFUEblsCCqE5QVqk6jeAtvq986CDY49gsnvezVm2idoymc2Lgb4
         sD1zpDzLL837/Cr90iwDF7loBkAmeHriAPMYL9W5gwf+gCmO5iwSwJNJdseSCmAthDc3
         Q+KOifZZmK87i4uHMQ59FyGVNyfO4IcJQe13JvH/yuM+aTeESMVQjROd3H9g/DghIC91
         6b9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuHWRkBujR33bD3MOT3ApjHE6fEfQktCZBtIR7dmrc1inEwxbPYwfGVlY3uWuCMPbTJUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8acMfmBw/Eazx5PI0pY2EzdMK6Dt1/M1ipujMo69Kdi8yZApz
	X7JyrCnI2+Egpqrg0WurHGJ15Qdq+xArIoF02ImlrXOswVzi2ZsiYuHn0TCC2Q==
X-Gm-Gg: ASbGnctjXP5Smt/x4NoRzFeum4PMDnuSnAZKjiYTghpFsRdxEqjSpm2qbqU9247otLs
	ITetvJNWbscXLUdUmHPgCzkIE/ygD/D35DcxPP0wecbxb8wFQiHQ8AfOTBumyo8nOSpxE2Uq5ir
	wH4SHXvWDfs4/6Z4MzvDPuDc5gYWub4bqZ5QHUM4e7XgCgzXzNWmBf+UD2mj2K2mhsrEDsS1+e7
	QymbGcXzIfXPSbpPQF878Ajvm8WeaMWNsfujxxy1nat4xge/Rm3EBqiXhBpdxTGqWVNO99q88Qn
	IfmNc29fy9GlDNq22/HxGeuJhcWAUYf4PjM+sq3HOdBsWzPioxWSMKV4A4fmglCgm8qDPsWugoE
	BBg1q21PtG087F842CrwGcMlMXjipi3EhSJSqFQFvz8D74eJtkXaqcemLn7dNPQ==
X-Google-Smtp-Source: AGHT+IHdqozV1mQKBXaW9V+3jMftNzdXpp8Bln3IFUxTUj3k6B4hPjM18vn4LI/C43EHdAkOzeGr0g==
X-Received: by 2002:a05:690c:3587:b0:71c:bf3:afc1 with SMTP id 00721157ae682-71f9d57b5c9mr8109077b3.17.1755560501121;
        Mon, 18 Aug 2025 16:41:41 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f9bc:536f:8d5e:1c8c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e75e23006sm21723857b3.19.2025.08.18.16.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 16:41:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
Date: Mon, 18 Aug 2025 19:41:30 -0400
Message-Id: <18A45EC6-2D2C-45A2-8802-0E5060539398@gmail.com>
References: <89394e50-9077-4a7b-b30e-afd1be1a40e8@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "J. Dettweiler" <git.vger.kernel.org@dettweb.de>, git@vger.kernel.org
In-Reply-To: <89394e50-9077-4a7b-b30e-afd1be1a40e8@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (21F90)


> Le 18 ao=C3=BBt 2025 =C3=A0 11:14, Phillip Wood <phillip.wood123@gmail.com=
> a =C3=A9crit :
>=20
> =EF=BB=BFOn 17/08/2025 17:08, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> To use it create your stash with "git stash push --keep-index" and then
>>> use the script to pop the unstaged changes rather than using "git stash
>>> pop". If the script proves to be useful then perhaps we could add an
>>> "--unstaged" option to "git stash pop"
>> Hmph, would the behaviour useful enough that it should be always
>> enabled, without any new option?  I strongly suspect that those who
>> worked on adding "--keep-index" option did not expect the user to be
>> mucking with the working tree files while "testing the staged stuff
>> by updating the working tree files to match it and nothing else",
>> and as long as the end-user stays within that originally designed
>> use case, nothing changes for them, no?

I can=E2=80=99t particularly comment on the script, but I do think the examp=
le in the docs should either just work or be adjusted to work.

> Yes it probably would make sense if we knew that the stash had been create=
d with "--keep-index". At the moment I don't think there is anywhere to tell=
 from looking at the stash if that's the case but we could add a trailer to t=
he commit message when we create the stash to record that it was created wit=
h "--keep-index" and apply only the unstaged changes when we see that traile=
r.
>=20
> Thanks
>=20
> Phillip

This seems reasonable; I wonder if there would be any interaction with the s=
tash import/export features? But perhaps those omitted the index anyway, I c=
annot recall.=
