Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2932ABCA
	for <git@vger.kernel.org>; Sat, 30 May 2026 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780180646; cv=none; b=TmcsevPLVQT5xuYw9WXbI5VF3xNsqnf8NRMeYVla6MrsM9Ca8r7afG4BWCZ6XBJXxcHjHMJK2Quo32BArZ1qCSY8TGEVHdj7nL++nmpXt9fwp2Vne0fCOKgKHB/De1FDhRwtz/Nbg0iHjhhgYp4lqS8V+YmD2g/+oq7Pk7a6CLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780180646; c=relaxed/simple;
	bh=S9WObS+xxY5UyYA7/SkHDEQ/aoJHROfI6NoF82e4L+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etxAkUHJ44p44dWf5E2kLzEQQXfNXv0RUK8yCt8HDuZB0alcxKkMTV0rOVDTulYXbIaVwvM+vB7OKv9lJV/on2px6u1EsBpfQLGLqmWnwA100VGNNVzi8oPGvhj7PDXIjSp25VXdGwZiwJxepeuZI80uEWinbmtl5ocAJHEbW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=flWA7H5t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fc/NtA39; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="flWA7H5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fc/NtA39"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ADC21D00041;
	Sat, 30 May 2026 18:37:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 30 May 2026 18:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780180644; x=1780267044; bh=nm9Wxg6LK8
	WqGWw7h7sTA9Y8zpCxiWadSsyOppK5wNI=; b=flWA7H5touTG/Vg1b3aXA1SNTE
	kzx0AhIB3NdDaKV4jjwvXCqRA00zMWd//KY6Q4r7Vr7UdGoa+YVypa3UJuv5HKit
	ObkLKy8IqUGvbGLgXQuQ5YovEXmQPvGUzc/Umr2GALylnX2MP+othgm8ZoYNU3M4
	+4hgZ/1C0GRJPJ67Vep3P1gLTcYXJrkIQNdqjTOA9JZtU8TgM5Cd9AQdWSvaBbGj
	AHBEWibFpiLNWW0Il6vD4moKpobbBeIf9mBycrzL4PD0lC0bei+2WGWmpxmQr3aR
	vjzE803yYRsXAm0Wkto11w9BF5ms/BOXrjCXrH3JD/WYgBqNAKv+x1Y5pMmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780180644; x=1780267044; bh=nm9Wxg6LK8WqGWw7h7sTA9Y8zpCxiWadSsy
	OppK5wNI=; b=fc/NtA39onyTfEGd6VCHEzQFkB0HDBFXPFn5yiwMNvwDMbdSqJy
	8x79l2Mc/D2dVBPU+R/zNMb+r7lgDGJM85pMgKXhprlIwJIj7avLTB/HSPWA9l+Q
	zIOaX6uyd/ubt4lmXXbZ3/0Q/nrIhMeGu+BfF4BZt2V0ajscvDz8YpHAl4ZTApKv
	wPMcOrug+NTvtMeKfcM368oqgYIBZG2HrlK7KYkjXacDPy0wD/oCnR7J3vg1gzBh
	yBk5vwvc3kSPxcrA1QXGWCgdozUU+1+vyWVYNRFz28TYjFnUlKdw5twxg9h6Qxpz
	Jh2YxztufHWjFLtXW8sK0EuBPGk/sp/y4FQ==
X-ME-Sender: <xms:o2Ybas8L-KXwpKgIkzSK7K0EN4VHp2DvrSY9KKyJyDite06hQn8yrg>
    <xme:o2YbarnnOQXhiHDWlSqc7_5PhV88UEiViA-r2e-iYXE73FQRqS8zjKUi7F5inkwua
    tVT2eh-lAeFM_qTsQxnX3GYwTOJ3uJSXerEYTaU970JRYmOvHsO2Q>
X-ME-Received: <xmr:o2YbaqVydu_pbcrn4Vp1-oWWXMDxz9p2RvPehhn-KvarrsPSPnD7Zpn-k2R8fRE5i2EFsessxT51JDSBiV5HeaFcNQlzccn4Ikeb>
X-ME-Proxy-Cause: dmFkZTFzmRXBrXrT+ERfljao8JSi+mrwD/I79AWq8q1kcWt24ZbwIzyYLqOVAtk8tLONiv
    exQhMNDVXho/p6Pdy+S84JuDm81qTqrTfSEdfKbBRdnxKXgIIU2IIQjMVfmegpx0os6pKa
    /eRljwzbF4WwzvZw2LJcZTy5t16Cmx2T0ov4dUzCxOtXHqXxkAf2Ecs6Te6124XiIE0Jtx
    U3j33cMgduLwTogIrq7LODqrKXwjrIDRu7TE1sEWBMf8mrzZdFT8NokBWbd6xkm600RyvK
    LtPekFJo/W3oloEzzjz8n9i8blRX0o2sVak5FdgMKBTl52ACmUbLXRPbNYaQabYSO3+oQ7
    bk91e40b4UKq1VKd/C6pNHZCZzI6bKFsSUvSR6oAto+lE6VV8naneenNfKKLZ8XPDy4tMc
    Q1XK9K15HcXtzy6GDNPdQBtzQ2YsVbLLn+1SPOGirdaemdIUphz+eCaViw8qnOIQFzhtjZ
    RmR1R/tqNx3+IvybREOjizYAKtj+bvk0LiD8MWtwzRQIHa8yNVvEwHyDtGmSDZoTV54//C
    yFPeaPWaZSnYRyROoA3AkKLlhMHig36whbeUBsmbmhS9XSZ7Djclw8eii5pKxaUQv3tP8b
    9kxyOpG7UJDW4P5eNJrzk/pBlPJeDWeyehsNGtVCeoN2Vu/jLxjoQHlPsJEg
X-ME-Proxy: <xmx:o2YbaoE4LKybE4IZ0ElL2TTYGrnHeyJlMbZaD-Oa3dz1B-sX1mn9iA>
    <xmx:o2YbauexmTPUaAVnnaQouNRaPag9AeZQlwAsACheiXfImvmG_1Ug7g>
    <xmx:o2YbahKjNmV1_4jxIXtoRCXd7q07DvCDZJRoIRh4fwfzo9MapAJk2w>
    <xmx:o2YbarHilnWXWKChSFPZI_XKOtik45AkI2oDPjBB_Zdw4Z1tq9Yqkg>
    <xmx:pGYbavXldNhZzuivcX22ftvNUQ73ef2wROU8hxp7fsKZ9VkphFNnmU8d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 18:37:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 2/4] doc: replay: simplify replay.refAction description
In-Reply-To: <simplify_replay.refAction.70b@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 21 May 2026
	20:01:59 +0200")
References: <CV_doc_replay_config.709@msgid.xyz>
	<simplify_replay.refAction.70b@msgid.xyz>
Date: Sun, 31 May 2026 07:37:22 +0900
Message-ID: <xmqqy0h0ed7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

>  replay.refAction::
> -	Specifies the default mode for handling reference updates in
> -	`git replay`. The value can be:
> -+
> ---
> -	* `update`: Update refs directly using an atomic transaction (default behavior).
> -	* `print`: Output update-ref commands for pipeline use.
> ---
> -+
> -This setting can be overridden with the `--ref-action` command-line option.
> -When not configured, `git replay` defaults to `update` mode.
> +	Specifies the default mode for handling reference updates. Either `update` or `print`.
> +ifdef::git-replay[]
> +See `--ref-action`.
> +endif::git-replay[]
> +ifndef::git-replay[]
> +See `--ref-action` for linkgit:git-replay[1] for details.
> +endif::git-replay[]

This makes it a bit roundabout for "git config --help" readers who
wanted to figure out what value to set to the configuration
variable, because the valid choices are no longer listed here.

Finding `--ref-action=<mode>` and its description in the other page
is straight-forward, so it may not be too bad, though.

> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index f9ca2db2833..4de85088d6c 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
>  
>  CONFIGURATION
>  -------------
> +:git-replay: 1
>  include::config/replay.adoc[]

The use of conditional attributes (`ifdef::git-replay[]`) is a neat
and standard way to tailor the description depending on whether it
is read as part of `git-config(1)` or `git-replay(1)`. It correctly
points the reader to `--ref-action` in the latter case, and provides
a full `linkgit` reference in the former. Clean and correct.
