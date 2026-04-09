Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E25D40855
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766760; cv=none; b=pjCuZVgPf1rcbzsOZRj+E/0kqT5lw/o5AHpRXe9OUi3ZbHX/5nn/mE699zjxz2b3Oh6xm+U6fGZZQJRYTethNfjmbWZ7xeCgTxlAO9j6IdG0mdJ2j07yBryBgTFwGqlvF+asNW8eOYvgKwMazrfRTf4cChzLeL+q392HkWnk36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766760; c=relaxed/simple;
	bh=CSIrsihMD4Eq4hnWD7owpw4LD2gRQBtkU3/la9IcX+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7dzewY5crqw3kgJcarMbP7Y347yX3KYZ96gGNy7moU5VgABIruNnIN3levYOfKstWf2KHOwZLnwSYc4irGlLM5McJrFsX3/en7j/1UXJEJHo6/afJR6k3od9EKX1pHAXepE1Dmqdk306eHaSi/cwRg+GXL0Av3ww+wJk/9kDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMzG2IcU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMzG2IcU"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38df1889fb9so15050511fa.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766758; x=1776371558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSIrsihMD4Eq4hnWD7owpw4LD2gRQBtkU3/la9IcX+4=;
        b=LMzG2IcUEC/UP/J2/zCEPRtd+qToL5v6/RQqM9XkqzlhnNFD9ytMvSKYQdg3A5Y4dg
         rV9BHC+CgMCuRwQr63YJH5GYIRyjaTUWCzLvALK+RsLdofg4l+cpGEINBowV+4mTKUbI
         dUmktr3Q092AcLExNss3S3H2HifiP2qOOjmvdDPWWFdrEu98KjCeFQf6nfEocmfSFLg2
         xoy6UQv2o4qlhy+NtFsHMFZgKhZCTbyPj20h8KLf7e8aTKHKNkt4oc69YSIIYbPJrS1r
         N+gD5Ze16axFSndSl1KuCXqKWX9JHWj0GGC3dI8iX/5245IgODTG6YUqFDfQ7ec7UeM5
         FC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766758; x=1776371558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSIrsihMD4Eq4hnWD7owpw4LD2gRQBtkU3/la9IcX+4=;
        b=jz3twPlKRup1xJsx3Z3ncFDFd5uC9/0v1Gbh4o8AnbxWijM5x/vQEeKFZrE3M7fkKK
         uIkc3yT3L+giXHhxNBfvXeRQr/nibP/jQucMZLgARMIl2ZobEf7W2FWrfGISCQyezuS2
         ymRt8Pom/2SBsrPb/Pd4L3lJMyHK+MuCx+yAkml79qepTtU29DVIMXY+/FSMu/t86Piu
         kDXdV4SM9x/LdTL8XnA0fIXobMCDRBRGC3YvFMfkio4ochK+gAURr//lJmXHXwwEob24
         vjxZD80Y2OBKAaeqMwkgzHkyFqeR4r7mPPgQQuel7A9Ydo8C2J7uQ4htmBqVvPR/fEOx
         zcbA==
X-Gm-Message-State: AOJu0YyB8WR9eGQKsh/MZIURLBGjEYTu3bWPYDb19LroFjZwbW66RaXk
	RmPsPblFNUuEEIaY2BnXoXj4nxJQp0PhSRZNE3QyDuSxDWV0wS3B1O7c
X-Gm-Gg: AeBDieuiQqF2Gz2vjdxkCSQeDLgtYXQ50Y6OpRpRKC2Hwf0HzD9L3kuZii+bhYAmbFh
	c8HqJ16A4EBTDMkwz9QeJaC9ac46giiOIPPIbJ/+c5N+C6FWwQa4C4F0QLbkmLUBFgNoTR9/E1B
	jdIOVjc1eUZbkpDFXoA8rgj6tPlYbb9cpPfcHllsktLeGADt7oa9v82Gd226xVG92194F5c4Yqz
	WEXeYRNNLRCUk/+1fXIJCBh08zLbCePTSBFuQQBpJyubpPVnm4s656UP1WmlyanhtCJrWUmRFNy
	hSML3jvqxKzDU5mDigYmYZT2rorMt5ZquEtlXUJ8kTZNMf0UrjZd1S0waGBazrCr/UX7f9yNYQD
	cFTMA6P2521sjI8Dq2Azr8xFiT1VJPt6KOJOdpDoWEcZ+dQo4lKoitSQctg/yNxFkf7ebaTQVWr
	0nlFR5ns9FZ8/JpRlHf0e0kM0HyAGrVGiPGhxbnscUxzSjfKzVwnKMoAwG9lKMvOeGykGRbjKXl
	vyQsnZPgs3Z5DWx
X-Received: by 2002:a2e:b8d1:0:b0:38a:4dd3:6a48 with SMTP id 38308e7fff4ca-38e4bf6873bmr678371fa.26.1775766757414;
        Thu, 09 Apr 2026 13:32:37 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e4926fc89sm1672011fa.4.2026.04.09.13.32.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 13:32:35 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 22:32:33 +0200
Message-ID: <20260409203233.19082-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqjyugt3v8.fsf@gitster.g>
References: <xmqqjyugt3v8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Should we or should we not see an extra stack entry saved at this point?
> Don't we want to test it?

All of these should be fixed as well. Thanks!


Harald
