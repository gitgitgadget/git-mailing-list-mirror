Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23017D358
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927210; cv=none; b=ZUKWFDyQ6OnoiAdxp9aQD/PFu/9Wj8hEEefR/rPcoCXjO4goORIO2OV6w6XTT5TsUkQxzW2O0oJCV+VbpkAS/TLN63BhZpzbvR97OPLUb9iHMHfLYzczJisl7GtCABB1jUNOdlUDaqvPK1K8gox3/hJDGfHeKzFJLX+5+h/SZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927210; c=relaxed/simple;
	bh=zk+o/tyu5Q98IZu9noGKCEPqQ7/4DtdcLcGZcAR87cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WslLwtqReXNM/bfdNLY1UVUjZdPdL3SCNHbBLbZ4Xlc71H6ezF6aEAMUTnSmmNjTb4e23xvBgQX3oT2v1ir8ozfpCVsJxIiXU+HCfAVYr8ZduDtwaovGzmqrbbZo1smkRMGG5mMYYGq+Nmz9ORreDEEmjVCMo84qMEwGcI/Jj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lqH4l3wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2OwbM9+v; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lqH4l3wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2OwbM9+v"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7E2F2540225;
	Wed, 11 Dec 2024 09:26:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Dec 2024 09:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733927206; x=1734013606; bh=Tt7nJOkJhI
	N8HmgcmBgsBg7MrQ4quNSrJYjgyOyepH4=; b=lqH4l3wlYaPPNjjqkFBgak1NwI
	uNCwi/23JBssyONbCFkKkpWSjKWzdlcYtJmtsvsjyDuvJ3OTiGeWMNpWlSD0H7zz
	eVjkgLlp/0qrUiaLh9h+DOkEahnofyMaJUGOfn7SfLEKBdVIU6MHEAQTCudI0MDb
	rElQl3aY3D/jG1dYXGlxtyA7sRcZWlqYwVQ66AebDbcwdPrGoU5/UXoINtj+l2wd
	f8wray2DP3RdyalVkTxoKwMYQqlK7B0KnysmUaQOlPyUAw5LRRC19BF/zoORPajl
	PROlgQ18yCvDiSj5YWLFTz5BelnKfLs8uQkT8+XGjlMmO62hgpN7c3AeMXnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733927206; x=1734013606; bh=Tt7nJOkJhIN8HmgcmBgsBg7MrQ4quNSrJYj
	gyOyepH4=; b=2OwbM9+vXtT6Oys5r0ywbcCz7HABoFS/1l9wK1i0SIVkAE87RLg
	VAZQpvt+dK93Hinyddxl1VZi5L93bpAH6+CbnJCMdDmqdRZE4xRHD4Wsxni/zcCr
	EYIMZXM58/rvWoEr/Yzv7AZAOa2Zsv/YA+W0+Vnj71YXYJ25afT5EwOFNVkHV1+7
	ztG95fH+9JjEUESu/Jlwx+XfAH5YyWbHvAKxr1BMrcK14WQYD1FtDrj4teGj+VL5
	oZXWager3rxAqfwkNTWmyFXwO0pOQhSJ7eALMkhs2YmzlnlS2xIfgWtAljJV7XnI
	Wt+qGOehk6ahnt++M85QmSQegoJHHgI3Cvw==
X-ME-Sender: <xms:JqFZZ1DLMTEsjyNTRVs7uRAcj0TXOYmIBLIh4TQRlhBTTgMvungSCQ>
    <xme:JqFZZziNk8TrJJwETUQF7SJJu_PyATpo_fECCV3AAJYtC5Co0D-Y-SZFxHGWM-Ldx
    DKv7pdTdnzZ5Sc8Tw>
X-ME-Received: <xmr:JqFZZwnJs_rAP_dcZe0IBdAMM-GJdL2f1PRH8yX1yzoU_GY7XPPrIA7WyMsnvyMmdKg63Iw1j9cKut9Nv16mM_-7Tq4HbRNgEldfyEjXTDm5jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    gthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JqFZZ_waWqzl1oJoJ4ur9rKrHy0EZAvZ0x7JeZYOoXMbCnscFtiIfg>
    <xmx:JqFZZ6SpL_t0aKrgEpE8caLchidxU_6-pOZokoJgWMvk8vHwq4Vbnw>
    <xmx:JqFZZyYvy-Hdbq77B_VhR50BUWeeIkIKCTG4YjdvqnOkiAcaXp-G9A>
    <xmx:JqFZZ7TIhI39QB1qc1cGkfTK2USVd4Wqkp7ckCzw9C_BifGJd-aCqw>
    <xmx:JqFZZwM6u9lcGSexCEzIcookKAwUj5OoaV5b5IRme42-o10LmJhQCEaP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 09:26:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6acd030f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Dec 2024 14:25:09 +0000 (UTC)
Date: Wed, 11 Dec 2024 15:26:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/7] refs: add support for migrating reflogs
Message-ID: <Z1mhFqmznVxObmAn@pks.im>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-7-d4bc37ee860f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-7-d4bc37ee860f@gmail.com>

On Mon, Dec 09, 2024 at 12:07:21PM +0100, Karthik Nayak wrote:
> @@ -2687,6 +2688,7 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
>  }
>  
>  struct migration_data {
> +	unsigned int index;
>  	struct ref_store *old_refs;
>  	struct ref_transaction *transaction;
>  	struct strbuf *errbuf;

Calling this `reflog_index` might be a bit easier for context.

> @@ -2868,8 +2894,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	 *   1. Set up a new temporary directory and initialize it with the new
>  	 *      format. This is where all refs will be migrated into.
>  	 *
> -	 *   2. Enumerate all refs and write them into the new ref storage.
> -	 *      This operation is safe as we do not yet modify the main
> +	 *   2. Enumerate all refs and reflogs and write them into the new ref
> +	 *      storage. This operation is safe as we do not yet modify the main

I'd rather move this into a third step, as it is separate from the ref
enumeration.

Patrick
