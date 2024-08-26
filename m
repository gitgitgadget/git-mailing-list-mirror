Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A6312CD89
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656948; cv=none; b=R2CipXYBgHragxxAK45vvkr4RNw8VZH3SzNf4hIw9zrIcJIztmOfeGo/gMjrhF/lv8iz7srCRk+5QpG1gaQjhLaQixdqSlPuTmwqXSABk+mJMvNZ398W9AcvovTszg/d16H1p9+HtAZiTkQ9WiQJz3lusqFvbMJ0qLja+icj/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656948; c=relaxed/simple;
	bh=A0Byj+5VYH5hPzhlO3nBk6cIuy0H3asPJXEyJa4Jcho=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knWUFILT9OPwWrzQ2Ix2IwwckVw8a3azqP4LSHT+g/N6kzJeADmUk2JP1rq7hfGYu5LDOEvnJ5U6+yojfLvig6Q5E8JVxiONDNG7DwprmOrKqOJeEtlwU514cEgp6gZTWvahLOteeOXnmF56NlthpC9v/4gx3VR0jIguOedCtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LWhIvPDC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0QqudqR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LWhIvPDC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0QqudqR"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E08991151AA3
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Aug 2024 03:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656945; x=1724743345; bh=IF4aC7ZcbN
	LMDFv2aGj6D5fGo+6O6q1NZ3o/pfr5hNo=; b=LWhIvPDCkCZ9ZnPcjBImnTFBAM
	MswTBb93ICarnItWXAhwwTc8pNGcVV+4An2QzZDAKPdc5CkA7O6KqZ9Z6UenHTvp
	R9pNLru4rbyy6tueuf5zXYtKDFHCquCXxdWBBRWSWCaTTYAqAyoO4HG4ytIKcYAg
	mU/53sELAP2mhUyICZ92D8h1WYGbkFVcphfog1IeBOjhf52Z+sVNbD3d97Dq3txE
	/R4LBtCVJn5G6WHwgeuTfzihCLdRkzCQE4w0Pu8JjBdCef8NgixyI9J6y4byThsh
	03wKHWNDAgwQcx3MkZfZDJoUkyx0nlgCNwloHnQ30PDD/cRGVgBFMNAAwHfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656945; x=1724743345; bh=IF4aC7ZcbNLMDFv2aGj6D5fGo+6O
	6q1NZ3o/pfr5hNo=; b=I0QqudqRD//sLrJQ3ZSgWEqfVPlvi4nkn2RTe00zkm7K
	XoQ9+hlxJslE2jS9fHTvBFuJ4KgEgBdKOrg9B0dqr0D0pCFq3wps8FLI1U6vY5Ky
	xxrNgZ8Kc92jquJs4zHanlHuQ61mqKMwpQVFdsdniF9q9AWwTjgjYv1YwzLgxL5o
	tIk8MlzS9o1VclMu94iqJj/G2UAISF0b2vzl7YsmKC2ZgH1t82bLIN6dpMLNLaCQ
	ysAwHp+uPdGyGZeFYgC8FubEDbo4SEHN7lwrkhBxVsv5fH4nEHwXIY20ufK3uBrY
	De9gvJsumk7PhKIgHVSJA37Ds1n6AhOv+Qvk2xMVHw==
X-ME-Sender: <xms:MS3MZq9KOB76k6dxTepsJsZK08i4heNvbuSNb_-r4HtVKXhvdkQNJA>
    <xme:MS3MZqsiW1SYv4VinhiYPZ3v0vEw-TAo0x-rNFvB2Lo1JpE7RBW4dL9Re6ifmxBKx
    OXbejlbkc8ZxHHlBQ>
X-ME-Received: <xmr:MS3MZgC99wIi1YLl26yDenEufZlJX8V3DodbkC0wUce1PjCeP6LOdLncEhgj2PC6s1YyfQBkflyopI5lqmiw3FcuEYRcCU0TBsJP3lClNQznFPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MS3MZiflLFiV052CN4eDT0DoN8129QvWN3duiX2b0_RyuDg8KZrLgQ>
    <xmx:MS3MZvNfNi8HrMxSHy3odwjbDcmpPvoaNOndqkdDV6T2-RA7tSa1ng>
    <xmx:MS3MZsnIRaMksMThrzURSWOFlhCcBT-9MU-pxbeau--Nd0pWmA7-JA>
    <xmx:MS3MZhulBBGTAaJN0OLeS9UPT_IqnJSKFL5XffkWCimYwnrqidWQaQ>
    <xmx:MS3MZl3OFrPPAd49lou4rciKB55MRIQUR_ndSBIWZX_TOEvTE4UAbQg4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef2bf4d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:23 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/22] builtin/repack: fix leaking line buffer when packing
 promisors
Message-ID: <19eb9073482144d0983de1ff9529fe050b3fc6a0.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

In `repack_promisor_objects()` we read output from git-pack-objects(1)
line by line, using `strbuf_getline_lf()`. We never free the line
buffer, causing a memory leak. Plug it.

This leak is being hit in t5616, but plugging it alone is not
sufficient to make the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8bb875532b4..a382754feee 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -425,9 +425,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 
 		free(promisor_name);
 	}
+
 	fclose(out);
 	if (finish_command(&cmd))
 		die(_("could not finish pack-objects to repack promisor objects"));
+	strbuf_release(&line);
 }
 
 struct pack_geometry {
-- 
2.46.0.164.g477ce5ccd6.dirty

