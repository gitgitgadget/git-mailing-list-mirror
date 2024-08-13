Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8C17A92F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541139; cv=none; b=uR3QHAFniD/duDDNmZQdGlNs4LdX8AEmuN4DWPieZxOggNYh7aBbRbh2EDzfUyuc+Vi98l9WiXokFVV4HVhy+NYcsVT8n4l3emijPQqPwO2gyBz0rHk4hgx3pHWc2TGdTFyYKvFQ1Nmt1A5Q/04R7cwQ66+QclhIIpn2CtadXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541139; c=relaxed/simple;
	bh=473DEWWJ4gsbvH8YcYMKqAmlRVk8BPaT0Ltcm5n6888=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2VskHksM6k5jQmbnOp4aUjf/HO2yDnM7eFP8HMMP4Je/vg/07UCd+zAV2XPYwi7UrXYY/qCkMslNO8DX7KNTDvdCgUFUDqn1R76b9lp1ILR4ibCa2IfojrFkuZ2PWVAdwgg0g0i5l0k9+NVqllfHUSG5y0nL9SXqDhALwoUWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qKCX5yfd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5QwqV26; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qKCX5yfd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5QwqV26"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D4DB3138FD09;
	Tue, 13 Aug 2024 05:25:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541136; x=1723627536; bh=+gSOY1O1LZ
	eq+oQuJd1a5GbPIh7+2n4l+MhekS6XmC4=; b=qKCX5yfdNL0INo0CeH5XmvHC7K
	amNQISlIFrRY0nukk0dRlDRCv7qwLbfidAVm/CWw0Wvf+Er1AvYkGIPQVoiHokAF
	4mtSmKRQsMzkFPzWGnR9QD+J3wXIdQDaQnsrVnUeebrQv8J74FjdEHvCGl1zIcyg
	LyAnAchdW80CNdh7L/eQ4LLMv88f6rWkLShJRr//3C/1eOkjh+W7Fq+QS7WKJR8J
	1G+98BsVBkQ6ilaCyVSg3sQju5emEwh8/gb1u85yI2fGH7mq6l+9ZFiCqdUt+1H0
	6J0TfawwPSBKGk4wneS9nwlQcdUw81+7hqjvhldfQB48uocbrPZMmzw16R/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541136; x=1723627536; bh=+gSOY1O1LZeq+oQuJd1a5GbPIh7+
	2n4l+MhekS6XmC4=; b=a5QwqV26VJUbGUCQhAw6SYnvUpYJx1WIdIBu9yrj22q5
	i1zPuLHihxQKByChI9UvTA5+aTOf176B38mS6ZIFZN3gK3a33bnIGkzw5DVvYfcf
	NyU6VJ8mBUBNDZSEKoq886R6LxNHI4sdcjsjvJIDKpx5U/lyyjNt/o8H4223rLd8
	RUe9Po8MkkLb1Zwm0Q5wZRkbwapdTMIO8Zv8JmJfrh5lxvgQ7/ezILFXH9QKGAsA
	5riw3aHqtHnD+0V77i+B1Zy5M5O0C9Md6UqdAlAoERLFk/+o6gmvrJ2Qq7o7zNKz
	C5F5beRCKaQc7J5/APIRuC3z38b2c/oJf2i/hRyUKg==
X-ME-Sender: <xms:kCa7ZhcBiRX_X_Dj03Ju1V7bfqEFPwNkLjyOXImLZ76Y4OehGYnsVQ>
    <xme:kCa7ZvM8en1h5jIST83KirOf4_cHegL27OxC6FXw18eozed56TFPP5CQrn9oAk3j6
    lYfo5u9DZPtyvUGIQ>
X-ME-Received: <xmr:kCa7ZqidMiHR2uFSli7TGubLhwHLvCdsp_ICJtj-KrwHc1yeX3yMlYns7Wq4eY_Ycsit59-lANyZ2TcrXoI7HOnhaFnJjE8OxBE7jD2NG3nmQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kCa7Zq989edkCQpELHXKhOq-PrG_vveyX7VBDNiAX2nL9NJBGjnn4g>
    <xmx:kCa7ZtsUI0HKNiDYlRjnu4y2Qb7F9N9HOTYZ39lXOw6SBGXMO6s0bQ>
    <xmx:kCa7ZpE_d-Wy7ROCiJ6vZId_obALicOcKWJemllUiEGVcNIRBpe4ZQ>
    <xmx:kCa7ZkPoK6G6VvrdUJshwA2SLIcqMRnWAxx4WPp_oRryzx6_Urxn3g>
    <xmx:kCa7Zm7C6_TknsfscqTHGcTW16UX1ojkwJGdUhJw-c4_aES98x8-BGh0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:25:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a19859f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:25:19 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:25:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/20] path: stop relying on `the_repository` in
 `worktree_git_path()`
Message-ID: <Zrsmjl7BVWhxuolz@tanuki>
References: <cover.1723013714.git.ps@pks.im>
 <67405dcd0a121aee971f854dc35ba89bd4f808c4.1723013714.git.ps@pks.im>
 <cqc4xlbrusu5edfsh2snvekkd2qfwjxu3x33pzizp22rsuidbw@pz4e3fsqfhgv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cqc4xlbrusu5edfsh2snvekkd2qfwjxu3x33pzizp22rsuidbw@pz4e3fsqfhgv>

On Fri, Aug 09, 2024 at 02:02:21PM -0500, Justin Tobler wrote:
> On 24/08/07 08:57AM, Patrick Steinhardt wrote:
> > When not provided a worktree, then `worktree_git_path()` will fall back
> > to returning a path relative to the main repository. In this case, we
> > implicitly rely on `the_repository` to derive the path. Remove this
> > dependency by passing a `struct repository` as parameter.
> 
> Are there many situations where `worktree_git_path()` would expect to
> not be provided a worktree? I wonder whether this implicit behavior is
> really necessary to begin with.

Yeah, there are cases. I found that to be somewhat weird at first, but I
does make the logic easier to handle because you don't need to special
case whether you do or don't have a worktree.

> > diff --git a/path.h b/path.h
> > index 3d21b9cd16..6228ca03d7 100644
> > --- a/path.h
> > +++ b/path.h
> > @@ -97,9 +97,10 @@ const char *git_path(const char *fmt, ...)
> >   * Similar to git_path() but can produce paths for a specified
> >   * worktree instead of current one
> >   */
> 
> Now that the previously implicit behavior is more explicit, it might be
> update the comment to explain that the provided repository is used as a
> fallback.

Good idea.

Patrick
