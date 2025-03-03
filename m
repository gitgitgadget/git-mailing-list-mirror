Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD41F0E2B
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997598; cv=none; b=W/D0l8UwgyppCFPKqYz670hfGcbBi8U+TKEb3xDF8zTB0RkMzqSYxBoQpnHhqZ8GgLC3AwFSEQTlJE1yK6YGLh1iospmDPiORY97d62E+48Mt9BaJ4yXTdoWHcyUvr+3H6xhDTdoAeP9Ts9XPTLAWcIybklWx8TCjKHO1xCwl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997598; c=relaxed/simple;
	bh=S6ICllEed19CvGeVDGQ0u3YZlFV81zvxfiyiRYjkiLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9IM/O+IagBhHMA+C/aAlmePm0NDBhxPgTILV/nH2PIy7JTN0SmURJeoEgHwoJ9k3hokJNHx+uTnO4tFH8MgU+oVH86SgQHvzzidYSbkX9CJiYrq9Vyv8TbjjluOnSd/h7GMqGWV+5DcZ39UX1xJqr3sFimMeWE7FjGOs4A6wE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nqUNSiHv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoGd85Wl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nqUNSiHv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoGd85Wl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3EA925401CE;
	Mon,  3 Mar 2025 05:26:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 03 Mar 2025 05:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740997595; x=1741083995; bh=fq52+yHq1S
	sWhS03s3xRav8hNp05zqJE42FemDTq35U=; b=nqUNSiHvMp6MyBl9qB8GzDPOIE
	A3U3mr4qbYl4KVCCp0p6MG/DYz+YUuLsQjgsnwfxrqlCgXV5B7ZWyOremIWKDoWn
	iuWsjte2WnKTbYZF6efgQSEDMEwCsHv2GcyjEisoxVadPGLF4FHFwnEh/u41jWX2
	SUfVUsHKHS+wAxN5aSQU30N6XXhEFSWdTU26D0TkR7Sr96GNNmMO3ukWpGk+y1dX
	75b9qcNylSoX1xtm5SqT9PG8deMciZvNWqTQ1nirP3eAN3hL4oPkvQouwPhqevzo
	aQB/OEm/ivSb1/fJN22xhj6/VtFy1NFcdX8yMvolIUbrwvRd87YwM9TbXnsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740997595; x=1741083995; bh=fq52+yHq1SsWhS03s3xRav8hNp05zqJE42F
	emDTq35U=; b=BoGd85WlXeXsfzmQgUY8RN1wdg+Ly3d0F8UqCU2Gcu5zINbtuxS
	l/MpKiJUa3E7edC4U0dkttvdt3u7uP8qYGoW9TlOV3632DpWvnesH6HvbY29K7HL
	fmCNLOIZUPcRZaRe+olu7uyamhXk2SnkkMhiU9v/h7vE25itRKc7h76OP+NR18Vq
	wIwb0XAHmLdQetTyOW0h3MIxu9E7fEBwVtOmHtGkPhuZ3PRCuVPlQ+2pDwUT98TJ
	6vTT96sO67tLC4CFqTNAfI5MQ08Bx0nBBVEEq4PqcYg5LAJwnfoI6gxyea9m97fH
	GhIPonxwH1El4K/R6NtgFYysLJ3Ov+rxbWA==
X-ME-Sender: <xms:24PFZ4Etcwn3vu_ohgTcAnIK7-oLszFwnp9TCnK-jw3nH_I4ilVHBA>
    <xme:24PFZxVizpnuB6U0JN5RNe7B967coUXM1gjuzuobYrS4a2GPXRKQNRT0sVAghFZwW
    lPn-GBz0KBjLt11jw>
X-ME-Received: <xmr:24PFZyL5uoFl45bV7qtHKNs48h287MamFilFby3CATi0eyeyGhytg1-doaIYQHIgtcnSHxF4dHqRk3Yo9H_P1AwjkH7Nce7SBKcYc5qIjPF31qAD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepuggrnhhimhgrhhgvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:24PFZ6ELrKRCE2bj4jfF67qSZtrXx3UnCSP23pU4tk3cCZATIRDDWw>
    <xmx:24PFZ-VdY0Imqc8PjiKU3h1M4NM3j-SsuJdT6H8OwwYtr6r5F1ce9Q>
    <xmx:24PFZ9NUrTAAf1OYJch9gph7EFETwYReiCBa8qa1ooknzNuDzMFVAA>
    <xmx:24PFZ11BJBPhwZzOnwzvQ1B9TBgjshChpm4DPDYYcvxfVZB2ly1fMw>
    <xmx:24PFZ9RhLiMR3RVSWqqJ8By61Q2AYoAc41d3Ur9Os5pqQtP95zhq-R_3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 05:26:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c8ff96d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 10:26:33 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:26:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
Message-ID: <Z8WD2MeHpOH7Ni8A@pks.im>
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301105838.1481-2-danimahendra0904@gmail.com>

On Sat, Mar 01, 2025 at 04:28:38PM +0530, Mahendra Dani wrote:
> test -e does not provide a nice error message when
> we hit test failures, so use test_path_exists instead.
> 
> Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> ---
>  t/t1403-show-ref.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 9d698b3cc3..12f7b60024 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -196,7 +196,7 @@ test_expect_success 'show-ref --verify with dangling ref' '
>  
>  	remove_object() {
>  		file=$(sha1_file "$*") &&
> -		test -e "$file" &&
> +		test_path_exists "$file" &&
>  		rm -f "$file"
>  	} &&

The refactoring is true to the original spirit of the preimage indeed.
But we could also improve it even further if we verified that the path
not only exists, but exists and is a file via `test_path_is_file()`. If
we decide to do that we should also explain the change in the commit
message.

Thanks!

Patrick
