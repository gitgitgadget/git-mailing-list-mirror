Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECE1A4E8C
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982416; cv=none; b=kholCSthAbUVcU8q5rFdmZZP6EoVflzdZwEXsDY6hre5m6NDdV6N3mlwEh3Pv0YazG2YWxykD9CqnLvN03fAseJLiVaNB3on8gLbMJ5Pz8XfdycAR2cYY1yXsJSHp5CcmA0mOCRY8S/QAImyqiJwqidZjTGqUO6lWrE2y1YOnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982416; c=relaxed/simple;
	bh=I8N1zyC7t1ObaMPzBrqEDwq4w5Di5iMBr8AijFUskUE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N0c1soz86DzDpzqchxpt8yFgaB6PEA+bSN1B4FI0wjowdrDxfsw5R2DlxLk0tXcT+zruM8C+5M8uZb4/0DGGtbn4CTX0AiDlStyU4ydCuAcuDIwE6mzUhvGAXQrgPousr0mSbK4GbGEvzacyQ0gAyULeV+BRTp+c/C4a+HYO4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHJa/6z6; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHJa/6z6"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e1b55346c0so647435eaf.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727982413; x=1728587213; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8N1zyC7t1ObaMPzBrqEDwq4w5Di5iMBr8AijFUskUE=;
        b=kHJa/6z69KavsiDXQj1qJHmSV+IRSlMcbaUiyGqftsh9CUJ39HLadM/jm7jO0czqMv
         whl1N1C1EYEC9Lp+5WWxsB+1ob8LzaBEfwarKA5f1JjPBwQYibf79MoO09TkDtH1ADOb
         YtCgQiFNqaorFAlDqfcKyzHNhoRX97lQu3Ix2sx2UkzD1Mz7pTrx2fHoqSSc/VQ6KFcm
         gKlo8WjQUa9keqxp7HI0kwwCE2A34UGhWMso1LPlpGhHgb9baPj2EtWl3faxZ0YueAOM
         5V1mvrgHFsT3el7282vOsG2EiENbQXu9DQcTli7knO/a5wBcUUgG/1sNlYGGAE2nk9fK
         Mfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982413; x=1728587213;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8N1zyC7t1ObaMPzBrqEDwq4w5Di5iMBr8AijFUskUE=;
        b=BzF/GWSBDm5AjkeyKTDwMgYsaXF9H8AaizTueBnlfWIKAIlIzsuNOETQPK764cNlQP
         OIAVCj0D6a85Q89IKw+fN5iODDgbessrKRsNJ9SWdacIbTQ86eAeP6k6XfMGBs4+Ck3i
         r8ykGW9l+lA1Q4AvDLCRzLy+EjvAxf4r/b78vSaHN+wkpMYR6Bd4IaKQgUNWrTIOqnFT
         TkXF7X6qKtkvrG9Yg8Lp/bNoI21X4nCsBPZvTJWYn6lLgRItfosRgqXtQtfZZw0lVUYc
         D2Dw9n3aQTf4BLcT5WJZ+TG70saCnlrU3JLTd1CrwtW+W+K/jQ+qepULpiarAnNxysQn
         Scxw==
X-Gm-Message-State: AOJu0YyXx9pi/f4ddAObvcarUmyaALtB/1JrEgunUNMcRDxyPY56zSKX
	Hr0a3mtStNolZDwdOVx3FAaV7Y+3IRgwLdMDJDLTBj/O7no/Bj+ryRd1UniCojMlnu0EBwszd0j
	chndcxAKtJPiHHNN4UTHa0ew+rzZJpLcz
X-Google-Smtp-Source: AGHT+IGSGGTN1/PahJYSKSz2WzdGG3k9hvPHSR8kXMnbBMDHgmeNyEvcUVLZBZFLlFqGoEDU4ag8eM3o2AM11GX/aNo=
X-Received: by 2002:a05:6820:1c9a:b0:5e7:cb2e:dfec with SMTP id
 006d021491bc7-5e7cc097210mr84939eaf.8.1727982413507; Thu, 03 Oct 2024
 12:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alireza <rezaxm@gmail.com>
Date: Thu, 3 Oct 2024 22:36:28 +0330
Message-ID: <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>
Subject: Request for adding a "one-shot" rebase strategy where conflicts are
 only resolved once
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sometimes a clean merge is possible but with a rebase, in-between
commits may raise conflicts in which case a conflict must be resolved
for each commit individually, which is not quite productive and at the
end wouldn't add so much in how the resulting history looks like.

With a "one-shot" rebase, a conflict (if any) is made based on the
latest revision, then in-between commits approximated based on that
resolution. This way the history can be roughly preserved with the
same amount of effort while still using a rebase rather than merge.
