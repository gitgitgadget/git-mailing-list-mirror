Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74E1AA782
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812195; cv=none; b=K5UXfYxnohGhlcvlrGd4Xx/ztasDXC88ccOh+Lc8DuxAdG9hFNhVZ6+34lVrCL7qj9m6hX6HDVauVde9PgEmgOaIFrsEqrHfJfdWW2jYdgWVH7aioHAwozfIvRaanT9pOfR6U25zSanzvY5OOeVS5g0cX7ZKSWhhhoeOO5vVDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812195; c=relaxed/simple;
	bh=jdktNKdpYyBOplmlgh4zobrjT09Z6d82Vrj0qahlOrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u56PArXbhohUQAOAhJUyz6I96jAlH6U0bJ/FstzXpRlLwguCjIv8U65SBLAWM6YP0gF/MzpAESZmEP28K6jvrfk00zzoaUEgcSkGXOwW13whpBHnfDk3MQHxYS94VsgFGBUSBdhdNlcQWRafJk0fU6PjMzTvwbPwoBnFrbpWWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bXvlaD2q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbNIdVlx; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bXvlaD2q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbNIdVlx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C3E491380201;
	Wed, 16 Apr 2025 10:03:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 10:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744812191; x=1744898591; bh=zs7SZPTHip
	KfU82yVXQcoX+tCm60yVnUrVRwcBl4qQw=; b=bXvlaD2qMKnpmpz9pA9Nzn+m62
	GJY0k8M748TC5rFWh/hcLcpNxgMOvYWMpVENYfGH67o4KhzZ/IRioydgk56EnRJj
	Hza/oZjxFlI5y7cLxYnXjQFSUpWGxpY+4bunHJDTK9vZ0h5sPhcDcvluvMMk6jWW
	o01+WGzzE4M7XqQ/ihOGQ+Nxocup3aav74w4vnfKoleEKxaOTJ4NlmMUM4WZIOSf
	EZYZ2/gWYtr2qivPDD1D2Iim5UKXREhzPmlPtDcreJymlG4dzZr2yMuccvCMZACD
	w8YkLbTVx8J1y1mU4mwKFGpj1HoQdl5RGaXxEnWz9BLyp0EICbdFtyrIAmmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744812191; x=1744898591; bh=zs7SZPTHipKfU82yVXQcoX+tCm60yVnUrVR
	wcBl4qQw=; b=FbNIdVlxX4Rnf5f2GygCO/3u+EPejD+xoHC/3aHuLZKXb4eq3By
	TYheMWIowf5j2drEjBYabkKfzTRWs1N1jbuB7nc2op8AAsYLkKUV8pQW8uRxlOkS
	aiTnN6ECR/BHAU1HdS19TF9YzySg6M9LPiSInKHAgFCmvsUfmp5m3nWEr8wi+kbJ
	Jq1J5CLpY9Eeu32UMxDUKwPjgtXBS50AxOf/f8bNIUyJJRUbM3tm5tfLh3+mRT/B
	sRMCiJvNZ8xafMEhB7em9HGb2nRmtZKg8jSyJePHU25lIqtLjliiV2SjIpsQKQ+y
	jkC8HaKe5gB0RGHssEs+NpoQoEBfX1ZgqSQ==
X-ME-Sender: <xms:n7j_Z0CTMsMV4AkVziBDbxU2glo0JFeXZgTFnGs88TD7bwbYEFDYDw>
    <xme:n7j_Z2hOyhNhIAGfD4iJrjTV2TKlkjYUsTw-rYdL8nnO_cWiH5k6_EO7ZLS2spu9X
    AwKGtFunmfhWXks0g>
X-ME-Received: <xmr:n7j_Z3kq1Z5X6adY5w3yWzXUyAD0PcZ4QeKY0poNCrufohXu1hatqAJoJJlC-RQwJ9rGPQEk6lefOYKewxeLWMrmGUCEKjI84gCm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:n7j_Z6w3W3-iz5FvWnLVEIKpultxRCt1d7g_F2RHTJrH9QJqzWGB1A>
    <xmx:n7j_Z5QAr-Q0Ox9VACQ233xgxMOVV4Tjrta2LWxEoSDjFLnCedtk1g>
    <xmx:n7j_Z1bTXvqdRyHHRbl5s4LIl-UJxGh0EXjXCWXUNlt4uiK7lM0dfA>
    <xmx:n7j_ZyTRJKbIQw-VdKCNeB6CP-6GkJiPz-CYKBMrfu5fnTwBeUA51Q>
    <xmx:n7j_Z0k9xhA_7yLrKFRLil6HJtVQmB4dlvcLCZRD3kj-FuQwFQ4SYdUo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 10:03:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org
Subject: Re: [RFH] fedora: pedantic fails complaining that awk is missing
In-Reply-To: <81209cfd-049e-c853-9c4a-2cf9803e56a4@gmx.de> (Johannes
	Schindelin's message of "Wed, 16 Apr 2025 07:31:01 +0200 (CEST)")
References: <xmqq34e9kmef.fsf@gitster.g> <Z_80oMscHcR4pyvf@teonanacatl.net>
	<81209cfd-049e-c853-9c4a-2cf9803e56a4@gmx.de>
Date: Wed, 16 Apr 2025 07:03:09 -0700
Message-ID: <xmqqzfggi4pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This reasoning is very convincing, so I allowed myself to turn that into
> the following commit (which fixed the build:
> https://github.com/git-for-windows/git/actions/runs/14485317015/job/40629741228):
>
> -- snipsnap --
> From 4890df8bf1c1311ef0c3b5a92412ccc4f833f944 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 16 Apr 2025 07:17:24 +0200
> Subject: [PATCH] ci(pedantic): ensure that awk is installed

Superb.  Thanks for working well together.

>
> The image pointed to by the fedora:latest tag has moved from fedora 41
> to 42. The fedora 41 container images have awk installed while the
> fedora 42 images do not.  That change is most likely just part of
> reducing the size of the base container images.
>
> In both AlmaLinux and Fedora (as well as other RHEL
> derivatives/relatives), awk is provided by the gawk package.
>
> On Fedora, `dnf install awk` would work, but for unintended reasons! It
> uses the package filelist data to determine that /usr/bin/awk is
> provided by gawk and installs gawk as a result.
>
> On AlmaLinux (8 & 9, by my quick testing), that is not the case and
> you'd need to use `dnf install gawk` or `dnf install '*bin/awk'` to get
> it installed. Having said that, awk _is_ included in the current
> AlmaLinux 8 and 9 images, so it isn't strictly needed.  But it's
> probably better to be explicit that we need it installed, as a defense
> against some future change to the AlmaLinux container removing awk.
>
> Using the package name "gawk" is the right thing to do.

> Note that even '*bin/awk' would have worked, but it is less specific.
> And who knows, maybe in the far future a BSD variant of awk is offered,
> too, and would then cause ambiguities. Best to avoid that.

The last two paragraphs may want to be rephrased.

The using scripts are saying "awk", not "gawk", so there is no
specific reason to avoid mawk or other implementations at least for
now.  As long as installing one of them makes sure that end-user
scripts that invoke "awk" ends up invoking the one that was
installed, I have no objection to pick just one of them, but I do
not think "we must be explicit to call for 'gawk' and not any other
implementation" is what we want to say.

Instead, we should say something like "Because we know that on both
of these distros, our scripts that call for 'awk' had been using
'gawk' that was installed as part of the base image, let's make sure
that we explicitly install 'gawk'.  If the image already has it, it
would be a no-op that does not cause breakage."

Specifically, we should not say we want to avoid BSD awk, unless we
know our awk scripts won't work with it and/or fixing a bug that was
caused by the incompatibilities.

> Suggested-by: Todd Zullinger <tmz@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks for not crediting my initial report ;-)
The patch text is as expected.
