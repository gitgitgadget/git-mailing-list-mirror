Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D141754
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771649696; cv=none; b=V21NmQ56dQ38qtE/CalQSEYqkT7hBGX9QUxZaXsNfGk7OfE1sb1Cy7Iznu7TfUT/GnwZ2Xl9l7/Sq7cOicKgcYOLKQQP0aR1e0y1lp8AJ55MFZcDYTERiD2Jb8nK7n5KHjYPA9lJcByiLm152yNb89e1aGQVEKXuL4E9Pc8vQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771649696; c=relaxed/simple;
	bh=CrGqKuttXGX24wR+L5wpHXXGyUATGgGQ6OKzO2NwLbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P/bYocgrxaM+OlTnzO3LuntetwdJfPsRwyfx9qGbMkuKo8eW0UCi66O/Se5jxZ9X98jDhzWbqXM1T165yZfmGOKSr1ewhDPLawxkQeJPua9weDOImWqXB/S943p7HBA3VeNnQIsca9lN6O5e3IZg8/ubf8f3np6zgF+zy+SXtr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pGTQG83L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZlN7VxiN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pGTQG83L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlN7VxiN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 049557A01B0;
	Fri, 20 Feb 2026 23:54:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 23:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771649692; x=1771736092; bh=9/HQyIFZMJ
	ObrJRylE8uYrbRge0ow7gty47hH91tzUA=; b=pGTQG83L2jZSdokrTOUc+2ws/K
	hwJIaal4/NQchigiSmM91fqM+hdwb5vFVjTd61mYJnwIbPSxbBC0xSfdBsTTIVo+
	RwQ9jbmnvoeQc3AWnc3CwsZRTvDtpa9u/3TjyW5AapE+zguwDfmDEWgYa0XQoVkX
	fvOG2ekRscpJrOs5FwHOg8DeqXM9nCpd1HREaulonA7yAwA40AQrVZrFNuOxvGfs
	yowZI5OvJx1cxIjj331i/EBewPXOOOCEAP6emRt0gvJzvVz57N7ypbtGgNBVk0EV
	cjREtYm5Du6NsgrRbaEZul+2N4oEQd7MsVwi4PcDbnH0Wj8Eij320TTczJoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771649692; x=1771736092; bh=9/HQyIFZMJObrJRylE8uYrbRge0ow7gty47
	hH91tzUA=; b=ZlN7VxiNRphSz+H9TmIopyEeH19pSLmzW242qbF3OkCU4QS3cb/
	V1LHboyhciQ0HCb2fGu4FpLrdUoefTDPFv+UhzGi6+guQrz9UUiJWTAGn63MUV+F
	fJGi5/uO2O+lE4UA664POaKJr3fUHFa7J9OKGe1REyAbrfJ7T4RAGACFYYonC7nb
	V7Zy/qdTQ2wpe+VkkSOHfVg7xWgvlW21pYuXpInM/zpPWK7o2dd44OVG7VUrlMDl
	ooR31C5KGjJIzfPLsQ2eWHDuq2OoPz4dzTlpDUzuGNiScFp0BLDYWRtQI+EgCzcr
	iiciSc+aXZ1TAmdPU3ZlgnkOBOY2PGnDtlA==
X-ME-Sender: <xms:nDqZaTrF5km9qMB35mrOJv_Jpb2R6X7YW1SZOnDjxvQvT_YW5Je9dA>
    <xme:nDqZaVENvpvENIxQQQN3S20btCdHq1zZ7WoyBxm9u6X2cAmKSb4JZMgt0u-sKlj9m
    qu5zdWIHwiTF_Agjhcm1YgMVKy9GyBAxvuMc0PLuVVIA44S0Les5w>
X-ME-Received: <xmr:nDqZadl5DMkXhOZEv9YpVnfumnNuX8QMUrAe7p6J3FyHNFYOK-6dfhx-u_rOUWW7Ig4KPuzFi_8AaY68ri_Qlz1dbKNfzB0Urg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nDqZaQlbnzpv6ucr-C02EM0xCHE3zbUDDTGewIx5SgOl6X7U5wAMHw>
    <xmx:nDqZaWtUUUb593Qudw1U8gMxyQ8U9Ram2j28eIBMeGi7t_V3njIq8A>
    <xmx:nDqZabmUrqmtEWYPwbohri_z-2S13PFJM68_nH3WFXmH3toZwGev1Q>
    <xmx:nDqZaZuSUg8qmBvtOuZCvGu2rVmNGaDwSW7_GCncyykA_fyDXxcOfA>
    <xmx:nDqZaQQzKh1KhLxUuUPZgFMop6-dwZIXRI4P_xj_0FScUzNwn_fk1kI1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 23:54:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] format-patch: better commit list for cover letter
In-Reply-To: <20260220230633.132213-1-mroik@delayed.space> (Mirko Faina's
	message of "Sat, 21 Feb 2026 00:06:31 +0100")
References: <20260220230633.132213-1-mroik@delayed.space>
Date: Fri, 20 Feb 2026 20:54:50 -0800
Message-ID: <xmqqldgmu25h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Often when sending patch series there's a need to clarify to the
> reviewer what's the purpose of said series, since it might be difficult
> to understand it from reading the commits messages one by one.
>
> "git format-patch" provides the useful "--cover-letter" flag to declare
> if we want it to generate a template for us to use. By default it will
> generate a "git shortlog" of the changes, which developers find less
> useful than they'd like, mainly because the shortlog groups commits by
> author, and gives no obvious chronological order.

All true.

> Teach the make_cover_letter() a better cover letter format to replace
> the current. The format can be seen from the following example:
>
>     [1/3] abcc234s: this is a summary
>     [2/3] 73s84ns2: this is another summary

Two things to consider.

 (1) Drop the abbreviated object name, as they are useless garbage.
     The result of applying these patches will not have these commit
     object names anyway, so even when people find these messages on
     a mail archive in 6 months, they will not find the result of
     applying the patches from the official project history with
     these object names.

 (2) Do we need to make this optional, in order to allow those users
     who do prefer the current "shortlog" style that groups patches
     from the same person together to keep the original style?  I am
     undecided myself.
