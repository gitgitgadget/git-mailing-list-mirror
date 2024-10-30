Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3791E00A7
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323367; cv=none; b=aZkh5OPBSkdmyojEmkOt1+Z7AVskSauRzMpqq3NiRgXI2kmmB6+ewPdQRHk6zTQalrxv2J5YUGU9oshNOu8yTzuf/WibL0HKTs5tPOwcYjHWxcVT5TGYXq2M5X14J7q3TyDZW2dVzL9DWoZ8BhBrOxdZa/gOZspgsMN39QN6FQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323367; c=relaxed/simple;
	bh=SCLBJ5ya0oLmcyKEqVrypm8l2yzUL8EzogR2SKowApc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwMLiwCD39h8I2in2Yu9LdhG6jM4PMEgi38fGEu5EKugH4g2hRJq5q1bNE6KALTbWmeQ6z2T3b9lzC0p7s40NL/jCUBhBa8Z0Xw0y9WeW4rTYhc5hq2VKexy1Txp2RI9aJeyxn4GbJzQhDZe87KGTlxM4XXRju729SAD47EKaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhu00Wjo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhu00Wjo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8ac50b79so19655ad.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730323365; x=1730928165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8DdCAJWWLXpkThh3UbdyfavH0MmpA0iC/1GHxBkhbQ=;
        b=zhu00WjomBvB5F3V0Ii73hyPnrCyT1RD8kyTuCvLWknbB3QRWql/byTG5NCjejsRQc
         1nrxuPBHE60q5k5v3/IGV/pV2kBFReWZi+IXYCGwxVlRp8aVhGEwO3kE+EXiFAZtI/nk
         rB9Zb3P269rhNrROCf+0sLUTMeHHV7a1Ww03+DXSh8SuBiriRtm1gCPh6h1VrAPB64Qw
         D3K6tfCAiMPy9ZnDrX5uzrltNzfTy3tjbJuFUNY9N9HO3+ln/JkB8tuQesvW3f1jg8i6
         dTBqKateJ1fl1zy3wwU7H8cvg1KQfBqO+/1cL5Bwq523kWnP647JOrIqBMG/ZBkb+zXb
         n1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323365; x=1730928165;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8DdCAJWWLXpkThh3UbdyfavH0MmpA0iC/1GHxBkhbQ=;
        b=dFJnCBcPyxyGj71tSyJfhj/qxXdZvdGkfgoQR4gRg00r6I8p3Fqd66bWhbBZicKzx5
         0Ol9YRhiUUJ8QIblwQR3leAIprFIQi11hzSEYzX8bIRiqURlGXY2y/SI+oz7+ZQsBVDB
         U7WWwFsCW7sEvMvGt++JA0OQNuenSZZoG46QRh8oUhN4xTsVHSKLxyyh6ybR9L/b1v7u
         5D4514M9ygFd0PuK4zogxdWmEGz0b9QMoHnDfQAlLgmUrpEQbZyTIRPqxwNhNHp3ljE5
         RgYVV5W7U1cBFAVvvxBfBRnQ7ldVwdn1fEW3b1uL/d8RZRBQ7X8tizLV8LxJFusf2vjV
         civA==
X-Gm-Message-State: AOJu0Yz/fMGfsKH8VPpPNiKhW78xJ/YcbSvH9c0xtcf9SJhhzJm9SeFf
	JPzsQWxqgLC6r6igAke2PivKO5DyrZnjKXHZ6yESs3vsFKMorMn8FttTmt/V6OaN7UTNlVq6sJX
	VHw==
X-Gm-Gg: ASbGncthVT164on3p4Wcdb2KK7IAUdEeCWc0I1W/KJOs1oa0H9pv+pTj3lAOeZOjPaU
	szbRmLW1R3vIXFskrPi/vT+zUDQMTbUHmLKgffi9Wk31RaI84BK0XiYoBbIKNC+wfRNBJJrU5zA
	j9ZqF/+SmN1LthBYvmB2h1VPS/9hur0YhUT4FWQMGB5V6LvlqWBPEGu/QcaY9ts75wwVim2+qjz
	dTXmCSH5qNErCfSOJuhowoUdBPhsecE2QZIKjzF9I5iVkR9
X-Google-Smtp-Source: AGHT+IHjtrzJqkCUorz2t/Fp9rnFJiSs7+4NPytCx/3MXqzJ/1YMD9vUdmRQV8uizm25eZQJWVoptQ==
X-Received: by 2002:a17:903:41d2:b0:20c:e262:2570 with SMTP id d9443c01a7336-2110428835bmr922455ad.8.1730323364709;
        Wed, 30 Oct 2024 14:22:44 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e2cb:194a:36bf:6b07])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm293715ad.249.2024.10.30.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:22:44 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:22:40 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "fetch-pack: add a
 deref_without_lazy_fetch_extended()"
Message-ID: <ejrw5wyxianyz5wkwvfw4dhssg23lmxlhgbo7bbzwif742uk5j@rni2fojw6py7>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20241003223546.1935471-1-emilyshaffer@google.com>
 <cover.1730235646.git.jonathantanmy@google.com>
 <4dea8933cf05a5020da7d78c088f4b091100952c.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dea8933cf05a5020da7d78c088f4b091100952c.1730235646.git.jonathantanmy@google.com>

On 2024.10.29 14:11, Jonathan Tan wrote:
> This reverts commit a6e65fb39caf18259c660c1c7910d5bf80bc15cb.
> 
> The commit message of that commit mentions that the new function "will
> be used for the bundle-uri client in a subsequent commit", but it seems
> that eventually it wasn't used.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)

Nit: can you mention in the commit description that this cleanup
simplifies a later patch to detect a case of repo corruption?
