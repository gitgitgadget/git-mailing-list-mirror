Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0B22A4EF
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614101; cv=none; b=kVQFt5HQYllN9bcIVXyh0j0lrhqKbuCUBvH8TT4YXTzAAizcr6vT73om5eINxs28bEH5Uj3qxm/MIq/T+nzQahCyDKPI7irKX7uJL+ZDNPVDDxbGoOCbyquTKqeET8jkll/+ScIoAW3HV/B75Q+Afzqwm8cabd97z9kBkkDQ2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614101; c=relaxed/simple;
	bh=CTVFlurmaSbqHWcmS9F8QMnwIfvCXeghi4VirmlbGaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLS4cRt21yWKJav3+fs/N+4jj7H/u/2NFUiSZLq3r48cVhAjS5CSh0TXGzikvTS4X6udXaNfPITp+Te9w3e+UAbhn3BquKvR4JlSUe6iHd+LiDJK/oWpgagdNcan804El7u0Q3wuLofaw2YIu4bAlLFO4nKyVXnP5u54SWxV/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qsir4zqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpFhOvOO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qsir4zqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpFhOvOO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D7A813802AF;
	Fri, 30 May 2025 10:08:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 10:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748614098;
	 x=1748700498; bh=2zc67D7TbRumPNdiiSfbopUWDNYwhCg9g4ibTjCB/o4=; b=
	qsir4zqrwIX/hYMX1TlxfbOvjtXCxofFvyCXgTlWAPgz59Ts+bD4/N2R5RaQv9s4
	JqInOhIsmxLVGkq9QISXGtnefYaGYBc3kmpHYldb/qv1Gq9TFTb3unK+voecxaul
	7YRu+kK0Q3vbID7jlRdCcceUB7s1tpOVVEy6uCQLBOIXyJiy1VwTxlcO2LHhoH3r
	HUJVOfCZ1BVMr1a8H8iJjembY0wreYMzzZ8zMmyw2a9rYM33uSKZvHvEgLKZdxU8
	ARbD5r1IIXiywh0MWFYvKPLNbF3wY/qbCNbEI0ODyt9Fxi0vayJsMYm9yb/NSbIS
	pi3uI7IqWz9fWZ2v3acqlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748614098; x=
	1748700498; bh=2zc67D7TbRumPNdiiSfbopUWDNYwhCg9g4ibTjCB/o4=; b=Q
	pFhOvOOPxeVuvbCmkv1GrCgIpQK+rMQWvsq4iE283vGNe56pruVxQy2Bwqdz0vtE
	hl5mhF7RbncRqvA+cDimSJWgrZ+faagl6RnhsGzN1WOZH3vDGDhaK04Q6ZQ0IJka
	JMXJ90Cz2ZxunapYj+QVDAyUgi7kL1aZke3ZiZCy3AMC11nl9DyAnpjezspbsDHN
	aRAZLKozN6jh/97lmNcv5bOBTy5DZO+8pBX6bpxzsqZlYJMspxrDeug3+EScTKcR
	cb59OZbCR5ly9u48A241/enLWJaoLRk7n3/lyQHz+BZNP8qzQL6XkLIvxIqFiW7L
	0eCp5Utxdp+i6ZsBo9Ytw==
X-ME-Sender: <xms:0bs5aHxo7UybF5roe1uUlVGMU05CuzS05T2Nj3YvpC30OeswECN0FA>
    <xme:0bs5aPQAOy_VCWyA0in_UyrXcTNecgJROtMKZXTM_IIgSoCiTG4-yIwuxXwiUHlpN
    kqowmZ6VCjXxIljgw>
X-ME-Received: <xmr:0bs5aBX4So_yKSRJRkOQKMlZE1DfQHo7t9RwDBM61fPwgz__Nm3uzBZ2WtW4FonjXZvlZIHUXH8GkZfpJHDMWsVKvgA11ecB9Wop3xVs_KAhMQFO-dy->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtudenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruc
    eothhmiiesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepveduueegieehtdeg
    leejgeegveefiedtfeeuiedujeeiffdtgefhkedtfffgfffhnecuffhomhgrihhnpehphi
    hthhhonhdrohhrghdpuggvsghirghnrdhorhhgpdhrohgtkhihlhhinhhugidrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiise
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:0bs5aBjrDYy-4Bh1FMe_bqJGe8LxlEbqcl7tmFek9NHxuGgql2UtEQ>
    <xmx:0bs5aJBtiOk1IPZd9YW3svVGqZBY0HpYP82hYWXd2nC6Xes_2HHaQQ>
    <xmx:0bs5aKKiLGMmKxbkziJ8v_L7d6IkNtqSrB1hiisKSjrd45CJyeAOdg>
    <xmx:0bs5aIBcFDDoivfWbxYdftnGlyooPFRKMmPA7kmy5lq501qvhBSl3Q>
    <xmx:0rs5aFVxrIzN5bi9bPMp8vT4RtA56muefmYJN8E69yYhZgxVa6lU6u9I>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 10:08:17 -0400 (EDT)
Date: Fri, 30 May 2025 10:08:15 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/10] t983*: use prereq to check for Python-specific
 git-b4(1) support
Message-ID: <aDm7z0PEtfzeKBI_@teonanacatl.net>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
 <20250530-pks-meson-tap-v3-4-676f5e41f2e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530-pks-meson-tap-v3-4-676f5e41f2e4@pks.im>

Patrick Steinhardt wrote:
> The tests in t9835 and t9836 verify that git-b4(1) works with both
> Python 2 and 3, respectively. To determine whether we have those Python
> versions in the first place we create a wrapper script that directly
> executes the git-b4(1) script with `python2` or `python3` binaries. We
> then condition the execution of tests on whether that wrapper script can
> be executed successfully.

s/b4/p4/ in the commit subject and message.

You did make me wonder if someone had added some sort of b4
integration into git though. :)

Tangentially, with Python 2 having gone EOL upstream in
January 2022¹, how long does it make sense to keep
supporting it?

Debian Bullseye² and RHEL 8³ both have python 3.9.  Are
there systems in our targeted support matrix which do _not_
have python3?

It's not something to fix for this patch, but perhaps if we
no longer feel obligated to support python2, someone may
choose to remove it from the code and simplify it a bit.

¹ https://www.python.org/doc/sunset-python-2/
² https://packages.debian.org/search?keywords=python3 (even
  buster, AKA old, old stable has python 3.7)
³ https://git.rockylinux.org/staging/src-rhel/rpms/python39
  (RHEL makes finding a decent URL a pain)

-- 
Todd
