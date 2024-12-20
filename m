Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC52153CE
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709463; cv=none; b=lW2Gf3lC5Pv55nT7JN5F0J/ZpV9VsSPUpEdtuz4TxLDTlRbRtFWJA6yQpgIMzOvmj9mVtFd69cGUj7TkWe/tBBX5ieUGIq7lmOPGy8QtGfnWZ+Qg0cj+BLEYra62Z87YXDWEvAyMs5Omj7NaEXokG6sCXAx8ufkCWZis/2GJY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709463; c=relaxed/simple;
	bh=eqoh+DwEoV0zxze2KmresOBoE+wfe/gr1KhsfL+qPaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nO94MxepO9PoTv0ezQww9x/vfo0aI2YWllTgUxp1cn/1rvO7Hnn41qOID+q+zOCifZOKxZpmKHAPfeSfrxkZGYFWSF10OPM0k6CpLVAWMdRIQCfAm6D62X+Qk2dLtYXYU6PZIQCOLdU0EykkvTiKk/qaCdPOBHvaApct+HdUG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dVhpRLMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSamWBKA; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dVhpRLMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSamWBKA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F38825401C7;
	Fri, 20 Dec 2024 10:44:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Dec 2024 10:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734709460; x=1734795860; bh=qlgres5JMJ
	xHZ+gZiTs/BjNWptQY+NqGrOJ6YbkRw5A=; b=dVhpRLMHLWiHCni5hxAEXAFr9C
	to97evM6QBp6NYmg3UIPIusbvitObQrfQ2mC+lJY2eWOll2Eowop3P47otTILthV
	uFNPPlgM+HkTY+yYpeRJ3+QlaNuAh3kLy9HgVg9zj3205eof51AoIBcQMNaqgK/O
	IyKBARZ5ZF8OasvVPDPTAJP26GA9zWJ+LGiwwFrnfneYwEDe7nFDQj/+J2a+aRlH
	63mNhveSsKdKZ6DqXbRpJ6ik4MU0lDSD62pul9RQQJN6Wv3a65yw938xH8bgPx1F
	oOoqDSTIQ/rMAfncMESjRhsPISW7Plq1HWgkhoc9Frg2dSy80yFfc0jUGrXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734709460; x=1734795860; bh=qlgres5JMJxHZ+gZiTs/BjNWptQY+NqGrOJ
	6YbkRw5A=; b=YSamWBKABF3G8kRdvzLECtUC+cNMo+ccY6WecNl0eY/vbtLvpRm
	TH1ED+Zh1YS/T4JtZ9dFpNRoO2+VYzDB1jVkPpGBYAo6oAtaXPnKCPzUrVxflSyv
	L3JH+WUXkUDVDN/84y00XZmdqqpzbLrDk9mUB6pVBc5MEdw2r/PgBAsVWQ99LiUz
	MDWdCKBW0uVgRfXxvHEGB5AQTW2gAd1bcKIIhJP6Wc2AaaBNBUu1Dr3DRrYC4ZSM
	Y6xT3MiJSysYE1SY4PJ+X6+oCuaLblUVarjkS4kCTjmj0FJP5oMCSoYtz3/+/M3h
	6B+q7h6Fm2ZrVx3Om/0f8YXRRYQxPJCB4qQ==
X-ME-Sender: <xms:05BlZwStLVWaFtB4y8wUdIby0YdipGH0A54Jlg6D7Q9egF-iK1cmDg>
    <xme:05BlZ9xeio1wwvSPGVyHOC26fuzu_5990jLTrbj0DZ6VfpsFxIVlMCA5Sd_QZBzav
    K_P8RajNjLojwNb2g>
X-ME-Received: <xmr:05BlZ91jVMcgbLoiC3a6ezLT_4NEa2Q-1WuSTKuXK2fzjJkxg6MufRUs4P_I_DjFgq2ZMG-K7qTbkX__kcUDnXOb2IfI7PZtFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhonhhrrggurdgsuh
    gthhgvlhhisehpshhirdgthhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:05BlZ0B_RquZrpfGo5N8NH0FaQhfXAIyEQzbASaD1z7YkwRNM7fZHg>
    <xmx:05BlZ5hym06nrC-8Ug0IE2kUMRJdpIzEYdfue6qKZ7W5DznNPKUNGw>
    <xmx:05BlZwr3KhbtjdJU_QAo-j9bz77gmTlTA-P3gxeEA4tn9Ix80k_fpQ>
    <xmx:05BlZ8i8E-arh0G6aiW3aAf0IahnFyDqLKKTl0v4GA6j77fDZXRENQ>
    <xmx:1JBlZ3bMed-TRWPOM760EWrh7ciGn0n5f17jMg_VUwuyF4AuC8VAUDV3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:44:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: chmod failure on GVFS mounted CIFS share
In-Reply-To: <c287fbd7-eb08-45f1-953b-5afd4fe41f9f@psi.ch> (Konrad Bucheli's
	message of "Fri, 20 Dec 2024 15:42:36 +0100")
References: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
	<Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
	<c22a7d5e-cbfe-48a9-bdf5-e73f21ac648f@psi.ch>
	<Z19Ymnnvt9jOixPB@tapette.crustytoothpaste.net>
	<c287fbd7-eb08-45f1-953b-5afd4fe41f9f@psi.ch>
Date: Fri, 20 Dec 2024 07:44:17 -0800
Message-ID: <xmqq8qsafjfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch> writes:

> I have another idea: there is no need for a chmod if both the config
> file and the lock file already have he same mode. Which is the case if
> the filesystem has no proper chmod support.

And for majority of people who have working chmod(), would it mean
one extra and unnecessary system call?

Instead, how about doing the chmod() first, like we have always done,
but after seeing it fail, check with lstat() to see if the modes are
already in the desired state and refrain from complaining if that is
the case?  That way, we'll incur extra overhead only in the error
code path, which is the usual pattern we would prefer to do things.

So instead of removing this part, ...

> -		if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
> -			error_errno(_("chmod on %s failed"), get_lock_file_path(&lock));

... you'd do an extra lstat() on the lock file (so you can move the
st_lock inside this block, narrowing its scope) before calling
error_errno(), and only after finding out that st_lock cannot
somehow be obtained or the resulting mode is different, you call
error_errno() and arrange an error to be returned, all inside the
if(){} block of the original.

Wouldn't it work even better, I wonder?

Thanks.

> +		if (stat(get_lock_file_path(&lock), &st_lock) == -1) {
> +			error_errno(_("stat on %s failed"), get_lock_file_path(&lock));
>  			ret = CONFIG_NO_WRITE;
>  			goto out_free;
>  		}
>  
> +		if ((st.st_mode & 07777) != (st_lock.st_mode & 07777)) {
> +			if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
> +				error_errno(_("chmod on %s failed"), get_lock_file_path(&lock));
> +				ret = CONFIG_NO_WRITE;
> +				goto out_free;
> +			}
> +		}
> +
>  		if (store.seen_nr == 0) {
>  			if (!store.seen_alloc) {
>  				/* Did not see key nor section */

