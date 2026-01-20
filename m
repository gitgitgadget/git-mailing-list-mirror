Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C542E01B
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942176; cv=none; b=fIZqlMDirsFDX7doUwC7O5iK96gFs1TvTDZ7jdTBdXyrger1l/KoAUDxiF+fmF5NBYLq10wFDOnyR4nRIUmis6k6gxM2jzH5SBYi67R/yZGryuloNtEECjxIc/aqz2GNAhyuXkiyzEMm7uYxBHCww3hdIHd1n6YukR7GGSBiJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942176; c=relaxed/simple;
	bh=wwjj/gJ9SO9lvie3pwN3MOBbzPCi2mM5/punOw0VE6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MNiLkV0g/MgmuOtJ+APFFFysDxLVyqId3nuIKG7AOBcHOGksU/DhOKnz1tyytgH3R/SOY4NBz34fDqUZX50zHP4sZ22wV58m6MRbVkxnEn4Q8J8/A3nh40eGtMu+VnXLfCfKOGCosM3j50Mke6fPnUD4u5a7NPKOkTKdJ9PcpOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vawkr8sT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsCu+xHo; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vawkr8sT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsCu+xHo"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 172CA1D000E1;
	Tue, 20 Jan 2026 15:49:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 20 Jan 2026 15:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768942173;
	 x=1769028573; bh=SxLPhcnTTgJx/YWdZ0AIwOGIydec2UXLVYKEuOPq0Co=; b=
	Vawkr8sT+61j5wE/y8Wp0lzAPRanXoxTIiVzj8zPQXST46ut2giijidFeaUcYFwQ
	PqDJ6rT2vkLN1RNcSiViUI0w2/n2A+TURYnBIJ2TAHMpz92i6w05UnWjcNZh0lkY
	f3tOs7zS0tixCByy40fumIDUrh4VREkB+FyE9LWMq7N2zTlnXQbGa4Do32SHuaQM
	cNNa4w6wDdwqP+jJPgo3vguFuaw4zm2BWIcO00GCrTjhqrR4QsovYsWVCSoKFDfS
	r3iFzN8nf9Fyp32cZq1mI9aHKyogoNCh+FxsniSGTOu4NLqIMEkZkeg6PgPIfo/x
	ji+reXfVZGjsaKomSuFMMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768942173; x=
	1769028573; bh=SxLPhcnTTgJx/YWdZ0AIwOGIydec2UXLVYKEuOPq0Co=; b=J
	sCu+xHo7VgqNQEdnWYB1Y3pG6gidJQIld6Ynxgh3WZbAU8HvIOf7KVaMy1t1BY6J
	0jJsW2qo/OwScK3+8YI5lVH1w7EywFfamWRLv90u08vbkpJLOj30YXkobmcx5FdV
	Twzg4DA4r96vTUjQ45wYtUEqmU1O/yyfW3Ux+hEZ+CXuXCn6q9ktqQ4wJfsKuno1
	KQKXygAnwFRrvgiepmORR81lZbJyd+Sq8IdDEi+7AUjrzmMDeOLb1KfuGFdL5grf
	7CflkDQPyQaOp2r+uRosJmHuKvnFIb2F7JKz8oAdJGOM5SoKsNPlIJwtG33hlHDG
	JAe5hc8untVZWBPzOu3WA==
X-ME-Sender: <xms:XepvaXy5DATp4k9WZp1gMpc6WfR4IOOzgGhO0fsfp7vWZ3Pjt_Aq3A>
    <xme:XepvaQyMATSYS4ENHLjQuolr9kLlrp4oFjw8jrIcnrCj9BPxEJylsgGx-bM9RrkIU
    MIJ5AclY3llUZ60y_JfcGVShRZdMg4CwjFgRQGN5rVdFlvaXJtQllM>
X-ME-Received: <xmr:XepvaRYmoUChMVubufkhMTPVdPgRRZbwfkI9b0bG4sR9h5dEdnsIDasZAcrkEtjYM9_HwH6nlZj6Rc7omwMoBJEh1lNIk__yNtdo_H8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    gvsehlihhnuhigrdgsvggruhhthidprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XepvaRVVGYH-LOOolRbYoy5A9OIbrFYsnn2NdP1XsZemYBbJIoc6Ow>
    <xmx:Xepvafhfz7Vv8AQVJ8UstCosRE8a7rG3LOlbGsAyJSDJnXftuzCMiw>
    <xmx:XepvafvtlTkoMxwqKLRe-2JjJeShRkMq-cSgyvcsunqW0CIe7ILJTg>
    <xmx:XepvaY4wzY56qR_y0ncxlwyp5jS_bdBOL8GtISU9F50mheZFNVxxzQ>
    <xmx:XepvaXK3tpX580uAsLCuY--UIKjHEeJhEWluqQc__6ialYsDbwTr-jb1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:49:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Li Chen" <me@linux.beauty>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "Phillip
 Wood" <phillip.wood@dunelm.org.uk>,  git <git@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] rebase: support --trailer
In-Reply-To: <cb5a792f-c763-4fbf-bfcc-52f66c895c9e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 24 Nov 2025 16:45:49 +0100")
References: <20251105142944.73061-1-me@linux.beauty>
	<20251105142944.73061-5-me@linux.beauty>
	<cb5a792f-c763-4fbf-bfcc-52f66c895c9e@app.fastmail.com>
Date: Tue, 20 Jan 2026 12:49:31 -0800
Message-ID: <xmqqsec0xb50.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Nov 5, 2025, at 15:29, Li Chen wrote:
>> From: Li Chen <chenl311@chinatelecom.cn>
> ...
> Same problem as I commented on in https://lore.kernel.org/git/cbe93380-e145-4ebd-a213-928b8c3ba085@app.fastmail.com/
>
> The `See also INCOMPATIBLE OPTIONS below.` is not indented to the same
> level as `--signoff`, where it belongs.
>
>> +--trailer=<trailer>::
>> +       Append the given trailer line(s) to every rebased commit
>> +       message, processed via linkgit:git-interpret-trailers[1].
>> +       When this option is present *rebase automatically implies*
>> +       `--force-rebase` so that fast‑forwarded commits are also
>> +       rewritten.
>> +
>>[snip]


After this and [*] the discussion stopped and the topic has been
dormant since then for full two months.  I'd drop the topic from
'seen' soonish but that does not mean an improved version of this
patch is unwelcome.

Thanks.

[Reference]
 * https://lore.kernel.org/git/19a8fe42354.3909481a3912041.7970296104893780556@linux.beauty/
