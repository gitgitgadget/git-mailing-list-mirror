Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF783385A5
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447085; cv=none; b=g/yjEeGU6t5m3wLb5nZzrTbSdXhElUwYKnQFKHGjCtMi0q4OUfbUq70+ipP/naj/kt0/U+gov1RZNnAa47Ap5e/nBdQKDWvHDFRtEkr0Nwhlss7ioziNVtlYWIGTHfqCgDb8OvpP1WdDET9MWG9DzY2jPXaZRLP3pkGHjBKysiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447085; c=relaxed/simple;
	bh=86cgJ0XFSw4JB+R3iif5nEF3eNyqrxQfJZ/fWZ1VYTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLLvwZRp9rRUYKxxS5XuX9QvQuMB3GqXcUEanJlcXL2C6ZnMScimjrRm+NUG2io9ze8qlL06xkE/kaXJcPo339dZSuFbuspwTs0Ibe5qrDQeiBXpsIWWDMSdMPR8hiipnwl7fuZ4vdk63xjwf7SZsNFkbLoQ/p2dRsNHVZLGzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XXXnCrlv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwhqWw82; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XXXnCrlv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwhqWw82"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 77D6D1D000CA;
	Tue,  7 Jul 2026 13:58:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jul 2026 13:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783447083; x=1783533483; bh=sT4WgY82Le
	0AZ4GKLR9b0ElbYk8oDAexLqjac6/2sVk=; b=XXXnCrlv33Z/v/zaAmzdqwJ9NF
	pvph63mCpbZOOnLCTOyu40cKwFtrUzKhNE7WPl5uFId6UKNghVUqGuYLbWzGDZox
	o3fDsHvsAhOwUNeo5ZuufYolpz94QoqczSeYnJUiphH1G7GQiJZsKqL4t3Zj1MwN
	HLvvhh+iXGNqiLJOHNSpHxfGgpicgpWiM7ub94+tFC80TNBYg43kn+DESCyIx8dK
	fuzItClvAF5cT9HjZjMW3BMJJRmjBvnL3DRsA+DjcAlQZulZYBk86AtJ9jlpLtgW
	XKrku9iDCqBkUDDDZ8iOwYz6/IzFnplt9QsjSW7ePa6PWSy8zvN+N7qdG4Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783447083; x=1783533483; bh=sT4WgY82Le0AZ4GKLR9b0ElbYk8oDAexLqj
	ac6/2sVk=; b=ZwhqWw82LjWwsdHypBD77o7/+tOsORhKHheZkM0RqcYhvGh1Yrt
	cS1mW6jI1NGdtzV697EC17nEi7eglneBz/4bFYh6CAVGqwWhxWKmDxJ1DzEdZuPg
	oZDA6Mp5wzZVx3fRS7eCs7p8GGa82DgPWThSovTSI5/F0hdX+Ek3fBF6GNBRp6Jd
	s/jusmrj/TORah34or9wCXCZhY+Ii57hxYggrcL2T2dnVr0ai8OdNrj5ZO7a/yuI
	313PPiTaopFGTxRF5DL0E0p6kL7my9k1A8T2r/SXJspE8UVI3o85QWQcBIHFFilW
	un2hAgTwlEZcSg/ngci58ZcDgk/a3mLzLwg==
X-ME-Sender: <xms:Kz5Nalk9jX3P6zYd73lIo3bVqHxbjxWgqyzQXK2rnwAhdf1hEoi8Pw>
    <xme:Kz5Nan3Ve3mwxCDxet9auDQst9fMnIGwiak2W9Pj_Uvzn4puv5nnFctflJeukHh4G
    9Pf8_xB1baRYJYCUJtZp-4140qKg7QIH3Dm_KjMvYUXQJqzN_fS>
X-ME-Received: <xmr:Kz5NagpCrp5G0HzkblKLgpnZBj-XfCQ_eVYU-Rex6sCUQl45QSh9kFmVGASWjJvlRUNaTezRz-HKOVQtkVfwLWNjTzJqQSqkkap8aT8>
X-ME-Proxy-Cause: dmFkZTFfyBdTvY/r5TyJ9sLMkJxXwje1P9G6oXA2ztZ+QHyZ72Et7+osuVDwDvony/lXyP
    2w1s8KUvuNTWe267KcG9AuvwzK1Cwt+8bBQJxDfFHem+Y0qLBH1H9oG3wRRhiYETj08by4
    yrnaHCTdV9qXcqhZWzfXBFOrGX2sYxPii2lZB7XRNrpnqMrx+MJfoqehzu7xBhgKbsHrrZ
    t4ZOWQnM0PHyqsnDJj4S6dTWLcB5b8/gW2IyLHRpvIcr3isSok0xC1NSyOj1RfpeS98dG4
    PwDsqRuLOvpNiXUEzO1eMvuf4VReiksQTggwo0itY5dvUAh2pVlJKqr+1dhfbnYvl7pUBC
    2TnUc2zewKWQitXOD2h0m3h/giCkcZg9/6rplonBzxDu+pAiUF2FEpPIZLUWXpOoUFkOS7
    vLFzmbDn+7WdOcGBW6P5JqgvaDZEME6NupUPaK9pLYDmds1sl4L25CDIefqBWRpfnRqKT8
    eVvk741NPgz7Wc1MaaJcZd4LSI9tlVZSxkWRdIN4eQkAQh29W6I5/pPtW4WlHD8aTddRzL
    SGH0q4NbB8ilfzrw5G/FOIaatfd4t6y3mO3bhHidEyeCyYnbDrcF4ia+8R9ZGgICJHgGwI
    mXoxWC6UiK++o9il0lh392bZ2yrsOl2s9tcUnBDbld0hgQxSs7vrDDCMqvBQ
X-ME-Proxy: <xmx:Kz5Nakco34UUj57608olH6dRni5l4paa7veqZcdvnyOpjFaCnih6XA>
    <xmx:Kz5Navol6d6X8Y3F07lgYfe-rW0g_ihpdDkLoTFTGMBpmZzwlpbKJg>
    <xmx:Kz5NalEVcn463Zs0RqHUxcoY1SPEzhKS9iknTolHh_jyfn6yrn1C1g>
    <xmx:Kz5NavvsUMJvoqDFEiVzJod4luoY3fPGjUU0VtUvaLh0oE1dCG74Ow>
    <xmx:Kz5NasKYqmx-99y-PqJurTWI3v6Q7y-XzgikI-2mG1QBhiIwTGcTa_R9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 13:58:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] setup: split up repository discovery and setup
In-Reply-To: <ak0U46-J4qmwL2FD@denethor> (Justin Tobler's message of "Tue, 7
	Jul 2026 10:02:58 -0500")
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
	<20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
	<ak0U46-J4qmwL2FD@denethor>
Date: Tue, 07 Jul 2026 10:58:01 -0700
Message-ID: <xmqqldbm4r86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/07/07 09:21AM, Patrick Steinhardt wrote:
>> Changes in v2:
>>   - Expand commit message to talk about precedence order between
>>     the "GIT_SHALLOW_FILE" environment variable and the "--shallow-file"
>>     command line switch.
>>   - Remove a now-unused parameter in `set_alternate_shallow_file()`.
>>   - Fix a typo.
>>   - Link to v1: https://patch.msgid.link/20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im
>
> The changes in this version look good to me. Thanks.

Thanks, both.  These indeed look good.

Will replace.
