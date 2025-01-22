Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC32214A73
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568708; cv=none; b=TcdFqt86IaSAfh9N5JmdrNlb3uz54rbjF+QPXacTg6L0YZWnTIXS9kjo84p3e6nJgGm+sgVApLmMRls1rPL80mpZMTumi1j7O3dPQiDlVbf05kQtHCzg8YjQc7HynDUc8XN0m9fxhf7q8X4U2fsXcQC1MbPj1VV9LDWCe/tFrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568708; c=relaxed/simple;
	bh=XSZOsc+XTpNKHquhJ+Zbs888qGbwxcrO4R9a6g1hAFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SSKYjSxWMRE4GsaW+NSHHUEsk2Xuo+N8XCu9C7evxpP0XqvL+4SXdSrG56zoqrys24DH4SfftagYpinsp5ADT4BBgNb7i3c/GUpB/v689xLDPy9CzH/i5FdE8cynZdo5sqZCzRAc03Te+En99rL8l/emSheAFosiaw6iLn88Ivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gxs8y5yn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4HBbOu1; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gxs8y5yn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4HBbOu1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 97B2F1140076;
	Wed, 22 Jan 2025 12:58:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jan 2025 12:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737568705; x=1737655105; bh=veROqNMUA5
	IMN/NlzbStr0FYPXn21k1+lUZig6G2A/k=; b=Gxs8y5ynocvnjbXFhrOIiDCRVG
	Folu/OcXMcH3Ex9wim7S1sTlXEkgAdNJlma1GiycNa4Ke1wdfKhsGbPgnlRt0cOH
	w7PKuQVxMPNe7RIlrlawLMeyUUXzXrRsZk+hIRyBd4CLIXJff+btwmmLzycsh7Hz
	Fnq8bsASxacn6mBbj9W1JX/b4tIvDbwHK6R8J51lMq68Mw6TzbZqUDz75XHY3z9y
	rJwseUpihWugaGiK/oLZxmDcajCqhTxPbsNxV79rFcHXaJ/l2SpwTNNmPNOCsA7w
	xsmCgTM896+1VfKo+tFsXEaO0w008knOK/Qfsgl4RQV8lEhoVCuRKTXZiTRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737568705; x=1737655105; bh=veROqNMUA5IMN/NlzbStr0FYPXn21k1+lUZ
	ig6G2A/k=; b=F4HBbOu1LtUr580CZoNyAgBx41I1mB0howD1XdlcDaBHR+VMo0E
	WZADRSEw+t/FAgi/uMJE5IruHLStH+zWExd2aRBumWf1ziAVGeLIXnqSYGe+NAY7
	QBZGAqyq62fqPQ1a4rj2R6o0HCdqZJlXS9GkmA2RRtjwYt0uH25df+aQuorib3un
	gz/oMhNBQ/ph+2tHF/tGnYwH1Ntixe+vGR6Md4Dvc8sG5pah3xbV0zVkBFVqO5ra
	ZEoQatcRxE8cgCWQWAzLrKl0597QfaDxhV2JYGnpMqkyQ5xk/hyAzpFZrpkU5kDE
	YjQHSiESQSr2eeE8vAFoZGWbVLbDfxP+jdQ==
X-ME-Sender: <xms:wTGRZ78mjRDtYzBEELwnT8MJNyLdFRrnXRZ7tIJRE0z29aV0EiUOOA>
    <xme:wTGRZ3s1835-UT3mm0CH5_Dk5aP7RFODCA8HWII9xuJJnFFj817ifJTv-vwyiodef
    0pfkR_KPcbTrkCQIg>
X-ME-Received: <xmr:wTGRZ5CfXn6beSw0BmMhFTTZqyxM-413Jqk6b-4_McWF7plvEkUYt8H-SG1ak3leFpuAkB4opxRNCHGXZB_RG4-buDYXw2HLbCiT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgsvghrth
    drtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehrrghnuggrlhhlrdgsvg
    gtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:wTGRZ3e8SA-WuVgbGRZWTv6dnWIpKsk1NuVuoz9R4QQSZN--4DNYPA>
    <xmx:wTGRZwPtQgfme4PgvJv0fnAUHkOOanIKRtbxdmvWzfZcW3DR6snrsg>
    <xmx:wTGRZ5k4GtLIpVg1dHvDwqrYMGpabaHrHXYFVpgqmBvTnfLrbkGqug>
    <xmx:wTGRZ6sgrVGlbrduyZtAKhabPRFbksGBea46K83r6qY5dCkxd0DtfQ>
    <xmx:wTGRZ3cUUXDw8muSChbIzzWDqwJ7yFXQaSbXeE4CdKCa5AxBLiEEg6r->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 12:58:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Robert
 Coup <robert.coup@koordinates.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v3 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <Z5DRESPpegE41xaT@pks.im> (Patrick Steinhardt's message of "Wed,
	22 Jan 2025 12:05:53 +0100")
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
	<20250120-pks-remote-branches-deprecation-v3-5-c7e539b6a84f@pks.im>
	<xmqqtt9ryi3f.fsf@gitster.g> <Z5DRESPpegE41xaT@pks.im>
Date: Wed, 22 Jan 2025 09:58:23 -0800
Message-ID: <xmqqo6zywx1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 21, 2025 at 01:25:56PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/builtin/remote.c b/builtin/remote.c
>> > index 1ad3e70a6b..e565b2b3fe 100644
>> > --- a/builtin/remote.c
>> > +++ b/builtin/remote.c
>> > @@ -640,10 +640,12 @@ static int migrate_file(struct remote *remote)
>> >  	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
>> >  	for (i = 0; i < remote->fetch.nr; i++)
>> >  		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
>> > +#ifndef WITH_BREAKING_CHANGES
>> >  	if (remote->origin == REMOTE_REMOTES)
>> >  		unlink_or_warn(git_path("remotes/%s", remote->name));
>> >  	else if (remote->origin == REMOTE_BRANCHES)
>> >  		unlink_or_warn(git_path("branches/%s", remote->name));
>> > +#endif /* WITH_BREAKING_CHANGES */
>> >  	strbuf_release(&buf);
>> 
>> Interesting.  I wonder if our new warning should talk about whatever
>> end-user facing interface that triggers this code path.  It would
>> help them wean themselves away from the old interface, no?
>
> Not quite sure that I understand what you're saying. Is it that we
> should tell whether we were reading from "branches/" or "remotes/"? If
> so we already do that.

No, what I meant was to say "You are using outdated remotes/
hierarchy to describe this remote.  You can run 'remote mv %s %s'
to migrate its definition to the more modern config-based system".

The message already says the first sentence, but not the latter.

