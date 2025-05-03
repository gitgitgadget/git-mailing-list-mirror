Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D3218AC3
	for <git@vger.kernel.org>; Sat,  3 May 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746298583; cv=none; b=IeiP5PfM5GonfoiSadPLgp6U5lChZTULsOHgKOc57tdnoUjbwMiU/pw4I1BPYKa8LvDtTRS7mFZOTD3WcoKIhVVtc3U9IK4X+C2M5usIQpLpEwx3r0ajQo6Dr+f4E3d3r8p6bAmBwUhqpe/LtOmfzzTbOK7dd73Sp1HeNnpbJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746298583; c=relaxed/simple;
	bh=XYmQTanqcUYdYQPrL80CXuW+qkeWA1yxfT8EtRFrLqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RvJFe9IIrorhEmYmP8I20cukbl8uALgULT1Q3sCXE8WunFAr36/7/+89RsbuwInESZfgWVMqXxqqLQoPdIBajqsxkHwN7L4yIbzq5OjDlvci/4CPYenyChBmqkekHFasShzGLGSTP6JkNz8E4a7DcJhp5i9sWfWkh1k5WEYlfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPHwETLg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPHwETLg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2260c91576aso29128595ad.3
        for <git@vger.kernel.org>; Sat, 03 May 2025 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746298582; x=1746903382; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYmQTanqcUYdYQPrL80CXuW+qkeWA1yxfT8EtRFrLqI=;
        b=WPHwETLg7F1PyjJcE47HwyRB3tIKpuLDXBGS/jgzRWh2QiWokMpzFIq6JRFEGdfFOe
         ixFjcegUMADFChen+hppS8E9sOPhRI5RY1wXpFdWdIDnCilx06bTBhACwAjr+M1VLgkK
         W1Y2rdbMKT230AsfCInEm7d6JlJ2Pv+nn2KfHj592KZhfeFqsm3K9y6OqIRj7mO2abQW
         rm1lOivBeo2ly/Yf3rE2hu1GYql2mKqvAkKQUDnAo4sRPj4AbEvozRhft+XomdH2lN10
         h6K3O1RZG92Aa8pArCb0Z9lncl88RZV8KZNoISNbL/2ZJiXfMeMB2GCMxxNDZro0pv/x
         tuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746298582; x=1746903382;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYmQTanqcUYdYQPrL80CXuW+qkeWA1yxfT8EtRFrLqI=;
        b=FNd9ETdE0B9YN4+p8bd/GAcv1ciwCqR/OQRfPgJN/QQUivn+XawxXKp7pSnHYnjawj
         tuZWIeDTQHZR6sxqhyCrlvv1Cl8MBo9Ik41VV6fwo+bxPKHKewXJ5MQ40q4X1Nl1qqdZ
         rTwz9HWDubzJ49evAClqSCdu8yEA008JAw0BJWkSs4KTBnZaQuSRYx67t/pRurMaAOgd
         Nxt1tvfZ5o3HG1B/0OVJtEmINkQsGZ8mEJqFHIGyDoWOc7TFfCQcDcafEjdi5k5z4g5e
         tuo91gYX9XzCdVETUKjdlJXV2H6iV9ImWvBMaih4sM/x8JGGlPqVdlxSUbVys1XzyeNu
         E5sw==
X-Forwarded-Encrypted: i=1; AJvYcCVjCMOi1dBztSZ5SKVBblK/jCJ20BddR0jG0d3hjScLt4xrzIKgrVJuln/wLGpk3hcr+W8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9s6npD9UEoJzhsqeaxoDcT8xIXXLptO/RgbzTCSTidGuK64zs
	wuqI+ZpgTsdAUMGSNEKLcQZvgmks9pGOolfn1W7h4WhvY/yD5egq
X-Gm-Gg: ASbGncvwM7jK9zIzdqBWuDn3LIxAjRTVC77lcRYSd8uyoPBD2HGfvHPDg1ZnEbRAWR8
	ptcs5aoDGexdu4SPkgQ8xoSmOBS7FtupUbE5BdFoXbjx91QAY8hL0cvU+NqK38pzUdbzmybrvCW
	hZaQTAe10i8w9yV8e7bRSUjs3jM3ZHiYk28H3ogNKBcFK2HR9K0vhLRrYHkJs3vSlHvxTHu0rTt
	buk6Faxp4Pkuse+0BNw8qtAxDDPyW9XbE2h1dP63yknXxk6G/wLm9J0vYFCpXMbz2BzD/Wl7ZAm
	htGMrbtDlUqRwcnnxy9kSugfcRbzerDB8Jf11LnGdKHgcrK7jzUUb6G30+0ZgE1vm10AGpBHGgp
	+hg==
X-Google-Smtp-Source: AGHT+IGIWh53TjMk/bL/Go93lw96+M2MD8QkSU30cNruqOiGG4abU5zoSUNc2lbaVs7G66Rg3fcWCg==
X-Received: by 2002:a17:902:d4cd:b0:22d:e458:96a5 with SMTP id d9443c01a7336-22e1eae8762mr29727425ad.38.1746298581606;
        Sat, 03 May 2025 11:56:21 -0700 (PDT)
Received: from fedora (static-198-54-134-143.cust.tzulo.com. [198.54.134.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590631a7sm3655275b3a.152.2025.05.03.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 11:56:21 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  shejialuo@gmail.com,  Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
In-Reply-To: <20250503133158.GA4450@coredump.intra.peff.net>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
	<20250503133158.GA4450@coredump.intra.peff.net>
Date: Sat, 03 May 2025 11:56:19 -0700
Message-ID: <87frhlmsks.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I dunno. I don't mind making errno returns more consistent to prevent a
> future foot-gun, but I think as a general rule we may be better off not
> looking too hard at errno for exotic conditions.

I generally agree. But in this case FreeBSD only sets errno to EMLINK in
this specific case and the only other case NetBSD sets errno to EFTYPE
is when the O_REGULAR flag is used and the path is not a regular file.
Using 'grep -r O_REGULAR' confirms it is never used in git, and since it
is a NetBSD extension I doubt it will ever be used. So not an exotic
case, in my opinion.

Thanks,
Collin
