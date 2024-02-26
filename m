Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC41CD06
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934178; cv=none; b=O5Hgo1TPZtTjkPnHHP3X2TbFh33MnlYKYqyoQUIr9sdiy9m9rFQezPG1p3Mbrpk/Irben55PdEf9QHAX+0WQMkWMkUOtNyGp5PZ818B51Cuwhwx5qPtpzBXDu2+sBLpBFAeFm5Lz6O3LQmOVAydB8eQuFWeiaq21aeM0Y+1Xssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934178; c=relaxed/simple;
	bh=8P0LDSAGBpCqremKVdORIdUiZ9uwcGyltpOpnpSSaA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAm1HUzoFTSRMLgl1i9SWpO6xinEp+4enUALHUEkx+/+y/d/KQxp9PjmNrolbohPyyVCzFGAqrp4R7ICz2YVSLgmJSNCMOdt3FVPdvBRE0INDgvwybbuRH2Kf3C9tyv+OrPhz2TAdgvsD4I5JI1CYcDT+98dpWDDt6K9mlOqosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmEqXubP; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmEqXubP"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d14e9d4d0fso231361e0c.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 23:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708934176; x=1709538976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8P0LDSAGBpCqremKVdORIdUiZ9uwcGyltpOpnpSSaA4=;
        b=cmEqXubPy5vFWsYXRZveW8Zt7oVrwlR/X7aJ5hFfmIwdegcelXny/E/U6GtoqPn8Hu
         +sA+WXwT4fLHnISDbzULQt5RrX9ODPbc+qUBLzMyVpgK5SNYqEU2LoGlLjFYrcDtonDK
         HdxvtZijZowyenkGe07quBdaxmYxy1R43N6n7mviBQNmvGkg/6ZwYuyoz9AVAk5c4rph
         H+Kst4pCbIPsTa5CN1FfEvNxcfp1jiv2ayvO4OqYkm4Q6nBKUt/9MbspMpN4qsHCKFTQ
         D7rVHHia2gzwbZNs+ZEZSnUBlEJT+p+ohxfg7HSU74ScPyIiiGb5MuYy/38CAhDprlCP
         OMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934176; x=1709538976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8P0LDSAGBpCqremKVdORIdUiZ9uwcGyltpOpnpSSaA4=;
        b=FF2rcrZuN1tf/GEhE8HhTG81jeJ55v4TvSOTRZmBbXrA7623J0id0Xwc0rkm73oa2p
         xRTRY63QkzigOI137OoQoa7Ds/05Whh33F+K2bYYWpRDMNIN5WxSMwlD38kHlDf8bA4s
         DeTxYurJU/+SKi3GsDNBYfmXhdsS26ZCX+iAZBn0a6JCYYy1E2Nr7Zuss2QQDh733XRN
         e0ttbz8rH1OkClEF8MVHVII+HGU8XkWPRfkkAOqQe99+gP9RSUc3mBq+8XyeskwRgN5m
         AhMNTdl3VSvbiW6Dg7Ep751JKpX78LDk8hMjIHBhE2DMZNfFZLvRG9m6SnBGYCp7c7f1
         jP6w==
X-Gm-Message-State: AOJu0YzzL+WdTE7hUJoMHuItxruNaQGQd5tZAyeDr/GEsBy1CWtbVx+L
	bf3lpmepYDTA8Ufrg5H7ucl0IFjwEJO2ATLXOW0TKIyCuv5qjI99MH6nKL/J4DCz2c+AF3K5QQR
	4MRJpAf/sZVKQa5VLbl0ApbNeNmmGvdCmBf4=
X-Google-Smtp-Source: AGHT+IHxzffkSaSLGk5I0T1Ss4RjIpG0GUdeG9E4JzwHuGsh5Eh+53sfz8yxcw4sWypPnIMAT4Wg0EsFkfraI8TX7to=
X-Received: by 2002:a1f:d345:0:b0:4bd:32c9:acb with SMTP id
 k66-20020a1fd345000000b004bd32c90acbmr2676769vkg.7.1708934176009; Sun, 25 Feb
 2024 23:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACeVQwQ4MELjB8nZyeu9QDTtgwhhw0oOsL8BHdm_rxTj1vMy+A@mail.gmail.com>
 <20240226072248.GC780982@coredump.intra.peff.net>
In-Reply-To: <20240226072248.GC780982@coredump.intra.peff.net>
From: =?UTF-8?Q?Pawe=C5=82_Dominiak?= <dominiak.pawel@gmail.com>
Date: Mon, 26 Feb 2024 08:56:09 +0100
Message-ID: <CACeVQwRkoJejrWvym_BAZE-OWi+q3RZfyEpwAwA+0hGUBCeD=Q@mail.gmail.com>
Subject: Re: Bug: diff --no-index with cachetextconv crashes
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> OK, I would say that this failing is semi-expected. :) The caching
> system works using "git notes", which are stored in refs in the
> repository. And since you are running "diff --no-index" outside of a
> repository, there is nowhere to put them.

I have not mentioned this specifically, but my goal is a general diff
command, which internally uses text conversions, pager etc. as
configured for git.
It makes sense to cache the textconv results when used in a
repository, but I don't think it should fail when not in one.
I think the default behavior should be to silently skip caching in
such situations but produce a diff otherwise.

> Of course any time we see a BUG something has gone wrong. What I think
> _should_ happen is that we should quietly disable the caching (which,
> after all, is just an optimization) and otherwise complete the command.

In my script I currently disable caching explicitly for all drivers:

keys=$(git config --name-only --get-regexp '^diff\.\w+\.cachetextconv$')
config=(); for key in $keys; do config+=(-c "$key=false"); done

git "${config[@]}" diff --no-index --no-prefix "$@"

But it seems like something git should handle on its own, so that diff
would accommodate use in different circumstances with the same config.

-Pawel
