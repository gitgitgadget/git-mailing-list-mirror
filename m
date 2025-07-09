Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74DD241CA2
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097368; cv=none; b=G+TtoE3TM6jTTkV2Z+psbmTDF2AXkV6xBmdwOeP1fWwhzpyiO84h4usJoe3oNRgX3/azTjIH7z6Xw64vEnF79ZmLJZiFEoxudKv6L87/Kp5kdmiPNkGx1KbOc9GO+MkMdz4ATSHRi49D7NOek5LycBktn+Ldwt2WT3/+mJk9w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097368; c=relaxed/simple;
	bh=tIOZKNjGulowdoqErRUEx72o3TijM9gp4qhRZYJ3Ads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzPPfFfkHUFQjSVBCtY2It//ZfYJrRXdkouFCLATCaYURxhH2lKir2bNO0t2bifSM0a9IERycP/uroDVtWJjnUR4LcEJlso34A/1yUrpWdpXnsaBql6fvFPTRAABwZmcZRZx3yEaRHQeR4eJJyiEIHzs8EsS7MsgFfAH+t/gk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQCW47JC; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQCW47JC"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-407aac76036so228928b6e.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752097365; x=1752702165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7/iugNtXKql69IT7CmZhu26aPSug4eAZBiA/zGNiDQ=;
        b=PQCW47JCQjqUO08XGxJP34U1nGsJSFzGguvxcSSFRi4F+S6zm9MY6MIxo9vmW61s7t
         YkJk6vekacz4rHAjcMqqFFdLmSzOwxZAmzZvjaK+cV/kLPAe48x0lfCR449Al9WQRSEH
         gKo3Ywr8w9VV2+qVF713Hd9sJog/CQvQPsfF17GRCYKpEQnTX6PXIKGk5ChKUbJfuG0p
         BMAXW9phPoqWtSa9lzrdHgIm+KQdhLbShI1RWwuKYxX59/JvSa7e3nSCmZVWekOuO0/M
         fO+UH1vR4aVR2HsYheZXwJtJUEM/7QRYUszvRxMrXsU8twR7R3lkqzEKVFSaLNnkUI9q
         4Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097365; x=1752702165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7/iugNtXKql69IT7CmZhu26aPSug4eAZBiA/zGNiDQ=;
        b=VB0Com3Fv0OGJmCWzCWZOlkNm1mdJTgH14jzJCnRJ4N4p6Ie4gj4bEh/lnXedFzyUA
         fYXZWMrq3Dw0YdU+XweZyqqWcrrTtxgm5pJU1SuvKLpqOBGJ5zN1qNynA0pjLTMejX9+
         XkoNVkDBTQwU0N34FLerrD0vyVBATFJ6WBnLLXPX6PfL5lczKHoi5EFNZm63QKiyRDhY
         jlzAL0GYkbq3aojDbhWoiIKM76b5ls11kBlQ9ruDmZ/1u16HyYXgvD8+SCmFPLdm8DrF
         e2GsNICySvi4r+4E2LtsxpbxURFJbaGaXRLwxXpn9490BSKvrV1AuDhXc4JSyTUXyO85
         +wwg==
X-Gm-Message-State: AOJu0Yxo97KRhvzmBnNE97AQxRmH/GWuhQ2S8yK4ixMoJ82HjQH7Putf
	rAv6ckIIS+fApe/PNGX13numB6dQh07se6WCUTfWkXJU6I95POx5RZvM
X-Gm-Gg: ASbGncsWROC2h0KVBN60rfv6Q9vtFstgUnAjxEFvfQvzPav87c/Yk5+d7B0aVZ7cJbE
	2ykwbfYGzxoe8xFWmQIrYnZkzmg/6wE+FVeQUGQk2GXcOeUSZRrRKcAbIlcVh0k3aA3UDssaPWq
	hMa2PIPSI+FGVdOFsyxa/omQ+CuoGqaYMOLEI0d4HHt0U/vs1WOkA59h8rg/lau4/D5wjIV1+Ek
	jcaXXnKfXsUdgw4dAfmbqHn9XXpd2GMve2O9V8GnlzgXAOjHoD8A1+2chey9CyLjIcZdhdFBnHc
	ntiaSDmDbc9zlX2fcg66iCvLYl8i9BFvScHdmAlZ6Lt+GcXII4uhPpU=
X-Google-Smtp-Source: AGHT+IFAaGY/eg5PM3yHDLuEFV8PjA2/5ZB6dhafyZljMJa66aOnjl5QV69BE7Ci1sVtOqfLQkjyFg==
X-Received: by 2002:a05:6808:399a:b0:407:59ac:d72e with SMTP id 5614622812f47-413f3f60ef8mr225702b6e.12.1752097364866;
        Wed, 09 Jul 2025 14:42:44 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-613d9f01df9sm7492eaf.21.2025.07.09.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 14:42:44 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:37:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	irecca.kun@gmail.com, Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] A handful of Meson cleanups and improvements
Message-ID: <wrbw52vfpzhewh2ocarlh3et7kkvso3n7cmy47uw2vv4u7zgyw@blc6negzqkrv>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>

On 25/07/09 08:23AM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series contains a couple of more-or-less random cleanups and
> improvements for Meson that I have accumulated over the last two months.
> 
> Changes in v2:
>   - Fix an off-by-one error for test slices used in GitHub Workflows.
>   - Now tested with both GitLab (https://gitlab.com/gitlab-org/git/-/merge_requests/375)
>     and GitHub (https://github.com/git/git/pull/2010).
>   - Link to v1: https://lore.kernel.org/r/20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im
> 
> Changes in v3:
>   - Add a comment explaining why we only need to search for Python on
>     the build target.
>   - Link to v2: https://lore.kernel.org/r/20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im

Thanks Patrick! From the range-diff, this version looks good to me :)

-Justin
