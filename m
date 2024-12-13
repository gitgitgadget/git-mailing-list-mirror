Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF401DF256
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092685; cv=none; b=kbwC9YSGZvR8l84S2shGHqqhDDGwtB62eW479bQhjz3MAH+QsySV4KUXyMQkrIp1xvQ0pOSGwhatBYFEOySjlEvJENwCRinu7N+MJh4TY6PqsoMRp/vB1Hi8ryjHk/xmTUs90e2KCWmB8OOgNNfwR6g1Nh1ws8FpNNNAKQ7Y3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092685; c=relaxed/simple;
	bh=DlkPw7ku753Am15BvjI9rGXH2yWkDAsY/maG/hVLD/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnwQtZCGa7/eO6H6TQmdX8kNOpCxL84bItu4qpmPRc0uB397fYb1A8cqQtwEpSazBorzfA8GY+Pp3fcvx/YAbAXvLALzIv6hBfsssIJlBtjhQV2CyWZ23HkWMSNSF8RiHoqmxyR0lgJKTsUSVz+PW5f1y8dEomeoC2yEGy8ZLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zylp5Tu2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CMrY4Y7a; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zylp5Tu2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CMrY4Y7a"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57E99114015A;
	Fri, 13 Dec 2024 07:24:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 07:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734092681; x=1734179081; bh=rddz5lVAX7
	eKmrCkpku6ncXdr0xc9Q1fJV3VchBsN9A=; b=Zylp5Tu20vOFVsgEl/PeihnUp6
	KTJXKz8J/8yOUxGwZJkm33wZPagwKBTVzIK/XFe3DB/HYC95TZFZMX8cC51Hg8I1
	PKmQas7eSn/BzzzxBVD+79y3/FTYK3Z4TVZLsWl5CSQ2DyI9AVami21+neFTmFr/
	GFTUytT/oZcWXQ/nBZqLP3Q35Sdh2FP2WFolujDJtq4gjqIo35Zvgl7ucNAJZiYs
	7E47L1HrYUh0yrbYqJQhlWUsGQRhnes8VrdAppXRvfb3XbX2mPaeBBLSY65tO9LG
	pWnSVXZiCkWqgJdCJNOIGhEhgiQYichxGc/a0d4QmhvH19r9X/woTTJYGK/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734092681; x=1734179081; bh=rddz5lVAX7eKmrCkpku6ncXdr0xc9Q1fJV3
	VchBsN9A=; b=CMrY4Y7a2e+rTNmM/veXZuJvMXXOtdO3jq0JIttr/C5B9CesUih
	3m/zU/GrppXS1GMcdd/yeCpDpMpwxjycqsInbwiNQ/TbkAjV1xAry1p0x7vws6fS
	3nrjwh9RfNVKMDnTs6So/5RWf8uxtrqWw/AAoEWQ+EaV5e3EqiLJQhVKup2PQiTJ
	/1q/4Bs/E07ahD8T9D29tAMH0w+/4iB6gc0+VzN+Txj201yNbQC0hBm/ckmXdN7a
	0c79TJBaKIaVpPLtkmMcWldKgdW23px5weJQC5rZleqElEGuaaxMfOqR5/dKwvtl
	f1jmbgqrxThjXayyKneyhjlgOlwTjHFI4/g==
X-ME-Sender: <xms:iCdcZx9ZX9uGbH7N5Hbj7NGjkbjWHAmkfIutcypwcpKQLhKX3WLArg>
    <xme:iCdcZ1voNGQLl9ExRLrRoYq3SgTUWl3-jI8gS9Uy94mszbUXOOviWn31Kj1GF7my0
    IElYBiyMAacU5ihJQ>
X-ME-Received: <xmr:iCdcZ_AIjUh1PIUzO6RsvUA8FctVasxiRQatMSaoY1Y2Gde8nr4R8oiAiCCFMVFDBaxeXHxlto8BcfhC551D_uX7jiVkf09nZmWl6t5lOjlSWMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:iCdcZ1faNzzXnEJFGAvsf5HwwgoBRJ9RgmiclDzIC-rnjmC7K9SYqg>
    <xmx:iCdcZ2PlacgbqyidDH5NkpuOYixYE_nqMF0ebihPzLd-Kedw3tg0hA>
    <xmx:iCdcZ3k5WEtEVrU79ToDpqEW-vG_tuRO1fiJ_1pQZgM7HeKXkyuo7g>
    <xmx:iCdcZwvAXLS8FvYuL1MBVLjm_x08PflcD08cEkFtooFZ0m4VH3VExg>
    <xmx:iSdcZzr1Nt23p8MDF1p_cA0VJf9cjRbi2theofbq5moSJLrdU2oT5i14>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 07:24:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0fcc342a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 12:22:59 +0000 (UTC)
Date: Fri, 13 Dec 2024 13:24:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] refs: add `committer_info` to
 `ref_transaction_add_update()`
Message-ID: <Z1wnbCoidG-lC7ui@pks.im>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-5-f28312cdb6c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-5-f28312cdb6c0@gmail.com>

On Fri, Dec 13, 2024 at 11:36:50AM +0100, Karthik Nayak wrote:
> The `ref_transaction_add_update()` creates the `ref_update` struct. To
> facilitate addition of reflogs in the next commit, the function needs to
> accommodate setting the `committer_info` field in the struct. So modify
> the function to also take `committer_info` as an argument and set it
> accordingly.

I was wondering a bit whether we could instead pull out a
`add_update_internal()` function so that we don't need to modify all
callers of `ref_transaction_add_update()`. Because ultimately, we don't
use the field anywhere except from `ref_transaction_add_reflog_update()`
as far as I can see.

This is more of a thought than a strong opinion, so feel free to ignore.

> @@ -1190,8 +1191,12 @@ struct ref_update *ref_transaction_add_update(
>  		oidcpy(&update->new_oid, new_oid);
>  	if ((flags & REF_HAVE_OLD) && old_oid)
>  		oidcpy(&update->old_oid, old_oid);
> -	if (!(flags & REF_SKIP_CREATE_REFLOG))
> +	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
> +		if (committer_info)
> +			update->committer_info = xstrdup(committer_info);
> +
>  		update->msg = normalize_reflog_message(msg);
> +	}
>  
>  	return update;
>  }

This can use `xstrdup_or_null()` and then drop the condition.

Patrick
