Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9711922ED
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281602; cv=none; b=P/incEoXs/A5iHZiHu3tnFlrszA/AsPKH3LZIiiamwzKl50i29i0NT73ZlFBn0/8lLSW5w3Ax97HmMfmAOW1zfeGqGDUyGJAaj5z3Im+tlSCZpm23QxK4zo6eT/xk7kkrpjHruL2PrYH0O40wwLDFCE++koGLwtAqGHNDiwFh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281602; c=relaxed/simple;
	bh=GRYMEhYYiNefSsPbxjCI2GQJ6Xci5p7Tw0GkghggFYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1eOVmgi69bUmv9BwMbm0feSegeNbi0FK/Ac8SoTqugSWxJm0BZZxvuUp8OYXOV5o86nvk2KyWEWTHA8ZDjWs18s04NUAVCCMh4dgVW36jYLAMpSlXTx9aF0Y5Gx00dSbobf6iXIRL92r+BnpG/hSuCbgcKhmHV5QwAG6+2vz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV1q7wwl; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV1q7wwl"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85afc05fc40so27172039f.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741281600; x=1741886400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUSICgN7QHxbYpbcn7mtCi2vx/cJp7g3bPsR/Ty2ztc=;
        b=FV1q7wwlUFQtC2nZLHiwiVsj/BfxYDxzmSOTuLOcqBwPAbDcVIaLZrWULnHuH9mAil
         grdYwHMv1LkcexjIx+fujOYe1Q7UMpu4qatemiyLymrHwZqHW5xVBhl+CGrx/LA1DUfO
         N8sd/uDWe0e65KTvgZp+pz+8zCH1259qcMFnmLGM/xOTwulpFG38P266JI2SSxqN7Dt6
         2hQvcZC3xTrLDHyIQMvpJKcBAKE5Y1iLuEWHzRibFmlqjcwyIQJZhwO4Gz8+h1dC681T
         AmL3iDHWHa247vcpnP/PHEmraIMpT+5ZmS+jaEDhMb2OOiT3D2yBx0YqY3oSrO2PUQQl
         j8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281600; x=1741886400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUSICgN7QHxbYpbcn7mtCi2vx/cJp7g3bPsR/Ty2ztc=;
        b=TGD0qqr84Iy9USTTe/wGLiSCCgiYiq2CwVVaVHZHaheooVkgjI9sIBHX60by3+nl2Z
         9Uq7ottaAw6Owj7DqT8EkcQ4InOCmuJ6tE8JMjkqj3VfkAGT+mugxwi96cDEvDWFNBXZ
         Wa2NBG+P1MajM2qUViqOBN3fLU8Dg2Au+9bNiBjveYE+JxVP1YeEK6CCIsbCjJQ/4Jj6
         rIfkQJn96yXB9oCXD3RSK/UhwIw4+B+WhffaIPcUi0+KwRudg/cJm0AvMNMdMu5JuRqy
         CG6ejvtk8wbqoBCYc9efvtrzO+mKuCo7TxbmhdvI96TANSd2w7Ke1AHLU25S1oANgiGW
         lKVA==
X-Gm-Message-State: AOJu0Yyckbdgb2GmoXhaTDJ77Ot+KYwSTuuxK7GQPRfbWJAmvXQIopIp
	IxWr03ueA0qxmbw80vpyu7WrOVwoRMn2/u4l+dhnsapcHRM6TN37F079SUoe685VlHwJ+lee6W/
	V+8R6Nz+Bx/LUSrdpcSMRhSmSwmfl84kv
X-Gm-Gg: ASbGncsvblDduoCV5qxZcVSR8JX4+ABjRANq2ERj9/pshuZxSWO5XMIWbEySylstXT5
	Tyad/3soKA7TdDF7PiUTIb2jIRSDYQfihj2mYGLd+m6ur7ndomtpdSff6AfaAaTrxyd5rpdd5kx
	AMkHhkzbrh54JaOKe+RrMKTrEfcUj6DdFqeg66ZealQtMSDmb3cP8NZpdg5g==
X-Google-Smtp-Source: AGHT+IFESTYR7FKjMR1Zzsl/AdKRx6uRd5JjZjEdJ5y6wBOku1+FqG2tsgwjloMHgGu/bq8t9VK7W+b0Y+ljSFiJCZU=
X-Received: by 2002:a05:6602:4a0b:b0:85a:eecd:37b with SMTP id
 ca18e2360f4ac-85b1d066fb6mr37894139f.11.1741281600202; Thu, 06 Mar 2025
 09:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921024533.15249-1-dgoncharov@users.sf.net>
 <20240921024533.15249-2-dgoncharov@users.sf.net> <CABPp-BFX-HewJWXMRNVMasGOUAuhSn7Pwx9Ls4Virz7fnOqxEA@mail.gmail.com>
In-Reply-To: <CABPp-BFX-HewJWXMRNVMasGOUAuhSn7Pwx9Ls4Virz7fnOqxEA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Mar 2025 09:19:47 -0800
X-Gm-Features: AQ5f1JqLTq6vMw9Wx8u7IVT3tZQk5QuMjtzPLajvpkNYu50gOiCWBk59SwLLp1A
Message-ID: <CABPp-BF-wzhydmEd4_LWRnbdNQJi1UMEJv_quBQX0+ikbS9A8A@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: fix a crash in process_renames
To: dgoncharov@users.sf.net
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:27=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
[...]
> Anyway, I've got a couple patches, the first with your testcase moved
> and adjusted slightly to fit into the existing t6423 with you as the
> author, and a second patch with an alternate fix.  I'll submit them
> shortly.

For those scrolling the archives later, the fixes are at:
https://lore.kernel.org/git/pull.1873.git.1741275027.gitgitgadget@gmail.com=
/T/#t
