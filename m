Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F11F1537
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829593; cv=none; b=tQIukJGDBpOogdJZfziq+X9GjtsiPVNsCH9LYTgNT0GDA6dvjjb6FfDqICLilt4c/9F2f5R5n6dfVwOoDq/KD9kejChIhcfSUqDNDw8Tv0YLPNi/V1D+r0FncOVZ+jwYkltbb5WfLtzMvZzq6WhodbQ+oPTXh+TFowX/ExAw/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829593; c=relaxed/simple;
	bh=vO52R7y7+5u9Z34cvotGAAzPmPYtFTX8Jd3sFTUBvC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0HfZ+TZMrbYwLApLcms21DaQzs4dfZc9iuSp+NOtBbfMa8xTgFWQkRNiS8EYa1ngH882bfNOGEnizzV6kx2pXjFgKFkc85zP3EBswvTZVkkndFb2lZoRPm2DsspARchwDP3fJzURU1T5wJoooF1j6sZdKO/3Y++ld1SU9Wbqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FN+X3KT6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHkuc4d3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FN+X3KT6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHkuc4d3"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 43B9913801DC;
	Thu,  6 Feb 2025 03:13:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Feb 2025 03:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738829589; x=1738915989; bh=vO52R7y7+5
	u9Z34cvotGAAzPmPYtFTX8Jd3sFTUBvC4=; b=FN+X3KT6LGwbtzm/y9j6Txxvh2
	77gjKOoctBl6pVYiAokwupEYPMuoGTgffZeo6EESzWn+0Fil4f59X/4IOHRU8349
	gHNkIzi0B7C3u4nsZ1MadPL1111Ps/4ftoRU3RdheSLAJAJeh5Hoz2QvQS1xsqe9
	23ox4x5NZ1vIx5ycaPqjNRKEIfr75tbyglO4M6uP9B1BP8KhjlSf1RSJJwmw5Dlu
	Comhue/43vmjciBUmI/u0zLnYTxMNXIsQ72j9Xed3TxOHIEEApSa1DxQptTANRww
	ixlFPs7idZM2j9/6+6Nh2NhH4S4xOR2Fi5qVn3YWvW4UJSdrY/7g9p2WZ70w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738829589; x=1738915989; bh=vO52R7y7+5u9Z34cvotGAAzPmPYtFTX8Jd3
	sFTUBvC4=; b=PHkuc4d3KieHnip1jqjGZGoFe4D8LQ/c+u/A3fYmn/bxcsXtDv+
	tIqZjdGVEBwOmuv1aEt8CjQIlVjMkqSMpvaGrkO1s8RiDmhmTcYDuZAruYsZj83n
	W+PTuh/WPtLYuVr+wR+jJ+KIakD4dSIlpWPwWrozH8db1uUGMc8wEbVfmh11gHyo
	07mvNS8zzchNsbBnOPTQWxfSOFKh0rp+v0nYphIBftCRYA4u/YiUsxVPNDqeozfU
	gnJgkiA3QcjOrdztpTkOor1/AfFVWKO9bAQA83LG6FnbnFdus0eJ7cewDkXqndcQ
	PemHKjwcygWOnb6xPg13ETNCa9CAVCoRO8Q==
X-ME-Sender: <xms:FG-kZ8xgizmJFGe_hsD0VdwaORlXCjvZuiCdMb3v0hAzuPQ0YMjQLw>
    <xme:FG-kZwSbVSXMoQSIzNCBdjP4mtA2VC-p-5GseJdQOwCLhYPHzmkQ_iknokIcrOnJX
    kqtl-ZSwEzOCkRZJA>
X-ME-Received: <xmr:FG-kZ-XwyCW_JS-9WCcgUsp_dWuQi-OkSxZIaUUt8Uaqy9WfhqcB-MBPKkrWWQ9UjzR5mmdlcLtYODQEOHn19OqY1ZtW0z_OPB2lFN4qgdb5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    hsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FG-kZ6i7-4zLYKiJBVxtoJB86X2rwrGYDivK7ier_JZwjQfmefZa0w>
    <xmx:FG-kZ-Ca6xwk3V5GLNJN-Nd-bc00y0gYP_bupv4asy_dnXeU8bHW2w>
    <xmx:FG-kZ7LN3ISeGIh1K-2m6aLtmB-PkHIA-P0XasDX72qkCTBBua7eRQ>
    <xmx:FG-kZ1ASh2HthaNLvbdhYZHzmw6u9bsLRbhSuRgUubtQoQ4rEDGpbQ>
    <xmx:FW-kZw2RAruoOZ-Uk5D-DX1LfE67QGn71MOBlMMRMyf_x0fDfQ9fjCuv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 03:13:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e898116 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 08:13:04 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:13:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 7/7] builtin/clone: teach git-clone(1) the --revision=
 option
Message-ID: <Z6RvD4FtfXIk4Pa3@pks.im>
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
 <20250206-toon-clone-refs-v7-7-4622b7392202@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-toon-clone-refs-v7-7-4622b7392202@iotcl.com>

On Thu, Feb 06, 2025 at 07:33:35AM +0100, Toon Claes wrote:
> diff --git a/t/t5621-clone-revision.sh b/t/t5621-clone-revision.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..d4889a954e6300e0e327ebe7dfcf73569d966829
> --- /dev/null
> +++ b/t/t5621-clone-revision.sh
> @@ -0,0 +1,123 @@
> +#!/bin/sh
> +
> +test_description='tests for git clone --revision'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=true

One last nit: this line is not needed anymore, as tests are required to
pass with the leak sanitizer by default now. Other than that this series
looks good to me, and this change alone does not warrant a reroll from
my point of view.

Thanks!

Patrick
