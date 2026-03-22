Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2833290CB
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774201812; cv=none; b=l/whSFrZqwfnWGfEOqnAnmtefAxD9J/AlCEIAW5174psDfw9HwK6GI90//U2rQ7YKKCvj2TlhjuoeydSXqM8CDL+m5ajPnclIKqm4bZqH/0hsyUW2R324/XbGucr+OR+/xul+v9yWWbfc4KXtOiZANMmuZNzMlghudYm0ApZUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774201812; c=relaxed/simple;
	bh=ensHUGo98R9eMmlVcZDpoLJqN/bnjLAVTEuoJxhYZrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UDoyR8gOtIs4WLtHiCS4WS8cVfyvDVRDLZwsefhnS6rZ3TPY/0W+pNDJ/TwqDjfSt7gyXCfnHnf19Ibtnyvm/C6xYpuI8jtmbd8PO5YEeoj1LN52TRFFD8c72iGsgAflw3LRjQ6TDNs1nAQpnj1knRCT2vImDl/kKLKiG5mCvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gzEUWZYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5lmUfyDk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gzEUWZYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5lmUfyDk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CADDEEC0118;
	Sun, 22 Mar 2026 13:50:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 22 Mar 2026 13:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774201809;
	 x=1774288209; bh=b8TaJi5iO2x19Ec1QJHLNILzKFU4znd+tPI84sx7rZ8=; b=
	gzEUWZYUrpajoTn4ja4m05KDgoWv7vNG37wgGXcV2udX9u8d6r84Wpt/06h+bnmH
	f27SNMhlz2Zi6woRVX3jfT9n8jr6nPTbNZd7Jeds6fM5Qc7A4oI8+S+BTsjShiFg
	UO+C1R/fNoa+ZIxUO17ECylXvc6meeuEjzFZGGHKedA0RI8ZQVPYRpw7RFBf0hrr
	0sq/9qcg0C0dpi/Lglof8tinJDQmrW1nK112HiaqB0c+z1ubp81C0Ll92kNWFOVd
	hiUosOiV9+Jv95ARhLDafPkkc6BZqU8px+GHq1OpxZmTbsq+HiS0L980ChEnL8U0
	96serLPy2/EI1vLVj7Gk8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774201809; x=
	1774288209; bh=b8TaJi5iO2x19Ec1QJHLNILzKFU4znd+tPI84sx7rZ8=; b=5
	lmUfyDkjrRqQFZj4O9FZrgdQcIdNiMk6q6ZQQHgExuO47t6aZVtjVIs45lxLIgGN
	NqKSNY+JRWpL6EkZUYMw7BQbRij0+fI4P4X7piHC4OJbB2WdHMo2NsIL/oYV9wuZ
	m31EMBDxJ530ZuT+Fq/OeMr3368MRK6ANLrK/vCMJvhRu6xUlDUSYl13NgyDn88J
	IiSVlpcbrhoLciuKyt95h1UNFHjG/IbVdGWckF/+9ZySA9ywQvSPL91zNzE/D0Ah
	IFGuNRjxfJ/p/ur5u5X2/qNjMKtbJqfZ1+QH8GDNFwguF0r3BPiZj8C6NKFj+yyx
	CCvcV/fTmrv2AbNpRqkCQ==
X-ME-Sender: <xms:0SvAafeREo_tk77lqW5Xzh8DQnYmv1DwLO0nendtvHrzFJJ1paoRVw>
    <xme:0SvAacPQ7r6BKLRsFutw8bE0FyXbWZUvpL9RUU7heLquU6GF4HrEWzuyN0RzWpIav
    48hYgVuJfVqtzViGUo9PPcHz5145IS-XpUoeLVQ1u0guHCt6PQe>
X-ME-Received: <xmr:0SvAadgi7NY-ouNj4OfVZXSimPxi7xwI1YKRc6c4MmNkxSD2Rt4OjmqCa_jS27-o3v2WS_5ZYA_Nv6_d8YLcS34geQCQCQM9WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeigeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0SvAaf3zGPJmBv308CM1mWcrIWNJourUmTkwPmZT5nkQqqjBGhHpZQ>
    <xmx:0SvAaXhmUoCZx1BQI8kQbPWjSXEDqSW0P7fvZtX_RkaiidKt2-FOLA>
    <xmx:0SvAafe-W4Dl7NpH44RcTRagjmjy7oQ80gRUuzfU_Oip76mp5fQdOg>
    <xmx:0SvAaalMQdrr6LswukFZpXNus7fx3Rr_SOk0vcvAzFBrba1yGUCfDw>
    <xmx:0SvAafRRxIla4Fon-hVeFByoyQ87o98jNgtPr1JkFYA7DM2V-9ZntGXg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 13:50:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Mar 2026, #08)
In-Reply-To: <6c108696-2d41-4fa1-9662-fbf6db97f767@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 22 Mar 2026 17:30:44 +0100")
References: <xmqq1phc9x98.fsf@gitster.g>
	<6c108696-2d41-4fa1-9662-fbf6db97f767@web.de>
Date: Sun, 22 Mar 2026 10:50:07 -0700
Message-ID: <xmqqwlz392k0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 3/22/26 7:46 AM, Junio C Hamano wrote:
>> * js/macos-homebrew-forgets-reg-enhanced (2026-03-20) 1 commit
>>  - osx-clang: work around Homebrew's clang lacking REG_ENHANCED
>> 
>>  The build on macOS with Clang is fixed to work around a Homebrew change
>>  that exposed an issue with missing REG_ENHANCED.
>> 
>>  Will merge to 'next'?
>>  source: <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
> This seems to no longer be necessary -- the latest workflow run on
> master succeeded (https://github.com/git/git/actions/runs/23392330338).

Yeah, I saw that too and was wondering if the glitch was reverted or
something at the platform side.

> Did some kind soul fix the runners?

If so, thanks.  It certainly was not me ;-)
