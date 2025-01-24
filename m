Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05461DBB2E
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705716; cv=none; b=I7q68bF1p/Un/5mM/PUiHqxdSo83yUvR2sUcT7FKxq3MPikI1s8nY8VTWMjki7NoC1+ZASd49G7OzkHM6vUTMYV3NWy/2ZXrUVgqj/txx9MyBt2RzJDf2rlZC3BOV1RXhmRFPbCO+rg5JuvFZgoYdOi7ltKuXoI/gpLycTZlZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705716; c=relaxed/simple;
	bh=OKAkBj7OVr2zE+43r0q3RZw2DTyDgQ4BNTHQ5L0u7Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp9rWG/kUSVDeo8resBjbdft9X4P7AcQjNTp3yjmmrCqNjh7iPF1JnH9RVu+LZe+1EG0JFkxVw47tsEwI0pyzciRFeudhOTGPoi4d3zk/ePqfLVguiFE8iOOujVzuYzRZcx0mSUjuaV3mKyl2Q9uLl7i9f/uYIuOT1v+Aq6kkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YGDKT9bd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cKrBCI1j; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YGDKT9bd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cKrBCI1j"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 857C11140142;
	Fri, 24 Jan 2025 03:01:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 24 Jan 2025 03:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737705713; x=1737792113; bh=xwE5Q17uom
	zurRKbghEfcVUWzTA4jlQIdHkE5Ft1BSw=; b=YGDKT9bdgY6BnCTOFYgok40ReV
	PAzB3RMdJVUVCSySc9Bh1o3DJpm9y6V+j3u3cER9/lxuVleILbJZlitLNMiFf0bu
	99gBPReOp7PHiYmSvc6eib9w2TU0l7Cq+4S1LR5XFRNbSCeDOXkwJQy/NsuoDCh/
	k9ZhOhako6ikNOfwWw8UJPJSP0qjQosH4UoSHTkmfPRf3xX/Kf7hCKS6PBQ6kFbC
	VZyTi5jN4eA97Tl2kcG+TpnAaYxL/l5+LauV3g5Hv6e8tmZEeacJikIgqpR1xTqJ
	bi8TXUHOjNy6qsDWmVNkttcrAIZvnNX7mqhXl2J8/Sjdcy0tFb/BiSHc31+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737705713; x=1737792113; bh=xwE5Q17uomzurRKbghEfcVUWzTA4jlQIdHk
	E5Ft1BSw=; b=cKrBCI1jPR4Kxd2nSztMtF59+mp8MK0guMrhwp2E05I+4JP+hU0
	ot7SMKuf5gNaNpeD14A0b01fOU09ZyLndCS5J9BGJXRi9NBBgerJezQWX6gTsUEP
	FfY5UCttyK8nkO8vXuhz7ASHvKKZtJXpUxym+HypYwaOhsDJy2besEYgo9rRBWiu
	kQHKAptWcymOrZUqOk+XtI4/UCeAb64u2X5TeXLF/wMlsLzv47Vanv7jTSs/iRHW
	mCebSPVJswqvriXRFkHe/2MWcvizy44rGlxKVmylsSkOwJoBnkdRoeKXOMw9I9kA
	uXEj/anoZpvJWMVrkyrSxRdW4cloAobn2ng==
X-ME-Sender: <xms:8UiTZ-zQQ7TyqW1S-zJlc1raLhdjD8gMpghCgfYUYtAwsvQjttfHWA>
    <xme:8UiTZ6QYGjgEtURqQWkde8L00M2cLpUHqBjcUtZgCq1aiUZIj6Z761d32hIKF5ZE5
    CqdV8yRtFyxXNhO-g>
X-ME-Received: <xmr:8UiTZwUu0DvnGcKceyuRkyeqB9x9ZyPqyMYF1X2H9dMi4A0OvpRb8_Lr1IJSPkqh_WjH7WzaCna2wsGDmj_4zfqTrOF65ZgzdQlTyRZGhVFudQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhhuhgshhgrmhdrkhgrnhhoughirgdutdesghhmrghilhdrtghomh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8UiTZ0iCe4i5fsLZLUiHtqzqJy0B3oyEAe7lKd6LBHfaq-i7v2yICQ>
    <xmx:8UiTZwDtRtrbabmg7faw_H2G04-nrr9lvPho0k2pZAmu4vHx3o22gQ>
    <xmx:8UiTZ1KFB6ZMsqmDMq_GJ4QXHUSrQ6Neyfz0VA5CDnrVxQ4rgf8STA>
    <xmx:8UiTZ3ABMenM_3Ul1Q5SSc_5VbnqReLftXqkvAwKh52zLsjCIxRHDg>
    <xmx:8UiTZ-ATiw_lWUBFVkqp3T8yml4-USxo3LIbFnAkUlQ6PsRld870YKeu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 03:01:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95f129d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 08:01:51 +0000 (UTC)
Date: Fri, 24 Jan 2025 09:01:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH 3/3] refspec: relocate apply_refspecs and related
 funtions
Message-ID: <Z5NI7vQ66aSCgjjg@pks.im>
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
 <20250122075154.5697-4-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122075154.5697-4-meetsoni3017@gmail.com>

On Wed, Jan 22, 2025 at 01:21:54PM +0530, Meet Soni wrote:
> diff --git a/refspec.h b/refspec.h
> index d3c97bfdc5..294068d226 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -86,4 +86,12 @@ void query_refspecs_multiple(struct refspec *rs,
>  				    struct refspec_item *query,
>  				    struct string_list *results);
>  
> +/*
> + * Remove all entries in the input list which match any negative refspec in
> + * the refspec list.
> + */
> +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
> +
> +char *apply_refspecs(struct refspec *rs, const char *name);
> +
>  #endif /* REFSPEC_H */

Same comment here regarding the documentation of `apply_refspecs()`.

Patrick
