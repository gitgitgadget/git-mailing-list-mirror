Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFD14A60F
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027685; cv=none; b=eU1tewnJrhhvEmle7zeuqC9ypjhW7UNi54c56vOQlWBAmey6z3hIq8J8Sh8Tgenqq1H42cc71rxaGYBHmKwjdaRRdnM60kNKhqGG9z9jYFSfgClgK0prMQ0wdkVj3hVaFxr1DrUk/wGF6VB0wKpBVpOGUGxrxyUvzehwICSVNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027685; c=relaxed/simple;
	bh=rZe+9OhRSQjUw/rO3LTBPsswqaFGCZNvpNT2Js1yL7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWubKqj/mVjEPmPrWDb9NriJNzEVE30f4SHlu2iDP9qqlqCwj+ioL3+W3JglVNeKAsY6d40domGW7sXkOKXsPdyoFEfvKDLneTtbfqLN6P3IdX4UUJMXkD96n4PKA6bopaSeRmrsj0MWw1hUpNxJHCJAv7e5oZ62YjmUWI46zbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G+GA5qx+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYbSnxxF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G+GA5qx+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYbSnxxF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 756971D00B10;
	Fri,  1 Aug 2025 01:54:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 01:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754027682; x=1754114082; bh=Z2DNjtU6Zr
	eKSMpE0LAVBG+fmLt+qHPoQZxl0DNdYX4=; b=G+GA5qx+srEkYhmQYP/sJn4Lb5
	RD/dw1lRcF6xhuqMUUC14FaC8DvpGUsupi2uz0eki9pBQ/MemW7ZWrMOAzILRVfn
	6RYHtcYIjIdYAO/cIbwq6xvJ7EkJqKHrs/qNRw5mUmegZxr6ZbpRZYrRMrCb5skL
	Q+bkE8Ndv/FhAIOhngA/z8YcmqglAxEDALic8j3VSqWcK1ylBMbJBPzWph8nglME
	G8zRvvLKWSNJW5Pw+qHZpSHqU355SL8Z+uj7+GbSMQPs4tfieHxCyGvGmvswIgAt
	xj9jCkmP9HHhu+Wr+VlChTJnNapecMEYt2+8pL1J43Pox9UQJuwmq/wwfRCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754027682; x=1754114082; bh=Z2DNjtU6ZreKSMpE0LAVBG+fmLt+qHPoQZx
	l0DNdYX4=; b=DYbSnxxFT1ibIRTBf7Apbs4D/eEw7Btesp3ijaR/iaHRge3kbjv
	mNYA0mZl+U4jXi6/iI/HpmjaiommW+STJlBWfTQX5A+NZap0GQ+R9BGUcYZgUsYz
	xZ0iqTPL6uxRikfIsGWZ2x44nzUX+vckjJbeq6Lfae44oWC3CYlRRIr399/T7XND
	QsHKXak/Y3juesrzoIkB/orem13svv98LAbCESOXvvc3nyn50L9CN7zs7S/u+k7p
	rPOZb5ahwL7Nx0V5DxyBcHE4GA1dfEA+6F6mU0RlWeNdo23sNHPIqd75zxM8e+zB
	KlJIYXs9FwoUZAfA4iJPpDhHMiqkCTiUR1A==
X-ME-Sender: <xms:olaMaFGAhjn_n4btie9UoI3vUJ70uVpX-4c6A6XNaiZgnrYub3-y7Q>
    <xme:olaMaHQmxnElbjgIBlBMR3umg3WLEqlcKSfui3Rb9_aACZKiRyB0cQtWH2i5qqvlY
    9Xkv_u-JDZguMYvKg>
X-ME-Received: <xmr:olaMaCy1w_fZB1PHhxOW4gfawk9YJeqrWObHjJqLvL5NMRmVvzY1D2hwKF9-6vBqrZKs-hYc4zDRsFjgAIC3xzfiaWwLTHfcyyck_2vuF7h8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvhguhigvsehgihhthhhusgdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:olaMaDc66KeL4LhLw5itVhe5TuO87zPEzNDl3oFVQzdtVFCJo9CoLg>
    <xmx:olaMaFMxml9XkHRwtGrQwm0oMmKHNDLaTGXYdtHtfBxPUrCzRtlMTw>
    <xmx:olaMaOviPjIsww-zR1E2JGPhcDD6_xLlqnkm3WQ9MLldCU4ReJarcg>
    <xmx:olaMaGCg_RGPikP6Va20uRIjSOJqk5v1Jl6EafEAF-41H4Dd4Ut9Lw>
    <xmx:olaMaH1K2RzKHC8uQ1YZwv1Eqs0UMjifTiVr7sHwMy_ZssdlniqRXupt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 01:54:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9622aa16 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 05:54:38 +0000 (UTC)
Date: Fri, 1 Aug 2025 07:54:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, karthik.188@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Victoria Dye <vdye@github.com>
Subject: Re: [GSoC][RFC PATCH v4 2/5] builtin/for-each-ref: factor out core
 logic into a helper
Message-ID: <aIxWlX36V6DcxWa0@pks.im>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-3-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731090040.1625303-3-meetsoni3017@gmail.com>

On Thu, Jul 31, 2025 at 02:30:37PM +0530, Meet Soni wrote:
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 3d2207ec77..bbc0e5ad1c 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -7,19 +7,9 @@
>  #include "ref-filter.h"
>  #include "strbuf.h"
>  #include "strvec.h"
> +#include "for-each-ref.h"

Let's keep the includes alphabetically sorted.

> diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
> index 06b469bdee..2c6ecd5fc8 100644
> --- a/t/t0450/adoc-help-mismatches
> +++ b/t/t0450/adoc-help-mismatches
> @@ -17,7 +17,6 @@ fast-export
>  fast-import
>  fetch-pack
>  fmt-merge-msg
> -for-each-ref
>  format-patch
>  fsck-objects
>  fsmonitor--daemon

Everything else looks sensible, but this change is surprising as it
wasn't mentioned in the commit message. I see that you changed the usage
though to match what we have in the man page. That's a good change
overall, but should probably be moved into a separate commit so that
this commit here is not changing any behaviour.

Patrick
