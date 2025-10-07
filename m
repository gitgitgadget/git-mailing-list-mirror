Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB0258CFA
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877902; cv=none; b=hGdofDz6Zu91vUpmMlSQNdBGtK0ifLvh4Ght+T2nipGKAEOKYsHHOifvZsct8lOz8gx7NYRg4wGiP8qqZS5mw/E+Imu7CMMuI2fdlm2ejBQSLmL/A3bNMJajbgyQt0X1iRoJ1AUrYJQ+OpdeAuQ5xM3iZECwl73X24LS+2fgRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877902; c=relaxed/simple;
	bh=BZrS9NaCvYpaTf/usPAbQaqy/mJVexU9GjLS3tdbYCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WhnSujvZKPXLWQaQXXvaHa4ZXVWyEVdy0CYfW95B0cc/KR7Xwegi+V75Wt+S8qSLVyQezr7h8VIhIcnZKO0PJDlECja5vI9AuilZmOk2A0FzjxnFl+cTtlXfuzcQ9t09bEr7lQ/Jinjk7H7ylfqI78ZgAHUb9pFMKtVXuhc8W/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSq9Kd9J; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSq9Kd9J"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57a960fe78fso7712123e87.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759877898; x=1760482698; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQmdBFyi9N86wAuvYDlu5dcnEu0751qfbksQLF2J1z4=;
        b=dSq9Kd9J8hsaR3uly67HtYjcqcjTClBbeIqe93ePMLYOYv12ayvqdxems2eakulS7V
         zaeNbc4ad4Dw2s4jUCFagWe4tofaaX/rF8+2FY+MmWLYP9CbPbDxd4McCWUwxcZgKjnl
         FQ3JOi6Ng7EUzTkLP31K9qG39pJSao5sr6wMJOyg8LjEP/+7x/0gwSbNqk9apjjpD0rL
         68wmMJOnNM3sEMHhcVDXZwksti0wbl+9U21QgL3C0WFz8TEKLOKQDm1z9bnVbYNovYI/
         sl9IG4uvU8luBOUk/I3S1Iwwf3nmio3ZhW0QvKOFvB/36aN4DhxtFubJACXQKidp3lCb
         VrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877898; x=1760482698;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQmdBFyi9N86wAuvYDlu5dcnEu0751qfbksQLF2J1z4=;
        b=QpAR4MdEZ6eJmzScYGHTNHrukvDtzd57ZBM4APQdWFZb1RoKfFgu2IG/YUYc3MGVDS
         Qk5WAbOSPueLWXjVMidU0OPmfLNLq5L1wyI858fYbArLKXms12DxeSMEt2orjL40H/Nj
         MylHiaDytSxIEzfqbxbqt8kNsA0cAk47sRsE6woi85U/p73KPO1u5S8MJ5pfmcg0bKy+
         uFt22uUgVZFIEFxM0rxyrs8d2xTc9MI31Eqjx4+BQxFKjGi1cotp3glicqgqXdGIOLyw
         P2E/Mx87ZL67qbiimcQJc7GVwQMdIv5YgY4Kl86xolP5GXm0TAQ7R0uRqb4usyNS2dRe
         MQqA==
X-Forwarded-Encrypted: i=1; AJvYcCWJEO79MzLAR5aP7YWw820ZIwfu200xQspYqI5RwvsvkQi5BEcV66yceUs6YEboeuHK96Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/huXrAJyA1TQVbHYMkQSF9Xbho20CtOgm3F17mPIbT1RKnTZ2
	h+6OqAHUnUVpaWCwV5xm2y9IKiAgHBDfb0EmXGrXdKPKNfoEJa8i4/qg1jTygL09IO+KjiYjNmK
	QTG/FdAkhoqlOKhFdGYjjXckRGbqv38g=
X-Gm-Gg: ASbGncuBG197q4yedx0dvXI4XMIuKqA3YWgAD+taBQD/LuTy0D0CdjE5/lyV0SBVsFV
	wVMntAToZtvy3ZZZ+XBAbHqjtQYuVrLV6kS6LETc8Mx4T85fVQQQc8g7ZyG4mcyaYlq+YR3iA2u
	I8WFsg9566TGq7G+qpXEMwjxOAuFYJO1qVJyN2mV+ccHS8aCN1wVtIrauBVaCUAiZ+G7PfSJsRy
	Drxe79wbS3Xah4DTruzjMCMECIxEEOP
X-Google-Smtp-Source: AGHT+IE2r23gmuxVCNBW7wtRTQas4HJrJknhxBpkXPVYKO7XsthmwI67iUaBzgnZqv/YU8KDFM6YN1dRkyHSJ7hSh24=
X-Received: by 2002:a05:6512:1387:b0:567:ef90:f519 with SMTP id
 2adb3069b0e04-5906db0364bmr350183e87.12.1759877898305; Tue, 07 Oct 2025
 15:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im> <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
 <aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>
In-Reply-To: <aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 7 Oct 2025 15:58:06 -0700
X-Gm-Features: AS18NWB4lrFSf3O3IFncNkkM9mT33s_Skge0Ukmo3ontyAClYY7Gobe3Vd0Fhf8
Message-ID: <CAPx1GveBE5mi7R3kOwYM2ER7rmVyS3Hwbe4o-m7UzdtFutouZw@mail.gmail.com>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <ericsunshine@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:42=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> My preference is actually that we stick with the default.  I use (and
> for a long time have used) a 132-character editor window and I find it
> quite useful to have the extra space. [mass snip]

Since I started doing some Go programming (which I still do far more
than Rust) I do the same. I actually let it go to 140 or more sometimes,
with vim settings to put shadow marks at 80 and 132.

I still use my trusty 80x50 windows for holding a lot of individual
windows at a time though. :-)

Chris
