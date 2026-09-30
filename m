Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D84DEC38
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779576; cv=none; b=nStBwAQgo50wNBQUL0PXBnQMPdBY8qRpD6FBp668P9GTawb2gXE2ux/O/vDctXuenMQtwfvzbSwqXQVbXuyPnigg/8WVpmAqU/pV4cPm4IegJVOPvrbVoCeYxQdjQO9sQb+KiPJP5Su+tKo9aLK/vYUQ8xvHojE/uT4ffOI57Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779576; c=relaxed/simple;
	bh=01N57bM4LMXAYMB7aD/qyAhQOuiFzaXes8G8DxEGmQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS2kzay3zfnCeoDssHa4fwzgCloU6LmpBNduJWbWfAiqQc8jtJHXTlfHPN9gPh9McYG3ehT5iAi1zysldL2fg34Pekke09YBjOAZOv6UovJv7GeUEMTymbQcI+YMZKOH718azaREpyKsMN4hQoh267KoP0OUrYpi41s4Z0ESc78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f7zo9DjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZ2gT/QS; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f7zo9DjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZ2gT/QS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E9CBEC025B;
	Wed, 30 Sep 2026 10:45:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 10:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790779558; x=1790865958; bh=x5B/sTSGLZ
	iyT4uvTIMUWU0or15+287mQeXTfgNzBUA=; b=f7zo9DjLBq4/Bg521T94VrbmXY
	b6Y+wndj85B/eUGt8cs6kl4cWQpl89aaYIYwwTmbfpucTm9I/wpDj3wylFMKTjlE
	3EPdBufQeNpzEqSVGWr5mgo68jcFvVJ1Z1d0zYdZz5DBEoWmiJj7EtD48BaLsuki
	ib87yUm6lW6DvqE9TUlt7ouKSAAYy+JNRQgEQiLkJtKkwUywlOf06xFPy0YTl4rk
	vghAlXKOK+HD4+v3mFeJtmuwdY1qi5TER/C5BYVWtXdV4ieqLiJS7b646gubqqhh
	S+Qc0UPEp5//cIJG+aoVfqGV8ZyOp4ugJXOnMErK94yUQ6X/Vp1+TS2RXBXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790779558; x=1790865958; bh=x5B/sTSGLZiyT4uvTIMUWU0or15+287mQeX
	TfgNzBUA=; b=RZ2gT/QSDw5CHnc4121QWHnwb0fVpKSfAkbCaHQp8LCLptfqjT3
	cfgKF2xrzigdRjtneIUvw4/+Hdf4IAo6iqlEMUgf40fxpnNmfsB6HVtOtKu/kR6G
	4MXe2XSd3xgeJEOC1oWzXgd4WARLWKJQgfiIHY6++gZi1zYB6IupiI4nxu+q8PuT
	NJHp4OlDbc/UpI5p+4CKO2EawGEU4HULx2mufPUQX1WNhIt9dVUU//TYncXY8Suk
	dpkamTqredI6mNN3j6wm+Jpc9GP895e8Peth3I6eD7beINWzMFYmnBtRd2wI5K3h
	llAbCiOQSQ7h8L073PWWbltPtosodmj23Dg==
X-ME-Sender: <xms:piC9aqCHYC01T57ThsZBa9BXrbcZwfey9hREFx5EbNlk0k6WoQxOnQ>
    <xme:piC9arg_ojY2o7QU6oYf9bNejrld-wnAaCTcyQsAe8zdAJz9iWkHaSO-muKihzVYQ
    Vy7BYbzKE22tRvhS7I0DQ2_oZ6k6MmVsz4gKf9qxg4wjvbVG-bqrDg>
X-ME-Received: <xmr:piC9ail_3sNTGmK51bJoJdbaSTzN01G08oTCC45UL6lPptS1Y6fkMA>
X-ME-Proxy-Cause: dmFkZTGx/okesKsHLibzKu8si3YLEHbYIw9SLiWYvpV+KLrBiA0Fqbb2RAntn8gCSjO5t/
    lDyGgFzycunqXHl2nkCyiDnBIuPEp5tlHIzVkFEXq+AIsDHxQdPnlzv+3Tn31tzU6YEGel
    7+Cltgx8Uii2UzTdIk72xEB8qKkAaSVFRewrt9474ZvpqpIhIIScTx5w0Da+VIJOaTi71J
    CU4RPWIMHe7pvL6MXntKzq6VgsImr2p47/J2d05ApA9/dM29d0ovFCYlT0tQ3yKOa3to/f
    EuSyESnebsxaIrD7glZZv9A1pWKI2Juj/TIht06VW19yzOy4PlfaxYz3MpwZRt61BOmCbn
    WhS3PDIJFwFZirEz+Hx9ERouZ/wa3y4Z6gSRoRNFakSOtPC6EQ4Fx6lQvRMu1HiTT+EJVM
    bkKvE08pTv1PQZdC0lLIocxuvL6WAEkJ7qIA/x8A8fpoUzH721uwJycPFY0uXikKnJhwSZ
    AwOfs7xYgrJtGhb956Srf0ilmtooiY3DB3dWPdU8jjlChRukKW5XKPw9Qu8BYF8yqN3m9m
    qMVCrvTEfD5okCjcCIqV6WvHuBFfemKM13FgrLe9KgGFiyVJKzBIFIRkhHkQmkW/WRFxun
    d0wdTMo+DCdRI/wYWsNgJAsEIGdqCwf4a1e6qNi7038uOGV+4vSH9LqHvfRw
X-ME-Proxy: <xmx:piC9anoI5-yNqKulPgZ8Ag077-nusmoThVJb74dsvuVtrrWCdU6nhg>
    <xmx:piC9arFttblzKc65JzkFvJt-rLCwBBqY8Okn4iZSHoVjbzLWeSFQLg>
    <xmx:piC9ajwIj_6_HTjtFCg5vdiquv9LP9XejWBvNWXdCGH9U_HESWswxw>
    <xmx:piC9agp9hwv4-at2WjOsALltOQpKD7vM7ySYUZGHqufVs6ViUEYadw>
    <xmx:piC9asiXj-hcoZc-GLDO_VzfO3WRcCzX2_JWjPne033P7rVH-k5aNMla>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:45:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53475fbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 14:45:57 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:45:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] ci: use cmp and align job-count selection
Message-ID: <ar0gon2VE0RlG_cC@pks.im>
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
 <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>

On Wed, Sep 30, 2026 at 10:20:33AM -0400, Tamir Duberstein wrote:
> Changes in v3:
> - Use twice the CPU count on both providers, instead of adopting
>   GitLab's existing one-job-per-CPU policy.
> - Include CI timings and their tradeoffs in patch 2's commit message,
>   and explain the use of sysctl directly.
> - Patch 1 is unchanged.
> - Link to v2: https://patch.msgid.link/20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com

Thanks, I'm happy with this version.

Patrick
