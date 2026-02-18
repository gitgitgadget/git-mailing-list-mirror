Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057162FFDDE
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438537; cv=none; b=joN1x6AeZaUaoRcNYkPg9I3rlZEJomphO+vnhKTGlQX2JSgY2vPc4LC28U4240hQOX3AG8GucktZUrFZSoPxW0gWpVJkiC/G709Pbe8rhwNEOTuBQ9TSIKeFwAuFcwC4TvN9RiUfLbUInFIOYSh8RY0G/ADM0TCT2BiGRVOlmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438537; c=relaxed/simple;
	bh=krD1wboeKEu6f5G0UdVjRw1vj5sZHzDwuFmuXQcf7Qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Imui2PY7jTfNJ8flJEkqIUebA0PtqQXNsVXNqPzhTj2+pLvaYoYDcXToYzcqX82JkrcibUSo3k2ozX6YCikMwFXPFT2wXL7MKecq05zU9fhvH5BlZBIBoZtkr2p3bAwyKF6RjI+lcBHZ784vAHo9XZAkEoRRr/ahTsf2Weyp2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FAsyd9/b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=USYYtzzh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FAsyd9/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="USYYtzzh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A5DE1D00119;
	Wed, 18 Feb 2026 13:15:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 18 Feb 2026 13:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771438535; x=1771524935; bh=phwdCxP0Qv
	9DI0WX0/hfqJRp67NpCE0FiX8coy8GWbg=; b=FAsyd9/b7HCBovdBnkWIGkHSFs
	xgVvPnmu2vDfGOQDns4PSzDxxqX1DcAP5uHrOfnAMCHChaN6xDEbdKqt532FsT8J
	UOn4v6GHPskj3HCQAqGgCfcxGHF8mkX+Z3m3XPW/JK9tQ1f3en1mdP+lwCFRwMkj
	n3V+56wzNEXg7nY5Bl1KvggWUuvKTtarOwYXGuJWRqpi9kjbGSDZ35eV4XvSNX2S
	ZbmunFrLvFeGjKjAGLhZ7B5eqDpGmcqp4qYDli/yBNK+h7VyhxYWhEbR94luRCiM
	jNtg6VpTdc+/PZl2/viRG4lHghqC5T0jwZUJqrEeTH52ttVqpooNdaE5qJZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771438535; x=1771524935; bh=phwdCxP0Qv9DI0WX0/hfqJRp67NpCE0FiX8
	coy8GWbg=; b=USYYtzzheAt07pvx4y6zi7/Emxfm9tQBUAQLeySVXLQ5kvf7fh/
	lPfmLvcmwsbZtnTm2VRgGh06PSP6mtTQdrY/L7PSgHKzSVQiPEPdVoU+sd3QwxOl
	mZlpPo67ovzAwRu9TZvfTzUFOl2jBq6GJvrcaA4BFYCMGQQ4fo6SEG0tK7zFt9eE
	BIy8rKKnaorN1zuZsFyD0YhyipqMmKRhrAe9a64bTtnAaK+KQSUfRSoD7Vkpe1Px
	JSwmD4gN6VNMRaxkNR7hCULPL6x38G4uDSaXfLryHldOeEGf2R/vlYqR5M8cZz2i
	ICIJrDH1KyTR9zYA/fDPME+LtPs6p3L5Wjg==
X-ME-Sender: <xms:xgGWabQtG9TlTTlNw0IEw2uiPKA6Pg1Rs9oHE4apX-ovpaoLyz-C1Q>
    <xme:xgGWaTzuwFeK80ucDiayzS2hUF-B_-z9_lTRMRBWCsQsQaIy5p4O2FhcuQ_nu4GS_
    a9W3VWqjcjxNZelb_scCovMN2lmUCnbnHszmByV1iKBbP_hyI8jpQ>
X-ME-Received: <xmr:xgGWaV1lacgUrwOdku35QKpeZsbCez37HBJ4lUnYXFVm87kqQajvbjelT2Z_5_meI0Nx7ty3LPUg7HNLw3yABvEpSjDB0yrHJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xgGWaZ7EzfZ2sJuOm1xzki9x3ndEkTyzwO8weadJTGw_TGdNiX7fMA>
    <xmx:xgGWaQXhK-e24dyCtsG7ml98NkYiWI2zcuJCe92Age9GAI9J7kX6ZA>
    <xmx:xgGWaQCbC-9NuYZkCkn2YMF5OQTADNItWS4sRR2L3xl1FuCEGrhyow>
    <xmx:xgGWaX4SHqEozGd-b3U3z-5blGcdl3qksA7ZDYMqvKGe51m1vQ5RBg>
    <xmx:xwGWadUBQeVa91X4IXynTMYUCSqUwcCwuvuhfqGlxYYTiJHQImbXxt1i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 13:15:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v5 1/2] setup: distingush ENOENT from other stat errors
In-Reply-To: <20260218051850.164972-2-a3205153416@gmail.com> (Tian Yuchen's
	message of "Wed, 18 Feb 2026 13:18:49 +0800")
References: <20260217084124.150366-1-a3205153416@gmail.com>
	<20260218051850.164972-1-a3205153416@gmail.com>
	<20260218051850.164972-2-a3205153416@gmail.com>
Date: Wed, 18 Feb 2026 10:15:33 -0800
Message-ID: <xmqqy0kp7wai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Currently, 'read_gitfile_gently()' treats all 'stat()' failures as
> generic errors. This prevents distinguishing between a missing file and
> real errors like permission denied (fatal).

The above plan makes sense---you would split stat() error into two
different classes, start returning ERR_STAT_NOENT in addition to
ERR_STAT_FAILED, have the caller act on the new ERR_STAT_NOENT and
adjust the way it acts on ERR_STAT_FAILED, and if possible add tests
to make sure we react to failures from stat in an appropriate way
(but how? --- it is where my "if possible" comes from).  So I would
expect that the other patch would be to split ERR_NOT_A_FILE and add
ERR_IS_A_DIR, have the caller act on the new ERR_IS_A_DIR and adjust
the way it acts on ERR_NOT_A_FILE.

But then the proposed log message below says that in addition to
NOENT, it also deals with IS_A_DIR.  I do not mind doing these two
in the same patch, but I do prefer to see each patch to be complete.
If a callee is changed and starts returning different return values,
the callers must be also adjusted to react to these new return values.

Looking at the preimage of [v5 2/2], we stil check if dir->buf is a
plain vanilla ".git" directory only when read_gitfile_gently() returns
ERR_NOT_A_FILE with [v5 1/2] applied, but in the new world order
with this patch applied, shouldn't the caller deal with ".git" when
it gets ERR_IS_A_DIR and not ERR_NOT_A_FILE?

After applying this patch but before applying [v5 2/2], we lose the
ability to use plain vanilla ".git"?  That is the kind of thing I
meant by each patch to be complete.

So, I do not understand what the splitting the topic into two along
this axis is trying to achieve.

Thanks.
