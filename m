Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000853BD225
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580934; cv=none; b=eFH3wHV0Gj73RCRBnhYy5m/kzSFOMW37rha257rSxZ7IBcSnqwuj9tsCzofRky3wnJZ5U+Mp1fQgj47qm5Fmwmp7C7fgoJQSdGfIYpN0BDuw0PYDeSD6iP4Nbx0C+qLxOvTFo5mEKmJXLVOl8B1Xyj2fCokZhiMhop6FcW2ZFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580934; c=relaxed/simple;
	bh=35Bv7Oe4ePGhEyPFMEr3Kz8jgQRCoeW2gmm38mwWLNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ttKA5PjHOC8NPD3qME/MutfZ+K4qRfHvA0jIvM9m1WOG6UN/nxrdOr5RoTTSVFlmCODy3YTTTOw0pZrrMgDqZ3UDGADY0psxQHwnKUd+ymzO79KYzgYYHZYvtU669hfPXHQC0veeBsC5BgAt/uHHxU7oDk9xCmp9SgmyLz9wHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BiLI6CZr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuPg9CnM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BiLI6CZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuPg9CnM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CCF51400109;
	Wed, 16 Sep 2026 13:48:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 16 Sep 2026 13:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789580911; x=1789667311; bh=Fzhvn8aA6Y
	DRBdogCpEUtY4BZWm/fB0Q5OksoPBNKDw=; b=BiLI6CZrlGAclGzY0yFTAQRgY4
	oRDQUeCbfp7+7o579Ilj8kf+XswQpabBjB2vz+U9q/+B9xo2gBlnM2qgTbIeJ+2q
	+HuBokfBgtGHT8R606CDYYqN5UAnLF5idwRASyhHcpiSuIqNWf8EO08WMU7SpjVG
	p3S9odKUr8ixHPTwBqTx/yfNDlSxHnUKZGnAxzROqKN4PYN9kJYyQfeu5mTtZC0V
	8iK32raZvKp/nW1ud/XJnOmZroIu7z5JPIcWE2UQwdPCEW4BAOL82jCxdantsvWJ
	42S2a6xJ5BeCL7CBn/0X/ey7BK5D3FA6fx6fAEv90DnIyNSbT3MYlXpbDOmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789580911; x=1789667311; bh=Fzhvn8aA6YDRBdogCpEUtY4BZWm/fB0Q5Ok
	soPBNKDw=; b=JuPg9CnM5tKDxC/0O8Az2YYhnk8NSnpymkKAnSFa4TnBY8DIT2o
	iFCCeb2Rgk3SxQKw9Tsk/A1Cc56oHpXYcBMkH/t3nOVg3RJ/aLJSL2tAhsOZE4YB
	htPmR8YW4di24E9ZucZgwDLaYICxtpJhWQvFdmZdmmrOQ3XEFDmRcapTcRJwxihf
	cbhmPIUyeinMjqmVEab4/BDHeMXYEQrfpNtrD2s4eyax4rEuqVNAZrgv6fcN85+Z
	hbsQVmQh7PIzgPYQqciHgfJTovWfxf1ci7wBjysf6/9JVxb7w+Cpj6wBNOUUL93M
	CjFD2gA2pYp2mVXZfgeoXIxcyxiTTaRhehQ==
X-ME-Sender: <xms:b9aqanBXijP-qZ5N-xHFy29L1Tc0QzEPLcH5-zWV95rSqodUVkfudA>
    <xme:b9aqavzeg_bSd5xzgF_k1ElrJrxXyMmjiLBjiU6J8voLbnB4FCouhFp2Kka08WRGY
    lQVGaY1OPSp8uZ-QeBfNmqUnwdj-MxtHCLiuREhweh6-BYh_gXUtfI>
X-ME-Received: <xmr:b9aqak01EHRWJWSLpPs3DoC5Jduz8eIjUU47_WrJpI9nprlzU6E81G4-OBaJR8kYFyU9oi830Xz9X1ulr1bwmwkJUDXvQqNJ4iA8>
X-ME-Proxy-Cause: dmFkZTGKjYu/DqLuQrBwfUJn9RPSJ4oVC5XjwVgMmTRSUS9r9kFYTaJHPaYxc2odc9QIqy
    E0dWJY4EKD41py4WLqiFBM84odDgR+s4Q4pOf2iyWfN5oYmP6Ask4L+wNt9dELYaTwwpxx
    fK5eFWp9Vyu6+cDHc1Y8EinNjMEYtho4wrpNlEJBcmIttiUv7/T5THa7kARcbivtVnxqm9
    4AscXFDrZHG3wpqQqGfHE8gcy0cPWDkXyqMq2yxGG3JDPruv8vSWz4+JYdgVpkYQI+/UbR
    ar076UMZCQnGfRaNUvabkr6DgJRXhLLHooHGbedS4dkT6pixk/7ZklJNAO/lC4QeUTIBuL
    3scOD4p6ly/N6OolVbVcM3hES8IJ3/bhVIQ0GE5ZGORJFDE4p0AlCj9sizIJMACUMfFo7x
    tEyw/Tw7ttW6Xjhyt4b54X/mGYB+OsiejfeoA3UpJZC/IH8sjgXBetZsnY/bDy4eWrA1CF
    K1yQR12oM3Wsya3xvkdMvqK/hOv7TbKDGIkxeJ0tg8bzLrIOxTEe8+XhIxb5teAGRJ0ls4
    tgV8ucmuECruG4spyGwH+iifFoJbfJ3ivhV6koqfKJ5MHZnzlOxLaO2wgDFZMbdlPAx1dV
    yZdD4sFTz9WrSqjIPqmyoM/xa8TYHMVhqO1z5LwORHxz6ECzYt15sJjy/mWw
X-ME-Proxy: <xmx:b9aqavxNdXJ_6f0K_4Spl8HRgsUYD3vHDwM2bbg550Gv_gs6lQEwiQ>
    <xmx:b9aqarFwB9TwDPU0pftQ8sMIPxY_Dt2Ole2rHb19EPCyhob6wKVxig>
    <xmx:b9aqaiZh46lvL86zvRo2N1IM4jNH5JD0jp7BeDug6yDNp0metXSK5Q>
    <xmx:b9aqatDc-pXLk8G9v64dFxMI_y63ya02oZZlHVXtaySzXiQRPlbHzg>
    <xmx:b9aqahbd5JpArd0tzIIhvEzfdx4DmjOw7HoEHL6rQHHQNI6_XYqif9VG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 13:48:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Orestis Floros <orestisflo@gmail.com>
Cc: git@vger.kernel.org,  Florian Schmidt <flosch@nutanix.com>,  Patrick
 Steinhardt <ps@pks.im>,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] commit-reach: parse commits in the given repository
In-Reply-To: <20260916134632.1424829-1-orestisflo@gmail.com> (Orestis Floros's
	message of "Wed, 16 Sep 2026 15:46:31 +0200")
References: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com>
	<20260916134632.1424829-1-orestisflo@gmail.com>
Date: Wed, 16 Sep 2026 10:48:29 -0700
Message-ID: <xmqqld91w0ia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Orestis Floros <orestisflo@gmail.com> writes:

> ...
> The latter used to be the only symptom. Before bb5da75d61 (commit: use
> commit graph in `lookup_commit_reference_gently()`, 2026-02-16) the
> initial lookup did not record commit-graph positions, so the walk simply
> failed to find the submodule commits in the superproject:
>
>     error: Could not read <commit>
>     Failed to merge submodule sub (commits don't follow merge-base)
>
> Pass the repository into both functions. git-fetch-pack(1) and
> git-upload-pack(1) keep passing `the_repository`.

That's reasonable.  It is a very welcome change that aligns with
recent libification efforts.

Will queue.

Thanks.
