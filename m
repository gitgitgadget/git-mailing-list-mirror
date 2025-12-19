Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D233B6CF
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157820; cv=none; b=QhDzz3fmPKipPyCnoenaZ+do5qBQua3ZzO97Ni7+Bd7auuPbj0PX0R7kq2dQqj0KE1IJuu9+XHVuvRIymf6ca6xhWe6uQLahJ4umHXkl+tj5OyRNTEgRh7yfVOobh4Ox8iivvgh7C0SUENAjXPWiBLJR8NY+NIVuohg94Oo0XgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157820; c=relaxed/simple;
	bh=Wu4iLCNTNC34TGPMkZg7IvTCn+6uswTOGr+Zmy1p/to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucD8SNIJ6lv4IflS/bYUen4Lnoh9t6aVHuei5KkV9ePAzu1ChtCCyBKe9dSlOQefwgu3XnfYKkEoOotUuSd8TFnyeO/ZO8qadpkyREdRcVzxP65/McpaxjVtAsc1ZbyO9RwkAuZt4wURt8fVCqQBLA0o+63rG4eTY+ABtXXr7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYaOjcmi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYaOjcmi"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-594270ec7f9so2206417e87.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766157817; x=1766762617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu4iLCNTNC34TGPMkZg7IvTCn+6uswTOGr+Zmy1p/to=;
        b=LYaOjcmiuilOsqAPKMwUKWK7YOLzVhQqUf3mwaCaVf27A7QdZLUeR+jY5C39m7yNmf
         CkhI3WoFCIf8sOaUEK3/rq1hNsfe4COB3H9b9Qwuxw8taSJJmZarHI/7+jQMalwQK9e3
         GWHLfK9YmRMFhSqeoPsRh0xksyP1L33hAyZ1/hddKLChMNePXneJxbhHXxB43dOlAXqg
         DLySzJl5Ltukcpxd7ZRlglQCO/poY2/I9D9Yp155hYLwI85X8RbGcNPj+FBykhpN+D8A
         bJ2AWHWTHupnaBAbDu1CdiFOtzoNKSG523xs2ektVTC83EvZ3k+ShIggo5cw15GYzurh
         cQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766157817; x=1766762617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wu4iLCNTNC34TGPMkZg7IvTCn+6uswTOGr+Zmy1p/to=;
        b=pYxafvVB2zDqiw4WASL1hsdrh+z6VQZePmoHBMd9MoRlb34Hto7VHiRqL61WnioEIT
         MUEyvyQ2zlh20o8HNX9mXVOgh6SOTh46+lvSkS2GaXFCtNf1FWxI+zwvlJPSAtkRPUer
         fAiMuc5qn9VF75OhxC6wX6JvQImXMZBZxppaqhjsxG3qY0SoNXniGxnZFBSED6wc665e
         aTmLQt6h4My2nNKHWVOCVM7enztTyVd7g7sbCvuMGyhBj/SfWd42KjaMoXZAFsxKCOsu
         5Fm5Dq//iKn0VjSe54ya5fh/vjN75TU7pFS8ZLvbKDJ3KaqKTpblNJ51Wp7czwMgL9RX
         GltQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPToaZ4WIci0jok1NzNjDLFGGN600TiZrv1qYYCPsvLXcGGgPTwwY+AtvIcmtDBW7SkoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPTcN2AVDyKWEEpiDQt/0sxtcMbIpQxkJkqfroYJLzPIpgs8y
	dVng11tOBMZsjC/pS2yY/L4ru0xaCsPNxIZYz+Sr1sdPZcFAiRV3X33T
X-Gm-Gg: AY/fxX7YBmlX+qgIzu1toUAAjsItiWk5mltGU42AA5xhpwzsde2Y8MrHcPw+8ARW0+y
	Vt+jLF6QLyLbmwBU9mgS9eDlz/I36Hy+2LYFyOibaN0zplg+Caq7JFpRs82OxkSCgU6QqxSPu8f
	u9e9XFOj6sgL/GzueYq91XmoyiBd1kxT9Wr0auHzpnPgIo/GrRqXLQDZ9IOtzwaRRZAjx1fePeq
	PheFGBT8G7jm8SdHf6HNV5jIcKJlbqdzS3e8E80uSk7gRL19PkZBCIIcJ5nl/Bqs6QaV6cIJzs9
	uOsfTnHbGX1HEiyW4xBl4tn2gaybGecUKqNeDryReP/AYZ/wPE7hg+bFSkjqVRgDhKnjWmT4HsU
	mqj2rmDmCczTcO4laTNKlbKt/GECcPFyAbAVg7hiDig6XiWtbdkZ+Z9I8lSefjYZtOk9TjS9jdA
	BYCGPGwB1a6B2g5PSXxmPAiMhbov+IrXhwTlCAbqjsIrS7qd27qe5Bi3WOkStRVrGJJUIEB86HW
	EcDrvZLNw==
X-Google-Smtp-Source: AGHT+IFLQp32FlDGwFtHdC+fslO5YUR7DvZZslY9ga+NfFXyFjJZXUQ0MwSUpfseFOHaXH8niLJmLQ==
X-Received: by 2002:a05:6512:3c8b:b0:598:ef90:3e87 with SMTP id 2adb3069b0e04-59a17d1c18amr1346904e87.18.1766157816592;
        Fri, 19 Dec 2025 07:23:36 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f7f5sm762250e87.72.2025.12.19.07.23.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 07:23:36 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: chris.torek@gmail.com
Cc: collin.funk1@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 16:23:35 +0100
Message-Id: <20251219152335.28448-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAPx1Gvcc6P08F=HiqWOMcWjGtv1TsqeS3aR=GtzVxpMBzorqFw@mail.gmail.com>
References: <CAPx1Gvcc6P08F=HiqWOMcWjGtv1TsqeS3aR=GtzVxpMBzorqFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chris!

Thanks! I get that we can wrap things in scripts, but I find that it
doesn't help when working with a team. Other people don't like
homemade bash scripts.

It's much easier to convince someone to use a feaute when it's built-
into git itself. Just my experience.

Harald
