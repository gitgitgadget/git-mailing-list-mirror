Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982E212B2F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338307; cv=none; b=rpRlJ4FzeZd15PM/kKgbdrAHQf5ZUhN49DPThehWKwIG9OkIHX0DH3DTwnUiEgrFEz47ONDlTY0aoupgp88kgirifG9fXFbkYxgpliodZ7jKIRM2f1ZuCfxCZiVIfz9rmLkWwVu/NzlQW9FNHmiT3u6Mwac9Pudu8y8iBN3ZrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338307; c=relaxed/simple;
	bh=KjEHqSGctYq+Qim6ps01Q2RpZVoZr7yhKwxOPQ67nTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqCWoc4azKq45kHKuIpNAsPa6zy9rHS7zEqdNdpTRbeVFiS4iGP1udDjYaM7DGPs1kdkgyRipf+T0OtYYtbPmXV0Ea4mS+IfVbYTP06ii8ZtXMVFHMyybWgfkPzljAoDH8btTI4RQaoFAbMvIRDDXOGNal5EflyHnYEC3Ty2L+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok/eP3/x; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok/eP3/x"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32d9f725f68so85114a91.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757338305; x=1757943105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjEHqSGctYq+Qim6ps01Q2RpZVoZr7yhKwxOPQ67nTk=;
        b=Ok/eP3/xKdkC87tYpn+lFTi3etapzJbxMbASf1IN5pQoi8PT/Dp4zDcGV9P2j3nSBK
         OXIxYXsLLRehe4Z5qhYoe3Qp5FI7v/J0D/mAan3cDiy7jB6CIaTWftMfwaQ3rnGq5cRo
         7hJvAwxFMihhgci3bJJPxCnqBGh0tDDLvb7FL4A67q/06S+INI3mZrBUg/EIN4VxZTF4
         J8cxunyikqSnte1OXDF9N7bNojOZUHv0qYhHirNy/P11vJpCEhdJfPRnabM+tVS9NIKb
         ucjsOrQrlYNoRhw0TiRgJ1leQfKTJ/++mC8FXeX4bb+sFY+HVKFwItr/QfnR0oxNGxNn
         7KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757338305; x=1757943105;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjEHqSGctYq+Qim6ps01Q2RpZVoZr7yhKwxOPQ67nTk=;
        b=hlV20V8b84JhyUlzIcXJ35J/ny2+HEc7IzNVxvqDNH4lQcJ0hg3ceUOwkjlxmlWn2a
         L8/Z4BE3OVkF+RbyWuySTRpepOjOQK1CnCKQAEzmBP8l0L2lPncqVlDgT0Z9JwuwcIAM
         TbMWfuNwLU7zH3FjorwkUV5sbLwVttWtEE5N+exKj5nSDCvM5lQAyBRk+IWZmNsH10FE
         QNphCcydGUjni5bx+x5vZB4itt6WUojJmCzy7RRW8HfH/Dv/mxigNLARC86bZfsWAUz2
         OyJupauvBvjWuj8BlYC0msGt9TH3P80daFx2D/4Rs1LpMIqdKGeFcqbC+FJjFF2C6bV3
         1XAg==
X-Forwarded-Encrypted: i=1; AJvYcCWhgBRsvJt9E0wmZ+cENKs6U8R2ChngEW2s2qZ1mKAnanpsLYeCI4mOrDToXqmAakUxtAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo3F4dtOJx4OdiEQ07cGaCnvceEzB4kYwcZz6SvME9AcvOup9
	4TmAdv0pq9ElIGPiTj9Uvx5ew9cym2b5i1Np+ZyLCNEWjTOPewx9lrbDVaWf9Q==
X-Gm-Gg: ASbGncvvNgoabutRLUwjZlGCGAgK9snVQ5YluCdFm3Knf62zQsP6TfRqo5WIhwLuoe8
	ulKbIReGqOLGkkLyTJ2Z5TZrx9Q/nCViVvHh5D776vOGKKTSbb4M5ln3ATGkvyw2ZLu+DmGa+cP
	pLukqqz46odPNSibZws03Ub63KdtacMU+pPclJ5B2lMRgjBQ3ay/UoqDdbn/djBdNxWrf4hxj7n
	dZF/ddMuCv+Ma6j1ico4No2O+wdNK8cjFQXgZ+kGCj6H2O31x3GbDEnLju39QzdtligzsSYB0EX
	nQNCd6o/Kjw0b5/alm96BbUjsLgXHNNoVgKZO9pzOGHiIJbLtuXCc8fE9HNyn4CtZNVgB/sG+J4
	obWNBE6qX/RVf1+naFW8gTdbn5XGnBHMqBKGAXm4Wj7SMzqnbZm/TaDmiXusYbZv68C00olQ=
X-Google-Smtp-Source: AGHT+IES24lDFe4wEvjtGEflpDiOhuqYta0v09Bz6T7NKb3oNTFMRFA/8ypzemPQc0yJoekPUE321w==
X-Received: by 2002:a17:90b:530b:b0:329:e1d0:3bf6 with SMTP id 98e67ed59e1d1-32d43ee2f03mr10355827a91.6.1757338305238;
        Mon, 08 Sep 2025 06:31:45 -0700 (PDT)
Received: from Seonghyeons-Mac-Studio.local ([220.94.153.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1cfbbsm26509376a12.23.2025.09.08.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:31:44 -0700 (PDT)
Date: Mon, 8 Sep 2025 22:31:39 +0900
From: Seonghyeon Cho <seonghyeoncho96@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: aLaz7yCXWGG2_oP_@pks.im,
	Seonghyeon Cho =?utf-8?B?KOyhsOyEse2YhCk=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] add-interactive: reject malformed numerical input
Message-ID: <aL7au7hI_zuI7bhW@Seonghyeons-Mac-Studio.local>
Reply-To: aL5VxjPSqfXbnY7W@pks.im
References: <pull.2044.git.git.1756553495661.gitgitgadget@gmail.com>
 <aLaz7yCXWGG2_oP_@pks.im>
 <aL15aTmKQOsNrF0D@Seonghyeons-Mac-Studio.local>
 <aL5VxjPSqfXbnY7W@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL5VxjPSqfXbnY7W@pks.im>

On Mon, Sep 08, 2025 at 06:04:22AM +0200, Patrick Steinhardt wrote:
> I don't think that would need to be part of your patch series. But we
> should have proper error checking for `strtoul()` if we're already
> improving this code.

Understood. I'll handle it too.

Thanks,
Seonghyeon

