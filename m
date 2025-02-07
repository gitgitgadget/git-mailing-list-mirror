Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5F1552F5
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738909717; cv=none; b=NVMNXcvmadKgtX2qsgQsWKwcB6aT2Lia1Ixln12WK/7aQiWaZzlbxUPyCCt+/M7Qjh88g/E7AKAU1ZFZJ/oA3NSsjf6PB+zcKBKGaobuwesT7AvpIZiT9iMJCc40e4e9mqF+TqLPuSg/DO7TQNm55BQ7AZzhFDmwFOyhX91lW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738909717; c=relaxed/simple;
	bh=y6eNT2XknMoVYk6mFhqBYGk3bfDRn5qh/Nx6sOpxs7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVq4aZmG3fp3Kmdh/G2eLy1D2zKLjOn2UdK5F1AJAYmLFkiXwiNYeDFOapbltQFcAnMYekxsqZknVNoR5Edgo1Cx/8HUPVGptrvXtWy137599HMa+oOp7yvJ+1X7CtAX6eu9nLe6ZeBhOTULFYjkWBK7YVmGZx7ZFUv6+Z8fDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nwJ5wJKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChGqZWas; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nwJ5wJKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChGqZWas"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 15F5513802FA;
	Fri,  7 Feb 2025 01:28:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 01:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738909715;
	 x=1738996115; bh=p/ujTK0B4csVe7o6Ng01u16L55dM8LSF2ECqzXeR0eU=; b=
	nwJ5wJKQ/zm+Ev+SV6cTIgYIQFw4HTq9TKPeD95+v8t4ZHhFjp2mjvulbdLvZI2f
	/daWaizTw237gePdyXS+ynoUpTe4ubdyd6FAXKEuLDvuL7q8PYFzf5DzV/SP3R2b
	gKXuI8NZICRbmHFgw93so1Ypf80ZGi/f0MlrrB4sx68W/ZleECLS5HRlUMmfgRqO
	bnjZ11chb4oAHsMS6QBP6hAQJ45toSV1+iJmrJYvg99l0L4jc96p7ROAmS3KzaEM
	Za6f0S07EGnNk56KQJME4HTMnXftKC+0bKeDtLdFPbdk4pJkP8GZibzUiZv/5il9
	ZxrAQ7/fzklF10EFeAvhaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738909715; x=
	1738996115; bh=p/ujTK0B4csVe7o6Ng01u16L55dM8LSF2ECqzXeR0eU=; b=C
	hGqZWas8eKYK9dfh1z03vc+qp1QlfiPAP4zA2DE72oJTNXwb6xx8GpMV2yfE15ai
	Cpn+oYOO6eaE9MK9h0t43uDjrG93Pa/za77o10GqElMm9jfUVjlQChsgyGPhgpFL
	K6Vn6u3AXJwhyOv44DwPaio596lWz41iwI/N/lgYptCk05bRUimR1B13zafu6jhA
	KrEyP5B7wRWAsJOnARMMTpoRYtAm3rGRzVw9gqePfmclA17kDmkQFmPrScV3/9+W
	X+l7yO/l7KpVi5zSnLZGWJ4dbfRJAEHFHwTlWeBiaXgZcm8jPs+JEnfdG6VmRfI+
	qEZQOyQXUbVkgtGp0fGbw==
X-ME-Sender: <xms:EqilZwaIhniM2SynKOisgg8M3DInjhmpszZzmbXNR7uGJoYv0ck4yQ>
    <xme:EqilZ7Zq-xD_cU-L2flEzluhisi5WjhLyyX3nCpRae2Nv6Ex9BNvrt1K7CqPci7vK
    UW-B4QQTvuH83bRww>
X-ME-Received: <xmr:EqilZ69LFEiIzFRCZsZIg8Q8NbAOdjBxBKb9Kf53j5lQcAedKTpEFuXFK5fWZ-3x9OA1SIRX_nORJsYx7B_sMqt3OrzUtFP84Lw-_BmwBfMKKoob>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EqilZ6rf2rhXQ4dffA4wxmlu0Vv5SgcOhcKckanjQT5G1Py5WaEGaw>
    <xmx:EqilZ7q7HzNFRoOBhpj4fqAozHBfkIKliPStHNos3AoI1Nbgxtwp0Q>
    <xmx:EqilZ4SmiiMt5JZMtKO4F6eTgpLknQYtmrEYGqmHw4lHWD4mnUUtyA>
    <xmx:EqilZ7oP8R9WMmUPhiKBBK_F52bG3wI4pMOi4cyerV9LjQPhaAtIAw>
    <xmx:E6ilZ8f6XTW3rj8XTiopspHk78acZdlf6ZkChiKgqrHqIT9q5bCMlvyt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:28:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 029e884c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:28:31 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:28:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, David Aguilar <davvid@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/3] difftool: eliminate use of global variables
Message-ID: <Z6WoDpX5bvXa21qo@pks.im>
References: <20250206042010.865947-1-davvid@gmail.com>
 <xmqqy0yjjix4.fsf@gitster.g>
 <CABPp-BHpqSRy=G4HB+QtbFuP8Bohw6Cd99va2++PawehCDt0Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHpqSRy=G4HB+QtbFuP8Bohw6Cd99va2++PawehCDt0Aw@mail.gmail.com>

On Thu, Feb 06, 2025 at 10:08:29AM -0800, Elijah Newren wrote:
> On Thu, Feb 6, 2025 at 5:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > David Aguilar <davvid@gmail.com> writes:
> >
> > > Move difftool's global variables into a difftools_option struct
> > > in preparation for removal of USE_THE_REPOSITORY_VARIABLE.
> >
> > Both may be good things, but I am puzzled by the "in preparation
> > for" part of the above description.  Would it require we lose these
> > three global variables if we wanted to pass through a repository
> > instance through the callchain instead of relying on implicit use of
> > the_repository?
> >
> > Aren't these pretty much independent and orthogonal?
> 
> The declaration of 'extern int has_symlinks;' in environment.h is
> guarded by an #ifdef USE_THE_REPOSITORY_VARIABLE, so if you want to
> stop declaring that, you need to both pass a repository through and
> stop using that global variable.  (The change to trust_exit_code and
> symlinks vars do seem to be independent, but kind of make sense to
> handle at the same time you are changing how has_symlinks is treated.)

Ah, that makes sense. It raises the question whether the refactoring
thus breaks something because we don't use that global variable anymore,
e.g. if we were munging it in the preimage. But as far as I can see we
don't modify it at all, so this should be fine.

Patrick
