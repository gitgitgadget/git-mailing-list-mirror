Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D820DD42
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402890; cv=none; b=Hkzlmi6AyRA89xHtF/YSavZ/LL5Ir9IArXPZGTRixS2J9lTaCf8Q3tZbQaZSuolYVtj19bxGU2iHQfSNb6A43WMRGp0590IBJrsfeVB/+/fGlG0q9eO6VjcfAqBkavGD/ACMhvSjKLRoSG7zaisjhcZwrlKxmkjo65UQg4JBeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402890; c=relaxed/simple;
	bh=7Fr/FOv/BoX0+7bjCON4l9I8I72pWM3rs7SN69bVFXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nH1t0ndWYarP3zaurSSUZh/CVxo+/BfyhayIjVypnVH2LqjHrmeAu2m26GLvJvd/QXciI8MN+UuY+tBMMPzVPt0AtzGLrf7MVmNTEY3uzm66fg+8r4V75dA7xF2MKHGt31gk0R4JMmIcMKHvJfWUY155w+x9PS3zHep62C+MIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jiAUshq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkJ3mwzZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jiAUshq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkJ3mwzZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BE3111401FA;
	Tue, 12 Nov 2024 04:14:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 12 Nov 2024 04:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731402887;
	 x=1731489287; bh=65h6pIcDumFaCxWS1dcRVQX+3R/9y5K/yOCan6kANDY=; b=
	jiAUshq/QV16LkUTT3CIc5DYtCdkHE07d/bhuT9xb9XPYJlFNdnLB8+6HYdlugUS
	A7t99lPe8PU32RUe/6sDFzxRt6aCfbQKujzeRDOPG7FC+h4sl1UE9nj+tufzQ2b2
	M/3Rf8Ix2euOT45sFn9+oX6E1vZsf2Dg/B4apLccoZPtPyV1CQoBRGqYmVjENvCt
	nPOqfseimG8YL6FvHCIuBIpfK9gIdUlq4KF1A5q5lqrNXitR6dA71G8DFt5SS7oU
	LAaZR6Ds+bts+8LNz5OcsSFUUnGWNq4KXXBduG0JqwcU9SSH9j5zUm+KiBnyIGqO
	k73Ba51cMRHbpyqCrc4oCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731402887; x=
	1731489287; bh=65h6pIcDumFaCxWS1dcRVQX+3R/9y5K/yOCan6kANDY=; b=P
	kJ3mwzZnepDw8O5kZ9p0Wmgt7LbM71StiIC7abO8XA6630MJkJiy/vrsMvDhCw2I
	VfN5VfyhIchzkb1XYJfyal6LE094m9qRZl4rRZ1bCsNQMSx7Hf6X5Fjb4oiexpEE
	N53UmUqNK6MHi1yLy03BhgRYnaXxkZ6plsC5XptuEOCsqyxBSQ0HNDygibAuMLKL
	N32DMr1Wo0C2826QmoyDsb8asguWDIIBKcU5wi+8GOkeqnzXCPfp+4UdZMvgn9Mp
	Kc1uORTSqVgIrhhHGgxQfw20VN8U5HCkDiQ8Czz1g9ttN9RqkYfwzV5vYzt9O+Ob
	iTXeV4xhXLOxfg5W8YXOQ==
X-ME-Sender: <xms:hhwzZwc-ZQc6IVoH1GZarNCqhIxCCktzAYSjfYp1_Ibk33PEa7UnLw>
    <xme:hhwzZyPPP6QMScZ0Wl2WfkU-Sw3UmG0n6kzUW2O4bvoCqnC6jYTULwZymJygPhS4B
    G__RxWexcSKiyH4jw>
X-ME-Received: <xmr:hhwzZxj86Ij_ybnBsSR7tYZ0hR1MwrqgzSHylnvVJHJSIpchCeBhkbBwchak_P22d2LKCImuRYAxN_xuZuGyJUJEcRBZRIkZhfBv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hhwzZ19StBiOpfLBFdZlkv6DNW80Nsz47EHBFxUSlpRwDfTQjWYtHg>
    <xmx:hhwzZ8swoBQCcIrXmmJIfjNTO9Yv-UxNwlk4jHiIJUnCNEsg4IWFAw>
    <xmx:hhwzZ8HEFToFACYXRYy6k0CWdXTUBG7xtXK0j3LT89Hc1rFMeMN1Yw>
    <xmx:hhwzZ7O9k3wF9AOFc83B90c9SM9aNqTr3Q_tCwnRVr-PtGJg5qJK6w>
    <xmx:hxwzZwgzyhFIKeMSN34Zif62FsKoEBiRkdNaomc28MzmfX5lYg4n6Skd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:14:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 2/5] doc: git-diff: apply format changes to diff-options
In-Reply-To: <b0a894fc-911d-49f5-a10c-19d441dc7133@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Tue, 12 Nov 2024 10:04:50 +0100")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<129763c2aaefd92bddaa59601c5a3275b9defa36.1731343985.git.gitgitgadget@gmail.com>
	<xmqqh68d8e9h.fsf@gitster.g>
	<b0a894fc-911d-49f5-a10c-19d441dc7133@free.fr>
Date: Tue, 12 Nov 2024 18:14:45 +0900
Message-ID: <xmqqy11o4xve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

>>> +`-U<n>`::
>>> +`--unified=<n>`::
>>> +	Generate diffs with _<n>_ lines of context instead of
>> 
>> Understandable.  Shouldn't <n> part be italicised?
>
> No need: the processing of back tick quotes already treats each part
> according to its semantics and applies the corresponding format.

Yup, you reminded me of how `the backticks are much more clever
these days` thing works.  Thanks.
