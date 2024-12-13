Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C61DF991
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092689; cv=none; b=Ga+HyKuoeQ5/jeMiijiaoES80hBLOi9OkmBNyGcqlmkQTLH6HeyjMcpgdjmqJTeDqjM+0ui024CFwJ1QSaUVwZWMUNBwiVrce6pc2vY6xOwp1PatIZmLGHlACAQ8g6JcQFEF+BRjJ19txh0k3hqHz8UeKez/gkVhh+mLFycbkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092689; c=relaxed/simple;
	bh=WPd+uha4qRiPljjzSjwtmQREzO665rSd0ESiqijHwTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ+JgDFNulAY5SjlNUREyb5acDB20FNVsOySVdvw4FxzU1zceh/19wVckR7ihR91xs+jfD0eiiNLx1G7OZO9oDsxFCBO1UFbsOKxsJEPSWsJrK/IbSNsNWtSsFvc4LKF3tNocf7uotTRTZ2yn61c6T+Ky3Kf228NrlyeG4qpghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rTxetEIz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m6uGXAJ6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rTxetEIz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m6uGXAJ6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 016681383FDD;
	Fri, 13 Dec 2024 07:24:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Dec 2024 07:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734092686; x=1734179086; bh=4uw5X287Z+
	JKNypmRQty1Jgg+Oe0ktlAv6V6rr+Kjkc=; b=rTxetEIzKIue+2Aar3Fh2fGhJZ
	VCX4NLMwi9ToSvBIhqbIQ3iWowOVk4rywSZPM5ceQ85kf0p6tjb+6zZUmqdCPgSj
	n5UXGep3q8i5GUMFGAPGTRQ0vRBJtVzKnBkLP/TS4nUBoa1Kg5TP7cQSef6R0Bre
	MJ1HfxGmU1BY0zAPXerEWl9SEjliRlrW1+uFRhY7Adt9JYfPgTZOJuLt7QSEIaZA
	6Q9F31TzOfO3k+YbJeKAzzywvO/9TyLiVLcemj3QQOq13V7/H2TfEZR5PPlNP/09
	xZBZfG/FKbQ5dBTm17e/UYz3MA/zIX1wkldj2uu5/IHtbUNVm1LMt+J/XpEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734092686; x=1734179086; bh=4uw5X287Z+JKNypmRQty1Jgg+Oe0ktlAv6V
	6rr+Kjkc=; b=m6uGXAJ68cUgecmlrq9jKJaPWEd571s/v5zPF6S29Z23br4Z4LG
	IdrHcs1sjBkjWFVUQPSudQTc/mr3rv3pXj0k2m43MsLMXeztXWMvHKInmv2iY9ue
	c1XvkxEPffNpxGqaHpF7eQaHaE3khg0KuwpjmGDinQcAUIEAHglT+2WR6FNd5atH
	dZGshLAoTRgm/eRJLx3OWCaVbUEbDfMYUnHFeGI6MJDZGAeeNeGiQRBB0xCuWGmy
	EzJ9MCmf6m7/O04hvyOoAdCYiGiyOrAr1rUvPQ/vnGizYOU4myVdw4SOOBBb/OFE
	T72l544r0mRe3xhwO2Nzyb8z9qUshXRLnbA==
X-ME-Sender: <xms:jidcZ-QRi-vMfnkerpPjS41fTrMqmHeW-0FHbeSUsMV8Boxx107izA>
    <xme:jidcZzySb7rJDVhGGpoEE7dyT48H21IJncu6tWwJ1QrOroSujTgOjdfRwsXadcZSZ
    ZiY3WRBenP1gC7FTQ>
X-ME-Received: <xmr:jidcZ72Dk21WkABMzrSIYvmx9PelRUMK5Jq04nPun3HAZc8bF7iLMb6pbHMtD5u6b46B7GHEkhVSWWIHJGN1wpEVR6JkFZQH_GIN5l4FTeIvE5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jidcZ6BRSs3nGB0EukN0h4RMlLDbrryFMg3J8XYBKI4o5iNVAKdCyg>
    <xmx:jidcZ3hFvml5nT0eY2aNPG_eSa0hxptIekPI4vja1Q83oIJC8xkeRA>
    <xmx:jidcZ2oA9JPnB7wLIVt8c4ZllgfMq0V4jSPb3FvQ4Ohuha4gqXFbiA>
    <xmx:jidcZ6j6mPe7Mx2QNDcHSwYxSeofVrySqUFtC2siB93tI_GHXECJow>
    <xmx:jidcZ0tJsGkM34MNMlS14wVar3pdpAe-BNrpDb_fZO-sacctCUx58Z4f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 07:24:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 414277d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 12:23:07 +0000 (UTC)
Date: Fri, 13 Dec 2024 13:24:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] refs: allow multiple reflog entries for the same
 refname
Message-ID: <Z1wnf54rEq0POCb3@pks.im>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-7-f28312cdb6c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-7-f28312cdb6c0@gmail.com>

On Fri, Dec 13, 2024 at 11:36:52AM +0100, Karthik Nayak wrote:
> The reference transaction only allows a single update for a given
> reference to avoid conflicts. This, however, isn't an issue for reflogs.
> There are no conflicts to be resolved in reflogs and when migrating
> reflogs between backends we'd have multiple reflog entries for the same
> refname.
> 
> So allow multiple reflog updates within a single transaction. Also the
> reflog creation logic isn't exposed to the end user. While this might
> change in the future, currently, this reduces the scope of issues to
> think about.
> 
> In the reftable backend, the writer sorts all updates based on the
> update_index before writing to the block. When there are multiple
> reflogs for a given refname, it is essential that the order of the
> reflogs is maintained. So add the `index` value to the `update_index`.
> The `index` field is only be set when multiple reflog entries for a

s/only be/only

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..bec5962debea7b62572d08f6fa8fd38ab4cd8af6 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1405,7 +1407,19 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>  				}
>  
>  				fill_reftable_log_record(log, &c);
> -				log->update_index = ts;
> +
> +				/*
> +				 * Updates are sorted by the writer. So updates for the same
> +				 * refname need to contain different update indices.
> +				 */
> +				log->update_index = ts + u->index;

Okay. So instead of tracking things via a map, we now rely on the caller
to provide the update index. And if they don't provide one then we
cannot guarantee ordering.

I guess that's a good solution. After all, there will only be a very
limited amount of callers in the first place, so I think it's fine to
shift the responsibility onto them to maintain reflog ordering. They're
also the only ones who really know about the actual ordering.

> +				/*
> +				 * Note the max update_index so the limit can be set later on.
> +				 */
> +				if (log->update_index > max_update_index)
> +					max_update_index = log->update_index;

Makes sense, as well.

Patrick
