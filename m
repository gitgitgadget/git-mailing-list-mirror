Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A00135A51
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741624; cv=none; b=OuIq/dY8JJZLlkrwG35OQGGF0yl8xLBKm+Ha8zepxEZnjlVvb4gQGSZDi75lRPCrYjVlFVUK1WWtxis9m2o6c8E8/+OWXYvd0cMTfcKwvUmEHEeTGrwAB9teM6/oYWM9zSUe/255iCNKnFxrawLZYcVDg9G1wdttaaZ9Vnp7wmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741624; c=relaxed/simple;
	bh=xBvyjPkdB/EXZ7XsF/HCERJtuMdzYPfV7swgjETuYjU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=NjZcwN651qXyY9+UFea6gPJ99SPvj4Vpx6/475Y5RlP+O+JKvEnCrz5y7+HUpczk9fjWW6yUVF4MuSYgjErWQqU8PeU3IyB25v6bgNdC4rCdhpPQ5j3oKluzXM/eePsITHLAPmeurVRik9pItJu1lt6k1/Mwf1bfCePe8UfaFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw4Z53cM; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw4Z53cM"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a159bd0cd2so398681eaf.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709741622; x=1710346422; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBvyjPkdB/EXZ7XsF/HCERJtuMdzYPfV7swgjETuYjU=;
        b=Iw4Z53cMZHvPiEOdW3x6y8a+eALVrT/tilFNfT1aBwDJ/laLYWra8b0ylOXUR0CI6v
         vq/EXTxzm1K7J++iZ6guUkhyL4Mm18PE+0OEaEczldF+hkDBGAA4Q9S/5W8YpEW/9oBG
         F6BhbWEOudcEFXA5WvA3kMGno8cIj6+qrwg/alscLCGkUSfxeIRCHyHn751Yg13fGRTB
         X5lOvOVHQY1vvTlzhfdJThzSp2oIADMKhLKc4HlLF4JN/NcPBPE0QxCuTTIP3SBLXCmr
         fFMm6xruk0aTBEJIEdPNpRFaxaKHBB8pKcvcXvheQuJdLFwSjZ14XUwrPgtIKG+lvKvr
         604w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709741622; x=1710346422;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBvyjPkdB/EXZ7XsF/HCERJtuMdzYPfV7swgjETuYjU=;
        b=ipY3LEHfwtGCLvSvfEovNKJEd6GANdIhR2pWgrzzka0cMCcY4rCuidVIRniqZEfWpY
         WThJ4NuaZHzQpM7wdhNkfOkmG98f9eSWCb1CCPc8N44VAAN0Q4/14NWgzyiFzwyJivkG
         2NWgxikoz8RG+od1G15Im/kO7MOcneR6w7boad7Qui5EpaS5zTPieJJFY9IDmi1R96sx
         5s4UowEdHzJKO26tREwiWIK8ybUHCLolp363Pvgq5NAhLVIIh+OCU91j+mU2ZvFOQXkb
         vDPBi4rJuYcBwd+oeTl2KFGU74k8LtYSbrfMI0qc/7+khLGRwNxF37mvrKyBIj6xFtdc
         ZN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBjDhgGD56/cgtJ8/iv0274/n3IdbQe29PHxUGYENlEN2nYH3DCL4s4zwVyD7ypVSAFN+Di+LEZqXnnkOPFJzd+Z+s
X-Gm-Message-State: AOJu0YzqhlUTfQeTs6YvKUjXuBQDRN9NSHT69b03cqV2a9ampoHxUTdU
	Zt1Nes4B3R5R155mOPIVtJxItFrPK/RT/ajf/EBRGbIg9brGzO7QGQKQ8m8mdxx2Jhjm1l1pM3L
	WK5ztc03NNW80ChfA8Vrz3+vFuq2m7/iBrGo=
X-Google-Smtp-Source: AGHT+IHKB6/RwwxGS8I3DnP3znjpGulvsOpHzlx+bWM4Zyzt7HccccEqQZEXVWq7ly6WlLXsoZ1Axx2Dspa0+S/ejH0=
X-Received: by 2002:a05:6870:b018:b0:21a:2be7:65de with SMTP id
 y24-20020a056870b01800b0021a2be765demr2564586oae.21.1709741620481; Wed, 06
 Mar 2024 08:13:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Mar 2024 08:13:39 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im> <b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 6 Mar 2024 08:13:39 -0800
Message-ID: <CAOLa=ZRQ6sYLBqjWiMXGS7rcv8pJ7jSEneiJ8ZcHtALrrcwMeg@mail.gmail.com>
Subject: Re: [PATCH 1/7] refs/reftable: reload correct stack when creating
 reflog iter
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f264e30613003ddd"

--000000000000f264e30613003ddd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When creating a new reflog iterator, we first have to reload the stack
> that the iterator is being created. This is done so that any concurrent

Nit: s/created./created for.

--000000000000f264e30613003ddd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b5ace808b6b8618c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Yb2xqRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWFuQy85NWFoM04zS091V3AzNDRKQWw2eE9wVzR0awpNMzV2eTBtKzMx
LzU0bE5VSUhMRHpPWURBdEs4d2ZxTW5teHpjYWFUMFg3TkV5Z3Zrbnl6QjZ3WUZxRkJRbmZFCktG
a2x2SGY5MlNCQ2dJNllOQnp1ZUErZ1lyM0VpUXNtcnpKMHVCTUhGK3JpSlBiand1cU1SUURxUnZs
b0Vlc3AKalFxMmNNaFVwS2lOYUVNTFdsSHVtZ2o0bXYxaEhVdDA0cjVlSDdKL3R5SjRNeXM4QzVv
L2xQVnBiazZxZkpnKwozUlFxbXM3TWExYUlyRzJxQXdXSCttMjRPcEx2VEV4SDJoYmtwbWR0Wmlh
MXpyL0NJb051azNEc1Z1eTRlOERRCmJ1d0U2NndITkRSTmkwNHRKbFN2Y3R1eXZIc2FEWnN0MzRn
elVpLzRnYTNTd3RkdWVyZDU0QThyd295ckFncCsKMUkxdVNtbEhmZVExK3JVdG45enY5ZDZhRXdY
L0NNdC90am9oT3RWemdNUkJSNTRoVGRoWVgvOWRNbTcwRng2Mwp0V1J6QkJERkpGUnZmU3BlbXMv
U0VlL2ZJSXVRaEZHM3ZwZVphc1V4aW0vTkhSTnYxaUtDWUlvUkRpT1JZT2w2Ck1aeTVLcHpXa2pU
OEVnRm5ybStOOHRsWUhFcXhwUFBncTE2Z3lIbz0KPURPR2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f264e30613003ddd--
