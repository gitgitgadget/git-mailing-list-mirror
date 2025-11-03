Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9828507E
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195398; cv=none; b=sHfVXZlIfZTuY02mZdMpRqza1V0eYOWWJBoRtNDF+BRL16cgiehdeLt9GUglDzEzIyROfYqrmwMI023hkh3srCJEdl9ytn3gT8uXRSGPx9cIeXkogpo7jbfg0BjNwBIhmuLIEAWyOXXAS/8NCoZxhIhMUtKxI1k65GpG2cIZde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195398; c=relaxed/simple;
	bh=C6ZiTPHu15MKD5fRUzFkjtDMoURIIX4IWbCZicOchLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KAoRIfnhYF/IetsnCRcJ8PRq7dPX1aYFhLsc0Cj5Kfr0vrq5Q1FxeKyM7jT9nvCELgY7bbeNLq/9q6gkxhbk41B+OLXNOJEQOImeDDhDhRH8zO/cIv2TZGV2dagRBE1be5J626Y4ypEBhBKjgE8FU+Jml4exZRkGD7GqllmEGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HA6qmVNA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doB374TL; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HA6qmVNA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doB374TL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B4561D00307;
	Mon,  3 Nov 2025 13:43:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 13:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762195394; x=1762281794; bh=h3gztTudBq
	ZoGNqspFy0URr3flHVhUNYBe8oijHJ1go=; b=HA6qmVNAJxDG1CpEKVTz9HcIod
	FFrEbhEGQJCt/rwCDtr+S20Rz/8+3aaiVSydjV9Aegp1iOUn4V51Y2JD5rp3k8j+
	KgcN1Kx23k2OJEMWPbhXQlyaujNrFUK+TpXH9zSOZTL7JBem+xZTl24DdEZGNTc/
	HpCJZXKgoYF+f15PbGt+FF2ZaBNVQ+/0zX/yg3l8Qe6Tka5sK1Um+8V+huD7h7Oi
	OG6cYEmBnBffSlVC3ts/K4M6HKbuBcJsCTKdfh6UPyYC7Et2C94MWR2mYJ9IP6AS
	+UWLznW3QHGNDm13c0XAgJvmd32hc9ZJ+qu/Izvw+42yd6oOycL2Xvz0iGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762195394; x=1762281794; bh=h3gztTudBqZoGNqspFy0URr3flHVhUNYBe8
	oijHJ1go=; b=doB374TL1DUdqtXeI6T1m91f0JQpMEvWDMgt7MiYL3P3e3bIVjq
	7pOEeZnhqQ8QLPGy1fuyYif482RbcjC0Hx71v6GB4Cd3o5aIuKQ9RvnclhHDM2Ie
	BmlZC3lzZ6aXcoelMfygxXpB1g06PYWKSB2hZmE2aUUZh569LMowb1H3Koyu3EnJ
	QxFUevoR1mNKKp/dnyZXYKLBedmUChutqxLyPwYWMu9n60PBtHL3vOunAfiFzVvD
	QHPop496Ifv/XnmRH2KL2810RsRgfdvWCve7muAtrPZO4Ohy4ByTw98nN5REUHkg
	yaoZi/l6NJ3fc9eP4VdG3MF5y4G99Q2BcEg==
X-ME-Sender: <xms:wfcIaULg9dOJ99thwdVtrqV2jD9yThoj7vse550JlxpYQ4nBU1FzhA>
    <xme:wfcIabm_1dEdgIfV4ueuLKWICVPc3b8jpiuqjCG5GEy-PwVk8b0fIXo56M3hRzg2n
    tbcnvwLOGuMkKh-eN3hhXRtrUuDDcKXdm8__WUqvOrrHs5LlcPzbw>
X-ME-Received: <xmr:wfcIaSHgTMNcb0aaibNb6ZWnIwFteWPJTEuHhkcFnyC4ErWEZJsguRHOIFZJpTo3KJT41QWY64cyGHANO9dfl4ZB6c1lMBB-lJ8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:wfcIabGXT14EIulmObsh1WWUjQLQG1lentH9pmT0AyI4N5q3IhfYcw>
    <xmx:wfcIafMXummYIY6ix702S5bXY80ldl-in3i5ouiV_zB-t0czrTF5MA>
    <xmx:wfcIaaEFVg7suepxPciRXBoDpaJ8d2uC7FqPAGMMoeilXQxI0IeIxA>
    <xmx:wfcIaWMV7p9OZz2OucTqdvzgXgpE2s-PLJ3AOfC5tN-Vq5Uk2PsjjA>
    <xmx:wvcIaTt-MIzQIEbUiWaZuKnPe806-voeXXA7Ch0tMz6iIfo-nADKv6p9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 13:43:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
In-Reply-To: <xmqqo6pjt2wn.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Nov 2025 09:57:28 -0800")
References: <xmqqpla43wcp.fsf@gitster.g> <aQRaRuBtt_r7SamL@pks.im>
	<xmqqo6pjt2wn.fsf@gitster.g>
Date: Mon, 03 Nov 2025 10:43:12 -0800
Message-ID: <xmqqh5vbt0sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The tip of 'next' as of today after merging this topic, it seems.
>
>     $ git tag --list --sort=version:tag 'v*.0'
>
> no longer works correctly and shows ascii sort.
>
>     v1.0.0
>     v1.1.0
>     ...
>     v2.0.0
>     v2.1.0
>     v2.10.0
>     v2.11.0
>     ...
>     v2.19.0
>     v2.2.0
>     v2.20.0
>     v2.21.0
>     ...
>     v2.49.0
>     v2.5.0
>     v2.50.0
>     v2.51.0
>     v2.6.0
>     v2.7.0
>     v2.8.0
>     v2.9.0
>
> The merge on 'next' immediately before this topic got merged, i.e.,
> 9ab444ed (Merge branch 'tc/last-modified-active-paths-optimization'
> into next, 2025-11-03), is the last commit on the 'next'
> first-parent chain with which the above command works correctly.
>
> I haven't dug it further yet.

Bisect points at 054f5f45 (ref-filter: parse objects on demand,
2025-10-23), which is unfortunate, as that is the motivating step of
the whole topic.

