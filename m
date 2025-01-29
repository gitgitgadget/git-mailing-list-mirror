Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0E193084
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182693; cv=none; b=X1D4vkV5KEb7IHSts4D7Swo6Y5V8692GcBZn6aTM7s4UkGTjnjLhe6MpVfn6uZMBxj2fJGUbDT2vHkxSc8Futwc/z+dhAOIVBQsXCpc6ZlqH5j6/vCQtCEtd1x/oZdZH6TBNrU5eTwZsCMoYlk+cjYfPnKsQoZc68JtO2WdgD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182693; c=relaxed/simple;
	bh=+e9DiY80MnACVslytEDGoikW7YiBLb9makr+bGPCvIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmVa9uwa2DGjTQQ4BFB7ynV3h68DCNpnRKt/pGEyaBVHAg88XxwPXUqJimjnYZV+d1vVy1aBToXfe5pjwbVYqDxPxIDawFhmeUgxju283uXxbt/FlQtciNJF+Q/11BW+IR+JGCspbSbfIKW4+A9yjuOk9kbwHzZBLW5DOiuWtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4hcdhXG; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4hcdhXG"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ebc678b5c9so53596b6e.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 12:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738182690; x=1738787490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Plnl2Csbx7Fgv1jxTjGPiViiyp7ysODRQvIjAnFoJw=;
        b=d4hcdhXG83m97P45lEtfX/DocvdZv0lGHfcChhpRfJSOoWKas9bL0suHG/7Rmygcvk
         hq03VzdkH4QcS+MC2bWX+QFUrkd//2kxvvuRQWyi4j3lFtq28UxL653369xiXsn0OO3z
         HBGZ879mbjCTkWFNX0521kqtzMpIdc8uS5S2otv1Ex571Q96j355Cvviqv8RmjDSl9gc
         4ppt1rSCbONpCyPQIjLVp0DimKaK8hTEmy5Co9OgcC6DC7eDuO69N0KizvHQgHzDpMkH
         y3Swww0SuSvJY+Sg44dBg4JMQ7PXDl202fsIi4Ez0rNmdgcIkDD9ChKLCD7cMZWeIKvT
         javA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738182690; x=1738787490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Plnl2Csbx7Fgv1jxTjGPiViiyp7ysODRQvIjAnFoJw=;
        b=Clw1iuyj90gfIoydxradktgqUXXHS+0gXJdrFz2DFWps4qeYiLhfgxVPmgCItmkwZ4
         rudhESkoDl9YsRvCbIU9hmKI3GMmbZK7AoKqDipPXiUFd9SfcM1OVW+PDHvO00OSEJWJ
         52SHezAADBKRuCSZKNhZIXBA7pzU9Vo3O63ibHNoJKFAJzHAeF/MFg7IREe2au6Y/Sdn
         qvKhwDoIop0TZM3ZfLvA8VkNXTN9Pvw+ghvpZvyFgACBVlYOhLIVnIaOvlaVuM52SBxM
         KlQ1noCQZEyFwr59WcyIFs2VXhM9PMFZnfe30pRShKF/V9Qt0DdXfDODLfUlAljncXoR
         X21g==
X-Gm-Message-State: AOJu0YwmTPkeSVzNeuzsqWarOdMVSP8kfqrIuGV23unXP5qZmfrMlWuS
	/TOvSIsVYFYR+Hk3DzgDpx1GO3tDiFs2TsCjIlswIu7DkUcJguA8r2qoPA==
X-Gm-Gg: ASbGncvVokLtL49j58qajnlJxDzLxCfEdvXXUoYsNltcR3F0HlCAPSq6rdQDi4zlWZ0
	hn1Jxf0RGLSwwzG9AVrb1WzZiTnG5HRIvCatpRd/349dWYFzYEdlWzwZWErh9Rg2ZuObNR9LMqf
	bqh+qgG20i6D8ZYVlyBbMmzLiW99hpZE28hfw18lT1jKSDRtYHipuzCBd3WI+lCrHvK/bLFsRJR
	UnZUIgmx7u0c9s3ygixKO0k20ARRC4Z2nWoz6VTyqfuaZ3EF0wl2y++Q2YHfvqUkDRm4aelA/7Y
	cFMgaCXb
X-Google-Smtp-Source: AGHT+IHU0fpqAfkgsdtXAP/tISSw4aqti8mxPht+R4WVmfY62759QGF2+ZkZhpz3zCQgi0ekSlPtUQ==
X-Received: by 2002:a05:6808:448c:b0:3f1:ccc5:26aa with SMTP id 5614622812f47-3f323a0a013mr3087132b6e.4.1738182690542;
        Wed, 29 Jan 2025 12:31:30 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa8b540e33sm3824510eaf.14.2025.01.29.12.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 12:31:29 -0800 (PST)
Date: Wed, 29 Jan 2025 14:28:36 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/11] meson: deduplicate the list of required programs
Message-ID: <5ytcbgq73mpxqgz4vsxg4trk456c7b44x74ch64xw54agjlj74@5dd6jtifg5xd>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
 <20250129-b4-pks-meson-improvements-v1-7-ab709f0be12c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-7-ab709f0be12c@pks.im>

On 25/01/29 08:12AM, Patrick Steinhardt wrote:
> When setting up Meson we detect a couple of executables that we rely on
> in order to build Git and prepend their respective directories to PATH.
> This is done so that Windows can locate these tools at build time in
> case they aren't included in the default PATH, as we know to pick up
> those required build tools from the Git for Windows path explicitly.
> 
> The list of executables we check against is somewhat excessive though,
> as many of the tools are all part of coreutils. Let's deduplicate them
> so that we only check for one binary that is part of it, namely cat(1).
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 1e1e478d17..48eb068fd8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -187,7 +187,7 @@ shell = find_program('sh', dirs: program_path)
>  tar = find_program('tar', dirs: program_path)
>  
>  script_environment = environment()
> -foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
> +foreach tool : ['cat', 'grep', 'sed']

It might be nice to leave a comment here noting that checking for cat(1)
alone is sufficient to account for the other tools part of coreutils.

>    program = find_program(tool, dirs: program_path)
>    script_environment.prepend('PATH', fs.parent(program.full_path()))
>  endforeach
> 
> -- 
> 2.48.1.362.g079036d154.dirty
> 
> 
