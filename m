Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9107186A
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735959153; cv=none; b=Fq9FwVjz7m77HHZa3ccyagNnnyJppDsLZqtthoD48IOWpIwGBmJ/xPdCzISXrRwSOY7erTyfRcWhlndccsxEvDeNhlkxWo0Kq76Tm11ti3bnLx5v6yDnm5KsivQ2CB3VZvySUefNO+oMqmOqtyYJ3IFRh4eMJGp/IyBiTsVVRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735959153; c=relaxed/simple;
	bh=h3eMdqH4JL8m0/Sg1R/+IN6ZN10bJ/+HKSj0d2Azxy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThriFOEWWuw+Sd92q1bqpPf2cSlLspwi9EX7VeCrUc7KkxQLX4CM4cO1D2ixZax5NwNGNfRE0syaL9rXZihW6SktsqL0yjcEUqVw60Nfib5r4tXG2NDsaEzxtL/x6HuHFd2mgHZEO4EyoCOQHQCZkjBHjtN0RYJkFphhwdhC1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G1kHkdwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yM9J5ZZ2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G1kHkdwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yM9J5ZZ2"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F1FF213801D4;
	Fri,  3 Jan 2025 21:52:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 03 Jan 2025 21:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735959149; x=1736045549; bh=W9FcgjLG3u
	B+jvwckwQMFz9/Z1nE6wUelUdBVQd1sFA=; b=G1kHkdwenC2j0SZd1f08i+tJt5
	Tab2cW8W6ibWQCmyKxVEHVxFPYpSHGi5TL+zHxEu4x+7P5j04HhDnKbd8PgEn10D
	VGQbci0419Kxmwn5UQ71dqAFiII2RudOP4rvfHwt1ysWACzZfjiUX9jpI5/MkHXU
	dyXeJvQcfay/S3Lt95Oto91bC8jUJhf3Zgr/OURTqo0sDwVetmqcuWTvyydZ3Nus
	c3udv2Jot+fZ1gFHDwWS34RTsPcVGf1m0VhMHuX+RPaYExYFVOuZfJ+LdIRB4UZt
	EkIZuNPgK6cecIHJOfLNA7VLLrzoCsx5TamrdIP7NbS4tUxzAywxQo88n0MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735959149; x=1736045549; bh=W9FcgjLG3uB+jvwckwQMFz9/Z1nE6wUelUd
	BVQd1sFA=; b=yM9J5ZZ2/Vy+puSlQAhF7UbSBAIpCxkS7jSbDzyWBWSk5zL6xC2
	yZz02eYqVDoPeoz4uLKTsmlFnRR/sGT0Zb5fcH5iEUU5H/OTLDdMShFc0qPOFiLa
	fCmWlRUVm8gW5wvcW+oec0+H5CZ+l2eyu49N2PQ6a8oPyhvhIwdXengB5bsRfA2S
	q0NLFFQBhNeA7syAqH5Wd7LQjSrLDdCtjboIBfUtgDlFRwIIo3q1h25gqFzxoJO1
	Sx5RWAMvJOkEpUd4h0GxwrSjnp+WnKKDF/SmLwBaQm+fgB6QB8VvgfxFII67YZM7
	GaJ8DhsdnG/qOOPBeZcXeQA6vZYyiTN7HDQ==
X-ME-Sender: <xms:baJ4ZxUWrxmwkAQD0AMU02C4gukrC7spz_1YFMRA38vfEEYvX_bNcg>
    <xme:baJ4ZxlhtRY__bZwoX93H-af3NgZ2FSWNAduazsOAbYdaTleDpH-ewUhZ5z2hWMwf
    LD0pS4Hu7IkKiYy1Q>
X-ME-Received: <xmr:baJ4Z9Yl48goe_5fZIKEYWNnRdpdbNE1__LMkzrAdaLnhJvyS0Ns6nECRmIHAg2kyyV9Ka1G0EQKnQRE1PU0mp1c8tpbnYyyew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:baJ4Z0XM4FaEI06u4VCpnUvFWv-yk1hkuRZ0DDFG577Ch4mK4cf_cw>
    <xmx:baJ4Z7m7HFdjE9wk5KIIiexI3L3gkLhSsRzlzYvkq_31d0aiMsXsQQ>
    <xmx:baJ4ZxfAVuXB8d9VORExov8kyX8FNShAVgW86RNiIhWIMezOX8zHQw>
    <xmx:baJ4Z1EFVhCbzcC-RyNT7mQ3NL2_B0MUGBwQkCgEWLTaA4svPb9Pag>
    <xmx:baJ4Z0CNCvEeHAHYbQr8rHom71smt4IIJsNtJ40w186vnPfC8nxlmD_z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 21:52:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] object-name: fix resolution of object names containing
 curly braces
In-Reply-To: <CABPp-BG47KNt5v3vEzPCCb+qRyz9473qPTfoOcTytb_Eis96SQ@mail.gmail.com>
	(Elijah Newren's message of "Fri, 3 Jan 2025 15:34:41 -0800")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<xmqqpll6wjsk.fsf@gitster.g>
	<CABPp-BG47KNt5v3vEzPCCb+qRyz9473qPTfoOcTytb_Eis96SQ@mail.gmail.com>
Date: Fri, 03 Jan 2025 18:52:28 -0800
Message-ID: <xmqqa5c7nvdf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> Interesting.  I wonder if this looseness was to ensure that we won't
>> mistake a colon inside "master^{/title with : a colon}" as a start
>> of a subpath, instead of asking for a commit with a title that
>> happens to have a colon in it?
>
> Yeah, good catch, my changes would for example break parsing
>   master^{/object-name:}:t/t1006-cat-file.sh
>
> I'll fix that and add a testcase.

I am not sure what the updated approach would be, but I kind of
prefer if the parser does not have to be intimately familiar with
the fact that we know about '@' and '^' as possible characters that
can appear before the opening '{'.  That same attitude of "We know
that before a '{'" '@' is valid thing to appear, so let's special
case '@'" was what got us into this exchange in the first place, and
I am not confident that we now are exhaustive, knowing about '@' and
'^'.

Thanks.

