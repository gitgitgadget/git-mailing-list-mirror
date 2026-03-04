Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952593E0C66
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648275; cv=none; b=gyjewpKmKA67OmFAwL3I9zFXbQiUo7xRvTT6y9z+AShYYWsGfzVd6D6RghnbXFbmnAZRRsu1Fp4uQFf/PX0f2iT7rfhGGiEmENbxZHCGUCHsAvGwFqSszrLGryuTLuThdW/pEyG4NZtE28yNz+0tH8e6Dz/teEomqjWNUywtNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648275; c=relaxed/simple;
	bh=y1xKIwcD/dbyb3UAcQumpy/Ogg2GrluPOrmWo0gP3WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiZPilTA/UE9smfUS0qDQUjcyghQxOhec8F4MQBDZppKQJcqdfHBPacEfmO5+n2HxPWLwpBK5eFtPU0afTtxys9QNxVW57WRT1NeMikxK8RQIsNJHEoq9QOykD5x6s2GENKdEUO9s1E0q7HT4n5QBWgu3y1w7dQuPe7yE8IvBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU1/rTt9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU1/rTt9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae45a4cc54so25657755ad.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648274; x=1773253074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1xKIwcD/dbyb3UAcQumpy/Ogg2GrluPOrmWo0gP3WQ=;
        b=kU1/rTt9337KwvBi6wyG4FkTjVmikentj2N9Op40lB8XrxVQi0/9uk29BqG+4snb6v
         lrkElyxi4ohUB8bOuFGkF0xRQGA1z53FrrrqUvvy2+McI0p1ow2YOEwqpEiJPImq77ad
         Mb/FKlCkchoGRvB+n7+YX2BSYqfU9jasdmNiSZ6wXzwU5faJY3pNFiIj70i5zid2iDMg
         Vtd1Tv73SBmrytStqgYCoiP2pz/FtGgJZfdvvdb0sIVp4uyJa1OYZIbwledd6HmicPJz
         Mj7GKNxDSrgQUu5jJZJC5rThxJ0ZM0U45wrwbWZirITpUypa9NsYdPWQUJeI92qwH3bs
         jR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648274; x=1773253074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1xKIwcD/dbyb3UAcQumpy/Ogg2GrluPOrmWo0gP3WQ=;
        b=f7rY2h/QJWkGFPMSkekQwzv8unAQuphZN/3KjKFrIN5u4GzEfGMcmxZo7Npa38Xu1b
         g0lsOMsuJFzRAAjk116mZ9IBbdOIXnaL2nOyRJhX9q+BF0qLE9ErpAfaoU9eFyG2Z5oQ
         9swDftMUhb9+pD9CWP2SfCJHnx41s0PuDLqyUJwvUbOZx1SqeyGzTGT4tsEfl2kCkdvY
         s4XfyZh7l4ILjS2ASHLGvAej9c4YlzTF7rSd0UarBhuaiwDkkw56GNW73Nwft1HW3ogO
         mzgGT5yS0DGZWNXdAMfMLDvbA8Q8BnM8VWxtvyDSHyYMY9zNs6shnB0eCQO5ybmOdHiV
         Ir5A==
X-Gm-Message-State: AOJu0YxrUmOWXPwzMJQrmftQwsGagnHRrS44qQJWK3bUr8rKz9C2wR4D
	yXR206+QNjW8HIdHbikmhE2c4G9hnoonNfqChSz6ojEYl/p/wYkhc3ErO45XzQ==
X-Gm-Gg: ATEYQzy0h3ZbHogsARU4VK9qDPHOjaWqHWVSO5vumw+iRj1YdANfh6zNUxsHhn7+boc
	Xa9HUcJyTBpISeUGea1zWEd9crhV0jf3x6QOxdFlqyS8Jn1MkSxfhN4gyvjK9ZxmkPA6WQEqdKa
	RBR8uTCbxt/PY6FoxPzYOaW1ifXATEC7k4jNj4mx51hDuA4LQVpc+l/LhPS3nJzYcDiJLQEsOn6
	8p8QaDWXReHPbXGIcSSimbKxz9duIaTtJFyL43cru5+LgwgHksX2TgLLX1jL/OaAKpVQvp6+oa0
	IKtncRut5ofVGIqFeSjqQ1We+yv8gEELop8R2En6f8mRUY9v2wCv9g/Xfq/Mg4VjxG9ud0vw/eZ
	tw+So41WOuEhHEqCGl4d4NG4LrQNgr/iycjTefiYHoSqFBq6V5x2dgjseJbo9zAA5Jrz2gVZdxh
	PaiBRmH+YYE36RhT/q0dSsxmSmzLqiWpGicB7bm9LtEF7rhjkO6NKK2uwMGITrFBUGdlFRmo+un
	KOvpYnB5Y53B57Rjl6l
X-Received: by 2002:a17:903:1a68:b0:2ae:5275:4d52 with SMTP id d9443c01a7336-2ae6abaad27mr28397005ad.53.1772648273749;
        Wed, 04 Mar 2026 10:17:53 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6c4dd0sm204135445ad.70.2026.03.04.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:53 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 08/10] fsmonitor: add tests for Linux
Date: Wed,  4 Mar 2026 11:17:52 -0700
Message-ID: <20260304181752.25768-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafikA4bQS3lB0Hq@pks.im>
References: <aafikA4bQS3lB0Hq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> Hm. So the fsmonitor listener for Linux is not reliable? Wouldn't the
> end user see the same issue then? I'm not sure whether just ignoring
> that issue and adding a timeout to our tests is the proper way to fix
> it.
>
> Before we jump to such solutions I'd rather want to know what the root
> cause of this. We had similar issues in the past on macOS, where we
> eventually figured out that we were missing events due to the buffers
> not being big enough. So did you investigate what the conditions are to
> trigger this?

This isn't a buffer issue or a bug in our code, it's a kernel
limitation in overlayfs. On older kernels, overlayfs doesn't implement
the fsnotify hooks that inotify depends on, so inotify_add_watch
succeeds but events are silently never delivered. Newer kernels have
partially fixed this but it still affects some configurations.

An end user on overlayfs would hit the same thing: the cookie wait
times out and they get a full-scan fallback. Correct results, just
no incremental speedup. The smoke test catches this early so we can
skip instead of timing out on every subsequent test.
