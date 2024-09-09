Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988F22095
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890811; cv=none; b=XDw5BpyJEPy7GM+rgF4ag65OZdW+n9B37+z1G48fXzhDYfOQzNpR7ajlEmG6Bq9aKKrnjpIfdKeaVOJa0q9A3RpWj8D2OzPsKJltHNxT7nW2o3bmFwlusELYbaUsOeZlVr7M86yH1GLGq4KveDxZ16DD6rDvF++clxKfuXW/LgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890811; c=relaxed/simple;
	bh=RoyC6xmhV7vbLFgY6BLRwHe7mdBEUP3DxZXwgYWzDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRwqAEdnwDlyRuGDomDVi1f8/Q/eCCUIwNEVwvCVGt8BqyPYaEB+Gp8H/7tY3up/vrq8UygGfYkc0wqBFB9W/xufmiAO0rSul8hZ9Uq++bketRMT3EWYYV9ZdrVbu3NS9Pkn8t9w+XMB1TtvnxnB0KLfJfMoSTf2UBWtz2AoKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljUwmQ4v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljUwmQ4v"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20570b42f24so51621055ad.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890810; x=1726495610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xj1hdxqL/BZ6nB14PmhMhvwvNQYS8J274odw/hqF/sc=;
        b=ljUwmQ4vyUJuDbxPfEZH32Bzp/J3xDneO4vKBGX45arF3mg/VAAFTcasbxbBW/8RSk
         oifh3WLTRm92xMoAyT+nG2HtBzFaI2dEM1F8mCL2PKfbSVXy3/52+F6TNd97JNpqbdv6
         ZUQ24v3Dvrvw32jOJVWhExhvcLb4oUx/tz8hTEtLGX/+2odUB9VsUwufjYPmqNlzA4IP
         GjVb5qU9tPIfyvcgZmoNNGei5P9zrwH5vnmN2Ditcv9fl0qmCA7c1NCoindQNatqhx0S
         sduD/PyiHcWLOlUHQvtd+XKoAPRr0F/6KzUtjIXXmxXZhR+1OlwZy80OjwGJ0q0VBzLw
         ToyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890810; x=1726495610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj1hdxqL/BZ6nB14PmhMhvwvNQYS8J274odw/hqF/sc=;
        b=v7xQTeEtv+Y5gx0BE5bDrIOTGqYgv4pUbEQ9j41EOt82lgy4y//Zn4bWbk5otHZexc
         hJVNdLCJ2V3p2jt/ouIXCb2+RlzGCOJejmKYlDB2XQx1hjLyWgxadVqSdNT/fVPwhZiJ
         k4ELD4HzIgZTZdovB8kq9mlTjBbRPTgxi9tLY/c+28SwtSvVm/FiujprQIHOUFBiVA20
         JA6F7vnlmiM6zaBw1LmCpDrzdbgzKA7Xmx5tp3viZ1kyO5XDuliX+rxCceARdaKKp+mM
         HM6T/+OK2QXG3Jm6RRfPbktbleCKiQxB0RoJdTg9ucBIgiY3Q1ERwtAblDUeJF+oLYIa
         TMhw==
X-Gm-Message-State: AOJu0YyQ8btsVEpSZ4SYJMxga7Y9OZmJwLGmPmPt8EZpqrHoPh6Lfob5
	gAJwA6ghQXPgcsy0lX5Chs8W4o8cpPafS9k9xTmSM9aEYlYfYqkU
X-Google-Smtp-Source: AGHT+IGcsX+DWmau4CP8c4qMyd+XQXiXchJiDY0icir7Iw28LOgXxN5oW1TQWJcc7HVwbgfkGsZ+0w==
X-Received: by 2002:a17:903:32ce:b0:207:6fb:b04f with SMTP id d9443c01a7336-20706fbb21fmr54242075ad.17.1725890809409;
        Mon, 09 Sep 2024 07:06:49 -0700 (PDT)
Received: from localhost ([101.228.98.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eea9dcsm34398435ad.153.2024.09.09.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:06:48 -0700 (PDT)
Date: Mon, 9 Sep 2024 22:07:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Sep 2024, #02; Sun, 8)
Message-ID: <Zt8BN7fmYOSaDoeK@ArchLinux.localdomain>
References: <xmqqed5tv9eu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed5tv9eu.fsf@gitster.g>

On Sun, Sep 08, 2024 at 07:38:17PM -0700, Junio C Hamano wrote:
> [Cooking]

[snip]

> * sj/ref-contents-check (2024-09-03) 4 commits
>  - ref: add symlink ref content check for files backend
>  - ref: add symref content check for files backend
>  - ref: add regular ref content check for files backend
>  - ref: initialize "fsck_ref_report" with zero
>
>  "git fsck" learned to issue warnings on "curiously formatted" ref
>  contents that have always been taken valid but something Git
>  wouldn't have written itself (e.g., missing terminating end-of-line
>  after the full object name).
>
>  Ready?
>  source: <Ztb-mgl50cwGVO8A@ArchLinux>
>

Just a kindly remind here for reviewing. :)

Thanks,
Jialuo
