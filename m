Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48034D3A9
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787422132; cv=none; b=dJ5QtVrsRfrf7dKtw+YYLmNBNnBaD0Tuv6WH2zs6+xASwfvK2tlwVaIPbbvzpDEi/9wYwI5J9cq1R2VmAXNy+QZKhA3rWUHwrsHiPZi++HqEMvjbNcPQvRnQQPGviMYdRidhzN9/YxBYRTC33F9tNly1M4VjRHhYRqRALyldcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787422132; c=relaxed/simple;
	bh=6pVlORUJ3QP+yvufzcGhJG6mOATFUzQA/XPc3YozQxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N8ZaXnf7Gi6JnR2gCgEFuZb2Ghipjpkx2xik5psOqnCd6ygUIplQTCodIsXtY3kag+NoLCpD6MKjiZSAij17ZyzzWJQcrvL3UxxPbASwKiD33VAGUYE1Y9ZB81RC2ZxDECgcejjbBW2kSahmW1gdZqcc1dUyqygBeAqhwo4gJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ov/LiyTd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9U2EeBq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ov/LiyTd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9U2EeBq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C7CBF1D0002E;
	Sat, 22 Aug 2026 14:08:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 22 Aug 2026 14:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787422129; x=1787508529; bh=YhRtbvyvaI
	sK4nqDx1b7P0Z/S4wcA5n8m1VVuqHRHF0=; b=ov/LiyTdJngjNVDX5N/q3Bs0PZ
	UlNHXnboUZdA9Te5fwx9wh8cPMp+D8tlF8nBrkTrc7y/S3FsRiQak0QbPY7shgmd
	J2qJzgbZ/H6f0X+RYDA2K3AxTQdmm3a24GMGLwNXGkm1NevY2ZUdWHdBKZf/g2i0
	YxdaWy1YRoZnnBGNNoXPLFGNASSE3nH9jcKqU3VBe6V3PBj1UKX5mZMEVCfMVfny
	oUOQQxxtPO27d+zIqNYHDkO2c9x7PdOI8L6+VrySIwAlGIWAkSWjjPhZCZBa25MW
	VrkxV77AbwAGlb+mactNnKwGWEDd9dr1Gq2Golf9LpulsqslL9ICtj6Vl8JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787422129; x=1787508529; bh=YhRtbvyvaIsK4nqDx1b7P0Z/S4wcA5n8m1V
	VuqHRHF0=; b=Y9U2EeBqq1NNONJeguX4KoIyvV0kPUiqOtusjH8M0CHzMR3xAha
	5FKHzIOQfpzA6HLiYUqYsPcxN1AlLh04WiHhnC3fp2CnOm8N59puTf9XLD1afsq0
	2weOts9qh2U/hKn20L9qG43PLVKBAcju6utUZq1vk+ydfmT2sFExxNrPn0Vierzf
	Je8k5FKgRM15amIzpC/3iU1il+joVFkfDWf4bG859FHmRoyWFcmnhHmcnT4GWtZu
	7IqZ7QFn/2jZhQxOnLCpuina0sW1A/B7MAxV/lPuUM4OIGfyqEHzPziC0fxc07/x
	wUIBsKLEsZ1/6lxf666sF5+LkoV5+AAfFEw==
X-ME-Sender: <xms:seWJarJmHFw5dwyf2H1QvkU9goFL6ASSShEUAeAMFr25QQhJQknJ6Q>
    <xme:seWJai3n5LtFj7wFXxsNE4WsJiJucDTUIXlXK49iTDds56nsbBl5OVE2mcSRd8fNl
    opD0wraxKP75oqdykY9sCUIi-2WCNG1fDZFdTJUpn5GpmYFVkvK>
X-ME-Received: <xmr:seWJatg2aBQucWUlxOWpjnQKI1YRBYD-ktoG8pqzJnxi7YOR6VOuvD0arMpnooCD39alfgVizmYSplBXVNpfqssTZeIohDuPzA>
X-ME-Proxy-Cause: dmFkZTFJlTQAHbpcY6ZUGdp+b1yuTVm3DNR9csB3Yfv+QasQHMir63WdzLKpHIEaBkEIOU
    DKVUBXG6oqHZWbljFGP+t0TuW/P0kKUHIQRyffHzjor7eegvgEaqF63c4qaCEfIefK2jff
    QSxEv2zSHHMpJ9ECOMJdyH5X+hcCBII0ibv3RehE0a6jKWmVKvKxr6TkCTB3Qm3JbKzZZ2
    fL59LzQ7Xm+9K/n6t/pSEmGC9df/zr5YwdeOehTdw7mgbN4MnSe/G3y0nceuoeaVlO1Qhj
    B2P2UlAtk19Udi8J3sPg5VUMWZqJ8CDmgn2BEywch6gC864L/APhyVMuqcacj+KoalS9m9
    2hjefUpaqsYiFFUd+ihYf3o7wxgQhCsliltLmEa9FBuISX2dRj8a6i6Q+vOhAm5s0fMnxn
    +4PiftLDgUgNFSIXT+daiAUrqixpN5YWAT2SX5uv6e54JlbHSTfAlxdTVxb01Ax1bl4H7q
    Q7Egku+d1zwGshrB7AzKAtwzFO9e1pDS5alrovfpbpI+ELdSbVNs3aR/A/zCOapDJjHx/f
    9QVG0SvWbkkiLAJZUvZ56gY5Kz6Q6SyjD1KOEsBv52oh1YmXOddSIhqBKIZyyM8+5Gc3TN
    qYniJEnVa0znsl30Y84SOHYpNfq9D7pWRW/EnlFGSoEwLveUtDUT2NsLdWgw
X-ME-Proxy: <xmx:seWJarXZshTmD5na3pcB2IFe3TlI_nKghgyIko6sI9RL4VhoYjengg>
    <xmx:seWJakUfEY9_j_z7dXgHEggruDo_r4BTvac6aJP7xJlZgByRo5IJ2A>
    <xmx:seWJajhtLoUKkzFCzd0E7_u_id9sA8K0RdqtnXh24SBW0900d6w6yA>
    <xmx:seWJanZHjbhmyLqIj929vTAbV2gvFF6SvhucI9XdzcqGT5b1OqfIpA>
    <xmx:seWJaqurW0Q4GBiCLjoA3oxQHlcgo-Z2-7JaljYV9oBOauB9TB5Jmrvs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 14:08:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  Yoichi Nakayama <yoichi.nakayama@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v7 0/3] worktree add: improve message for ambiguous
 remote branch name
In-Reply-To: <pull.2197.v7.git.1787368962.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Sat, 22 Aug 2026 03:22:39
	+0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
Date: Sat, 22 Aug 2026 11:08:48 -0700
Message-ID: <xmqqv792uixb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * fix grammatical errors in hints
>  * narrow the scope of local variable oid

Both changes look sensible.  I very much like the new advise()
message that is much more concise.

>      -+	advise(_("Branches with the same name appears in multiple remotes:"));
>      ++	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
>      -+	advise(_("Branches with the same name appears in multiple remotes:"));
>      ++	advise(_("Branch name '%s' appears in multiple remotes:"), branch);

Will queue.
