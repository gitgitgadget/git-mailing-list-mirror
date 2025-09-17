Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9E1E3DF8
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090169; cv=none; b=MCDzXEgBPTRcjpswBbGet50vitQsLnhzN0fHYQuZdINGlm/1aouAUECLNYeAVRl2T0xyTv3MzBo4+8dqaQgCAtG/3LXoWSCNeLVPqBt1ziKeAzbcGD4c/55QDLJTcQDSQpwSJGLomHs0omXfsNV4mqk9Ub0KW57ikUO836ycxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090169; c=relaxed/simple;
	bh=A00GMnWCn07chNb2KcuyWfctQHaqlJWeK7S2bs64Z+A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EFASBk09UU6Yl9lmbKosYx2Xln+ghqQ2/S2yxyabN/wQTaGfTNHK6AoC/f3pZi5P/UZOy8m91Lzail5lKN8y3rgolM3QHz5GjnWSqXICv2brGjGkQR64HcIhzeS6SlxuLOxw/W5dZOpcMApJr5p0ZPV8jEb/rYqxCVtOpJnMM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBWiG0Lf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBWiG0Lf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24458272c00so66979865ad.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758090167; x=1758694967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A00GMnWCn07chNb2KcuyWfctQHaqlJWeK7S2bs64Z+A=;
        b=cBWiG0Lf23i03tb03j6dAOFsdfiIrq6gv033EQpfypgLXYWmX3XK5YjakOk/RHcPvy
         4QBwlkL8Y5doBWpdqMxOIkDZAm+3nXFE6+m2Ow8LtC6DyFHKTGhwEB9KMi2bETHZuwcK
         srtvt6zRfHrkzRJsFqOgL5jnpFuj+7+lSnn82Bjd0Snxx6SIhv2+VRfQTGRJYjBgDXWV
         kqw7+ZZ2K2qO9YHLv28WswPlY2JUVg7q+1y5B6QECDxTiLoqdSUZkYCGdj1Yr3oXVzxZ
         +Cq78yLT2SCs4MDMALXkSnQ2FdaDycgENsKJtnpPawYk9WmZ+Ils9FnI5sHCjCuRUgw5
         p1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758090167; x=1758694967;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A00GMnWCn07chNb2KcuyWfctQHaqlJWeK7S2bs64Z+A=;
        b=Cv8yBWa0/ADGEcKGwmBpcHLfdaUGMU1XfQ3N7gifmYfmuJnEcYaajNFqRzcly4FeRk
         sUVqO1WbZcOqQmqcDgE5V3raVPLX+VPBfheBJiuab0Op70VcDdMAsBaF1p5tfxiFaX7n
         hl7vHzFVthjFNQBmm3yDhvrFJ+oqNZ+2JIXuqLQQkBlMzwyqYaV+qGwdPWBppevBMk5d
         8669vWb+yhVRBk2so/G4stvK0v0C8/Xgd5wwojOVCk1+3rWg36dtn+moxbiMovXTZ+Jv
         G0yf4G5+w2Z7c8C9p2emghIZxdedBaz99QTT57W4XCXmamwodtp1jRviKSn/vBsdENjC
         T97w==
X-Forwarded-Encrypted: i=1; AJvYcCUiZr1QTBPEjzHPtUeJ8CzmerpfBz7jhxfxTZnfhbkPCWsBLWnictNEyr4DYxlGSa/hBqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDozovHwFav1bGUygmX5ywckknqNBNiFMHHnA+L3AJzmg5WXD
	NttZXvHCrD9/5yWT8M60F8+Akt33bsiyXfVJSFEHMeNWOVan5QvqEaNv
X-Gm-Gg: ASbGnctonMoEDIai3hVy+c4zz9AAzATVxUwxVa++UWkjZWn1bVBBRebHuFK0tGodO7e
	ZbhXhv1YHQCPV5jAiDMGe0eIq4DfgXp4F3zcpyBa6MrN6ycbfx8WIdx1246NMHJ0qHNnD36mK8I
	YkiVWkxpO+OeypsDJ8miAeiVRk65n1cgAqQBnYDcpaX62bXdrC0bPB2PbhOzDQcJQDG0H2REzmS
	vcWiP/jIlJBxNaltEg4A3Y2HN7LbljWI/7QADij6aNPl/oLhhpzkSEZDu7JAyI12zdu5KXqEs4L
	SuQBmSx5NLOakSyz+OcuDKeAfkN1isyEIWPi/VIvw0bNhtevv2PylF3h0DzSW49R7uR9Gr973sG
	I3Gkk8LEa5jq2rRhhxye80bDquttwVHej1a3B49KrNrQ=
X-Google-Smtp-Source: AGHT+IEBAWy6FXtDiwad4GTmNkvEaJOb2ijBSc2OtSOlV7jKpwrFnRNITUWo8/3kmvIq55An5Zgaog==
X-Received: by 2002:a17:903:8d0:b0:263:a2f7:60a0 with SMTP id d9443c01a7336-26813aef9cdmr10504475ad.48.1758090166886;
        Tue, 16 Sep 2025 23:22:46 -0700 (PDT)
Received: from ehlo.thunderbird.net ([220.158.131.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2653fcb5b33sm89120495ad.92.2025.09.16.23.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 23:22:46 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:49:32 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
CC: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: Participating in the Outreachy December 2025 cohort
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
References: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
Message-ID: <7CB0088E-B6D9-4104-A632-CBE0895D7AA8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,


On 8 September 2025 1:15:27 pm IST, Christian Couder <christian=2Ecouder@g=
mail=2Ecom> wrote:
>
>As usual, everyone is welcome to participate especially in
>(co)mentoring, providing microproject and project ideas and sending
>PRs to update relevant pages on https://git=2Egithub=2Eio/=2E
>

I would be glad to act as a backup mentor in case any of the existing ment=
ors / co-mentors have sudden change of availability during the program=2E

If you need help with organising, I would be glad to help there too=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
