Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C7211A2B
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547979; cv=none; b=lzWXEdEHPNmnY9/0MIfB/fcc4WNoW/P2AuDvAnJujB63fIYUGxSGKCdmGKEi4g9/ih/2N7tUbwLx3qGFrzy3/ma6tyQWFve7qrMXk8qsLtg/hNdgIhzYgEQH9dtdR9Zl811RlygwFbgUlwtl4SIsd02cov76ZevnlCXtSzCWreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547979; c=relaxed/simple;
	bh=SZor9YIdCdnfl4WOMW6WIAnrtPiy45SAGE/dCMMrgQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLJRxIByKM7qIPzVz1Q8KSGRuv87umabUGOJ6SgsSgIJtTiAW2/dR1wrThqrEwBNTohfJvyDzGgesaxQY4diCyyL5XVlYmGP1pGtgDPh9AI6gk5Ucd1yzlKETO3cnfDEOYWKYTeb4AMnVG/CWV4B3ZFOSCMu0LvLztReUZExKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g/iqgQJ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MRjcSV9f; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g/iqgQJ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MRjcSV9f"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 023B713801DD;
	Wed, 22 Jan 2025 07:12:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 07:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737547976; x=1737634376; bh=ByfnQp4MTo
	7ifqMGy3W4ROUOqZC6PD+pOhBIjtY9Ux4=; b=g/iqgQJ2At7gv9a181CSLHH9/G
	nCMc/om/5YfyoPcxYDiSw8UA3S1WlAGnR2bYGywF7pY+EnIYhdh0bMT6XOUwQSef
	EB3oDzjcKyn/Vcyz44+/loUxJxrbL0RPXMI53PWic2KQUaryN4a3Sgsaceotlp94
	giDmZ8M1QqejZ1THpFEwHroYW8j+homFi2crfmHwEDrTRLfvFEduUJghl0mugD9/
	kQ1otnwtvmVB1fQzs9ZciFhCFOe7Pja/SxRUXZJUa8PYpkQJ0HOxaOGOQO85P9nH
	1K1sfeazmmSxDYFYdkRlWPSmgZu5Af+XOLGhrhCTeLizGniu1jpX0yO5GfbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737547976; x=1737634376; bh=ByfnQp4MTo7ifqMGy3W4ROUOqZC6PD+pOhB
	IjtY9Ux4=; b=MRjcSV9f+Alg4DuOh/CKIZCRCjLJdsN61BIHKkjhWqShvxTDsmg
	tJWNVwHhzrQKi741x7vD8RwRSjJ6otMRQjeAYnm/2LkSvXhm9Fxr7VcDU+z5iK1u
	NXjmB27ZejtBdiuXJUGmPPuz6W28PUu7172YB+f4/UV8CvKXinPCkUnAz+733n8A
	kD+WCw/1vVJ16p9ytT6UcIGQtW5V2nvwcNM2G05c4vN8jYskyyO4rE80BFyP6z8X
	OJDKMVrMptBgFFyYzOhJYkgQNusq6m9/V96M4ZbqKz/O7XZ+BNSUERDN5eycXvW4
	W//J4XJHp2UY9Af1Nb8C5FiQZRbeEyLO/pQ==
X-ME-Sender: <xms:yOCQZ-ObZKxoRhmA1rJvURmOk1NpuJLtoXvDswh_T4m1WjVAcFxXFg>
    <xme:yOCQZ89tHqLVpAOJemclyBo7jfNcIBj5-7FVJR1L5q4EsfeHwLmFhbqFsE45PJibt
    L0nffjjARSOLcq_JQ>
X-ME-Received: <xmr:yOCQZ1QT0RFHvAJuESQvkj_ZVWZIsm--0uJnXflvsD-7GREJbtWeNT2b9xDqMeqEdFKh7Pdx6MiLdiU4NwC8O_GPgXkoIfH8O5pj2ifi051eemU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:yOCQZ-setlvnrf0QP0ixuMuRIy0j7v_CuuuA6A6S2zbm7yHHtNq0Vg>
    <xmx:yOCQZ2cQOjP07Pz2E3P7pSpA6g4RLj8MkGsM8Pxe79mq4rkZ0AaI9Q>
    <xmx:yOCQZy0iUOy7Ct4kuHxvJ6xkXv3sA9Xp3eJNJq3BsZs-QA212FIpiA>
    <xmx:yOCQZ6-M7Jamxf7708HXZ47P2mH74bRuXyY6XWQGHKKg3aO_jH7JTQ>
    <xmx:yOCQZ3ojWr9k_51ACdTzI_73R2I0JA_wMoLXESOAq67NRWDcKnR2ddlW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:12:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5d2d544 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:12:54 +0000 (UTC)
Date: Wed, 22 Jan 2025 13:12:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] reftable: prevent 'update_index' changes after
 adding records
Message-ID: <Z5DgxQuc2j_-5GHg@pks.im>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>

On Wed, Jan 22, 2025 at 06:35:49AM +0100, Karthik Nayak wrote:
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index aeec195b2b1014445d71c5db39a9795017fd8ff2..c3f0059c346edbe1ad543c9832959c6fc0aa9180 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -1369,11 +1371,57 @@ static void t_reftable_stack_reload_with_missing_table(void)
>  	clear_dir(dir);
>  }
>  
> +static int write_limits_after_ref(struct reftable_writer *wr, void *arg)
> +{
> +	struct reftable_ref_record *ref = arg;
> +	check(!reftable_writer_set_limits(wr, ref->update_index, ref->update_index));
> +	check(!reftable_writer_add_ref(wr, ref));
> +	return reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
> +}

Nice.

> +static void t_reftable_invalid_limit_updates(void)
> +{
> +	struct reftable_ref_record ref = {
> +		.refname = (char *) "HEAD",
> +		.update_index = 1,
> +		.value_type = REFTABLE_REF_SYMREF,
> +		.value.symref = (char *) "master",
> +	};
> +	struct reftable_write_options opts = {
> +		.default_permissions = 0660,
> +	};

Nit: it's unnecessary to pass write options. Other than that the test
looks good to me, and this nit isn't worth a reroll.

Thanks for working on this!

Patrick
