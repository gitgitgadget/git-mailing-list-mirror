Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8523A83BF
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018017; cv=none; b=p1S07eFDJu7SFklgC8Kf8XhlE/bIWTr230ulaEAHmR6yeztZ8XdDdWoTAV5eaIgJeTrS13tr029ah91lkH8GJ32LLDjspssuUGwJ9Dx8QnXPk62MvUvZvwmuUcuHXlWaHGpLK+9Y+3WK7yGTjKpj16xFp0qfk1McqK5zGoBFArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018017; c=relaxed/simple;
	bh=j58w3CO1KwPL/ZMtZUtZa0+BzUCo9OWj4nJxfnJFuVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvMIkXL+OA4Xv2N10UeWpnLp/6XpVb7wMgz7JUSS4eNTbZm0Xu1AQ8qsa2rKrgz0oEq2q+xz7Rib8oRy7V5l53E8mc6unTI3eRNhJm71kth67Nyaipm8oLBPP4DgGKQ7XR+lMXZUANicDKYrmloZ9HqBsGRNRp+MJ/NM8edqaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NVkLt65E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jy0MHaEH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NVkLt65E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jy0MHaEH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 71943EC01F0
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:46:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 14 Oct 2026 18:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792018015; x=1792104415; bh=sN7TwWUVKk
	BXy/szX6+LqnGwJ3Vo8/76fYFQ6BlIgME=; b=NVkLt65EzsM6PexuC0N3R74wEN
	lcb1fXwm4YR2KMOBaUeng+V4F5n9iZ6zlonyvkhDtBHRucxOR/7QTnRzrq6WyLdN
	V8PAwoCCa/3N+0FI4F1quiNQ6xD1qK4XLok255DPDDL3XAq0j9rkChk3IbOWcisJ
	2cAAbxmS6qXCbGl49zGvVtyeWgmVMrnLV345Wvg8ptzvyE086lqH/wk0LToL2xjA
	uSZyE3NXCk+/bty/4MouG7D7yRD6Uk/7aaKiLnYzghv8xCwq6sFBYHfOfM1SHvJU
	GvasxcpWLDXmf5ls6a4IqMua8g+nH2eqJwpBMafdryFv4ms2033+mkpRci4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792018015; x=1792104415; bh=sN7TwWUVKkBXy/szX6+LqnGwJ3Vo8/76fYF
	Q6BlIgME=; b=Jy0MHaEHgT6HWvu9KFg3TIcUbq/cs2RZA+CG4YNq92yXZbpQWti
	Wl1P09nE6X0x0kiNHZkjsc32Ssn5R3hS/G1MZF+nB5ZgfQJvjj+Vnv8YcWYFfXph
	AOa1IU/iyx4GFPxT/KGEttC8GyYPhyXa8oocmfUr1BuVEYGCVCkHdG/f9PjD80qd
	cVoYgv45k+25VDAcA/BOppnd1EkN88SVt4bRvhepSudPiMDGh9rEBN2DIMZh2sgr
	eaX1SRNXhOokQeTycriChk06jQk+2oG5QWel72GxROaGmKki72l+VkLeuuVuleyH
	KZ80aecn1GgOkAUnIKswqq+fl/9PqG0wrZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792018015; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:BQpVpFuAdddw0k7QMai7He625ACzGf41OM7ty858LVPAMdy
	0XLui4hvf0o+teZPQbdbe5zGFaSZHdKvlbQ0CImeBHPKPleaLLfgDCoow9SGgY9Q
	JmIDB2Gqiss7Q3TmGDbSeTTq3TIqLWblvFv5vn4IF8wtHyFLKMjGyudtL58gNeUt
	pzVza1U1pn3jAZ4cWUZSJG2gw5wSuqV5Vo27tWQNrtE4qoRRN/Yaodwg7Ns+um4N
	bqbnqXXFICGCmpTQRY0c77GtNCtW1tNSIbItEhN+dRTfeIsp2EyKKqcZYcg7oLOh
	7Q2s/2zXmepfTM4oxZf5Iu7ehhEb+7uRnck19UA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tt5/QMlDRRLHskTwwGCU9l6nMherNadhKTHsVsy5N8A=:j58w3CO1KwPL/ZMtZUtZa0+BzUCo9OWj4nJxfnJFuVw=;
X-ME-Sender: <xms:XwbQahBJYz0inHry0RFIIqra6kdFO7_iRGlLYsLYW7pvjziiMaIo0A>
    <xme:XwbQamZi16yINZ0cvbI4P9v6EdvZoqN_aJIH_hCuEyubuUqJcQ5sDf3DUY2DqHEXZ
    V5wUs8Bf4JmsY65syNpDP04_CqOGDFGTif-Gon_O9T55cMKoPJsawGv>
X-ME-Received: <xmr:XwbQak4cN-fqG8LD2sOyHl4xvGA8BnU0GwWnAQRXm5TJg2aynIQGtcWscwIBtYGKxP3wqi9IuGcJxLLQRs55qy6JJUzzVyUcewsT>
X-ME-Proxy-Cause: dmFkZTFBIDWXIe4vR81HQlJI37NW/yWHbFl+PRzkcIGolAv27+HXD2K1yZElfX77qr3ODO
    qc8MUeCn5gNKoSlv+iGOJQDUgNpesd/sovxY5aywSQ2pNgAS/e74bxRV1DfeokAkQqdQVj
    KS+dTu9brQdMF2McgxFGM95n0ebbXJuY2ghc6eCXnG4T9XPao1YN6BEI9mP7Z1MwXZXxNN
    agU7U8qEg9xmLba6aKCkrkBToLigN08/LHiFkOWPJosdGQFBz64/JHXirfBDATOIv6XDy7
    XZPMZgCibpTlAmBaie/31kI4nZx4ywgPwOKOYFHXXjl34ATJl7KXB1lo3OKbKTNTjxS/oI
    rSM2HU2ELHVg6hL9zdLSDcQ0DbbgclXWroz3EEZXawvNKcMtG5ppC/dNVLJ9cbtqmv6phB
    upUZjyg++3RF3bGf5Eubz0Sx0+JX30zvg0+q986r1gZVox9rz8MC4nbXDNCufdLjkc2Vvv
    75uwa3ED0Q3CywNR+IfKtnhek0UzOpns8ukA64MZ9v+NBZtvB+H2Joq9H6K4l8S0jGWZ3V
    SvW9Ue1bNqH8LTcVmWiJrnrTtOe9MibI34PKwWHJzrBzMZnfat4b4MZhzPEfeant+E7mw2
    oV3l9eBwrFWT7Grw7c0jd/lM3TK+0bku8Kj2EPURDo0IfL8f0KOQTeTpQv6A
X-ME-Proxy: <xmx:XwbQanZLbjcyl9emzwSXpkWZFHsLbM9yv6yxCZpXNnJIWhRBhC4hJg>
    <xmx:XwbQajjin8vyHmltOKx3k5xE6Fo0miWDBQ8ff46JYW7uLxhxJyatPQ>
    <xmx:XwbQao_77XfvOKZ5E_zoiXVwYGn3xCnGxRzSdytjUnHtzzBJzKoUXg>
    <xmx:XwbQaurdYyD-c73E9qDVEruwW1jxlbg3z-wo7IUPOfcypzc9zQZhJA>
    <xmx:XwbQato6G1Hn2yZEGwT4tJbaZgf0jX_otOrQse-FhcM2nUALYE78zZ5Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 18:46:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Yoichi
 NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2 0/5] worktree repair: avoid breaking unrelated .git
 file and gitdir
In-Reply-To: <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Wed, 14 Oct 2026 21:20:31
	+0000")
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 15:46:53 -0700
Message-ID: <xmqqmrsfq4rm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 'git worktree repair' does not sufficiently validate the cross-references
> between a linked working tree and its administrative data before repairing
> them. This can cause the repair to modify the wrong .git file or gitdir in
> certain situations.
>
>
> v2 (0156021)
> ============
>
> Split the first commit of v1 to make the changes easier to understand. Fold
> long lines.
>
>  * [1/5] align .git file handling with repair_gitfile()
>  * [2/5] centralize inferred backlink selection
>  * [3/5] use read_gitfile_raw() in infer_backlink()
>  * [4/5] reduce .git file reads
>  * [5/5] avoid breaking unrelated .git file and gitdir

Makes more sense to have this series as a logical progression of
smaller pieces compared to v1.

What is "0156021" by the way?

Thanks.

>  t/t2406-worktree-repair.sh |  33 +++++++++--
>  worktree.c                 | 113 +++++++++++++++++++++----------------
>  2 files changed, 91 insertions(+), 55 deletions(-)

