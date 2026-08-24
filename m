Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53135CB87
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583519; cv=none; b=KJRJhb25rvhJg+2jiQZL6dYy78Gl3WQgvxyP4RHVIgktZnv6xYu6t6FQhNJ33B5uW8GF6JgWgiAM2tMGbjHwDNrNVqT4b0upMsN3JvZ6uO5mbdz+A7tgGuNImYvgxh8pfmabI/nRKXlEhJjGzI1nreY2jSiRmN3UUX4VIVqEdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583519; c=relaxed/simple;
	bh=eXghryvUtuPu5qsMyI2sqCOAD+r7Q2NCycnLDBmGRF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHXExi35V4bK+NA2V/3Wdh2PXUxoABPbCw9c0rmz4x2jNV5kn5t1uvAg7anG3wp0AMpcOzebMjHOd3iEUNcWZo8gKkG+HMEKSIrioE3oBqmzstrJ3pEtbY+T9jTsfHUo1SGvhPCdhnECdT5a12amdblEw1H0qsji4AwqkXZUs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A1KMe7Bw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1p5nmcF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1KMe7Bw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1p5nmcF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6FF01400014;
	Mon, 24 Aug 2026 10:58:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 10:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787583514; x=1787669914; bh=D8remXMeW0
	mVbg36yeCgcnQZKbaYs0bpcmY9sws6d9E=; b=A1KMe7BwpzSUpaCZ4gluAepSvm
	zRYfMvDnZhZC1+nI7oA7JOVThGWCrFEcF94di5LHS8DfqDYV7a9Oku4hYvOeYi1Q
	XqKUJPlbJq8GX6nF4tqHkwg9KHrnA0DuNG6zAQpY4/dPR/N5OIFFr5UlAXfI9J4q
	lGFHr3oEiMH4k1hkCbisNPoqw7rsqE6BNABUz2XGOWVpG8SlzXB7fQySe/LO28JG
	K1V7wBFGAsgxrLVEouiR5o/cIY5yOzRDtpYy03DFQb4kQRw1jNnyanlXglNSRvte
	Qje15pvhPb5q78V5fY+VjqkWvquEBOgb4MzBkSmDMtMKM6Hj37rkBXlHomRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787583514; x=1787669914; bh=D8remXMeW0mVbg36yeCgcnQZKbaYs0bpcmY
	9sws6d9E=; b=i1p5nmcF5Gj9k3e6Hv2GxRhjCln2menJG9zNITHjJSq8Dt9dGzt
	hru9saI4/VK399ByRLeRPM5Nf8WPV2NrlszT3JTyPFb9D8td4coapOh/jHd6jC8K
	4/0qlBR2eYpUQQ61afy1NH7FS2JhMoZpvGrvJXxBROYAFZeCFuUNb7aLt9jgK3/F
	bYOok0bDXBrMSH69nOhQNGINPeGnNBnudJAIXfUByrj+RPi9RRc97wVsTgrIKRrr
	tgogjEH/4MrpYIDs7SaicLT8tsn0tg3NfAWYbADQTM+4qNrOWFYT2NIRdeEFrj5Y
	2YUZYbPwqQd1LhBvM/ONDHS41Vy2YT1/D+w==
X-ME-Sender: <xms:GlyMan29OQAeWvJFhhY-J-8XG6jfy4gdbaCXhHCiFlLnyhn2rE_ufA>
    <xme:GlyMas_iPCmKhx1Z771nFZMh1LUm5UIStj1ZpNq1jrXgdL8z0IgC_HJJIOs3sefVW
    w_EYBfCNnnBrPYL7U6tu1RLri9rUIPWtDPGg-c1mwDq1yBozksmW08>
X-ME-Received: <xmr:GlyMagMfmX6XjTBY3MOq4ZpHWikyUbEJkc8Q67XSffGbUcguzgjfj7ymGgdFkhrk3SAIcd6uGWYPGmzU5csrqORBKYSFASXJEQ>
X-ME-Proxy-Cause: dmFkZTF8/aYw0x5XMI37oCXXOwVDLeqQPEKSNjTEHAhUnU3VjSy+wxxYEBoVT548lOgFF4
    oZqCsMiynvW8Iqu/qsy/3irbN/tSLSxwpt94wExWW4/NVT8fO7AwPKH3Yb6BbGOfLRLTSc
    IBvII7Q9L+A3EdlSWbx6/OtrEP/KhaFpLVGlS9UAHSxrkEzS0eJIyxSsJe79iJYKtsMdf5
    ZXcbfo11GChNviNxhW13kdKxmj9BFbb8/iZxoZKf/+kv3hqy0FLbvsMLGr7hxbniNG3THx
    BmuWQKDE7mLCjrRSTiVWtFe/qCOorXnqsQanWnyGQTfUcGQg+/iDG2vwY0r69uH+Rt2GXM
    bG8Tu4LsPm5ZGpQjAZHRAp/zSoFNuRExGFnBGWpgazow4+7Zc1aajSRuD9qDy94Y2YCvHA
    1pMriHve8K9To5ZgsqoPVSzo9EkREy3Uv5LQnVEfxogWLNcUo/GksOEB/03s2S1+bYO0P6
    hwEOHk4Xgq87RJlzC8p6sqQRaCHMjAangFnaxSLEijrgTLAROBea8O4CmAhyPg/4oumYuN
    jbSaR7hQxV7QbalziY5aI4op62Cw6v46l3lzwxADnF/KZ6tiM45L+oinClYERJvuXdreZR
    eoG1ToC2OYmm9p9i0xHfE9nO17WjIQOdcjILgPh+VPPMTxpj7M7O5/RoEmbw
X-ME-Proxy: <xmx:GlyMaocQdC-NSjvKWptvnf6eMTayRSV7dPgRXjLYdbrq0RQhy5_0CQ>
    <xmx:GlyManUQzv7hm1pSYYGytkL9ohN71ibep432uvZY2j777qjFGtZZRQ>
    <xmx:GlyMaoh5XkY1sdul6HiJzBsgZvd_qlf0dbnD6iYquY-ULjjuLe3cdA>
    <xmx:GlyMau82Ayfb0bFrXUjnqJl1leX_L_B79_pPS2gFbwH0HbOMBKbaVA>
    <xmx:GlyManvBMise_bcBhVKUUR33hgxGGK2DalX_8ORZJCL_vlumJW8uNv2b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 10:58:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Vladimir Sitnikov <sitnikov.vladimir@gmail.com>,  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: Subject: [RFC] stash: let the stash stack live in a
 configurable ref
In-Reply-To: <91feddb6-0d1b-42af-9942-307b98aa747d@gmail.com> (Phillip Wood's
	message of "Mon, 24 Aug 2026 10:13:37 +0100")
References: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
	<91feddb6-0d1b-42af-9942-307b98aa747d@gmail.com>
Date: Mon, 24 Aug 2026 07:58:33 -0700
Message-ID: <xmqqfr03sgyu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On a related note I've been meaning to add an option to specify an 
> alternative branch name when creating a stash, so that "git checkout -m" 
> and "git rebase --autostash <upstream> <branch>" can record the branch 
> that we're switching to, rather than the one that's currently checked 
> out when creating stashes.

Interesting.  I think we have seen ideas floated to allow per-branch
and per-worktree stashes in the past.  I am not sure how much we
should rely on the stash message, though.  The more heavily we rely
on it, the more restricted the end-user messages supplied via the
'-m' option would become.  If we were to officially support
per-branch stashes, we may have to adopt a more structured format
(which could be something simple like "at the end of the message
after the last ':' is the name of the branch the stash entry
targets", alongside a tweak to the '-m' option to always append
': target-branch' after whatever the user gives as the message).
