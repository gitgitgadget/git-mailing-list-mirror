Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43D1EF38E
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522152; cv=none; b=iicPZS7bzlqpC7q8IxWY4xdHAQDYyTNt4J9K3LLgG5CBAJIiLgXILLWUwM9p+Fx3mw00CzL+dYw5DcXDaerjnwqHbBgF+MMQu2JafwIP3Vs4QNB7VAWQKTBfLWerr7t8hsaiVDlW3NFKEsucKzABPz35igGFdamFLqKC0SH5jhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522152; c=relaxed/simple;
	bh=7LCJXab3kxb1f+ieY/FbMdpbgX7zEqkCT0jTonX0SeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6McL0Ouj6QZJFcv604rbxHFjgDR+v7pykAWINU7wSjFrtDrXbNnxSZrUS8jEKnP4EVt/P8m63YWNFWbsLKjHdSOvLU9ysYcrvAZPAn4kzCpA9CnJ/mG09go3v557VG7F8Wazn80N5hmWVzBjy8CwfdSKNUDOtwBNX36y/UM8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pezNkwSZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axIIAkG8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pezNkwSZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axIIAkG8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C52B7A024E;
	Thu,  3 Jul 2025 01:55:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 03 Jul 2025 01:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751522149; x=1751608549; bh=bnYnFmMTDB
	OrvA/Y5RRMNWSOfZue+LDEwZkg/3Z3vxE=; b=pezNkwSZk5RdTHiVpAyvTmaByo
	OmnpYTqFBHmBWHX7YebmHGV5Yv4yDwYIummC+/5QNDj1w9T6hzi8A8bDOuj/cXrk
	A45whyHt5rscU+FFeMY492FPcpZeZLFT7rGKTXlwlEo1i3HSm98zuomQP7qfBpvP
	dQOao5zG5q+IYHqn6ufLfGx9tB9Bz/enA1jpcqEp5kiw3d0NEEigTCgYmZczUlLV
	PiMsrD9WQSABijE3TwuW5elcp/lzZ5M/ZQDIsiUErenZj46gZvnw2OdL2+JK/zIo
	YMfAZ+W1uiIZVbxBEbKZ7x/XXYnYFKSwGda8hYbdHbnXfTHf7368p1NJJoLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751522149; x=1751608549; bh=bnYnFmMTDBOrvA/Y5RRMNWSOfZue+LDEwZk
	g/3Z3vxE=; b=axIIAkG8nHHG/RelR4z+Mb0RPDCB2A6cBd5lfKL72+416chl0b5
	kaw247XqGhQlo8oBLWJSfbcD2yGU7wuGuNXOX/7dyqPcIZj9nfT8cmdA4H80di+a
	Jp+JAWGrh4CciT5tCCaB0ggiaNUyjcpG4nQbgMC2dQcNqIn4samUtT/6rC57YkSe
	2rZfz7pYd/fm5R4vjU4XYUE/4WlRxghaBLFIkwOma56ycOFoXE0Ui6AJpiClWICA
	Ce3prmXwp2evxLR1zTYwbmpSzuUeJNBlE6smk8o15VxVFCollCHYpyk5/9vpoXCk
	gY35R5jHUAL/7ghIHWynJuL+mRCrGDB6gwg==
X-ME-Sender: <xms:ZRtmaFxZnCxMBFQM4CeONfzG2emv2h4mBIemKBbxKzaiHcqiiYX87g>
    <xme:ZRtmaFTQoOdvlZITZrk5edQCI5V7zpFYv38yF9l9wmuLqaQ59NlVfW5rRZe2nnygF
    SOIVSzFYZGxnodp0w>
X-ME-Received: <xmr:ZRtmaPWDdPdjAfKNnSG-6VAYBxObDFu1cHZIKy9MhQaa4V7owuAcGkrQjNMHX87-rcWyUowBLRFVUH4JAT7HchGyjk9WdUdViCF2OGfetg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZRtmaHi56WsqjN4QztsCYa90_CND9CoY3r33vDXenD7k_A4ZzFrZ6Q>
    <xmx:ZRtmaHCMCTZWT0jaUZaKekupjhoo2c2U-gDJiCOvp2rH2jaeo8HrnA>
    <xmx:ZRtmaAIIZK7m-CdUeBaoIgkrVFwJ8XGqp02zJacDF-nOkHRktKUfkQ>
    <xmx:ZRtmaGDGPrDAXXjg4yEzDwokPE-d_isxEzU5MoN6j6rVbnzpXr25qA>
    <xmx:ZRtmaOdkG-1IsE754MnWrkwPTNrl3r0g27ZGbkyQCNchWyyPzrVXmekq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 01:55:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f5b39e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 05:55:46 +0000 (UTC)
Date: Thu, 3 Jul 2025 07:55:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] refs: selectively set prefix in the seek functions
Message-ID: <aGYbUpC9OEd90J4N@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250701-306-git-for-each-ref-pagination-v1-3-4f0ae7c0688f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-3-4f0ae7c0688f@gmail.com>

On Tue, Jul 01, 2025 at 05:03:29PM +0200, Karthik Nayak wrote:
> The ref iterator exposes a `ref_iterator_seek()` function. The name
> suggests that this would seek the iterator to a specific reference in
> some ways similar to how `fseek()` works for the filesystem.
> 
> However, the function actually sets the prefix for refs iteration. So
> further iteration would only yield references which match the particular
> prefix. This is a bit confusing.
> 
> Let's add a 'set_prefix' field to the function, which when set, will set
> the prefix for the iteration in-line with the existing behavior. But
> when the 'set_prefix' field is not set, the reference backends will
> simply seek to the specified reference without setting prefix. This
> allows users to start iteration from a specific reference.
> 
> In the packed and reftable backend, since references are available in a
> sorted list, the changes are simply setting the prefix if needed. The
> changes on the files-backend are a little more involved, since the files
> backend uses the 'ref-cache' mechanism. We move out the existing logic
> within `cache_ref_iterator_seek()` to `cache_ref_iterator_set_prefix()`
> which is called when `set_prefix` is set. We then parse the provided
> seek string and set the required levels and their indexes to ensure that
> seeking is possible.

That solution makes sense.

> diff --git a/refs.c b/refs.c
> index dce5c49ca2..a4220d3537 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2669,7 +2669,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  			if (!iter) {
>  				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
>  							       DO_FOR_EACH_INCLUDE_BROKEN);
> -			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
> +			} else if (ref_iterator_seek(iter, dirname.buf, 1) < 0) {
>  				goto cleanup;
>  			}
>  

This is quite unreadable, as you have no idea what `1` could mean. Let's
make this a `unsigned flags` variable instead so that we can provide
meaningful names.

> diff --git a/refs.h b/refs.h
> index c05be6d0ac..c5e08db0ff 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1300,20 +1300,25 @@ struct ref_iterator *refs_ref_iterator_begin(
>  int ref_iterator_advance(struct ref_iterator *ref_iterator);
>  
>  /*
> - * Seek the iterator to the first reference with the given prefix.
> - * The prefix is matched as a literal string, without regard for path
> + * Seek the iterator to the first reference matching the given seek string.
> + * The seek string is matched as a literal string, without regard for path
>   * separators. If prefix is NULL or the empty string, seek the iterator to the
>   * first reference again.
>   *
> - * This function is expected to behave as if a new ref iterator with the same
> - * prefix had been created, but allows reuse of iterators and thus may allow
> - * the backend to optimize. Parameters other than the prefix that have been
> - * passed when creating the iterator will remain unchanged.
> + * When set_prefix is true, this function behaves as if a new ref iterator
> + * with the same prefix had been created, setting the prefix for subsequent
> + * iteration. When set_prefix is false, the iterator simply seeks to the
> + * specified reference without changing the existing prefix, allowing
> + * iteration to start from that specific reference.

I think we should detangle this paragraph a bit.

    This function is expected to behave as if a new ref iterator has
    been created, but allows reuse of it
