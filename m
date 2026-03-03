Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC5330B0B
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772503905; cv=none; b=j/VImdWqP+4ayksKf8CrJ5P0jkjBL513g4oAuzYgXoxffWBGbCEzFRnaX61jnp7md//DPd7fRD3SYxzu51RcgkxfQUHCK01dg4XwFouUElDsXgiuTYt7qxWgdRrYO9rUyDkQSwc/B+VqInWFmXOR/4ObTSiEUVaolv826hM2wQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772503905; c=relaxed/simple;
	bh=wLVXYHKmaEjas6E89FW95cr7xzLFqxyOAgowFMV+EZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aTrCXpg2Dm4FsQijHyD++hqqkmDpKNyjmCLr85351Qat910v88D3fqma5dzHsuVUTqT+THPToQdxZarNZS6MEXPkWSFb2X3StVrx+im5jGyNy3wtCvUoZ5dR6BZac+rSsnZItRKxQm+fvMCgUc0aBBffc84MjAFRZJStuuzumUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CgIA9mEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuCMzeyX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CgIA9mEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuCMzeyX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DDEEFEC0076;
	Mon,  2 Mar 2026 21:11:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Mar 2026 21:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772503902; x=1772590302; bh=Ju/7hhvIhT
	CFm7YNVX/XMv/MzN9UtQ5rsKlaxbVn+OQ=; b=CgIA9mEC8+VAku/U/Dra1yfX+d
	V7gSm3DREtfR8xqSFDTNA5hkVFTV0J42lwHuosmnaBSEIpiF4DTsponvl0mK2Es/
	EzmGAdMm7LIWl8XVjPFC5qd+3GftLNCF9PSbdSvll3jUKlQUDug5kF5nl141/31f
	lOsTaIsfhs+iESbBwfB/Egwx5wE143urIaDffMHiPnaJfbVdxfVaSv2DUTrBZC5y
	vTBd+htHNrRPBNC4VXVqWescx4iGIU7oJEr+mL48x+AVAxRKK0c31/bjkzuViLk3
	rQadZRhPOFcwnoENxhnnZcZJr+N8jt8ApOFosxslMCKHp6sb0noQ+0pUghqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772503902; x=1772590302; bh=Ju/7hhvIhTCFm7YNVX/XMv/MzN9UtQ5rsKl
	axbVn+OQ=; b=KuCMzeyXMsHPdDNjG+YeLPcXZKRXGUBV0ItZEMeH5PytoMa6Pgw
	5/RDlWrJ6iaduOsO5rSJwSSt1f1Pjd1hhlzhN0nBpKRXXH2oy7Nk/uVnXwLrN3Fp
	iPYFXIXW0PGe0CUzFr0CQjL/Nsj7jhBgdt1XyCN5NSL/4jlP0KO45DW4ycGlf0Et
	0QGOiahYqjDfydtSOXHEVJNJsKBH1VNVxQCyeXQpPe6utW5AdcuFkAC+IRF/ZUhd
	ZwuHGj1i9MoqSiWyMtjaQSEAhkKgbTzq/jdUoBLOpZWaymWFcPGeF6nFRkdtMRtF
	CZptL9PunPv3Y8lIRNlRLl3fdDwco9cyAIQ==
X-ME-Sender: <xms:XkOmaYovT7pKn5x9DAKqDfcvxF5v0g7PZBr4DqBNtIotDj7lal8cng>
    <xme:XkOmaX-pktt-EBTGeJD0sNyyiHXwExeXQUZ4S7uC0YoWO0WV8A3e0pjHaBbS3FuXr
    Z4eT3RXr7bX2HwmJ2uT41u_FthTAgJBFZqz6d0ziSw8PuqKpz_vVQ>
X-ME-Received: <xmr:XkOmaUcURAsuvFmyOdWE0kz7_f-89SNyZfUmVP4sDGvTk8OjWA0pDdmmBIVlqfyMqjxqY-rYxvW4OyI8N2khyKm116vO3rPePQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgrshhsvghrrdhgrhgrihhnrgifihesohhsshdrqh
    hurghltghomhhmrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XkOmaRKL2MgUubmlDdTm2xpWBJ8jAl5OJPo1d6irGLhJ7WuJruKRpg>
    <xmx:XkOmaUjZxe8ypM1Fbb1MjbfumFlr74MEV28Cm_L1oLXiLmXntq3LdQ>
    <xmx:XkOmafQ3opUQQu_mUDHZd9IMbRDLk27CwoZ9WVYJxNBKm_qh7aOi1w>
    <xmx:XkOmaeXmiow1aGlLIXc-Of3ujtbXeDrbyYl5-UQtRorG7EPi66KziA>
    <xmx:XkOmabuIEo_R19jeIr6prnBp77fm_TjBpo_cYtQ5C8xVJUh2ZduD8qH_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:11:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4] submodule: fetch missing objects from default remote
In-Reply-To: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
	(Nasser Grainawi's message of "Sat, 28 Feb 2026 18:53:27 -0800")
References: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	<20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 18:11:41 -0800
Message-ID: <xmqqfr6hfyqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:

> When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> added support for fetching a missing submodule object by id, it
> hardcoded the remote name as "origin" and deferred anything more
> complicated for a later patch. Implement the NEEDSWORK item to remove
> the hardcoded assumption by adding and using a submodule helper subcmd
> 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> succeed when the fetched commit(s) in the superproject trigger a
> submodule fetch, and that submodule's default remote name is not
> "origin".
>
> Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> t5572-pull-submodule.sh demonstrating this works as expected and add
> dedicated tests for get-default-remote.
>
> Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> ---
> I removed Jacob Keller's Reviewed-By since there are more significant
> edits to the tests in v4 that they haven't reviewed.
>
> v4 includes fixes for the issues Junio patched in seen and I confirmed
> it merges cleanly to seen (with v3 reverted) as well as next and passes
> tests.

The tests in this patch seems to be broken.  I didn't notice it
before merging it to 'seen', so tonight's integration CI is expected
to fail at the tip of 'seen'.



*** prove (shell & unit tests) ***
[18:10:13] t5526-fetch-submodules.sh .. 39/? 
	error: bug in the test script: test_when_finished does nothing in a subshell
[18:10:13] t5526-fetch-submodules.sh .. 42/?
	error: bug in the test script: test_when_finished does nothing in a subshell
[18:10:13] t5526-fetch-submodules.sh .. Dubious, test returned 1 (wstat 256, 0x100)
Failed 2/56 subtests 
[18:10:28]

Test Summary Report
-------------------
t5526-fetch-submodules.sh (Wstat: 256 (exited 1) Tests: 56 Failed: 2)
  Failed tests:  40, 44
  Non-zero exit status: 1


