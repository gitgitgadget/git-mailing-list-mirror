Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B034400
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453930; cv=pass; b=KbdMEcd0x/XlawgU5nJtx2YcIoHPgcsj1Xq0PV1CgzmtSXfcwRUeAnaj05lrPPolaI1aVXt3lPguPLdP6akG+u94jE72ORmE3nkdwZZm2e3svh2T1IEqsjCgi7RkyR/9v4gRvdXK+wKnMBidGnVN/+oDzlaK55vJWZLG0UI+46I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453930; c=relaxed/simple;
	bh=/5szww2zMP6dGgL2TIUyDSG32kWPkvmjHjJbZvk9xV0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tWjfdpPct1OKBCW2vkYQ2lYREv9f4gL1rZUxc7o/ywZsZDndYGZvylK7jB1qYbk68uynNsuu+c1J7vbiR56RSMCyquMOAjmsKY+EHte6Fq/PX1BNoxPiAZM4pJkCR28HwXn+FH2aY+u0JnxIAGRp3VU5ebjNoMMbf568LlYYTRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqec2ohW; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqec2ohW"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732165d1eso4521605c88.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 04:18:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772453928; cv=none;
        d=google.com; s=arc-20240605;
        b=Qd0juAqyStJaL/gB/ONcNCraXjBbbeLlzsirsrJex3EIgNntv4liJ/gLiWpo+Ev7Db
         jB321J/LOoNTAD2tpa/W8EllbnQvMgz4R0e6s6v2xvQZEVmCXbkaIbgd0bBMMpRNuHpn
         fKynoFiyC52mOSAAXur3CgGLunhSK79xyWMmjU8VuSR3sNcQ3uklnxV4nSsERo8cYMZX
         wTt3oZ/FQDbp3kIs4NPGEtziWfQdoBmEB82PvprFL0E7gIkuL+V+au0a52Z7QcklAsh6
         VZIymJbE+AacXqIAiumgDXxqKQSBk3vhYzou5wEIFYaNhw9vtRSNdkv9PLCpGj1F/B1z
         CU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=/5szww2zMP6dGgL2TIUyDSG32kWPkvmjHjJbZvk9xV0=;
        fh=wsvoWvBz3+zI3cO8xbdreD5Z3aI/wpKopH/flyQpgVg=;
        b=Iwji6MFfHH2wO26gj1OLsiz0BAPRvanvJHITG639dOdFVk62pm6k724D0yyokcpJDp
         WX9D3nKGXRuJj4bR48Lt8kLb8rJJKhq4FTYBfKiF8wZTd0tsm85SFZKensIlJbiZiRB8
         ZR+aAWoGKTM/+WvolT1tib/FUzPZPsluVfoXQR0I36c/LCf67CX/6DqUudEjP8MY3AD1
         tKqNU/DyPi4b9ScJ1fzBJp0AcEmm+stuKcjcNr0RSNQBfh7rgCk/Gzk3pVcZwNbBi86O
         kcCN/ntke8AxppEp6+Px4RGvhrFechyZTXwuQ+kE6jfzUnWwMq+QwSyRPteshGGZBbJL
         zI6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772453928; x=1773058728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/5szww2zMP6dGgL2TIUyDSG32kWPkvmjHjJbZvk9xV0=;
        b=Iqec2ohWdiy0H2MYZYpt2bxW/nH9SHnz8LGM5dJsPwInC5+Z1eMDHd8qBSVJ8YHl59
         JZgaTG2XRm5vRDU7rHmD8se894JJ8CgE/jn9C6i5cTMEzIsO4JbLgkpLyCjuDyugKCSg
         ekTf01uIDu6lG2Q/JxfuJmI9D3Bfp9968S1ay9ffksks4xqH7sGrELaoVc/5ykzoZCkw
         +cPUkLC3b96oEjPpgCpBrGfkm2azXtPdMtPZf8N5Cgsx5wYcnMgSCHzaukglGMaX9ETL
         YTBvwNkqbSAocfOEcgGNVOoSLV6BCMYQF3yAQDKJd4dx6bum7gVKQjCS52t/JC+gRmBk
         u1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772453928; x=1773058728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5szww2zMP6dGgL2TIUyDSG32kWPkvmjHjJbZvk9xV0=;
        b=WDifDzsRfbWf6Ema54Y7KgDORgfOMLWsQXV2S0pMv0R0KXuLnkn0L5HeZGTpfANer5
         O77VOqUN6vZiZ5M05hCZR5p+7q7kxMKtsh3uB7tNLHrTbg+BX1oYb4c0PlHcwNkFf7KE
         UdSrC8E4akPaW5RhsXSjiXlqN11XAU99lLDtreKre04C41jTBaiXboby5nj3WFlphm6y
         bHNzWQoWaBPXRTTW2xfF5rYJ4QHWD7ciq/rtONklRMr4ZL1Y3zpd/Bbu5nM3Uvp5bF8O
         nAg6ZkTQmXF9j1p0EZNApk4p09MKS6Y+8zsf3AAuFXSfaA3vZD8DwSyNkRVXlkCTJ/H3
         h67w==
X-Gm-Message-State: AOJu0YyjctW3oIhn06Avq+oRBXoRGBMzDOfb6CL0H35AwcXJ62BMHNhP
	SY7KhUY1tBy7IaenGw4XDpeONut1cidHB87myTF5xwpr5mbmou0ddX29jqdkuoOImV7uNf3s8zc
	n6Jsa6suxhGaipVJlg42O5t+/rHletmFER/SpH1g=
X-Gm-Gg: ATEYQzyUwGmikX6aqNkQHUXvmoWOG1VDJfcOi9Y/s8C/BHXgee0+VHK7g84KW/C7gDS
	HlV9TIEJmYU35X/0Ow53kQCvwe63+nQLpRndwZybDu+ANtTutt4tqHBlwL/zcFhNqriM+K8k2PG
	xcszDfD9SVgDtCK/9ZeiWYYrDjYDDW85b/wCryBe49una2FCOTZEm9RwCJAx7dyufQg8zkf+H7X
	0nErBqU+yU5b+stojJDRJH45VZMpNgFrZJoeXerw2SnorvwQm38XIqSZEJ7YaL0DXjvuKBkeJqz
	qmiNUxbmjsoVr8C57GKv9xoga1ryPSPIoyrTSK04qdyZ
X-Received: by 2002:a05:7022:413:b0:11b:7dcd:ca9a with SMTP id
 a92af1059eb24-1278fd05bacmr4874686c88.34.1772453928027; Mon, 02 Mar 2026
 04:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 2 Mar 2026 13:18:37 +0100
X-Gm-Features: AaiRm53MIOe7TsV7UnBVlCy9t3p0NDfPUfO6KCOXZ5v9JTkyu6XBOQQXgSI3q9s
Message-ID: <CAD=f0L8NMSqirCMxo7dvoCavB-24xOjDfSsQ=hvC++3-MyqEbg@mail.gmail.com>
Subject: [Outreachy] Blog: Outreachy Internship Update (week 10 & 11)
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As my Outreachy internship comes to a close, the focus remained on
migrating repository-specific global variables
into `struct repo_config_values`. During weeks 8 and 9, I encountered
some challenges related to repository initialization and testing.

I=E2=80=99ve written about these challenges and how I was able to tackle th=
em here:
https://cloobtech.hashnode.dev/weeks-10-11-refining-repository-specific-con=
fig-initialization

Best regards,
Bello C. Olamide
