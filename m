Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794F2E5B29
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127467; cv=none; b=U4aLh69SjDdiPgqPdii/GATYLzOdX94yrxdlLl1xIAC1aDNR5PYZ0OKLmUZsC2YwZ/P/saNVT+Ds1f54VlVC+7RFO4y9YZVdoGDzLpNBCGoDqE0nLQK5SKUEj5GwiI8yvrC+haonUiXsm/fXRvgPMNFLB7mokXYMXNFtemeGkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127467; c=relaxed/simple;
	bh=tXp9++etolBaU0zjgxVdiTu5OMkSv87cBjURTlQ2PeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/lprcBBC4TiwbnOhH/5h6uTQc8YNSwOS2MgZAFZQVXL9Ppv1uEWZeWEzWAcfE2lINx1wGulX0TXRkg8vxXw7TbO69c5FhScKshZIsC4lDMCObcQJxrCISbxzcdMclbt+4JQrDznzCs7GjR93oFqitahJiNAZNGpXOH68ra92ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f7gdmbiN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBkhxWxk; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f7gdmbiN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBkhxWxk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6514A7A0130;
	Fri,  7 Aug 2026 14:31:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 07 Aug 2026 14:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786127464;
	 x=1786213864; bh=eNd/OMUO0EgDOwi/1YP4mMrdj83YncBj6adxPdNEMdw=; b=
	f7gdmbiNisBlWtFYORPBFQLyGiFvmPGg/B6m640aVHqLqC9JHwrx8RqnyLxGKVPp
	ZPiK8bIFuN3zIiiyzs2/Y8YRULcLf53/uUHr95Y6zCxzT6K2HIkrqXqdCnaUXk/v
	uE4zcMmmFae9xEX/d5728FlgekvlbIO+r/csuplKJW9wFntEOSOps0t0KauJXO3L
	apy7mUFdiQ83wjy2iA9ZMKqeZWxExrOXLwX56FrtowuKk1FT3lDByJFOqK2JRhS5
	7wN6rJC+TfUcPSEGacxsvfgOcjxc8DJVU1djz2ef4DxVmw2lJO6LtBTg8kZFeKTN
	bEMD4L86bArveeaLiM9RnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786127464; x=
	1786213864; bh=eNd/OMUO0EgDOwi/1YP4mMrdj83YncBj6adxPdNEMdw=; b=l
	BkhxWxkrbGSPlkJOmDnuKuS8YIjsufz+DLeiXn7DIVXQWc4V9QmoIffSzbua8y1u
	oh4i2GLX6VFM470iapcM0LGzUKtIjaChEuPcUXC7gNgD4ASfQ3OfQtDXEQOCyLfP
	eYrQ7nwVFtpLKxNsZJcqJyTv3Fxu9wywBzgqys39o0HbJjnPZfXx5YD4zDYITo3/
	CkRxdJv+bXAqKerrGbfvnjOAWXGEx1Q3jgf3NHeLkebZsmGMV9phe8BfrpUAO8je
	4/I+ggeOpLV90cH6JEDmW9MvzZeDzRhOvc32ZGcPuqHX4iLhsNsn2c8hzQFeC/pF
	AAi8q3ujyqIKhPUcjzGQg==
X-ME-Sender: <xms:ZyR2aqQ3SKnZn14jdosMMiw_OouxVnksug2SiUa0OZtg2-dsJkw4Ew>
    <xme:ZyR2au0DVgdiB8Unv6ijIhlfQ2BkEz1fiUwxlYsjL2zQ571pJRwW82vBvsso6QSoc
    lSq9mp0642TQqhs-zCdvlI0RQZZDCpqBP0IMEp2aBmaiFV7eMyEcA>
X-ME-Received: <xmr:ZyR2auBXLx-hkoVVkRT--2QmaiOljc_IvyOOG5E6O7kpDyQGIfyn02w28dDLGqtzYiYHAPZoh8bMUJsmAA9YLgvIrIZp2KlKXQ>
X-ME-Proxy-Cause: dmFkZTEFGLs/IKm9cDOUYdRkTnBaEBSyQzJYy7e2Jpn+qOg2OdkE+Ele+Xo6UvFMiGLggq
    mS7ahjB0W9oJM/MprL3H8VuSzCr2IZcL7OGzCI6QXqeBJUOQVv4RMxv9m/zA8F+kpejD6Z
    KBHt57o/kGNFk2Ljo5xq5RZ+y+0vbxFM07ctiz5pT9fZPUVm1s7nPCdE8tHSkb0B0DuCOF
    n4l00Mj9LRX9SCR9robgo2XNcOcw3mxixw/pkGsN7UtEBV9agkTon7IirHxJi5qy1IoL8x
    I90gomxcq6o2mMt7bDbJVWicuUWkGEkyvymE6kLCXcNx8GTO9NczU2OmJxPuU3gwhrfUYD
    Cumf2MJreEnGBn0Mh5J2EU46o/auVrHEsD+DsoJu9c+ogtcwscQLtaKJwVP3eN36KYnKko
    QOvSCza/WcfZJoPN5UAavSXhKp5pX5Igj3b82HCbI85vyfeRXGITJktIIvoIHgvzxqkcxx
    qTo/tie/Ct2T6JjERFSGxE4fRa+IlZH4sj2izxzyy85eQrwpHfF8wPRD6XxYNqUspz1Ula
    hjyvIvhO3wxaa5FyMvV36pXnYbtr9E2ZzOX3NA9slzwBGnV8/K5vUME1AAVMa0X+VgCMW7
    MgafRiqPhOGSzmePydQLXlfWCsQuVZsMZqatLprpVsfA15Lrlw0nP0k9dNxQ
X-ME-Proxy: <xmx:ZyR2aijIhIf_r32hOSjFmsVp9KQsIeCs-yA_6rD8_h850xh9vg6xng>
    <xmx:ZyR2aoO3e1xm8U3d53hChhEQt7-ptBNJ1kZITayD1pUQGAEhB46ghA>
    <xmx:ZyR2aq_SCC_uyD_wBs3gtbkPiTl5PuOT8k93P1iILQnkIBNAFXxefw>
    <xmx:ZyR2ahc_InJQgxF_KJJjGWGTNfl6-VKpph-Dg7YUvscRYrIObNiZ3w>
    <xmx:aCR2aiXramVaRxWtg60j4_IxVdSOjCbiweaX5t719X16a8AQ3ilGSfY->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 14:31:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 0/5] Introduce 'uploadpack.lazyFetchTrusted'
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 7 Aug 2026 15:55:06 +0200")
References: <20260710085137.4171240-1-christian.couder@gmail.com>
	<20260807135511.1818458-1-christian.couder@gmail.com>
Date: Fri, 07 Aug 2026 11:31:02 -0700
Message-ID: <xmqqjyq1eqah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> Range diff with previous series
> ===============================
>
> The range diff with the previous ("Introduce a 'fromAccepted' option
> to GIT_NO_LAZY_FETCH") series is not very interesting as only the
> first patch has been saved, but anyway here it is:
>
> 1:  8dd67ddaca ! 1:  b5b0836d19 promisor-remote: factor out lazy_fetch_objects()
>     @@ Commit message
>          that could not be fetched are promisor objects.
>      
>          Let's refactor the lazy fetching logic out of these two functions
>     -    into a new lazy_fetch_objects() function. This will make it easier
>     -    to extend the lazy fetching logic in following commits.
>     +    into a new lazy_fetch_objects() function.
>      
>          This is a pure refactoring with no intended behavior change. Two
>          things shift in ways that are observably equivalent though:
> 2:  314c61cbbe < -:  ---------- promisor-remote: introduce enum allow_lazy_fetch
> 3:  cb2f5447e2 < -:  ---------- promisor-remote: teach 'fromAccepted' to GIT_NO_LAZY_FETCH
> -:  ---------- > 2:  879e3a34e3 setup: extract path_allowlist_apply()
> -:  ---------- > 3:  98431ab7b3 setup: add 'allow_dot' arg to path_allowlist_apply()
> -:  ---------- > 4:  a46f4c1bb8 upload-pack: read uploadpack.lazyFetchTrusted
> -:  ---------- > 5:  4063f233aa builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
>
>
> Christian Couder (5):
>   promisor-remote: factor out lazy_fetch_objects()
>   setup: extract path_allowlist_apply()
>   setup: add 'allow_dot' arg to path_allowlist_apply()
>   upload-pack: read uploadpack.lazyFetchTrusted
>   builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
>
>  Documentation/config/uploadpack.adoc  |  42 ++++++++++
>  Documentation/git-upload-pack.adoc    |   5 ++
>  Documentation/git.adoc                |   4 +-
>  builtin/upload-pack.c                 |  11 +++
>  promisor-remote.c                     |  76 ++++++++++--------
>  setup.c                               | 108 ++++++++++++++------------
>  setup.h                               |  28 +++++++
>  t/t5710-promisor-remote-capability.sh |  70 +++++++++++++++++
>  upload-pack.c                         |  37 +++++++++
>  upload-pack.h                         |   3 +
>  10 files changed, 304 insertions(+), 80 deletions(-)

What's missing is the information on the base.  I tried applying
these patches to 'v2.55.0' and the recent tips of 'master':

    2c78326f81 The 11th batch
    5b2471720c The 10th batch
    a97fcc37c2 The 9th batch
    13c7afec21 The 8th batch
    9a0c4701dc The 7th batch
    5d2e770923 The 6th batch
    48bbf81c29 The 5th batch
    41365c2a9b The 4th batch for Git 2.56
    d35c5399e3 The 3rd batch for Git 2.56
    55526a1826 The 2nd batch for Git 2.56

but the series did not apply to any of them.

It turns out the reason has nothing to do with your choice of
base.  It is because the series structure is not understood by 'b4'.

The cover letter I am responding to is a reply to another series,
but the patches in this round are not marked as 'v2'.  This seems
to cause 'b4' to grab patches from both series and smash them
together, resulting in an inapplicable mess.  It seems you cannot
have your cake and eat it, too 😠.

Next time, please do not thread the two topics together unless you
are marking the newer iteration with a higher 'vN' number.

Thanks.
