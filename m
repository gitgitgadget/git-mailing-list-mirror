Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530C294A15
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015115; cv=none; b=lTAY7O71QIWSmPoXOkj50uWoD+xT1SexmI68+XQooXvzi1KI4nBgnSRqmm3ffmpoIQeslGwsDDzRWI85J15dLiAO2Iy5BmLwAfVqGRFpI1zrV49rqbNdzfZVS1i3qruK4GKRoS1ok9WeRsBelj+qVoF5sRxHwoWkQU5uFH1yvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015115; c=relaxed/simple;
	bh=FKLaJmc8uP7fszOQyxRFy8g2sTdW2PqtRndsxoVWun8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaz45yQ+vYdQGGYNp7oSl6ocJUEQPaiiuyPjEjpz/LD+rHO0sT0ws3ete+yKPm+lQZ38YzBAabTfN3VE54jL6O+EnCBSX231OJLbDzEeXmWHqdCnM4bEPTiSLJzTxLGPbI5QuhK4DhKdS5uuw8PoYGUNK1YnBxaM6f3MxQ3dHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrTjdlh3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrTjdlh3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso3631133a12.2
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751015112; x=1751619912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKLaJmc8uP7fszOQyxRFy8g2sTdW2PqtRndsxoVWun8=;
        b=hrTjdlh3sGlXSy5iWMSIXOoo+8fec9bE0D6hkIAXeWUeEPZU79KIs8/HTy0ArjuoMB
         4WQx/Q/tDcb4dywwe6BNHrUdODkKT5BIJG7b+kRyilwuzjnygwUkbsnTD012u2eSt1g0
         C1dhR+mBUBCxWhecMn6bT2o8A+SnM8yv9jyiWiMUdTh8tiyEHbI8pLQ7JC9frIGM9Lq2
         i4OLntO57/qYwNR8MG0RfcoCxVYp4SMaddzIUyBdCebOsJ1kGki3F935SKW8IIjeAj10
         26+nxqm2QCFNnu+ywkCL5I16OCXK+Frr5hcMQbCAl1jjcGLvl+oh4wW+nN99ik6ZxPvI
         R6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015112; x=1751619912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKLaJmc8uP7fszOQyxRFy8g2sTdW2PqtRndsxoVWun8=;
        b=Uo4uq20vaxZ/ulUWjv61KLayKk2REyDUGlxgIcif0E2byNYJnwmHd/s/j4H5aCciVE
         GIp/rW/sdjCH21uRILcU0Yfp+2z7AhhzdAiBbtfpR9LV4AbaiR4GRSQutkBVqpyokJBX
         AC5Sng3UlVLupMl9ruhL9yVJVDWndR75K1/LWhzszsS2Haruoohi2799NT/CKeJjfFZi
         1whZY38yBUXIHTr8llHBCfDYdbzuyyhf/FWx8m6lgViDCvFVb+l+uyoCrtDo6OFsn74P
         LNb2CGtB5HO5h1wvxlM2DWGRM7fHUmcIFFUR9U805wwhCCsV5yh2EdAfRmDk/ncSCgnQ
         FBOA==
X-Gm-Message-State: AOJu0Yw5RY6yVdsE7QluwvmH+5gEowqqMoLmb4wdAL9BKQwA0MI3zXFy
	+/uYQWk3thyFT7QtXz+Uan1rfG4GtXpv/z2JWLldalqbIm6t77FRwJTomkDT/7DtutdbojGVfG7
	AI5FeVi1dndk8freKEaWcYjkw8KhBmEZRQqaK
X-Gm-Gg: ASbGncvdZLYNgPNO2I7Bvqxq65iJ3cYKmltrGk3/Lqj1eOe0vSWimPlFdySiSWaniX+
	yuamLpuxcohEMPh4/iVa4ZH0VsqjwWqyN6txv332FOlhkbQDI5Nej3dUnRArC29FjG8UH87l+8O
	Trmr1v0GBOYjiWeyAI98dfhiqJcc7z/XAxLeFb8JwzjEzxuacnzoEZiTiiP9BzQ2+wN1hyWbdHg
	+Y=
X-Google-Smtp-Source: AGHT+IHeruR+0aQ4QQ89GLanJq8hrZahcY9qEG6ODBiGYiltdlUkBkNBMyEvvPp5KzVNgFOF4NF0DoPcfR+xCx83m/s=
X-Received: by 2002:a17:907:3c83:b0:ad8:e477:970c with SMTP id
 a640c23a62f3a-ae34fdc67demr202605066b.23.1751015111686; Fri, 27 Jun 2025
 02:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com> <20250626221631.457725-1-ayu.chandekar@gmail.com>
In-Reply-To: <20250626221631.457725-1-ayu.chandekar@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Jun 2025 11:04:59 +0200
X-Gm-Features: Ac12FXxbhjwS7Iwlu9N2x-d1hGDb3FMaKhdWMKe0VU-gwuBCZF5A3lMGCXdGyvw
Message-ID: <CAP8UFD1nCVGCK-PMzRzqFqp9WEDbTtpaSOzpCZrL-74wmUA2kw@mail.gmail.com>
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, shyamthakkar001@gmail.com, 
	kristofferhaugsbakk@fastmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:17=E2=80=AFAM Ayush Chandekar
<ayu.chandekar@gmail.com> wrote:

> The "auto" value for core.commentchar was introduced in the commit
> 84c9dc2c5a (commit: allow core.commentChar=3Dauto for character auto
> selection, 2014-05-17) but did not exhibt this issue at that time.

Nit: s/exhibt/exhibit/

Thanks!
