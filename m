Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BA26A0E0
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354493; cv=none; b=c08drFT+9r0aXjJUqAsthJtZOFkSWnodCfdgs7wwZRgiUAcAJwpYMEc3jwspqlpwlh1FVc2PrCK+CckT8MOVJYmokkCBWXMEo6vIqqj+Pt4umy5uCT0jNSZU1V+X27DHN8VolqL72g0gfffI4qNlxeHVSySYtWCbPlZiMqFgmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354493; c=relaxed/simple;
	bh=ZcR2j1oIx1UwtUFkh+Hzfd5+FdQEzx9mNgf8niJ1kYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TEC+VeSBct4TCAqa8Hxhz0iLv0xKZhmhY6mhQuHJIAuU11fnfMSZHuhRA8G/ZLNjX9/PyGzos9gkt10+YU0iWHWBdTfQ76G3p7PfFdRQOpobm8ldl5GOBwMm+H0xDtotU/K2lupryqvEmZd1aDkeHOYwk3xYomul53GdiKwOu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yoDFHfX+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nNiyow0I; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yoDFHfX+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNiyow0I"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F3632540088;
	Tue, 27 May 2025 10:01:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 10:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748354490; x=1748440890; bh=caGHAe/ruG
	4JoBmPzo8JOucmuIlq+tp3XVy543Xz1pc=; b=yoDFHfX+wntTII3ofdVhVUzPzv
	digH8X5EfWPsfC0hmzlxxDQiFWZNuLbA/3z81KuR6sy5rQrhMF6XKo0wANt4Bf4K
	CPTnHLrGbvCrLRRSoEHlnw/DaGKRL8OgBvwN+6rfhdbySi/MrxuQd6OVvd7ZGzdK
	sOBLsQVENkuEfgWW2yum7H7ao9hJMrr3Ksa9kacKUZSoFFBX/vGSGz112qKXZndw
	8nHWkajCDhD2tL/oi0Oh2aBVYMWEqaxWLID742vZVNKK5AObjPgtMYoQ0+GgYuNb
	Ca9a7siWb/VrssA4VqQm0wbp4q/PsJ1qmG+j6JebiySTLYZsk+6r28dYe8Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748354490; x=1748440890; bh=caGHAe/ruG4JoBmPzo8JOucmuIlq+tp3XVy
	543Xz1pc=; b=nNiyow0ITjw155uYmnZ0yQgFXiLGlQ56gphKhAF8l5mBY0OVou6
	ZbiEGDoTv3Kschqk2DxMjpX5fQUBl8e6c0BRUId4EKLh5jZM8GqdtWQaiFcSSez2
	ZDt9taTmJ5SySxoN99fm6aLCrDrrfVY4r0moJfPUvonCzRUAh6Efb6JDT6ypFZbc
	Tr9IG0Rc65QIkAVaI5PXxZsuwRQ5OgV8Zi/CDck+3gMmrYXq3s+Dgdp0DRNZ7YZc
	jQvFrrNzKFcLvsjo7alNBjzg+ZTzKcEIdkNqJuF6Dt/GyQaKnT5XMYDh6lAX2VkT
	4sFud4iJUVHAmkTWirwqcrYpAH3HGaXiQYw==
X-ME-Sender: <xms:usU1aKESjf9E16uUroczKX_s8j9zkMBSSjHDfbb8MjRbI3SvFKpm5A>
    <xme:usU1aLWwL6A6vm2DSZ5XvXrR-6IlvxckVtwz9FweP3Oa8q3bpfvEMoFYHITJPKo5h
    QE4oCNOQa_GwlL_7A>
X-ME-Received: <xmr:usU1aEIzTeFEMaU_Dao41W90PJ92bYu0g9bbs9BenlzVo168qxooDCbdYvf60zRDCOVjZ1OEtg_UuwqewUvMs6YpdtlsOYW6wr9AE5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:usU1aEGLpwssG9PBt3eZu4meBta02J7rme4_YzBIluuQ4JNQ-mua5g>
    <xmx:usU1aAV1ondgycmdxC7ls_jwwEGty4loHvMQ90WXyJPcjIeqt7vAng>
    <xmx:usU1aHPt0JxgThKArGF7ipVDK8mquxDzPuOBB1obhF7UVYH5DDrzNw>
    <xmx:usU1aH3964xRNPFz6q-U_eqyvfDmJpNevsiIIscx3222huD9YlcYKg>
    <xmx:usU1aIB67qoPne0NUEzBrFSRlNEUA6wlBIUTYKTJ7Zkls5NDdskCJBYb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:01:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v7 1/2] submodule: prevent overwriting .gitmodules entry
 on path reuse
In-Reply-To: <20250524073628.58944-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 24 May 2025 13:06:27 +0530")
References: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
	<20250524073628.58944-2-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 27 May 2025 07:01:29 -0700
Message-ID: <xmqqplfurw3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> @@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **argv, const char *prefix,
>  	if(!add_data.sm_name)
>  		add_data.sm_name = add_data.sm_path;
>  
> +	existing = submodule_from_name(the_repository,
> +					null_oid(the_hash_algo),
> +					add_data.sm_name);
> +
> +	if (existing && strcmp(existing->path, add_data.sm_path)) {

Looks quite straight-forward to me.  Great.

> +		if (!force) {
> +			die(_("submodule name '%s' already used for path '%s'"),
> +			add_data.sm_name, existing->path);
> +		}
> +
> +		/* --force: build <name><n> until unique */
> +		for (i = 1; ; i++) {
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
> +			if (!submodule_from_name(the_repository,
> +						null_oid(the_hash_algo),
> +						buf.buf)) {
> +				break;
> +			}
> +		}
> +
> +		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
> +	}
