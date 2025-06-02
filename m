Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3C198845
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868112; cv=none; b=ZmnRn8g8kmTiyv3zINE3tXbSMifxi1gVkEN5Qhljku58ES5HgVX00HwRtQw/jStuuOZRA9H+Xcm4a5otcKBHteWT7Y32Znc87bI2fKKTNkWf5olWhbQtqBTU9hMdQqdi2zQ9OQLpC9vVV3wxyLLE7skRrFJwcnn1UGabEZPVo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868112; c=relaxed/simple;
	bh=8lIoVKG5XqpDgCU0xMxU0JWXVpOUnI6nm4Rl/DJ61JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDHmJFgHMmi7nk7YhIqmKczdFnjPAu/60eM9OqACAWcR9ZYvrWNBwWA83AZSeC7QmAQrHwhsFY8xZ0XFBFrQA5ruTqNSoovjIEn+zZ5kxC0EsFMR9aiUne5oH4WezwH0jJainvyEQFmzHknSCzkqdfvx1PrR6GNtBwNTPED3IeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmzckWfb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmzckWfb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23526264386so28931515ad.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748868110; x=1749472910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYNynGY6vi6FvKjYnNJ8LJgtP9106wM+4x+ai0PtWxM=;
        b=kmzckWfb76hotT1wRHncsIvyi1aWdXVaWdz8yTZJu2YcluoO0F4lY69QkeaX8L55bE
         Zp84lzSyBJR33nWjc3LW35+KGCRtQgS35Q493MtKS+Dv9NyubUtc9BAcQV4f+eBIQC2J
         xnEE1B2IM4TBA0+ENuuv86bk5kWD9Q2uAJ5YfxLSEM0pAbUo/EGc+h6HMq4V4J/oViWI
         YXwPwCvzJT4pc5L4sSVQJ0GjQJjtNk5Ko3aKiWboHs2XwB5udgFCm7WMLWFgPfJB5Ndc
         PDIaLMog7Wy889KQhH17a3idTytsCKdbihq10r4bfkuKUb45ACA5r5xb8/PzNbqgT+m8
         IduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748868110; x=1749472910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYNynGY6vi6FvKjYnNJ8LJgtP9106wM+4x+ai0PtWxM=;
        b=h19HK5K/yizLH2ES7gy3sVrYPK/ojfdMpFw+XwheHfO8c6pjIs5THbwfCfpzkiyYBO
         sQarUd1c1emCmevw6r7GQrRg3vWwlcc7ozKiul0Xj9r4TF7yv5/jb1Rgn3jgeJUljcKb
         e9H0KdZMnEP3OB2Eb0CZs5D7WMx1iCPnJtyyA8hChgoP/uiCsLwOk/Tqflex3Lb0wH+f
         C8auuwJ5c7oYSqaTVj2P3d0HAPFCSYzizEMAKVKIIJROk/6yza1ejXw/sS+eXmB95wjr
         gSSo6bjn4kvySjHMv9EkFmDlMs2Nsy9fy2T8llYQAlo59aWc1JaIq+T19fSAQc/e6voN
         F32A==
X-Gm-Message-State: AOJu0YzF6REACxomm/01fXk/Da0YvQvHEbxFTAxq5Q2QzJrc3/13t6qE
	RGawlJNNxZXhwMvHlD7wc932oUYTH92v51Dmsjc3MNt43PxuHmULPJEyDY2mvj+/
X-Gm-Gg: ASbGncvNOicDY+n291y0pivK13H1/kNW0NXV695K5FVEZ3ZrrgEvfzIrrCOvaRe8qFC
	hMcmZZAV7RmAFY2jsfIOyYl+JVlc+tzhmdpTM0f5ZkDewKhiz/SiJPw8ypTmwBJ+pko8x++IFtc
	JlPTkkC0LNDPpprhQW2Gwu8xjHPUzA6yir14d+xc2ZGcRsh/CBWjZJrOp2LacKObxmaf7Tf/DKz
	uOkUT7uxRZoligTc0YlCxTd5CuJznNlrJphFf0BgRf5TjFXEPqpuJVYajHPPJ94mvqWI+IjJBiO
	QiLVR6I3bT36nwZJ4riA5D+leo1aatCYKDkcTpIviC4nX91A4dJwv9LvCA==
X-Google-Smtp-Source: AGHT+IF/4Z8MT/jCue3XkD4JpdmZMh7fVU7bt7ziqnFwKnFCnkdU+xVcCO+vWWBLsTM23Kmny7adfw==
X-Received: by 2002:a17:902:fc48:b0:234:b422:7120 with SMTP id d9443c01a7336-2355f765533mr104037135ad.9.1748868110131;
        Mon, 02 Jun 2025 05:41:50 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506bd939asm69987645ad.70.2025.06.02.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:41:49 -0700 (PDT)
Date: Mon, 2 Jun 2025 20:41:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked
 worktrees
Message-ID: <aD2cCzBlyW8y9b7e@ArchLinux>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <aDp55upE6AhYunz7@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDp55upE6AhYunz7@ArchLinux>

On Sat, May 31, 2025 at 11:39:18AM +0800, shejialuo wrote:
> +test_expect_success 'no refs directory of worktree should not cause problems' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +
> +		git worktree add --detach ./worktree &&
> +		# Simulate old directory layout
> +		rm -rf ./git/worktrees/worktree/refs &&

FYI. I made a mistake here, it should be ".git/worktrees" but not "./git".

> +		git refs verify 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
>  test_expect_success 'ref name check should work for multiple worktrees' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
> -- 
> 2.49.0
> 
