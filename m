Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD91E3DDB
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123448; cv=none; b=JjuH26Wgq5cVInh7dxPBzFBA6ISH9dhv8d1gAdJEQhdqyEUED20hYO9+WLCbaCE9iCunsxtIxP/+IqocOGCM0Wt52uTV6Tc7bEqMTgGho/GaOw2db6YqSXB742WS2IC9gi3IpuJkVHGbU7v01k7ufkDL1k4pvbBdhilBAMC1XRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123448; c=relaxed/simple;
	bh=GWmn4oPmFywXZrLSffl4SGyzuzUP9PHshnU//WUUb2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jf0SXxrp00/tWuMkTa9BCN0hlctiD/T8utcMf4dlwMQZxDoLkRIMD4mli4w5eTAnrBMBrmTVLIQmSOQgHCbtFtfpf64XQ60bG2olrMxgWXA4XZvmkEZ48kK9sRVMriGAjz/lTnxWWvfn4VbGsswKDcAZk5fu8swxv0VkAyRAGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bRIafaQT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFbOh4SV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bRIafaQT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFbOh4SV"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CE0F5138019F;
	Tue,  8 Apr 2025 10:44:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 08 Apr 2025 10:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744123444; x=1744209844; bh=lCJ80sVyIZ
	hqgv/ZVK34g55xicVVz3ENDwVXHm1qBDI=; b=bRIafaQTI9tgo4hlHzlUVQsF7X
	014gbAbmsKFjtt1rwtZ3N8PKv/M5oZUe4k2Uz5jecIsccvPYYc2NHvHvcGyAsS43
	W7sHesi/ACfdI/mf6Ur/JEj9KxsMMbQWQ0l0WCv53Pg3crpSQ4wg72PG+1Bj2N8v
	tko86cNMfnc5+8D2L1CWIpk15OL9dudLOT+G0mckxnGYUwLG16/yOKwzCVDI9dje
	cYJ2WJiVK4s/1SZprdyDXj+L3kbOS6Ah6Fdt+iX3VJGoybDlphS65x3kujsiqAFx
	PxTCaQzhG8+tnRuKrq7cVjtZ4bxIbQTxdlch10gyNI3LqvsshtLpcx5Pn33Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744123444; x=1744209844; bh=lCJ80sVyIZhqgv/ZVK34g55xicVVz3ENDwV
	XHm1qBDI=; b=iFbOh4SVbfuu0ioKi+sMp7TrzHDmkMAdg2P7CBpurjrNu+HYzXj
	ylehqopcjPavTC9EfUW1dvytZKpnuhztVgyctvoGhh09M1BcNEkARKRqRCompidU
	3/LaX3DbxFmKbw7MJJw+/o7a6CkepEHlJsAhrHUULhyl6gdqunh0VsnZlc1t/RcT
	N1mZepRzl+5SN4L6+lMctP4DKFwKpK11YEwY2JBhyAdEQgEqFGROpeMQRs4BG3iS
	d6NOpWlvKUiDnovH1jpucy+gyZ0zdgSNZcl1Ob6KMWb+eNChXb9fMbtQDJ1GsDX1
	v8rh8Jw0OyOF2IDPFs2rD540L++b+ifms2g==
X-ME-Sender: <xms:Mzb1Z4Mhj8B7IrdJlC2xlWkQ_6LtyyKw_ti9Hk7ZQhwPqHgqMuSS4w>
    <xme:Mzb1Z-8Sx1spgJV7rKWCzAcohDIZYi8XLkoT8_GFpF5Vym5MPEyKZir9Ix57bcrZs
    RYNMknTYODpiqziCw>
X-ME-Received: <xmr:Mzb1Z_QhepzCdU411iyq2rr1D8NNI6wn-QOJadJ_SO-SNpPMQB7uBU3NJyAzUNUxUXUA2b-YMCx8ZCrxyfZ1lTlPxbBcHstgVNL2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:Mzb1ZwsZVYSt5s4cXRIzSGZnpX5JWgneFZ5bHInKhUgM_UeD6liM1g>
    <xmx:Mzb1ZwdQI6m2P3rOd2znrBQu7sw8_tukUxHwHScsBC0KBGv6gcbZyA>
    <xmx:Mzb1Z035SReR2U7f2QcG9Ol5rNzK5wZNeHrogszgKmSo8Rq2XYi_ZA>
    <xmx:Mzb1Z0_lE2yy77K84ndjgPpFtKze5qWRHNEOvNpqGT4jzgRO0sc99g>
    <xmx:NDb1Z5yIECK253LV4icIzWAq5qn5IqSL9d_aqDe1w6ytm0uehu6fCwrM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 10:44:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Phillip Wood via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] [RFC] rebase -m: partial support for copying extra
 commit headers
In-Reply-To: <240d1cab-b564-45ae-945e-cba621aa7562@gmail.com> (Phillip Wood's
	message of "Tue, 8 Apr 2025 11:15:56 +0100")
References: <pull.1902.git.1744041163929.gitgitgadget@gmail.com>
	<Z_R6W_yjJEYuWo0A@tapette.crustytoothpaste.net>
	<240d1cab-b564-45ae-945e-cba621aa7562@gmail.com>
Date: Tue, 08 Apr 2025 07:44:01 -0700
Message-ID: <xmqqr022yaq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for sharing that, it is an interesting list. On the subject of
> encoding I do think our documentation could be clearer that the
> encoding applies to all the headers as well as the commit message. As
> far as I can see it only mentions the commit message, not the author
> or committer identities but repo_logmsg_reencode() re-encodes the
> whole commit buffer. Out of interest do you think we could be doing a
> better job with fsck to pick up some of these problems earlier?
>
> I think "git rebase" only cares that the author identity can be parsed
> by split_ident() which is fairly lenient.

"rebase" already knows that it has to be picky which header fields
need to be propagated and which must not be, doesn't it?  Can the
same be said for arbitrary "extra" header fields?

Information on some of the header fields are inherently destroyed
when you refine an existing commit.  The value on the 'parent'
headers may need to be updated (unless "rebase" is fast-forwarding
an earlier part of the changes on the same base), the 'author'
information usually wants to be preserved, but when the scale of the
change since the previous iteration is so large, you may give it a
new authorship, the 'committer' information should record who
created the new commit object that records the result of rebasing,
the 'gpgsig' and 'gigsig-sha256' header fields would lose validity
if you are creating a new object that is different from the original
by even a single bit (if we are somehow recording which predecessor
commit the new one replaces, it certainly is safe to drop these that
have lost validity, as we can go back to the predecessor to see it
has a valid signature, and the change in the new commit that lost
the signature fields is the moral equivalent of the original.
Otherwise, carrying a stale signature may serve as a reminder that
the commit was rewritten in the past---I dunno).  And so on.

Now, one thing that worries me is this.  If "extra" commit headers
include truly extra fields with unknown semantics, the machinery
cannot tell which ones are safe and benefitial to propagate.

Thanks.
