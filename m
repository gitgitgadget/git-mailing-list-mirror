Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D46C142
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832421; cv=none; b=KtPH2OR7dejFT3IIikZK9lnnNJ01hSMMhugINfrYxuUcHbH+rVdYto28cR7D4i0VqLyzFk8QM6U+0154X670UgGV898iKFP4As7OTE7f3uDhcr/e7KO1Vk8/3Fy7HQE4MQ6JwNOgn3ggK/E6x74EWeap0mW7c0iKcdkt10M83IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832421; c=relaxed/simple;
	bh=/tr06fvrrxMJnv8QHCXPcYM97FcaBFN7V9GabZ0EiPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC6Z2NCVk3N0QFbzUrqzgx+PpozhK/MxpT9CPR9gUQK68ZvHYRV3dWNtM51dypRn0bbTcjiX7fKsdaDD0HsN+1+rUAZn2oDj316Pml3cxcLAFq1Q0xR8xNnY/gAufE+P4BJKkiBNPCaXtpYw/tVJX4gqm/wdV7lqU8k1A/7AhFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHefExGz; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHefExGz"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea1f98f3b9so2302311a34.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 17:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713832418; x=1714437218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1UYCOYCY+P2m4IDcU6kZwAijE9zdN90UhzfP3dJ1EQ=;
        b=bHefExGzCfxzNN8ae955wjC8ovl1p8rAPzyOV+4KoZzC3JtVc6sg3uNzduJFDOuM/y
         HrU75q7sCtUkFlTnJI/6hzSAezrUDEPR+PG9Krn7yT6WiS2l/RAwxFrHd7GU3YoEh7hv
         9sO/MaR1BY/d5HQhrqqa1dA+JFkstZ38EyEmz/ltcEe3J2K6CWLqqFFewpHNyegPU7w0
         QPYxvE7zgnhGsmE6pkbyPhWpr1Z7WMHA+kn1+MaE2QvR/6QvK8ahG45Fs7kwHvVwKi9e
         kJpVRZYDDtJP1B6ZSZ+7frwfhVL1/OpZha3s0aGdfH+lns6P2Nw2HQCkiksy+GqAnw69
         iYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713832418; x=1714437218;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1UYCOYCY+P2m4IDcU6kZwAijE9zdN90UhzfP3dJ1EQ=;
        b=EAidcBRtIqDwoycsHAq0mMN0frzyYRdv4MWG7rVGh9If5ztp1ypICMBny0e6aSQs54
         x5y7DORV2ebSYMsrV2ns7swh9BZOQcbXPnRMQh4WeNpuln8Bzeva2Ks8JjidfhH+bC5N
         lSCk/IUJhxa6y8MZM9jXZtdFVk2OvSbo2ViOAcbSj7gUs0bm7AAQTozI25Xq6fiER5AN
         83TZaMxMyBukXZ+6hzivEGRD/YIVVNEN3oi5bxPbU3bXDRYAaGTUjSQfNL6V+OLviFAH
         cte+EK6yOMrqE0fF76dxC3cjIwUgP/WyImPE3MRl1rsYy2VYfikbmZibZWH4hAk6RsjS
         icrg==
X-Gm-Message-State: AOJu0Yy4apVkbmub7TA3XUsS83WrvzFcWawrJiCs3aCFhXwsceQhyqHZ
	ZC/HRYi7Owz9jl+d11jNlG5rJYvcOp/e/a5pjkzQKsZybUupwL2UKg9h9w==
X-Google-Smtp-Source: AGHT+IGR4RKK144VAWIqibRTA7j+w50l8bs30D/pQYAwxOkyFzvJX2QgVUpbjUy63eQk4jFMp2V2JQ==
X-Received: by 2002:a05:6830:20cb:b0:6eb:8415:4c2f with SMTP id z11-20020a05683020cb00b006eb84154c2fmr13831815otq.1.1713832418664;
        Mon, 22 Apr 2024 17:33:38 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a05683004d000b006ebd5eb0f64sm1281595otd.77.2024.04.22.17.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 17:33:38 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:32:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/11] attr: don't recompute default attribute source
Message-ID: <2id3biajad2mw7xvq7bfaturhfot66y24cs5l5zxpc3q4jf4i3@duhrmrpdq3gv>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1713519789.git.ps@pks.im>
 <ae91a27ffc0158f36758cbaf903db2422df21d74.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae91a27ffc0158f36758cbaf903db2422df21d74.1713519789.git.ps@pks.im>

On 24/04/19 11:51AM, Patrick Steinhardt wrote:
> The `default_attr_source()` function lazily computes the attr source
> supposedly once, only. This is done via a static variable `attr_source`
> that contains the resolved object ID of the attr source's tree. If the
> variable is the null object ID then we try to look up the attr source,
> otherwise we skip over it.
> 
> This has approach is flawed though: the variable will never be set to

Remove "has"

-Justin

> anything else but the null object ID in case there is no attr source.
> Consequently, we re-compute the information on every call. And in the
> worst case, when we silently ignore bad trees, this will cause us to try
> and look up the treeish every single time.
> 
> Improve this by introducing a separate variable `has_attr_source` to
> track whether we already computed the attr source and, if so, whether we
> have an attr source or not.
> 
> This also allows us to convert the `ignore_bad_attr_tree` to not be
> static anymore as the code will only be executed once anyway.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
...
