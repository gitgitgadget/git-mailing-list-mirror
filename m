Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A862857CA
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218429; cv=none; b=W0xw6zPsjtVijbfs4mELbCOdvvUk24Mw7Pec5GTPfG9B5ragwNdxWgZW9GHEM8RZYWaTY0ZF7J/IPFQr6fLkC800ZZU00Lc0jAuRo22+WViCTyu5HvnVgkg+tEqf5CT32n73wCRqXDqW+hqbgtjYQOxfRfjNhjQVXeMPMMrE1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218429; c=relaxed/simple;
	bh=TkmoGG/xwx2RavU6m9c+ADN8fWcC/H7GEZwka4leWiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLQAD2E/Be1qp0nh+L8dHqrg8Zuf2NruJz+Pfh48+h4g9OTY5ESZ+0QhjSVC5eCnbMzHiXdbUSpB8JbDWMJcnnMqj/LassT+UIP3j2wcf2DmMW7MCxjGddOoxy9mTBAymD2HKFkypISW0wsnp10lcMxA4WYB1YCbIiCAgE6OBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rfSGrQbA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQ83y348; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rfSGrQbA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQ83y348"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E78C1400049;
	Mon,  8 Dec 2025 13:27:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 13:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218427; x=1765304827; bh=/QB34SSJ4O
	d9Db+SlqasxFh7tX2oq3JWvxq40q3erq8=; b=rfSGrQbAIKoQd00FYHhEsp7mtm
	8xZMyYW4xZLNn9Y4jHCwEsREgh3XP7Ik7rUPDUNXb/wtiY/ypr/I69Y3jDbPuw5N
	giaOY+tSSiuD6DMMILNRCTwhFZqpRJEAa7MdCRV2zH8hoD86xiiAlYLlunlI6NUI
	VXkrjgt7D6VqC1u2+kivWZji5T7Pu0bKpxXCZ6vD0nzLVy/AF8KambouYjX1QiIP
	4sqP6GEvj/I5dqdRBCX5b2blFy6XYPr7Kv4C8kQAaQ3SMcKvWTcsZ+cRoZ22zhEQ
	kqf2Mv08oWWGfljGQIDTiiRJYfAgeH+9a2qo27h8qLJ3RC1jjWUWT+B2tuFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218427; x=1765304827; bh=/QB34SSJ4Od9Db+SlqasxFh7tX2oq3JWvxq
	40q3erq8=; b=kQ83y348LN4rEs1mmE3EXc9do6e8AjyFBrYzroWjehwZ/X8L6No
	/UhxmLQgg8nIRcweHfAG/GHlq0yxhZ9Os4+chH4DFsxdWAWvPhVr6AIJmtz7zZqs
	6OsDOxQ2+u1/uIWVf4DuASFlJLftbQJyEC2ROqXeOHL1I38nJG5OGU7ha0J4sksd
	L6+ajtYI0LUwba3JxYW5tPko0ibJOr96HiWWeADGnd9jZWiKLc4g3ZQHMMd+/2gF
	mTxSnd5UMfcdl+95Bsfi4EavhT+gPLtuxL7KhLEizlY3tx8Q9yrlXW3Kthuf8bl9
	6QyZoXobWfcRF1E4uyc5lSSFKNRCbCII6cg==
X-ME-Sender: <xms:exg3aRFmF_ptvb-ReVWrAgBroOhWEOGxhmO8db8wFZ5Ize47dhLhLg>
    <xme:exg3aR1OaPq0C0S_E434AwlRs-Uml1TrLOB8sDcAs7QnAfdOPF2QZ-8ozsQeoM3_x
    31-HE5QLHMS4W3VOZ7nLxvKDKs_u96358Fs5d0ZQQyCERfzlOeNzA>
X-ME-Received: <xmr:exg3aZl69AIxqMoNis-seufzhBszwzHzp8orA0Nj8eRz3Vng4pdjIl7Ti0t4ubGmKr90YO42b5MZp3zxDvZx9NXwKo7Imrzg7rLrorOJrCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:exg3aR9mX9CL0ZUX9DrrzPyIxCUiQ_tdgmeGOMb6bHlJRWzhqMxebg>
    <xmx:exg3aequ7ng1HQfqwaLAQLj3SNFghEfVXUz73w7HrekEAsFsHcoMmw>
    <xmx:exg3aan9t3DeJFL8rpxszpIflFtht5GBn5Wa4yEKIestnxSl_5K3XA>
    <xmx:exg3aVgYeqmv4UJgxrXsNaEkCwOdQY88StTM2lx7ER8un1E-OM6jYw>
    <xmx:exg3aVKWJY2MKAL49REjxquvqP5bnGQ9BCddV4TarN57Si-nmd26Lx83>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:27:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c03c2b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:27:05 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:27:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/17] git-compat-util.h: introduce `u32_add()`
Message-ID: <aTcYdebOuUfrAAJJ@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <776eb88905f53dd929e5b7cb23593976a2f1aad3.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776eb88905f53dd929e5b7cb23593976a2f1aad3.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:28PM -0500, Taylor Blau wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 398e0fac4fa..a7aa5f05fc9 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -670,6 +670,14 @@ static inline int cast_size_t_to_int(size_t a)
>  	return (int)a;
>  }
>  
> +static inline uint32_t u32_add(uint32_t a, uint32_t b)
> +{
> +	if (unsigned_add_overflows(a, b))
> +		die("uint32_t overflow: %"PRIuMAX" + %"PRIuMAX,
> +		    (uintmax_t)a, (uintmax_t)b);
> +	return a + b;
> +}

We already use PRIu32 in our codebase, so why is the cast necessary?

Patrick
