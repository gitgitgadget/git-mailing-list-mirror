Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBD15B97D
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284320; cv=none; b=ka5gUu2SRExfVPYIz8cT1gYu8Y0K5p0RtWNXEUG3F2HMm71X3ermDho1ziH2IcaZphUYkwIGTNuN6/EbeyEman1/59Z5Q4c6gaRbgbeL41S+iI7jIOOHQmYO/wjZSR8Wg1k0sGYcQp7s3QYIrvDw7TYXBx1bCPbsjEi54MObP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284320; c=relaxed/simple;
	bh=c9zIA4nOvqPqZt5pKtCnPJ8ThIo+S8vpd/zKRrJXgqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulyQcnSa5/4lUkntQFdhUhjw1R+2CZVxlxMWRdhzuqk2o5hhrGoto2MM0GMCmTOCjTc467NoNi5iYUCBvljx2ORYTDmFOxnwlJClalkD0eDBVLP60ba4hKtG/ob9zbYmFfrdv+rbp+lVdPNf2mcEy8xLequPw3iYfivIcovgAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jVeggnMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EycBLsfC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jVeggnMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EycBLsfC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C07D11400E5;
	Mon,  7 Oct 2024 02:58:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Oct 2024 02:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728284317; x=1728370717; bh=c9zIA4nOvq
	PqZt5pKtCnPJ8ThIo+S8vpd/zKRrJXgqM=; b=jVeggnMuF17MBPw5za4nD8bcvB
	P23zvGcfMqHnb1a8NhrsQUs8qJLxoV7sND6Ld8paIc0bFj45tbpiS1n5dsL/XHJQ
	fziHBJaSoJ+Eq48FEW9ES+/LJ4P5iu3PFIedWn6wefVNGqdeWE10oA+pwnlCPvp/
	QoYC8IOWxwUft7YiI99zTWLjthZ7g5POq+pFlFUj7o9IXeNyqeyIIE1dCRddp/AR
	tOMTm4glpzbWGqhgsimM1ww/kj+MSgcxd/BP9yTLhoJ6fNNWZZqePaeYo7acM+GH
	MdPOQ/FkQpf0B80RBh2qgFilvKWRMJoB/NxIVun6qClnPLb0pTtrKbeJeTVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728284317; x=1728370717; bh=c9zIA4nOvqPqZt5pKtCnPJ8ThIo+
	S8vpd/zKRrJXgqM=; b=EycBLsfCuNDmO6+KVaDtjqKLY2WeSIy4Ppt3GrM7671N
	HjRu36h1AWsH0JE1jXdq9B7H90B/aeRmfLVbxiLH6DOO4CuTCeDVHK3XjRopNqxi
	/j0quT+wBYdFKmIjgTtaDZ7LIXrYKsF5q7oEsrMqJHBtpNYCZUH37eUClppA3CrR
	/n3wl5/eMNcrL5cQPOPJKnt1sC52UuTMqXkC/0pst18rrQFReMXpdQeGGLt9TEjl
	FT3a2I0CczhaxyDBo9Y4OiOydil8SOwK713ecDHG6r6Ajl6FWzu/9YMKR2kymWrc
	96sVyEK83HybsmHlFQ6p1kNqIruZF+mXbwNRfVMHVA==
X-ME-Sender: <xms:nIYDZ-qwBBK6GjkEERIocpHPHf7zaP1j-LstAqCT-wlPPzfUlVh3ng>
    <xme:nIYDZ8qrny6_GthRVS7PuraUKefTab0YqLqIas3oBMQq2R9_O-_xGfmzamHko507u
    iWFwSewWGeCS6HuAQ>
X-ME-Received: <xmr:nIYDZzP568_gDyLbJXcfK_iSJL_ITBp4kZ3ogE_V2E-IYblPt2-QU90LTjkkwqtZNS8T6sW8W0Y54d-qWY6GilVcHar56wkX4MHnWsqheKQz6qxrRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nYYDZ95YRMNXqetKWiIfHBpjqV-hiCC3D8wQiDMt9qz4ZqC_OmLDLw>
    <xmx:nYYDZ94O3ThGpMTGKAZMSVh3lxDzzEaxBJPMagh_7g2Y8gL8Zh_3Jg>
    <xmx:nYYDZ9hkCYsI9e5J_nRj34sKVxuzeuicsW9hkmDooxi4YrxR5Rv7fg>
    <xmx:nYYDZ36RV11Wc5nlMAEDJ6iZ9JhieYjUW24lwZQDNzGneWP3Bakg1Q>
    <xmx:nYYDZw2SzgmYKl9Xj9USUfgW4ea9cHo3flgbEv3ZqD6absrZBGxjlGHA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:58:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a2a3b3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:57:38 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:58:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwOGmoX5ner_F3Ac@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-osCNDMrUQv83@ArchLinux>

On Sun, Sep 29, 2024 at 03:15:46PM +0800, shejialuo wrote:
> "git-fsck(1)" has some consistency checks for regular refs. As we want
> to align the checks "git refs verify" performs with them (and eventually
> call the unified code that checks refs from both), port the logic
> "git-fsck" has to "git refs verify".

What's missing here is the actual intent of this commit, namely why we
want to align the checks. I assume that this prepares us for calling
`git refs verify` as part of git-fsck(1), but readers not familiar with
the larger picture may be left wondering.

> "git-fsck(1)" will report an error when the ref content is invalid.
> Following this, add a similar check to "git refs verify". Then add a new
> fsck error message "badRefContent(ERROR)" to represent that a ref has an
> invalid content.

It would help readers to know where the code is that you're porting over
to `git refs verify` so that one can double check that the port is done
faithfully to the original.

Patrick
