Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA341E0DA0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994506; cv=none; b=YBD6FiCzhXEWqlw6xL66RrXpTf8QrX2jlpZFsOL/a8hsiwR3ezQQJqLczLI6OsOz13DwIuwmwyXlOPQJapcNt5TQYD8RpUU+ZM8xM/wah8l58MC2MadkqqaoRwwmU1wvgrsdRxzhMDTboaBYpuUWvaqYrIhmS3Lve5AjYmfKdCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994506; c=relaxed/simple;
	bh=Ft7FFJCku9nq+7nOi3pUN1wWBCLnkZ3/i+JrfIq9YGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4Ooot/ykyEQi/1MD5IjMikISYYyNIDX/iM+5E173bwbaM9mW3aQzs4GxfLZ9Nd760I+o3qWbVgZW8DncD2Kcvo4Uh3MR0s47GGPq1Za1KfYFS4c8d6NidXkkhqwWSQjedlOBcQBA7N5Hte2iJHrcxEl7UcFxzasUSZ4s7Qb/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i2fRELWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UyL5y09v; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i2fRELWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UyL5y09v"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7121311401C6;
	Tue, 15 Oct 2024 08:15:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 15 Oct 2024 08:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728994503;
	 x=1729080903; bh=ea/ok2fK3ny9q9uetb37DQ7F4J42RPAONaJuJKtFG68=; b=
	i2fRELWIFLioJXVKiYnXL0Mxs4t7ngi4JNEN4oKNwcMBYwkKLdn1YnEo96ymYPC6
	su97wOmTUHqo78BQC4qc2Sl8Ibkg5TwQKLay/UlC2GkhKtVeBhrUXHbLToBxVA30
	p+c53VHd+MWMXXS3YDnKteulI2VzHzj1biF0EjjN/FtgFSTgvbCxdk4Z9hI0d27N
	J7nID+glyC9WlvKnronfGqde0ujQ+9OwkDHxpPb7V/V4jMRKwvuFrhw7cQ3kbJ1K
	cCNHggZPLIF+7DB89rBfgUHyHe83IMkJW9qpZxMzxbHiaUa/2NdhapyzHDm06New
	ZOVvyp84WktIyEPcE9Wl7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728994503; x=
	1729080903; bh=ea/ok2fK3ny9q9uetb37DQ7F4J42RPAONaJuJKtFG68=; b=U
	yL5y09v2hHz0yyRzGo2rxMV7CmjQNxpa3oXakNEFg9o2/GwZX9s8eVlpj82/nEuS
	xAKFTlo7W60wgk8avy66PTcjg4/A0sP1T2XQqPJBzql3+ARk6HOMh0QE5nCnk7jS
	25bUSeQC9a9GJOuiXPfGcNhkttcc7IYZpSpjqwIuEBTS7fYNbjhjVJrvzWYEMsER
	M4tl/MW9mwOFSAQLbgUTaGKZ4KJl/kWJulmD7gS7A8xfPb2HCjOw0t5Jzlozpp8V
	8Mrzb9VYDdOW7fTqzXdjzBbygAwZyDM1dvNI1/7u1MwMBgebf5dLvx1MjwZzK6WX
	O4u0qcY83X8dDs8v7F5kQ==
X-ME-Sender: <xms:x1wOZ7qYgbKL4LxYfUCaCKno46M-Y_y7cWdRfFt2WYiz_c5YFm7sIA>
    <xme:x1wOZ1o_08-TDkYCDiUozCNp2DmdKr21EqCRjYJc0kuKj2VPDNB6fHMo68X6FbgT2
    YlmUHQEl2W9fA61nQ>
X-ME-Received: <xmr:x1wOZ4MtNbI37ZagU-DgRKIKGm87LVMeJuYi3dSCBZHBqrLmZ7C3MxZAOr80aMtjzqcycp4B5wBjRoXS9Osqa3Rm8UZVjyRnD2apKcUDBVWCMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmfhhitghksehnvhhiughirgdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrgdrmhhilhgrnhgvshhiohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:x1wOZ-5-L3tevfRv8V0hbYxFOsk9_gQ32XST7mzE7U2AfRkVnpsy-Q>
    <xmx:x1wOZ66j7sLjDqxKco2jqDfaztF_4sB3lGGcCUCdikZ1_fEqv-KcPQ>
    <xmx:x1wOZ2ih-K_wRni_XkQKWQX7hb7R4uFCqBWbYCdYZZIgYtY489gJDQ>
    <xmx:x1wOZ866XbwquF-y_U3UwetolZTS5o0AGAoxL1XWaonSmOwi5EpozQ>
    <xmx:x1wOZ12V0sVaMX0gVRTgphI5p-Oj6b9OEHsv03k9r4cNMnun-8NH3jiM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 08:15:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 149e34b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 12:13:46 +0000 (UTC)
Date: Tue, 15 Oct 2024 14:14:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Taylor Blau <me@ttaylorr.com>, Martin Fick <mfick@nvidia.com>
Subject: Re: Should object repacking only update server-info for packs
 instead of doing it for refs?
Message-ID: <Zw5cvnkBQ1MzIS79@pks.im>
References: <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
 <569E3AEA-AC68-4186-B38C-2E47DAB9890E@gmail.com>
 <Zw2MVqi0FLcMuR8Z@nand.local>
 <Zw5LwB2ap1QnmG6L@pks.im>
 <428B24FB-A648-43BA-9381-1B46D99E2F37@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428B24FB-A648-43BA-9381-1B46D99E2F37@gmail.com>

On Tue, Oct 15, 2024 at 12:52:12PM +0100, Luca Milanesio wrote:
> 
> 
> > On 15 Oct 2024, at 12:02, Patrick Steinhardt <ps@pks.im> wrote:
> > 
> > On Mon, Oct 14, 2024 at 05:25:42PM -0400, Taylor Blau wrote:
> >> On Mon, Oct 14, 2024 at 09:33:17PM +0100, Luca Milanesio wrote:
> >>>> It seems counterintuitive that an operation designed to repack
> >>>> objects would be performing maintenance of any sort on refs?
> >>> 
> >>> True, it should not touch info/refs IMHO, as you’re really not
> >>> changing any refs.
> >> 
> >> Right. I don't think that the current behavior is a bug, but just that
> >> it's doing unnecessary work from within 'git repack' to update the
> >> info/refs file when it's known ahead of time that the refs haven't
> >> changed.
> >> 
> >> I think it's reasonable to skip this step when repacking, but of course
> >> we would still want to update info/packs (assuming that the repack
> >> wasn't a noop, of course).
> > 
> > It certainly may be reasonable. But in my opinion, it would be even more
> > reasonable to not use the dumb HTTP transport at all. If you don't there
> > is no reason to run git-update-server-info(1) in the first place, so
> > you'd neither generate info/refs nor info/packs.
> 
> I don’t believe anyone uses it anymore, but someone *may* still use
> it, and therefore, Git should update the info/packs during geometric
> repacking. However, why not introduce a “kill switch” in git config to
> disable it so that all tools can automatically skip the expensive
> info/packs (and info/refs) updates?

We already have those, see "repack.updateServerInfo" and
"receive.updateServerInfo". Not quite a single kill switch, but it is
possible :)

Patrick
