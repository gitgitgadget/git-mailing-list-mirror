Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FC12C7FD
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153859; cv=none; b=rZr5saBRFeSL74CdqzOokZJktnRk2cAWRrODKm184Kj8MsZpZamUhAOjAK/9IMivTKgWYfnUkCxCs20KSXWYFlQnl0hjgFxQBAEW5+Gl/wXsUS5fKPEXjBIYOEtorR50nc72xe9pDQxvrVEjWU/7GkaMCTeoJGPEPfg348BDXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153859; c=relaxed/simple;
	bh=TMgQh9nEhGgkqsOepGXHCWj0IYHYxWGeuZ52Geq8eIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+fTTupUNNwY5oemuGzd3e217IoKlbJac3ZxfX1qHhL04jmNQ65ytxSyLt20hhAjsU2BIGtrvj51xBTIhNH7YoDtcW1mJ9tJ2lUHLq7iUn6yV13PaTD+dGBp5ywTfyj59MuZQ2ftelNH4WmxzUFrfjWR20qRewI1R9KPDTLE750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QCr3JzsH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGMDFdno; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QCr3JzsH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGMDFdno"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 230AF11401DC;
	Fri, 28 Mar 2025 05:24:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Mar 2025 05:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743153856; x=1743240256; bh=thXXNVucmS
	v73GyfSJIdmgtbq24a7n9V0QFGT8cQ0pw=; b=QCr3JzsHv/sDMCTNR+G+mwmNdc
	yADEiVss/Nsp30mX9HFME11gcbTkEJ6gptkvZ6XgT9STCTm+GWLWlq9/YTUliT6s
	iVdAN96uBgYZtz1Kt2RIPvDgTJ61xfsC4Xl3aUlvxcoXJwv/eWKjjSIG10h9WtvG
	NKZ4yehSmfZ9XmTHuw5cOG0BdDoRvnwlhUMxw5Ya4qR6cFGv38IL6cCMQ+DHv0YR
	zujpU0FAlbv1TSjN+oN43uXciJ32Y2tqcyD9oatzSQuXr5NYfkp/2AY577YQbMyK
	WcoeKkW8CsKVPQTIK67/yERD0jrv115wGs3ppo/HQy73NLVDrMhIKij3HJxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743153856; x=1743240256; bh=thXXNVucmSv73GyfSJIdmgtbq24a7n9V0QF
	GT8cQ0pw=; b=UGMDFdno+7GQVJuBRjMUu/rNvywBtoJofUGNuaUnqHuA+Wn2cHt
	pAiq3fXqt90gZDxFdAjedch1S8g0kBWHdwN4L8zKWSXWvvIAWyiDuuFcQG/tzbK4
	Yj+IsbhQQGPTHqsiF+RpLuar73vw9Pa+SDjAAE2DJ7ngsI0R6FdxVlk0xvtt3bXE
	2/QelKVQlY7v0lKyrJRQ5tPPEA369LDtwZzzD0yApOzUagOWiVBH5s+3So8VXHoj
	1JnFBskS/D4LaMQghE/iChn7uXw089z3t4By7lXhonfG6vkcLeWxvlejpXGlaSou
	MQt2f0Bl0kJYLIrvxo1shGcCY180cbDc/wA==
X-ME-Sender: <xms:wGrmZ-8_Q3_BoqzGFmRImUpXfxiPmLO7gsq9g09iFtrc0r5_z_lxQg>
    <xme:wGrmZ-sOXRVv2gPOcscPJNxtG8Hwz5qsXwldjKL-w8wYpvkVVPvCL4f2bfRYHFkTg
    BHjgmrlljltHuRk-A>
X-ME-Received: <xmr:wGrmZ0DUCjaMH-lO3p4Ggooh6tzdQRzDwMEwPmoqnRYI05ZMpKlVZyqQWNOUMbYxrlD74iQ2-Hc7Cwp9a2FpgPNqpFXXkrk7kR4rh7jC4fT5uic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedv
    geeiteegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wGrmZ2dLMS0aAT3vs-lKtzD11_K9f-SwaEnAM7yOHMrYkFwxy0WHHA>
    <xmx:wGrmZzNp85g74dW25_AtQ-E2JIfNQRV85UkIl6WQSApeidVbQ2l35A>
    <xmx:wGrmZwk5EoYHVEmH2OplARxy65fkfCuv9MA4w4W67HQU4VpxGJHAEw>
    <xmx:wGrmZ1vw6UlaSBlrwNQE4QaTEYn3bd-IOrcZ9SyaLhhGNQbSdgZtqw>
    <xmx:wGrmZ-2P0rPf0zcJYM1DPxMfN6xd63ssNrt6DE31rbCBZNnEM5B4sk0L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 05:24:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09ca1578 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 09:24:14 +0000 (UTC)
Date: Fri, 28 Mar 2025 10:24:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH v5 0/8] refs: introduce support for batched reference
 updates
Message-ID: <Z-ZqvbK9gJtuo_mS@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>

On Thu, Mar 27, 2025 at 12:13:24PM +0100, Karthik Nayak wrote:
> Changes in v5:
> - Inline the comments around the 'ref_transaction_error'.
> - Use 'strbuf_reset()' wherever possible instead of 'strbuf_setlen(err, 0)'.
> - Use an extra 'conflicting_dirnames' strset in 'refs_verify_refnames_available()' to track
>   dirnames which were found to be conflicting, this is to avoid re-reading those dirnames.
> - Add curly braces style mismatch in if..else block.
> - Link to v4: https://lore.kernel.org/r/20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com

Thanks, the series looks good to me judging by the range diff.

Patrick
