Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44208274B28
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751410; cv=none; b=PD2loFf5PtdM/EBqr5TCpToeBzltSk5gulVFsHasKQvUdD2cNY66TzjtaVRdUhhPGq94/DcOCcVC/IXC3FgWzaOen7n112SbdzRz6shqY2bRWNBewxX9Lw5iPSNsoMHWxAsqfkCMxMcOg54mJ3ZihH0K7KswOtWe3tuF7zYmv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751410; c=relaxed/simple;
	bh=hyO0IYzuxPJN84vdgyfEl0rRglx7PbK9MLZDsYwLKbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RvizvSmI1gaNd1Uq4V6ekeBCjEmKzbc6MAB2ngFSOAaRYzKBYomb3hMYDpbl4luUa3vvZwfiDOejnTOL5QNo98wgB9n0gjSvj8gLWUzi+pUgGi4tq4FLk+AKPEsAbT9Y8wtzn8tcnbFwfbvz4r0IFjX5vGNxxOjeXa3vpS7mGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gwxER25a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNsYgERf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gwxER25a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNsYgERf"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CC11140009D;
	Wed, 24 Sep 2025 18:03:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 24 Sep 2025 18:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758751407; x=1758837807; bh=lzzWxhX9Pk
	ME0Eu878/6hsT/BeSWpHLSp6zLdh8PkII=; b=gwxER25aKJjzIgL6lOPJYYUG8Q
	gLLzEbSWcB+49d4N6Da/Bnoi1sKrVqJQWkxE0Txf/hflD+e/awd6t8tDYcC2bqdb
	1gtpWdo3p/gDp0+WFw6rUpVcEGfw4oBvhaaQ+BQDl3zNjaQkoDeGz2uHs+g/sUuj
	cELzsEaZqrJCQ5Ivp/lO5G3rkRVsXgclvd7e8RCo+ls3hkrjhOTpWvqnnc5X9Wkq
	ChRsFp5T3Kb58r4vGyCtSX9VD5wSNjTExWI6h3dkZhCpULJkkKDhFH4Df4/kf5r/
	O4nzEcCmlvtBZ+1YLKR5zMUpwHZ4xyJ1GDqDia8Ckl/88mmpC1NrFQNgTzkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758751407; x=1758837807; bh=lzzWxhX9PkME0Eu878/6hsT/BeSWpHLSp6z
	Ldh8PkII=; b=CNsYgERf+RtEbukIYYRjjfBMcp4kB98Mc1RohQBba8IcB0TSzGF
	lQ5j7QqbTnn1fSQwPKWl1nzpqjHogHaTT/z3o15WwfZWJymYkK775Iw1BWLB/Dwd
	Gv09TGLoTAd8U/LOsbu1EO8pYd1UaKKtU79eJvOrlj3pmUPaVDLld9J2fLMvC/HN
	6/xozMnpJSKDqXuLdr0lJ65O5kPLreka3V7iNMfkUkom32qgL/qhtF43JpBI2jgG
	W41b3SpfhjnSWJcPMTX9NFnyveEfh/3I2fO8PUOiuF/lysXkgCvrLpBeaRUNS6bK
	+3uup/YxLagmAlUIoP4U/DfJ7qeZAqFqHzw==
X-ME-Sender: <xms:r2rUaJ2N7RxfiLyW7rnWuSOKEakl3WWTq-_4PL3VUng160BS4H4jqw>
    <xme:r2rUaHEaS9S957vKluz5mwelpMbIEDaxzAJgYKGDmO-gtIUBmY0KtftZ6wrhgJGuX
    8em77zBdvdfrWc0Ok2cXpoDQ5zrOtn8rnTBfUNmv_cRDJUwWPBGyA>
X-ME-Received: <xmr:r2rUaO7V0akwN1dcjDjWx-k0Xt5yj4yTV9eqEtLoyLpl2HxhVpd09Mm0NBx4kAkhoRrUwn09vTB_WsCsUzNVn_3HCkiM3RnPnC_V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtg
    homhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r2rUaFv4E0neXKahoG3_0OT5k-BJ-sIdLy8vi26ssfW4MPjoI7JQag>
    <xmx:r2rUaH62x5mdpyP4kMuPVRLGZ0osp9Do8Vkli4kckeyeQpsFmC8FkA>
    <xmx:r2rUaIU1vLaDF7077KRO9bsnRVK1CHXfJUgRq2XSB-KIDmBs__rvAQ>
    <xmx:r2rUaB9bvxoQMqTQDkpZyYwcpLkPzTQTZ1vORq9Tk02dOiA_q4i2nw>
    <xmx:r2rUaPDfG_V_k_ZpNdTLla0UqDXhbXO5clbaI_6AQ8Y62hhd8wu66V5m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 18:03:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
In-Reply-To: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
	(Jacob Keller's message of "Wed, 24 Sep 2025 13:57:15 -0700")
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
Date: Wed, 24 Sep 2025 15:03:25 -0700
Message-ID: <xmqqecrvjyoi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> If one of the two provided paths for git diff --no-index ends in a '/',
> a failure similar to the following occurs:
>
>   $ git diff --no-index -- /tmp/ /tmp/ ':!'
>   fatal: `pos + len' is too far after the end of the buffer
>
> This occurs because of an incorrect calculation of the skip lengths in
> diff_no_index(). The code wants to calculate the length of the string,
> but add one in case the string doesn't end with a slash.
>
> The method it uses is incorrect, as it always checks the trailing NUL
> character of the string. This will never be a '/', so we always add one.
> In the event that we *do* have a trailing slash, this will create an
> off-by-one length error later when using the skip value.
>
> The most straightforward fix would be to correct the skip1 and skip2
> lengths by using ends_with().

Meaning, "ah, this one ends with '/' so let's trim it and do
everything else the same as before"?

It certainly is how we usually handle regression fixes.

There were two topics that touched "git diff --no-index" in Git 2.51
timeframe, and the pathspec support was a new feature added by them,
so this is not exactly a regression.

> This fix might feel overly complex. We can drop this and just go with a
> simple ends_with() fix, but that leaves the needless strbuf_remove() in the
> read_directory_contents.

We can do it as a two-step patch series, which would allow us to
revert the more complex part relatively cleanly if it turns out to
break the cases that the current code handles fine.  But as this is
a new feature in 2.51, it is OK to declare that the code never
worked correctly and we are making it right this time with a single
more ambitious patch.

Will queue.  Thanks, both of you.
