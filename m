Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD927510E
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252856; cv=none; b=la9wQaMdtNBW8UiTpwqf0J4l3l/vIX5TwVPKUB2EBHNqsqLREuKFzzQcayn8oMx/M24bNpBfLHz8BBNbT50vKuO+XRbqt88E1TGtUa1earACfXiqGOHcPdxQ2AnCtXDBlCYGkoT8KkFoHV8lIb91FeNwVgU2FRtMT65sJo5+p8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252856; c=relaxed/simple;
	bh=DC15a2i6mBuy/W4s0FerMltrYEZHaLLp9bUyxjN1DdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HWDgRfKBkIWrgwZKpRDJ8bIFfH0IVREGoHddoNfXsusyo/jzMTgPneRpEUYaIuah70/8k16ut/18/WHVHJQj+QP/rKcSQuClQJnFjZaT40aEK8B78qY7n7c/fr+pogltAKtg7B9eDmcr0SaXZpnAlmNY5ms7VrQWqDQx7wudIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g8z/HiqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pM7hBi+c; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g8z/HiqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pM7hBi+c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 762F47A0133;
	Thu, 23 Oct 2025 16:54:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 16:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761252852; x=1761339252; bh=z65nliQEes
	zTQCnx6d+jMcCBgVD/gXXcY70OAf8bS/0=; b=g8z/HiqY6Zy2QFYs6MlYOa+Iqy
	IUGLfAiOxV6dOdNOdAFqCs3ZDinta9Cy+fxWvAPtpzaM/FN3/nmCaHjwW99f2pFg
	frgHEbxcyGqqnQOWMrtEoERF6wT7RmxuI7H9h+hN0S6XbqfOkBKw1qJxOfmgBkca
	D+tLAyXFO7FBgtw/1XKNHeDOajKTPNs3YW4+vW08GsNj//Zd61p80HExWJ6gN+Yq
	jTqxg/tJTDEu8zISTS+eau8VGMNQC507BiQ4CuRDpYmuEaIkbepGYW0HGMO73dUR
	ZMAcLI/8YA/xbDuEQHdq9dXuQOc4phm8JcA1CLfKSAz/M/Qj41/K2Ougvxtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761252852; x=1761339252; bh=z65nliQEeszTQCnx6d+jMcCBgVD/gXXcY70
	OAf8bS/0=; b=pM7hBi+c2n4gVedLmoe/Y8XJHeITpj1hpyDL7hnod8ORDGSrIZK
	27OGJlJxCDNhiOnEz0sSKIe84I6qd6tiXLaFUxNZa5+WZ2jqfoex4QOIZQGq+5W7
	FI7xu/k6HKQfnTHOPx7cy3QVCgTh8P+/GtBwZ7dgPXaMw4CpDq/eqFLR8gr3FuFo
	IfAhVgtdSu3FqNTFMGWtFFaDQ3jm3BtrmXqGiMsrBSAsC4lZhsT2DRqyPxJu6QFk
	B0+KrkVM426GjqLtbIBMp547jB3n4YrsveNX19Tdk3egBEW4WzIjjgLOslwO6Vw0
	vFFKa42GtNl5C8A3BBuDhwI/x4RJHOVjWBQ==
X-ME-Sender: <xms:9JX6aNg7dHXYBcYRNfEdFFLDbvSN9sMy3ynnNlE34m5is49i-n7Msw>
    <xme:9JX6aJBLkE6hrha2NNunBqclANn5fotuk_IClzxxFyjegupao_clfBdZjg_Weohpw
    fGdOECZMTpXa-1TYINAMzoTU4y5KsGMr8Y-d1-tdnyVhNpqNakMYg>
X-ME-Received: <xmr:9JX6aCGa_Q0GIPzqHZ3fkfVoQm_bQSid5Pfk2KplczJiXCgaoetlIbe5nXnfYMs15H0kF-1SyLkMov1i0kzY63MfPVvWsdQAeYnZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9JX6aBJUAFupLRSrZDCsX-kkz63r23hzgLTLxclfkdnuiYdfl_SRtA>
    <xmx:9JX6aGkthdSVSDYrPftu8Zab_k6oI9-_fBcs94zdHvdYGfXqW4Aixw>
    <xmx:9JX6aJT54lx_cr8ao-cHwyEQyPIdRldQwGDKg7FPtnrys6RmiLc8vw>
    <xmx:9JX6aIJPOm02fdV-CxGp1QpWYufE5wYLJGAVXSW_8RV6pYJwsIK2Rw>
    <xmx:9JX6aAFj4ytnE2hk2hpOGOGqh46CzwxPP6b8GB_TflkDvIvxodR5Vv7C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 16:54:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] refs/files: deprecate writing symrefs as symbolic links
In-Reply-To: <xmqqo6q8uoon.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	15 Oct 2025 09:15:04 -0700")
References: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
	<20251015-pks-ref-files-deprecate-symbolic-links-v2-1-0529ba48db41@pks.im>
	<xmqqo6q8uoon.fsf@gitster.g>
Date: Thu, 23 Oct 2025 13:54:10 -0700
Message-ID: <xmqqy0p1s5jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The "files" backend has the ability to store symbolic refs as symbolic
>> links, which can be configured via "core.preferSymlinkRefs". This
>> feature stems back from the early days: the initial implementation of
>> symbolic refs used symlinks exclusively. The symref format was only
>> introduced in 9b143c6e15 (Teach update-ref about a symbolic ref stored
>> in a textfile., 2005-09-25) and made the default in 9f0bb90d16
>> (core.prefersymlinkrefs: use symlinks for .git/HEAD, 2006-05-02).
>>
>> This is all about 20 years ago, and there are no known reasons nowadays
>> why one would want to use symlinks instead of symrefs. Mark the feature
>> for deprecation in Git 3.0.
>>
>> Note that this only deprecates _writing_ symrefs as symbolic links.
>> Reading such symrefs is still supported for now.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>> Hi,
>>
>> as discussed in [1], this small patch deprecates
>> "core.preferSymlinkRefs". Thanks!
>>
>> Changes in v2:
>>   - Tweaks for the deprecation announcement.
>>   - Use "textual symref format" instead of "symref format".
>>   - Warn after having created the symlink so that we don't drown out
>>     messages from `die()` that may have happened in
>>     `get_locked_file_path()`.
>>   - Link to v1: https://lore.kernel.org/r/20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im
>
> Looking good.  Will replace.

Let me mark it for 'next'.

Thanks.
