Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE731E832A
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224701; cv=none; b=h/pdfc4qJyYH6+cC7ki5YtjriEB1ndxBl89N4I59Lfuk19XsqcycmpiFb+Dg9QilDtnnrjDWjGF618LEcXW9yD8WzHJeBNDgwE0unWY3yC7rzEdaNv3HAqJKqvb1lumgF6EzeFQ8Sf/UacdxVMXQl3Yqh5GnwIIIh8knIYY2Bws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224701; c=relaxed/simple;
	bh=k1WLmvJsf/5a7uzOTh/1/MeWuQflCX1Ksj/KIVwrNH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJ864UxIqdbROCsFvxuWCdsmPOpJax8V+HC35uT6eRtCnTtM1njfV0NRj1HXGga0sP7ncpd9CiAn5SHZk3f0KMdrMh7UsXoG5Q6+ESuaGKW5s3qWUbCLWK/brZ3HZ3BRtHV8Cmx6lv/EzGDWTIocDsnNLRT/4ZU3gRksUUv/DfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEg10mPR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEg10mPR"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so6967599a12.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 12:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765224698; x=1765829498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1WLmvJsf/5a7uzOTh/1/MeWuQflCX1Ksj/KIVwrNH4=;
        b=PEg10mPR8Iu9DqbiUQNwPU9V/bSrn5nMRBcuiS2R5bAaysGIUTvKNGac6DGp/f/svi
         VvdwMos8DRtPm/pfbxx0IJxUxy7rJQ5ELwp+kqzR+kvYwixZOAiMSN/UlHRVc6ZvsJRj
         6ekF+FFwja9ZIO4cjeJX9JMpT8IvxiXO5sTZg1WO2JRhDQZcZLerQNJ1YQho9dectamg
         KnJey83V/Nq6LNCWeM1AfJNp2cHJRavFlzUsULZj71qMivlhaahZyhaR+h9KoQ/hTxul
         bG2jww7KgNunCrdUj63VQ7CKDZBI+fP9gLdlY3+wrSlM701lu6gH8TJ1wWfy1jq0qkLq
         6SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765224698; x=1765829498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1WLmvJsf/5a7uzOTh/1/MeWuQflCX1Ksj/KIVwrNH4=;
        b=LX0JWSA9XjiGwDad2urzLng7jNEUwE+XtngBG+bBhW1E+PMgZXtQ5yT4LltA1Y0OTa
         DX8+lu68Ih6/Y+IHjm0RwfcX+f+/Telb8vQzdMZvtgUbXcbOFLYx2ziyCh0EL8euk7aX
         NMCOlxZMo1eq2r3sJzZ+2a8luD5K+0DK+4eufwDrczI39cB9B8sohU8Sa47GQt7+tiDA
         YVw8xSbSphOJzsHzAz9wPcwSLOYozcQ5fyLFwEfsFMQ0hypvbg/RiOdRCiXSEjqkGP9M
         RouDV0El3Hu5fqm+tvfYHH4Zgj0HrrD0xUCgFakvHbF73Y+/SKl7sEUA0h0Dzqx7XD0R
         1XGw==
X-Gm-Message-State: AOJu0YyEp9TIoruhoMztGMhkHBJwVdCXau6GmDVbh1ZFC1wqkMa9qTBT
	kf6imqwHMT5eKwz+T3sN45N1ABags6fbGqCbizq2JgZUQb2IvAsoXMXe
X-Gm-Gg: ASbGncuB20tibzBhgVj0NgymHIXfOsYpyl4VFLuro30ScI/Efu4NF//FZTD7RzFS+FT
	lKElltIV3hVqj8Yf60E1f1NMjY/s2PJkEFzMgTn2nzN1fEG/FpQcNEJy5VceKS093U5Phis+dni
	GEx5Q85ZnN83PCM7/u2+S6krjcVHgcLowuUfDMBQ5vxYHXiXf8WKiqq+aHJz2ikywdxvh3X2WIv
	6RAxoEaRLIjuT+vVBmIE8R9oGwJ7Lq5NG1h/ZS5b+pEU8D1KeOxHLFr73Q9k48+Cifzma4Te0w/
	osJbjsUQL3/QjLSbazWqrcVMlFNr+NcFyOC4PAkR9vQG/JImj+PNEDM1GTSz0kkAYwHnpTUnhM0
	xUm1msN7iPzQp0MA3X5hdUDACdNprrO8N+cv67Ybq2mdnpyELaYAc4v8Dh36WaZOcYtBfgF6WKb
	EFmnBn
X-Google-Smtp-Source: AGHT+IHKVCfHqgf8tL5Nl2zUQeCkiQV9NOPV7ka6jLJYZ+b/4etKHz+dG3E+qNuID626UH19uqTNQA==
X-Received: by 2002:a05:6402:26d1:b0:649:5ab1:7bbd with SMTP id 4fb4d7f45d1cf-6495ab17be5mr516411a12.26.1765224698354;
        Mon, 08 Dec 2025 12:11:38 -0800 (PST)
Received: from ubuntu ([105.117.9.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2edad10sm11626791a12.9.2025.12.08.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 12:11:36 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: ayu.chandekar@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com
Subject: Outreachy intern: Request for the completion of this series
Date: Mon,  8 Dec 2025 20:11:32 +0000
Message-ID: <20251208201132.40186-1-belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <CAE7as+ZROO1GiEhXYga5Nqmrs5Xr=k9zsAiP2y0xzuny1ws+UQ@mail.gmail.com>
References: <CAE7as+ZROO1GiEhXYga5Nqmrs5Xr=k9zsAiP2y0xzuny1ws+UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello Ayush,
My name is Bello and I am an intern for the ongoing round of the Outreachy
program for the project "Refactor in order to reduce Git's global state".

I would like to commend and appreciate you on your previous works done with
regards to the project. They provided enough guide for me in my bid to continue
where you stopped.
I referenced this patch in my proposal as a part of the
patches I would like to complete to kick start my internship.
Please let me know if you will be okay with me completing this patch and
submitting for review.

Thanks
Bello.

