Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DE321F2A
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416379; cv=none; b=AM0T9UOktfCo+FfNexHuNCNQqb90g1oJhu+m/wANa+w9NalQ9m+9mFncG44Jnvdf94w8i1OCOLtkdmqNlygOz3kapWZCUidlWCJpOZ3OGbr/aaZBm/HMsIm0P6m89sW8YtkYjALcTgu7PzkeFPyN97Sfs18mHYG9bOveCgcOjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416379; c=relaxed/simple;
	bh=rnJRIO0e0VmTq6xv7CQgeGZdO1qhDvIHjXvG4boUiE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kG1itz+VXw3MXivSUrUVwELFX5uwLtEDgbgvQ1SQnxXFE6EWrQgPXe7mKkSztU9Xq8PForRgHJVM3X+OHSj6eMUlaleOLhu93tn2F1tP9Wi6zmc8q1Zb14fNzLaTFXZUfA2jEMjyNx6CY4h3qRmEJ6FfdzA6JPRsz9HQ2ghvTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jl/YKssg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CTGnoAFC; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jl/YKssg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CTGnoAFC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A40614001C4;
	Mon, 17 Nov 2025 16:52:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 17 Nov 2025 16:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763416375;
	 x=1763502775; bh=9PExQNxmJD1rlt8TMcg3a/MiLIFQ69IHn2SAclF2NIA=; b=
	jl/YKssgwfgGCzhrIX1PBd5uEsZkQojxi5JLqlUY2gj1W2GdTgNApISFM//bZ3cR
	7ju3g3k2nGYsl8ATD6JDOb+llaM0pFkjpT9h0OmgkSDb5oLvRiFKu40ovWWOfi1E
	ktiLbZ2zCoMqP5UsDs+Y1KIcTnSQqdXL7iZkTWNtCVAriFDCUFkz4Thh+NlZ1vRv
	8UonMlcfUpXCbzd0oCgAu+n1/M57N1BoMEl1b6ujQUkUnhT5QZ2mbgQIJY78y8/9
	t8EMiq2xylX8PzzA8Nfq+iMbDKJrLdMgYQSQ0ZjCTlWl3SfBEQg8YwRSdSJrR00Z
	3GSTnbAjfqMXQZkxvRiGkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763416375; x=
	1763502775; bh=9PExQNxmJD1rlt8TMcg3a/MiLIFQ69IHn2SAclF2NIA=; b=C
	TGnoAFC0fEDm9lLURdpikkgrXkIgQ1rrLSD70NP5w1VCb/IPAtX7omfABT365laF
	izHyaEY5Q6AlrSfiecXKA7CN2KVI76vCaCjgFFzADonsHH5RjCulDvsG1ILCvWHC
	/2jE97LBoIO5inNXDky7yO9b5mQXb7MCJVj5TnP6jtMMtvCWGLnvDHpzxPpIlGMN
	3FVKUphV7zPqzV6XD0Bia/GtSD0SmFmkAYNCxDkFtwZEJee0TW0sHA+9HKg0sJQg
	jOv+q6EoNQBxc6hjurOTuT0iX7cbtQEDSUKaiA6jxSYTAmM7aHiTbBUeD7xgMPQ7
	pA+VlOhC527uQHmzpuBww==
X-ME-Sender: <xms:N5kbaYdaZqYC3TzXcf8bu2eqjCWUXwLDWxlTlF-cLWatNCElAcgelw>
    <xme:N5kbaRrNLwciOkC-tK1sqvp9iODLY09hcm2sZMhRu73-J7naZkJIxM_Aw3o9Lrh5r
    kW7WYPAoA0iRd43Bo5y7M4Nz-y-BapWC-2MOPWnaC9Zh9HepZfaySk>
X-ME-Received: <xmr:N5kbaW64FdZyN3VHQldd_iqEr8BSq8M-CSERvppNISsaIn4TARBsgNasIBcxcLmBOO4lFEqfDlxYJ-A4Vvszs7i2dcUsB0b96Bfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:N5kbaXreJP3OMMH-rV-RQsml1F9Tc25AYsrBv4zan6hGFCvQU62png>
    <xmx:N5kbaYjRbTf4sfiNcPw28CsLmST-4-NNyuxLP2QVB7xObde3sqBmsQ>
    <xmx:N5kbaRLo82cQlLcLVVmohR-gKdjIc6sXzDqjEVWczP2HAkyQlcsa4g>
    <xmx:N5kbaYAFxV-sK9HhRAbPXpnDqUKXz7FcEKeE7PyNi-Wv2PEZlCGejw>
    <xmx:N5kbadRMU3vS4Jydjiygx1GXPytaRdzZE3u93-yWvxln433L_WAeOiKz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 16:52:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
In-Reply-To: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 17 Nov 2025 20:42:55 +0100")
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
Date: Mon, 17 Nov 2025 13:52:53 -0800
Message-ID: <xmqqbjl0iax6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Call xmkstemp_mode() instead of duplicating its error handling code.
> This switches the implementation from the system's mkstemp(3) to our own
> git_mkstemp_mode(), which works just as well.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  wrapper.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index 3d507d4204..d5976b3e7e 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -421,24 +421,7 @@ FILE *fopen_or_warn(const char *path, const char *mode)
>  
>  int xmkstemp(char *filename_template)
>  {
> -	int fd;
> -	char origtemplate[PATH_MAX];
> -	strlcpy(origtemplate, filename_template, sizeof(origtemplate));
> -
> -	fd = mkstemp(filename_template);
> -	if (fd < 0) {
> -		int saved_errno = errno;
> -		const char *nonrelative_template;
> -
> -		if (strlen(filename_template) != strlen(origtemplate))
> -			filename_template = origtemplate;
> -
> -		nonrelative_template = absolute_path(filename_template);
> -		errno = saved_errno;
> -		die_errno("Unable to create temporary file '%s'",
> -			nonrelative_template);
> -	}
> -	return fd;
> +	return xmkstemp_mode(filename_template, 0600);
>  }

A patch that loses lines is nice.  My curiosity wonders what the
strlen() comparison in the original was about, but let's not waste
our brain cycles to code that we no longer use ;-).  xmkstemp_mode()
checks if our git_mkstemp_mode() cleared the template[0] as a sign
to restore the origtemplate, and uses the template that was munged
by git_mkstemp_mode() and used to attempt opening it, which seems
very sensible.

Will queue.  Thanks.
