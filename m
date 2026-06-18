Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE53F23B9
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788449; cv=none; b=l7SzFaazjQYu0qC9Kt/adsWGGyJ6NpaXjrGiPw3ecqN7yhFKSCHrRxvjuv4WnM/PvgzF4zV5V6gbFtnsCUPM+5mU/bsCH3AS5Pip3kflaWYY7DopUmkBzz5UsP7dnhQi7C50YFzlS4+/3z695V3TItojnNm6nw1ed2YMQW1GrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788449; c=relaxed/simple;
	bh=i5CXcEwZmYFirlMUKo/xZZM+wzftNwtw+xC2ghdV1+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMC6KwEKeFTS8Ty4kI6vSL0EX+cRjiIDEbfWpWjPi1J7t5FOaZY+n7tkHaUYG7lZ7mZnuTUiB21/fl0zvhSg9iL80SZtA4DxxeYCcUfdMa3Ew2azmRRNrBPqmNS1h//MNXyYtzKhBk3S3D+DndUd4FsseOkNIM3i9MYB3QGRqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oGw2oIng; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WD5pg06Z; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGw2oIng";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WD5pg06Z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D84F8EC02C4;
	Thu, 18 Jun 2026 09:14:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 18 Jun 2026 09:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781788444; x=1781874844; bh=zsRrRr0lK8
	D1mpa9FNTtXpkzyZT37+Nyyhs1ewfNE0U=; b=oGw2oIngsGAwgVmQ2mq03e3ryZ
	gnVZaIzkpTS3n6SThgIzWWARg7W1RTwSbt6JN0bYyfZiSjzvKRdBLWzLPA94mFxs
	+qa3BcYDZUOAk+eXdkmjQDfzTashTAHpnAqSCQMwnn+WM0ZJCI9BaXrtdcsvI4tQ
	ZHdR9QMdCNwT2nB8RbLZcZjiKkDYynfJNv4B7i49Y1bwol2n6nWrckXorFQqjgtV
	2Rmwjo6DW+aflviFO7kRMZSWmYeDGOldV7k0VZdjvjbKDEVRFXGwhkKqsEY+QBNf
	Hxl8pZO916dHvG+o31P0vUVnEILYpsJKk5MOSfI0ly1qHLLIgCAFByruDDZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781788444; x=1781874844; bh=zsRrRr0lK8D1mpa9FNTtXpkzyZT37+Nyyhs
	1ewfNE0U=; b=WD5pg06Z9xSWP+1UCp4uo8wyHU5HpoVI7Wtw99b3N04Ljds9/DB
	vH4VlLjXUpWkBvCxhYn6odm9Qr0/9D4cCZOSZPmbS9DWLbhUSLvlSrjo92EgLB9Q
	Aor0pYI/c7QPRVtfRWw6cRsWcNg03Y4N54K++HotU9Ueq1aWJwhuCeMoC7FnxMBq
	Cy4Na8drKFY4IULqL/mvhWn1jjqHh2z8GaBCtQk2BYybf4BuyyKK7KDfgKqZ6X1M
	v7SupBQJwLO444acNuSMCMpws0YHN3DT6v1AcsC53p4Ve9NoD1XDaxH9JRPQml+G
	IJg4cOvfTR/dOtKpcJ9Cr4Xs9Vzk0JjIWiA==
X-ME-Sender: <xms:HO8zakWQU5IHHcz8HwK5xAw1me0prmXQX_lsNmCYe3Xe761vV4AxHw>
    <xme:HO8zaq1vnDXu2sEI3UhaM301Gpnmaio1Tqxn13cew1_R-lsdrQQL9YtBsw4I8a5bz
    BxLpA4tRoBzB4E6y7GVRKm76SUtRUwIvylR6DFM-kcKANmKcA1WCQ>
X-ME-Received: <xmr:HO8zaqrWsESXw5Pk9Cl9D848JsoF7iTKfxkUvTbANip0F4IsFGRHpx5oSwMnq-Fp6E6hcmn20DkQz7ewLLq0s-anoy8Sgtp0lcYp>
X-ME-Proxy-Cause: dmFkZTEKKh4s5U7Sd+J1u3dzXVebeg/EyBhXLAtteTYqboVytDSUdBJy38ZmmNj1/RbV0x
    mnMiE33jjc44u4C13bhgtSfXY+acedl1iCWiC8QHolRMdNiYRdJhvI5r6lJyyWIBnENHZP
    KZ4Wyz005aapq6LwGzkhxBdCMMJB9vPmkjhOOsSUcsU4vJR6uy/BqE3HJY4bmarHZRe3ve
    F49+bNyKQ9wbYzMf6NKLLddTmXs1YTFuoxiEjVl4Ks7Dwo9TLi0GvHgGzQsoMeV3L2tiPh
    dO5bAZVK5ik+KNA60s1mdcdbk6lePzMPDnsotehmUiG9lJ+1njJtMWs3uJfR8xgd3LAINB
    8XFGb1gRhRfhZf6Uxe6rg5rN71bAvYrbHE1jZXrGr2+UIvxOyK23P7TVOexOLj/u7tczas
    ft6vBlOyM/xrWS++0YP4Ci54ewMZMvaWsbQNNGt/becNEwl9pwZ8L3CFyJMyDqW1RxvcGX
    NGdT69qoZwVaK+Q0d3VAD5by6RONnIAI019/KXyJ4ccCtYGMFirpao8U8FNYZf82/jrn4+
    rZRVH63b39VXyd8aamZrRejHmrWSQ7X/RcLG0KHYk44f0lmOkb80LwS+0BFM8J8iylvGQz
    C5jIynxe7UyAgtLasbBOyFA4WUrHQfJZ7qY0KMuJmSKCu0HnJiLorwYls63g
X-ME-Proxy: <xmx:HO8zapWQj_8BlcZon22ZWOVMbv5_HA5fHVM1_uCliY5Sgkn_fpL49A>
    <xmx:HO8zatZBF5NdetHa5UKH-TYyBjM7nIg3do5EtrSFqzOXUKIUUmlqlw>
    <xmx:HO8zaueroh1XFI3iVk94bi26mfg3vWcroXIT1Nm2USS9pp7OSJI2-Q>
    <xmx:HO8zav0WgwP0Wvky2oTQ3vfsMHeZ_gNctzRIcL2kxs5XVTzVc-FfMQ>
    <xmx:HO8zalmgGtdPbgd2fin9CxS8sTWvBfP41-jKfC_-80UBZZeEG235do93>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 09:14:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com,
  johannes.schindelin@gmx.de,  stolee@gmail.com
Subject: Re: [PATCH v2 0/2] environment: move ignore_case into
 repo_config_values
In-Reply-To: <20260618114207.605211-1-cat@malon.dev> (Tian Yuchen's message of
	"Thu, 18 Jun 2026 19:42:05 +0800")
References: <20260617154929.564498-1-cat@malon.dev>
	<20260618114207.605211-1-cat@malon.dev>
Date: Thu, 18 Jun 2026 06:14:02 -0700
Message-ID: <xmqqldcct2hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Related materials:
>
>  [1] In this patch to migrate protect_hfs and protect_ntfs, the approach
> of introducing getters has been endorsed.
>
>  [2] Derrick Stolee's previous attempt. The reasons for the failure are
> also mentioned in [1].

[1] here refers to the starting message of the whole hfs/ntfs thing.
Do you mean that people must read the entire thread to find out what
the reasons for the failure was?  For that matter, it is not clear,
unless readers read the whole thread, where the approach of using
getters was "endorsed", either.

> [1] https://lore.kernel.org/git/20260606143412.15443-1-cat@malon.dev/
> [2] https://lore.kernel.org/git/2b4198c09cb6c04c60608d19072d419503dfe5df.1685716421.git.gitgitgadget@gmail.com/

> Changes since V1:
>
>  - s/repo_get_ignore_case()/repo_ignore_case()
>
>  - Use repo->initialized instead of repo->gitdir

I do not think I have any objections to these changes from the
previous iteration.  There may be some other things in the new
iteration but I'll have to go in and read the patches to find them
out (if they exist).

Thanks.
