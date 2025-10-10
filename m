Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F22F7463
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114689; cv=none; b=V7nEtGInsjGoZyL8XOY3oCJemc+X82r/hUV6c+Kad498ygWpptMLI+QatLjfI9BvGEK6/F/dpJ2E21LKhMXegZ7VBTFzTI0w+lmoquYdqpOLKuAkrT6yKlZwC12cInWPvmgcrN2tW6XE4vmwqeezf9Bn285TBd+knAz7X2sL+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114689; c=relaxed/simple;
	bh=Qg5NeSrxI3xzTIf3mvRqtOLUMDUaxvTaxqD/lcyfQhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V/NpGxheDBMXSNRaC//ZFb4O6CIME6EfbrUG7gSTp5kbcD6ziC19ws1mICue5p+YcuR9FbFSgW1GulIsFSJ3gmPSXLSPYYwY9RGuwpTL3SCcTKD87NWOeuFNDANW5UT5DR7FNEEKZXNlLun6uFwxccosxpzYWOGWq1sm1sEXTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VMecXcn6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMitc4B6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VMecXcn6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMitc4B6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E33BEEC0209;
	Fri, 10 Oct 2025 12:44:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 12:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760114686; x=1760201086; bh=YelA0sk0D6
	FdkZt3uq6p4n+XBlBdZP0rAoUSdVuZ9KA=; b=VMecXcn6Ddfn9lTfmvN7nF20Su
	1Oa0JSDFCzuiZmi7Rck44Mh4VEXeILdPKtF4VXBoO7eOjXTjMyuIhq0k0gYJ4LfT
	vagEVbQKSAjAk2iD+EKT0lsAcppuAxF0GuCTS2q+ur6f5bW2CrdQp0nBxsEaR8yA
	1AiMmQfMh+Pa43+bCiduqDcDaoLxVg1vyLLX/Mnuj+4CkalqmYAIxwoLQYSMEYzu
	2X5GOvP9MNv129Y2SJ94EEqrIvdK8Jydc99W6QHhZs4wyeB8qARiJ5AhLHqcOVzR
	KWfHWs5ChfIMrLcsKIx+AbAsLwIWU2+bZPkWcb5Pg1+is04qAovDe9HLsjnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760114686; x=1760201086; bh=YelA0sk0D6FdkZt3uq6p4n+XBlBdZP0rAoU
	SdVuZ9KA=; b=ZMitc4B6ZuE7r2DQep3uJ/stsqkWZV1zR9cEdYZziPAXqZKpX03
	k4cbMw6pC5eeWw3QpTeHog/dk6KUNK6moJLRSLi6XuVHEa3ejIvv+T8ggwCpKDzm
	DtiXhX6JL/aGsoJhY4CAzn3S5PsX8wwvKrBYlvVQU2xRXCCfXzWztJXx8zW55FQw
	Ss5ip50BBvVeivgYEQ9tnoyYlFXZbgc6R12CsoaLfb3rcCF8vT9tHYOibyNh4nNo
	MQUK8TCgOQcYwwVttUpNEVybehjZAnJHF+dG97oCSOXQT4+b1Z3J6BGIkVoEs1pu
	fWqTRKYbYOLNWtrZKB/f4LsKGKy1HKZGvTw==
X-ME-Sender: <xms:_jfpaGOnAZD7R2KO3QBYe3ng70YmQ1ef4xGdEXv9rTJzQwq8HVPdkA>
    <xme:_jfpaMYuLaictOSuD8NM8wDKE4iB3LU0kO7LV7WHolSGJZ99a37IRCleFUcpb4QGD
    niI-stt_Yh8jy0z0vvHzb_xBGtH7_TYPOkAev1tdTlZZr9kFkUrUw>
X-ME-Received: <xmr:_jfpaKrWSDoQasQz-_CJdecWkUmz12LVjpDbaeM9empQ2JhCkObRQffuXp9M9K_E2h6zrP-SrozLSP7M0aVrVeIoU3PLik0xHNL7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:_jfpaAamYnvnNad8uUfSds7OzlQrg9q5FZA-QA0c682VfikhK_GyaA>
    <xmx:_jfpaCSQE9bAG8m6xniUGWYzfg4RlBMNrtl5uggLObBErBQgNbNfrw>
    <xmx:_jfpaH44lt29mtz8xsloTWbNQIkCFTjLDzJlnD-MP_6Uvjp_meq91Q>
    <xmx:_jfpaHxLshVb0Kw1VqRWHXZUMg8YNL6JgryKDcZsJoj-7e9rgMyoNg>
    <xmx:_jfpaMh39XNn32YpYJISp11lo26kmfjqa4zSTg_TO5CZ4fZqezhZhM5o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 12:44:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: fix broken jobs on Ubuntu 25.10 caused by switch to
 sudo-rs(1)
In-Reply-To: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 Oct 2025 11:41:14 +0200")
References: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
Date: Fri, 10 Oct 2025 09:44:44 -0700
Message-ID: <xmqqzf9y905f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Ubuntu 25.10 has been released. One prominent change in this version of
> Ubuntu is the switch to some Rust-based utilities. Part of this switch
> is also that Ubuntu now defaults to sudo-rs(1).
>
> Unfortunately, this breaks our CI because sudo-rs(1) does not support
> the `--preserve-env` flag. Let's revert back to the C-based sudo(1)
> implementation to fix this.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> this breaks a bunch of our CI jobs, both for GitHub and GitLab. It would
> probably make sense to fast-track the fix.

It is curious why this is done outside Ubuntu.  The context is that
the outermost case "$distro" has this arm

    ubuntu-*|i386/ubuntu-*|debian-*)

which is where the patched code appears.

> @@ -65,6 +65,15 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>  		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
>  		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
>  
> +	# Starting with Ubuntu 25.10, sudo can now be provided via either
> +	# sudo(1) or sudo-rs(1), with the latter being the default. The problem
> +	# is that it does not support `--preserve-env` though, which we rely on
> +	# in our CI. We thus revert back to the C implementation.
> +	if test -f /etc/alternatives/sudo
> +	then
> +		sudo update-alternatives --set sudo /usr/bin/sudo.ws
> +	fi

So at least shouldn't we be limiting ourselves to do this only when
/usr/bin/sudo.ws exists?  Or do it in the nested case "$distro" that
immediately follows this one to limit the effect only to Ubuntu
(which may need to make this into a helper function that is called
for both ubuntu-* and i386/ubuntu-* arms)?

>  	case "$distro" in
>  	ubuntu-*)
>  		mkdir --parents "$CUSTOM_PATH"

Thanks.
