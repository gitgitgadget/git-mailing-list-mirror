Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA911DB548
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472032; cv=none; b=gFA6sYYIgkhogLa7Snv5jBdP0zwumEQckEV1w2WdnbyAU27+hN6RRxFRYc2p9AObDajIeNhFrqLlC6fRtQ4zG2kPf3993rfrxaBw8JntNHbo9BTkQxGJdQIOwF183ZGpv/H10v1arVbiVNGigAmfhbChOl0/X9auH7OU9pEJY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472032; c=relaxed/simple;
	bh=16dXLxYRLPYTPm6jM3AX0PrZJozKqBSi895t9Tdo0ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG53wDW0u60bsWN+mSwAGCjvafg4DGtnDV26g2dzrR3j1uyfgdVb8bOZM/RkFazV/Lv30XOLvJI/e731DxOCpL8EtmSFBK9f60a1ye2QbJBy3pb7/P7ei+TnCewAPtBEg22Z5s48kSRdVsR3rIWOT1/4D5z7TGytDp+dDio1GcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T6mTBKU2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gj1E0bFQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T6mTBKU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gj1E0bFQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B101114012E;
	Tue, 25 Feb 2025 03:27:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 25 Feb 2025 03:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740472030; x=1740558430; bh=AKun4jcVta
	yuyUmiCgsaEFG7EmvQsDP2r16p2tTKHtQ=; b=T6mTBKU2CK79U3eQo4UFlLuF0B
	dIJsoPiAWdQ0ghTZ6V6L4qYJ+UWCTPfoBRYOK9rrAyuKEjIRiFs/Sf/tiUvDMRXr
	mnbbwW41ockDbCzPJ3P47S9te4koSpCGUQ5pAMLg2pqQPAKPDak0m5EAc6y+ikeD
	H9GpSNuoHUD0CQQBMl9yq/76fcMOY8d2bBNfnzwO8fEKKvQbI88uM+i2TwbeZPRA
	wDRiUD22u4fsGeC5XxxnKD/Hr6wl078zk06j86YpGaL+vMCMQIcNtus5ZPc+rpdr
	3JecxFhUnnl/d46zJVKXCPlLy2C8cQtSrISpur2MlX6G7HVrRw8NvEIa9Ysw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740472030; x=1740558430; bh=AKun4jcVtayuyUmiCgsaEFG7EmvQsDP2r16
	p2tTKHtQ=; b=gj1E0bFQ69GssBw25L7KfYEWjiaQdNqcHCU4oHK6WdJR4ejoacY
	/ntBwNIcLU/6wTnGEdNl1M9L+YrsZ6mLc1pzeNUzGMkVBEmOPWWYFDuScdUxCWwQ
	ucTGmKOHcAnpgbTWT3CPvgGdpVTrMNKI7+25zjN1HQD/9nCHCDF+eBBJOyWcVXXo
	xw9U+NJNbf/RvG+KNnokPjpJiJNymLnwt1tlZYnyGKF82OAKj6SlJ2TPn+auJEEb
	j1yLA2NAMDGLHxnxUuyXvaY0X69RhWQpYW4Yw789Xw4sas0FHuM+WYSPJCBGmdnm
	mxzGlsbL2fNUJDEtGCQrv8LbY1tUaB0V7Gw==
X-ME-Sender: <xms:3n69Z4TLIvN4ZTQGOxn_-QpCjZNcUjrZ1zTZG6omSVz2HOF7_8-HGw>
    <xme:3n69Z1xbTyZ3ElOv8o6o6wzr61NTHK_1-xacPY-Gq7VfaOwbIxvCzYxl8uYLqwsjZ
    _CGXBt_N-ohbu4OFA>
X-ME-Received: <xmr:3n69Z13mDpTX04ltCeedCCFCqldHPqi7C488P1rl5k3IuVJkd9a0wFKjOh8iaUfAo2RSwuodCNLBZZWfq-c9Ozi1R47OslJEcHtms5EFcYn-Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdr
    vgguuh
X-ME-Proxy: <xmx:3n69Z8AP77Xj4p1u9GtpuAw_SeNnJN3N1XeTnZePPt2YwwnxqOF4pA>
    <xmx:3n69Zxj5M4BqaGRMAXsel_GCjw2OpGR5JVbyAsH5YSXAFd2yOMYVVQ>
    <xmx:3n69Z4o78zolGt2viPlDbKSmN4sv726Y8UuZbX_wRr5lqRKQdnsVgg>
    <xmx:3n69Z0jn46Ic6ofh1OzRTvz09aBLE64UIeJiZFeZHg03QqFoh_85Cg>
    <xmx:3n69Z_Z0JXtGO090y6RvPHdbqsFiSrhM54JSKVwWrpxFkmjhKeJTwpfk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:27:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3705ede6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:27:08 +0000 (UTC)
Date: Tue, 25 Feb 2025 09:27:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 0/8] add more ref consistency checks
Message-ID: <Z71-26jqJH7zea3G@pks.im>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
 <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

On Mon, Feb 17, 2025 at 11:25:25PM +0800, shejialuo wrote:
> Hi All:
> 
> This changes enhances the following things:
> 
> 1. [PATCH v5 2/8]: enhance the comment suggested by Karthik.
> 2. [PATCH v5 3/8]: use lstat to check whether the filetype of
>    "packed-ref" is a regular file instead of using `open_nofollow`
>    to check. And also enhance the commit message suggested by Karthik.
> 3. [PATCH v5 4/8]: move "open_nofollow" in original [PATCH v4 3/8] to
>    this.
> 
> Also, I rebase due to the conflict that all *.txt files have been
> renamed to *.adoc. However, I don't know whether this is a real
> conflict. But I decide to rebase to make the life of Junio easy.

I've got a couple of small nits, but overall I think this series should
be almost ready. Thanks!

Patrick
