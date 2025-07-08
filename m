Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E14225A5B
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006486; cv=none; b=Pp80N4oS8scRS/h7GEW3afk1mjz4GjUM3Wq1U76ZSPkouIi7QWhhfiAt6zgzfNjsQ+LSVnIDUCYKtTl+u8+cxB4vr4fh+yaWaCiahR07RhjKqMZEsXO90OKS+orCYqvu8kjYwqeQPGMSlGueSpsz9NQGcHQ8Mz0jD4OwHcIFiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006486; c=relaxed/simple;
	bh=EsHJ0IkNzE3rlRxmgSDI7ilaRjUsD76AzYHEeBddHOM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cjpMBv0tRo8XR8beox4HQr7tX/extBvgUyp5Cs0f5gyx7y8eNfgPEJou9sPWPw1D1xL47gwBaVeViWWWO1obgzXHRMx4WsEZTdEoRSr5+HxksVw7ULFuVvokSmEmBa2RhmvNpDOHMCIFGLsW+b3h18/Wa+23o579qE/d5c4AqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5q3oM0G; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5q3oM0G"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso52283146d6.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752006484; x=1752611284; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsHJ0IkNzE3rlRxmgSDI7ilaRjUsD76AzYHEeBddHOM=;
        b=R5q3oM0Gq3qHwhQyM8uR97ui/vY5fXVmNFHpAKEtfkH/dmfKTnZ6uqU/Y4towSIdEV
         2G3m9j4zjlUFcKpi3pDv7EAXaKFzIT3Fg/OEa9FaqYNb9J1CbrYlNg2f9RMCFKlvTO74
         +zs3NzMADVP9FiS6YInVYUljfdQAQST9MC11lZq2cKkO3Q6wVUVpMM65uTH9Sob3k/O0
         Vegs4xLZYq5G5kVeR/2bh3b0Gz8kzjK6GQbFKkIuzSrNMWUDHzOv5i+i9csfHBemuSW/
         rsjFxksOx/Gq0onauIf46TOaITpHdbkppTSMuurKydJgHq3CoWM8swFBReum4KtxPeVU
         +VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006484; x=1752611284;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsHJ0IkNzE3rlRxmgSDI7ilaRjUsD76AzYHEeBddHOM=;
        b=rPt6lfoI82iACkX3Pgcp+yExT6hlbJwJca5OG7/FyJAq3aVH5LlbrO9nuXzZxh1KXp
         P2poBcPjMZHMu2M2t9ZLLjdI13I33m9CCI2JsZo/J2g6V2v3ZLs1hJkzMrxxFaI9on7u
         xdk16EW3aGORVFAo7Alma+ZDOZDqAOx4kGLCR0iWIePVDKlbRfNS3VuNMd9Qd+tJ47bk
         SN24aiplb3GWyiGquK6IB7IksQfyiv4cgKoJ3zJGr2Eout1OnlvfbsTLXM9GCaDOQ6Hw
         9EWmc3mBhefeXIB1dxpkCEraTUGLvdrYyrC8VqHgCX4KtJcMwhwOySjnedL91npZj+dL
         DY2A==
X-Gm-Message-State: AOJu0YzW8ekxwY9fxtAG3guRAYG8xtmx9T3rRAkQjUcHONYi61Cc/rbf
	m3w0cBWoX+zyce+Sz/mwoPn9ioR1m5QM7P4BpO+PvDYWWsVC5mqZ56q3jL/ejeNb
X-Gm-Gg: ASbGncvZT6iw0e5X2LaHqyhbontu/FvJAAYyJxO/nT7xCrBEkVdOFBOs2CqrUOxJYp/
	F8KYTrZYI2dOsWM0arWX/Iv4qj25CcI+d2qiwtwJn0kzh1RwleOSl04jIwjHTeZUlY0AUQm+Tfz
	Tvr7Rhe9mhSjr35L+zmVff2BoFcJV4emPCmKxTEtWS7Yg26nu6s7fOU7ju6uRXEVLAiNN/SSn4B
	stKiV3ysb1hQ3LC1dxubKhv6K3T4XLroLwHtu/sy2Lp0C0fEepKziLmkxVu5pwnr0LuDOljnlAn
	/p/nymAUVundpqydm8M3T1fahwNBKDBI5k872LzOWO8Cn8xVtWWWHdgva0XfsiiGvqgkyVJd0VC
	wUpIYViK1Fg==
X-Google-Smtp-Source: AGHT+IEXWq6IROWkrMlb8eOPDTQT34r35xU2FEx6zMVFJB+Tl+kdFPE9vL5KY2CbzlIiu/9dCMbmfg==
X-Received: by 2002:a05:6214:c65:b0:702:d83a:70d8 with SMTP id 6a1803df08f44-702d83a7121mr209723616d6.23.1752006483709;
        Tue, 08 Jul 2025 13:28:03 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc7534sm82204606d6.11.2025.07.08.13.28.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jul 2025 13:28:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 5)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Tue, 8 Jul 2025 17:27:50 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <F635B5FE-09FD-4A19-8534-EC31320D46BF@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

Here's the 5th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-5-jun-30th--jul-7th
