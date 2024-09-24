Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45C42AB3
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161372; cv=none; b=oyzNPS/gn5gzRw/lrXVwXnw9dgBJHSuH4CW+iKqX855Ab73xIXc90Ec1gXR2zzxOL6zunlcT/gYLSx+5CfvhSwkisaL3z9k4UdpMI/gNlXDieKBgRzRRq+HS7i0zvDkKIKEEhvAjFYVGyYcdKLA0s7oQKKslqV1pM+BoOHpnhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161372; c=relaxed/simple;
	bh=7eo5IiiMppOn84aQvHdQwTSiJSvMioDjbSFBTB7wBrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF5JLly/59Didi7sW8Wst/MV2DoNy1I/N4K6YVa1km/OA4UVAIE60/D1dcD2ytEVVLs1I/cf651h7fEyO8eDRX3Ep7C8s0MuDrJaElIQowXsvmnjvZDGYZcBKxWl4mVsXBBaYjyN6iJcBxzrDl/cdaYevUdV2Z+ZUV8BJeWkTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mI02LZTl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0UjB+au; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mI02LZTl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0UjB+au"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABEF4114024D;
	Tue, 24 Sep 2024 03:02:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Sep 2024 03:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727161369; x=1727247769; bh=mUUCdI1gi5
	/13+IzUGiK51LkrpoqTap3rmx+3IEHl0E=; b=mI02LZTlnIpjpdb5lqlFDib6TU
	cu6qIIL+wSklJfx9D0mghsj5KmtEB5CcYNr2DVwTbnhuloAtMwDJiCtyZlhrZ6sj
	MjLTQIAziGwPHjQjt8kbhBdmfYqlep/WneCSBpneXw74dagQKm/fxp3LEcg/S2Yj
	IXOQfRdSbs1ydcCowHYRNIoWEW2LhJsHTJFcGhKKodtF6aH5otoFRU7s0iyfA3aU
	CrhpM68qGO4n1b4kctzX5odGIch68rhjTJTEl6kXnr4aUDu7MPR/Wmh9+j+fzrTx
	qIYkzEV9Saf1ZMFBmz3oST3M5wdDrQ3Ex0vZDONNXsi7/adRI1Fa0Mk+XFnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727161369; x=1727247769; bh=mUUCdI1gi5/13+IzUGiK51Lkrpoq
	Tap3rmx+3IEHl0E=; b=B0UjB+auenq9UPwL3tZwM9tA85ixjK4J/30us/gMuLWf
	RyXei1rAKtSr5hvjCsjCZorlk3IqRU4TM7REbi7N1Bl6+ySClvG7kOhUC07skzM9
	jC4U3QEcfKaesXBib2tdGyPXunBynFptuVJUUR13zg8vW8eM5qticWPVBODZ3oo2
	3GEfJNfSL7Gsy72vvkbr5JGu0/hRnRCg1qir1LE/72kB9pKlSZe26odd5B6MsDE7
	nBf7b8MHC3p8alm/0lZFuguiTu/IvAQ5L94fVheTSmHwTxz1YK9odIMNbCXLQ8SS
	w59pVobTfGRV/KzPqS1RwQpqvB+j7HEtzFHnvGN6pA==
X-ME-Sender: <xms:GWTyZq8PB8G6o6CM_FZ__JnRE_szb_6EvKKSS6DRGr_oSEk2CwKjlw>
    <xme:GWTyZqsDYwd1SwzAL1E2RF29R8VXKiGpThnv6Cup7iN4_UbsiIcmYU8r9vbdHUayP
    RnktR2qaR_SsPXyAw>
X-ME-Received: <xmr:GWTyZgCKeL2VSFxdWG9HvSAE13xncecXj1b7CVttdbjvO0fdxFNMDTexDZpZ5x021Vv-dHSkM9vb5nQud9xq2-DQzAOF5abt0mfbyueyjMG_kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GWTyZicuMnXPTIWohLuGX4LICP2m5bdEeJX90MjDdgwYZ8jpF4H-FA>
    <xmx:GWTyZvN0DJZLPy_CuibOoasfzRdoLRrANiiMyXNjJRt2Rr1QpMyyDg>
    <xmx:GWTyZsm5Sh_8rLFqoggzv6om7sgXK5_x_9hA9FICePURHNkkegpXkw>
    <xmx:GWTyZhtCpXvIiZ2Pp-r9HJxxietgv8bmYx1flyeHdxLSONCG89iTpg>
    <xmx:GWTyZqom28yhtVopw6gA-mzRthA2KOXMiMxwaN-baTo_9Vv6-hxRTrmt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 03:02:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99b6ef18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 07:02:12 +0000 (UTC)
Date: Tue, 24 Sep 2024 09:02:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/6] test-tool: add helper for name-hash values
Message-ID: <ZvJj7PeB52m_1mG9@pks.im>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
 <7e47fc8cb53647ad92c86801204c3089a5dfe8e6.1726692382.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e47fc8cb53647ad92c86801204c3089a5dfe8e6.1726692382.git.gitgitgadget@gmail.com>

On Wed, Sep 18, 2024 at 08:46:21PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
> new file mode 100644
> index 00000000000..15fb8f853c1
> --- /dev/null
> +++ b/t/helper/test-name-hash.c
> @@ -0,0 +1,23 @@
> +/*
> + * test-name-hash.c: Read a list of paths over stdin and report on their
> + * name-hash and full name-hash.
> + */
> +
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "pack-objects.h"
> +#include "strbuf.h"
> +
> +int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +
> +	while (!strbuf_getline(&line, stdin)) {
> +		uint32_t name_hash = pack_name_hash(line.buf);
> +		uint32_t full_hash = pack_full_name_hash(line.buf);
> +
> +		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);
> +	}
> +
> +	return 0;
> +}

This patch breaks t5310 with the leak sanitizer enabled due to the
leaking `struct strbuf line`. It needs the following diff on top:

diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
index 15fb8f853c..e4ecd159b7 100644
--- a/t/helper/test-name-hash.c
+++ b/t/helper/test-name-hash.c
@@ -19,5 +19,6 @@ int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
 		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);
 	}
 
+	strbuf_release(&line);
 	return 0;
 }

I also plan to eventually have a deeper look at your patch series, but
didn't yet find the time to do so until now :(

Patrick
