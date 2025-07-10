Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96323506E
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182766; cv=none; b=Ivn0TM8f69gdTeEnf2Qro4+ruJLXou+WwnnOt9hEWf+7pVTQQfj9zY2MsaqYBHLE93xS49Akq86bEOOLGJ5FA33EeCbr1JlhLIaJly4YozoHz5LgXI+gUcfBNUjZ9oXGfLaqS7LPC6DjH+y93Ptynb4kamAQ5ZuXVxnl79RaZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182766; c=relaxed/simple;
	bh=lJR3ekfl5zrEJKVEcvx33sL7YxVSwe7i3cxbJNa8xvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfmHpNtM10EgyM4IMZkWgOroSxz9MVe7BYWu3vjQkCAvqlRTmJ7gWTBSL7XKLkvTWgl+7GBUV5uR8SoUJWq2q5SGuj4iOOtv4tfkdVKk7mesRL6J1eze2zd+kFHAHVxLm1yujCimfs7ccxc5ZeeLtKsGUfkAZBzmklQPcOt3K9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S8uabzLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMDTsQwP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S8uabzLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMDTsQwP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C1151D00157;
	Thu, 10 Jul 2025 17:26:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 17:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752182762;
	 x=1752269162; bh=xjxcO/IT130stvkY9Ilu1cENDYyFZD7mMKQA71RXYDk=; b=
	S8uabzLCoE1ywLT8AMgMEiQpEa/UiIR41syq28rKOQnkfB6uUuymtCvt69fZML1Y
	MrXQXbqc+wHFmyAK8RiaTYYyrc+GfQEAFPCwYDBnm4w1onSLjoMQw7+gbvXaHfFd
	3zyVZb8vBMUzF1pP1Br6NXwj3ZzfA0oq1fF5yHobZK9wLuCEcVSZHIBU+pV7J7Zx
	UW7cEO/wzxlGPoZH2MEKpRXDgPu69uCMoWjEIL1L+AJ0y4QFSzRFcuJ7GvRJb5xk
	GsEHEoMf5pYg/Vk9V1Ls8YyoRrpqu2CDiPUhof/e/M0aFUyRrToWrBxWM6EVBZ0K
	qD5Pplfu4zfx8Q41PTEpQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752182762; x=
	1752269162; bh=xjxcO/IT130stvkY9Ilu1cENDYyFZD7mMKQA71RXYDk=; b=E
	MDTsQwPJrBRaRXHJu6UT/lF2zxElU+wqb/hcaMb2BG7gzHN6dwU3kNT+hChtpL3w
	xeOBibyBzrhfjGMbr2xn3iOf3ipMpDmnuRu1lPPZC4gnIvYjLWwyQ9vYUrJ0/aUE
	3CBaJ6ooHOPz+iD+Kp5SkV3mbCZz8kEmnyNhx9k3hKP0m43T0LvZMc7TFOD3NfsJ
	GBK/O+1Csme9Zw/4/H0YxRi5na/ubZ6RbMnIVrIoebVCynuy3T+/WkhBYq3fSuzS
	BYomnJLDBcfyVoYzxzU544eqKDv2FoYSrP1Wc5VwMklF1ueGt26NnJ5GvUMCar0K
	Pjny0BizunYY/C1cIZUPA==
X-ME-Sender: <xms:6S9waLfMls0jC7mlRfiVdImG_h14ZkdBOrM4P4MIo_httNq7VQLfhA>
    <xme:6S9waJrumLgsSvRC0Z_djA2Yp4LrqVzvzSOGZquW3ioUF9CvUwbxuq7IlAmQ8RGP0
    zKBC-Dnfo8qa-8mXA>
X-ME-Received: <xmr:6S9waE9jYWUHSvIeki1Qz3LqJx8tiJ3fTjCGW671G1AM4fZvT5mROPKBObps0QM4C6AKu-T9By3NvwVrr8hwDGKrsUyUg_2E4Lo2YNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6i9waNcR-h70SeAqtafJckbqkdMyGpAhzQKFd_YUkdN7h6A2pXfqEg>
    <xmx:6i9waGLh5E9HHrIz6MANt7r342AjgnlvWdYtWiErXPwkHE9lO1EB3A>
    <xmx:6i9waFh5Unes22xaeba-vqi42FWc1e-REDdQ8ketoTCMsnremqFqwg>
    <xmx:6i9waMS-EBNuC3ZPNWWWpXIX9TaU82StJ2n-g4WKsrf6PsEEKpDnDQ>
    <xmx:6i9waBCkItlxJcvSXYPqxpiPE5k3W_e9LG6AfN4GPaEo5jEPd5nUlMyi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 17:26:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 0/2] daemon: explicitly allow EINTR during poll()
In-Reply-To: <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
 ("Carlo
	Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message of "Thu,
 10 Jul 2025
	19:45:41 +0000")
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
	<pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
Date: Thu, 10 Jul 2025 14:26:00 -0700
Message-ID: <xmqqfrf368lz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Thanks, will queue with the following typo-fixes.

I'd appreciate an explicit Ack, even if this version is acceptable
for all those who have helped polish this topic.

I understand that the self-pipe to wake ourselves up is left outside
this topic on purpose, which I agree with.

Thanks, Carlo, for putting this together from weeks' long
discussions, and thanks Phillip for pushing for simpler and smaller
set of changes.

Will queue.


1:  30773a76ce ! 1:  ef03aa432a compat/mingw: allow sigaction(SIGCHLD)
    @@ Commit message
         The current code uses signal(), which returns SIG_ERR (but doesn't
         seem to set errno) so instruct sigaction() to do the same.
     
    -    A new SA flag will be needed, so copy the one from Cygwinr; note that
    -    the sigacgtion() implementation that is provided won't use it, so
    +    A new SA flag will be needed, so copy the one from Cygwin; note that
    +    the sigaction() implementation that is provided won't use it, so
         its value is otherwise irrelevant.
     
         Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
2:  7a33d7a646 = 2:  d83e1eef3b daemon: use sigaction() to install child_handler()
