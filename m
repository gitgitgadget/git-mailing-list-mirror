Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F37219E8D
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637259; cv=none; b=rvSoIoiN7XLXTXbSMg0K3PoUHSDaNb1bNKBLsf633xQdDeJ+w1WIlB45hJqru4oKo89v2I+SRPwgjY5FQZGMzW7f+jM3dsmwAt8hUfvYLHRhOkhm1KOWLVlpHZ3Cf7nQlS5o3yeRPMjrzKDdSEtmTry0346x3v0aE6HAKQCrvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637259; c=relaxed/simple;
	bh=CPUeHyu7sWFXlBhQVVgFBnIWN3LDi27vHRzzwYvFN5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgqk+fPTxFdRUZd34q21MfX+PMtqecx6XqY+R/DMC1k2WTyQ4yy/sERb1r74XlBkr/V/FnJUUcclObzDeKOKRM+cLyUrxJmzi19URxrXcwGpxirRBWRIPP+ySUiq9t2NDbvC73ArjVUFaCzc/VZLdzXOtxRYefR3qJGdgI1JM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI8xtLK3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI8xtLK3"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bf3e02db4so106729b3a.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754637256; x=1755242056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPUeHyu7sWFXlBhQVVgFBnIWN3LDi27vHRzzwYvFN5Y=;
        b=BI8xtLK3IxraefgOfqAYisPzXiHQEKw52KI/rXf+FG6PgCMWeLMpAuJ8H9pMXJuzc8
         /pqATtqwYnnksAQUhOMHxXIOm/T5/zblUvK2XDstDpigTg/PtA7tbWlgihGRedqKMHOs
         KALqxufANV1GXDC7tbA5wE5Oh1bqym7Q0+EN/mij7lQYW3z1gWwlclWFXKcWN9bVm5MC
         zZ25NZCvFHd98FSpqgydSEr/V+fjI4dhOlbRV8WSxdtQhZbN3Pvr8AeAQCW0BkJ1HKZ2
         sMVnSHa4vsFQETNT02I3vvQczeE9iUksXlD2EgULdYmLEBPfwnMNYgWbZk2RR8cCyHLJ
         KYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637256; x=1755242056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPUeHyu7sWFXlBhQVVgFBnIWN3LDi27vHRzzwYvFN5Y=;
        b=BVAvX0jv/vXNQU4m98c9Pjyo4kNCXWSlG/d7TkgZcvwcICy9DTknEi3gm0ebxEDYP/
         9Bce1k+LuX/KHY7u6h4NvrPZGfJFW/1uzNg//MjRuKYYvI24ED8bybxVEX0wYfb/XYuZ
         tduESx6NzVL0Sk5I7h/B5QuKt18CfvIKZxegPxW4GNYCzOKL5yS2glcb+keHlhumY0EN
         o3dP0zPuj0jNeMvNi6cq5VMFc5940n4a3ONZAWaXBrCjHuDUX+v+Endup1GQ7bn4v0C8
         +7e48EwtAi9HBgy1BMBK2YL/eYu4nKzm3wqLdN2B7YGjPoiHX5o8Umb52G5rMoSySjDU
         KfbQ==
X-Gm-Message-State: AOJu0Yy9QChF678QW+IUMPU6TKWmV33VGoO84ph4JHHzR5eXRGi+wpa3
	mLVbrzArqQWHe7J1jK8X47v58tz67E74W3q1KcQZDQ8BrGjkyYJ9j16B
X-Gm-Gg: ASbGncvjtzHcUfbQ9As+FmvC3ewYW9VuGjJ5RT2zAFd8Zmsa9yUUxueoMB70YQSMtkR
	KqKOcBo/MNFe9D+6OrlRUcoX2a3GUvhC7JwvgEPy4CiMf4vdjFRCocj+X0ZdWl2bmSDfyk8FJ8O
	FZnRoaotQ/o2QJTq+7FtonwhCZ+RsEdAECFC+xcDV6HeZtFqyOjnOTR6YDWeuODAr5/l+FDXich
	c4n0D8gyXr6sSn9VL+8IibqNucuoiU/hpjbtph/f/ayRhRh21k3lHg2RSaZIBMy2QpyziyePuVo
	woHpm7LXVQfkR05wEX4DGE+ZoyfNtwPEBDfLasIfGq//OR27uGjpPri5P7Op9pcd6G+7+AoBVVw
	BgjRN1ycLHDSHs+S3/iWAQGd8kZcuUg==
X-Google-Smtp-Source: AGHT+IFS9SekYVNakf5NOKC7Ylp6zgaf5VCt0VVKCd6E891R7WgJIpdagaP0SuK5rgWk04C3RZnR/Q==
X-Received: by 2002:a05:6a00:3988:b0:736:6ecd:8e39 with SMTP id d2e1a72fcca58-76c47bc3457mr1072813b3a.2.1754637256376;
        Fri, 08 Aug 2025 00:14:16 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf531sm19656785b3a.92.2025.08.08.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:14:15 -0700 (PDT)
Date: Fri, 8 Aug 2025 00:14:13 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] remote.c: convert if-else ladder to switch
Message-ID: <aJWjxbiyQ0cuiQku@generichostname>
References: <cover.1754455931.git.liu.denton@gmail.com>
 <cover.1754627874.git.liu.denton@gmail.com>
 <ee6d69bcafeda9d8a2cdfd1f8bb62c28c13941f9.1754627874.git.liu.denton@gmail.com>
 <aJWOcDN2LZaMzaqH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJWOcDN2LZaMzaqH@pks.im>

On Fri, Aug 08, 2025 at 07:43:12AM +0200, Patrick Steinhardt wrote:
> We can't remove the `type` variable in this patch already -- it's still
> used by this call to `BUG()`. But we can drop the variable in the next
> patch, where that call is converted to `advise()`.

Ugh, that's what I get for rushing this patchset out without doing a
test compile :/

Thanks for catching that. Another patchset incoming

-Denton
