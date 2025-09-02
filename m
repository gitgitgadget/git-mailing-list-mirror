Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40726C384
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836145; cv=none; b=EcIBlNxGqPkX0srW6EYg5RTiVogrcefp/A4MUkmT2J3iZSa9lY/vncHDonIcllsTSGIhJu/ylWiIgIKoE5giaAM6lskBTlxz+jtzXVyG5bOxeBCvdgIjPbxr8MsS5/kbbEHeXS9RF/iEFeE6UYrh4k3rLcITy09aVBVCfNzT7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836145; c=relaxed/simple;
	bh=mvGi/GF8/ruqzhHurvKKM8QFnKqy10CFLX0lmh0aPMQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZB8xMq4hcCEkRrnnyjvTPjume/XElEtuaAB/mFox3Mwiz2zxmS2ZoKnqzlsSYcI49BFnkJQMldnyaDLPo+x8kmSCQaQJ8vm5v9F3Cl+FFlRx4WJumLzNzsH7bWGTYJsdZkd+odALBd5LAUOEU6S1V9wTDd6k8DgvdrPznyoHcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T1s8V8uw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQo2+pC2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T1s8V8uw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQo2+pC2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C1F6D14000F3;
	Tue,  2 Sep 2025 14:02:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 14:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1756836142; x=1756922542; bh=mvGi/GF8/ruqzhHurvKKM8QFnKqy10CF
	LX0lmh0aPMQ=; b=T1s8V8uwhCgqY9xutBidudZCcsCAIjZNJJAe6luZzh1gNrMS
	NpgY+kZfb0ZY3dwQQpAoSHGw7NyiXnCvxKAJQlvgYwRnnuLhBiUzSNYHjaEESBsc
	m1GzhrjyE/vIBwgCw6ELTsvDHArklUdXc5+dcv1UQgnicLGk9oi0hqfXseFjD2O5
	h0lAORaI2ZW93bEoQQBr7lqVVY3mTJaAMM2MhkoiK4AheCpyNGFl2i3jIAFfg58v
	49Z6fYUg7mC55JqRKKZSunQzAUgF/z72XS5qIcvF8+1MXmztoNBubwWP+iTrt2FP
	YyM9hV6uHlpxOCwOmfT3sWoCMzPAuFWNSSVpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756836142; x=
	1756922542; bh=mvGi/GF8/ruqzhHurvKKM8QFnKqy10CFLX0lmh0aPMQ=; b=I
	Qo2+pC2uM83g50t/QA8QuA+SHeJPRll6kp5dYHVjbJCUUS/0PO8rBzc2SQGwMfgY
	YEAXEbI6Jy1Jo9/Jds0F85fO2ZAga+FyLkfiuedTGzGCQYz9sx4zf2slWH01HDED
	ZzQW02jbX/siAdPYP6KMJbdgRBDvo6s7dy2A8gzqtOWhLhelgy0OaCyze5KjHn6W
	Bg3wxQPtqipFqu2tnGgBShi+RbIvvsXcIXj0PMP8Vvhujbb+BDHixiSXB8yprveO
	7wMV3MhET4pkUCfmqt9xDfh8V0k02FbhhLME37+lsyr0B/vs4fBw0byPb0EJQSfg
	eseTZ4F/zo++VpVqIN/sQ==
X-ME-Sender: <xms:LjG3aNOeowiVL9ElpQBZbEY9m-smC46pz93_PTczknwh0eKALDecLQ>
    <xme:LjG3aAIoKUfTQES5l940rn49MZ1SbRSnYgFFEsz7egR5tRO6FEnnMj4UYyJ0bb05u
    oF6Eg1b4nhk6hFQpw>
X-ME-Received: <xmr:LjG3aOEdKgz2-LGeWcBfs8jICAr1_iQOz27iFB2MJ4Wth7r8yT3wD_f6PLFCf9R-jfmYNGuXyaHQLDEvCPcgp-0p7p-5HeyVCBHfE7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtnecuhf
    hrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgt
    ohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftdekfeeuveelgfelteeiueffffekhf
    fgkeevheekhffgteejhfffgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtth
    hopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LjG3aIRc-ZdmD_zkC4wRFiZXsJnwxvy72hgUf9ooOoZxDnYPA4mcSw>
    <xmx:LjG3aKHnkh3T_WDSYzyS5vLv783cOQJD2lTSjnyWKJ_YsPE2t5SNUw>
    <xmx:LjG3aE_4p5UuOz9jnKih8RlOVlalIRO-YJ417C35rRmdCKRd0rJszw>
    <xmx:LjG3aEKrQb7SbR7APREmRsD1gHd6CYVZOcY4LSO4Kf3kIgftK3M0Vg>
    <xmx:LjG3aPx_47dLdC62UvkzNA_xLPPZMOKnXv2IgLtPuWm9E0Qd3zmHcYOv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 14:02:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [Bug] With "[remotes] group = a b c", "git push group" does not work
Date: Tue, 02 Sep 2025 11:02:21 -0700
Message-ID: <xmqqiki0ivgy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

... even though "git fetch group" does and acts as if we did "git
fetch a; git fetch b; git fetch c".

Yes, I know it does not work, but I think it should.

Expose get_remote_group() and struct remote_group_data out of
builtin/fetch.c, probably move them to remote.c, and have
builtin/{fetch,push}.c use them, or something.

It probably is a good #leftoverbits microproject material, albeit on
a bit larger side.

