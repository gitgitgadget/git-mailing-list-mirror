Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397031993BD
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436509; cv=none; b=Gj9hV6RqQwWy0K5MdUQx3jyxe99u7nXQpN9hJRJsGk5XruCMh/lfinFCFmVhSTF2HcggOhisf+2Z6WvRk0jvL1UhQjcGrY2N8Rd5W8XmW87LE+g8aN4WSfTaM7W0kyXZsLdSdOLcPofC2fzeMIuhtHMrNjm6uefitxbJP+8iGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436509; c=relaxed/simple;
	bh=1v3s4sAfi96w8f8p+jRR+XNeDD+6Vdepw6UDPlZXtQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJ9Vy3uhL+/Z2TpvsMc8URiDu2FlNm1V9UvcviuPjqg+NrVQ5coM1Q6f1b2OYaPw2U0AXhNe8YYSRDH8rAG3Q2oeNiRLNbLuaMBs+BqqFfH5UYommeJwqVm9bg7BeW/M0LCvm8JK1LnkZ96TfP7juwAFab2ExTRRrc8ExJ0lfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MEfNlrwP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iLxE7h6Z; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MEfNlrwP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iLxE7h6Z"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F50111401A8;
	Fri, 20 Jun 2025 12:21:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 20 Jun 2025 12:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750436506; x=1750522906; bh=1v3s4sAfi9
	6w8f8p+jRR+XNeDD+6Vdepw6UDPlZXtQ0=; b=MEfNlrwPK6GmCv5yudUinvVpi0
	ktD8WCpvqm+lTs5yJcaJ8IADwBrkhe6dEtueaAozqGQnVXDbhRVQTgrGkcYGNqDM
	fVJgId7J6ZCJ++arJNWDq0wLB+R+zz6/OXGbWLKiA/iv1KYenYoJVdpX1pXbN5A0
	UGQ8c+TsLwsbIy71HAg1Q4+CaRv4YS8Z9k4qRzXv7KycNAi1JnBfTPaeYrUlXEYA
	uHOEdo+Rm2V1PRmhUePn5ePwYHDBVl3MoEEDOEVyFPmSAjXEB7+AX1CpQo8GHC79
	q9fQJ036U7/8LVsDFEZjkFamnSPYj32kk7+jD0lTbVIf9EywBFADEMrTOAow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750436506; x=1750522906; bh=1v3s4sAfi96w8f8p+jRR+XNeDD+6Vdepw6U
	DPlZXtQ0=; b=iLxE7h6Z7L+apBSvL38tDGSm9KiRDt8W6bfxt0oz1YKnomum9kE
	lskuNdn+Jtce5tUYN1na6iyhCCHwSpugv3qY/E0pNOv3AsMYC2C1ub+GFa33rRMK
	QzsbjHnQFdIiccc2bf6DIHGka5doOLDsUS/VZQ74/rCt5o3gelGCSt5W8Zoyn5Gm
	v0hT3OSJ1LEz3aDnZDWANckOYP/iK4upM65duxZVYksIQvLjagQedVouK50j3JAw
	ZIrz2gbBt2/oxDJt76DwfcAKhfaURRAgj788OkEeR4WnCV80SQ12gVGaqwxHaS/P
	00wy69F+NEbEKvZuHuiWHe8ydEaUIP8GpMg==
X-ME-Sender: <xms:mYpVaDDKounspZ4vp6Oe1DpwFrcYRuPKKisrglg2IA4b1Zt3Ko4Ozw>
    <xme:mYpVaJhSLQimuz4t7wrQ0iaX9kQmfdiLHsUuhhj5X-sKHBA0-T3OfjD72A9iz-XGs
    OQJLoG8-2vkHveP9Q>
X-ME-Received: <xmr:mYpVaOkSAR-K1N7Spzzs0zQjqNoIjiY1kzm9g8tIh4Adp8O8M_SnjUNtM-xf3kxpPdOKHFPd56VcJcq5aepHpttE0can9LI7G4od>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mYpVaFzPIew1uKBiqLw4nntHPpJpjvareo_Bp4PkbLMjHC3MzFU_Jg>
    <xmx:mYpVaIS2xRcWq_k6Lb8ebptFjdvPDrTPqOo9SdDbXFPGffEI_vHyRw>
    <xmx:mYpVaIbqv_sltA3ypJDDdFSjElbOt0ky71iJ2Xx2VqTgGI0-zU7vqQ>
    <xmx:mYpVaJTQkHe_aH04fpGMwBkCcRBSEgX7L5V1wFlQHGHlwMxX7-e4hg>
    <xmx:mopVaH_yOUEVJmqg2miqHG3Mxbn2-BLiSxzEOB-zejM3gU0xFG5s4XWD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 12:21:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/2] refs: fix some bugs with batched-updates
In-Reply-To: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
	(Karthik Nayak's message of "Fri, 20 Jun 2025 09:15:43 +0200")
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
	<20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
Date: Fri, 20 Jun 2025 09:21:43 -0700
Message-ID: <xmqqcyay4c4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> In 23fc8e4f61 (refs: implement batch reference update support,
> 2025-04-08) we introduced a mechanism to batch reference updates.

Just to let you know, as these two are fixups to the topic that are
no longer in 'next' as we rewound the tip of 'next' after release,
if you want, you can redo the base topic instead of piling small
fixes on top.

Will replace.

Thanks.
