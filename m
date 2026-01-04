Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910221DD0D4
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494977; cv=none; b=TXN1Fd1T2rHOV+oVxZntMV8SK+acJAP4yXFDVK0QmalZ5F4JQcwmbLRUxBJX/d5D+CUOPo02zAaNrV9CwyztZoJU5Vdv9olEkFm4fOxebMODA7PQp+tZWGfAUHk73w5IVF89S/7YAuA+9R/VL8TqEyx6PR0+rBf/VRyrQ5GGU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494977; c=relaxed/simple;
	bh=87G+8c48Re50H45ZnpGsw59MhHF3P+Zh8h4k51OBKds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KKIWCMOkpC/LAedXt1y5kKJzBmiooAV7CO+1rHRmt8cFRyIRqTqvJsa2iAjLqrcafOO2eCt5hSpUZLLEih6XMyiw0fAu1hBEzgU6bNfzkjVpLSrg2uauwGEFJP8CK7QeXMNmsjxfGCFimRLCYEQ5DCtFhusNAs/82nT4ta096Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T3XWCvMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uuev+FzW; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T3XWCvMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uuev+FzW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C6BC1D000B4;
	Sat,  3 Jan 2026 21:49:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 03 Jan 2026 21:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767494974; x=1767581374; bh=/RiItQJO4g
	fBwbtcBvVX5jPAicytDKl05ZQTplNo/Xw=; b=T3XWCvMfFne20ewTSlhoN5EfNH
	e9h5S0ipWt8Yw2Gh31/GToUupSJxMckxFmPmYsyYPo/06RHAuzZPwn3oqdyl/ClO
	7fHjC0yUYbzgjFu2eVjiOJ2ex2ztyVBiTuisI/QqLJMHvIjQWa4RtDcNnKiHrVaN
	0gqOOoI5SiF480cwoyIEw+iBku7RXGgO0qJ8DzuRsmisas4FWA1U+ZpQlm3DXfhE
	4vFA33kE3sKLjAUrXbHfpTrWj3hN8j7s2DdQ9oWbXFbRtJQYphbhl1twdfpv5Sfs
	UlT+3Q/MVllNxbDPMaJpxxuI0m97FZw93CCxE8poQJqzENHBj9s/9TI5gpFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767494974; x=1767581374; bh=/RiItQJO4gfBwbtcBvVX5jPAicytDKl05ZQ
	TplNo/Xw=; b=Uuev+FzW6/E41ADfrLfHfE5xS14K8lDW/+JFw0UYn2QLvqfiKbQ
	ztxvDxprP7owU8l03+v+RaeScQ4eQqX5kcAUNEZs+GXyStLGieS9rovD1kPTDQ/N
	/zy3qJ8CinnYDPCvIbxoq4YB42hfAWiGsd34rd6P0sAYYaRu1p9xQU+CpmZLpw5G
	mxsaDV+XgPUKZubumILQN+EXRUedjXxushvY4brnLxHKGqKH9bNz1hY9S6yZQSSf
	0fIT30GbqV0LJOu1EcHF2aUeTwUT0OE6+qHLL75W/x0bWYIhLjrCm/N7fvq0c2hy
	zirKAiyh22VAd6T7IK+RsVW8hVMyBo66opw==
X-ME-Sender: <xms:PdVZaRAGNPKYiaMZrA5o4G_KdV70vmo-q9kBUXHVPuhirQpbm-tCBg>
    <xme:PdVZadUCeS0zT7bpgYj7l24TCNLRerzwNAWaJPQ0xc46WSc1oAedCCHM3q1T4HUzI
    owVBu411H6LXrgSJ4HXe5CVNMu5RaEL9E398qq-OGrdIGhsR4waKnE>
X-ME-Received: <xmr:PdVZaXDIrhT5Eyn3XaQ-Bfx5fLZgdQW_1HXI6AZv2XR2-uRRYPH4ayTcviDKpTwkd7WzxHNFwCUXuRP3AzCQlD1rgaoMLfHQAnAdbRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtshgrhhhirdgvlhhkrgihrghmsehprhhothhonhhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:PdVZaY9FVgxZpdFTaTI_JSMIeFnBVCpk79nG8oqQvt5dbDeaVOOK1A>
    <xmx:PdVZaWEr-WzDjHJcZbvJnkUGPGpISTK7TfkfQWxiXWfHIPgOVV8pFg>
    <xmx:PdVZaeOEqXnf0zPeda5Su0MOBQxprPzRq4l81OPEAGit5gh8VfCwqQ>
    <xmx:PdVZaYcZ6Biv3-1jGvPngohLWoA2ccQSbfNutPgLs1H85XzihnrusA>
    <xmx:PtVZaQB7EL4lvnvw4UVICQl044uzaHa5iiusO9XfYlOlxnv7Xmkz-G_Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:49:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "ps@pks.im" <ps@pks.im>
Subject: Re: [PATCH] reftable/iter: fix undefined behavior in
 indexed_table_ref_iter_next
In-Reply-To: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com>
	(Tsahi Elkayam's message of "Fri, 02 Jan 2026 19:16:49 +0000")
References: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com>
Date: Sun, 04 Jan 2026 11:49:32 +0900
Message-ID: <xmqqy0menlc3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tsahi Elkayam <Tsahi.Elkayam@protonmail.com> writes:

>   The indexed_table_ref_iter_next() function accesses ref->value.val2
>   without first checking the ref's value_type. This is undefined behavior
>   when the ref is not of type REFTABLE_REF_VAL2.
>
>   The correct pattern is already used in filtering_ref_iterator_next()
>   which checks value_type before accessing the appropriate union member.
>   Apply the same pattern here:
>
>    - Check for REFTABLE_REF_VAL2 before accessing val2 members
>    - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs
>
>   This was marked with a "/* BUG */" comment indicating the issue was
>   known but not yet fixed.
>
>   Signed-off-by: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
>   ---
>    reftable/iter.c | 13 ++++++++-----
>    1 file changed, 8 insertions(+), 5 deletions(-)
>
>   diff --git a/reftable/iter.c b/reftable/iter.c
>   index 2ecc52b336..2eee65bb1e 100644
>   --- a/reftable/iter.c
>   +++ b/reftable/iter.c

What are these lines with two-whitespace indent about?  When sending
a patch purely for discussion (because the actual change may be iffy
or dangerous), we sometimes deliberately corrupt the patch not to
apply mechanically, but this patch does not seem to be such a
"request for discussion" patch.

