Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AD38911F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367550; cv=none; b=N7Bh6czU20GYdsvuALPpgYDWaIooMLAa8oUl6LBEmlkagJ4S7JKII5iVUHsF7thRIbVr/1+XgBPwcry3ax6CPrrL544Ngm7d1VgqVpaPwz0BoXfiUvVmB+FRP3bZxa/uWZ0LSV+MguxPfcGVB7agdrOrK8RNSbu6tPR3RiTSv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367550; c=relaxed/simple;
	bh=pu8KPjG0IkAJeqmIkeCUu0yCGlQMDzhMPYInQjrNfZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nln14anUI9FifRHrZDmrGaajYts7x2/0UKygOZLtZDg7xOXV4sOnfhdjcTHNYmeseFXMdFulD1AepUJZMRERt0cNJRSnpYR98KM57vVBoHVlyTb25E3ZLkRujy1OlsHEsG1lRMFpO00vEFAZegs1ZPRQwGwGatwQS5O5PILyW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qfFFxybo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMUl3uF9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qfFFxybo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMUl3uF9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C4933EC007B;
	Mon,  6 Jul 2026 15:52:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 15:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783367548; x=1783453948; bh=v58yoiTRhY
	i4r/zeJ10FisTAB9IN2ibq1yhRDtc6JAs=; b=qfFFxybodEOSpgXktxgMYwaQE+
	r/M/cl3T55+qebdPhLTCG5IEWMXqeR91fSmxSEF0qfw/x7gyHjxqAGACUFPvE24W
	LDjZM0NDlxR7AFtDHToE37mkZHeC+X715DwpRiXjBW2UVVrCzmDdwS5MPY6ghu3E
	usz8Ak3Yp7gIDYnBH4+T4M6nI/eZILYQS0uJnNlqcKkUecSvu88+o54zRtGsfcv6
	Zj+M7rkZJ0JCqPZz1xdiGXxhSi3ppKhl+O2xeJKqFLO0ITWp6t67koQ8QP04JrAM
	uRtfDBI1+bcYkGtQ6eXan3LfwiJyF5U6LpdmeGS4QqcCtsp6aU120mNtfVZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783367548; x=1783453948; bh=v58yoiTRhYi4r/zeJ10FisTAB9IN2ibq1yh
	RDtc6JAs=; b=NMUl3uF9Vp45mGJitUNiSPGaJitNxwTH2Qwt44qjG+5DxjWubEH
	BxGXGGCMewix7HJxUvutZn+RYlrImYb9jan4/VoIhJyJDxU6mSIMvJA3CcFCW1k1
	00wdh1Q7jvzLTA+L3cisXjjBBfmMuH6NVJUBaifH30rrfDxYObSXEd4JobGqJ1wf
	Tk+Rj0lJkkQHI+Td77usC46pqDEzkMXVKTG/i6ty+KbDo0xK9eKxT4tag51Zv/hu
	IOMdxj4PKUOctXKAaLEk+hIx21EDfPdWeYEEDpW4zpq7jKJhlidKxeAv0EIp/y4o
	/imDHHmyn9CydroP2/RX+E0NTNQ/UHydEwA==
X-ME-Sender: <xms:fAdMauu0c0EWL1WOP1CJHgyGE9i8QUb5Xu8WaxyFPcV3IWIfRAoooA>
    <xme:fAdMamAKJ5jRAFljNc8IYrfFN5bJ2BTl0aOTAmeXUNFdfDtLy6bq6vEeyBjY3M3IM
    YOZRnpZECL-4Om1Ch7NchIkt06GAB3lzg7RyGAn67H0PjpkZ3MWnsE>
X-ME-Received: <xmr:fAdMatZ_jzMCZdyFgQXKFMbj3ACUpwNPwcVNUoXZnDR9BNEjRVpgpsTUf9YuaDOimArCG5F2MUX_VK3YgMfltm469qc_fLE9NXHMMXE>
X-ME-Proxy-Cause: dmFkZTFcB3AZ85RwN1phiQx7+6vil7jE3QJANwA7LXxxbndnAkH46gq+INSv7zkznp8SgV
    QKVXaJ29Vb8HY/j8dsGaSHGtPt9hz49ELZUyeLzz4ipwxzZL2bR27fvPhC7/aaoGiSX/l4
    Q6oq/G6zoA9bM4glItSC0vmy64/Ltg3JGU1fwjRsl2WqBCj/KWZ+tG2yLjzao1qpQ8EoRR
    FX+BsvB4qbx+DOU+FL6gke1mSJJoLFjM/JSsssPRxMLszhpQiw7e76OuyjjZ7oi/Am26Vm
    vqKvvMoYgH5sJ3+rPZ9dkaN9Ty2urr9o4fYznJ9WuUtNKPQTqtcsbmGv+SogZ+ZYlDu8W3
    HOvoW2TCWUa7ydCpg4eYzuVriIbOIl7lgcoAvttA18VdpuXLf8cT0SWl16eKFESLiMqCOm
    R5c6dxEkzraCO6lRE+rfGmpwespXAi+6kyJBCsBonJTz6Rm74eGv1Rf0n7+o4rBSkUF1jU
    FM8X9ArcEIh1ntm/umCfJTpIUt4jS20WU8fhLzl5MwV5GM/rTYqxd9T70hyActCVWsK63s
    WyLzDqDCl1eVD2Ga/NHoOlrZ4MtYsg5Lxg/nv5I50sWfr57DiwKVzuxA8amte8UQfYWxvN
    Gk27KlBSmY4x6aNQAKlYMWmMF79uTeDtArVhBEDJEbreI9l59yPWK5VQn6qQ
X-ME-Proxy: <xmx:fAdMapVnyFuVrPXD12dpDcQtGL9OP1v3FEHwNcd1ZMhCSz_x74uKHw>
    <xmx:fAdMakMoQFahoiuaOypYapHbVcCme0BmT-mwNVJAFaU_sXZ-UJw2ow>
    <xmx:fAdMarYM46ZY9b3dqtyks2rDy-hHBUhLEa81b8n_2BLTijgfXHiQLg>
    <xmx:fAdMar_p5mCW_MJEDZxmxar4FLSBMiFfE_hHr2yYcrBYKB-lLU7W-Q>
    <xmx:fAdMapKq-90wP7N-vBDdPHdyJ3aIngUatSZUBGirVrEme9vOkrxO918K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 15:52:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Shardul Natu <snatu@google.com>,
  Koji Nakamaru <koji.nakamaru@gree.net>,
  Patrick Steinhardt <ps@pks.im>,
  Shardul Natu <shardul.27591@gmail.com>,
  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/2] Makefile: add $(GITLIBS) prerequisite to
 osxkeychain
In-Reply-To: <e0bb18ff0191de384ea3c947bf26ee07834782cb.1783358097.git.gitgitgadget@gmail.com>
	(Shardul Natu via GitGitGadget's message of "Mon, 06 Jul 2026 17:14:56
	+0000")
References: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
	<pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
	<e0bb18ff0191de384ea3c947bf26ee07834782cb.1783358097.git.gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 12:52:27 -0700
Message-ID: <xmqqmrw3aoas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shardul Natu <snatu@google.com>
>
> When Rust is enabled, the git-credential-osxkeychain helper depends on
> Rust symbols compiled into $(RUST_LIB). While commit 522ea8ef7d
> ("osxkeychain: fix build with Rust") updated the linker command line to
> use $(LIBS), it omitted $(RUST_LIB) from the target prerequisite list.
> Without this prerequisite, running a parallel build ("make -j") from a
> clean working tree can fail because Make does not know to invoke Cargo
> to build libgitcore.a before linking git-credential-osxkeychain.
>
> All other core Git targets that link $(LIBS) already depend on
> $(GITLIBS), which bundles common-main.o, $(LIB_FILE), and $(RUST_LIB)
> when Rust is enabled. Add $(GITLIBS) as a prerequisite dependency to the
> git-credential-osxkeychain target to make it consistent with the rest of
> the codebase.

I do not work with macOS but doesn't this change introduce a
build/link failure?

Sorry if I am mistaken, but as far as I can see, $(GITLIBS) includes
common-main.o (and it being .o, not .a, it is always included in the
result), and git-credential-osxkeychain.c comes with its own main()
function.  

Using a list of things to link that contains common-main.o does not
sound like a right thing to do; in other words, linking too many is
just as bad as linking too little.
