Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7A1F131C
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735295667; cv=none; b=C2AZLams+t8BX5aP2kdwDgMWcEuPyyhkKcBeBqexUB6s7qNfTHDc3n8WWaoWIBqc9sfku7sfobF8TDkzZ0tjypCToS0bmW9TnF+LaxMggAbyHHpkFAJL3dlMkQ+tf6QJ4jW4rZ9wyKTK2hw3mvThZGrM+xggnkh0CblgbNcbMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735295667; c=relaxed/simple;
	bh=u0JUJbQr36dM0qFR4QkUz4zW1JR6YBI/iHNnQuAQjTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKfIxMQ7MfzviqiAzZFAutAveRlytQjfyBYxxKCtwDhmunbU2FAgGnNDSk+cRZ8UQlS6FTt/Pr9fhqHba/N7CwwLOijNfngz5wQ+mgrU3vROmVZq6H+9/KmlRe2SUvLSHTmwCAuNlNAoHucgwf/8fqkQf/5VrfpMkohZJh0n/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GkUfvKHK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGSFHE8e; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GkUfvKHK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGSFHE8e"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 567C313801C4;
	Fri, 27 Dec 2024 05:34:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 05:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735295665;
	 x=1735382065; bh=xncXmoQjyHBWotDbntx/HMpnRG49i2tGISCZJVgdUyI=; b=
	GkUfvKHKVND+rBnp+1xTDgaSWLqdxYOV12pikbYOeIhJfLQD9QKsEEazE6E4J7b9
	N5B9Bt6lo/AFLDb6UVDQLGTL5gExSb2zKJWA+mcJZObivVe7CQWCpTyZTSD4yWsc
	QrWgOPKwGYmRk7Fg1ZuVGUS5kQeRxkKMFGuKTNP5XBzHWexNC7hvkOiO0UX0qqVD
	vbWYIvBA1keAPKAZHC/VN/txu35SiwKpwqlP3Dy9VSKAZEGV8cBcJfvsu6xvvBuW
	23fxM8d6u4QynLd7xy+ssZNWup5hWb4H9g41XJEq8N6a6Lal9nMynbMlAy0AG6s8
	kblulchRF1tVflabnUHxMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735295665; x=
	1735382065; bh=xncXmoQjyHBWotDbntx/HMpnRG49i2tGISCZJVgdUyI=; b=B
	GSFHE8e8U16jeEvitt6hYkE1W8CNRHA6gHXb6RCvcj/nKIEDNHhuaamEgmJpPCAJ
	OKZr6vHAAP89WzMzH+FcIaUjBvAtD/tjJ/ic9OK0thQK/qI9tCJ2NxKbhjzH9WBa
	6khPQYKqKNp+x4tGIm6NN0ar2YvgA4KU7zEQqJ24NZYLvdEcmgve5HryC0Z2q04B
	X3GUc5WwXTjwQ06ExJ0XuDMzRcCgei8jkvx+22rg1jHJlI6paVgiNC/Fd7gTlKQ6
	jjy3bYuNYPSTNtm+C2PxasXQfy109A7uYv8EO9LVCEaOHL9GT0CEBgPz3749jWmN
	8/DV92dVIa20KjkNxN0mg==
X-ME-Sender: <xms:sYJuZ5vuyu_J-mCvgUkqksamyxV2-LM36jf3TqOPXNCk8IqziqnT7w>
    <xme:sYJuZyf2oBSUT7MSizDfW7iCyVlOfeqL0Okdy60B5T858Y0MOkxCdoZn-oF0pSN4w
    LQHpmKeTKnM9g64dg>
X-ME-Received: <xmr:sYJuZ8wwBBshRfN7HWk8iLq6lN70zQHnNQ40hA6WlsW-XlWcXZ2PKj63AWDRzWGQJgWFGcrpYXqNh17BnF6uFrh2YNe2CHeKgzOuJ5l-Vin10w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sYJuZwN7k23aj1ADO73XoIP7AH0px4wylWuGbDPzwp0zwHAVxxnw4w>
    <xmx:sYJuZ5_WV2UxTE0eVUfkQx_km-KkX6hNAo7sMzDGyfQyZytAiKkpXA>
    <xmx:sYJuZwXYs04hMuKvuUzCVoPeYuN1p6QN54ntjbOA0Fyhem0OjO4S-A>
    <xmx:sYJuZ6cJ4QOxO-bBuvP6xHAhdbGp8xoRo2k9Epvw-qPUyfUP0-yHtw>
    <xmx:sYJuZ7J4ZSFuoZkSCMPlACFOxgBML36s5uD4AWhMbdZKZtjkMPM78sQz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:34:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 83a19dfe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:32:20 +0000 (UTC)
Date: Fri, 27 Dec 2024 11:34:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] reftable: fix realloc error handling
Message-ID: <Z26CnRsw0yqQblMO@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>

On Wed, Dec 25, 2024 at 07:33:07PM +0100, René Scharfe wrote:
> The current handling of reallocation errors leaks the original
> allocation in most cases and corrupts the capacity variable.  Fix
> that in REFTABLE_ALLOC_GROW and by providing a new macro
> REFTABLE_ALLOC_GROW_OR_NULL -- solve this somewhat tricky issue
> centrally, with minimal impact to calling code.
> 
> And the last two patches add error handling to the remaining
> places that still lack it.

Thanks a lot for working on this!

Patrick
