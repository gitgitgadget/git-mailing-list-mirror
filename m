Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2693132106
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427748; cv=none; b=Y0nevFZw1KV+DdcReHwbg6qYEvNIzq2d951T+Y3AbvGkwOrZdXC4LsyQJKAaX8wniopsAJ8iEsdlFXlW3mVA1hOoSdbcpR0kaziKOBe6CyQ9pRNIW6ITeleygPQ9dtqN/uBNgARplZ//6pPp7N/qNgL4gr+FFlANwT0XwXXq3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427748; c=relaxed/simple;
	bh=DfODXLf5EkjNXgqnmSzCzwbbBBGRjwH2YgCu0LYfzeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sin3X01o5rCUNFwm2m+PJdHfN7NWVFfyDtr4vlgD7GvBo/KzmNQ1lZ6kknuADiBDl7PcjtLZNtbPugptXZsiqQwrrJjrpMTmK1Q4kl7NlIZDfwq4OMDlGtlU2+8A10Ld2JeJQr5Hzs9u6H6l4PNqDtU9BTfUQEVo8EcyuCtjoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hexMAFtl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Re8ceO82; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hexMAFtl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Re8ceO82"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FF8111400D5;
	Thu, 31 Oct 2024 22:22:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 31 Oct 2024 22:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730427740; x=1730514140; bh=kbceiEGBCH
	XOG2EIPUBIMSbj6CQhcNs2Y6guiILFbb0=; b=hexMAFtlGbRJRd3XFHXlsxIndr
	aI+phn2ZNxPX1Bjgvxx3jaW/RvAGyNxtEhvu4g3TW7kOukEzPTWbwqg2PB3z5r09
	4GsEqEDRhZjakTebJ07sPQDH37OzZXYvsBG2p22pq/cTNFgYJoDeNDBFvEaUv8mh
	HXR0xctdnoVK0nju5UehuAfwCfkgdFydsh4JC0/rBqGk8cAUfBA7y0lxpy51AblS
	wTV6Q/I+akypijKJgR6noezSFIJN+TaJnK5o5FpaXdDNmduPmfQ6gooXi1yMDFQB
	r6W5axjhHQ8K2NOGEaNVUZ72+Warq9JIZ2BUM+Y11bEg0DyGh4hQ+5B27tjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730427740; x=1730514140; bh=kbceiEGBCHXOG2EIPUBIMSbj6CQhcNs2Y6g
	uiILFbb0=; b=Re8ceO82mPd1pBhvtVwEPlXQNzLm4ODDiW1Xp2Bl68nAWkC1+wN
	6CcN+wnpfuro4pYOhkhizwt/IE/+1ufFCW9xGtZsTOPgiE612WwpXNnCY688jBF0
	OlmXwaoZ/OIRrTCBBBpG0lzod0BPVd07Fefkdu/LZkNp/H7uEb5eRPVZeU+z+MDs
	u0lsA52VDwQqlHBirCxQPTcwnPvp5tSkQbYvdVvp+NbpmlAU/0Y7VfiqZF43XMpx
	vvLYRMSJ9bFrEWemkh6weh0Kf5ntcSmHeZknhpTTkpGdMdsM6SMeEiQMirYUcPh6
	/Ah9/drLqVb7TWef77fmAnP6SjpP01NLW+g==
X-ME-Sender: <xms:XDskZxLWH5acW4CvwTE3DK5Ndy5H1-70UH8jMs1vPRChuZg8MTeV9Q>
    <xme:XDskZ9JtcML4yOITKUZm4v723GotUvGWlJ8tSpFm0AnALTFP1TziUasnKmMKuW0py
    mWGgjCWt3U6K6FDdg>
X-ME-Received: <xmr:XDskZ5vGgR2NzzYYLaGHQHteKUb1yqFnnqf-LxNHkz-B7j-AN_6Q2t862aOeTOj7OYJ7fsMIkbXHJQdxWOCWgqWlFTbUsioV0Yul>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggr
    ughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohephhgrnhigihhnrdhhgiessgihthgvuggrnhgtvgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XDskZyY-eO6ITNzIrwroD40fyCbf3Z2iiGO0MGyaUaQC_0NrfQYU9w>
    <xmx:XDskZ4ZeVAwPhKTR0mhuPFWW90cBvnvGCjIvAuqgqQ-Cd3xNA0NFfA>
    <xmx:XDskZ2A_R-WONVAPknwLRXGsD10q7DLQnBLI329YHCErPs6rVkmPFw>
    <xmx:XDskZ2bNY8E7Wo2U8W0gNufA7lW79Wtw4iODnWkvqS8Yj4I6tXcL1w>
    <xmx:XDskZ9PjVskEtBf00ibXtUPzTQ6TQ0HYzqxXcBdKNIJj5_ewFvG1_cCa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 22:22:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  me@ttaylorr.com,
  hanxin.hx@bytedance.com
Subject: Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
In-Reply-To: <631b9a86778f15b7086e5f17fe850ffa151dd341.1730409376.git.jonathantanmy@google.com>
	(Jonathan Tan's message of "Thu, 31 Oct 2024 14:19:01 -0700")
References: <cover.1730235646.git.jonathantanmy@google.com>
	<cover.1730409376.git.jonathantanmy@google.com>
	<631b9a86778f15b7086e5f17fe850ffa151dd341.1730409376.git.jonathantanmy@google.com>
Date: Thu, 31 Oct 2024 19:22:18 -0700
Message-ID: <xmqqikt74rs5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

>  static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
> -					       int mark_tags_complete)
> +					       int mark_tags_complete_and_check_obj_db)
>  {
>  	enum object_type type;
>  	struct object_info info = { .typep = &type };
>  	struct commit *commit;
>  
>  	commit = lookup_commit_in_graph(the_repository, oid);
> -	if (commit)
> +	if (commit) {
> +		if (mark_tags_complete_and_check_obj_db) {
> +			if (!has_object(the_repository, oid, 0))
> +				die_in_commit_graph_only(oid);
> +		}
>  		return commit;
> +	}

Hmph, even when we are not doing the mark-tags-complete thing,
wouldn't it be a fatal error if the commit graph claims a commit
exists but we are missing it?

It also makes me wonder if it would be sufficient to prevent us from
saying "have X" if we just pretend as if lookup_commit_in_graph()
returned NULL in this case.

In any case, infinitely recursing to lazily fetch a single commit is
definitely worth fixing.  Thanks for digging to the bottom of the
problem and fixing it.

