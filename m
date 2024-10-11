Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5075381E
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668867; cv=none; b=BdyD/X0fSoBYlcZPyXex+LYlJcwBLiZdXXjtNi95OmPJcd4FXzHSNwcU7GJ04Vf0mz+R1F5SlUMGK4wH3VWtzucNtY1pu5dZwcR63wBN8GSY+fFT0YALHTO73BVf21LFpN1HprRw6gRRGVJCIcyZTkYutQW0hF1Fi1u7KqThanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668867; c=relaxed/simple;
	bh=Fo6UohHg+mzRaiDfrh3ftwdw0/tn/gv2DO6z52wuiWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hx4ydYOKhiZ66UagMmxv4hU79UyT5YWagRgSoPR8oPqc+GKCBpJpBZ+bYKr1mAGHsmldVuvqMnp0SeVDnTkIJD6WaDDLRUkWfuMqiwcHmgzwfDvRJtYWRNd+3Yyvjd3tSAc8sjjig5XbrXJBcnIJiW1tpG4bCTrSIzodhzwWCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W3Js2rCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQ6mbc1j; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W3Js2rCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQ6mbc1j"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D5DAF1380299;
	Fri, 11 Oct 2024 13:47:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 11 Oct 2024 13:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728668864; x=1728755264; bh=F0k4jt+9un
	5dt6I8JCemEVyoZV2jX6EpSOPuEgo/6nw=; b=W3Js2rCPg9SDzYTZvoLhLgAvPr
	oKCJWHBbqP7nu1Ah1vpy5QYBMfZKq2HNDDDMTnsMoTd2oEEcgUVmrHctNYYbhapG
	7ki5Xv8sXsPT/BhsVmS3Lq0XlGBWjqKiRFGn9MgN+v2amq/jGXF4OGKVRrqmFnD5
	XZ2LCs6ChVNyWeQbbbnV0sFVxFXNFN8Rpj/8PEuWzB34JbIcBKDDXGAbhOq3SIVC
	Ya+MHtdo9gVGD2wuY7aJ1Iv/44dnk+8aDNyLhKzO2wu8Sl0gF48XLLhI6K8Gk2O5
	ywzaGjUicQz1UFvjql0DotqBzTtwViAbjQm5qbuDovMf6JTr49rc4JYapHVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728668864; x=1728755264; bh=F0k4jt+9un5dt6I8JCemEVyoZV2j
	X6EpSOPuEgo/6nw=; b=EQ6mbc1jwUtts232PLd7FQE71NsD7gm+mpCnldggFn7Q
	7CHHXI6drCRazhfIi8msMcAK+C8WOBK5WZ3n+phVBj7Lmn5f9eMpdp/8NpCmDXjZ
	E19whgXWOZ5fTuUCETbwM1DnX/whRJKR6Xqk2QUQyBr06PA36t01uxcquDCkkoa2
	Qsy1sNk5lJdcGm3uWnCmUmn18HTLaxLbMjft/JGAadJgCLmT8JEfjpDDVucunw1z
	O87S8/LgGm1FtIpskb2zptu9UWSjWWOeMzot2BV5w7qSsIIgMS7f2o6C746WABlM
	qvqMlXhSpcl91CXqIzRKyNQ1fFTG4jFO1Bn41m8jAw==
X-ME-Sender: <xms:wGQJZ9dY24CNnVz0EQV9jOChiyHMj3vksD5Nk8Wfs_pBw69EZ2MckA>
    <xme:wGQJZ7MZYI-tVw3LSsj-I-p8rdS290mXaet0t-I5rJEySDx5Qk0JISg7sMXltTetO
    eoCWUnowvdfXDXJVw>
X-ME-Received: <xmr:wGQJZ2gbZkUIaoeKVIMm2xtnlc47kA9-Yo5kkuvtKsjiaIcjVppyMiCeNA9wP9vUUdp6DU-hvBzh2JrqwDMJBRANLVCeccW1WElVqm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhhntggrihekieesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wGQJZ2-H3AEJyiqjZidfF9iDlMJ0s8dGjMqM819VdCxZaQ5Y96ShDw>
    <xmx:wGQJZ5soK0V3sXgJMWCkDTG4LlzovMVTzLN7nuXhS4YwMXzKSmUX2A>
    <xmx:wGQJZ1EoppNZNDk8Wai9zpnhZR-92F65bHrZbZywEeMrdNT2quwnDw>
    <xmx:wGQJZwOCQQHQoC2tvQAMX5mlXns_2mz2pJQKHAA3W2EJY-BkJOGBFA>
    <xmx:wGQJZ9ihPPtcQOOELsMfm5_fUdQ6__9woSF1i7L7S7SBnXZdebPKnf3D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 13:47:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 0/3] Remove the_repository global for am, annotate,
 apply, archive builtins
In-Reply-To: <pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com> (John
	Cai via GitGitGadget's message of "Thu, 10 Oct 2024 21:13:45 +0000")
References: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
	<pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
Date: Fri, 11 Oct 2024 10:47:43 -0700
Message-ID: <xmqq8quufs5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Remove the_repository global variable for the annotate, apply, and archive
> bulitins.
>
> Changes since V3:
>
>  * Improve commit message in patch 2
>
> Changes since V1:
>
>  * in patch 1, only pass in repo to the bulitin if the repo exists
>
> Changes since V2:
>
>  * drop patch 3, which is a bit more involved to dis-entangle the_repository
>  * use a single variable in run_builtin() to keep track of whether or not we
>    are operating in a repository
>
> John Cai (3):
>   git: pass in repo to builtin based on setup_git_directory_gently
>   annotate: remove usage of the_repository global
>   archive: remove the_repository global variable

Will queue.  Thanks, all.


