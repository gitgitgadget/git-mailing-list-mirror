Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA320FAAC
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538830; cv=none; b=kcFYNLwM1vj0d6aLb8qN+GR9tX+mVn9W1GTHFZE6P4wArp3RVi4iOjls3+iKE4PFeLIAcM5b8O0D4DMHsMeXIDJwowElI5oqZM3tft0DfEYXEKfkbgfLEXSNrEC4DCikIqZKdiBnp2tGWdcjsxL7dRM9bxOLHClGMooFoQe0pbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538830; c=relaxed/simple;
	bh=9gbOETyWD0Smzxmq9sERh7bUKwxPTHwGgHO75JxPDgU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDzUdCjeMIj/gIvUxRsv+7lFQ3eCBin020Nkd0TbkcorNPPcPWj56qQYTzDHYfxaurbFqGEYWmSe6eTcri4/ZDzLLkzMoo9Gy8TJxF6Ha59C+E1PTMH1ronUeooERBU5USGmgKKLIF72IitiglP51ggujiyOFKoQETYaxWVDPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o+9N+ob8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYatXlaV; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o+9N+ob8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYatXlaV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68C5F25401E6;
	Wed, 22 Jan 2025 04:40:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jan 2025 04:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737538826; x=1737625226; bh=0MEA4Ic0E2
	W8YQH33nRPX17toY9Df3Y+k2XFrbbhSnU=; b=o+9N+ob8o3TLYrgJ2FmJeknlG8
	wxdARLt2ubBC/3JRvYemSSZEjzdeNlW7EQVbveeW/M4ubGxhqCIQ7MU+rR/JZVYC
	XcMrqf68ihttoecZvEpD1Jzz+zu55tZc20ZSfTQADzRRE6lSV24Z5t8a8HxPed/l
	mLFT4dk+/Vh621yv2f4LSVPK3ZCzdEBmh360mz71zpmX1hAIsiR7cBVdZKL16Vtu
	5hpYHgwPdTMKds/gldYyY9xK8XaTqQRw9rYqsoYfLIoybqb/NRZVLq5lUPJr2nUw
	xKj/yzk1zTNohrgD5AhXTaxLWTC/iDwSD7SQXKspzGi+B3oLif9R/FMb9coQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737538826; x=1737625226; bh=0MEA4Ic0E2W8YQH33nRPX17toY9Df3Y+k2X
	FrbbhSnU=; b=YYatXlaV0WDVNZRp2VSFFDtkgcesF+CsgkC7L9Hi01kcroYSTIf
	QLzztoa+QJ3nygpm+wl3MtjmD189J8nfd8oUh4TUr35JBA5IWCZncL6lDj3BYgd5
	0IfOEivY3648Hd0Ulfl00ISTor7VIcValOwNEIX+Ptn7I+GDcI+Vdp9RJcLy49Ig
	oIS5rdzrEPoEKvRX8XTJbqqKqIagq/W82xhyokrl4GcTAJGg0d9+Y+fWelYwq5WS
	QsPt5zROgHwHIRWZs99jhxowmZoIuSOJ9QcevgUK1g5aEihlXgWHOtmVkfg2BQqT
	2hxuIL+2KZQcwFnW03715WijqUFt9p5zwkg==
X-ME-Sender: <xms:Cb2QZ6fxFzJtI3lexwO-vfOUI_YA6n2_naZZg1BYzvF5h5Pvz0PpbQ>
    <xme:Cb2QZ0MKOLePGGKbihuQ6LStKsRQa72qLXVPYd7-XLMPeipLA0kWfIWFsNlKymytO
    O7b3EPtJqC17tNdgQ>
X-ME-Received: <xmr:Cb2QZ7joOOPzSbnC7Gjb2MGZEcjQvmWRvnui2_OcvIuPS8plmQSsggdQA1w_FUD9m8mAg1tm1dNbz52WJk-e3eR-T4mx0AXNUhaRRmeTTqWnXtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepheekfeefgeegvdegvdeffeehtedttdffjeeuffelgffg
    heefleffleejvdefheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopegtfhhjsehjohhhnhhsvghnrdhnohdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvght
X-ME-Proxy: <xmx:Cb2QZ3_S0z6yEI7Ltej2lV0TDU5cvi1JfFNk_gpVk7DPsBqB3u5Mpw>
    <xmx:Cb2QZ2t-pnq0Hyyu6ZAVR3ecRAplhscgGcTDwibHZnlvhqES4u8wUg>
    <xmx:Cb2QZ-GRAqREYRTXXqVYBw8ezrpmQciz3daNsmgnR5vNWPE66KSvPA>
    <xmx:Cb2QZ1PUMTDhX6UGeCDgfcMCqcs2j1eic1MvzKVb2uyD2S3aYMsI5A>
    <xmx:Cr2QZ4Xr8e4wjEVD-fZeUp477ZGtHKU8td16sTfLur-Oej84k2DQxKiK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 04:40:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d80a7c98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 09:40:22 +0000 (UTC)
Date: Wed, 22 Jan 2025 10:40:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Christian Fredrik Johnsen <cfj@johnsen.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature Request] Allow batch removal of remotes with 'git
 remote remove'
Message-ID: <Z5C9AcABPMz6OFRd@pks.im>
References: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
 <CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
 <CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
 <Z5BW5ofJVbM1obb5@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5BW5ofJVbM1obb5@tapette.crustytoothpaste.net>

On Wed, Jan 22, 2025 at 02:24:38AM +0000, brian m. carlson wrote:
> [0] Sometime back I reported that `git remote rename` on a fresh clone
> with 45,000 refs took about 45 minutes.  The reason I didn't choose the
> remote name on the original clone (with `-o`) is because it was in a
> GitHub Codespace, which had cloned it for me already.  Fortunately, this
> is now down to about 55 to 78 seconds with reftable, which is a major
> improvement, and I'm sure we could do better still.

That's awesome. Thanks a lot for playing around with reftables and
reporting your bugs and findings, I really appreciate it. This kind of
information is invaluable to us.

Patrick
