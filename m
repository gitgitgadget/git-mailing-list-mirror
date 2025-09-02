Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72C2DCF70
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831245; cv=none; b=cpTvQIurlR2WY+eVFi8PQrgaSVVt89sx/GjVZq7LCwQXNQs7bkb1en1Od/gPWAgpeo8q2BInGX7OX+Ypp+AZ5AItlw4y31pPGvqBxkJHMBZpc4x5iLrtTYsCidXnupsoGJGNiVwyOXz4Zg8KI6KlYv8kjIOb+lNl1z3UpqE1LOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831245; c=relaxed/simple;
	bh=XBwDMVAj/N/kJf+WpNyK9ho7GXDlcWXA73qgCnIBsMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iT9hKJjMrPBhLYkl+M+R1Ny/9qSvGBiqPGu0pWZPcU1Uw8q2jORx2V8SYDOlgFuoNVZAykbM/virMDldGX2JntxzXmEYZyfPGaZceB4o0WEKX7XvLT1oGRqw8yLqZKXr7fiVyv1ZpSoLdmYKinqmZz8xegXT47a3egNI07dd+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u7YTWraW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShASNYJK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u7YTWraW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShASNYJK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F8EEEC04F6;
	Tue,  2 Sep 2025 12:40:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 12:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756831242; x=1756917642; bh=bbEJZdY8Eo
	hheTq2o3mNh7autJTl3PCauj8gnRQaTHw=; b=u7YTWraW6JSWfTXabitpGZlFXm
	TuV6CijUGp23J9GQyS95b7gTvnHe0gOYZMzahemtCTE2F1iF7o6kj+n3RmdEilqO
	ASxxdb9Hs1hPZtp5oRBvyKDiG0ppk+GoorJXzUS8ugnNPAZR8DTcrCjZFyPGF2oS
	/iZ5RE6SgludwXigFffF9d3H0T6nC3JNA1usFjdaEzivo7VOvB24adXtDlFoI1lw
	XqF235X4HOcSgypLAXBr+B8SYQ27g7qAJe2888yEtRMFNWudkVglMH7VGUb4FdLP
	VLhWcFf/X+ipP8eo8bPYu6mdfE0tjvhcLGAAxI9ScAyxLJkDJ7Z3/72ijgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756831242; x=1756917642; bh=bbEJZdY8EohheTq2o3mNh7autJTl3PCauj8
	gnRQaTHw=; b=ShASNYJK7/SWQAE8LV/g7amYIOzDGo5eydMlzTgOXMysjpOVAu5
	DcrrnbWEvTwGYLKAp0LyXBvovlwH4UU6Mfzu96pnWk4gpZWCANV6VYN1uWjiufCG
	u1RZdbNUpEDIZCJHh8ZOJ88qBfKtWCP2GRW+DUtHNIivFJV9+tfRTj28TVuZhj4r
	FXGOVNJ5zLuJ0/JK8NyDB6rCh3CIN7gQOIOh4YzRgq7eXP1PQEULeNcSt60+3GXI
	YTdpCXYGia92s8s8VmZcuKEXfn+Z+3zWLrCyflekj1atYSyruAU6h6ZpdP7FeO1f
	l3MbiNJb1uHd7hDcMPveTl5XBY+u257/YsA==
X-ME-Sender: <xms:Ch63aK6-UXF1pYhLcSqpn2Ox8hbG5LlPpvGxt_2AsYyEK0GowgnVqQ>
    <xme:Ch63aMXeSaa9KdHgGsDGHSzEObhavPV3PN4W8USNnBMi-aGgp_rOZCfc1lZR0VnWU
    eFjkcexSWn9kYR8Vg>
X-ME-Received: <xmr:Ch63aJ5HIkMFwyKo0ZksLt71U5DG1mqnhtqOuymSZP_0I5kwHLP2IHEXIXunQ78GkLQlms8bOjG7PRhqlv4EoRjxd52LlWfVIiIEJOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:Ch63aHpBDtJpdvc0IE3sef0rPdbLcH9J__jYfb39NEidrWvJm88-tg>
    <xmx:Ch63aMmbjfZECZw9k3UAsGcWLkx8U6Hiw10344DXZffMnV0zBMS6zA>
    <xmx:Ch63aDNhli2eR-mB0oFtjhWYnQxT4-3dx6mrYcCD7cLge5IoYTvhEQ>
    <xmx:Ch63aAM5LVjag-7uFOrALgz0YL_OI8d9oL1GhzMzIYBF9Urvn2WXtw>
    <xmx:Ch63aLRnM8OlWPClonmacUCJjt-LLvUCP4WxuJk4FxoltT10d0hKKyWf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:40:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 00/15] packfile: carve out a new packfile store
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
	(Patrick Steinhardt's message of "Tue, 02 Sep 2025 12:48:25 +0200")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
Date: Tue, 02 Sep 2025 09:40:40 -0700
Message-ID: <xmqq3494lsdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>   - Rebased on top of master at 6ad8021821 (The fifth batch, 2025-08-29)
>     with ps/object-store-midx-dedup-info at 13296ac909 (midx: compute
>     paths via their source, 2025-08-11) merged into it. This fixes
>     various conflicts with "seen". There's still two conflicts: a
>     trivial one with jt/de-global-bulk-checkin. And a more complex one
>     with tb/prepare-midx-pack-cleanup. I don't think it's necessary to
>     really address the first one, but I'm unsure how to proceed with the
>     second one given that the patch series still seems to be cooking.

I think the second topic is not really cooking, but is expecting a
reroll, so I'd say it is perfectly fine to drop it and expect it to
come back, if it is still relevant, in future, in a shape that is
friendlier to other topics in 'seen' when it happens.

