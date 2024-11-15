Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B7174EE4
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654676; cv=none; b=j4UfHyqdbRXHvqmjwhyPDdhSBUgg3C3vBZKv6gYNmi1dV6Cix/w/RZDSjVnOHSa5AklNcaHOe+1EGKsvvqvIyHJjVumdEcMyFmPXfJgXNzJipCZqSqU7hHiIKrySDjQSeuYIawmHua4ShxRj/WAFvrgqwtNbBgqoNdCVrw0D3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654676; c=relaxed/simple;
	bh=fg603K3Rk470GMn1M3d9szu+BAzS5UZ7ktSSY72cwQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMB1a4qHTJmKEUBZQRukZDWlF4+qil//3y/tSWMsKPWU4TIVxpcnU8SoXNmCirI+Oac07F9ury69pG6VK4CYDaMAJjgUqM1mbGjypLg+kwW/hStLWOxtI5j1+kRdYGvw+CicHzkM89O2ymLSil4C8axJeIxH8E1DC7JX6Fltym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O1xEvHU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKXR1XuJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O1xEvHU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKXR1XuJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 62BA213800A7;
	Fri, 15 Nov 2024 02:11:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 15 Nov 2024 02:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731654673; x=1731741073; bh=6U0tCepxAj
	1LS723RjyoyuRAv1laDUCSmwb750G3zyY=; b=O1xEvHU0D9KX3pPrY30wYgE0ZH
	/nigJxGa2y4l1xJAHqWYU6UNjIeAY8CRpiZGpchWcKnaaWOLE+rcTiMb+X1NW/0H
	bOoNaC/T9kUPyeHjoe+S+2dJxhPhzOKuc3LLNNUyTW9gULYVn+0nCMFdFAJJvIXH
	hxQXM0oDVeHJVV+S+spP8QBcxuIKySoHT/zjhQ+n7iWWnEnKDpC2qaycIqjEIICQ
	/xGr6oIrkOHGuhcvPSe2Ct4mumtlhYEkTESOzf0gkmQ40403HYrVNv734gKfFfga
	bR6X+WTooytqYPrThxzPOLqC/at3bv8/jS9wYdLM5BZ6wiKrOE3pp08S6kSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731654673; x=1731741073; bh=6U0tCepxAj1LS723RjyoyuRAv1laDUCSmwb
	750G3zyY=; b=lKXR1XuJZWo2WLRBuLXbUrRmCP29KNgMNymNJSP11AGelCjsdcd
	vrrBHiAyrEctuhUPjrD2Pm0zdqnaeA6qE8NWlBQaQi2zAxFsPgLjvEQz8RUfpake
	inXdKxLY6kU1V4+LpwA8r0SOpdSyfvN26OvgImc1Q4l8edghoMd+zNU3oWGNSiSY
	D1R6gT7RCzdUyi4jfayF6ATuuwe7JlOi0VYR86pvMAgulqyoRylbFJyYlrVFS1D8
	NC85JtL3mPvxJA2l93BBPTiMPXqErkgWPyxEumvEx5iNVO1VBJSj5H3Z6C46Sxqk
	m+xkQPW1gLQIt0LrKdOoHLQRF+i4luRvm1w==
X-ME-Sender: <xms:EfQ2ZxmGFbJyuqeJKpJOLIe01BsK7T59pPu7g3l3uRMIKv2BAqaZ8Q>
    <xme:EfQ2Z82qpr7GoalGO6SuYatzHjIVQNtMQD9pdKfZQOfZl9VZIUQ4pdbluFFKx0rHG
    Hig_iZkrNt9_mdwVw>
X-ME-Received: <xmr:EfQ2Z3o_xxwpgT4RdU2utEAHXJVyLFpR_Af6CthXlb6NraJVP6BrFwwkZfnrOZKEAd75slrYB_v11kITRMzQBjtfEJv0ln7Bftk3NckL6wjysReyBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EfQ2ZxkPOdlHLkgX8QBb8_r0O4uCise0dCrOYOOyqxZHKT6oqHSpZw>
    <xmx:EfQ2Z_2nK5ZSmE4HN2kl7fjsiqcVmOtCJexd4f_X5iY6XFnd8ATzQg>
    <xmx:EfQ2Zwtxpu0l3SGXy6JU5jemsFULsY-6UqCy2NxcVZpruFP5QvQydw>
    <xmx:EfQ2ZzWVL-yGO7ngEhRxdaelTJNjoSqPDGWvlAB_Temo1FJqDFiSGw>
    <xmx:EfQ2Z6S1aNAGRBTfcG67r0pE0Qjayvhw59cp0fAK_qt3yUgA8hL74EMb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:11:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8106df49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:10:28 +0000 (UTC)
Date: Fri, 15 Nov 2024 08:11:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 5/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <Zzbz_4Xqt39JZfgU@pks.im>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
 <ZzYrRExrs17rapOb@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYrRExrs17rapOb@ArchLinux>

On Fri, Nov 15, 2024 at 12:54:28AM +0800, shejialuo wrote:
> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0 ) {

Nit: there's a space too much here now.

> +		/*
> +		 * Ref file could be removed by another concurrent process. We should
> +		 * ignore this error and continue to the next ref.
> +		 */
> +		if (errno == ENOENT)
> +			goto cleanup;
> +
> +		ret = error_errno(_("cannot read ref file '%s': %s"),
> +				  iter->path.buf, strerror(errno));
> +		goto cleanup;
> +	}

You report `errno` twice. This should be:

	ret = error_errno(_("cannot read ref file '%s'"), iter->path.buf);

Other than that this version looks good to me, thanks!

Patrick
