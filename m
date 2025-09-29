Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780B26F2A6
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188107; cv=none; b=GZADUt3P3JXNAPXxs9KR5pRBugoKa2ViNXi9QkaM1mWEqyRbb1XIaG6IkZska3Dirc4bxQuhPH1GMkbHjnik9HY7ia5NVvC+KyOA76WoCgq92fppPpP6KLwAHhoxheW4hbfA+tkiP60HmQhMbMhVGcnpwMX8jB6nmYDrdIZZSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188107; c=relaxed/simple;
	bh=IiRtcxq8dZrYbUI2noNsr6f4gEAYOrDafryMxUqcaZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPVKCWj/kqNYkXvFeUF7EXGeKPAMaS/IQmzYXM2FY284YBwvwf4+Jktd4veOysGmQ99EXgteABn1ud/jUAtPE/U7WRYpvKyfnKsLF1a3Q4UuAmv4y4AfScdRlAX2oIUp/Yh7YYLa8S2XvnDGzu+iPshsNVX/M5MvujrEqzTdO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZCyCHzh7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tnIZE86Q; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZCyCHzh7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tnIZE86Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 75079EC0196;
	Mon, 29 Sep 2025 19:21:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 29 Sep 2025 19:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188105; x=1759274505; bh=VMqrf9UW7v
	1Ea/Ef38NZiUQjck5b/9hLUKfBq7DiGWI=; b=ZCyCHzh7jylyFoVkoN6nldhCPh
	ellnZzKB0ExV7cKxqe2KINSS0MCsSdxpE6lilg83ofjVEUVSnbgS5bNbdkZ0vpL0
	nMnOZHxfyBTgeYZgjHy+7hWlim7ARwrZapvj6axqcEBfKMBA+R+0plgkQK4zKRJ3
	UePiyf1swDYEIki7gMgZEAsPvsrgU+7n0mR6YB2oXk1U9pUA7IVzx9M3L5lC4jn3
	gjtO1SSdW0Ixle9OaS83XnZSUlsk8lHI476fn8yhtQbsEdM3rmqYX6I1/R/suCyk
	Nm3YNgQx7tjIG25Qx9g0U0fAiLRAuF5wPXG4jG/SEcZls7nuYEQBLU1n/0OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188105; x=1759274505; bh=VMqrf9UW7v1Ea/Ef38NZiUQjck5b/9hLUKf
	Bq7DiGWI=; b=tnIZE86Q1jFRDgbK3lvxOSMRlnN2uVd/1jz2hzjmNzn21+PQqnc
	6aoAkhaSrCIjcSUtwI4VJz5ACGmm8TcFGCE0DxjhqjA7Omb8nHDj/b0B5b0ihaV9
	TzBfSGvPqDvW2fKof4xbhSiBTdAZRkZgNwqvKYswkrXFPa1iE2EmxAGC5uqAQLNe
	iUimiZrRzibMaVkVV1X7+ViYXYXr0zdx6plFTpo1heqzdDsn+BypM/+NMy8g0rpd
	PalH9QNjuXUJjq8dAOsToLnNphqyT1QvCEODB0W/NP1T8iQnJ5xxaT2xlmqBSor6
	AyfVQjNxZYKB/muP0veCKYugUSU33f6K2Fw==
X-ME-Sender: <xms:iRTbaHARW8ZtwQ6RstSVTM5ipi5Vf_TRDESa8tJuIYa7txoHzixWcQ>
    <xme:iRTbaBNOInGjRpj3K2Iu7dfg9QcojmAcCS6CMkD2FuyxL9GAmRc95v51gfa53hoyg
    Ovzj2u7AluI0RSMvJ4o0VASWXG9Qf7dvXnxhK2FPJY8_tafXkdmrg>
X-ME-Received: <xmr:iRTbaMaqB7ou7TJPjNsaHWRB8BAvtNci1uP-4GSqZKrn4TbCP-7QB8-GW69Y9-m8cNH8wcOrHrmYFcxz0iHNePs3lKHuJC200X3L_eH123w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:iRTbaAsKJx8sQRW73mCPJYjYGyl_OVwkPhQYlQ3vakCbdm40pqTShw>
    <xmx:iRTbaOP3Pol2XPKpWAqYSXBloATZGrwkP5H3MOSdqk-TfqGZBeBj1Q>
    <xmx:iRTbaH6c-fD7TTF1fUwg2AkHBzeMvkePvOrh3b1izhr9heieRbFu0A>
    <xmx:iRTbaERMEXP9MTe12gJoCq6dTcRo523tEJtUOcPH9BKO5DYeMR3rnw>
    <xmx:iRTbaMf3fqstNMj6B9CqUIQrakEyE9umSZJ1TfkRKxeYc4qLIV6PsPaq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:21:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7de4fab0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:21:43 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 19/49] repack: remove 'existing_packs' API from the
 builtin
Message-ID: <aNsUhEVUmzmZ5gp3@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <ae267fcc820dc19497f9f897bc5915b2040739e5.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae267fcc820dc19497f9f897bc5915b2040739e5.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:23PM -0400, Taylor Blau wrote:
> The repack builtin defines an API for keeping track of which packs
> were found in the repository at the beginning of the repack operation.
> This is used to classify what state a pack was in (kept, non-kept, or
> cruft), and is also used to mark which packs to delete (or keep) at the
> end of a repack operation.
> 
> Now that the prerequisite refactoring is complete, this API is isolated
> enough that it can be moved out to repack.ch and removed from the

Tiniest nit, sorry: I found the spelling of "repack.ch" a bit confusing
at first, as it looked like a typo. Maybe say "repack.{c,h}" or
"repack.[ch]"?

Patrick
