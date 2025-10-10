Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4D33D8
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111340; cv=none; b=Z4yjn6YP0ZM4F5APGHz5CJY+jtCiqPYTo7hZHS/B/yxtl24camcI5J10CW1lqTRyTpnsWIpwdd1z0tCaGlQzWK3XQhfSychp6+fwHjzkwtEQfp8SmoM56i/NAEMbiDx1cLXEGZd7l8ulQM1FXT2xiyFnOqPGX1/KztwoiR/eO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111340; c=relaxed/simple;
	bh=Xaqo11A9RcdobQDDHBJM2ZD/iPuIBRB4hn6HGzfCF1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RKmOjW6lhZTUOau7oZCXaMCXdpqa3W59mlmg0jsOD7RHiY/zwKIDCVizoq8gwQPZSk9HhPjKHFqU7KZ+EqTnogjkYiAh2XKJUl9qbW2csD8H1+aL3cacdLat/IjWzs48EU7w2VTM0gnFvLbYdbGQ7S1bt4eCO/rz/5aG6xRaUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UhlDCjGC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6I1c/fS; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UhlDCjGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6I1c/fS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80377140016A;
	Fri, 10 Oct 2025 11:48:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 10 Oct 2025 11:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760111337; x=1760197737; bh=8FEx30bLC1
	PPhYXWdQYCVwquwZhkXNm8Xa1iaqH1FmI=; b=UhlDCjGCuUDBBO/ncBCc7Vy9w/
	7OXiwV5vtgm8UD2uk1w6h/1OL48fKxgzgNcMAP6qDdbIVczFhCJ3MUpkh8Y1uy7r
	k7dfEJY3uvqac3CGyEHK+p+I0u8Z2IyNEO9KWfztOSbiXFX/iMb1J/1ixcnR4Los
	TTBc4ZTqoh8w4rlRdTiPcq2I+30nZQ3kmCnb0aiAZUejWPM/kwL7U6ac0SkyQ66X
	MBcK96hep10btfu5L4HU0g0mc9ZaSkg39x+U4eOXKrBmvaZmEHcDEVPCTz1NLCRL
	kUSFydsFmyUkrnhiuLgFdD6f9mYw7p3ad2fqQz0hjN9ofRU89RursWxpDfKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760111337; x=1760197737; bh=8FEx30bLC1PPhYXWdQYCVwquwZhkXNm8Xa1
	iaqH1FmI=; b=h6I1c/fSmH47AK3X+e0q4EzDkT6PTIlP8JzMp8L+UsS4WB0xjA+
	o20q20UOBdmHAUi6ENsn6DglM9qQMhTA3Nwyb6QkK6DZaiAiPE9tqw25SZKbJFEG
	huS+2qqVeoYYS9WWFInjyTWNT/SVfEYMqrVkdAEs77gv2ZRHebeMG48kkbR20vsh
	YHAkUjOW2ObyIfiVqR4u14uLOiwC2c33fb/AS/3bD4+Pm41RFkm+w7hKyoRT+k1+
	RGxrsgJrkeVcbSNkCDaOhvYasznoMwEpF/TFaSR0lULJhXF16/2fTeyB4SxL4EBm
	dJ51cfQwa3HmYQihFDYS0LbEJ5zxo9DMrsw==
X-ME-Sender: <xms:6SrpaF17cwYDFLVpYcnukdK9T8oEDFHSEZ3BKQNGDzcg9iErtqzL3Q>
    <xme:6SrpaC_76frs28aU1cam3DCTCZNloEYZcwyeEi-_QfXOnS01ABNOKm66nNBg61HkY
    8M_uJjVHPr8QpRetwpGbs1AiWwT5np-C0sX02-U_tmDy1-MIkGqSA>
X-ME-Received: <xmr:6SrpaOO_sgFSUGgOEtUx4kABoY9Pmp1QBViBNw6v3Mx3I73x3os7U53_tIydNFV0Tf0M6gvF3v8cwhaUQdK5r6TVocSWnM3tjH-X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6SrpaOfPZpZL2LQohh7VfzOWFbq5CiiX-VL4P8wkUo6syZflQBLhUQ>
    <xmx:6SrpaFXMmZiDFeFQSpzummgImL977jW1sSs6jCzh9SQMRXf0XE8kug>
    <xmx:6SrpaOi3aD-pUY-h6GovabCemRzXPnMzPqYTxgXNX4uvQaj06eYykA>
    <xmx:6SrpaM8F6iSbRMg_sFn7c1OsZBAOzJomxH3Pf-tfBH1GiJbPYytqew>
    <xmx:6SrpaM34qnEgkNUuQSVMg7zfqdYp2LioD6ZqJv3un7eYQ4PeTt_rA0BW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 11:48:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] refs: forbid clang to complain about unreachable code
In-Reply-To: <aOia55_sjFQjw1UQ@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Oct 2025 07:34:31 +0200")
References: <pull.1984.git.1759995982220.gitgitgadget@gmail.com>
	<aOia55_sjFQjw1UQ@pks.im>
Date: Fri, 10 Oct 2025 08:48:56 -0700
Message-ID: <xmqqwm52ahav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> An alternative could be to fix this at the source, e.g. like the below
> (untested) patch. But I don't mind this too much, especially given that
> this here is the only callsite of that function anyway. So please feel
> free to disregard.
>
> Thanks!

Indeed that is much nicer as it targets only NO_SYMLINK_HEAD case
without affecting the other side of #ifdef/#else/#endif but as you
say, I think this falls into "once the code is written one way, it
is not worth revisiting to change it with more iterations" category.

Thanks for very sharp eyes, nevertheless.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bb2bec3807..cb402a2a54 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2115,7 +2115,7 @@ static int commit_ref_update(struct files_ref_store *refs,
>  }
>  
>  #ifdef NO_SYMLINK_HEAD
> -#define create_ref_symlink(a, b) (-1)
> +#define create_ref_symlink(a, b) NOT_CONSTANT(-1)
>  #else
>  static int create_ref_symlink(struct ref_lock *lock, const char *target)
>  {
