Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221419E7FA
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613778; cv=none; b=o4JYIzdXg3uVh25Nmd9KVOBdBFlMNx1UK8KsI4DreSCnXZ7GFBgGIdZrQsORtXwVDD4BmXkhiqh8Iao13rL5jXuhhOV6QhOH4VrV4+IUERjuV3h1REcyhXWMqesJvTir8eFqb/5e5srGtrEjVd2I0p2Xnor7/XTf5Pa4Oc4OsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613778; c=relaxed/simple;
	bh=6Dqm9L+0DiOvJwg2HYvPadjGxU1QTzg+e6YxeLWFCFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6DLbcOfRu/Ly6oP8h0ux0zrN4cl8Tx59MBULuqOOFFDyqtMxLv1Y7VSeI4nIL4j2GzhZH6mHbxqDztOBogC1vo7fWM98s49TiSAgTf/jWPzvvM/GP6H4IHVJwHaFBY8//VAjMfOjG9Tc5DZ3GMPUSsRrzrlofXcy39HBW6y3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ClI6lVzA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxzFYvBK; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ClI6lVzA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxzFYvBK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F823254023C;
	Fri, 25 Apr 2025 16:42:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 16:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745613774; x=1745700174; bh=jocwUPVoiN
	J1paGO+d4UuWy3NHUZV58R2rzX5wfn7Fs=; b=ClI6lVzAMzoloKHw1L0p2F1zT7
	FtAkkpX4MgKu96D/h8ZD4Rw15vlvpO7Yq8eqEjHIax7OzXMViYeIEJmLnW5uEFoy
	/JY9weq3+OBauyJD5wxRzT0jETXLru5EL/5yIF6We281/onEzVj5cHMj6ljdOtoe
	WfVlJaAAwtbyx1KWJBUWi9PWhyztpPggkcQwz7xiH0RXQ7SXGpZFx8RKXmVQKWxO
	4YSamzptFEyVnQxaKHiOK/0NOhdIBPaHS1o8c7tOcsgK4OyvCamJBMb3empfBIvE
	NjSxrQY9QZqRaEMb/q5uiCIeILYKstLBzEOGj938aCo4NRXWNzuFx2+6KoyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745613774; x=1745700174; bh=jocwUPVoiNJ1paGO+d4UuWy3NHUZV58R2rz
	X5wfn7Fs=; b=MxzFYvBKrGOZfKiRkWYmno+9WRJayWAs66cFA+kcjoX7EYbon7U
	dujAfn0sIIDkKGVZkgKIOfwctQlaFsbqdXvUI6+HjlB/gl2aR0o1a4A7M1ZI4Eh3
	7bha6kkmlK3rZ4hOEugOYFKnKlryA4modPDFnGM+lfBr+1rHt8o5PFd7kp9zqKrO
	jab1EyXhjA6H65YpnG04WMF7pdU30g5Ubtjy9Sq5zmsP32xs4MF2iTf5/F5nrtSV
	rGmdj09mcALl4Vlb8YA4YrRgf/YxKTaqG3B4akaMiO5/usLhyfJ9kAVgvfbvzU60
	loidpOGmBnMJXA2Zt+s5QPYxbSVhflckqmQ==
X-ME-Sender: <xms:zvMLaMBbh1v8PuKNUOmDyW09YNbBceUfq2YaSofl9IJoKZrmm8O7AA>
    <xme:zvMLaOisBvIMYXaPL-Pop0Ag8vGm5MNBUIZUQBVWG2f8CmgY4YpyuWxu_V2KRAVy2
    ex2ss3nK0MPkgaJZQ>
X-ME-Received: <xmr:zvMLaPlmcJmXbcNaFB2_Svbuk1AlSpvRJBOfWDpsFS2Bf4ItJ9YXTbNMgaXTzlRQyCBz-l6QS_DzmyavtQ84QLyRbLsJEwpqTttm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zvMLaCz6znG8r6j3nuc8n8Nxf0zfV8gSGQdUuYH9H9KnM56G_4Kx3w>
    <xmx:zvMLaBTRt26c3ukgWdB7sT5CSngYt8DLnVkg8lN21AfAZrPEVtDdRw>
    <xmx:zvMLaNaZcuGGggouZrFaNwNjCVgEOjV7KM1OsxrMx3TEldSfm7k9iw>
    <xmx:zvMLaKRV58sK5nBd28pjSicAISyeGXq5jAijY8o1sBCe4WvvhpzIMw>
    <xmx:zvMLaFcahgIjunwM5BHmJhep-nB_Ic0g9SJprUpgmblDumG3l5rKBari>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 16:42:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Toon Claes
 <toon@iotcl.com>,  Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH v7 0/2] bundle-uri: copy all bundle references ino the
 refs/bundle space
In-Reply-To: <pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com> (Scott
	Chacon via GitGitGadget's message of "Fri, 25 Apr 2025 19:33:07
	+0000")
References: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
	<pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 13:42:52 -0700
Message-ID: <xmqq8qnot1kj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Sorry everyone for the noise. There was a whitespace issue the tests
> complained about, hopefully this fixes it.

Thanks for being thorough.  Will replace.
