Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357312BE7D2
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223964; cv=none; b=RXzpJFgD2L6wAplmahcStttvBwnKEs7/Xw6JXNbp3PYAOF028llZwbGWlEl4yHuEvhi7LZ9vQq6+KlBKHPrG5+dpcR4xLF2/PnX+4uHuejggzFanOI350zjy91Udupu404cyQ7Yq08K3plr/DWWkSRn25pmWDQBeloFQJGloiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223964; c=relaxed/simple;
	bh=utPOrf4gjhS1YQSY/Gf652viVjylpSuuYRzl4hTd9HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZEk8A+9R/ONYN6G6lwrQ64puKNITAyaP4pm6CDg0CJxsmtPxROTWIaZe1RhDUpDzt1KexoF9DcML1b/F1LXSz6GBSP5DtrThbkuZZg88qJDVD4DiZxVpo7s65tgOVWeRRZ+8h7n4Fhb1Zpprmj+FifNFKP0wAdIVMbJ4ha5N4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOYgmg8G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOYgmg8G"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso2629825e9.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758223961; x=1758828761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utPOrf4gjhS1YQSY/Gf652viVjylpSuuYRzl4hTd9HA=;
        b=TOYgmg8GW7LySZlSKNt6soB6hHGuaDuJyCA9cl5L5Yfc48eJV7jFOv2AAuP0lKsgBE
         OQHmFE+Kfq3TK7QIHvWvmOEVA7oFGMUEMY4Ug2/c2O4byP7EYl+Z30EBG8vw9ZIKoe+p
         u88QAz1D9pdV4Mw0La/wGkXmxVdP0sqy3sO8eJx7X2dcTmTdRMqpobo4OMA+bBcZYgyZ
         c06SsLJwwqGLRnqmMWZbwcXgyB0UlPssGDlWQnHpJc3AJVvuwq4ZDrIaKuqffJYNdkmq
         XecS4puDFkRebZX5ODXAOcAyFkIw78DHjfr0/oHN6/oQhQcQaij5ZKMJPyqd6saKFaN5
         3Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223961; x=1758828761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utPOrf4gjhS1YQSY/Gf652viVjylpSuuYRzl4hTd9HA=;
        b=Vu8VGoNvav3bEqidWf4OmaIKAHqavQnIVoqEGTxReb5txkmKLpXdMQLtjtCEUOk7a+
         FBGojRz47d91Ie798WLUqItYe/TSciI9YWTLycCHLsHQcUx55Wzew4xkIIvRl3l207iC
         ChYA87XK6YiYW85OO9Qme+OwBvOzaAk3ZYddR69OyxIapxiG4q7DnMdq8taQdhvnwqo5
         8r4oTPRCUFLju+HneEIlGkzS9tquQg62nXdrkkXiWjby23C3XmTOEViKXZhxwfsR2Mf6
         /u6bxZfLWircleZbney2feMo7m2WuTlDSL3Cgr7Faq1K/bns4zViASvJE+907gOHj+qc
         +g7A==
X-Gm-Message-State: AOJu0YzkyWSWM7P+Q2x/cmBqL8vq5zTahiBc+NOsDxxxNAJqVj/SRlar
	PeirFxULVcXIjR94LqgPq6sNtmNiN5l8gDGp+su2TNZpqZZ95ETdOrCO
X-Gm-Gg: ASbGncsTR8RzMhoQ2IpNyeGPpn7m+q12QZbHp3Es7M7ool8SyElK2ocyz3/e+xDTBeJ
	K13m6sDarWYPrGVG3rtBtC1uVNxluf+DghmmrBoHoxTDa8rncgaeJntyiyn+CRYjDvhTnomUUg+
	seMTIVfSUemiSXPSCzbns0DeKSskdvR00FYGgk1CC+jl0p2Zp+MGS/lVHZeo/NrAjBRkkPyI4eM
	K55J3XP6e1OCIqg7aa5VN3JfTbjXohYBjuC/V6IgqFXG5Daxycum+fErutTWNUw68gZ3KVD6k4l
	ZxmYsdTbtO+31iTJ1ybWfqRv3jR1SoB+0ElCt3XV0Otai2fb9M0CViiWU/NdGIpimRz1AvCd+xz
	AdiXV12IqEMGnx3tRHcZ8Dlb6zmrQqpprIFMz6yeNEqhrCD6IJlyzpcVz+aElktM1GkY=
X-Google-Smtp-Source: AGHT+IFebgGbOTc5iyADFXrqZK1utVKCiHnVuezPnF8x2DlIDNMDtdBd4UtjY+3T21hNuaBDlh7I2A==
X-Received: by 2002:a05:6000:4008:b0:3e7:41bf:e631 with SMTP id ffacd0b85a97d-3ee84ce6a37mr162020f8f.6.1758223960966;
        Thu, 18 Sep 2025 12:32:40 -0700 (PDT)
Received: from desktop (s176125235115.blix.com. [176.125.235.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm5096513f8f.3.2025.09.18.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:32:39 -0700 (PDT)
Date: Thu, 18 Sep 2025 20:32:37 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [QUESTION] how to find options set by scalar?
Message-ID: <evxbvwwyo4p4iboc4k6r2cd2cvlnm2upgxumqopdijwmvhxhxs@7xvg42heibp3>
References: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
 <aMkVqNbdgxqBJ9K4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMkVqNbdgxqBJ9K4@pks.im>

> But doing this via comments may be viable indeed. A start for such a
> change could be the following patch, which causes us to write a comment
> "# set by scalar" after every config that we set in the repository:

Agreed, I think this would be very helpful to have! I'd be happy to submit a
patch.

I was also looking through the list of config options (within
`set_recommended_config`) and thought it might also be useful to comment why
each those settings are recommended in the context of working within a large
repository. These comments would just be in-line in the code for those curious
enough (I think it would be a bit noisy for general use as comments within the
config itself) I might dig a bit into the history here, from what I understand
it started as a separated project[1] before being added to `git-for-windows`[2]
before being merged into `git/git`, are there any other bits I missed?

I see there may be some relics from the history that may not be generally
applicable, e.g. setting `credential.https://dev.azure.com.useHttpPath`.

Link: https://github.com/microsoft/scalar [1]
Link: https://github.com/git-for-windows/git [2]
