Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA51AF0AF
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792857; cv=none; b=hy+dRi09e/pzv5rYaBU4ubXliA0nyueFE2xzpgM4RJiAWyD6veJY1mPoTgbkRpYjzO+xKviQxa1C/WkIUdi70AYksew2/x4N0ftNh3AhmNpwj67iIT9P2t4j5K50H9do4E1NVe35Xz+Rw2IdPKH/x/534C+61VFxREzFC7SczK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792857; c=relaxed/simple;
	bh=EJY/qeaMqAjVHGnDJevvWKnFX5G/hjuVpCMgG3wuXHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YRrHrPwPaEZ8Z+Yl9hFwIAW0nxkk0bjj6CnrvVlqAzXzda34F5QOmcR+llcr2/V1DZ3INqJ3M/FXCr+wNLJGA1D2JFM33TERQ06Q7Bhk2RRRtsVmRMyjAAMAr5y9qi7iqXuoM89pzI467f6w8/SLth6Vnz/NelZy6uHzS1u1dB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UdJCT3V8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bzTaXitn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UdJCT3V8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bzTaXitn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC3467A012A;
	Fri, 30 Jan 2026 12:07:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 12:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769792855; x=1769879255; bh=oLVhinWYVf
	fDuutGztFP/4X7BLqWaRCJsFLLeRjGU0o=; b=UdJCT3V8BYMnjVkjiLFJ/V53T2
	o47Bum+uKAwocNp8qQvB7OElHQvUtMgwGbqEW9fzI74HiCdoM//bB7pfyivKXjgz
	ab2KhYk70ZCATs3jWv6CwB531IPG+1QjbAd3x3DmiMUqvnJW/sp722D14nNUP+8Q
	dk4g+hMsQGZng8m6RDj5AYQaa4o8/6G3kMTcsYWsF1kxbYAQbtNYegtiRcNLouYG
	SEwcVObcF6lENhF7rpxaaBRZrJxwChIP6ESA4lfoBxaS7vTJGnvGvMYak+9oSWOf
	C30lA+KO4V6OdsFQNttmsDE2mUV2qmkd853Ra2z92WKmL92euVS0cMxGg7xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769792855; x=1769879255; bh=oLVhinWYVffDuutGztFP/4X7BLqWaRCJsFL
	LeRjGU0o=; b=bzTaXitnKuEtFkTeVFW33g9fg5bLDpzJcN2NBkgrSEBq3hmiKSg
	qcbtowf7kCaVLZWxgVuaJ6TqiTaWXyhgJT+h64hyGHdUlUdZV0WwpHcv83ITlo7k
	yKvUcAPiEt8CqOiaa65Je/uEfGKx2JAAvEnefjQdOgQKpWSdWcEob0uJ+d9sgOPU
	sWtMehQBb7hLfw2NyootGfMdD75dfruRa9vXmJlAInBTkjxuiwo/fKMXbC8ii6zy
	1Y5TRImQsoPr+6iPMnVscCH2eMlt0bAKjmJDDHmZEOw/Ugg6JfYrmxt7ab9L7qgo
	vzc5FExBsaqhOiMucN0xPFXai4JYfsfDAuQ==
X-ME-Sender: <xms:V-V8aSAVv8Nezr96UsoFC4xXrf5Ff3wi6k0G0oc4F5-5lFUQm0vevg>
    <xme:V-V8aQMASDYshZI7cBrenwXx_4JASLGtDKepgqo1HcqKkjNjJNYwtRaJL_30ji70W
    _k8cX7Ya7ZQeJnClmS9XBglXL4dHEdy-QlwdnoHaHaaV-cU-niayw>
X-ME-Received: <xmr:V-V8afYNMrKXzxqOKQRnrU8e9R8gYq65RXb-wpfNAn7Yw38HnhunwOQYYSymleI8skI-qe8EbGT1vFDjP_X77P8zBirZX90Jxc56feg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    uhhsthgvugestghouggvsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:V-V8aXtlkO4hK6ZfPRprnwlgXaRP9DriQA9ThdOWANCdnv_wsNPwCw>
    <xmx:V-V8aZOGgeydBhPSjPOFdeUK4601oOmDwESLSBV1fYDGVYKe3wA0ZQ>
    <xmx:V-V8aW59wirDys1quuOCfnECTk_qRPt9BuwdU59fUm3dwJi8KHVfMQ>
    <xmx:V-V8aXSy8ATkOjvFqyEntrUFwB9TAZo6NMkYyTiUHVNMvGeA9jaSTg>
    <xmx:V-V8aY8DJweY8B7XoPa2RiCZcLkwzB7zIH8Qf4a_uE2-asV6t5fS4CB9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 12:07:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v6 0/4] Fix git-last-modified(1) bug triggered when
 passing a tree-ish
In-Reply-To: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
	(Toon Claes's message of "Fri, 30 Jan 2026 15:26:34 +0100")
References: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
	<20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
Date: Fri, 30 Jan 2026 09:07:33 -0800
Message-ID: <xmqqecn76nca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Changes in v6:
> - Fix CI failure with Meson on Windows.
> - Link to v5: https://patch.msgid.link/20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com

Replaced.  Thanks.
