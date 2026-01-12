Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981811EEA3C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230344; cv=none; b=UcfZRio5DK2omUljpv1ZwqgheYkkA+Mr3f8FRVstuq5Y+uBHjBLBbSl5qHu6zSbEInGpnGW6LfTHwtQWO5wp/2iuLpGYmiSTVIh9lzmecUjNtvwMBCaVcLQZENyiqvwaDY2mSkQhyB+DDEVEcdld+d7X7LDxDtIrDP6ge3Glf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230344; c=relaxed/simple;
	bh=P/bse7UephEjZawqd6zkMq4whnVth2ZheMkVq9/9Ehw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+QANvwP7ZdZMIz2VONXtWw+R5yEHnuO3U2totrlUsuZqyYcIAVnys6WVxeQQ10IlcTeu79/u81J4Q2mIZERYY87Xxz89f591HT1SDHSk8BHjMC3snsODAQ4lFJVlvkL7HaJlcvPmKGsQQIfVstNflD9CsK3SboFSyMcy32kNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnFjVS6Y; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnFjVS6Y"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-121a0bcd376so2080449c88.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 07:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768230343; x=1768835143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/bse7UephEjZawqd6zkMq4whnVth2ZheMkVq9/9Ehw=;
        b=VnFjVS6YNvYKq3e1clb8vg+7DYKJ1/9haVr0P+SiuH0W9EQJlSSP858j5drU6A2iSC
         pj5/GDr6PA69x4KTDIWLtO47EpkT+mVl1foNDIS94ns5fjN2njGwb7NiJG7RyOSrL3Bg
         mMEKsVUy2b0N7lXEZJkkje32EB55xWEJ2eypouPWqofchKp+o8+G5ONZg4z9s+lzb3H+
         G67kg93gT42k3y+KXS66exmDYnEa9n31okaeTBlgz3XgbWyJvWdj5fVEVngMN/Dnaw1D
         ymMVV/NS1VOPavs4Jsf1RYRHwflGFpeCLSRdctUeooSCt6dmCKwDjYlNF8pykpQGZhY8
         ZnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230343; x=1768835143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/bse7UephEjZawqd6zkMq4whnVth2ZheMkVq9/9Ehw=;
        b=SkY9dMufnI+lRoFAS7uTXp0KHdqcJMEgb9y4eGIsokyp1qYKBqagwMFo/mzpMc4eg5
         20XoTY+mCsKkNJTzQUjOt8WCmJwug9KMNOXfxL259CpsDnVr03Ec43FLcrbYUdkRGEG9
         k4Dv3f16VZWvUqyrzlo8jLDrH5MUSZfG99nG4NGVtyDFPOrMzUCquzYCepuBoO/oOuHt
         hNXobbYPdgRUEmLZfDsirJpP8Pw7FKdnWWJnL5pUdcti1urJzliDHwdxqo/RcmBS5B4y
         3Rrg/CmahAh10Gi69oOBzKDr+/yEOriIKPYFPevJj0uUWcDm10qRK6ayfKnMj1jW4uCw
         WMKA==
X-Gm-Message-State: AOJu0Yy2Webdtz0D7dsFzzgx0G9wdex5f0weH7TgL6fVS67NlbULK8NA
	fxFu4yiAtVP5aVxXvH8LHnl7AiKja1+QF9DQgQiI+9uOzv2H+JskqH62i1DAcb3HEXmbAZ08S2U
	MXbHz2NlcUQOJ0nFnQ8/8PMXC93KfDPs=
X-Gm-Gg: AY/fxX7idcKEIQdF4KFV7VXxy9d//WVom/iWwhWQeSYhIzmb5H5Lmfrb/p6QNcqefEH
	1uWmJWnymc6VmpAddcYw9zDXCG5YNtQw9ZGN1zpZq8LgX42SEKDB0xPeqfE+DwqHu3AcG54QHXF
	+EY6iwTEqyyep6qRIaED0z42+9i3iM+OamEKlHgtyqP3EESimy0WvvOlqV6m3PauniJk1q14D1Q
	5PEcJCx+tDQq/WBTe+J6eaKmu+WOd5WMQrEV0kc8iXoj0TJfEKDGdPwWv5bnJhtxFXb7Ib6TgcH
X-Google-Smtp-Source: AGHT+IESk7LGG/t5dpfmHEt2LMH/AXOHrX2VtMRG0wm7fc2IB9j2MVT3THHuTc+WvSOMW5YfY0EXw1U4mPMpF8fGnzU=
X-Received: by 2002:a05:7022:686:b0:11d:f440:b743 with SMTP id
 a92af1059eb24-121f8ab9d25mr15933589c88.7.1768230342401; Mon, 12 Jan 2026
 07:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768217572.git.belkid98@gmail.com> <abbfe2531158e9bc99ddb903b60a77c26beb0c9c.1768217572.git.belkid98@gmail.com>
 <b0e4b10d-5c2a-4685-9b79-92bf838c90cf@gmail.com>
In-Reply-To: <b0e4b10d-5c2a-4685-9b79-92bf838c90cf@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 12 Jan 2026 16:05:44 +0100
X-Gm-Features: AZwV_QjIWkiAYI-D_alrcYJc_vvryrXzwUuU6e2cBAROx5sXNEe7agxvrqe6jII
Message-ID: <CAD=f0L-CGTZRTxync-cidJsaruTa7nz4mkcqycATA_C0Oi2rZA@mail.gmail.com>
Subject: Re: [Outreachy PATCH RFC 1/3] environment: stop storing
 `core.attributesFile` globally
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 15:29, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Olamide

Hellp Phillip

>
> On 12/01/2026 12:59, Olamide Caleb Bello wrote:
> > The config value parsed in git_default_core_config() is loaded eagerly
> > and stored in the global variable `git_attributes_file`.
> > Storing this value in a global variable can lead to unexpected
> > behaviours when more than one Git repository run in the same Git process.
> >
> > Move this value into a `struct config_values` which holds all the values
> > parsed by `git_default_config()` and can be accessed per
> > repository via `git_default_config()`. This will prevent us from
> > moving any code from git_default_core_config(), ensuring the current
> > behaviour remains the same while also enabling the libification of Git.
>
> The important thing is that we're not changing when the config is
> parsed, not that we're not removing code from git_default_core_config().

Okay thanks for clarifying

>
> Looking at the changes below, I think it would be simpler to embed
> `struct config_values` in `struct repository` as we do for `struct
> repo_settings`. That would simplify things as we wouldn't have to mess
> about allocating an instance on the heap and freeing it in repo_clear().

Okay I will try this approach

> I'd be tempted to call the new struct `repo_config` rather than
> `config_values` which is rather non-specific.

I initially considered `repo_config`, but a struct with the name already exists

> I'm also not sure
> config.[ch] is the best home for it, maybe it should live in
> environment.[ch] for now - we might want to move it to it's own file at
> some point.

Okay this is noted.
Thanks
