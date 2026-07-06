Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F23E1CE4
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369790; cv=none; b=Mm4RHheJsWiykg9Fb4tNAOBgFaSbqWtZA5o4Dseis0IeQYa70KPvahpOxG7c0YAnffG0a26s0vdrWwFQKTRdR9y6vytEgWe6VRR6lk55cxeJoxaxEHKwhbNgpz9QYstpHLyby6/nYxt1L9xUNbcOwZ27cSl9Yi9MpYcxv6ghjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369790; c=relaxed/simple;
	bh=BIao1r6Xuyrg+jUiuyFwb8fProXmdw7V84ds4rhG9Us=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8nI9+ChrCwgMZcToWmOgUZqAzYUr5eNULogSmHV/17yUKXYYcyILItTPbyLPHakvzMZaT5WN7NUzALqVGIwTC5tUM6w8idvT/h2RWd+9ccz3TBmr7rheyAUmld8YuHqzfoWiw0DONI2Lb3DkY8FTc+TP0Cg2Oh2w9vNgpVOc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aTId7fEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rYRUno8R; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aTId7fEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rYRUno8R"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEA0814000FB;
	Mon,  6 Jul 2026 16:29:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 06 Jul 2026 16:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783369787; x=1783456187; bh=b/D3ZbU+l2
	aA7zHX9aRSQT26G4RCB4JwDRvWqWASHIU=; b=aTId7fEnRJxBfZ1IjSQQfAWZp4
	yT7l3+lX3lj30N4Kl3eRH5aaKuKGaU2D5wONqOCRVGtc4QUgie5oxnpaBvsc4Rom
	uiIAe+bIbl0annNI1evFsqzEH/AiqE62tgDEYr5+xgqxPyOmWInQCBLQhKJ+RRUf
	KEAUbPKa9wMvEAzA6lIhv1rVOJ1zVQXoZ9lLABhoUdGxj4UNbym6nlP73/uhplyf
	FGLfv4a4Bty5P//Z4L1pzj6Quxs29sWPh4bUY3BrAmpUSLEbaMAhyZWlPc4Y2IN5
	mlYLNIY2UAdaB08Mzk2poke0pTPPhiae4nRpMKkJzdlCRNlXxFQLqiuM2i8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783369787; x=1783456187; bh=b/D3ZbU+l2aA7zHX9aRSQT26G4RCB4JwDRv
	WqWASHIU=; b=rYRUno8Rk7mcuR8AgMzkRwrv25G7WsDR4m/9WZ3U5xWDccygQR9
	0SBMJq6KcM8MBois52kUOx/D+7PRkqT2098CqLaSpdx/y/0saY/aUuSXpRqG4iI7
	IkTtoyrJna0HLCY30nbQEoN7LzKxojD1Vw2YBUh8AuhEALbvvg9GydT4QXdFvy3p
	HY/PjJJli+ZFll9A0WtouyYOj5vFZBDrZFl3g3h6utsiIcGw5Cxq7D9sX4WvFRYP
	H8ZguQ3hMgEOot3d+wEMwuly6FDQCm3JW0pU8FDT1mg1yT+vFGIo49aEpLZ3qIcy
	jVE085h0EssNIRuM4YPH+MTOzhBizB+s2hA==
X-ME-Sender: <xms:OxBManZihDDc6v_ztakFYNYrTDs-pFW6P_Z9NKUTbXIjaDw7Ke3KAQ>
    <xme:OxBMaqExDamAUzwV8gWLp3qeJ6DgRAVWrdqJbI72AS3Li7McGf9urMdvD50M8xmEn
    7ANKev95zMePv0i3hTXZfWhCfqs_q1lLVmVjYhEfM5Soe4Mk0S0DQ>
X-ME-Received: <xmr:OxBMajwiZHw7EQbBy3bR_g1QBZQu5z1x9yznAQnqk90_LHa1dV8ef992NxqQAYOtkztpVCm9EEYavUX449VKgb_aHYynblOmGqgfHsY>
X-ME-Proxy-Cause: dmFkZTExkFL0lIFNPfWuTtMmulnekqNcSceXEl3phx6uDwAnY3sAhTOGjf8CWGl5kn5UNT
    VQm0k1J+mnjH9McxpQoXhSZ6O+wWRepUx60B5tgstTvfbDawvIzDHyK+v6VAsxmEBZGlmO
    z+2GP2vbTJdVwZgfZFbaiTqef/vdqjAuESLdrs6aDH14WEOshYxXiRGNBJtrfhhBUah6Je
    oP/sJFhUw5v3xEseYqql5YlWaacv7xPbLRPqebjaQCYfsskXlGlC7QsvP0VSfvlIfLaSY7
    iKE+36tj9OpbzozmWDB4VX4gTFdTLBe7/p01FqBICi+MJBI8Bt4/NQh4WvF1QGqBmdW/AW
    bNz7zqIrQIbd8sA+0KlB4jKenOYYI+FNYCunST6djEF3xq7JIzX9aHs7Tiy/PIjs4tlQe9
    tJRi695SwN48OC30y6O6gC/6790GYhA3Gzr9N8/XE4y9DMjiKgcBvdGPRT09/OxI4mFaZn
    gH83yswB+94/t/nOYPKICftkcDwCtjKMmBAQc44dKtBXhdtV6ihVABqCBfmSiRZbAk/CBS
    Kt7A41WAexjM756ICkfoFCuJwndPhVUjYNqmafy/o18X8N0myvtLpRCq2B+Sftw/pOUqPh
    n/BDUtyhFIjkvB6E8O/y5H2BRcgP7un3H4/ZwZj8u1f0K8ZuPKgktH4KxL4w
X-ME-Proxy: <xmx:OxBMaknroWgLRRjZ9LNIdbWGbXzPcZmKAFA889hklgxB0S6I6c5v-w>
    <xmx:OxBMakmTFqIy2SACcfSkzptDDopACtASVVg2mU4S6ZKvJGh2X0pCyA>
    <xmx:OxBMauxqbPCHkob7qeqZnhzg7cYMj1Xaan2UEFRM1i6VLlz20GX9Zw>
    <xmx:OxBMahoF0g0wEH7C6ofSrhtXIaOcxFYOrqh7kn0mmyIa8kurs7aHUw>
    <xmx:OxBMahi7mO1pqkaa7qwuD1wPv5UFG6NHs7qO5OOIqhmvJkOwqRyu8KQi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 16:29:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 0/9] t: fixes and improvements for GIT_TEST_LONG
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
	(Patrick Steinhardt's message of "Mon, 06 Jul 2026 08:23:55 +0200")
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
	<20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
Date: Mon, 06 Jul 2026 13:29:45 -0700
Message-ID: <xmqq8q7namkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this series started out as a simple two-patch series that wired up the
> GitLab CI badge in our README and GIT_TEST_LONG for GitLab CI. But as it
> typically goes, tests broke on GitLab CI, which made me realize that
> they are broken even on GitHub's master branch right now. Some tests are
> failing in the linux32 job, and we only didn't notice because the whole
> pipeline hangs.
>
> So I had to go down the rabbit hole a bit, the result of which is this
> patch series.
>
> Changes in v3:
>   - Fix commit subjects to mention correct prerequisite.
>   - Link to v2: https://patch.msgid.link/20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im

The interdiff looks trivially correct ;-).

Hopefully we are now ready to declare victory and plan to merge this
to 'next'?

Thanks.


>  1:  e4add14ea7 =  1:  afc7563e22 README: add GitLab CI badge to make it more discoverable
>  2:  d762b4d46e !  2:  753e950eaf t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
>     @@ Metadata
>      Author: Patrick Steinhardt <ps@pks.im>
>      
>       ## Commit message ##
>     -    t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
>     +    t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
>      
>          One of the tests in t0021 writes a 2GB file and then roundtrips it
>          through the clean/sumdge filters. This test is broken on 32 bit
>  3:  8d43eb2819 =  3:  f776e0fb5f t4141: fix inefficient use of dd(1)
>  4:  fcd048f6f7 =  4:  9754b96a43 t5608: reduce maximum disk usage
>  5:  11df7f2cb9 !  5:  0f2e28dc11 t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
>     @@ Metadata
>      Author: Patrick Steinhardt <ps@pks.im>
>      
>       ## Commit message ##
>     -    t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
>     +    t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
>      
>          One of the tests in t7508 is marked as EXPENSIVE because it ends up
>          creating and adding files that are multiple gigabytes in size. This
>  6:  a16bc1754b =  6:  d329a2cd40 t7900: clean up large EXPENSIVE repository
>  7:  b2e6b0d517 =  7:  a336d4ce9e t: use `test_bool_env` to parse GIT_TEST_LONG
>  8:  9632b19164 =  8:  cfff94c79e gitlab-ci: disable RAM disk on macOS jobs
>  9:  a42c613012 =  9:  ed5e8807fe gitlab-ci: enable "GIT_TEST_LONG"
>
> ---
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
> change-id: 20260701-b4-pks-t-fixes-for-GIT-TEST-LONG-78e538bf0e06
