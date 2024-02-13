Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD8399
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841837; cv=none; b=sN0ERJUbQJGOkGhVz9uBR8PVyR0P39pzSOeOUFWMaJdDOKiaBV+w4eXv5caghQRfbdlBWyfEZMJjV9raAquqzjZeAUT7cUfPm5yG6j7imzDjFFStXKr/ktN/qyemjMV3nOLmjsdZ5mtInQN1NjTcdYaFUBQtlUza401uSBVJqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841837; c=relaxed/simple;
	bh=dDCNtekxInVRJBorPrr9w25YT6BdDTUhU8/IKbvB11Y=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=Pf0FUBC7IuR+cunKYYUTHnL26+1LPteLidFOsnXmJhvhG7rzSHqmj78wivwetWg2USI8qqGAiRvSTQZJmCx2aJsfofNmm0zt610TL/lowV43ZboGj+Vzgs1aOj2SVtYB6aaxv5rcd/0+isqae68zmVb2n+SUb10mS6H9PGvyfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbrmrMBz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbrmrMBz"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d10ad20955so8875991fa.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707841834; x=1708446634; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dDCNtekxInVRJBorPrr9w25YT6BdDTUhU8/IKbvB11Y=;
        b=EbrmrMBzm1y+ymO4sMDjV2Tv8A+xEtbK+2hOU+EsBCiznaume4OL9ArjNfe58hVJFD
         xBBuMsl0lZeEJH+SnupqRS7dDygVwerAYF4YdEWdXbejCdwwYvWlx4V8QeTskZ3Vmx8Q
         aJ/O8H+lcA8qe433KZ834FIHVZxWniPz0WSsrxc+6WD7cDte1JU04DzzPbS48XYA9gSq
         EQagqwHkTACGni4WsZATsq44CvC7P6M9g+JJdlDP84J4bgdJAQceniIvrfzd36il7uYE
         uGlWEKdG7T1neBswYYWxKO4VaZl4kxZUxQgRzDWVqYskMsCck5gJftBaJudP7s6iOS4M
         wo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707841834; x=1708446634;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDCNtekxInVRJBorPrr9w25YT6BdDTUhU8/IKbvB11Y=;
        b=v+FEAa0hlrHEzGNKxWozaZFSubVHu1rMbEIXYmHFw8tAuoR7EnAGdSiyMtE5GaAR/Y
         IYACx2zxYGlh5DHfDhxDRxIsBH8u5RH3uA7nfShbFLXAbmERRFLr9fK+J4DuJsnk+CD7
         csrP3W7V5kS351PtwgVl8sF/hXgYEnjmRRpEaoOs2rI7dD9slTT4wyOUe3l3UXum1SJj
         Rf/17VpLeOpHbiK432pR2odewLfwT5NaM8WL2wWqeAP26fwMT03I5ZysDYTFOdQjhw51
         ClErTneFpCTTx8iIukei0apOQ9GPb5KQ2gNnDaKVxsj317LG9RYHYXo7StUTmSqhptTO
         /H+Q==
X-Gm-Message-State: AOJu0YzeJoHEm5taQas5TheDSNVwOH7abbeR6CEPo/dYs5faSWbSXP+g
	sumLnCSBDOCmPmULt5F7Qgb/EkLQOsEyxjTRHlJJVqzTsTxMy16Lmbjb3cCN
X-Google-Smtp-Source: AGHT+IFhsn0bM7+6rXdpMUcyfiPpPZpUtfSSmrt+CQ49PpG3ppb3mehVA6NDDuhQmxzhToELetl8zQ==
X-Received: by 2002:a2e:8316:0:b0:2d0:ce3c:5848 with SMTP id a22-20020a2e8316000000b002d0ce3c5848mr101150ljh.51.1707841833577;
        Tue, 13 Feb 2024 08:30:33 -0800 (PST)
Received: from DESKTOP-T29D115 ([39.49.134.105])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b00411062c123esm4920303wmo.26.2024.02.13.08.30.32
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 13 Feb 2024 08:30:33 -0800 (PST)
Message-ID: <65cb9929.050a0220.e37fb.b3e6@mx.google.com>
Date: Tue, 13 Feb 2024 08:30:33 -0800 (PST)
X-Google-Original-Date: 13 Feb 2024 21:30:33 +0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: richardclassicestimation@gmail.com
To: git@vger.kernel.org
Subject: Bids Take-off
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hello,=0D=0A=0D=0AConstruction is not a difficult undertaking whe=
n you have the right equipment and a well-executed plan. A detail=
ed construction estimate is the only way to make your constructio=
n aspirations a reality.=0D=0AWe are a construction estimating/ta=
ke-offs service that provides a detailed description of the proje=
ct as well as the necessary expenses. We also provide a cost esti=
mate of the given project.=0D=0A=0D=0AIf you'd like to see some o=
f our typical customer work, please let us know if you're a gener=
al contractor or a subcontractor (what trade you operate in) so w=
e can show you some samples that will give you a better understan=
ding of what we offer.=0D=0A=0D=0ARegards=0D=0ARichard=0D=0AMarke=
ting Manager=0D=0Aclassic estimation

