Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508E1804A
	for <git@vger.kernel.org>; Wed, 21 May 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843605; cv=none; b=hhJHSyWvtpxg7/O419XF6pg4taBgHhVQsnVxBrPBZK3CE4LnXfXJSLwMSR/SOmMcMAGODogEm2AY0WzhHRUDHNKa+HV0MKaaLvaa/OYJeLVSlQXc+yJrJ+VYgUO6fPR0mcw7Q4v8QjNoHHF9GWr7B/8UOMs8oVjqPaW3CVppChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843605; c=relaxed/simple;
	bh=irar8tOFlRvpHF6RTi0FzSqUQ8nbYviDK+E8MLZJ08g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCvPB0qw/IBw+MZAHOBhs2rEIFAc4TeSdoNdzcY9zTq7RJvch7pNMzMpjBjNei8TjOY6R41kfSEKwKqI+l3E9wHJHa2dg/IpJhbsc1TSaqnjNPDddi+ovL6gy8tIrdkcCrWzR02yVOyWRWLn+Oq/76WuTL3y9OK6Sy2+StWde4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PLp/2FZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MqEpx9V+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PLp/2FZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MqEpx9V+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BCF8114015F;
	Wed, 21 May 2025 12:06:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 12:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747843602; x=1747930002; bh=5w5YT8GFsT
	z/WraImOH7+JwTnbW7LZ4ODrQyZx5O7rc=; b=PLp/2FZaClbXlmj/9mkm9jx1rA
	u0aTPXB/voeE8UYOz0oCAYuvmDJEMIyHfzZlC/d2PHl9l38jM6tJS3k5NB1xWLLz
	yJfH21XCzBGYVknXRsmTAZPSKXcUzTlUFXhYwzaqZ8wSV2PO8clabaXHchiCKIgX
	bSVFveL8HZYZcX5IBzeRwFRstnVn0R2IRH7tnKgYrNWco9JZwVQvPxbfd8jdg+Nf
	xue/8fuuh9QobLAGXEQ1AJ2diafOLZyri1x0UVJEncKrSTwcRHAVESIw7iNylkvF
	sqBgq7NdBPeIIebMSbaDj0mWe6ftHKCEmCm5B1UCfW1p9UDKasDnnfeOQEcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747843602; x=1747930002; bh=5w5YT8GFsTz/WraImOH7+JwTnbW7LZ4ODrQ
	yZx5O7rc=; b=MqEpx9V+U6pFTiEU1ipHQtAARYiDPlfLzck6GJMb7/qn7NuGtAN
	r7/PxhztoP5gKlw/GU63Tvgje8mdiJYOW7r2QDcs/X0W864fPnIVZUW+RMJME9sK
	oJTDcyJuhPKFoMP80P3Tujb9hkGtMR+Qj2Wt0DewszQ/Xe/N3mZI09R1GyYtPZwC
	xf0XaDT2B++m5/ZCDd/dzMbj8j/+fNJts0H4Ge7kOUyd9ZGhQiizVTZMQ24HcOsP
	qFfI2CqEHk1i2tzMXNBGuqw6V6yJm8RE2W7Q6uB4stp+9eMxn5NwGKcp7NpIoTkR
	UxhTR7pD5oem+l6Owa2lAEO8MxbAlDh1rjw==
X-ME-Sender: <xms:EfotaCQY1Kr9edTL0qy9hyxYVRNK2NagefCLNFNGshRyvCEmQPkPwg>
    <xme:EfotaHy7JAt-TtmVytdqLiCJVCA0O5hWb9XCfTt7CbiRpCa5POlbcV6M6r07SJsWE
    H_6-cqDPdEXIyyPMw>
X-ME-Received: <xmr:EfotaP2TxRTJwJY2tOX_TgQcMwHWuW_a9D_RlRxSH37ybw7cyjznvBm5NEdL20aJs0CTIviP2duAI0_TrH60FzpYN_48jZ-bLIRUFjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefhedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeev
    feehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EfotaOC8NHOmYd69IELRh85WD4qJTNTtZX-RCcv93ild7kvPkZW7ig>
    <xmx:EfotaLhv6QlnTQyyIqBNfaEc_OWN_2xjvr9ZOypFnSnvKrBs-7c2ng>
    <xmx:EfotaKp9SgFtLNA42I14rKQctCl8Qt1iU5ShVIXp9VQb1k94O8uZnw>
    <xmx:EfotaOjO8zB98RpaGxXBaUTyKTeRUY4IVDg-xl4t-EsxVB_Q0qQxVA>
    <xmx:EvotaHQZueoXa9iEwW-tF7fEJ2jt6nh-KfI-1wCXmsnCbq8znSzjw_yO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 12:06:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
In-Reply-To: <aC2xp4Cdb0j6OX-G@pks.im> (Patrick Steinhardt's message of "Wed,
	21 May 2025 12:57:43 +0200")
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
	<aC2xp4Cdb0j6OX-G@pks.im>
Date: Wed, 21 May 2025 09:06:40 -0700
Message-ID: <xmqqcyc2aqy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> This new feature is only enabled with Meson 1.8 and newer, which
>> contains a bugfix that we have upstreamed [1] to make the TAP parser
>> work in `meson test --interactive` mode.
>> 
>> Despite the changes to Meson itself, this patch series also contains a
>> couple of fixes for our test suite that caused us to not generate proper
>> TAP output.
>> 
>> Thanks!
>> 
>> Patrick
>> 
>> [1]: https://github.com/mesonbuild/meson/pull/13980
>
> Junio, I noticed that this series isn't yet part of the "What's cooking"
> report. Is that intentional or an oversight?

Neither.  I saw a lively discussion on the patches and was expecting
to see a finalized updated version, which I would apply.

The "Please hold off" message in the middle did not help X-<.
