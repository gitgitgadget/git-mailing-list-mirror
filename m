Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07323D7E0
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693279; cv=none; b=Y6arfHeOjDyXeHTwrfvI3kkScFUBG6lIGqNOgeR/zUWZ1B8z2Oe19MYcNRxDtJBlbtCPDXYWoj1GkMxQ5azrWxdAB5YpRTmn8/AQYv2UayoLYw3Z3KxNfumF9kyNjy2bGNQ8uRf8gAXlswhbCz8mAgeJ6PAOPJzXyuH6dAuFi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693279; c=relaxed/simple;
	bh=H0Yce1lJajV8SCllWETH/RmkwUHsQ9UD8P4UPxJXuBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcScdrFd7QPtIxKrElL6W2ayEVSkCdDqdFt1PToPnwOJd4aBC2ut8MyMLCtdBwlAHyb1pm1n+AM36UULt75Wu8KXhCdKZ1IJROB3cjI6aUz4ktrk6UToQkkSROqp0gCmLYGsJ9Cb9y4RKwup5y0au2r5vfAalopgRrSPjwkuhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CG1K39iY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJ5h4DFO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CG1K39iY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJ5h4DFO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F05EC14000E6;
	Wed, 24 Sep 2025 01:54:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 01:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758693276; x=1758779676; bh=i1hQ8lPPlU
	s9SzgzXecdUZHJrBm4i/bVyUT4ezDRvSY=; b=CG1K39iY95yxYGsrC67P/0NHO2
	bkLKYGz/Su49lYhR0yQZ7r5fpJ8UZoHUSUSZ1FNYAUxWETS3XNe7Oe9uqQbD2TDI
	Pdka6q87Pz+7t12Jr5S6o8E/7S+6peQerMzyoC6uYALvZRF0Ydb6PlX6MTfE96HJ
	8hBwoEj+YcQtq49v5AhuPMc+T/9n35nvYzEf+mnl04YQvcbpLd6g6HbhSiFCQFfz
	LJbqwPxaGvhWFZ466Y57fsyZ3cpsWc5sLAI5zGvSmEhBR1Y+dqBGxBdl+RXmnFOz
	oUf0zGQQtc3UAmBYygLHqnNUprNtUlUyiz7vOx5oEo/p802VDl0ZIu7O0Qsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758693276; x=1758779676; bh=i1hQ8lPPlUs9SzgzXecdUZHJrBm4i/bVyUT
	4ezDRvSY=; b=nJ5h4DFOpPJ7EgMTbwLNVqv+nqaKSQrSaZSEMgYkidd2mXZRRFF
	LsiLRQ9XJPFSewIpCMP7Nfaea6s/2uOOO0fbgYnCNvZu3qs6Vm5foiXW11Di7+/8
	IznHO0rRyx0m5Tj2ZYiP6ON97HPbKakqMbrRXsS+U+Zrsrpkf0DfeD12u/UOSHaC
	9pwJ8879MJYWisohUy4oR2PSfi9q4Y2I+O7Tm0HJSde+owTk7bigsQxrUbYVD+d5
	EaiVcrLO7GT0GHNoHIdfKj+Vio/XmYobwPPv8TVetZSmdjlN7/b7X7pHM7wGSvfq
	pbfvsgJ9Fm6/r2ta4lcXfbr4Zd+FMVWD5hA==
X-ME-Sender: <xms:nIfTaP0AaKbN3hCJJCt1Guf9nOwvotsyrwjmox23kt7YPtHJR37muw>
    <xme:nIfTaFF6lv19MxrOZO5JQQ7B6JTvEtAOyzF4oESJeGWlzMBw5WDGQJTAnCd7wu5BG
    3pH5kNkO3algmeio6T5VEx1r84y7o83fcpDPz2AOwYMgcbmcI1s>
X-ME-Received: <xmr:nIfTaE7ojJm86Go5RiyM199XpaThlliD0SrOP4wlzCpD8dTs1uCaloTqJT5RoKSH2Y5ImmRMVNx7NXwFhLFFuPYt3v0AJgVemda5voMOmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nIfTaDsLvZ4FuZzihNbp-HrmrFqfyO6aFgwmnXWxl8LkqMM99oTc9A>
    <xmx:nIfTaN7_OaC4GyyfPnfWiEZpoXAaJefXRCyRuqSxdDvyo7TlhL7S7Q>
    <xmx:nIfTaGWz0QdYafD67Vj0LBhYBn9H8I9FyPe8Jo44ijmfE4hcLbCqxw>
    <xmx:nIfTaH8zfToxFsAHB9Qo-pLJdEyehJRiElLaBs-L6oo0uDeyrv86bw>
    <xmx:nIfTaAY8Opkp3gB89uW25k9kdqB5I3FSRu7fz2HyDlMZOzrmwspg35Ya>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 01:54:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0213bf08 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 05:54:35 +0000 (UTC)
Date: Wed, 24 Sep 2025 07:54:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v3 4/8] reftable: ensure tables in a stack use sequential
 update indices
Message-ID: <aNOHl65jYyoNXou_@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>

On Thu, Sep 18, 2025 at 10:11:45AM +0200, Karthik Nayak wrote:
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 955be1edb6..a458f5a4c5 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -317,6 +318,14 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
>  
>  		new_tables[new_tables_len] = table;
>  		new_tables_len++;
> +
> +		/* table's update indices must be sequential */

Let's make this a full sentence starting with an upper-case letter and a
period.

> +		if (prev_table && (prev_table->max_update_index != table->min_update_index - 1)) {

I wonder whether this check is too strict. It _must_ be true that the
new table's minimum update index is greater than the previous table's
maximum update index. But in theory, there is no reason why there cannot
be a gap between those.

The reason why this makes me a bit uneasy is stack compaction. Say we
have three different tables:

  - A base table with record r1 with update index 1.
  - A second table with record r2 with update index 2.
  - A third table with a deletion record d(r2) and a new record r3 with
    update index 3.

Now if we compact the second and the third table, the compaction will
realize that r2 is deleted and thus no longer needs to be part of the
compacted table. So the new state is:

  - A base table with record r1 and update index r1.
  - The compacted table with record r3 with update index 3.

I'm not too certain how the minimum update index of that second table
would be encoded in the header. In theory, both minimum and maximum
update index of that table could truthfully be 3, and the result would
still be both valid and sensible. The new check you introduce would
trigger though, as there now is a gap between those two tables.

So I think we should loosen that condition to ensure that we have proper
ordering of update indices, but not a gapless order.

Patrick
