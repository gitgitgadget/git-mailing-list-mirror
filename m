Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B221E871
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831982; cv=none; b=pSPVCSyFtiZPGZ/LuVbTrfAxCjHQj2CQ1mMYFofMjxpSnURj2pOGggDSRxH5bklTingVOqx+QF+IPBGucWJpI7aCW+t3PPUIsJKBXWZbpkOYr7cVKFueCRp5NSLQVCaZCPVx0vOtqfmYI8WC/6liUzYR+Fa9HMJ5YFGB0M6dGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831982; c=relaxed/simple;
	bh=eRY2FTc4szAl3pdCul2Cv0ZjW2uBHt3ssQlcfye8sHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qTBU6Xl2ccITquXh2nn0XzzgTQ4rwjSjs3oKc/UsaOCMIvzaOtTVM2G9EH+EDDOMRdl2+/NAzrUkISpgFmQgWcEQ3JrFWa0BiR3hnCz6TKtqhS3YeFt+BxH9TKWN6woUtMxHbG97sX1XL24V0vPHUos+RuNIMwBhb7bCu0UsPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CLIpEtyC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfHhJmsU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CLIpEtyC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfHhJmsU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E5061380333;
	Fri, 13 Jun 2025 12:26:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Jun 2025 12:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749831980; x=1749918380; bh=q/o/BOfvto
	JwEeYCb1q4H+n7AK8NRNuMVXRs6uLXQLA=; b=CLIpEtyCWW29foqlvk4z4R3XIh
	FbDUWFi1CYHvpVpRNwV+SdlBw7m17S7M9SOlfcDzRP0X1soyDhqsa5tNuCusYePQ
	b/prp9Q8WcN+NjQ0bTKg74Dq9QA5eBUD3yffXAkc7oaUlfyx2dTNaLbwYNikWygM
	MyUjOBhrKENH+K1eYtiRBnUuCrjtkgaWlu113xgYbnKHQp1zfPro+QBwKDIHpVGo
	fXB1FGDPHjowiEsqfqtjYXvWTEqDy20iaFlkxHOapkIxC7SxR+5Bf9cmVkq5kIaf
	8sfjArCLlL6ns1gahAmQf1buMQlE97RwLX84TdoQKpgrcz7BxXy6ZmZWNLbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749831980; x=1749918380; bh=q/o/BOfvtoJwEeYCb1q4H+n7AK8NRNuMVXR
	s6uLXQLA=; b=hfHhJmsULRKWnqCgqZDwH4vd1x4sfyYrYLyEjtE5NcCF+WFOGz+
	hhC1JR7/uSBzMTRlxtzZHDKSolE65XxXIIIUCaWTr3UrFWKj6Sly6uaBcIZ7cKU2
	eZaM7UkKI+3CIKdkS7DejDm69Fe105IApY6KOXnfDi1yBVsDzavgG5FNW5DcNoKY
	m0TXpPl8AxbMeYMWX/XXl2Pj4jWRaTy9G3iwJCL6PA6OLslEcLWHBkNP5Ev59QKh
	9HKDYyOXsneT1smM36VN1DffSydsfhmeVQG6G2U4MxNDjXH07WE03b8CyBzbJrAT
	yzzjI9oY8cDRDQbk6+MAkiPApxGcfTupo5w==
X-ME-Sender: <xms:LFFMaJ-InV5xGDLeCL_I8xm1xDUYEc3lmioMk0B7xsI7SOMCT9IrYw>
    <xme:LFFMaNshXO5rgz4M2fVHkVBwK0gmhundxA7Ha_257SB30I6627p_yfTZZIVRhwTIH
    LxBH9JEfTiyE4ouIw>
X-ME-Received: <xmr:LFFMaHCE6VpvqtuBsoIFwShzhSzrpjzstHNE0OH5SBjkdhzpjXAmYiX9lfU_DQmv9fDwdJproUblJfIht-oQQVBg_n8wtrAqePiN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:LFFMaNdvjf4hMnfQIjKoS8Eyzmp970fLK1uQ2t0xm1gRMsub95kIXw>
    <xmx:LFFMaOOMKz3cKisL7lDUJG9Z--dBMi_Sb-XM2gPQI2dDhabSGo9o3A>
    <xmx:LFFMaPmKSWiYyP_Vq9GKlFknt1_qIRrygLKQTwOPV6dGm9K9F9VT2g>
    <xmx:LFFMaItzVfjD6hrGQNoDw4AsfG6ZeG4QpCMyh-k8eFeDVXlM1tO_Qw>
    <xmx:LFFMaFMblnkQGZ5xMVD5IqX54HyB1_85d995LbFkaS4e3vcj6z1o4YpR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 12:26:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] merge/pull: --compact-summary
In-Reply-To: <857ea4d4-2252-4d46-9f93-e78e9450bb8c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 13 Jun 2025 14:07:10 +0200")
References: <20250612222537.2426059-1-gitster@pobox.com>
	<20250612222537.2426059-2-gitster@pobox.com>
	<857ea4d4-2252-4d46-9f93-e78e9450bb8c@app.fastmail.com>
Date: Fri, 13 Jun 2025 09:26:18 -0700
Message-ID: <xmqq5xgza9qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Jun 13, 2025, at 00:25, Junio C Hamano wrote:
>>  static struct option builtin_merge_options[] = {
>>  	OPT_SET_INT('n', NULL, &show_diffstat,
>>  		N_("do not show a diffstat at the end of the merge"), 0),
>>  	OPT_BOOL(0, "stat", &show_diffstat,
>>  		N_("show a diffstat at the end of the merge")),
>>  	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
>> +	OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, N_("compact-summary"),
>> +		       N_("show a compactstat at the end of the merge"),
>> +		       PARSE_OPT_NOARG,
>> +		       option_parse_compact_summary),
>
> `compactstat` is very dense.  s/compactstat/compact stat/ ?

Nice spotting.  I think "compact summary" (to match the diff option
"--compact-summary") may be even better.

