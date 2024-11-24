Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EFEADC
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732446672; cv=none; b=NPU1BXE0n1z2UTp0iwIA02XM/oy9Ouk/FbfA4dra17t3ciq6izNhbHGRHFLPFF/xxY1sOQUzGYqCs83qb6oly1oBBvMO/m7z2aTDj7++I/v9np82ZwDYZsbScQcEzYnQvRsD9VNnZ3EBqVe4Qgo5A7Ai1D8fjpjWVeYgecSo4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732446672; c=relaxed/simple;
	bh=KYrxmCBO8kf2kaiUZt4gvZRIxBybmICzYBk+EKsf8EE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=ZjRAjJUmDyuRXE8Z68xJhCC6YzqlXI4T9jER5L+ZQXakgluLowKRN5bVihc96WeX3Asb8Tli2YUI3Hnm2Gj1wU06ht46BxfiYDpCSBgvMX45vfNZN6Zq/JJIy+R2QCkK65fy9a3zhf71ZOvcku7skDmQlW0qt58o3Thc8YHRfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggbvkJzF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggbvkJzF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so3084014a12.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 03:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732446670; x=1733051470; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYrxmCBO8kf2kaiUZt4gvZRIxBybmICzYBk+EKsf8EE=;
        b=ggbvkJzFNevd3Zt7Xr8irobSkVGte82/yAoI+w3APJ7FeyodKLQFM5TATbCsDOSVDi
         dZcF5BRPPOgVc2pXy08836wdGImt15odOteKm7xzf9JVAI9akOaZeYv/DenPNxOsLWpQ
         1oIJB2XOKEOWyXXCfPjJfLU0UFmSP1JYeYmuSYewQOjyc4XNP/abEMZFoB37quy11Ywy
         7CEqe7krOdmrj7D0hpUlUxiSximk+dsX1G94umEGqtdKNNdmGavcBwQdrQjunrtWihn5
         xQxq2o57WOKJqPMJX+/v+Px4hbkFXkz4AhGhwEAWK0TqRA8suxSijHU7zQ1uqL7dK1tL
         FZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732446670; x=1733051470;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYrxmCBO8kf2kaiUZt4gvZRIxBybmICzYBk+EKsf8EE=;
        b=rAAclfJA28ECAk+9xOUeSMZuJwofNVO9MhFTHYqYXAtXTELzWxT4jaYPL5/KLNubk/
         vddT8Z7gWCYgBNJj6KuQE8LYEDMsNG9sYxeo7HzQcRxyZY72CbaW4GFQaZ7Ob/dJSR/h
         vYmrW6aCsGZ/LaH954MnCMZU9z/mPADcmgQtFW2A0oQ55r8eq2eCqvX0CAKm+gv3a7Bi
         bsVGzE6uaI+IP1yF8a0ZvjNt1SlwgOEgAX5xnQluyRuaiJhKgEK/lLyZZruKUeGWlhuK
         Lwgzfz4x29gwdEtbgeUHCEn/OSKMCVysxk1MsJLj02oxwPfWABmM5Ptv/ugDmLHC+MrF
         7C7A==
X-Gm-Message-State: AOJu0YwCmOI1jujBmi4nMRSKO+OrzVAvbAAjL1s5IPqy4/ODZsMJqaMA
	6F6oyFcD+tCYz9o3TL+141f/Nw9ZEEX3nSuTkKiBc7XaM/9jUja9NWuohRPuXO95gg==
X-Gm-Gg: ASbGncti2mPW+GD+ZFnxfSadRVftkBw+Jbxsu20PBjL4mBYkADYceQUMAoMN+ugtcz2
	aBUhiT+XE+zN9plI99CdwMnLLKm5cyX2X5L4Rf7RGCywSyPh/62agYjnaRXxhu3udNUb3gbCJFa
	CJfNz0+oeFlES8WHfbDkEnHvg0bUvVUf5cWioqiA48Nx6MhfjM5brGU2PfdOSUvkU8svYJQk7Hv
	wko7jG/SbsPtwgdY3Pcv1SkyC2ldI27X06vzX5/6Cia6egEZumEzaw=
X-Google-Smtp-Source: AGHT+IEHghVBfXfqK8EctAIdaEBGM9CX2dONui1XIhaMIqLpENbgjzPT7YSR5AlcaD4YJXZzCKyJ9w==
X-Received: by 2002:a05:6a21:99a0:b0:1db:def8:45fc with SMTP id adf61e73a8af0-1e09e5ac944mr13815173637.39.1732446670537;
        Sun, 24 Nov 2024 03:11:10 -0800 (PST)
Received: from smtpclient.apple ([128.1.201.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724ea9f4f8csm3598800b3a.124.2024.11.24.03.11.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2024 03:11:10 -0800 (PST)
From: Homyee King <homyeeking@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: git clean --exclude broken?
Message-Id: <1A13EB2A-6075-4CA9-855E-B72ACDA67C0C@gmail.com>
Date: Sun, 24 Nov 2024 19:10:57 +0800
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

13 years ago, Todd Rinaldo found that =E2=80=94exclude option is not =
works with any options, for example, `git clean -Xd -e=3Dfoo` to clean =
the files/folders respect the .gitignore rule except the foo, but in =
real world, git only respect the git ignore standard rule and not work =
with -e option.

Today, 13 years later, the problem still exist, so I wonder is this a =
bug or should we clarify the =E2=80=9Ccorrect=E2=80=9D usage of exclude =
in documentation, because it=E2=80=99s really confusing.

The discussion can be viewed by this link: =
https://git.vger.kernel.narkive.com/ulppacPK/clean-exclude-broken

Looking forward to your reaply!=
