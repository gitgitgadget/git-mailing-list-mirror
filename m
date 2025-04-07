Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA891448D5
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015358; cv=none; b=FabGLmdA74DQdryg0tP1aiYyC0MuXzJJtWMDVIvZJc3GInY64TBV+k3klvL/jRd++6s1oPZX4USpu1G/ISEN2tJsIPeRscEwT4adxHNzau7tOr4ROBLIQ807I/k/Y5hcl7yujiURDHTsCKVe+xOymS19DCdtr2BSfKfDWRMiLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015358; c=relaxed/simple;
	bh=mQYB0t3D1DK6w8W1N85kib8UY7mZJNjkoRQT8HBJSCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHowXHfCLPF1MgenT9EsIpN86wXSFLUr6HHA/3455GrkbjPagtxTiNWadkvbZ5n2Os520gA+GfwyY8HX3HD1azxS8Jt6DE8yQOBvH902n6Pjv2vnCVgRfheT/EgOkcKQxvMuvfR/7t7pwpPeFa1iHqwP2mg/LN3GotsEgwI/b+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ3n9u91; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ3n9u91"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22401f4d35aso42014815ad.2
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744015356; x=1744620156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQYB0t3D1DK6w8W1N85kib8UY7mZJNjkoRQT8HBJSCA=;
        b=TJ3n9u91TDV9bpoN7UKnrKFRiPS+66HoVcdxxrhqcovZeRealXZNT1B6A4CcHwsgTa
         t+ghvjNKCqAVU9hRha08GnjnMyR8gtNaq43X4I85lVlo3ktP6xTFSbhZnN03Gj3Fm/ZY
         J/TjxppXK/PycmJ6g71uXCiAkUZX801XV4rFl6QDmnnCSskxlhKhz2wWr7eCLRJK+nzj
         aebMrUK0ijl2vWiWQOcjgnbD2kONB51pWKNmTgC7jnvp71AjED4OOY/OFCqk8YJmITBe
         ogUFkfQjGFJ5KfVpVtlqoApd6LpzT7B2cq1poePCl9Eg20rEyu0vnwBBw/yI6UEKBi8f
         CJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015356; x=1744620156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQYB0t3D1DK6w8W1N85kib8UY7mZJNjkoRQT8HBJSCA=;
        b=Netv2co9WAnI0b59373UTJ2YuIAq3T2ZkfgQTU3KucJPEZRUFtYznRbyIEmfucZEUl
         O9bSe9p77riHOi6Ma2r4+NyJxVNN4W+i3CqM4HU+xrfQG2jXRe59DHLsFiXM1teVVK5k
         vX+IdxVYB2i0iuzPMF5GbIpfp17mlJZD9kyFM/kUhQZmXEWzY9naMihPbmzicgSuS9ny
         Wfkpv/YSEcacqL/xFD0SwIgrpDN5d8ySetv/wHE5X7NyT65GCFvua2mUvY5Ru63YNr0U
         5oxjg7z7gzxrlSZhahj9cSOJTPF622tlF23q953QEWNHjZ05KVJT/e29iJUF8We3VLYy
         nJjg==
X-Forwarded-Encrypted: i=1; AJvYcCWmPtiHw1yngwRC3GaFgTop+VHiFOgOtGpn7JsjBR2Emkjkv1rWryc5rQ81QaZXHs+82/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2KYBBrQMDN52ttWR4MyEtnqkDFXQt4LKgOHTaHvHgVoD1or3C
	XW+k+Brs5VP+d5GK7qAz1Stzww6/ts4yUFIUTOZP5QhNV8ZX8OkPLp51ixY0Zxg35g4h1u1Vkq0
	Dhoicwtei2wG2lyy3RYF/Zbs5THI=
X-Gm-Gg: ASbGncvWTbRupE/L/VYTXxd4p5gW6n7cVmN1fu36GfFd78G97G65ez/+ddjXoDxumlf
	eiNJeuXczqx68kDakwL+IWLXkhfu1Q/orodRa9ZH3juSBwVVlX5fJLBJ5TwE6cMojA4hpLdIKgJ
	ndCw7kQGnCsrNyOpP2VUFipbgHneM=
X-Google-Smtp-Source: AGHT+IHmMWKPeq8vMpgWnmDuPl32D/C4JkdlHUospe6XsIDMr+sMMrQQKWX+lVcN2PJg1N8Da5iUgdsWXMGkW8yQbwc=
X-Received: by 2002:a17:902:ef01:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-22a9545fd23mr107964075ad.0.1744015355674; Mon, 07 Apr 2025
 01:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326052602.265989-1-ayu.chandekar@gmail.com> <20250404085133.1098274-1-ayu.chandekar@gmail.com>
In-Reply-To: <20250404085133.1098274-1-ayu.chandekar@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 7 Apr 2025 14:12:24 +0530
X-Gm-Features: ATxdqUHFn8_GGZ11S8ClxxsElgUehv8FJ90VCRpPWFlriiFrWAimr-uA5BHLc_8
Message-ID: <CAE7as+bmkHgrNtqkw76myE7WVen2S5URToXzVqgnRzOWj_-fhg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_v2=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: Ayush Chandekar <ayu.chandekar@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: christian.couder@gmail.com, git@vger.kernel.org, 
	karthik nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey Patrick,

It would be great if you could take a look at my proposal, especially since
you've worked on this area before. Any feedback would be really appreciated!

Thanks!
Ayush
