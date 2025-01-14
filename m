Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032C20F996
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852507; cv=none; b=kMKO7Xt9nPJcUaiCbnbvUmBR+nuYaXopN3BlfHnF797cPDun0CUlz0+tEJ8r8a/u8/eMXvTmlGLjO9+J4Aw7Z+5gfW24fFxRikX5xorxBtepK8viLYenrHuE/kQXTfeELJjAzlHsvwZcoHtjjaixKqXBn0ovOTo3upG6t9DX/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852507; c=relaxed/simple;
	bh=GxhKjA38fxBNFvtC2rq6pw65YvM27ds49dF0VnPuNQo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sxgLLigiRIH8ntEtjcvEc6FYmeJzxwkKWOXH7DMBFKDrw8sU27wH2KPpyW3MuqL4ua7rvOaStDcHVJyVOp05PibWhpuB9ZD+1jqwIT20Z2mx6KIGeuk5gnLOWhJp7ruf7N/97XxW46Onqr3Ox4ycYaQxArjLYIFyYHDWJ5YT4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3DOg2ZE; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3DOg2ZE"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5162571e761so1827806e0c.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736852505; x=1737457305; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxhKjA38fxBNFvtC2rq6pw65YvM27ds49dF0VnPuNQo=;
        b=j3DOg2ZELUqzZe+WiBw15f76e6MkqZsSplGKeaVZ1MJ4ihf+RleMnB745ypJltk8Aw
         qfjLabScbPv2xNOoXlnvKKt3qr66BN9wQzQU/TISbf+SW1VgggweucTXa5gZoFo//DCX
         rza3wBPGmstXX2l6Gt/wL54b4vTaxkhYpmJBq1R1VAjzlUKxlHdl3gUIb7qdNnCrQuaD
         WkcIV6P0FT/mQZ+d3nc7e4KeKMSY72iL8eIX9PWH1FGCO4Y/qexQsfUISa8AMQ/novWH
         sUp8q+lKDm3CKstTipmwfSHDFgb3Dv48PaXWMg0tlTWy5Ak6CrcyMhfLdFEP/iNiy2qT
         03kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852505; x=1737457305;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxhKjA38fxBNFvtC2rq6pw65YvM27ds49dF0VnPuNQo=;
        b=OK23DuImlRTS/g/ng7Kfl8dlnJUt1wUVrS2WLgKsmcd1xrq88IiLAATvuyQROlI9rv
         cTagAtXAWkiXuJM4lq/QT5OmhzgOj8bdeB1Mjt54MARVbICR8mWVQxVe7SDEMEvUjd6X
         ONFT96vcHwKCFAOA0HXXNVXLRAD6t2u/mcuoyEr0fzw5M3MgeZxCQ8jgDpne+Prg8NuV
         o4fcjUvBVUbSqQyvWleSf3OnRX6RpchHm+jbrQjFhCEYTA4zX8laFW61g7IcED7jz9gX
         pfyA/tB2CGwhn9TEFLJdr5FmQKYNhATb7A4wIlgM6G8Uc7J0WRnKiu9zsYQ9xaKSeSGo
         t8YQ==
X-Gm-Message-State: AOJu0YyrfBO2W7jT+LMUgwe2vKP1hU81Qz4+6fPCCGG4Pujfzx66luIk
	BfUoKuMlRr3zcDtDYAYZarh59HdGMbBVbsBpj2/v/+XB24+0Vi42TAWBojD1bRmAuCpgXuAp+NU
	HVmh0reCWjD3qCGlMUuaPpinXo7UYQg==
X-Gm-Gg: ASbGncuxTrTrEjOy/eSHfmjnMBGf0vXC+YNArdAl2fj0tR+tl2Gs7bfI4sLDVCFvriA
	MpgnRZdnrDOy0x8KR1ln5vLDb9a0oP7rrTKsrlQ==
X-Google-Smtp-Source: AGHT+IE5+QKZtsaUoOhsDJxMNUKDPze8RU2pr2udU/k7+fVOxhuJX1y/hd9xpR0dAmIvFjS71w6Cz+MH9UOen0UbxO8=
X-Received: by 2002:a05:6122:1796:b0:50f:f21c:4fd0 with SMTP id
 71dfb90a1353d-51c6c522a97mr19445992e0c.8.1736852504824; Tue, 14 Jan 2025
 03:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: tao lv <thebookofunknowable@gmail.com>
Date: Tue, 14 Jan 2025 19:01:34 +0800
X-Gm-Features: AbW1kvZ0w9nfWeNitOmvL5O-9RHtmgUGUB5cAxqkof873TdJNKTU3Ai2DUu-HAU
Message-ID: <CAFePT4w4hHZnS0TXGA6-_sA-Vp4f3H_sY2Ue1XreFM3SEM8i2g@mail.gmail.com>
Subject: Feature Request: Allow `-` as a Shortcut for `@{-1}` in `git diff`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I would like to request a feature for `git diff`: to allow the use of
`-` as a shortcut for `@{-1}`. Currently, `git merge` and `git
checkout` both support using `-` as a shortcut for `@{-1}`, and I hope
this functionality can be extended to `git diff` as well.

Thank you for considering this request.

Best regards
