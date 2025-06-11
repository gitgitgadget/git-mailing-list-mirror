Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEA242D9D
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677592; cv=none; b=WZlRImkys6pybun5R2Rb9/z/jr4gRxOQg6xNibRlZjRX85ZETn5ypqBahfNiU7retFO6HaDEqyBXy2OZayGEn2miwbYaVSWkFiAfGIvP2p9q840imL/NJJja3lx+FS6dqlqzbq0Ufo7g2qTxSubFk7yhSyzEBcaK92w9ucfzybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677592; c=relaxed/simple;
	bh=AVpO5WEd+Sl9zqsImXyXMtoYMLN32tQ/2a4XFqfmmSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZiIBMZAkR7+/IqMYkFDTKttBVM7yvrCL3elK66TauHgmALPBiL2qfhVvj9TAvKoKF46iindMAmL3Fx27Y7CPFscydobN5yhMpiS0FpuhVnUEbh0Y0SAK2tW+wCVwHMcOBBF1hXqmhbe0jp9fry9eAiytw/zO7rwbT4zD6evUad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NCwVE6zP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wy1JqpNp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NCwVE6zP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wy1JqpNp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CD5A1140198;
	Wed, 11 Jun 2025 17:33:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Jun 2025 17:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749677589; x=1749763989; bh=jdj/hVWzlj
	Iq6ntFTi43ykhMQht0RFLSEwYUHDVW4b0=; b=NCwVE6zPOS2ECuu/pejwy9wHeP
	BkVqkmdje9t/kY/UXvWHx18nqStl+lKlAWd43QYBHfeV/btaYyKwi2fEq++dESkt
	tPkwIY9+0A0OXKEfYul4FCcv+K4wGQmoia0TsNtKBLLZ0NrJhH5+Vs5NjUbTpmfP
	nO/IGoS1bdQSG5zuk067Olxg3IK8rX+ujSpQengL0+CKpuEB7X62Pax86twQeysm
	yYduwrvxZHRgbOrHN09V2JwmHwxpLSD9f6IxQy8ny5dMTyJ5oHaO7zPY+wNt3x86
	zYRbR5m1nuu7JsvnCRdeCHnNGxEui+tl7gv6sYPTa+yF1AwMGAl1sPSk8iGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749677589; x=1749763989; bh=jdj/hVWzljIq6ntFTi43ykhMQht0RFLSEwY
	UHDVW4b0=; b=Wy1JqpNp8zFOU3QKyNe22Cj0e4ChxKIFAzA39OAaO2ikj70dLWN
	9jyfqOdrgyvbnqixMSxKc4FrpTbA2FN+g8OR1zE5bqDSRG5Omkjpl8UxmgtSdnPa
	mHhIHAf3olw/MybpqwubthTo71AhpcSFz0QiGQsMJo+2Omzdq9841A86Hd4DwfNM
	2VmFNqBpIXs0ZAMRhN9uub58JzDEsKV5cvI3B2Gvv97o222t/P/dbl//YM8sqHj3
	6WfVGCQd7ciL3FuLLPQ/Ov6lygbBdXI9ZlqfXpWRZfR6IIDucP3ptf3X9fr8qKRp
	0fBDfAbCtWL0zqNUa2Jn21kjR8ZgD6eg+VA==
X-ME-Sender: <xms:FfZJaAOD984i-kHRMEos9o7-h_H1zjXb9vnxNpAGpPCt2BVRGvUCZg>
    <xme:FfZJaG-W0SdzNfNa9ut--n1eKDDIURE929nLKjEjSCT42BXELSkjlsBcASlMp47mU
    E-YaaRcjdDYYvMncQ>
X-ME-Received: <xmr:FfZJaHQfGSnK2NLeAARVTqZ1Q4sFLZNI1DvEoxPa3Xm-mL6T2cr9vkMto-XcMKqbMdaQTx5I9dxUpzM5dZFaeRsJOqK8zGxJWGIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtgho
    uhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:FfZJaIsIyO0P3YC3DpnP_qzUAbrVw90cXjCLQgm9WPvyGD1LP56OZA>
    <xmx:FfZJaIdJQJxkkUMz2Pr9nfENaUinu2llhOiOA6eR2NZQPag6IkLZkA>
    <xmx:FfZJaM00yaRLWdOMPa-d7w3J_lFHbnLYscIEu0Uv12_tOBqervDo3A>
    <xmx:FfZJaM86tdS4FugLLIISObA21wGrm2EKC0DQozu42fSjdAO3K5C2mg>
    <xmx:FfZJaEKqoEHEXVptcZ0TbmmUD1-DapnlUKjVjVlGm5mh5zyBVQr0VcK8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 17:33:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com,  ps@pks.im,  ben.knoble@gmail.com
Subject: Re: [PATCH v3] environment: move access to "core.sparsecheckout"
 into repo_settings
In-Reply-To: <xmqqmsaegf91.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	11 Jun 2025 14:06:18 -0700")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<20250611173433.74393-1-ayu.chandekar@gmail.com>
	<xmqqmsaegf91.fsf@gitster.g>
Date: Wed, 11 Jun 2025 14:33:07 -0700
Message-ID: <xmqqbjquge0c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> My gut feeling, if I have to choose between "lazy loading" and
> "popluate in prepare_repo_settings() and then access the member
> directly thereafter" for this variable, I may pick the latter for
> this particular variable.

I left the reason behind this choice unsaid, but let's spell it out.

Originally, this was read in git_config(git_default_config) into a
global, and that is probably because almost everybody that touches
the working tree files needs to know about it.  So populating it in
prepare_repo_settings() for everybody, even though the calling code
path does not even need it, would be OK---they were paying the cost
to read it when they read the default configuration variables.

It seems Patrick earlier made a confused comment on the two models
that may need a bit clarifying.

Here are the rules to follow.

 - "lazy loading" is not wrong. Initialize the member to an
   "uninitialized" state, never touch the member in
   prepare_repo_settings(), and have its getter check for the
   "uninitialized" state to lazily load it, or have its setter do
   its thing.  prepare_repo_settings() should not even be aware of
   the member, if we are going to give the member a getter/setter
   pair.

 - "Without getter/setter" is not wrong, either.  Load the member in
   prepare_repo_settings(), which will turn into a no-op once it is
   called to a repo instance.  Use the member directly afterwards.

You cannot mix and match.  If the variable is rarely used, you'd
want to catch the initial access and lazily load it, hence you are
required to have a getter/setter pair and lazily populate the member
in your getter.  If your variable is very commonly used, load it
once in prepare_repo_settings(), and because you are not going to do
anything special upon the first access, there is no need to have a
getter/setter pair.


