Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CC1A5BB8
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293503; cv=none; b=LTyJqHBSSuPkGjd16ig7QndZE58DviMNFOLNaZyBP4u/zBqIclC9tsAhjp5bEJHK1HIxh2dKqpfBkfGsGO1f5nGRC3tTdtmZyS1RUe/OLXh0aY8fKcj7CNEgoGQ/xG46v81i1kqmfVeb7uHN32aYEmhZkrIU0M9bqJrNId23t+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293503; c=relaxed/simple;
	bh=9mtSebaWQSaIQEBuQMUQUTXGgXaR/vVFtwNJPgAYijw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rn3FaBaf71EEWbquDwrSGmKvmhQ2cGKIlRrswHJuKyeBPbGme+CQFRsxrVxvIjeqn6I9kqAULVM/nsCkhjM39hF2a2RD3EMFyinopas943+5pYSnNTYCWHQ3WU2pEDjkRx1c/z3SQcsZOxaJ9clf71Q89AKjkv+Ct2QoKesWT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zr5qdMqb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxVo8AI2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zr5qdMqb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxVo8AI2"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 47101138280F;
	Thu,  6 Mar 2025 15:38:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 15:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741293499;
	 x=1741379899; bh=9mtSebaWQSaIQEBuQMUQUTXGgXaR/vVFtwNJPgAYijw=; b=
	Zr5qdMqby8DHnygxfYayR3yPwUlo/R5Q0cr1uA5AF8mOg9O13B3SAiMpsR7Nhv84
	whBVotgR/IwZkxhTy+AgSYzDkSgJJomqOll8319rb6Xdem22wykZEmy7mzlFSSpi
	wRhdhImQMYMeHqwh8+AhE07vxb3u6jdS3i04Ub3IweKwD+kgZ8CNE7ojaVHcU2p2
	dhrbNA76xZY4eARySkh+WSfA/MoOHtVppwHY+M/4aDD0ZZtvFBTl8uyHQVRxZ0FI
	zf7m3XZ1OvBbHwbMxLAzS7VCoKEpLLilmIpzzgi2Le6p5OMd8CNeGuSbgHVLWjaj
	UhWKlfvAXHlOvANIRRVLEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741293499; x=
	1741379899; bh=9mtSebaWQSaIQEBuQMUQUTXGgXaR/vVFtwNJPgAYijw=; b=W
	xVo8AI2PPFN2c+lySbPom4WMl/s0L3bODGJym2NEBTUQo5oULrqMuGU5k5+DiD/z
	O5E73Ev5G1dGws9xLB393M9Ky6CpFLp++CYxNdryB38ccBgTjpiijgPBxvkG83l3
	c9f/W19f6ppJ5j4jM6YD17/4WfUiS0tA8j7GlxNu67t8B/3RwVceUrRAWQVYQs6t
	GAZO2T/ag1k37EsAucBZNoXmCa8lugLz0BBxyRH0XZ/dYa76YrLs/x8WI0zMn3QN
	E2TPn+MSsKt7/M6s6NeNXw1aapbc5jn5Fj5453JJzdLunYSIZCqNcJ30s+WM1MLb
	9hHniXiftXf6ioeoMsQew==
X-ME-Sender: <xms:ugfKZ4XImB32tHe0GEbRzI5i6qkLnXdtpqKm5MZwLUxT11Unxr0-BA>
    <xme:ugfKZ8n6xlZlRrv2SxoZemqVtfVq29NQP8XsSmdtupaNQS2QNqZvcV_Y8rdlR-Ggc
    fixPduXdtfBMZo-xQ>
X-ME-Received: <xmr:ugfKZ8a1tS7LHWqnBbnJYOPL-r2rsbSSu1fqywNiwrtYq2EJgTjjjDN8sx9JufF4fY3ugBn_ByErlLWJCz4kA5cvfLFGNaX_VG-9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgusehmrghnuggvlhgs
    vghrghdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ugfKZ3W1GbBxva-tkIS4LQgpA4SxKEnIDqR_Noc1vliYY6Loqgs_vw>
    <xmx:ugfKZyklGQ7sIpk4RqDuU-Ifx4aRVSwVs1w1lrhGfUVIypc8e7_MYA>
    <xmx:ugfKZ8dEyujVb4LcyOcLBeWISwngQxD6q28a0khHgdO8_v3-islbfw>
    <xmx:ugfKZ0Gk-0MvqvZ97KCdnY6WLtPE6cW9unX3FL6acRU97PB3AZJd-A>
    <xmx:uwfKZ0XJ-IvEyWJDzXyyqtNf-17QIyqT8CbaCAKzBhu89IWzPV1-bkWB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 15:38:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: David Mandelberg <david@mandelberg.org>,  phillip.wood@dunelm.org.uk,
  David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
In-Reply-To: <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 6 Mar 2025 15:24:39 -0500")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
	<c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
	<2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
	<65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
	<42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
	<CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
Date: Thu, 06 Mar 2025 12:38:16 -0800
Message-ID: <xmqqldthhp3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Mon, Mar 3, 2025 at 2:25 PM David Mandelberg <david@mandelberg.org> wrote:
>>
>> > Thanks, I'm not familiar with bash's extensions to parameter
>> > substitution. The completions can also but used under zsh (git-
>> > completion.zsh is pretty much abandoned I think) but it looks like bash
>> > and zsh agree on this expansion.
>
> I don't think "abandoned" is the right characterization—at least, it's
> the completion script that Homebrew-installed Git users will get for
> Zsh, and it does re-use the Bash completion scripts (which therefore
> ought to stay portable between both if possible, otherwise we get
> stuff like 8776470cf3 (completion: repair config completion for Zsh,
> 2025-01-06)). The Zsh script has seen some fixups over time (such as
> my own 3c20acdf46 (completion: zsh: stop leaking local cache variable,
> 2024-04-30)).

Thanks for clarifying.

>> The tests don't automatically run under zsh though, right? Maybe I
>> should try to figure out how to do that in a separate patch...
>
> Correct—which is how bugs sneak in ;)
>
> I'm willing to manually test the patch if I can understand how to
> reproduce the issue—it sounds like having a remote name with a slash
> is sufficient?
>
> I started trying to test Zsh completion a while back when working on
> one of the patches mentioned above; I got as far as this hack [1],
> which is to say, not very far at all.

Thanks.
