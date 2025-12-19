Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426F33D500
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156092; cv=none; b=cI9oRle0splDTHo+IjcEQvUHpQhK/RMZhppFvLwGigxlSIN4pnTNwPch3EgBpbQN41PCQUn4BM0prP0yUV/wm/iUPf+u7IBLdbZmzf+pmyKBU5Uw5og2+Gwp5leZtmWH8A5vJtX0oVvz774FtxVsxJhir755wj1cBmG5atSItos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156092; c=relaxed/simple;
	bh=jjSteJwYsa92et2ROv1xyxktQZYcs3u6r0mKMMeVdzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMWym1T91nkzQyyQhGZNGAYEz/EgdLscdRLdWHGLhJpgv9uxyePosW74ag02F3S9nzuru8k5W1tn3fgijm+7DIrHJcswuDOQgEW873ljGg9LHZI1W6JGN1i594faXUJ2T08Cx1wX6pGKBi7/CXIUj76Fmey5ZvXdxRqz/wCpwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYQC/xXT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYQC/xXT"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37fcec29834so14754501fa.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766156089; x=1766760889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjSteJwYsa92et2ROv1xyxktQZYcs3u6r0mKMMeVdzk=;
        b=iYQC/xXTRIf0cDx8yOBX36tBN0spmGJ6ExMaji/RKpP0Gv2y0NXOhpDy803AcVJMFd
         IL4Xdi4ov4BKbsjjqFXkhzDvNaZwAh52QRuKKo0Maj42KxwoQJIPW21YMCXLeBwpyQXJ
         zTyc00+gF2xqDn55Fr8Web96rdLsyiuCs1aWzFAnjCI5OZWAbFa80keqGiQMalmCDWvE
         lMYdpm+1PXm0oWBf3buCqRr6JQVW4sNQKoeX0R1khfySW6v42jD3wbAuN6LLPPRyjtPe
         p+1RNfgssp4B5s694bNmCH5kAlAYurozcjweLhiIrHMOSW8JRoqE4kxHzc4EZ8UAT6ef
         C75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156089; x=1766760889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjSteJwYsa92et2ROv1xyxktQZYcs3u6r0mKMMeVdzk=;
        b=bku7PfdXJP9Rw82FuQYRS2/X4yDvw3Xz5jCO8hv3S9mdONsfs/JHLXeLlDLxeqQ4vN
         /ILWmJcFbQvEvHgPKqnEbX4X5DfKXV2sX5kMmbtlnEpHB06IolZrc3HuacXlWE9ig3SQ
         tINxlPiSxBeOUNUHw8wcbsxwUc1Zuk5qZ5w6kWZBu293X5kZAAo3aQs6U2HvRmr1lcx2
         HtOWXHC4XIUWmjECjOfSkRfCk1g1aEuIOrpdviSm6MVlyQwFjaeG85RLBBenjqwRi/he
         Ckd5HBlN2bItYs6hAkGLBK+K+YZAUuWayhzWdUBbiCT0BdxHBWmjzNt8IHdF9qRbZhj8
         JSFA==
X-Forwarded-Encrypted: i=1; AJvYcCW1h/0EpVqO2npIRBozhOVFD+tPfMGPBejpaILtywDF8msjJmmh0Cr2SEuPHlP2opRd9qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJvuAU2NhJIKE6l0sR2RK9H6LPgGAkjfhcewB6wOYluc6gecg
	mFZ5kmYfMIPbnDr2sROtLOA5xN8VdDO/7PXYxkx5c+zjyvCimQTsLXEe
X-Gm-Gg: AY/fxX6TBnJxdv4E2A+WgKvpqlGoiF4Rrr8PyYbG7xDJKWRHlnoH9vKiS9+OTQWeHPf
	kamaUSUmX1s+zC1Atmt7HkUPxyqKVflvAEQVjbpGjuEcSCjKzSooRqjAGaAl3ol2do+bzLKAjLV
	r0xs6YBnGvNjSVHQ1gBt3+3BXF1JX4OiEoIoKsbN3nYrgQ5sIvbzfgUXneXSUZg2kYZUMDKR9jU
	1qBYZSkdKShcnIj0XQ6yH7pfkFAI41mODbKOd6H8uc4jHBMHJr7cAqf1GI9x8eMd63FjYQcL7PV
	0RGd0fC/x5YyLSbZVuEgGhjWeKXlOIwEsK0yTXDBmNiUDGNx13TP+BedqoON15cSM36MM/tqAe0
	cpGPRMlRfrXVlkgWNuGMyi/lx7AXVMqu2ALBkzJ1OdmoFTPOD10qBjlbyNSNZtjyPlTVobUl2F5
	xn4oIz8HjHIRqO/U2Lbl0ItvCcJ/fF/7kDn5icf0/F5/J2WCAe5+IBQlr7hjXg4Q6KqqpRlUc=
X-Google-Smtp-Source: AGHT+IHrtruEYhS3q5R82ISNNtsVanuP42Q0OgvMf8Uer480juSxpW8FfAn/JMXKHz0/b3kc0ufMWA==
X-Received: by 2002:a2e:bc11:0:b0:37f:cf97:491c with SMTP id 38308e7fff4ca-38121687c85mr9567391fa.37.1766156088694;
        Fri, 19 Dec 2025 06:54:48 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de761sm6026631fa.1.2025.12.19.06.54.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 06:54:48 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: chris.torek@gmail.com
Cc: collin.funk1@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 15:54:47 +0100
Message-Id: <20251219145447.22234-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAPx1GvdNQbHY0avQ_Gt4bkLiuNHPW80E0v1vxrwyQYDD=zpc0g@mail.gmail.com>
References: <CAPx1GvdNQbHY0avQ_Gt4bkLiuNHPW80E0v1vxrwyQYDD=zpc0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chris!

Thanks for the idea, but that doesn't seem fast at all 😅
