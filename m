Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78311331EB7
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889931; cv=none; b=GjZnrN/1t6/bbhjydA6TkP2YP+GTK87JBVcK8uIl9q+ZxVsa2fEVJuflD4hv9e2xH8Lmh9AbQbgH3RL3C6lUwHSipLa3Xmv/FAg+KhWyK35n142MSUtk1b0KpLKfEMrcKtePfNpSrTuCDgZPWau+goMeJnScSdUuMNsy9n+SK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889931; c=relaxed/simple;
	bh=hG9gqF0TBQa1gHT9NFjqSnNcY0I62GnVxA+RBAG46Qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YdKsG2UQrggDIJJkFz41ygFF8fB81F+gGWLmzTpLSAOe0lgt2Ys75S/R8aCXqJD+Lepkr6o6rDA4JBdrPPfSiw6BgUJqd3k9E3OZdpLv+EnRbbW9cxWwJjxxnYHfiDw2Tx09sjWyjGOnvbcpO+AEMSZQlcl1dfyO3hmqj1Z4X3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RdpD3wmF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMdmVfrs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RdpD3wmF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMdmVfrs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F70A1D0014C;
	Fri, 19 Jun 2026 13:25:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 13:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781889929; x=1781976329; bh=/ty+7xiOdf
	47/jg5jpd5QMb/1y7g8xQNf130yglGKCg=; b=RdpD3wmFw5Zcmoal+nrRq8OBQL
	iyTX0LYmfT95IlsMiYFlbqr+JQSuBHpowkB5uL/rDinBQ3VSdV9A2mrpPKXiaETo
	7EXuXyHxscXIYa4FR+bfcAedqgWQRSce3C1HMqa3Q64Q4KEk5t8wcvrjfd8zD4kt
	dvk4C0gMfFleziU4Nu8pYvvL2G8OBN3BACr66PEOJf6CAxae+8k8f/BhqyJA2QD3
	H9CalWyCz3FcYVEd3VUgRZ5WxqRK5BaEpN8u+SHiO2eEfgL8DzPnEGvGVIe90jRI
	2AO5t1vUwrGeCh1EJ4MkXV0esZqGR2MDOKH1312LgzSYTufB2v8VfkFXJpUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781889929; x=1781976329; bh=/ty+7xiOdf47/jg5jpd5QMb/1y7g8xQNf13
	0yglGKCg=; b=TMdmVfrswaKCpIgi6younf6/wKCXqhndhQhFW3/C+vnUaKAdi1f
	NkzQ6q5o7VTIMCA7Frc7Hh9bZ9WKEWonc9boABdhrAs0irivo00p3fIlFez0kB2V
	SPx7tJHTzMOaxSt4zdi1PfxXHvbkU40x40ZCRYA/EG+XR4jvdkUNm9JQfu6QMfVF
	/bd0k83loee6PUmKY7DLphJPl0TjuBAoZ4Nn8x8xLAAdjIWeukcDgpBgptnqqbb6
	KUcTDWhhFBMTPPvbvUO/5Sv+WmhICWPzTljkgr2FX5XlfcNuyB+wYpfyAA6HZPb4
	Y8dxYwsxsmNUYTtc1CEhnS2CmbabcE/D39g==
X-ME-Sender: <xms:iXs1alvZHASVX2d4LcwQpFAKUl2lsiQSvBelafRy8hEvvbgxRUAxEg>
    <xme:iXs1aiKP5ew-7O62i3UWbmrTbcsURL-fzmSB2BwYS8S_s8SxVVd3JylQaDvs9HYxg
    upr6eZAgnxZtFrVQPiey77uXO0yGO-QXZe35yqr3-UDDiQP6bHxoQ>
X-ME-Received: <xmr:iXs1ainYcdS6k7JOdasLBPbkt1pbF1zEXguxZEfDSJ6u2ZAfAWf1y4MRWwXyeoicGYCHnFov6LNz94oR7xd2jJ3qgwz_9amZP6ip>
X-ME-Proxy-Cause: dmFkZTEvTiYuVspqx9j+npLkOGScrQKa82dzfl9+jQEQQZI/wzo3RMUENnqqJ+jANgHJX8
    MFAvwLCCXUdx+gsUWJ4eonLUqch0KgZcVIX/ESMd9CZMDXnWpjMWxeropWnQFQen1pE5zp
    IJzWNRCFo0z4cpB1n/F0Utn9UkiTQiLAryaFjlBfJ2ZkHDacsuLKaE3y8XuP0rdmKKRaH/
    0H7F1GYJbVVqhLoMazDWeQ0mlyHk681pnpHuyfDlv3yEKAUDrId60+q7+5ICTqJxyU7fhK
    irlB5KoD8gjZiDvXbIYNj0VMu0h04XCIJfhnEHS3T5qQLpbdSPnB6qZ5m2Sos5dlKAhRl+
    0pe58Gy9omT3Cvs0H6Hv16Sv0CkWx3geVvLcRzQvItAYCvVGbTr6o/4FT/hj2DfGxJrw4r
    GLMu2V5Rcf+vOwKaRRfiKTDQerSRRLGU4qRxUXrjGjo2mdnm6mETpcx8UrMmxqZXv/298V
    6Qk4WTlEh0AKqFcQgXYftXDA2WxjE4cgYBb/4dMNz0h+dL/COhpWrmbEdc/0oj5MgMzDY3
    cYZda29QqkjL8pa4w/aufnNW2asftIPaP8r8XvmIXZrl5VTWsUnZ3NXIWaGWT47BVuKezq
    zZVn/G8tCiPDrzcYwPIdF/bdYdoe65EkFXGC6FQ3uFOYL9aAaUpgDhykWLKg
X-ME-Proxy: <xmx:iXs1ajJPZ3Q57PaVXo51qPCXaq2-AVLLMijbcuN8YxGL-3bss7fL1w>
    <xmx:iXs1an5zsSXa7rIJDX3Biy2yclwb4E43dmSZMPkCcIfUEiG6CPTLGQ>
    <xmx:iXs1an1_qcWc4z311UXXj_bUISx_gJmbFkUtHE8E6r3pwkCo9Whw_A>
    <xmx:iXs1atcM-mznKufO6b21u7U7OuYzm7d1yCnpUBeukWM6KobjomFG2Q>
    <xmx:iXs1asZL2t4udb6HbyqB4DUIFbI80InHYWpsxF7Uu-yEjCJEeQWWhj6w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 13:25:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v4 0/1] environment: move protect_hfs and protect_ntfs
 into repo_config_values
In-Reply-To: <xmqqo6h6jvuk.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	19 Jun 2026 10:14:43 -0700")
References: <20260619163823.652091-1-cat@malon.dev>
	<xmqqo6h6jvuk.fsf@gitster.g>
Date: Fri, 19 Jun 2026 10:25:27 -0700
Message-ID: <xmqqjyrujvco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> diff --git c/environment.h w/environment.h
> index fdd9775900..b1ae4a70de 100644
> --- c/environment.h
> +++ w/environment.h
> @@ -127,8 +127,8 @@ int git_default_core_config(const char *var, const char *value,
>  
>  /*
>   * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo_config_values`.
> - * They check `repo->gitdir` to prevent calling repo_config_values()
> - * before the configuration is loaded or in bare environments.
> + * They check `repo->initialized` to prevent calling `repo_config_values()`
> + * before the repository setup is fully complete or in non-git environments.
>   */
>  int repo_protect_hfs(struct repository *repo);
>  int repo_protect_ntfs(struct repository *repo);

Another thing we should remember (but should *NOT* do while these
topics are still in flight) to do is to consolidate these comments
into one.  The hfs and htfs getters are covered by the same single
comment, but ignorecase and trustexecutable bit getters have their
own comments, only because they came in different topics.  We should
conslidate them into a single comment block once all of these have
landed in 'master', which may happen soon after 2.55 final gets
tagged.

