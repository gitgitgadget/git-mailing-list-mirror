Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9421423C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865614; cv=none; b=o4SnnNQvuHJs0zYgflL45XHQCPBdX6Q7+AbevPJ85tbmRi7CfYKTJO+9qQtzv1J7CqlVMB0LLSgt01sUj2ikOSIWjG8WS19rsdYzstl2BPNJ1vAWnK+RVj6Wpa+/p1hylkAAuB7l5Og4EEsglTnEgzVyBvksYGD/qKKfmSwHb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865614; c=relaxed/simple;
	bh=L6ZCQOz80WAReCdxkXntRmw1vQKcIZoVf2wd5Ot/Jdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu8clsBCa02ZxU4m3d3Ka1y83MXIzUgiCUqNtqsqeKDwXQih9x0rrergvH4UmMo5O7w/oxVowSXTF5kybrhm7Z3iwH44/duCDJf8Y0DDDo2f4h8eKxgm2GsA+dhaEIjSXvjkqNzkm+xFQf6IeF6UChZ76HZAIa/zUGlNdBw/7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cCz/gtx/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eb3hwXvs; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cCz/gtx/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eb3hwXvs"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF7AD25401A9;
	Mon,  2 Jun 2025 08:00:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 08:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748865608; x=1748952008; bh=AkRnGl9ZEY
	cVwFysJHlfCK+28iFVtRcUZ8o67QDVr+A=; b=cCz/gtx/WIPvOVciDgOXITGeLl
	t0cBdCjnzWrDhTO6nV5B2MORg4IGBGVqglY/aTWkNC2ilBh2upath9c+LLOlQmpc
	3cI/DmzQrVkr78w2lFWkulTUybkdD7k4RrFnjdG+4wJRsa9NivOMcEPEfVTla0Ax
	Q/dGmaQ3qVTr03T5H4GJZ0eptV58WWmD4xw/SGjSyOfB4haprNYTO2Uxvev5Pxqr
	NP4hgbDBIwVjZbBsOFbAZ5aS6KysAZFhxk+Ur7yBqXV5wMml/P8i8PkyN7d/aCjK
	NHN0lQOIC+sUQDNSjR+amFATfCd4Ty1w3NLFdtjSGntC1f8w0ELgyjriaTvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748865608; x=1748952008; bh=AkRnGl9ZEYcVwFysJHlfCK+28iFVtRcUZ8o
	67QDVr+A=; b=Eb3hwXvsTfsyX6fwnfE0vQ/JAXRqS9+U3aXNju7QHJDt9Oa2I8Y
	te7MnTfxl7O+YwX5zGc7V178J+k0KfmO6WnPWWIev9sjFvF6rULYoXgPmcCxLcaM
	cajrtkVss15wN1odNjpXW3RCy7+Uufx5+ghXPAxWGlDJTXT0isMeu+4wXnqudo+g
	A7A5gTbcFxiZPprqoilkQokz9A7gQQ9AI4skHnngKNz8X6HfgJEyYCsMZ9NVpcFB
	eE/Y5p6BBcCxwJ8W4UcYP/LLyzd5q+AB4+4AdrVCImJbCVpN6y7BRh+JQCh2BA8V
	XgGe8YHs2u/zfmBpU5/bb8GT7IbLL888+mg==
X-ME-Sender: <xms:SJI9aIJJEb9aJrC3VQaOPSJzdcMG3qjN61u8Sf4Ta_aqdFXLgnZW8w>
    <xme:SJI9aII0NarTpJ4IWB2OVZ8giIQ_7g-2OXfp0khT_-T2OkpVEIYRLh1rKbbucxJyr
    Hr2UV3TSPjut0BM4g>
X-ME-Received: <xmr:SJI9aIt_DGFy1zn056yNVGeYJc_VqFOthnLJNGsRcVyp8YBRe9cWr1Hpe5FePgAu12MROh_xUP40lVQOMKrLJHaw6M-UnVyDn6ii_Hv9gJtpSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeeivdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SJI9aFac8O_cdZQDNzhaQvC3oRI0SYK7ozh8B7u2nbippHt1oTLUlQ>
    <xmx:SJI9aPaYc0XCzF8MxYcF6X2ZPD8hcm1Wlk9-fpxitBtVEGP2W60Dbg>
    <xmx:SJI9aBDBU0VRTAU07LaME6Ux4pweHbIXum8i9sTbdFXH53lbLTiAhw>
    <xmx:SJI9aFYlexFfEyDzX2bQGBev8a2gdy59VeOkkn69mTY9DgCoNnPtSA>
    <xmx:SJI9aAmcQ6q6GiLJ6sshAQYZ8X0f7YKlWip4lowKh0g2hJ-Lh_YEPcP6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 08:00:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0068b7c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 12:00:07 +0000 (UTC)
Date: Mon, 2 Jun 2025 14:00:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] refs/files: skip updates with errors in batched
 updates
Message-ID: <aD2SRmlSKZm8g8kn@pks.im>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-1-903d1db3f10e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-1-903d1db3f10e@gmail.com>

On Mon, Jun 02, 2025 at 11:57:24AM +0200, Karthik Nayak wrote:
> The commit 23fc8e4f61 (refs: implement batch reference update support,
> 2025-04-08) introduced support for batched reference updates. This
> allows users to batch updates together, while allowing some of the
> updates to fail.
> 
> Under the hood, batched updates use the reference transaction mechanism.
> Each update which fails is marked as such. Any failed updates must be
> skipped over in the rest of the code, as they wouldn't apply any more.
> In two of the loops within 'files_transaction_finish()' of the files
> backend, the failed updates aren't skipped over. This can cause a
> SEGFAULT otherwise. Add the missing skips and a test to validate the
> same.

Curious -- we do have tests, so why don't any of them hit this issue?

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c  |  7 +++++++
>  t/t1400-update-ref.sh | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4d1f65a57a..c4a0f29072 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3208,6 +3208,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  	 */
>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *update = transaction->updates[i];
> +
> +		if (update->rejection_err)
> +			continue;
> +
>  		if (update->flags & REF_DELETING &&
>  		    !(update->flags & REF_LOG_ONLY) &&
>  		    !(update->flags & REF_IS_PRUNING)) {

Ok. And the reftable backend doesn't need the same treatment? Probably
doesn't because we queue all updates via `queue_transaction_update()`,
which knows to not add them to the list of updates in case any error has
happened. And in `_finish()` we iterate through that list of queued
updates instead of the global list of updates.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index d29d23cb89..e9a605d0ba 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -2299,6 +2299,20 @@ do
>  			test_grep -q "refname conflict" stdout
>  		)
>  	'
> +
> +	test_expect_success "stdin $type batch-updates delete non-existent ref" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit commit &&
> +			head=$(git rev-parse HEAD) &&
> +
> +			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
> +			git update-ref $type --stdin --batch-updates <stdin >stdout &&
> +			test_grep -q "reference does not exist" stdout

We typically don't silence the output of `test_grep`.

Patrick
