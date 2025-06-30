Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7621B9F5
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317729; cv=none; b=Fva7yuNNwx9P41030NAXlHg2zMmaA4Y8p5NcPNfbHUNwVG4aXFZhhnJa8z/MSYmp+LbrZw+cl7z1qZ+bAgZ9hwmU6dp3SF9hrTo8puklHVNlZszQK6TUp16Q+YuszJt9UdsLQuPQ2rK/MDXoN4xRwx65R19onQGA1s9DdGZzDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317729; c=relaxed/simple;
	bh=AoUqRcH92+c63yEFefbShQGknxIaS56+dWQJOgnqXkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtuNPjpTiKupOUYzmENul87LqNozD45pZHp6RiVwzPBnDHSGwE4qBer/cvopgLQIBwtqGmLMc0ZfWGV8PM6J5LYfnNz7dpEFby1Yss1rSd1S+vLCAcM4VblqvQxZAcF839KMXyvXvJdtNV7tFHndvRhBHEHbFfAThrqnz4L0KPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFcIzmvl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFcIzmvl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-236470b2dceso20673575ad.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751317723; x=1751922523; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXNSYBK9vW+sieEavatWVcdCjeQQsMWX8+8blMkgqiQ=;
        b=PFcIzmvlX3ODmHbByfEO/Pv0WVQ0jsPKUYrBhWVDHG+YQZgWqfxD7jl+mGzQYabb0J
         8WRy3OvBIa+shf8Auh8Q/o4ygFHsMw8E4eBuDGXuZUhcYiii2D+r7iUDKRUUkda9LiM9
         KARipf3Ul+LmJY1mfeikth+qNHSb3irDEYVD2z24wJ8dU2M+Q+F4FUdHpMW9Zr5VZTBY
         LhOVd97XTG/vLWOvekVQNPeWyKn1hYfWTCV9iShV8+RmaY6XXbrwRS7t/ebA/GqvtT63
         Ijtqmp/3pwRAf+hVvrevBfPlh3FNeZG9LMar23iX3qat6P8hpGJ1bwDzpkgC/5SfqvI0
         Gfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751317723; x=1751922523;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXNSYBK9vW+sieEavatWVcdCjeQQsMWX8+8blMkgqiQ=;
        b=nfBODNYQ4Vw8IxAhiJXojJdXzoi2Vz1XnQhhOFKETL8gdP0E2lmfOfH2fc6zPlZ9Ex
         qR7jR+wdCapk8awHjM0dCQ+K1hzbJzvEAoflZTrgu0B/tYlpfT+zYT5IB75swYwUwa8C
         TV/TGLx1mSalv3v9VswEzJ4g0vDxp0aTBEtj8t6wS2l2OEhGyqhy6DaPFgJPy8Kmuoo/
         kdWJrGiOkBGcqfVnbxqq8HJkbR8BENnIDJi8gWs3H60E7A1TcvSDGFaH6kf8e+Eo8jju
         b6pAllx+LEyW//74MnaPc78cjgyHXHznYd5wvOVZS01vVX1ZmaMAcsuVtNUmzibPU6Sf
         T2vA==
X-Forwarded-Encrypted: i=1; AJvYcCVZWq/V+54EsbXMvWhAS++kY3VUhSEoaV2GLxejf448j12mlEy9Pfia3qABHFKBe6MUQkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhZd8d+0YceC6yc32RvGJZzztO5GNsmt9J2t2xCQrKdIMzVoq
	7E721rlm5Q1d892Ms5RMnhWh8/BumRS14s1fUOcHUApRUf10TKJOaVaQ
X-Gm-Gg: ASbGncuHeNb9Pe6kDs7C0EecgXlayeVNIlh1LAiot6WvSeQcY4UJmpR4jcRuzclWhnH
	+H58zB33dT2mugR9QuQ6yKq2ip4MDDJANCbhO7d7FrBzt1gqkv6x+a3Bi8krah+xiHKWlamW7nG
	svA76gflKD45HMugCEBOYhtFFrFyWxEiuDVLiulz9eQIjfAB0/Iyf9c29Q4Wl791vKHIDn0N7A7
	scsukJFEULMqaWmc79llOvARSlA2sG4er4qfj5OMxVhyslK8hZvTSCIPbhh7h9qPF13V8UXcn8E
	IGteLbF98RswgRoGdPCfbnsO/qoNHu9WB+B7fOJ3PeI7d2pdImK9+w6Q9enaPG33ULGAsvQmjD/
	XRJX2IyY+NI3D9Bn9Chxc5DIhWMU6qigyR/RL2Q==
X-Google-Smtp-Source: AGHT+IEu3ytaN+EIkKn0QLwsQp9IuECMEXTnpChI3D6FeFi+Ef5CubRj+R8VYxYDgLsXFCZI8mM/ww==
X-Received: by 2002:a17:903:1aec:b0:234:c86d:4572 with SMTP id d9443c01a7336-23ac45e248cmr192251085ad.30.1751317722892;
        Mon, 30 Jun 2025 14:08:42 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb39bd0esm88250935ad.117.2025.06.30.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:08:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com,  ps@pks.im,  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v5 0/3] environment: remove sparse-checkout related
 global variables
In-Reply-To: <cover.1751309770.git.ayu.chandekar@gmail.com> (Ayush Chandekar's
	message of "Tue, 1 Jul 2025 00:57:45 +0530")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<cover.1751309770.git.ayu.chandekar@gmail.com>
Date: Mon, 30 Jun 2025 14:08:41 -0700
Message-ID: <xmqq5xgdlyxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> This patch series aims to remove global variables related to
> sparse-checkout from the global scope and to remove the definition
> '#define USE_THE_REPOSITORY_VARIABLE' from a few files.
>
> It contains three patches:
>
> 1 - Remove the global variable 'core_apply_sparse_checkout' and
> move its setting to the 'struct repo_settings'. Also remove the
> definition '#define USE_THE_REPOSITORY_VARIABLE' from
> "builtin/backfill.c".
>
> 2 - Remove the global variable 'core_sparse_checkout_cone' and
> move its setting to the 'struct repo_settings'.
>
> 3 - Remove the global variable
> 'sparse_expect_files_outside_of_patterns` and localize it in the
> function which calls it. Also remove the definition '#define
> USE_THE_REPOSITORY_VARIABLE' from "sparse-index.c"

A call to prepare_repo_settings() function is not free even though
the .settings.initialized member makes second and subsequent calls
to it as cheap as possible.  It makes me a bit worried to see
patches that add new calls to it to places that are fairly deep in
the callchain (as opposed to in cmd_foo() for various built-in
commands).  As long as the control passes these places only once
before we do the heavy lifting and then after the heavy lifting,
the only thing left for us is to exit, we would be fine, but I do
not know if all new calls added in these patches are that kind.

Thanks.
