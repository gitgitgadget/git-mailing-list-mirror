Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F003BED59
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099754; cv=none; b=oNVysGjTZynXQiNQMkgdSARaCBdsO5A+VClMQHJbqFLy8BDZAs1sAmeb8sOAmH/dfgN5sskDO2quH73wmdO3SGQXszeCMWhwyx7Tt/0VSdClYSYrnVS+kNvnrj0fwWbaStCz1x1XomteT3VkJ5VKX2f+RIeVfMZy+kWMDSozWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099754; c=relaxed/simple;
	bh=awI7UJPlwlLUAaUAGumE+IVtydyB5t1sncsfx6NZvlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkgsAJI+rKEHMTB2ryimEGF/vep/w5Gozhc9rkj7QX4NsPYTZhTGEEt9V9sm7CmRvBrQZdrDlu+k7+qygF4XeaHWRDj7UXTNcn5+u+sy6c4me/c9uTcB//AIxE+vLyhHI3IzM6QNhCBn0syIACcWT6bYDS8PJI72f5kUWPYM3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+an/rHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXmBcxAn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+an/rHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXmBcxAn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67F667A0138;
	Wed, 15 Jul 2026 03:15:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 03:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784099750; x=1784186150; bh=RU6kTvQbGM
	HlECOigY0QO9dsHf0Evqa61kdl4Yx8B0U=; b=U+an/rHpTBoAR5eeV9mYD2o1Th
	lIBR4NVIHZOXZuTw55PvjlULChZNmet2Wym30XAoryruAliE9l7KcFfVu1t8rVyd
	zforCgRPZm7NA5ysWWt/cTvv6ZZC49P0YqciTtaj+8FFw6SC/6jVbLkw7cXFT2QG
	sV/Gi+bzXxaU8MGWk8DYAAH+LIPf/b/mXgD9NlALZOatd/5m0A2P1AkXyL/xeZhq
	o4k3emsO4N6p2ru5TuANB21yyhvqp14zsm8M63WlRkDtfUzwfK6+ZjgFAdCu4Ij/
	kZT52UEuJSUU5TctvuIKVRqQauF6B78z9iyTmj0Ny/V7+9yNjVzrWgT5uqhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784099750; x=1784186150; bh=RU6kTvQbGMHlECOigY0QO9dsHf0Evqa61kd
	l4Yx8B0U=; b=KXmBcxAnQdbdLz6U3J6mHGN1rIkzJh1gN4Zejq/pprU7/WVzr+P
	q2ME3ajD3UPnKBWq1BlVZ6jfegSesdRndte7VXvKz8mQXuam/b9DSAHoTp2IouCt
	8osB6wWJ9kyutYza//N4P4Zh9klI13TqERByFFTHHNzizt37/ST4Z9kAsr6iiSb2
	sf0sOtoayEIdQ4/qUfycOrEq+BoRjguJzbO0b1NAd+Nz9+mE95Rbk+dKIUzm7m6U
	+MOv087mSbI4DuA1Ib0eGohAL1MpEAaf+qg5Q8ZQoBnmBs6Q9M5k/PYdbMJmTb5H
	gGMjas5+v/EXjGWVQduPU4VApIFRVgWgbHg==
X-ME-Sender: <xms:pjNXal20JkTslzAOog5EIgwbvkUCej4stLRlDokqfPbjvCeOzAEg_A>
    <xme:pjNXaiH51Y7x0WJ8rsWYCTYZ8TUCxN5QZif75TsU6Haj9VB7Yo2F1Rl5sdZ5cECSC
    GVGUC4RARpNhQxqiuazGh0zPQpKzZuGBqRhj9ldHVs2HKw25Fegtw>
X-ME-Received: <xmr:pjNXajivo4tkappIlhmtGEfbhtbKAAFmDGgj5MZOiYwqdl1tDEx1dz8Uy5C7yQkxI_x2tVeax9OsoW9BbPmN4DrzHRo7O9nP4_rcQsWD1PA>
X-ME-Proxy-Cause: dmFkZTFxwwuhqHbGSN0+P1UJCur9FDeS3ccq3qAbygdxqk8x95A+pxhSzRy/0e2hns/VBV
    CE7sYUhStQiSscxl0gC3Oqwe+c2F70YCFnyPfSORz2a1H6rTS/nEsC0LJdeOjmktAao0GI
    JIb+LQGE/qRMFa8TJyMjpGzg4P76DX3ALeowjLlTazAKjNhWTCpnLS5YUVseZFTtjyKh6e
    7CgtfIDDN3dUXYj7korJ9N01ypXQdg8zD7XErz0jPUuEHs9vnWBDQ7T10Wiog0dmDTxZQu
    BKyip3OrTwe/f0s+4yFJ+RnT8qJXf7iMi5sxTyi/KLtYpkShypyBl7Q53JB5iBwTzjNFch
    Zt32xRPqqTrOWQPYxD8e6FZl9839ylijaOcc8bTCjq576b4K4m30Z33GOVEt/fpGUF7VIj
    qRLM79p6JbjPFXe/4xTkLOI09kaWkxmYQpW+x/uwnGnnxmVuHpLc8+ugo2MAHXLGNQTWo/
    zCeNPyp8MQP+/H6P5szRRhM4ThU05fB5s6U4NVECIpGpVuQnqcsssfmeSr25uNG1ykzAef
    n0u2oQI5T9oGgld1eB6n5cg2qMbbOHJmyq9K5R+ccTw/C/gIbHDJsJGr+c1VQPiHKkl0lS
    z6znuRyeKK/7yZpwohSgHrEm5n/XN+AkvnAOdNt2crm0Zn6AKavxWbhfopUw
X-ME-Proxy: <xmx:pjNXat8zmMP2vSpz-FpBj1C35LtlcSIcw3Bf82-NDbR12pOac98ujQ>
    <xmx:pjNXaqrtwiOXrwS_e69obGeL3XpdLmg2Ijv9OxbZmckDzzaZuKpKpg>
    <xmx:pjNXas_Y1X0UiboH3iMXULfhzp5fpycuEVBW_CNPLYYGMFdFMLk2vA>
    <xmx:pjNXauX8P_EjqINl0YzH8beJ4eyrfdlC2EBHLY6CEGlwRXyQh4SEQg>
    <xmx:pjNXahM1BmBxsAyPVwIkPPNACfbrjlOvJt7SHruDdKX2YWGzxivAiE2F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:15:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e61fcdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:15:47 +0000 (UTC)
Date: Wed, 15 Jul 2026 09:15:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2026, #06)
Message-ID: <alczoVOVRGl4lJ2B@pks.im>
References: <xmqqtsq1qfzq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsq1qfzq.fsf@gitster.g>

On Tue, Jul 14, 2026 at 05:00:09PM -0700, Junio C Hamano wrote:
> * ps/odb-for-each-object-filter (2026-07-13) 10 commits
>  - builtin/cat-file: filter objects via object database
>  - odb: introduce object filters to `odb_for_each_object()`
>  - pack-bitmap: introduce function to open bitmap for a single source
>  - pack-bitmap: drop `_1` suffix from functions that open bitmaps
>  - pack-bitmap: iterate object sources when opening bitmaps
>  - pack-bitmap: allow aborting iteration of bitmapped objects
>  - pack-objects: drop unused return value from add_object_entry()
>  - pack-bitmap: mark object filter as `const`
>  - odb/source-packed: improve lookup when enumerating objects
>  - Merge branch 'ps/odb-drop-whence' into ps/odb-for-each-object-filter
>  (this branch uses ps/odb-drop-whence.)
> 
>  The object database enumeration interface 'odb_for_each_object()'
>  has been taught to accept object filters, allowing the underlying
>  backends to optimize the traversal by using reachability bitmaps
>  when available.  'git cat-file --batch-all-objects' has been updated
>  to use this generic interface, simplifying its code and avoiding
>  direct access to ODB backend internals.
> 
>  Will merge to 'next'?
>  cf. <alW0KzSZuZnHmOZD@com-79390>
>  source: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>

I've sent a tiny reroll that fixes two references to function names in
the commit messages. But other than that I think that the latest version
is ready to go.

> * cl/conditional-config-on-worktree-path (2026-07-09) 2 commits
>  - config: add "worktree" and "worktree/i" includeIf conditions
>  - config: refactor include_by_gitdir() into include_by_path()
> 
>  The '[includeIf "condition"]' conditional inclusion facility for
>  configuration files has been taught to use the location of the
>  worktree in its condition.
> 
>  Will merge to 'next'?
>  cf. <alTJCTKR9jOWfgbk@pks.im>
>  source: <20260710-includeif-worktree-v8-0-04686d8a616c@black-desk.cn>

I think this one is ready to go, too.

Thanks!

Patrick
