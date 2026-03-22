Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F011DE2B4
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774150275; cv=none; b=mAYd8Wqx30+fYJmDPCA++R4DG/IFQbB121dMDSYM2rXUuXm+ikGUWqJaSwby0sN1B5+ZQNf+iWI3/5ArIwvkoeDHKzDPm4fNC5EOU7lVAoCAjWD+BxnlDPV2rR9Nt9T+RII/PL0mjFqiJkbTxWVtCbkqiAzOwllI/LaYaTX3J5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774150275; c=relaxed/simple;
	bh=VnRe2DuYXqi8MQjTbELe/aMvoct/mI7J0T1z4hu8rI4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=q7ZFPDzHyjY8XpElmzbyBbcADRqfG96I472adIGisOaOREeKWf3Xh5cbejSdejfvSa3ASkAVJKGum1o9Y6+K21F3031WBcFKp3M/0WBV/40xvEumWo/jJ6Vz9J/CLZ74BvBpKQOGbaDydhDbU/9qppFgWBvIlfbXsjnYjoXBYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bO4Vmgyf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlOqtK9R; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bO4Vmgyf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlOqtK9R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 505337A01D2;
	Sat, 21 Mar 2026 23:31:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 21 Mar 2026 23:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774150272; x=1774236672; bh=eJT5+CvYcn
	eL5KYn0OvS+++n2c/veF7Xf+CTE5VAu/E=; b=bO4VmgyfTe3hP7OrBlLt6J3aPQ
	lEuKVzPMxelKGDyWXiEFLl2DXO0Zl97Zp+rxJKMzKgNMJtdChSI6+ejqyucmTt7F
	dAqtQkOB7oUZucpamJlmPYGbJQJM2YE8KGRXfxooPROblNUsWPW5xV7y+k8hgMcL
	O2vynJm+L+tY9o/JhPH31wISL+vR35WGqgs9xkmbUPUKdq+s4F+xxSMJey2HhoqB
	9YlPJtdDmYdT8pGOcyB8PYb3SEyGVDLDQMrlpgoRFk5XTgqfpje58BHRqUveFoef
	Aov+VESsmobstXf1mO0FPFYiEPbVwnYySzezHGt5ET8mcrHu9dcTY/iAFkLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774150272; x=1774236672; bh=eJT5+CvYcneL5KYn0OvS+++n2c/veF7Xf+C
	TE5VAu/E=; b=qlOqtK9R2J/+Gf9VE5RBG5nmkVqZU3xtwA44F1BXj7tlZaxFDBr
	vToAJylw33CACBaCuqNm8nPVAk5ENAXYUTVOdLj6gy2FaVbrfMYHZR78lOAXlvIg
	y1nMbGgQAzk8JCFT+T1LrvncDKTcMSab526Xqzvqr4SoW0Bf72Jc1J9tU5yqlzwL
	9+U72uyfq1fwOJDpLTrzXCD97ZVm0W5KqfEAl2B3BZBjo3lwrYrJk36Q3UpKUPVJ
	l2/1EK14+TIoY2oqMVRlhErb3Mie6o9/O1xzcxKcAlpb2oSyegSdTwmEl/4OGwrE
	fjJO+s6VpFlglL8p/jmFhRVZylzXvA5eI/w==
X-ME-Sender: <xms:gGK_aVVzb5V9fzIbk--GpW4rNbQN91XyG4A8AYVVf4P2-ByK7pHC7g>
    <xme:gGK_aZS638Eqq7yXCo-EOnmQAFJp7-3igX15Yw6MkGxIKHViS0AJDMyTbrEDiFbJq
    0PQdc-yE1Ph6IV4WPtz7qFlmKWHL8a8DCHAWDBEwydARYyZGE81Fw>
X-ME-Received: <xmr:gGK_abPDFi8hi0YeXGaiL4nT9FgUYl-7NHijCdOcfFE0q00dwzBaOBy-5Bo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudegjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffetvdetfeffheevffejueefkedufffffeeltdegieeuffekveeludfgvedt
    ffdvnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdqshhmrghrthdrshhhnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhholhhishhsgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhholhhi
    shhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gGK_afSUdQdIjeExDuJvDCLuQcCd1XZgp_nmYOYfwxbExoeWOiqEtQ>
    <xmx:gGK_aRhzSSDukc4g0naezK4r0Z5_yy03pT4ZoLtggZAp-B1Aix2YbA>
    <xmx:gGK_aQ-w_TVeK4S4jCDMkV8IWPtdsUM8x-_xzNt7YrmCZPNBHgf3hA>
    <xmx:gGK_aQHnDUd1O-GnZ6UATaokjIOB45ecfhmWjUQ2wikfH0d4rJUPKA>
    <xmx:gGK_aYFgjPml7zMsTeFTWTdyBWoolgD6HNtJzv-XmziKSZyJqT949vMC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 23:31:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  joliss42@gmail.com,  joliss@gmail.com,  peff@peff.net
Subject: Re: [PATCH v2] refspec: safely parse refspecs outside a repository
References: <20260321194653.24513-1-jayatheerthkulkarni2005@gmail.com>
	<20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
Date: Sat, 21 Mar 2026 20:31:08 -0700
In-Reply-To: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 22 Mar 2026 08:05:57 +0530")
Message-ID: <87qzpck0ar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Additionally, while looking into the remote-curl execution path,
> take the opportunity to remove an unused `#include "git-curl-compat.h"`
> from `remote-curl.c`.

I wish you didn't do this in the same patch.  It is completely
unrelated, isn't it?

>  refspec.c                   |  4 ++--
>  remote-curl.c               |  1 -
>  t/t5551-http-fetch-smart.sh | 15 +++++++++++++++
>  3 files changed, 17 insertions(+), 3 deletions(-)



> +test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
> +	GIT_CEILING_DIRECTORIES=$(pwd) &&
> +	export GIT_CEILING_DIRECTORIES &&
> +	mkdir nongit &&
> +	(
> +		cd nongit &&
> +		env GIT_CONFIG_NOSYSTEM=1 \
> +			GIT_CONFIG_GLOBAL=/dev/null \
> +			GIT_CONFIG_COUNT=1 \
> +			GIT_CONFIG_KEY_0=remote.origin.fetch \
> +			GIT_CONFIG_VALUE_0="+refs/tags/*:refs/tags/*" \
> +			git ls-remote "$HTTPD_URL/smart/repo.git"


This complex "env" dance is probably uncalled for.  Wouldn't
something like

	mkdir nongit &&
	git -C nongit -c remote.origin.fetch=+refs/*:refs/* \
		ls-remote "$HTTPD_URL/smart/repo.git"

be sufficient?
