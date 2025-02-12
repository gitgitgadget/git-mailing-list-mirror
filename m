Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB101E3DED
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354214; cv=none; b=VFmbHt9eaV/pBdrAJlxJ1W0zZVvU7PqfyU7P7HLABKsNEsQSIC+txAZe1CjuaCLSMB+BjDIPBIsBEQHN7dApXL3Z4ryPBp/OWrnVErAqI/eJlgvsK4/n4ORmKUa5xpQxBUqNSeQ915KMEIByXMm2RI1PLUEcQHMDH9vHYF0IoO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354214; c=relaxed/simple;
	bh=W1vg8Yc1eP5YHCmeeB7/AEO+QBPlZiKF0W/W26kmBLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq4b/RWeGhJIWP8nuo81jnt8sBfo2XQQiKkJ8UesT7/UdgyYLBucS+6e0luiFlJbX7rTQTK+vKAJUnEdc1ximivK+qy6rIZnnpFWQ77xCMgNyY14zU3BZBJ0A9wIwc/ndob+8RFBea9bOx08a9ByySMSmhsFV5A0dzF2sQXhT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hTmkZpGj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPLG8KMG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hTmkZpGj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPLG8KMG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D17A011401C7;
	Wed, 12 Feb 2025 04:56:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 12 Feb 2025 04:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739354211; x=1739440611; bh=tyhNQ5U+xe
	lc9nASlXIU3DtuYKtUL06Deq9ZZrQxxfw=; b=hTmkZpGjRf85h76deMokn+Lsq+
	K7wclPA9Q6HOQjmeRWqBRmk9OHeWx+je2zgNfH87UWOdVVlLEbMyOdK7uqDixL3j
	Iv6XZ5HORRXLlEZMaY1FmXFNTJsjBWjeUmKLJgD59PsUKAL5zRugRUX+mIefjh9K
	kG/827iYrXYXZNZQh2xWP2Ly9Ir43Tvvgcn59PtSzYouRZQx/rBU/KlWCxIIl8PG
	ubh90Qos06jt+FtSbB0nJS5uotaqgZv4EEboxhIbWJnzCLsciESgQ9gGX83TCtcy
	PNs3NFtVDTZcKOt5tyGxWD2nmMjEsPg01clRZtqHQKhdgnIUo3VeaaK5wcaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739354211; x=1739440611; bh=tyhNQ5U+xelc9nASlXIU3DtuYKtUL06Deq9
	ZZrQxxfw=; b=oPLG8KMGm1DpSK/U825DydFiIOeitCWtZzDGr4c4ug+Wem8H49i
	+9ACAk3COHviyv4Kjjd1CxDxV8IuCNVgQ1eMXQPK9D4jjs5QOTN6w2wDTD34AdRi
	/7krV6Ef1GQOhMM6b08KB8UPQViN2qY2t+DjILWoecVN2uDJSPJjvFt9dp1rU/jN
	4lOb7q9th0XLywd9//P2iCCXjOtI7rpjaIz5L6RwZXQmcWQtdqyrbsYnZauVief8
	FRT7yDBbY0RDYIfffQX1aND5Kt/3FwoMxaMnQPxsbZCo7Rsob0vV7YdjsyofwSsb
	oB1wgJT8Q6T73GfbpTussN7f0vk23xayK3Q==
X-ME-Sender: <xms:Y3CsZyXstya4AU4gg1TMTNvfCyNYfLvxI6RrbDjEbkTaG1xnMlmdDQ>
    <xme:Y3CsZ-nlisqoo4SN5AuofKMwj_Inkf7uShogUkczTanA0Sq9KdhElKuWwk8AbQEsX
    PLAqko7_SFKjCRQaw>
X-ME-Received: <xmr:Y3CsZ2aS3_8sVbDe0JHhe-5m1WzdssPneT-bjZyAnNS8fi8AFpbEUBMTOdk-1RgRqIIxD3043z4z7D-Pjbf2L-ecOL9JOqBs43E3jRqrPHYgzZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrg
    hluhhmrdhmihhtrdgvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Y3CsZ5VlpH7jSDkDi9wLGsNMG-tro_yIYygNaVokv57r8er-3t3zJA>
    <xmx:Y3CsZ8ni4rZpdAED_0xyp_tgfMpEabWUjYjfoGFohh8W7z3VjOCnsg>
    <xmx:Y3CsZ-fBjZaHyCt-im_o-4pn0vlK2fkXeugyBtzjMMyfAOdeZju9xA>
    <xmx:Y3CsZ-GqIvzO-xyPpzKj-mrM1ushhkd9GGALC0nAt9h0tVqNgiOE9g>
    <xmx:Y3CsZ7vyL5pkYyZhxSiRYoeEaMXYpHV7MIFmEZ-s5QrCJmC-5Qc4Rz8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:56:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e4e4f14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:56:48 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:56:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 4/8] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z6xwW0N7GG4NhCzZ@pks.im>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RPqE64ScsjzUg7@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPqE64ScsjzUg7@ArchLinux>

On Thu, Feb 06, 2025 at 01:59:04PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 6401cecd5f..683cfe78dc 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1749,12 +1749,76 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
> +static int packed_fsck_ref_header(struct fsck_options *o,
> +				  const char *start, const char *eol)
> +{
> +	if (!starts_with(start, "# pack-refs with:")) {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs.header";
> +
> +		return fsck_report_ref(o, &report,
> +				       FSCK_MSG_BAD_PACKED_REF_HEADER,
> +				       "'%.*s' does not start with '# pack-refs with:'",
> +				       (int)(eol - start), start);
> +	}
> +
> +	return 0;
> +}

Okay. We still complain about bad headers, but only if there is a line
starting with "#" and only if the prefix doesn't match. This addresses
Junio's comment that packfiles don't have to have a header, and that
they may contain capabilities that we don't understand.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 42c8d4ca1e..da321f16c6 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -639,4 +639,29 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
>  	)
>  '
>  
> +test_expect_success 'packed-refs header should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +
> +		git refs verify 2>err &&
> +		test_must_be_empty err &&
> +
> +		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
> +				  "# pack-refs with traits: peeled fully-peeled sorted " \
> +				  "# pack-refs with a: peeled fully-peeled"

Instead of verifying thrice that we complain about bad header prefixes,
should we maybe replace two of these with instances where we check a
packed-refs file _without_ a header and one with capabilities that we
don't understand?

Patrick
