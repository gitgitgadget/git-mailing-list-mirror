Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465438BF7A
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407148; cv=none; b=Uw0sdkX4WhzXTCdp74RuaSwLsPVPcRaiorluhnwy9rld/2jm1EkPN1YQInLdrTsESzjXHjqQJnKbknIEtUrcNtJcgLXZBbU8IvfI/LupeyBkqALGFHXFSGqIN9elsxOud4TqZn3D8uhZPF5scjDfhQFOprzxLfKvA/WCfjnL2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407148; c=relaxed/simple;
	bh=dmsPlNThNl1Nk9ehm/iL9gAseUOyxDHHVuRhSVn6JhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jHsPAjuJ4eFSULhUKmMHMdwkEOSmlculi30qLev0pBlTKhFe3dXjgV77rYHhCx30JaFnZhZ4/sBh0EHuPbcuoKq/rZJbCJaLJedkKuEQodsNG/nvRwSaSPzCqvbs0haj19TfQtRgb8j6Zn4C+Xku9iqUtsTUdSPpZIi3x9p/19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YfhS7BUV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/ns8AmW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YfhS7BUV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/ns8AmW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 06FB71D0006D;
	Tue,  2 Jun 2026 09:32:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 09:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780407145; x=1780493545; bh=J/Y1gr7QwV
	ZLNV/Qw1DPUWYHXrlW8mEr0ss8jGJLHQI=; b=YfhS7BUVfDQC1kSPSEAPfVhnLR
	n45Ypc5nXrw5k74K3+siJnFlyUf/VDKPk3ukjYgW+oKW4lmDF5gOs3HzerVSWcY3
	bXjLPalXKwyIi6ojdN3jUQCd1cfxiVRPOrxDfNKlxY3n83YblCxgL8iyRIoQevvG
	GIICE/kvBJ35TM2vVPqK5Aa1L29v7JhJrMOxkhRhFVZ6ofM7rxNQ9wwi44bGSBPC
	WrYC6o3bhwvub9hSY9KQzzta3u3AWdbrNE1D6M1+w3mhVYr8tHKmpLgw4h7K24QQ
	VqNag/H29YxwHNitPsyMTWLnOucytSWA4agY6jU7ooyhS94d1S7IpRp7ufuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780407145; x=1780493545; bh=J/Y1gr7QwVZLNV/Qw1DPUWYHXrlW8mEr0ss
	8jGJLHQI=; b=G/ns8AmWO6onk+n3V/IN3r9XwNWLoIoDc7xPX+s2rCWhfVWbZ4h
	4Eq9AMeRZMWjtjXUw7Oa6HZAkhiOEmDpcyyGB82LWedwaZOozTtV16Cw9MW6CMsE
	fDOVRzHqfGcERJwxaCtTQo9j0cddkpE5PM8IlsEOIbSxpP0bU0tMM7JuA/A9cm/c
	Ka5D3T/Acgd6KaK5HIOEWLWk1g7cuNPHW3pA5KDdeVPY3UzhHBLmyhc8LIA6QM7d
	omHETiniHzTJVh7WP+krM8MjqmvNidCLsS62oFim+S/j78ZSALvX/JFvG2dKsoPV
	Ev/dxU+9PYjPhPzmt59j8nsMlAMMAV2Fl3Q==
X-ME-Sender: <xms:adseahNjyoYx2ZwrIoalpl1eUf-uGfRd2AGEXvwszcEgQTfzG8B2gw>
    <xme:adsearY4hbrp7BgCleaVkd9DmgM2zvd1xWzEJ1y3b8408q9FsNN_BWHunm-G2oko5
    O4OqTrtp-Dtet5OvJjBJAoAlp05TUqAVHYcq_wS_w5cltVwfyh0BQ>
X-ME-Received: <xmr:adseatqx8muHdAs8muCef4A5h0PVFYRzZYATm47X8iWdLTtTbINHa7JInOg07yG3Ep2Db6HeA_RfWsqclrk9MpvBHcMZMMFaCWjd>
X-ME-Proxy-Cause: dmFkZTGoNujZRUPokXB9Fvq1ytUC501Ws7f2np6BTI62h4D2kuN9r8D0zIYEVnQEkBBKLq
    xDC2PHfoOqV96wIa7EYGb3nH1XnxKaLnouyp8qWlGWK+oUNw8mIx/NyfULj5zht5KKcQlP
    qhoqtlc/9/8mRaUVUcRKOJST3Mhv79dsSDDpTlH+ke68s2azhwhWJeoSSvPFFSCI73kP8n
    LPx7gfSUKE6lAv/r3TjQxFIvZReDptoU3fgBpbrgxKU/a62zDiPkubCYhcSRW6nf3V7vDZ
    eCVWW6B1287UisVnVQV5Viu1omDhWxxQwlfbSIohO/lGdxrG53dMVetWdU1uOekghInxO0
    lUio2OxrFpPk1h/BXSJXJN8Gl5iKqyHRIBcfB1MJaroPXQzfgQlqB5rEGNNEaa8qEIDWCf
    rhOtV+6BuyjXmMjnr6IheDO3p0lNC97zNIRGuC+LLYtthjcrt2RxPDi1mosZDh1FYEtcG9
    YtId8Z1BaIz48HUAqv1p5T8GlkvS+7LQAQGKlBptBV9A0106gyFRlAu2dbynGSlj3bUUB+
    821ToeiZOQf0/1Fjdnl4YLH6eqlzcTPJsubW18JVA+FFb64UYxZGXMMwEiH2BBzL/zT0Cp
    ThOJ4t6rnPttnCDHf2+dhqzVNGmuZcnuSX6nBEbV2MHWqhEOM4iMjoRnU5vw
X-ME-Proxy: <xmx:adseanYZ4uttH8bxz3gzbaIGpGSv2wM-EomrkKbko9C1T1mO5OsrNw>
    <xmx:adseatRWTslHtWPYGpuP6pR67_d4ttELM7gysG95z31QC9Z02uQenw>
    <xmx:adseam7xXgYJ6m1UE9LHgYt14-rq61BPEB0n8oNRFH9jp-I7v0D8Qg>
    <xmx:adseaqypkGZIVQsgB3ZTJjnzRhed0q3NGZ2SL6ZP7QmgaFP-TAr7ew>
    <xmx:adsearg5SSbeCyazb0refGETDCtIa3GlsIgoL4jV8Zr-6UWyatpLeVQS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 09:32:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
In-Reply-To: <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im> (Patrick Steinhardt's
	message of "Tue, 02 Jun 2026 13:59:09 +0200")
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
	<20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
Date: Tue, 02 Jun 2026 22:32:23 +0900
Message-ID: <xmqqldcxvziw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We're about to extend our documentation to recommend b4 for sending
> patch series ot the mailing list. Prepare for this by introducing a b4
> configuration so that the tool knows to honor our preferences. For now,
> this configuration does two things:
>
>   - It configures "send-same-thread = shallow", which tells b4 to always
>     send subsequent versions of the same patch series as a reply to the
>     cover letter of the first version.
>
>   - It configures "prep-cover-template", which tells b4 to use a custom
>     template for the cover letter. The most important change compared to
>     the default template is that our custom template also includes a
>     range-diff.
>
> There's potentially more things that we may want to configure going
> forward, like for example auto-configuration of folks to Cc on certain
> patches. But these two tweaks feel like a good place to start.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .b4-config         |  3 +++
>  .b4-cover-template | 11 +++++++++++
>  2 files changed, 14 insertions(+)

Shipping a sample like ".b4-config.sample" that users who opt-in can
copy-and-edit into the final name ".b4-config" is OK, but I'd rather
not to ship the configuration files that the users would want to edit
(hence making the tree dirty).
