Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0D34BA28
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758412123; cv=none; b=oFZ9EnAC2WcZUsYLTCrjmsc7+g4m2sy0X3QuIZfu7X0gaACbqhKDv52DihsqoeoFw5f5cDnFUKNdysG1y+ezk9vTX57NXLZIwRE8609StpkhYARUNMQlIwq7+VoU3vScpsB7J5M22FqBBlMD3/z9o3rhlJQMmH/xvMo2HIWUpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758412123; c=relaxed/simple;
	bh=DfK1LjaXydsiT1daYwada3YffGMk7HJaihT5oyYW21o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWhsX/PkjiK/5zECmYC6V6GVKsn2Z1lvJWtGe23gLzcC54/N8c2GKNN6DdDd6oiAfhh20Xox3k4Ifh/tuSOBErt9UJWBSnjm5P0+M/Y7YUZNIniOY7sy3PUwA6oanWLkUr1zoCfry28wEDYxpc8U+Dxwm1gw2exuG5JltaSZdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtXfyXTp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtXfyXTp"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3613574aecdso23372311fa.3
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758412120; x=1759016920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfK1LjaXydsiT1daYwada3YffGMk7HJaihT5oyYW21o=;
        b=XtXfyXTpCgayruX/Osc93dGKZvut2VeyURFW5UbnOMStNvicwfPTRUXqxtCrmVD6tl
         CohQMVo2OfPG4nGJMglFc6KbDbxeloOt9GiqadwNoSpBjp1IVpAcPmKAlwz2ocalyF2/
         U/9l4igYRtkxpUMVIQCjH07ujRB01kEICM5uamyrycVFEjr4d+TuF5qK4/q1KgbGhAtx
         UVCIjHRjDhM5at3iztHJAOVdf6oQYpuCT6skb2mOgqd+eLvfCM1teFDungstNkCvY6hn
         aePy/Iq+Y07qIHOuX6+nFiSYXycYJUs5E7hWs16v8uiB+ouhGQCdqVNqL3AfNff3L4ek
         EW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758412120; x=1759016920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfK1LjaXydsiT1daYwada3YffGMk7HJaihT5oyYW21o=;
        b=dC6Md3FEqecY1grghHxoSPJP4ALyH80P08KDlMuGiH7aYCo62aDFlAPvjjstQUeFNC
         dLNRNEdKRkv/sQU6nO21ISkCASSq+ijrEcxgblWwWZJ6O5KfSSZLBN46OKPe9vHD8JV4
         3dAjLUgvgx+rNVlhZekKDUpbZH050EuQ+m5qZsohuJUT3QSDiYjlRB4Hz05M6TFfMhvr
         +oiR9JcWhx37k2kRauPAegwrxwqoD6jPBECsBDiL6yiXxnHZhR4XCaRKFCB1vbrWceul
         ru6ldm978tqblsPNWACIMX524h2wlVX/ecGT87gXJSG9cz3cF1Pwa5MZt4Bf5dWep2+3
         nhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJGAsttmeGihfiZC8hOZgkAbkDo4bOCCJb4SHZkJ9metDgL+/t/q9YErpVdCYzY65DzHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64EzNGd+CrRh0W7MBzDLWP48kQGtz3zP4BEZAm0LTHF2FpXti
	JpD4Jz4xJNv73KQsXR2KyEIB8owOwezXRgsdXDDkscoRaCec0uK4GXzvo/xe+E2VR0jJccIRVK4
	t41RHiLomUNfIOe2Wlnl2bkQ1BgK0YSA=
X-Gm-Gg: ASbGnctp5mJGhXXfs4XKdIW0F5WP+DRAmhZOiJWhkHGh+u+Ui2ScxmbrG9GTU3Ifvc7
	OcbfvSgKa3stUy9FxjDNXVFxsIXZtfZtI5QXl3BkXShKNSZSr8suHj4hmEC5fB75rSk+H37PUlk
	yeZiCwXfvpdTG/nRNOYL5m0bSp2xYEth5/lQ4oHrPv+I7Ck2KJAzdaA59hnFC+UXq+eCKg3BvAa
	xjIaATY
X-Google-Smtp-Source: AGHT+IFBK/3V3PN/SgJNaJ0QS+E/6Zyuu7NvsX/Pirtqg213LXIGhNBqlGbfi8YvH9n75Rnny/OcE3BlHGsd9LvfTxU=
X-Received: by 2002:a2e:7010:0:b0:338:2d97:4d3e with SMTP id
 38308e7fff4ca-3641968ae40mr26533731fa.25.1758412119961; Sat, 20 Sep 2025
 16:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
 <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
 <002001dc2a84$cda40380$68ec0a80$@nexbridge.com>
In-Reply-To: <002001dc2a84$cda40380$68ec0a80$@nexbridge.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 20 Sep 2025 17:48:28 -0600
X-Gm-Features: AS18NWANJYiPdU-tcHUY3mIHKWgDzPscup49cRq3ftyh3ILqTieD8H3OuVN4Q58
Message-ID: <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
To: rsbecker@nexbridge.com
Cc: CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com, 
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im, 
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org, 
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org, 
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, newren@gmail.com, 
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im, 
	sam@gentoo.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 5:18=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> All I have is a C++17 compiler. gcc -std=3Dc17 might work for compatibili=
ty on Linux but none
> of the gcc extensions work.

What I meant was: Is there a compiler that can be compiled to both
NonStop and Linux. What is the name of the C++17 compiler that you use
on NonStop? Is there a Linux or Windows cross compiler that can target
NonStop?
