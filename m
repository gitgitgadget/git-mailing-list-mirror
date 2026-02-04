Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608D1AA7A6
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204193; cv=none; b=cMeYzSzwQrhHoONh/o3PajqQFDiABy2Hrm+N4xPAdOY/lCRvR1+mk8Wrx/R12xZMS8uTN/DHgJNhS+RWt0P9eMiXKHK02TnEjhXQN2rZ4lsCPuTLyPeAWUbu32+qhx0E/K5pOXYR7Rbc6Zi1M7/8Uu5wXzY4phNMc2BQ6RUedpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204193; c=relaxed/simple;
	bh=Cprn/AEuQ2QvxvDA8T9L6RPRlLyO/ppQhsa+0XDR4IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsPjSIG550yIThRqJFTZDuaLdTaAuag28PJFmj8Vrt9FxJLoQ+0MnyD+00udsdDnIq/vmr4p+WvaJswp3Iich26aZkOiIvTFhIzIqeYMi4MY0mSdFTZHn5gnlVB0bEz/BY0TflUCaB4MYVz+0jsE0E/vsDiD9BgpC98XlF8c5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypg40XL2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypg40XL2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3532aa9a77eso3158944a91.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770204193; x=1770808993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4xvp6ZhLRDWOf5D7BlZQyAhNOpyNdBZEkR/1PMc56g=;
        b=Ypg40XL2FjV+WGPJNqpsk47gXUI5v4wHecvYEMRJjHpg1G5F42HzIUb84VERvb3tyB
         bSeIYMVbLTGf9eSFND1GOf2mQzyS5fkpTVuRP0Z2GpFMqPaiVOiX2nEXszwug7gX118a
         gCy6rUunzZFAuMFX0cWSV02jb9gUk5M9WGDQtv9Xlzxu2oknLSmJa3Juvk+Hk+s8XL4i
         7uX20GfAxwSsmUEKJDtEvywV5/VQwJx8EJwxlyG871wk5fCo3cDTovt1UcXhRErNuF4q
         OsI2y/JssyrGXUaKOpSZEWcEK0APMMgTiWasPt28hWr5fwBPSzxObdmko1na0UaAJl6l
         0Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770204193; x=1770808993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4xvp6ZhLRDWOf5D7BlZQyAhNOpyNdBZEkR/1PMc56g=;
        b=DJDHgPnHJC8UkXmxKq2QJfbZ7JLFL2jw5MbN47khP7G4vPkGzoN4Gz+oGknU+MmeQP
         3xFxaT5DTrHzKQeOplxY9+GJ0jyg0UUmub2huhICx7QIEgrsJKPqqtZSO46swqExUdCi
         /wLbamq0JhSwEnNU3nq30CCNwRGk9Re7QrW3qzYhVtAoZ7iNRzsTaBDjaOAU0mlWRHUc
         ct/6ZpnVvQqdJCYRXKuj9C5gFzGO7FrhhpfZPeKG6+g8yPjml0qkIuwGXbEkX2i8CQI5
         NUiwka7IP95nOjxqXyAKMO/PD2yVSKX8QSOFRudgVsQqD6tayRowfA2NEe6dmlX0QRc/
         P/zA==
X-Gm-Message-State: AOJu0Yw5BP1PV4tk6SY6XV7El7TiDfS8KPzaIQ/CVoPGFMrxLcvis848
	IFI+ujN2UJSaR+eUfur/jNDwGvANsNpQq3JbiCJAmrGABZhXGA1EInXZmvMfSQ==
X-Gm-Gg: AZuq6aJCClWhjYRE3ZDJz4HsW2iDTpJCBoaMfo5XAw2gR453q3wSIyZ4BPOrY2MHV/y
	+hixBzxB/U5EnlTLfT4mislEz7gD18takrv6IH8UA6/4BL6QIX6dTb0IwX3QX3GukREX91WT66u
	bURDAQA1Wyrqf91PatxQoJBPqBn2y10DI6heYzZMIowPVINN6EIFzOXl4ykLNwKUE5zRPjCRE8J
	yDtc6PlZm5ySwe9nACHSNdkZ30XLw9sm97AwBJsarXamswmZsNPFy6BfNInrpsFAJa0gMcjnqvO
	ck+8mgjWVKtubqas/z9TqQvvqAOLdz0fw4h33P4wthrUJc1l82Q6zg0+ZnwC/NF/F9/ryW9kn62
	v3eVFRTB0fYy1NHuKeCcu9gtVNH7k20L4PRXrcla30SRX+wTRsi9LVKCUDNtTUgffU0kfm466pD
	GHBFKMjx5NY0WyoFyXS7L8mNSZmfQN10gOi1XnBXLlI8Pn
X-Received: by 2002:a17:90b:270d:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-354871bef81mr2081769a91.25.1770204192806;
        Wed, 04 Feb 2026 03:23:12 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:1b99:bc9:8a3a:dbe0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35485da2a03sm2278797a91.3.2026.02.04.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:23:12 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 3/3] wt-status: use hash_algo from local repository instead of global the_hash_algo
Date: Wed,  4 Feb 2026 16:52:22 +0530
Message-ID: <20260204112304.72727-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZS3MHhHQrD3yJfZYfaO_FRdjcXQ-G-A+tF4=e6xmABjow@mail.gmail.com>
References: <CAOLa=ZS3MHhHQrD3yJfZYfaO_FRdjcXQ-G-A+tF4=e6xmABjow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > We cannot remove `USE_THE_REPOSITORY_VARIABLE` yet, because the changes done only
> > remove the direct use of the_hash_algo and the_repository,
> > but 'USE_THE_REPOSITORY_VARIABLE' is for all the global variables
> > that are still in use.
> >
> > In particular wt-status.c still relies on the following globals,
> >
> > * core_apply_sparse_checkout, this is already being addressed in an
> > ongoing patch series [1], so I intentionally did not modify it.
> >
> > * comment_line_str and DEFAULT_ABBREV, these both still are used in
> > wt-status.c but they dont have any local instance in wt-status.c,
> > or in any other form.
> >
> 
> Understandable.
> 
> > Removing these would require a wider refactoring (adding in struct wt_status,
> > adding helper functions etc) and I believe is better handled as a separate patch series.
> >
> 
> Yeah, my intent wasn't to have all the cleanup done in this series, but
> rather to ensure we have enough information presented. You've already
> explained the reason. It would be great if you could add this
> information to the cover.

Yes sure, I will add in v2.

> > Though I require some guidance on the preferred approach for handling
> > comment_line_str and DEFAULT_ABBREV going forward.
> >
> 
> Happy to help out. Generally using an RFC patch series generally has the
> best outcome, since it provides material to base discussions on.

Thanks, I will try to send an RFC patch series regarding this after the v2.

Best,
Shreyansh
