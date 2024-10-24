Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F51F81BC
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792998; cv=none; b=oKEcwYpNXd5a2YNdQO9pvA8zhpWNPdXjbnSV+bCOM6v8nuakG/3+p0sJ/IT+cjtUYoHJBnob0ri7N/lnovZ6NI0kEMBU2BBOcZwyzjmhRLsgVLHGEGb5Gr3xhGALp6u5OHGgBg9LdXcGjgjXdJQxvYci2iKbNlgP07mds+sODIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792998; c=relaxed/simple;
	bh=meVZIfUh2DGIKpqPYekSO6Ib58zoDkI4xZaXzYChrgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QECLctGfsFZh1lWpZyVYDOdv1qKMsRaH2zb2xP6J80/+NuBeIqtOtO9h1GsR7rgcyUNM1vromeqeSK5PFJLahT3YFJcHPpB7NHYY/ne0MQ/tqCyaNZLOLgcEW/YB2LQCcK8arCy6LJSeG547c3Hv8DX579/KICC3OySljtGrUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=weftRbRf; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="weftRbRf"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71809fe188cso788357a34.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729792995; x=1730397795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUVdEr/T7Pee2uK81CJyeY82JuFsYJZicpM0g528Y+s=;
        b=weftRbRfGIJPZXT7jVyj08r1Ww4w09LwXK4enBN5bkRt3/qQ6atfwRvQJGjUcU3kmJ
         wGTrwaht32OTHEAWqrO9ngj7/wopaZX9JCYNwHOmBzIL/hRAfj5SmFuCvhug0nw80Rec
         T7xUvHmflhWpkDTBhvPoAL1LZqc/LR6dd3rsohrzbf+/UVfIGIDBhfr/j4iPUQwebiTr
         +umnbXPQDfZbuXZ0UaLwqZSMCxdJNElGkp+JPwXQZS3jVCQK9R/DXkzdXt+VARf2kR/v
         uWrrfTjbz2EdRLHsg/LOMJCZAZIYg9Bj5EpHnS3GGHp3FYv8YqtFomYr/y+2ippPqj9I
         yRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792995; x=1730397795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUVdEr/T7Pee2uK81CJyeY82JuFsYJZicpM0g528Y+s=;
        b=BSiB9BeOgGnVnZjQHyO6nOdoEY9e81PeYOwVeZ63BgptL7PwFUcE43mzSCyF+wIVTc
         BPa5J0Ye8sDuPM1pCI/R1WqXqmsgIaHOHaPvEuy0JPiV9SX1q8O7VPnH9dasQ4GJB3EV
         OG06VkSzV2odicJ8+az/NaP7QozXkQkf9a8rCCE+4Rl8hpTODGFhf/23bCFfyCzpI/sV
         kI1kFV8Cw8HDwf3m4tegE3rMwPx4K+TvXD5FZqaK6c6UBl4dgYoTVKPSfBRts7jrtVOA
         gdWDReOHBbVkw5WRdc+F2VWfWQBshf7fJ9ZRYT9dOdjPIXxEWWw0oyPUkji5HN4az6XH
         B9yQ==
X-Gm-Message-State: AOJu0YzA1b/KPIXVB1cQ6k/q8gg8usVAR52i4FDWQ989MQSkQbRgyb/k
	o7Kani6o7UwBcFYK4ZePH8X/C2MpFbP+ZFnJtWvp1ylnVAbwmL+DlRLjCnag3q4=
X-Google-Smtp-Source: AGHT+IFTwvZjZf4M/suMlMWNPI/DXUKb7PP7BM2KBm0KzS85fnnYb1k67bNsNiGDJ65X+q9wujGV0g==
X-Received: by 2002:a05:6358:5e1d:b0:1c3:8d57:ea8b with SMTP id e5c5f4694b2df-1c3d8127644mr591255455d.16.1729792994929;
        Thu, 24 Oct 2024 11:03:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cba55asm54648671cf.49.2024.10.24.11.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:03:14 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:03:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v6 0/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxqL4MId4ah+OmTW@nand.local>
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
 <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>

On Thu, Oct 24, 2024 at 12:24:55AM +0000, Usman Akinyemi via GitGitGadget wrote:
> Usman Akinyemi (3):
>   daemon: replace atoi() with strtoul_ui() and strtol_i()
>   merge: replace atoi() with strtol_i() for marker size validation
>   imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
>     parsing

Thanks, this new round looks quite good to me. Do others have thoughts
on this, or are we ready to start merging it down?

Thanks,
Taylor
