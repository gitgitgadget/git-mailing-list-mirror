Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00180244675
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617356; cv=none; b=ZQSOrzfKkM+G5Vo/CUAVm0s7s1GS6OqeUAEtsny08EoHjBCDCwYYio0H5wxO+O4j0icdMY4csgdY5Je6djY8RpqNPzIvboFiOl/bpzi6crbP7YgttCZiKHQ9Ed1cJ+Ew/ud39uLAq0VERpux8XGfaFzzPTqwu/PhpstwnFJxKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617356; c=relaxed/simple;
	bh=bljc8vhyfl71/RbRrQ+0e0NQ1HVIDiHXGlcmQ8fHUjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DjCUfj5UGsfE8ALwPqDhIui2RavuSn4xfksFcAsEdeBcQmOSFlaXHJDnbEbM3xPUsQCbei11zoSh46lskSDMV3jGgqkpf2MC7MYPEav3XjnnhhARncgXWyfQBfblOoD/QHs8LA9pbfdKcp7tawyX+IBm9jmU/KYKkuhvgtB9brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hClQzZY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cYTO2b5w; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hClQzZY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cYTO2b5w"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DB1D1D00270;
	Tue, 15 Jul 2025 18:09:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 15 Jul 2025 18:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752617352; x=1752703752; bh=JPK5kURwzo
	670uncV04onP5E+/xjMPjFi2dqsGkl37k=; b=hClQzZY6Mfc7Ep+9zIBHX4keC9
	ybOZICC+SEYkDNBwsvVBxU5NJ1WNXD+DEr/3vW2+Io/js3LiDRJ80ZwRz8jxvosy
	rFYS3DbWpEPBxOsRvODoOUdz9N7/k04Zumj7oQoKF0Awh6I5bBxghBl59sOIyS0w
	+6qf4HsiPuhrVHv6cdcMZfek2ivKfD5WDTzOSk0NdtWIOIoBifH8VZzhHj0RcOOz
	AMS19WRi4U8+KfACDlt8D4pJvIP7ELnxNBSpt5OF9oZbltDAkU1aFV56R8MWpbjr
	Tye+oyVv8R1h0TaOLSLRAJ+CmElaI+SU5DRR6qOMLluc+N2U7Xou19K0212A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752617352; x=1752703752; bh=JPK5kURwzo670uncV04onP5E+/xjMPjFi2d
	qsGkl37k=; b=cYTO2b5wvYPNoODRg6zxY+tNGedEDv7C8pxULZCl13KCmHnxseC
	dDoehjAaBiX+HpmBn2+cbFb3zKRedCqcNoeDkUftei7D42FrBW1+zmuh8NyIlMvO
	Hhg2+PwawkUe2svPbc8DeYEheqYipf5MvwQCzUO4o4ZB9RJoE2Uq2y/I+KkEfY9n
	hg1V4ZAxKX+0RNAZ2fk+Jo1SDuetgfGPhTNBmAT5xbpbDq/0N4o3Y6g2OqUs+uCi
	Z6MsxqOVZc3IeoCHfrgpJByrXmzX1yrsSawN2ZeJ/5m5SmneqOkjezm9fzlR8KCE
	YfyRN+CvHck+TGT6HRdzfUaMjrcOQCFnS0w==
X-ME-Sender: <xms:h9F2aBAYWXTYFDDOSXXKdrAjI4ycHV9cOQOFWoNOqwfbFy8EL0FS8g>
    <xme:h9F2aDVzAuyXcQyLJEBSld6oo3SEcy3GWf-RmqE7fk25blJHVMeMD2U-nNE3O23ei
    NwIEx8M1nZMtvdevQ>
X-ME-Received: <xmr:h9F2aFoLti2rfaPQg8fwJEmEgqWXV4w05TWOA4gyJsMjT4_Zc8cV6ukAyX9mzSGLalAQFCK4qFASzDMzPCRwzLYXlWjEWC8GitdNqw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:h9F2aPQMiPuYmCPS09HgAwV3tBg4cAtF028g-rweC1paAur9vG-xQA>
    <xmx:h9F2aP226Wthy0LYfUiPhTDiixWdzUqs6EqSMUPfO6BZ7jK9svluEg>
    <xmx:h9F2aLD1spcXLIAQpmRrhqZy6aJydJFGY48t_WW4X2bTCWn3o_PrbQ>
    <xmx:h9F2aLjZF_ME8NNYkvZwfzgzVWnXQGX-0FLn0EUpdDaTXXHrjSLQZQ>
    <xmx:iNF2aG3s9lvzkovcgXL9wx89PLr5SheGCDFpYUiZPaTiqXEaR9LVo6Pu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 18:09:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Elijah Newren <newren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] C99: declare bool experiment a success
In-Reply-To: <aHbMlUKNL2CAK_9I@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 15 Jul 2025 21:48:05 +0000")
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
	<cover.1752587571.git.phillip.wood@dunelm.org.uk>
	<aHbMlUKNL2CAK_9I@fruit.crustytoothpaste.net>
Date: Tue, 15 Jul 2025 15:09:09 -0700
Message-ID: <xmqqikjtf6nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series looked good to me.  I especially like the fact that we've
> made it easier for me to figure out whether starts_with and friends are
> booleans (that is, true if it starts with the value) or our standard
> zero/negative-one (that is, false if it starts with the value).

Hmph, this is a tangent, I've never thought of it that way.

The "0 is success and negative is failure" is exactly about success
and failure.  We expect such a call to succeed most of the time and
failure is a note-worthy event.

Functions like starts_with() and friends, those that Lispers might
name with q suffix, are quite different.  A predicate is asking "is
it, or isn't it?" question and returning "false" from it does not
imply a failure in any way.

I wouldn't dream of making them return -1 for "failure", because
starts_with(buf.buf, "#") that finds buf.buf does not begin with "#"
is no way failing.

Anyway, we may start rewriting our old-fashioned idiom to normalize
a "true if non-zero" integers, i.e.

	return !!some_true_if_non_zero_integer_variable;

into 

	return (bool)some_true_if_non_zero_integer_variable;

perhaps ;-).
