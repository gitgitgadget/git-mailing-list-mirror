Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AFA1EEE0
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543950; cv=none; b=N4cM7VR2G3u6ogobWjYC5RYl4Wu7rZi0X/yAhM18VQlE6LpcznCwDNJaD+sjkf1xmHg0DeEJXhwzrUgCwOgHM6B8hVxJdfv3DMUhiODuVgWdF3RyUs2hD1NRFTKjLJ9U/acLFxj//Q/EkDL3TfjRSyFiFHV1J9cQI2W7ROLKLWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543950; c=relaxed/simple;
	bh=enveLgTMHZ+jCLoFOGu6u1/vJzpp1nbI6rQ4sU4KoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jytip4LVbEK0cNhkYgyydTYsHp+n0crY9C0AJqyMk4fqPyGIZ8FSj9yqOcdJm155PDQQlHgIA7fpFNf6C5LBi9Qm+YWoNJ0oWjQJEkGgsVOgczXyfX5G/KL1UAdbqQxkW2GxG3uGH0Lh2TcY1xaFLzQywPgBFUjzBwk1LhfJnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lf2O6Ks1; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lf2O6Ks1"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e29218d34f8so3635605276.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729543948; x=1730148748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dRMFM6/xyVRSc0wjjWcBlzv7x3hZuyKQIoZEdHt9Dc=;
        b=lf2O6Ks1YNwFETradQjfzssv7/BlN8jKPt/U/HVb5wc4gHYA5YgJpsHuv8wGJ5qVT/
         Wsi/9ne+lObg7av0VljcXRlfkjDp+1+zRljk8M63eClLclnelgr3/F7xLj3TIou7cA3h
         WOQTX0PnzBrVFQO83Baqftb9kI8w+EETCceWHetSUV04vFnl2gK8Q3J+fIow+E8H5Bk0
         mS7ILmhF6BCmUl8epQV72O+K2rOSU3srbCO01X6f/vWLevsu3o1/NIPNzt/Qw5ppw1Tf
         2pQm/Zr6RZtBqqz+qXySxVhT/ZZ4N9jLZeC+RuPVIc37tmobfLlKDas9on8Lh5mlsQX6
         9f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543948; x=1730148748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dRMFM6/xyVRSc0wjjWcBlzv7x3hZuyKQIoZEdHt9Dc=;
        b=EJbaiwTYpSeogU50phDwh5UYo9MfYdN/4MVvSy384La5Q+Gqn0nF4EtuEwBkh2tbf4
         GCvZCO82dnAufmS9A+mn9J/FNzQELSdtTVB765u8JlPut5TMRIoVq8TJotq18xDglZo4
         uvh0k19hF72ZxnkK4HR64R7ufXxC/zcYExoGgrQxRRy13rxCeN5qkOnalb12XoJFJzO/
         Y7bwL1Zg2skNTnCBlc+inCAwDVdlsabExaN6ADNJ2vTuVvvLDMB0xTzGxFQewJgrDwex
         /O0vGJdK76N6fSwT568AW5YMzktgnki1jiL9oKP9va3Wa8HR/gbVFW1K+rSkghjWXB1L
         y2+Q==
X-Gm-Message-State: AOJu0Yzq+pZwmRrXFrb8KzzryzPGcKAzmL+5FtDkwQlGVeBJEFTkvQXl
	cd7w9GKq3jaZmnL/7cfm4rKyna1T8f0sF0fSQE/ZgDL8ZWGGpGzPhueaFC4wGZo=
X-Google-Smtp-Source: AGHT+IGaWHP6nENSBSMXGTGvTo/nj5a7tnkK2ffs2+aOlMdCTbDjHCAdocrhxahE2NeV2xLHbG1yzA==
X-Received: by 2002:a05:6902:2806:b0:e2b:dc72:3bdf with SMTP id 3f1490d57ef6-e2e24582540mr945868276.10.1729543947780;
        Mon, 21 Oct 2024 13:52:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaec385sm846722276.42.2024.10.21.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:52:26 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:52:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/5] t/unit-tests: improve clar platform compatibility
Message-ID: <Zxa/CQF3bz8PtD0h@nand.local>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729506329.git.ps@pks.im>

On Mon, Oct 21, 2024 at 12:56:30PM +0200, Patrick Steinhardt wrote:
> Hi,
>
> this is the second version of my patch series that addresses some
> platform compatibility issues with clar. Changes compared to v1:
>
>   - I've merged the CMake fixes at [1] into this patch series to avoid
>     conflicts. @Taylor, please drop that other series, which is
>     "ps/cmake-clar".
>
>   - I've fixed up the "generate-clar-decls.h" script.
>
>   - I've updated the clar such that it includes upstreamed changes for
>     improved uClibc support when we lack support for `wchar_t`.

Thanks (especially so for the suggestion to drop ps/cmake-clar), will
queue.

Thanks,
Taylor
