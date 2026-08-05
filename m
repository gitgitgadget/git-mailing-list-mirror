Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A516A395
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966544; cv=none; b=Bm9BW/pIzYpdwu6dOyGyw7AdodIsBeY4ISlOu9CJo9Ft2gazBf4AaduyME+LqbX84Da/btjfzD1utSmvX+TU+KDi2oEK3hzBK45xckwSiMyZ4aGO50hrWVseSqHxDNnySN5M6ZsYlzfWKpoK3+YaDxflG9Fyrd92vxZFyaQbaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966544; c=relaxed/simple;
	bh=cF+gPRsqhJECt+tX3JKLOvmZSbPqDfXBfD5/ra7aNDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSsM9e7i7GN5qRkPG5AW7edol9w9KkFRb7HtmG6B+nzzfryj0Tu+BAprLfGhosocd+7+e/itBB/JqkUulrptcgO8HT8f+jjx7CvzgqoShUH9N310DOLO+qMneAUndboJ3Bkhmnus2yvxzE86+WfWXK0hzTbj3FKzWQuS1M0cBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UB0AY+Mz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODq/Icgu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UB0AY+Mz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODq/Icgu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D2B51D000ED;
	Wed,  5 Aug 2026 17:49:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 17:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785966542; x=1786052942; bh=rVGuwj3Cub
	Z2X5Jhj8rPyOJqsvM3jqEn1l4t2tucw64=; b=UB0AY+MzMjYI84IB0nEA95VGiY
	b9U5BUoc4/nSgIk70+1yRqd+F/S58vefI/qTVgcOj6ZjzBBB7NLjSfb12WbpLQDA
	hUIsiNFYVt26ldxm0L31Sk8xt13F8yuNnsr7W74C+On435E3x0kexD7yv7KULi0W
	dNzZG00uJbGm/m65WZRQgV0tOn/NMAfARp+0+HYTIencCgK3cJTdKcON1ceb4yPE
	GPrtJI3KEp+4VcLAr4jd8qvdWtx0t8yH0CBX1Kew1R0HV2avW91icR5Nl/u2Nju/
	9ijMVBGq7Qrl8K1vzYJB7u/NzdSYg1ffFv9mjgX/AIAF5uRi1z+xOtHKiMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785966542; x=1786052942; bh=rVGuwj3CubZ2X5Jhj8rPyOJqsvM3jqEn1l4
	t2tucw64=; b=ODq/Icgudzb0uiI4aAdtFY367LaghSaLmH8+ORAjI0qsZneGdLu
	eG28RvzCbdojki9fqsIeUuSCtHbXQ65JBWLsrclwjWyP+fJjnv3uC9UxNXw3yp5V
	VbQWQqeMoIZdqOuvyp+51RBYTz2f/E2hOa4ZWl0TlKQm0g2EXYrL+USPRuYKcAbn
	4kgjKXvlizVO+QCdFEIPcOKzTtVIhrOXHooMx0fgZob9WVajX8euiCuHSgYrZFfh
	n/EqtJK4JZdJgS5gAfqsZKABdBBlvreP8k0IkX4BzdiCPoSU4OlK22iWUUKM9FcS
	bbrkWOnc2aGkK2tZor8SKT3tnXNIMZ+9Cvg==
X-ME-Sender: <xms:zq9zaoe3mvRqg6i3mZooKQURn5qNijOGHFRt61O0oZAoe0kSXWzOig>
    <xme:zq9zat6vqGBWEE25okMvj7O2c9-Jy-mGVJjT-4-Zq-F2SbhUqD2WyXeGzKK6TPXX0
    9Gfx5P9LY2aHC1phPeHB38Wkz2h4TDdtmkbyDs5SdBvvnaJj3GscQ>
X-ME-Received: <xmr:zq9zajWwP6NNC7VOTh0lvaLw6XNbh-J3rPvRACEkRuM0zwMDLXGAqwPDcrnbKXwy3xCW_h8z_BHZ_MamF_vY81C2XMad7W9kqQ>
X-ME-Proxy-Cause: dmFkZTGFDXqgLlizQo6jqw7qa51SvloN9oxQuKsOaMJHceOzks7fQ2l8dnMxF/v2A8yagv
    gaRHtr4BjrHq03KX+ShiTSUDxvklI6PMiZxzARCSdRSkhpZMW2C7x/I5qa5FXAHacQH61k
    5RzV13BeYTV4oKEONJTOzp4MTGoZq64va1J+CntBgArmmJAmR604Q6atuPfe7MpSpkZJTx
    py2PGt9adeErsGXbRGPF8+8GKiDO4ocQTOiIp4ecZN+FS5g2Th0OBl7khV2KxVbtSo923j
    AKE7FYfAivqhl9Gtnvg5JCTYT3gKnjd3MuVNrQsD7V8N6+KPRau/e4+Z7OhhxpPA7obrav
    n+KkO5G+4NtKYTH0PsgMoKqkc3hAQl7YG5j2VMkw9WRzSfTrMVyjcmiL3mkK3NkHDhEjKD
    U7CKbDe2kTZgi0kHJXBYPnj4lICOwjmvqQPfl0jjugkqgrBtB5O0jia4OCNsNBrJ6jH/rr
    pYNSW3rN5Wla7cm+5NsNo8XfxmShAgxSQ0zD/mM4bBwFEfzq9R2GqY8/u2UIwZ/AhrlxQi
    Yiuv91TqFun+XmTTJr2ZvogaebfKzOSVxf/wURSM2EuUyDGEYzviNtX0HGHWmR/GUoiX3O
    768giRnkah/akTomTbWegnKQduGln4B/bvgJZ0y+kmDJZPD9Qxn0Fm6/XkTw
X-ME-Proxy: <xmx:zq9zak4UNwXStt5LJ37WNNams-dJlGq6imJWbk6arhqj7sT0yLhnwQ>
    <xmx:zq9zamqID3ccVaOQRHM2YDrPEXz8YWrblh5iuF6Hw0jsJy_yECXtJQ>
    <xmx:zq9zavlvFONvuTpovr3sWWRZ4lSqQCl90RLt-KlSIGLbuEtAvSdohw>
    <xmx:zq9zaqPZ4UFHH5gNJuWwUYycEbOTErIXc7kYBGT7lHb4jAfPU_uFMw>
    <xmx:zq9zalKAlvAF87eZez-iXH8Agm_LZxzXhm9S3uivGfsTenGMl-d36H28>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 17:49:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH 1/3] environment: simplify repository config getters
In-Reply-To: <20260805115342.3939931-2-cat@malon.dev> (Tian Yuchen's message
	of "Wed, 5 Aug 2026 19:53:39 +0800")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260805115342.3939931-2-cat@malon.dev>
Date: Wed, 05 Aug 2026 14:49:00 -0700
Message-ID: <xmqqjyq4nsqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Drop unnecessary parentheses and NULL checks in repository config
> getters.
>
> These getters are only used with non-NULL repositories, so the
> extra checks do not match their current callers.

OK.  If repo MUST always be non-NULL, even when we haven't fully
initialized them, then not punting on repo==NULL case like the
original code is definitely an improvement.

Looking good.

>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 76ee65e62b..f5628b6758 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -119,23 +119,23 @@ int is_bare_repository(struct repository *repo)
>  
>  int repo_protect_ntfs(struct repository *repo)
>  {
> -	return (repo && repo->initialized) ?
> -		repo_config_values(repo)->protect_ntfs :
> -		PROTECT_NTFS_DEFAULT;
> +	return repo->initialized
> +		? repo_config_values(repo)->protect_ntfs
> +		: PROTECT_NTFS_DEFAULT;
>  }
>  
>  int repo_protect_hfs(struct repository *repo)
>  {
> -	return (repo && repo->initialized) ?
> -		repo_config_values(repo)->protect_hfs :
> -		PROTECT_HFS_DEFAULT;
> +	return repo->initialized
> +		? repo_config_values(repo)->protect_hfs
> +		: PROTECT_HFS_DEFAULT;
>  }
>  
>  int repo_ignore_case(struct repository *repo)
>  {
> -	return (repo && repo->initialized) ?
> -		repo_config_values(repo)->ignore_case :
> -		0;
> +	return repo->initialized
> +		? repo_config_values(repo)->ignore_case
> +		: 0;
>  }
>  
>  int repo_trust_executable_bit(struct repository *repo)
