Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F5378D7B
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501072; cv=none; b=jSCt7DvRiEOlMeR4Rte3kL/CIEVDAosOSr27Jd9Anqy54qcoMqqFqx6j+NQqPXL/L1goQtLQFuYa4Fg/go7c1PH3uiNjfYh9SD09iWvQXSZ7Ws6Z5R+cvQJoAet38BalTXatlDZFD5EFwQZ4iDhOSHx2NaCuVsOruB89FH9SstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501072; c=relaxed/simple;
	bh=U01lPinAIsw1vvS5yQgPJzoKg1ncypKnXsT/xV9c5T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXDubPpZ+MPWdXPe3E7xtbb9ZCR22pH/53pRwbzkw1gV7UGJiT/s4nRPVk1AWi+g1ffktOXhbbMPFtAc3bo01KovTgn5jP9eFrsJu86fZEYR8BuCw843l3Cmq7NT/ZLfkARMbpPDKvP18xn0qP8eyse7aUDHSj4caRvzLirdjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=azPpgN+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mp3mNRI1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="azPpgN+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mp3mNRI1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D979F7A010D;
	Mon, 11 May 2026 08:04:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 08:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778501069; x=1778587469; bh=/iu0Gz+5nJ
	8Ul/3R+TGQUg1nrAOym14KhA5lbZ27wwg=; b=azPpgN+GSh/r8ORwrRQfRrH/wv
	rC4NH/VCNeAgy7+yLd7x0sXKhpnymKjfhfSOq4F2o+7wygvWrBQmw4K+gjbPjjfd
	eobXEDbohx52iuUjprvAF9Jk3NTcxzkaNSqmKVFnZiKrRsQCkG91AGbaoKeIYcHU
	QaeKj3QmUa8h1R+3w5JsNGLBIQmCo0dBSuRAJariSkylv32Vu1U1o6wrXx7m+aFq
	TQEfj8rXk7RflpNjzzSzNwL2w6LbfKYjogjXyEf4ZXxjfHXwi8hmxfG3IJejkc2P
	7/wCAvDfoxxKBIzJuWg67/wuGkv5lCm0Ij1++8gaatV8XB398oOBd1YYQmaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778501069; x=1778587469; bh=/iu0Gz+5nJ8Ul/3R+TGQUg1nrAOym14KhA5
	lbZ27wwg=; b=mp3mNRI1w/TtmKW02yZmIllkeUU1f8ZZGiIx8xeVd6+H38F9ZqE
	fj+Alu7WxHu4BbTtOrU6PaZV6qBpFhSWLs4oqdPAwrnSjfXeTNbC671v6vCEHXaN
	AClEWrOX9wbAaAu5OWatq9DJZ5iJgWhy5fBYE/Nwg9lv0zEMOScgPSZO1jUquRcU
	rSXEnHYuRNNZh7fvkEUvDxLDTvMv4XIa0/mSSsL3Y+nlwKYl7dWMc/qFLtUW4Ci9
	8/d2VjIVYATlz6oo2MPPDRzooaDu2aG/Z890TRkwySjWV8L349cFf56BAbw8HlAQ
	KVPeUHWp4It5ictXy8wzvZMhBYXPfR0kVMA==
X-ME-Sender: <xms:zcUBavQEURYOojcdbTKbLvuJRqKAT_0bm9dXcMXrn_yw1lcGFa8XJA>
    <xme:zcUBaoNLtCW61xTi2Hu3ecB2FxTgGu1LatKvsuvkQ_qgtiV4YTfrQoSisXnrUuxLZ
    vv4XPXJyudPlCi8qrudeXcCtPXkppE2l4PgbR6YfpuK07evXuDvHA>
X-ME-Received: <xmr:zcUBaiPh3XRnVJkbFKRVUoNqKY84UMpEH5ylgbLwUaTiRA34qCFDTEypxeeWkn6Zjxeq8w3iyJd03muKi66yIRMuH6FOm-hklKO6R8g4mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhkrgessh
    hpohhtihhfhidrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:zcUBaovRzOkzccfe1iXSrbE2H2FRs57F1q0f57ZhxRg5lFoF7kpvWQ>
    <xmx:zcUBasWV_bCqWO0ThPkDy9oLw3EbR1INtL-AqktVcUOaytlUADbUAw>
    <xmx:zcUBagtEtSJmfk17uXJTECO89yz3aFEdEtbV-phafor6PM4Jbg_ZDA>
    <xmx:zcUBaoXkRlSAngxIEyGzfko4z1Hj5P_dMS1nWLIU_n3UrTyd-06V9A>
    <xmx:zcUBavcEE7SX5nYTnYrj2eaGIWp3EG9V6UcmCFscXg2aad4S7cqQfjww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 08:04:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe30cafb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 12:04:26 +0000 (UTC)
Date: Mon, 11 May 2026 14:04:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3] commit-reach: early exit paint_down_to_common for
 single merge-base
Message-ID: <agHFxwc_L64hTL7i@pks.im>
References: <pull.2109.v2.git.1778480348118.gitgitgadget@gmail.com>
 <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 11:22:12AM +0000, Kristofer Karlsson via GitGitGadget wrote:
>     Changes since v2 (thanks Patrick for the suggestion):
>     
>      * Replaced the boolean find_all and ignore_missing_commits parameters
>        in paint_down_to_common() with a single enum merge_base_flags
>        mb_flags, reducing the function from 8 to 7 parameters. The enum is
>        defined in commit-reach.h with MERGE_BASE_FIND_ALL and
>        MERGE_BASE_IGNORE_MISSING_COMMITS.
>     
>      * Named the enum merge_base_flags rather than
>        paint_down_to_common_flags since the flags express caller intent and
>        are threaded through multiple layers including the public
>        repo_get_merge_bases_many_dirty() API.
>     
>      * Used mb_flags as the parameter name to avoid shadowing the existing
>        local int flags (commit object flags) inside paint_down_to_common().

Thanks for making these changes. I think it would make sense to split
this up into two commits though, where the first commit only introduces
the new enum (without the new flag) and the second commit then adds the
new flag and the performance optimization.

That'd help quite a bit with the review as it splits up the changes into
a refactoring-only change without any intended semantic change, and
another commit that then does result in a user-visible change.

Patrick
