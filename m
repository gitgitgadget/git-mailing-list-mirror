Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE5443312
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515987; cv=none; b=t2wvKkmhHSoH3lNQDTgqdDxCRRUWkcE8RYlafaMVFhMFe8sUiZO1YiR5Pb4ZNEmpM5/f0QiqNNRaV6vBULOBJKKj0MdbuxY8BbkQdBbW9jcbd8MZYV0FqUBkHOvUxUClgkRppxMjd0Wqeu9awQqYyr8HwCQQoJOHlUoLo/vpCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515987; c=relaxed/simple;
	bh=XzSn+3BZVTtoBcb6zkl3vTw9H4N2Dc9C2QuCLtklh3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovGNVlkZ4JAKE9eA1t6JgBGkCLhl+sma31BFpwMMN+1JMYr7yw7oUgZJjygKAFn5AZ6BeGaSBSurhceIZCosYBYXd4qhnEneyNqMkqVnrEVX07JQ36XREnOQbeJIdXJgR6FcXuJbEKTprCjUdnO/Oge5tobjuuADdnr5/OvLRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WtZ2Ad0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XG8nJBXo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WtZ2Ad0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XG8nJBXo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 227ADEC0179;
	Fri, 31 Jul 2026 12:39:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jul 2026 12:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785515984;
	 x=1785602384; bh=14/G5yjDHi4eFkuMQoLXIdeZtr06TDq4PAFBdQds6eo=; b=
	WtZ2Ad0OSFn+PqDmaEuxZ9tO9UzjIA1Knn+Uq+IX0jOwkb96jRfWAKi/xhr9IJTx
	ElxlsANecaBPGyy9KU9kbBCZzgnAaQr1ZPSd8keaZLk9YBoL0cEADov17iguEBFo
	06ne3+a+3xSDvRJzV14qIrmOufQPbJmd5IYuMS2bV1PbcC96pq50RE49dawj0xe3
	OrF+OlNB48EcUUAqxJdDgd/qTqdYXjuS8JQDHT68oI4ylslH+qvatTeDNnOJAlcT
	tlzU5VwKpsAiaDnKOeZYWshMEuVsMrNJUK2Whw4qcQ3YmKS4FFGzwNNK29wadsqg
	u+5R9zPQlD4StiYYvJfPUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785515984; x=
	1785602384; bh=14/G5yjDHi4eFkuMQoLXIdeZtr06TDq4PAFBdQds6eo=; b=X
	G8nJBXo4Ce60CrfK/uB63ubGFoiH7cg1piSItlUdJePuN1dG+cHvwYK63rAJlsMr
	fxEpmmFGdxHg52s7fmwMv7GMh4g00FzMQkvMjgvROBmfej5icP4A0w+bKmsqbNkV
	Jqz/wyyRHpCxIfJwEXrF1SZgjPezR6oqZWzk5oZ08uLqCB1cEqj0lM2h2DrV68OG
	yPEvc72jQpiIev6LFDq61V6fkp71MeFITAZX7CSL+8XFau/KYXO0veN3pvHj4C6f
	poVfg0eo+Nu4x2NuSTxDIg/PKMZldNotoARs+1Xjsf/xulLbYbnWKd7mkRoFRo83
	sLgoT9i8f7i8/84i4rASw==
X-ME-Sender: <xms:z89satTrH5njZZYvtLTdAM8m7HXpjVJBPvmA3fXaRBvFhXysClF_Gg>
    <xme:z89saqciWRfe1TkNnpsTA_PEswFCB2GD0IXjnFsGX89gz9zSquYwroNb6RV5gnebL
    dJRfkXhJPSQFE0FywHRrOsIQXeFCyUqRyb6GXsRB_okypXxr-sdAw>
X-ME-Received: <xmr:z89sasolzRISMhdg5md-jOm0W77sxROh96HvnPkQdwACyxGPnAeXS1zxrgYY8byLjO4Oc1Ba2pQXCtQOd5S2aqeotbvXZfEITA>
X-ME-Proxy-Cause: dmFkZTFK4CYeM2S0U4EcIlRFcTgY4wN0py7RkK/lcRwBytZCQnkLqZS8JlcFU8vI+JldNE
    Ii7SqBIuehtp8u7Vy1WwU7r9aC5S/ayewJr9uy2NHkUcxOEU6qEJJSLiSjL+NrGFrsJ1ZU
    W40FDWAAsZ43hy+uGpWIbr62CAllzamvGpMljLiZsLBnO989pdRriJe7WJodDkhI/UfO5G
    PG++dHdN+FyNpQynu3Xv5+ctObmi4CWwTUf/4lH7Cqf4Fdr9vF1FvwThfNCpF5e8Q3rG1K
    sdoJ+2CYP/yzJZ4MdppTLlaarbKh0ptXaIGyFbhogQThFtObvJuhFf+eDNbpDtq0XLVKKX
    rnM9XsoIigCYZQERIlxLJSfynBoRNBiH1kcq0RBcFdmII1a2tlJVR6trDZkbzWKfOWU3bq
    E0l5Q3GIt6Im3O+kpyGRgEVHEKZwe/BnOsmusgbRCqEM+OKOWwrpK8wG7dhvRstdmAJDB2
    xFfsLs4RwrHQNQH8h9s+d/Xm4Qq6hgmov4UzSBJk2q7bLizhobcJ1LhyCQ7lIWzBQkbM9T
    gDl2uujfTsa3Q1cVsKcbKY4KSfKBsn+sh+2Wpp1vEzf1zAlzMLjKbcbPHPvJ7Uzrd5Idn6
    tMONCTQp4y49eOSoPIFNPDSuyh83C/a+3PgOg0z8nZ+0zipMH4498kNEG4EQ
X-ME-Proxy: <xmx:0M9sar8CcjcDA8DpB0ikLuYu3-Vae52nDahR7KRwg76w_3S2xilJsw>
    <xmx:0M9saoeUjJpab3S4Om1wym5U9D3tO7q7LfWNUIcwd1jCv3EsjtZeqQ>
    <xmx:0M9salKm8KhSVXLXZtKA2n_p2x4_21Iyd4NKPR5Vb2k9D0upl06owg>
    <xmx:0M9saojzhKHWGng5vEjrCpkA7KbSvFPzMXONJWZvxHJRtnYaRMjjHg>
    <xmx:0M9sam2HQy5hG52SLKLOCrc1si1y2Hgl02PBGEmc7GGjPNvUn6dbZ2jd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 12:39:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Karthik Nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/2] doc: refs: put ref migration warning under the command
In-Reply-To: <CV_git_ref_migration_warning.b09@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 31 Jul 2026
	11:07:01 +0200")
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
Date: Fri, 31 Jul 2026 09:39:42 -0700
Message-ID: <xmqqbjbncdv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name: doc-refs-migrate-limitations
>
> Topic summary: Put ref migration warning as an admonition under the command
> so that it is visible.

The caveat only applies to the "migrate" subcommand, and the new
placement gives us a much better logical organization.

> That’s the first patch. The second patch adds a missing `linkgit` since it
> touches that same warning text.

Looks good.  Thanks.
