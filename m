Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC233382CB
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768048086; cv=none; b=eobIWPAKWxxG4KafsyitPPit4/xPAjaEp4QsMpiyK3kw1x2+1jzeVBohZOWPzJAsGjyfqC1+npTYq/Vi9QU0I4Fbxf+PjFiZeFYXbkFWRwy11LLYl1nl+nDjuGP50k5Yc/ED5iRevFzOSwfsDUWYGl1byXkt05cpg28skDjM1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768048086; c=relaxed/simple;
	bh=/YTCUqRMPSuPUBPFGUJgzZcftmoa6x8KxyoTzjaySMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie3G69VnuNhwu4mbfDRkvyPX62/6bddb1ebOiwvgYd0dv/uGd4yM2teEwdFa8xKlf73GnMH5DhASXSLTpKNrdyzE6xOZHkRpwHBF8IwXQXjVZjiCTcY27k3Xt5V9zOGx3JuXKI+IdZl5RbMen8tSc9v5tnJI9CeC6LdyIYMJfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTB3JJH3; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTB3JJH3"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-121a0bcd364so5381409c88.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 04:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768048084; x=1768652884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSUKL2UOy6VKQvPTurLYgpxDQd88nGyXAbBEMJm/w7U=;
        b=QTB3JJH3wiFnjeEA6Js6MfmX9zoXggtxfqqgFv3/+lU/HmM/XkU3u9I5Nl/Gdrrvby
         z/WvgmxCczgk7G1VIwdd9HuuwOCWRZbAmWlNwkrX5RdRe0Z1fABDTpeG7l+9u1HKCJqm
         RQpKj368in/Tx7B7OErB7P5Z16mN8crOOGR7xaFgWE/Dv04WMeWbqMmGQNl/mk2doScc
         dwemC+OkLcIjnAuMcYXona5fwiuTGcR3yUsgRwerGRWXKI1PbUywEnsskNyB50Qk4/yj
         +DHdhGAm1v1px9i1dnQW+0bEk05xCSGp2CY+gGvYUE+J/8w9ddcfkz0Z2KMKTgITJsv4
         mrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768048084; x=1768652884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSUKL2UOy6VKQvPTurLYgpxDQd88nGyXAbBEMJm/w7U=;
        b=p+WmG/r2G8Asafk8ImAxp6jUJMTntbMe7+SoNF0IMNKU/zem2TgWTACNDUXYwFuVcy
         A5ZHx5zqqXJwS9GdsdBteuZk7yTwLz9MYL9YyiXybtCiPaEpEEPvp9s72Kn1LxVCDn/K
         R8NT3rFR8LFX+lNIWzwVWRDd5d6dxYGjn8WvcM68r7OfS7YzM/phJ5Q2XF7wmSSvQiPF
         ZjX4zx7urzoFg8qp0FL/XFw64gan7PY+jpXJOzg8b482V9eLZX74d8WfmWuKjj9uPk/K
         Kn/kXVPORO5opkWZ86NXjDaW4CVWGRlE1Ib6Gj84oPmYsyewVxkOrVmx7yR/ovXf1hNP
         uRYA==
X-Gm-Message-State: AOJu0YwnIYhGeki4WxKrw05eh5oGH0Uhn8VK22Z1z+28Q9+vKaKhdGIX
	kkWNJkKUcclyaakNHrNBtwjw6YtcgrLSe4UXB50oQeCxTcL54O4ZJnJw
X-Gm-Gg: AY/fxX51TYOAn3FU6oJV3nhVGiwiaHkH3CMTNU28/q3rW59eLCJAd2/k8UwriEKC0Ay
	/o16R9UfN3MmyuoI2WnyPfO2PryHnVY9G08jgTvw92rHTWo/wV1lH5N7LgdQAeu7FggMlpN4tu7
	JFd0abN9/7poN8Q4jz+waX/3812DMAT+Y32X6B/44dQkyLIMySF5k2FA0J4S/BzWC5XqUREymu0
	OyR2U9H+PoE5SaLgncsgWotnGySpr3uCkIDXzESwcmpFa0+m+LkwBveKzDPTyI+baRsPh1g2FCB
	3vZ8v1SLF0D6tBHiOoBoaIGArEnuHkhrY66wlPh1tdTm0N0XcICVyEJ224O5BPSo3hk1JOLjqzF
	z9zTHPucl4mDEATkxb3gwtEK7iFY8llWKwboYvpOnZdYM4yChA450O0+gu3cp7mKMOUEbpwTW/Z
	0aaGMczMzU+Tc7klp7
X-Google-Smtp-Source: AGHT+IGcjwraFYLAE5XKpdrkQ360R1OC7YHrIoPC2HTJ8sLwjVorIA4SWaGvZ5qnlGy9cttj75Y6vg==
X-Received: by 2002:a05:7022:112:b0:11b:9386:a37b with SMTP id a92af1059eb24-121f8b929c9mr13042305c88.42.1768048084135;
        Sat, 10 Jan 2026 04:28:04 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm19386921c88.4.2026.01.10.04.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 04:28:03 -0800 (PST)
Date: Sat, 10 Jan 2026 20:28:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/17] refs/files: simplify iterating through root refs
Message-ID: <aWJF0NNDnuIUXbMo@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-1-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-1-3587dba18294@pks.im>

On Fri, Jan 09, 2026 at 01:39:30PM +0100, Patrick Steinhardt wrote:
> When iterating through root refs we first need to determine the
> directory in which the refs live. This is done by retrieving the root of
> the loose refs via `refs->loose->root->name`, and putting it through
> `files_ref_path()` to derive the final path.
> 
> This is somewhat redundant though: the root name of the loose files
> cache is always going to be the empty string. As such, we always end up
> passing that empty string to `files_ref_path()` as the ref hierarchy we
> want to start. And this actually makes sense: `files_ref_path()` already
> computes the location of the root directory, so of course we need to
> pass the empty string for the ref hierarchy itself. So going via the
> loose ref cache to figure out that the root of a ref hierarchy is empty
> is only causing confusion.

Make sense, in `refs/ref-cache.c` we would call the following to create
the root loose cache:

    ret->root = create_dir_entry(ret, "", 0)

It would always be empty.

Thanks,
Jialuo
