Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF42D6401
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945314; cv=none; b=Td9mRWRxUoIZxA4oxrHHT+ZnYb04KIuOJRTvf3K9WuE5lxgqc/6MN/5uBVNHIboPAwVGgc7R56dNx0s5VDUvAz0rvmj9rqRN8FILBQ6jgaMrQTZZP8Mm+mNc8XWUtnyFRJ76bJg8CnIwWLQUN8V0B4KRd7fn8KayCkeIperDV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945314; c=relaxed/simple;
	bh=t4mNDSXmjcTZ5BNq+gq1tEysgzorkS6BRFl7DlSUE4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJWbQLH+BAYucRCauGK0IFZWjsrGLjwoiuXeR8VPZJP3SjL0shP8WVm99iMvmMbEZcF1rvful1SqsVgyTxCFtfktzKbyCsGAh3N84E8+4IZGqS+OcGxJkev1sQuc9P0rw/Q39lOFcmr67PuVXNU5GX0f0c9FMp2519rVuz1u6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ap5mVswd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cw1seoay; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ap5mVswd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cw1seoay"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2681C7A01C1;
	Thu, 19 Mar 2026 14:35:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 14:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773945312; x=1774031712; bh=bKVLK2pmsi
	libjilKuKD8d96Zkhly0tX5wgBsW9JpNs=; b=Ap5mVswdIWM9pHMZB8tGbyQLxZ
	k4NotyFGU76lu0H4pm02uTupesWOJmUDPnQJT4M95AYzg8fWGzjDNUndYTyXxQ9a
	H/luDWpSsd11mW9m8OU62Uubey73LRrNMXG8byiINPxr5tA0VOuPz4G00T76nC4e
	Qq7wu1GeiIlPZNElEaaL/66UIxymiRVTGSDqtmw6t9y++FHUkIak3HwbAzJ6H+k8
	NCZ4sqxrdGlPfs3Z4kaBmmmyUwHo4k/d9vzyRedKZLondBY4Er9s3KtIN+c1bMgQ
	fLRlQHCD++J4oZUwtVjgsPQE7KmVuS9AGXajxxD66zvPwXB9ZQ8Q3886ZR7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773945312; x=1774031712; bh=bKVLK2pmsilibjilKuKD8d96Zkhly0tX5wg
	BsW9JpNs=; b=Cw1seoayEcBW1kQpqhU30XozfdGY0QkjGhA0YDmb+kvBuMZ/CMr
	S4ry2pN996TFLWCnwLOj0w9pYhavEbm9ScW9aqGZs5BUaiweFMRlQWeSKkifxkcg
	4j2Jlh9I761Guo1FtRWKADxqemnT9hWzgF4Oz93A8mvjT2g/5fezCCCiD+KVf5Tt
	vO5lvohuhECzJZmbcBxiWvS9cnfJKZDqA38Ks61e6rUo4graSWfgK5hWKlxvYAVV
	JOcsi65zhvVwBF5xlN5a44N+6NWkwE4YkQuDh6ZVu/TfEjFTyAr12sMqoqGrHZx9
	qjFh68nWx8f6i00tk7rv06IvEuGNgQwY1nQ==
X-ME-Sender: <xms:30G8aU6DxEedv-cMSMRo1mP7XVeWJZwqBUrjs_2cVsN1Ykz-XtqVmQ>
    <xme:30G8ac68ui9azzu6PmbXXERg1Hm1DzwYvF6XxDhbbvwpBbZxUffIjbhHjEUM4nvoQ
    fIH0FgvIqrN7OY9Y30wYa0t1qafQN-wvBH9SrYLvdUWVP9k4amxX_s>
X-ME-Received: <xmr:30G8aYeF9Tew3C7UDDRDjfIo1AKxztqG7FZRXKh9ESXKNgmoCo7TUlmu3VtI0uaNMkwK3vvPvbyEPgipdGB7Y2lFEMLe_Gdk3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgrsghlohhoshgrsggrthgvrhhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvghlkhhhrghtrggsihgsihhlrghlsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:30G8aYAyFW2CTpwIDmvzhDG0LJtB2yL1w0LVv_SDutZtEeHoR5cWfg>
    <xmx:30G8aT-2prhRTSkp89eFlOU3shoRaFIT5wjn9JckK-uyZ_9McGQQ5w>
    <xmx:30G8abKAYllAdPoVP0pPJdSdcruWd6e1sk6I2HCReDjngsZaCI2JKw>
    <xmx:30G8aUjLkxZtSIB4rxu8wXD7VE_uKGO95aLAX8VsqlnirgiaCaG8fw>
    <xmx:4EG8aX86vWIe6rTYsG5d5dfLcx2t6EV6IBip4fj7uoEjzZHwaoyB4vO3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 14:35:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: Bilal El Khatabi <elkhatabibilal@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t5315: use test_path_is_file for loose-object check
In-Reply-To: <CAN5EUNR2mqpCMG0oPsDnzgZr-2yyL+S0A7p_MM62F7d4MjBuSA@mail.gmail.com>
	(Pablo's message of "Thu, 19 Mar 2026 17:26:31 +0100")
References: <20260319160301.98039-1-elkhatabibilal@gmail.com>
	<CAN5EUNR2mqpCMG0oPsDnzgZr-2yyL+S0A7p_MM62F7d4MjBuSA@mail.gmail.com>
Date: Thu, 19 Mar 2026 11:35:09 -0700
Message-ID: <xmqqbjgjllb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo <pabloosabaterr@gmail.com> writes:

> Seeing that this is a microproject and the current date, if this is
> for GSoC, add to the subject GSoC with PATCH "[GSoC PATCH]" for
> example, and CC your possible co mentors.

Thanks for noting these things for new folks.  Another thing to
encourage is to read and be aware of what other new folks in the
community has done recently by reading

    https://lore.kernel.org/git/

and at least skim a handful of threads, and a few of them that are
titled similarly to what they are about to post in detail.

Thanks.

