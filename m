Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E93ACEE3
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399711; cv=none; b=eFa3aHuvHRvl8RPjRzN2rLfVsk+Q2Iebb1MJYAdhWTQ91QkN6rGEGPAnLq2xR9CerOWqvXnS0fx0UaRCb7SFxFCQfqmZURTP1wmCng8EoXqa5/pmV+U+q6a694fJgVL+KghU73RPw7zmWphW6NN5Hwelt+Qk4o+NeuJg3/COrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399711; c=relaxed/simple;
	bh=pf3vPe6NXJvGGEUAvH2SfWalguRY2xGLueUKZ5vpA78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j8SYkvI2RzSwVG7ifM6f6DIZwssIfLqALIiHJDOiI4GlFOoF+Uho+4Fy2YsNyWLrs6o+3RdqZItaLdx/sN84nm8iA6p6z4ha1xrzfhzVYVFBDSQGZzjrm3efNd9QSJNiZ+RUyLt2XDvgPCxQrEyR1L59Cs+090vkeZmUBYJ10eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BmvlB264; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmbQWHMp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BmvlB264";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmbQWHMp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 742807A029B;
	Thu, 30 Jul 2026 04:21:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 04:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785399708; x=1785486108; bh=eKV/n81qtC
	coGbsja4zjiT06QmKqm9zu77V3Gvz1cao=; b=BmvlB264ZbrTTpYcDs3fjv7RxD
	MsHcsHJNd/TAaATOu7pH8BqtiJJ19CyIYcVznG0SIMgdLik33zaupBWnVVX033V+
	QyBeHjJrwucRtI3SZRxjYct68/4+KHhUlfxTTSp21L7yATOobh0xj+4F7b7FZQ7Q
	83PHgYUSx6XiifSRFWZtyEK0ykk+0AQIf/4WTGjPrb2pk/OqJbzOdlAPIE15qw+9
	xx7twYy7fLOrXrs1gRlyQtrIPt1+SCVNojqBltHBYHkj7rRfJVWHg20Yn+/zQ4me
	n939hojCqEcy59kN4S2Q7WpAhDNN2NQ3Udqmlzm8sSG+i0QLk4vYc9CIaUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785399708; x=1785486108; bh=eKV/n81qtCcoGbsja4zjiT06QmKqm9zu77V
	3Gvz1cao=; b=AmbQWHMpN15boMxdSNlJMB086QchBRm4gLJuIoGpwS469iNWzZ+
	ZcYJKm4Ct8Jr6qNIkPthT/0Y9N9ibWCsJWgUB4GnG1NS4+OPOEma+G+qWuQqxiW0
	qhYUZjxivmxsY9up3b3Re7eslzwxPbf+sdDcy4E6zwVsofLmdmu6/oSTXz3W4YiF
	jusGnKS1OE7SsYCcbAsdC4ijQ5ubGVSyOSaK6dnaz8I5FfGfPm5CkBU7UytxMB53
	obMog55D/EgGEuGC1mqWwW9b8qwCnkIahiFsP2YxYeOHGq5bbUSn5TknPnc8yykJ
	H895VPBKC0H+jzTAhMncTSPSUQ8rTAeAxPA==
X-ME-Sender: <xms:nAlrarjKFqgffh5b0iynnG0udaNMFG1QwzurvEO_KbigrU6zXUz8Ag>
    <xme:nAlraveXRy_7OKnwmCjiien02bKTMgjhSQw6NgAJ5t9KMhDoTnaSpDuCqAZTJoxZS
    itvS6zKdUsgS0IBnC95SbTnGPSDii8Q_YR4jU2F7VMedXwy2xdJiQ>
X-ME-Received: <xmr:nAlraoemNfILRpc9eKT6x3NukjyOCw-aAn7P7IU3nkkF-AfVfCizZx_OhlO6ubpeLIzhr5hPnd3UfnqfsNDAzOE-dI1ecjrEZQ>
X-ME-Proxy-Cause: dmFkZTFyYdB7DFv9ycDxTr79lJEBW1EBWYpovIwSAUiM33e/Ya0vJQVqctq6ygLukI3cm7
    xQ2Jwu1iWoJQdc/OklP9DACzREkz8e4nJmESsRAfkdFjh/peY15IsEIGrMYXNSFfk80RYe
    t2bDcgPgceyoL0V7g6PiI5v7QK0QvIRyrQWDAaqCceth9O6oekz+VzG4wN+QYfCrK7AMsn
    35JMEqjVccBMIFRRrVy+djMwPgv8u7r72tRlm+Xu1ErWFNPzt7wuZI863f/3xWrHdbWZ7/
    scekZ2ziJV0jXYPGY4FvApVTFLSlKipoME1ooLWgsap8pLRlSTJpO5r5OFryaKrwYnNmDA
    mOjzdta71XvLq9p3XNNX5wXVVEmEN+8Zq/fdarMCLhNNvGsXhzZySW0oehAaVB2o1TnVb9
    TySO2CtiAiWvnzm5T7QQaYvRgMrmm8Uu+R/2CiL0J8wCZJdpG3lJuy/s5M3iScfMMt8LZ5
    8FAA16FIYWMNDbRq3dQLA5y764/XHL91JtS6bLBEXs2MxqdcUrm3lxJIBP249gI6tY9p9h
    CqgpwDpMWDq6/EFHhC4ORBgy3i0sIR6Af1OGe3UKXzXhmUFuzdHctNaslu5WqjARqYtj4j
    h/kMtoctyiEKMKCgwiTUmYyjQ4fao65mf55mkkXgw6hCyO3fLqZ7IwshxL8A
X-ME-Proxy: <xmx:nAlrah-1s9NsvCIMDrlbJ9-mVErDUkspseN__KTvrAJtPBHjRpE_9g>
    <xmx:nAlraslzM93gWedQYO4rL8QScbW_oWV6hjxiK8veqMWZkCappMQ26Q>
    <xmx:nAlrar9jzH7-b9WEnuGp_hZv1i9aLdW7XT2f76v97RS67BfqACqQcA>
    <xmx:nAlraikci6KIinbTRNDKLETZSJE17X27x8hY2ly5E6bv9Wkt53_egA>
    <xmx:nAlranpL-F9gmw7XImT92fK3NcJ3-X7AfYF4Xo1InH--SEbbD_T_Lxhx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 04:21:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] Git 3.0: restrict hex object IDs to lowercase only
In-Reply-To: <20260729233215.398654-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:09 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
Date: Thu, 30 Jul 2026 01:21:46 -0700
Message-ID: <xmqqjyqclwf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> As far as I can tell, Git has always emitted hex object IDs in
> lowercase, but our object ID parser accepts both uppercase and
> lowercase.  This leads to much software relying on hex object IDs being
> broken because it doesn't handle uppercase object IDs and this can even
> lead to security problems when people assume that an object ID has a
> unique hex form.
>
> This series proposes to remove the ability to use uppercase hex in
> object IDs in Git 3.0.  It is RFC simply because it's not clear if
> there's the desire to do this, although the series should be fully
> functional.
>
> As further evidence of why we should do this, I'll note that there is
> exactly one testcase in our testsuite that fails due to this change
> (fixed in the last patch) and it's not clear that it fails
> intentionally.  If we decide not to adopt this series, it would probably
> be prudent to add some additional tests for the uppercase variant of hex
> object IDs.

Before going there, we should hear a solid argument why doing this
might be beneficial longer term.  "Just because we might be able to
without harming too many users" is probably not good enough, when it
is not accompanied by "... the (low) risk may be worth taking because
we will gain such and such benefit".
