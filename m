Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53244205E28
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352235; cv=none; b=FcNvUzbpJsO/DTzWE8XnN5AiijqOfomEP6Ol0/FxAbuVLbt7hNYAMLNHsML1OEwJtyfACrkluqHfMyvxwUdRfwwI84obIOwcTKW2Xfs5Zt75PYg72l4NFzLGUu3r10CduVxYymgbg5IBS3JnamyFg7vVZe2CMy5MftCJzI34KZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352235; c=relaxed/simple;
	bh=E4fN54Owv1Q2ZnbHXCJ5YWYC8Pz8TgRUYamu/89fQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDuso6M3zhxQY1zQHfJi2YjnpByjrJAPOPqWYK6jW9/kMMWR8XopqHus+FkR8NGCbtnFVATGdcR/NPKTROAkP7/ws7abgegT38jOlVsS4j+NojrLEfBnJ+V2sbiQqhz8ESrkiGgcsnpE3jOudd4BsyjhZQMsTEQU3BnRh/+Iw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B1HTl8G7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsYvKZfw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B1HTl8G7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsYvKZfw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F89A1140133;
	Wed, 12 Feb 2025 04:23:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 04:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739352231; x=1739438631; bh=KfNe6LT0ur
	xPrs7iyA8v07MHTLlsSGpfLeUVPTMRnaA=; b=B1HTl8G7bygajh/dFOrnlnrqOC
	Qj6HChrC5hyCpr55E7DGA/0ulSI6TCHW4cftZSZYY9+cn3n0wAZJ669fzOquthu8
	SnASx5vGvtnSjbvLfHxhkcJfq8FiWtrO0LPqWfGURoXKSCm1mgC79eV8FeUemGVY
	rXLlkMltOGTZeA1FltR8Vt1pviKmmdEYDb+5uOfnmfv4kmVf6XTf9qLg2pzmJeK4
	GKZ56yqMUyrdd5p86TDobpIW+lCwLdkYAX/fJMvOh4bIGDk2WNW7gktbWFKb118G
	zlaTIR6oYXfDkDSsgPH4wDaSXMwDi9VG0hNkE7LTyWlbtjpJh8tpnLtrkC3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739352231; x=1739438631; bh=KfNe6LT0urxPrs7iyA8v07MHTLlsSGpfLeU
	VPTMRnaA=; b=SsYvKZfwLicrdzRWmEA8UngttXHqWqheUqJngU1yXIY6XwjWTZn
	WKYrd4KEXhyJvkWTTk8tXo7Uu2nMEqjY+XnIWzfho60D3ofqcP5tPzG8JQx+x0a+
	DHwQ67UahmIBhxT2kno8LdyqErR8pvZ54hRYEgERz98RKMqpy9iQFp2CqpWJ71Jn
	HvRgyabvuachWa9UzlpPsn0MP/Juw1VPnYyXrEcEOYCiQ7u/F+tGejIh//fyJIdw
	HW2oMFCmACMuRQShzBtYRLPqKVtemCYtElmankyljiETCnpHWA0tLGAg/z6XVPcm
	2lbSmg4lHieEtltHhy7R3JvZiHM9lF4IG3A==
X-ME-Sender: <xms:p2isZ_-9nC7tU69WM6i6P9GtaWterCG_NvxjC9UuSmZzdP55haJSJg>
    <xme:p2isZ7sbejybr1p_pZJfzV71jO4eIC489r7gc2PULkqrrTZXAGX1qCvIrqJ9OnNP7
    3omFpks6x94QTO7KQ>
X-ME-Received: <xmr:p2isZ9AorCZMp421KGROVZ09EU_b0-vWn8sRbwCQOqEusmnzyrS8z7D01bbuLRgZThr6Zd7ik4nggGTuV_h5oHhiLdH4I8oTc6vlp-5lUKmGQqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:p2isZ7esm2j2Bz96EYcPhoavZD1WA9Ce_-WD31E5Xn0UlHRSlZO2zg>
    <xmx:p2isZ0O4bI7L-KQ1CrOywyzO2E63_On3ymGCU72nlOYQcY7dlniXZw>
    <xmx:p2isZ9lCgcq3ELV9QrCP3Fevuoh6yB_SYnjZ2YZFkOvMB9vB1-zBYw>
    <xmx:p2isZ-v9wZvDC9lftYkeSoaXFcA65iYjoTcwigf_4TApfNl8mmQTUw>
    <xmx:p2isZ5rKM7l94YLC333Tc9Viz9fWbKvOBFjCjnqftev-oBB4qKsLR1oi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:23:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27e2bc61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:23:49 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:23:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 3/3] builtin/diff-pairs: allow explicit diff queue
 flush
Message-ID: <Z6xopCvDXlX82lQ8@pks.im>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212041825.2455031-4-jltobler@gmail.com>

On Tue, Feb 11, 2025 at 10:18:25PM -0600, Justin Tobler wrote:
> The diffs queued from git-diff-pairs(1) stdin are not flushed EOF is

I think you meant to say "are flush when stdin is closed" or something
like that.

> reached. To enable greater flexibility, allow control over when the diff
> queue is flushed by writing a single nul byte on stdin between input

s/nul/NUL/

> file pairs. Diff output between flushes is separated by a single line
> terminator.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/git-diff-pairs.adoc |  4 ++++
>  builtin/diff-pairs.c              | 11 +++++++++++
>  t/t4070-diff-pairs.sh             | 22 ++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/git-diff-pairs.adoc b/Documentation/git-diff-pairs.adoc
> index e9ef4a6615..33c0d702f0 100644
> --- a/Documentation/git-diff-pairs.adoc
> +++ b/Documentation/git-diff-pairs.adoc
> @@ -32,6 +32,10 @@ compute diffs progressively over the course of multiple invocations of
>  Each blob pair is fed to the diff machinery individually queued and the output
>  is flushed on stdin EOF.
>  
> +To explicitly flush the diff queue, a single nul byte can be written to stdin
> +between filepairs. Diff output between flushes is separated by a single line
> +terminator.

The same comment as for the previous patch applies here, I think we
should refrain from using jargon like "flushing", "diff queue" or
"filepairs". These are internal implementation details that the user
shouldn't need to worry about. Instead, we should be talking about the
user-visible effects.

> diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> index 08f3ee81e5..2436ce3013 100644
> --- a/builtin/diff-pairs.c
> +++ b/builtin/diff-pairs.c
> @@ -99,6 +99,17 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
>  			break;
>  
>  		p = meta.buf;
> +		if (!*p) {
> +			flush_diff_queue(&revs.diffopt);
> +			/*
> +			 * When the diff queue is explicitly flushed, append an
> +			 * additional terminator to separate batches of diffs.
> +			 */
> +			fprintf(revs.diffopt.file, "%c",
> +				revs.diffopt.line_termination);

You can use `fputc(revs.diffopt.line_termination, revs.diffopt.file)`
instead.

> diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
> index e0a8e6f0a0..aca228a8fa 100755
> --- a/t/t4070-diff-pairs.sh
> +++ b/t/t4070-diff-pairs.sh
> @@ -77,4 +77,26 @@ test_expect_success 'split input across multiple diff-pairs' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'diff-pairs explicit queue flush' '
> +	git diff-tree -r -M -C -C -z base new >input &&
> +	printf "\0" >>input &&
> +	git diff-tree -r -M -C -C -z base new >>input &&
> +
> +	git diff-tree -r -M -C -C base new >expect &&
> +	printf "\n" >>expect &&
> +	git diff-tree -r -M -C -C base new >>expect &&
> +
> +	git diff-pairs <input >actual &&
> +	test_cmp expect actual
> +'
> +j
> +test_expect_success 'diff-pairs explicit queue flush null terminated' '

s/null/NUL

> +	git diff-tree -r -M -C -C -z base new >expect &&
> +	printf "\0" >>expect &&
> +	git diff-tree -r -M -C -C -z base new >>expect &&
> +
> +	git diff-pairs -z <expect >actual &&
> +	test_cmp expect actual
> +'
> +

Patrick
