Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6381AA7BA
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081318; cv=none; b=fhkt6q6oSiPito1V1kZKv/WoiVoV0J6yOkeFYL2FumI9lfqNGBUlj34/pImS8+lpQeA0ih8Ojv8l8XxBj0lm2JuV0gnn979pGSamrOz/kK3evPDRy0a361ziny6MVx4vVONW/rT5yVr4Cdih/QdBzUZ7H8FMfIwcXQ+FYWUfV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081318; c=relaxed/simple;
	bh=AAo3ippz8DySpvwwWuBELCyzG+gjjhtRED40WK0BTMg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=miIOPRi2u8fIPk8ei+BH28ksRTHjZuoqcxyLl4JO6QUL654DexLSqZKX7yAH1BcEcTTgnx1jYpjj0oKZpjrSSs4QkUQwMrV/8z33t1bxK+qOk2xg8EYLB8mu6qqBvy6n0uap/aCGLsQulpq94TpESuH5bxiecL6Sx57BtDCxqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgQYt6Wz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgQYt6Wz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73712952e1cso4493710b3a.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744081316; x=1744686116; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQrsQRuSq2xjIB/XxHYnwkpM8cL6wdZB6qpkbkxiGLQ=;
        b=mgQYt6WzlHwkGqXprJI8A5schtkv1KwvAPqBU0egyKHlzkWgbh2mSYuChjR7Q1NzDO
         d5VBYQzxe1/HD22sOA8uJ6sejUCwdCa/X2TtKryqHfbpxfxis66TNMfTpHzDWR8jDrvb
         SgHCDLjRXCbVi4lv2NLKdqJlTv7/ufUBKlk8CbF9efIvOAxT0NU0EZQwr2fAWp2hlm9O
         0j5dPQIn9Nix33sEnZaA+X32LKsiJtll5fzRhY9BirthgPciu37sCsGGJX05PSaKAg6J
         75EYgLg0A6kSIpOeWGGiefvH6/K9r0DepQEiOmPFWGeX0rsCxuokcIVQwTENsIVRddsn
         Y7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744081316; x=1744686116;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQrsQRuSq2xjIB/XxHYnwkpM8cL6wdZB6qpkbkxiGLQ=;
        b=JRfxSceunSpG8j/ZTUsgzOSm8u0BTSAclSHdYCIUiw0bPVzYXV6eoRYThkV6OPOZb/
         u0J+XgN8qBOeZRxX68G02Z1JzKyJJ644PDythiMCWhok7FTOAiR6tAuhPPOD9NeFKB9c
         Jpprk37n0DRb35womDYNO+UC7Oy8HJ0iEZ59g7bKyzZnnozk/kcpNOhOJHmUjrg0ehZ+
         rnApHYovd5hJCBs1BdsCfPdlEgggYKf4OmTHOposgr9aF5PP/0tPBm+GKb13T/mRvfG+
         Hh14kQt+d5gsTMQUL0angTN8BTdoFjLO3SMcsxexNFMagXXyxEptxVkQqYvbxZAEpWT4
         eDyg==
X-Gm-Message-State: AOJu0YzBG//UC4QYh9cqwIHG2sjEFNvAalS4sp5mYtSrctwKPm7Je0pH
	s7XBIHvG8n8JfaZlPDBXsr5PNd8m+f1ugHpFIomVQCPz2IlE7ON4KcS/SA==
X-Gm-Gg: ASbGncuYh3ljuBHYT+Y5L32pw55IAysRBqgMEhTmN5OGYEAyKO5M2Xslht75xI/AHQk
	wnOf+p/oXRMuvfx5xxxRyhx9guBdbavBiQ+yC2mWSSy9l+iRXNk72EPtQVmvOTJvrh/WEjDy+34
	ub/Bx4AhsnnG8sdUg0y6p/uOhoir0dCv3E8mIwo/XuGAGtfGhlKvq8JWK0zgw4aMB3l3+noY4sG
	jSDxv5l7npEUvNhOXYY9orYsVDkyZFz6sUkDu1PC5PCEQbpVtVFCKPDKkspUWkNOFDtyd+r9cht
	tfot2TwALOclQ/bz8c50UkWPSvL6jVi6guMNMNlwqjaWX8rzMBPV02MNhpMx1QHfN8rwgHI/F1V
	j7Q==
X-Google-Smtp-Source: AGHT+IFUiRs82kAxrkXyxXSgvM8Mx3xnvvPGXNPbRHOdLpvHhxA3qK/T8HtNffFlwD8X826ejXZsQw==
X-Received: by 2002:a17:90b:5443:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-306a485edb0mr22189010a91.11.1744081316411;
        Mon, 07 Apr 2025 20:01:56 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:b169:70db:1e5b:dd10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca1f40fsm9938371a91.4.2025.04.07.20.01.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Apr 2025 20:01:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 1/1] t5601: modernize test by using test_path_is_file
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20250407195505.86-2-ayushjaiswal12123@gmail.com>
Date: Tue, 8 Apr 2025 00:01:43 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B0D794A6-64AB-4206-A4E2-2D13E3ADC347@gmail.com>
References: <20250407195505.86-1-ayushjaiswal12123@gmail.com>
 <20250407195505.86-2-ayushjaiswal12123@gmail.com>
To: ayushjaiswal12123@gmail.com
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

Two things about your patch:

1. Given that you sent only a patch, you could do that without a cover
   letter, sending all the additional description that you want after 
   the scissors mark (the ---);

2. Your patch is adding the entire t5601.sh file. I could compare this
   with the file on the next branch, where I see that you indeed changed
   the line 69 for using `test_path_is_file`.

I suggest you to send a v2 containing only the changes that you did to
that file, instead of a patch that creates this entire file.
