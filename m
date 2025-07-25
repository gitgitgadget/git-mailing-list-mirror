Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAE235BEE
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440964; cv=none; b=IlmW89obJbguIMcGetgG187NzyxYUtE1JT9V2Nw6PdFoUu43j6rZKHMAwH8cznDVe/uHcHieqjdX0LFHXN1AMqfejXl3VNAQzPPQuBpNG4z68bF6v7PLPLh/SlBGevQfBoM7yaIijCgeTHH8ta7o6YxSEzio2dc2Fk8KM/SBx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440964; c=relaxed/simple;
	bh=jcKaE3taPMVgtTbNlU3xeZc+LLCN3gO4ecbP9v0Mfmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3G+sZXB9U1bA2lbzIw/3PTCrq2Pou67o10c+uugUxmEAK00c7HN1XO09xrZhkTKH7FLsCDKQxbEQQk1ZQmWPCWwQF9LSmcvn8KKcLFpkjTuSFTp7W4k8JAgCVpqdS0inkSBWbOYUzn+IlqEX9MvPtL7MfoKDN4LOJqzeJOb47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b7+3VMAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhUdPS6L; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b7+3VMAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhUdPS6L"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B6D1FEC0631;
	Fri, 25 Jul 2025 06:55:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Jul 2025 06:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753440959; x=1753527359; bh=iJq8TCDhdr
	HjoVqxpWeFz6qZj8fcceriQJw4SklKnMk=; b=b7+3VMALdjprosV0gpqnQ8Un4G
	721KnH1riT9qiWNppNgILERMQQpLewVdYeZbw1RfG0nebcID7KnxCAUZOJBFjP2t
	0wpbV6JS6Lns2ndQDKVr6X5zoVJaxmKjeSsMa7QMDJvaS5lto+1fyS84Ne4esq/s
	Aw3TTdUVXSnIuZKGLpabTj9Ujv6yGx44LG7kbGJP4U1pzcFrvJhILLl/W38nTRw8
	WuI+nb+H8wzb7VXcJmYNARgvtiXPMO+mzkT16IIVT7rPa8MDzqZbBmV50UFDD+4b
	1C96p+cqCUEdryMzXF7bFjS6Q9mRtBh0nnfoGJ4f0wkEPQ2D5BgsE2FRO1bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753440959; x=1753527359; bh=iJq8TCDhdrHjoVqxpWeFz6qZj8fcceriQJw
	4SklKnMk=; b=RhUdPS6LDg1m6wwOUehJd3QDMY27CCEMCSthv/OmNI9g5FPTED+
	A0piK3Gj0kx7DIHjH5olCn6puw06k7pDBYaeOp2BYES3HWSp8JO6H4aQZbCu5Uea
	Hss95eBcA4PHmrSdLwSgYWWWmQRUHUksDjgwFSjLkq69t8k5m15KM1/AJ2Qojtvn
	h9uergfzIHUlIMKNRURymZws+zcP4Qp3D2277H/tzaoke+pMTkcKji8w0hiz9lIX
	t9KikWvH6LIVIIk7T4jkVZJ1cAtAAJrdFGgNfBT12CdFCQAAGCraer4fkI5tzXf+
	mfzJXTCV3UdJi4B9bKtnNRnMaC5E6eFZBIg==
X-ME-Sender: <xms:v2KDaNAUDdBQaLIfdjHVCVpPGcKDtvdtTOsm4JU7VYngRXyMETiAdA>
    <xme:v2KDaOzEghqRRucYqJv0INy3qTXJgRp7izZriCYH7nycvJT9PpBb6E8xhm66YttuY
    thPRahFUaM3TDJRQw>
X-ME-Received: <xmr:v2KDaCBk9ODQe0daATXENlfdw6itsPCi2RZvLD6fSWqpL_SujPRSRzLNApIXe276CnwIeS_WFSacsg0TF-1L0Z1JuUylkgY85MpUgGlUn497>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:v2KDaDbd5NEdMJYruop9zRWa-gn1sXZioauSajlf5Q5XBugsstW8aA>
    <xmx:v2KDaCg1islJKzdrop7x5qezs0_27nWHfsokDsk2q8x3YgREAVyBng>
    <xmx:v2KDaN6bTRppNn4uDQ-GdJ_g2UH3zxNIzz6su2kKKYUoxcvN83p8Vw>
    <xmx:v2KDaB6S64So-27YF5HWWXx_AnFfg9vrqEpaHhKvh7y7MnzckwANzw>
    <xmx:v2KDaHYYGjAMwnO_KfxT22_bRYICpvcBK3IgLZWwR0GeFdMham7yVZGb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 06:55:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75c5db56 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 10:55:57 +0000 (UTC)
Date: Fri, 25 Jul 2025 12:55:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] for-each-ref: reword the documentation for
 '--start-after'
Message-ID: <aINiuo4GWlW_1Fd-@pks.im>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
 <20250724-kn-small-cleanups-v1-3-0c70f591de3e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-kn-small-cleanups-v1-3-0c70f591de3e@gmail.com>

On Thu, Jul 24, 2025 at 10:14:44AM +0200, Karthik Nayak wrote:
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 3f21598046..79a79212c9 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -45,7 +45,7 @@ int cmd_for_each_ref(int argc,
>  		OPT_GROUP(""),
>  		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
>  		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
> -		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-start"), N_("start iteration after the provided marker")),
> +		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"), N_("start iteration after the provided marker")),

Funny how typos like this frequently go through reviews without anybody
noticing :)

Patrick
