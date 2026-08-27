Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABF486B8C
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847538; cv=none; b=WMKcohRziTACm7VnG3Ne/aglUZS8AU65d4CDQawMVL6nkoH1GMxCt5uRob9WDYPWMi2I9I9vYJKCHtSQpk3NI2i1BU89O49cPVhRDbq3QbxFICHaiujQFNp/NEsGiMdyUbZdujskasTxuyUDQzYb4j6HOyeVJPDR9Oj78SpXNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847538; c=relaxed/simple;
	bh=7hOkXTk7r8fXflo+dnEIRqGE2l8P16rPcBI68PZxpGs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=l9zEnCxVwY8Qe8tM0Iy05u1wUxkoI8e1+TH4HYe1CIQ8jP5WVBUK0WIv0u3RMdM4JqtdYiAyth3SnYWVL7Mu7veHQ16qVJGO9n0ANvVdNf9GlTTwTQWdWWXaTVskakigLLo/a3GfiIUO00w1psYQGS2FWRZNsmwxt4G99hreAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN5OqDZj; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN5OqDZj"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dbcb505578so28021957b3.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787847535; x=1788452335; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDW/ph+lwl68/JGsQhMJwXwthTDEZyoCXbcz+2NElpg=;
        b=QN5OqDZjQJdFTfGNXnFqdMRL03eq7E+0NATSq0ftEtR7sujm/Voczp7OC3GDmKL0RH
         8GQtKPbiHaYHs1MJoeD8wV+DsrjF34clG35/SrdCZckZJN7xrbPaaIWx3WW7Ps7vTt61
         sN9Q2DsTeGm0kRwFYSDSsBPja6E8tuhtJP9tDP+bXd6EGZifiopizjCXsVuyAayI6x3W
         qU5lvXabmmmzsk1iONcW0JB4+Bb3VcL1qTg98xSDaxWrlXhhJgprNKMHg7aRtDXckfei
         jwb7s5Avay4xEN3YYdg7hiLJ1rh8WTZJRMHcJ7UplOl8aogY8eD5l8KFOIlbzSPmY5Ja
         lx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847535; x=1788452335;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDW/ph+lwl68/JGsQhMJwXwthTDEZyoCXbcz+2NElpg=;
        b=EjWlJWo845gzKmEIOz4Ew6m3HYHOISlTSX434K27wcA1hB0BlvtVLpQVqKfoGWYl8M
         Q8yuncVJhC9SRaaRJXY+TDVSjyyqt6eBgijg022IBzIeQP8hgjf/gwBkq1dWxrUSCiaC
         rfQC94ysqf84k/Dt35fHCzMEMDvTDxFsUTb69X9+E5LIamSzhHTUZ0TwuQe0dJAMahcs
         wb1ItlvPYwVDZX0amkcjWICj0GSL7bkFbwFKPYwJ2wQfhOVGauN/cfh2AqWZYcIORfXR
         gCGkQNCaCB9FbKqdtJEhiFre6NnNxO2jLJhry0lxOYAjRSiJPA1GlzYmag9iPgl388Sd
         yYsA==
X-Gm-Message-State: AFuF++l32u2dwKylgib6teBkImLfuxjQdE+iA8RIN7zlqiOV5MTjsqzH
	ew2esAgrlhONrhuSZh1wIEuHlerYWtmMwWv2gR8A816sI2Nn1uujpwJryHqfmR3v
X-Gm-Gg: AR+sD11VR+eepJFhpYXtkjfzyvRu+PbIDZ3BigNxsY7ba8TelrMPGN9WyrE6/SDDOcJ
	wlmsVGUQux7x5OanIYshSp06+CZ9qtioM5JFePUwkYnzrpY+N1p4JfzvuuF3eXm9frfuArESHw3
	1zLWfc4vhrVu2ax7Wzkcnfysvrd2DLGzER4HcPjcRScFbhz7MpmCNThhWDziP9MtLzC4o2m7kKo
	B3KD/SEvH70T5V3JoVn3aFis6idUEGKedFLxn91l3QBYIGD7dXbEcOUAfWkBy2X0lX8oTgk4HHV
	ObAV9ki24oPU1CByOPrI4J1Fb6KAgLsF8uEVMQbeNm7KYniqrZowrMi66rCQGcFGFc2rr57VRc+
	YjCXFPdNLFcs87lPXPHUPMsO3OTgdCJHsMPRiRqFKU89v/UUUijU8EDyjEEXFP9nHnFOS6taORS
	YR6gpedka2BJMKU0jEuF2OYSUi+BDyP7zzw4vl2I8Laqvizgbi9Rh+zGBjVCG/zAvsrVxTOamOh
	D1uG6qtecqC/DiRmSW3KNAWKpBK6CroHT2t5VGXfNJzalIybrvBCfVh2Nu+X/n1sg4SGr4ReTTo
	XErGoSYXwvloAy0bvl07qkg77f60Kq3dSEfqpw==
X-Received: by 2002:a05:690c:6607:b0:85b:946f:129e with SMTP id 00721157ae682-85d6fab03bamr1517267b3.33.1787847534816;
        Thu, 27 Aug 2026 09:18:54 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:7413:45f1:6c28:eded])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b5bc34ed4sm12766327b3.9.2026.08.27.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:18:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Translation issue in git checkout explanation (french)
Date: Thu, 27 Aug 2026 12:18:43 -0400
Message-Id: <E65E2F73-4497-493F-8D3D-4DF2E6B8509F@gmail.com>
References: <d928fd6d-bc80-45f6-b8ff-d21d9a55e18f@dgfip.finances.gouv.fr>
Cc: git@vger.kernel.org,
 =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 flashcode@flashtux.org
In-Reply-To: <d928fd6d-bc80-45f6-b8ff-d21d9a55e18f@dgfip.finances.gouv.fr>
To: Eric Gautier <eric.gautier@dgfip.finances.gouv.fr>
X-Mailer: iPhone Mail (23D8133)

Bonjour,

> Le 27 ao=C3=BBt 2026 =C3=A0 09:37, Eric Gautier <eric.gautier@dgfip.financ=
es.gouv.fr> a =C3=A9crit :
>=20
> =EF=BB=BF
> Bonjour,
>=20
> Je suis tomb=C3=A9, sur cette page de votre site : https://git-scm.com/doc=
s/git-checkout/fr.html (que je vois en fran=C3=A7ais, sans demande particuli=
=C3=A8re) sur cette phrase dans l'article git checkout :
> L=E2=80=99extraction =C3=A9chouera s=E2=80=99il n=E2=80=99y a des changeme=
nts non valid=C3=A9s dans les fichiers o=C3=B9 < branche> et votre commit ac=
tuel ont un contenu diff=C3=A9rent.
>=20
> Cette phrase est mal construite =C3=A0 mon avis, ce type de construction e=
st tr=C3=A8s rare en fran=C3=A7ais, le" n' "dans s'il n'y a ne peut avoir qu=
'une fonction expl=C3=A9tive c'est =C3=A0 dire neutre au point de vue du sen=
s de la phrase : bref, il faut comprendre la phrase comme si ce " n' "=C3=A9=
tait absent, ce qui donne :
> L=E2=80=99extraction =C3=A9chouera s=E2=80=99il y a des changements non va=
lid=C3=A9s dans les fichiers o=C3=B9 < branche> et votre commit actuel ont u=
n contenu diff=C3=A9rent.
>=20
> Est-ce bien le sens voulu?

Avec l=E2=80=99aide de la page anglaise, on verra que c=E2=80=99est bien le s=
ens voulu:

The checkout will fail if there are uncommitted changes to any files where <=
branch> and your current commit have different content.=20

> Dans ce cas, je vous conseille hautement de retirer le n' qui, non seuleme=
nt  complique inutilement  la phrase et mais en outre produit un risque de c=
onfusion avec l'habituel ne...pas ou n'....pas qui est une n=C3=A9gation ; a=
insi, on pourrait comprendre =C3=A0 tort :
> L=E2=80=99extraction =C3=A9chouera s=E2=80=99il n'y a pas de changements n=
on valid=C3=A9s dans les fichiers o=C3=B9 < branche> et votre commit actuel o=
nt un contenu diff=C3=A9rent.
> Il me semble douteux que ce soit le sens voulu et il vaut mieux =C3=A9vite=
r d'embrouiller les d=C3=A9butants.
>=20
> A toutes fins utiles!
>=20
> Cordialement,
> --
> Eric GAUTIER
> Contr=C3=B4leur Programmeur
> DISI Nord - ESI Amiens
> Division D=C3=A9veloppement

Afin de la corriger, j=E2=80=99ai mis en Cc les traducteurs ;)=
