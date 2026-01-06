Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D403093B6
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684372; cv=none; b=dhth8tpYmSn9tn4c10yhgeByljYeSs2Nx2kU0Qa1d3aZRC1jlTnSbgQgV1HqqAiLttnoBN9fPxU7QPW6rbTfM7mmVQ3ZvDDbeH90ia8ubFzrelZJA+zZovT18wjYHL9fBMve2Ihtw+vWd7RhecgXsD9IvAlA3xRQ6EOpXkWu9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684372; c=relaxed/simple;
	bh=VqctAs4D1P6zKrAD0yYZjRffteE2KoUNLiVIEZnm560=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJaHzLTGDwfv2/4Y8bUiENjLnR0PCLfTpCjvG/221tGvXrJtLWm8PaRnpjGQNwPRBmUJWRlldnAsSu125R9Gn+R2X4ulsnPleSQG6cYLTqKVMb1y1PELgdHscrkAqu3udJrVsJ2+9ip8oG41hSr0/uVJVGh6Ie8nZbHwB3vC54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LhrBkT3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4KSToQ1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LhrBkT3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4KSToQ1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C0A721D000EB;
	Tue,  6 Jan 2026 02:26:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 06 Jan 2026 02:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767684369; x=1767770769; bh=g/J51mit06
	K38EcgULWXc+rmBrhW8ovS4t5zZBIz3jA=; b=LhrBkT3guCVHJ2pOS8m1TSHwSJ
	kp16sk+GGMQXlwqJOcfKVbP/raXeCMqjRsr+tj/9LectQYOxoIJN5cK6wCv09/+3
	VAHkX3iZN+1ASggh+BlnNJRkywUfpWDNk50oeQBor9Dhm1CNhO3UCoP2HCgTuixX
	GVJeBh1nL+GGcxNlD/gC+nBbPiW+LUFY19WART4U3m6OZP7ERhcktxma0nVdUyw/
	MeX2HP7B4cytdnee+oiy31PxVLe5M9zV/PxC8R/hyjUrO+SyVLAl6ZoCwS4cEsg3
	2RmR3vSuiqOIKZ3Mwe9ywSRnK7AgymCZ5NbXEmhuJZESnPodjiGBe24xdPIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767684369; x=1767770769; bh=g/J51mit06K38EcgULWXc+rmBrhW8ovS4t5
	zZBIz3jA=; b=F4KSToQ118x82to2R7zGk5S1IDl+kzakvjloGcfdIVkUytAH2bV
	R1ZK0AH195HW8q+5nAN4yemr8KWhp/CbqJspdBVDUbvqpId4rJqbnaKScQhA6m09
	veXG+O+9I1Y84gmFvtt0uOWhLDJzFSErlpXL7alj4iBQCTwt66B9cuFz5+mh1+TT
	mfjjkPNkpu3w8LoFBBbIsfoRWIBHK9RvaNjBd88caKU0Xlkf3XrX7AdR4jwwlZ5v
	2/+s1yIKAygNrVVWl6VgY+6j3I7NsprJPCI/8hFkLYZKVJkb2YtOt+QviIQ6a/50
	B90IF8T8qdqus2hi+jrd8UEbUKBZS8TIzqA==
X-ME-Sender: <xms:EblcaQCdtOg1cOJ-kiKmS8wG2EaS9pdU0EYUSWiFFERj2QbE0jILSQ>
    <xme:EblcaavpZtgGGAV4XgmvI1QApiDPtSddo-XdlFwFnnQ6Gi1_kkd-am7oMcudBQ_eW
    SDs7yAuM30KTANLJG_6nSL74uAIxmE9eeoUsq1plSbZKm8igH2BYQ>
X-ME-Received: <xmr:EblcafLh39bloFL6nUyKKZ3Gy8o6PghUsO6dpQEk8K_kLbJFUHcVI9Y8EFW7FBwpUUl5BrcB411n9tolkAvYUSj1V9SZ5BEBQpIAJKwh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrhhnihgvug
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrughrih
    grnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsthgvrggu
    mhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EblcaRYm4yunpLvyJZnIJN0bVOUKQP8yDi2a1iffjQiaXT8-4-V-zQ>
    <xmx:EblcaRA_hetOLtUpxXpJk3qpEaHEOf-c6VLtESp4NZMsz9RfFJv9EQ>
    <xmx:EblcabYMCfhECAE5Efb7ibJj_sF7ESNIcPEFovBRj66lx4QQ5YoIkw>
    <xmx:EblcaZkI2RghRd8FKkkkKbq3LhE-m0NBKABWr-nTpHy4MWld8n1_ig>
    <xmx:EblcaSzqoLyDlDl1r-_9VwttVvWjeCjQXfBnNje6g-hs3iHRt2yL70Qy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 02:26:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 895c56b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 07:26:06 +0000 (UTC)
Date: Tue, 6 Jan 2026 08:26:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 11/11] submodule: detect conflicts with existing
 gitdir configs
Message-ID: <aVy5DAgijOJKA4dZ@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-12-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220101528.1227487-12-adrian.ratiu@collabora.com>

On Sat, Dec 20, 2025 at 12:15:28PM +0200, Adrian Ratiu wrote:
> diff --git a/submodule.c b/submodule.c
> index 834c794b7d..d778e8eca7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2289,6 +2289,61 @@ static int check_casefolding_conflict(const char *git_dir,
>  	return ret;
>  }
>  
> +struct submodule_from_gitdir_cb {
> +	const char *gitdir;
> +	const char *submodule_name;
> +	bool conflict_found;
> +};
> +
> +static int find_conflict_by_gitdir_cb(const char *var, const char *value,
> +				      const struct config_context *ctx UNUSED, void *data)
> +{
> +	struct submodule_from_gitdir_cb *cb = data;
> +	const char *submodule_name_start;
> +	size_t submodule_name_len;
> +	const char *suffix = ".gitdir";
> +	size_t suffix_len = strlen(suffix);
> +
> +	if (!skip_prefix(var, "submodule.", &submodule_name_start))
> +		return 0;
> +
> +	/* Check if submodule_name_start ends with ".gitdir" */
> +	submodule_name_len = strlen(submodule_name_start);
> +	if (submodule_name_len < suffix_len ||
> +	    strcmp(submodule_name_start + submodule_name_len - suffix_len, suffix) != 0)
> +		return 0; /* Does not end with ".gitdir" */
> +
> +	submodule_name_len -= suffix_len;
> +
> +	/*
> +	 * A conflict happens if:
> +	 * 1. The submodule names are different and
> +	 * 2. The gitdir paths resolve to the same absolute path
> +	 */
> +	if (value && strncmp(cb->submodule_name, submodule_name_start, submodule_name_len)) {
> +		char *abs_path_cb = absolute_pathdup(cb->gitdir);
> +		char *abs_path_value = absolute_pathdup(value);
> +
> +		cb->conflict_found = !strcmp(abs_path_cb, abs_path_value);
> +
> +		free(abs_path_cb);
> +		free(abs_path_value);
> +	}
> +
> +	return cb->conflict_found;
> +}

Nit: empty line missing between these two functions.

Patrick
