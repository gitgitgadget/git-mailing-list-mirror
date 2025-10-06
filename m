Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5741D63D3
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778174; cv=none; b=Pt0mTCTrwJasW2smNaVnm4BC5suRA3kpe4QHndoJGyS0axHyse6lK3WN5AvvoAyKVECrAbKZdyTM1MNqsVDEqhCRI69efnSnS3hCjRVTiUaiRNHQg2/WYvGQhmZS+HbZkFQueJ2Le963Gp1crVYooqO50ZbEVI4D1ORNiDsjfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778174; c=relaxed/simple;
	bh=ELSnnEijs3vNiiA7tOxZgrCnHcvuOTgTMtprYnX4wcM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k1nhU6u1tDcRePpZ+MuHEhZdLo7v1O1vMSnd+r8mmuWMCzJPvvR9xHQeZur97yE9YAYHu48TUcELMPQ53XMAF4G9ZvnouM5irjVXQeTnV6BYliEzENdg/eIlk0LL4qBqYKsG87MtN7tYb2S1WX5NPjA5y7QPEX9DKTBkNwftQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cyoG32Yg; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cyoG32Yg"
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-930a6c601b3so462359939f.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778171; x=1760382971; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1l3JdzX1P2nAHHp78YgwOHIGRoPyy0yoUwqB+O97i4=;
        b=cyoG32Yg7z1RqQGRXxIJVf+U1fZt4XWc2heAaMlXft/B7lzfwj/vgk4eTbe1RYCmQy
         s15tMjTPSKtlFW4qTc04u5pXHpyyf2kI2ifLBLVSZjP8LgDyvA+ETrlGFK5AXQw/kS1B
         QMge0YvsyLmir3dIzBJoJ2AUO9qMHkwgxgohc3F2IuBwyIJ280QXHWsHSVSpDfM/JjXL
         MkOQ10F323CxKRB15qjsnh1YFGUKN2n22Aku84BAetiwo2tqG2yc6HSFajUwJXfaHQd4
         m8TfarLqctjWXiZMedPVnT6wuRN1fbmXygIjPR1yJyyKbU0VpIctezqDNitq64BK3ChP
         QDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778171; x=1760382971;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1l3JdzX1P2nAHHp78YgwOHIGRoPyy0yoUwqB+O97i4=;
        b=iDT5NukLcMQtKQXRL5W6+VvtCHG4h+ZxLiArsBoqPs1flmoQXCN/2Rp1nMmO8fjTXZ
         wjP9OzOIPX7BK2s8jr1eBr4NnA9OWYeG0jx/dE9KP5wD0ug1DcDGeFaoo7krXEtSIenQ
         VulzYlP1P/aCINd9W5A3JNLrKiTFTteyYdZlHJEqw1YTGE/N2zdqz5LBhmtpLzY6eMu1
         EGO0nrSdVC9lgTbzRIvkttPkKD+KLAId0iqoyTsACUG9/hATFz90cBjyaUSafLrGVk5J
         q3AjMIwYZCHWyQemWSKl1SDP8E2GMT0dRkcHTiOIkSKKJiYmcXQR5uDxF+oT3cxnQG2J
         JmqA==
X-Gm-Message-State: AOJu0YzgaeelQFNfiM3cWTfq72Hs6105qJnslTsHTbCmzjGT8yKutrMI
	XDHhCbFoNyFaj9iJzX1+UM8aiKzDuojxv2RtjpG3e6nx3UbwihTYoXMHePJYJct9vAJdqX5P47Z
	SBdaco91XP70e
X-Gm-Gg: ASbGnctWTlwE7yI14e81ePPiC7RXwR5x3tFnIFbpw3Fj/aVevAr1gqkiXn4zRMJ62UR
	m5EUmF2Xox03A5UoBOUDU5DqLir5eTtsbInfj+70oPOt0fbl8oJSBH3mZuCqQoN9h/CMI9WnDtk
	98UYYVh/YKg7aX/CLNAajU3XusoQ33LmGnevWOde4DHg91Vhrrg7WFESCfWcXr8Ly2vlrlmFLkJ
	TdCdUr+Fevjh21oUxrn2TFBLtVFuyqQABu+12ZG/aHIxtr166Z5OUdy0KYEVGLPdTBtO40yriPw
	ia0KhUG8gVdUqSpys7VIiU2TRoGlNApw6RfO4AY1UlVfV01Jd4w/b/VsJoxHmvvU9VF22jLBTnI
	sD/F+Oc7rf19I6Nve4RB+5NyysJ3F6v6bFRsZmAb4P3/k6jjhqMwwCbxvjrj1penUI5ox/iz8aW
	wPWjWwgTMeZ0XN8nuLdogbiHJrfFcS8S6aNG9UTWmy5rIKles103s2Ts/ejqyc
X-Google-Smtp-Source: AGHT+IEoi2PddITVoSQpQ2nBtXAf+clBeax/uh9Euag6sBJFUzw77vzhKSv7Ed0Tm+EWc/r6JFNEAw==
X-Received: by 2002:a05:6e02:1809:b0:42e:2c30:285b with SMTP id e9e14a558f8ab-42e7ad86806mr181321375ab.20.1759778170490;
        Mon, 06 Oct 2025 12:16:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ea2b6bdsm5269902173.27.2025.10.06.12.16.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:16:10 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:16:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Notes from the Git Contributor's Summit, 2025
Message-ID: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

It was great to see folks both virtually and in person last week at the
Contributor's Summit!

After travelling back home and catching up on things that I missed while
at Git Merge, I had a chance to polish up the notes we took during the
Contributor's Summit to share with the list.

The notes are available (as read-only) in Google Docs, too, for folks
who prefer to view them there are the following link:

    https://docs.google.com/document/d/1arvvXP8DrF3F8PCKQOmGvYh5jUg8P9Clx9m-FgDD4EI

At the Contributor's Summit, we discussed the following topics (with
topic leaders in parentheses):

 - SHA-256 and interoperability work (brian m. carlson)
 - First-class conflicts in Git? (Martin von Zweigbergk)
 - The future of history rewriting - rebase, replay and history
   (+Change-IDs) (Phillip Wood / Scott Chacon)
 - Rust (Patrick Steinhardt)
 - Pluggable object databases (Patrick Steinhardt)
 - Repository maintenance long-term goals (Taylor Blau)
 - Change-ID Header in Git (Philip Metzger)
 - Resumable fetch / push (Scott Chacon)
 - Git 3.0 (Patrick Steinhardt)
 - How can companies respectfully engage contractors to work on Git?
   (Emily Shaffer)
 - Conservancy 2025 updates (Taylor Blau)

The list of all topics proposed (and the number of votes they received)
are here:

    https://docs.google.com/spreadsheets/d/1mSyAvvpYTIuR7JIm7J0H0IQQEUt5y8zq8Bo53nl8yCY

I'll send the broken-out notes for each topic in a response to this
message for posterity, and so folks can continue the discussion on the
list.

Like in previous years, if you have any feedback on how the
Contributor's Summit went, please feel free to share it with me here, or
off-list.

I look forward to seeing everyone at future Contributor's Summit events
in the future!

Thanks,
Taylor
