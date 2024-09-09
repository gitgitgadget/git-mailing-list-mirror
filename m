Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6A13BAF1
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882131; cv=none; b=NShhwo6XK3QIsuzPW7XTv2w6AsbXRMFE6IETwCqWTf4MYJIY6hHD6Jz2vDooBmYYUzXrweF9viSWMx6FKQ5jIBYGqKmdmuZr8+j4zbjopALnDQdOgTl/F/2Unc38tOXpwECus/oUn+X8MON7EFI8qdJ9iIeTD47DLEGFPlD7CTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882131; c=relaxed/simple;
	bh=5SjE5cNMUomp+g3yZaLqU5nPQuXarqUneHETX5QZ+v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxXSG9dn30V6tA2ophy8kQmqeSRGpVxJ76Mp42gWiyrpX0wZInEnqUtsNkVI/3IzL8ELP6BsoBsCA+EkNgZaaaJ+0V3zbpb6984fI7wjlojHYmFgT1DDyjcG180Wn3LKWi9EiLu4myEWCCZzdWMFljp9EKJJmiAKw6Jk1Aj+cIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y31ZqlNX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J6hiBTx1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y31ZqlNX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6hiBTx1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4153E1380268;
	Mon,  9 Sep 2024 07:42:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 09 Sep 2024 07:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725882129; x=1725968529; bh=CSxKATkilD
	3Ca3tvfmawOlPLM4EvVaoDswayh6p2QLk=; b=Y31ZqlNXdN/heditG9K6z9KhZc
	vmRzNdaviX9NoZmET0QoKzR5oUAq7j5AFAtc+d1Z6PVhcCj/LP4ox2qX6Dk34v+L
	LbfX+8YWFztuW9RZZc1s6lhdn2tCjlGQxUn6aQnatU72mbXMRPbLXx6lXsmiyFFN
	GgUZIHArmAfAekEY9M6Nt1FrGDRCOn+iUWvvke9lNQRnocjNUxHT9XByJ4ieYTNB
	yXSaE8GyuGn6QoAOqB2rJHRrvmXMWuqJKgLop03c0XsfRW6kEyJUPWJgz1p0UeKm
	vO4/uloqBrMd7MdXZsG/B7qCfloeUjXFTqPBLcSytgSQqVFZnsli2cqK9Z3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725882129; x=1725968529; bh=CSxKATkilD3Ca3tvfmawOlPLM4Ev
	VaoDswayh6p2QLk=; b=J6hiBTx19HnDnclyBNn6wFMJoyDl5/B6hHjdMGpxx1JT
	+LznhUDEAtky1aR9twtvWkt7S+uqF7J8/Ks7RqOdElcDH21vxYWyh8qjLOJTReOD
	oCJPrGEqULFDef+QNJdf0wIItGLjexnBYKhAN1Vu3SnAX2wiAIhW1tw0IJ5nsZyq
	UqlSEvTmhFH0AMz06Z+3WLC6OZrN2pAiYfL03EZOXV07C1aYQFncfnDOYgv5LOlu
	XxjqkAMujt+k2ltJtDXGU75JdEd7tJ1izd72ZIJBa0wS07IbhsxuWxEQs6oWDqMe
	L27dN2FAosx0kLpxBm2dVsduYpfNaERUXqgGFBs7Eg==
X-ME-Sender: <xms:EN_eZgI_EPKH0-xRPOu0a1kkQefUOVdvQZF0_jsbNZKVx2RJaAmjeQ>
    <xme:EN_eZgK8VMNHD5ZeKL-7BwNcvx5lYUlqr2Bmby-Xk-XYgH0FoN42UYVVvVFHvLfSP
    qsX_1vO5dXcJbXiqw>
X-ME-Received: <xmr:EN_eZgsxNlF9GMpz7053P6dXkLvGeSBB6M8p8N6cv4S1ZU1Kj5VD1UWlJh4YG7s2vJH6bxDx8h_ZrW3f6No9vd_f0Bc-V_q9gmjCOf9tqgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:EN_eZtYvKklBRox36_uMTH5FUSaCuxe8zn32nhlmOgI0_bTOCddYbQ>
    <xmx:EN_eZnZmfPecyGVS3MSKY5_EsHIBiPYoe_iHnrnm4VTHYfoxBRgKyg>
    <xmx:EN_eZpBAtG3CwWybuNGD9Ekd5_eg9QyNIevOgRvYhVyeH0m7HRgrGA>
    <xmx:EN_eZtZuHn-x6sjTjc_dQkHuuiAD3JLqadzBbEv2PovpRsyCfbgM4g>
    <xmx:Ed_eZjEozsKqSVb02h14WGnO5m7Jb-z6v7dTdqLcgamqFuoK2ykD-btr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:42:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42c37754 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:42:04 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:42:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 4/6] t-reftable-stack: use reftable_ref_record_equal()
 to compare ref records
Message-ID: <Zt7fDSjqqKMW2lKG@pks.im>
References: <20240906113746.8903-1-chandrapratap3519@gmail.com>
 <20240908041632.4948-1-chandrapratap3519@gmail.com>
 <20240908041632.4948-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908041632.4948-5-chandrapratap3519@gmail.com>

On Sun, Sep 08, 2024 at 09:35:59AM +0530, Chandra Pratap wrote:
> In the current stack tests, ref records are compared for equality
> by sometimes using the dedicated function for ref-record comparison,
> reftable_ref_record_equal(), and sometimes by explicity comparing
> contents of the ref records.
> 
> The latter method is undesired because there can exist unequal ref
> records with the some of the contents being equal. Replace the latter

s/the some/some

Not worth a reroll, just pointing it out in case you end up rerolling
due to other issues.

Patrick
