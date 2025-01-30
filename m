Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7121EEA3D
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258518; cv=none; b=rkhmTclJq+FqoJo5QtR9IrTfeVSNbjxDCN8Ti8BSF33dBHf+Egdg/x97VXCe9kOrGeGjnxYijmduf6nOaEruGEupBSFgR/pdZtSS9uKubZU291O0qAFERUgYSZaTN6mHQUvvlf8KimyFovChEp0kv87SBHH6MexiZ70mpJqWAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258518; c=relaxed/simple;
	bh=xiqMh3naKKTXZXqGC0VJkkgDTUEOAX+ZQQ7iCQOWr+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lYunnG0t/6D5BWb2nxk2d6en2m6tTPiRgdPEKAppg2QSJ6VXz9MHrC0lRQosUXZ4b8cxHlt4p9nzKOM7Goyx8YkO+GXoxuEjpZyEQ4K8wWS65nJHe1DaNlFfA4FZj+wpkajWa8v46o9UR/ejLw2YSy8skQlRcYjSFAuSPvidMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kiVc1HqC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jhOe+dN1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kiVc1HqC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhOe+dN1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07FFA254012F;
	Thu, 30 Jan 2025 12:35:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 12:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738258514; x=1738344914; bh=G0IebimxHn
	0YcBzMXNJQ1cNceJSfC9FDQtVWRoXqZzE=; b=kiVc1HqCVZtaw/MJ/geI53n1cI
	Keym9/n4nzC3/3wrTEOdn5tbHpWP7lrV4C7/7QpatjpeO/cCW6XLC5duNKSfNquo
	POT8kBJDxe8c+wLwaowjYHvBrQGPB4sZL3YdCxAk1z6mmR5YiibTdYPnAfk2zHVo
	Kzaje0OIVC4prDWZEZeBAZppjz4IixWFTZIzjsNU9neGHM09uSBb1rjgI+Lt7pKB
	ySxPRfo73ru98DVi3mx0kfaNUu3Aw6xu8+FgfgDDAzXqkj1RRmbxp6KA4v0ZPikF
	9JoJto4wdb2BIOyp8LJ3vWq7mTXVyMYH7apDOpASEyIQyb/+ECAZuhUkGbag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738258514; x=1738344914; bh=G0IebimxHn0YcBzMXNJQ1cNceJSfC9FDQtV
	WRoXqZzE=; b=jhOe+dN1ssl+Fk75rkRxS6yIgCCEyws5w3hYY/Eaqspzoi+ifBt
	QqlUNmBZE/of3LgQc4Tmn+QvUJMRM+p47jH4SbAnJED/f663PesB2iqP0pq9cexz
	5+IW6Ujm+m6VqvcMtkMA7pIfqzaHb+OgbVktG09g1TNa/UsZ1MPg+SOw6k+x3vi+
	W0ZeWFP5/8JEcMDh4eKYFCZSiGbkjRUiDsxPkeq6Jo5H7rhQ6vQ6s8FIE6zh+Vh9
	AafXrb1Kf7MhgfkaLdT/RkGTRAyhuHG/fheyJ7/1vEUurn0wDxopdbi+y/KucpTM
	ZqhkvfnQhu30g+wSkTPTtn0QMoYqtCzxMUQ==
X-ME-Sender: <xms:UribZwxPciReC_OlFIpTzdoK5CTU8pCjaTmzL6BXHiYa5FIcNIXrHQ>
    <xme:UribZ0SMtsbrRhpc_6rA4Irkyhwx-f1H3iBpGN8m7uOzytExefG0Cuzv9wrT22dr3
    3GCVQj3ngP6XgE1XA>
X-ME-Received: <xmr:UribZyUpz9tP41vZmKLy_gPY1f0ohvd2OML4yuGApLdv0MY5_eBZGt4_XSy2hMLPu23-0pgVK8B8BW31Ysy0yOCxl8pv8b5W_Oc7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:UribZ-guK__0jXhaP5D0uMdAssruYyCxrZLc1C3bpqdtI9rBuhwmAA>
    <xmx:UribZyAtqxswlnTybr2RArWcACsdVlySgG9-BZuN6rl_kWpETkb24g>
    <xmx:UribZ_KS02yC7Acn89NKQv7PUHL1-DWteHp_aR37sk3vT-3bZxT_ig>
    <xmx:UribZ5CO0DELvLmo7Jj2midF5F0oxSsI9W9Ob5zOwIETxhuLwvwL2Q>
    <xmx:UribZ19fL1QLmeHSIzoGlEqCLr042HwKetIe7HtLJ3t9kZKnzbhrugB->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 12:35:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] unix-socket: fix memory leak when chdir(3p) fails
In-Reply-To: <Z5sWCxEF3J7t8WvW@pks.im> (Patrick Steinhardt's message of "Thu,
	30 Jan 2025 07:02:51 +0100")
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
	<20250129-b4-pks-memory-leaks-v1-1-79e41299eb0c@pks.im>
	<xmqq34h1k02k.fsf@gitster.g>
	<20250129200702.GB2331283@coredump.intra.peff.net>
	<Z5sWCxEF3J7t8WvW@pks.im>
Date: Thu, 30 Jan 2025 09:35:13 -0800
Message-ID: <xmqqldusfbn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > Did you mean
>> > 
>> >     $ meson configure -Db_sanitize=leak
>> >     $ meson test t0301-credential-cache
>
> Oh, yes, I indeed forgot the `b_` prefix. Other than that I wanted to
> abbreviate steps a bit so that I don't have to give the full sequence of
> commands, but my attempt was somewhat lacking :)

Thanks.  It also confused me trying between setup and configure.  

As the use of meson in this project is a fairly recent development,
if we want to entice more people and interest those in the "make"
world, we should try to leave enough droppings for them, even the
meson-novice ones like myself, to try out themselves whenever we
have a chance, and the proposed log message of a commit that adds or
fixes meson related part of the system is one of the good place to
do so.

> You can pass arbitrary arguments via `--test-args`:
>
>     $ meson test -i --test-args=-vix t0301*
>
> `-i` makes the test run interactively so that stdout/stderr remains
> connected to your terminal, which also allows you to use `test_pause` et
> al.
>
>> (The "b_" prefix on "sanitize" confused me as well after reading the
>> commit message).
>
> You've probably been confused by the lack of "b_" in my commit message,
> not by the prefix itself, which was a simple typo.

For me, both were confusing equally ;-)

> ...
> options can be discovered by running `meson configure` in either a build
> directory or the source directory.

Very nice to know.

Thanks.
