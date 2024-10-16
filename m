Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4215C147
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 03:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051041; cv=none; b=dpvduERzLc5PQlivgJN21nAZKMWmHILqG7y1mPICcemm9nTs8IvoLjqJTy22mt4zyGUKyV/Pb4+1GL6hRSkFtXJ2ZXexvtBc2rpZWyeWc0yD8G4REvLO8WaCnvxjKnw1gKuaXC5umfzP9ub+AFG1CiNoHgQRFYPgvnu8lhWxaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051041; c=relaxed/simple;
	bh=jMlRSCixqwhrkH2x1IhmDaOX2s2jceD/BeOUpKH98os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv6Q0KgiyU/lwfhV2I1ffqDmP67r0qjNJKe8jJ2KksmUSXPojSv/01m6K+pVH2B55gdj65BdAJV80sH4EyXHqlpcrfp8NcvU4YDYegawBZ+IPdCWJZa8ipBTuStYbvYAhPLWEFO4xNgJGKK6JKxz9AgONd/kQYqT+xPmoxB7l/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=On77RsxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/jqvygB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="On77RsxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/jqvygB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D8F2811400DF;
	Tue, 15 Oct 2024 23:57:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 23:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729051037; x=1729137437; bh=jfKt57VvR7
	wouoPIwXxFR6NXEQ8oURrV66iWfrGOs48=; b=On77RsxLx2JeacRjAlpwgII6NM
	5IN508ubc3nVR088xdarjVvqJQmg4cWsfvcL9Rdid1774xBKm95y1h/tnza007xk
	Zfsn87meJkJ5UPeqRHzRUBg5/90c5UVrZJKvjkkW1LDcdi4H95F1XhTfo5GCJNh5
	vXV95NbhMMnJjW99ZWyzUt8CfYts1Y0EsMa5QYypgIPYYFMT6caj0CIA6P9oJ5Jz
	sD2VOMdcDV8JdOPhsfjN9k9Nl6J740H9YMVMlhLIn3Xzfz4es0vEkZ2qeSSUxbDH
	L4xcO7cllSQxsJENY8SGx5B/AA72i+d3a0Hzt2G0TNlapX13wRcbcyIu2MHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729051037; x=1729137437; bh=jfKt57VvR7wouoPIwXxFR6NXEQ8o
	URrV66iWfrGOs48=; b=G/jqvygBhQVJqsMpgEcAvR3Wgfc5dIpeat9rmwGI8e1P
	/NjTsFPBcyY9eMy+KH0fRysdDmYCzbiFrpcQUJDFk+3ot3XnYmcO6HCDvqt7O7lJ
	T0v1X33o4MUrbsO/P3m4nqSsI1bF99xlhGg9+KT7A82vGBWdxXVIw2pd+i6vQvOc
	sxUXD9TDRntczwoZYgL/hpy9cq6wnP2PAKWoSMkypoURCsAmX1BVNmjbQ/MlDNC7
	djYs1mkchLrlZPlt9s13VLK5RsTHjg3Qtns//r601pVBrDYqgIvGy+1UbgJJ+p0j
	F584e2TkwJ5ceaxZGxvKpSYLG0BrE+/jJHh0fWLy3w==
X-ME-Sender: <xms:nTkPZxAnBy9HUh91mmZgwqSPO5LVkPAdi9ZWYhfz2tDQeUWWb74BzQ>
    <xme:nTkPZ_gd2p3VoDip3Jzni8zhx45eRDZJ70AwmfysEuM_4s0MyIgf1UOPgqebdUrfu
    Md895AD49wpRw8qZw>
X-ME-Received: <xmr:nTkPZ8nqy9QVpVS2DNnhI5javNHaXcraR-gmWTb6om3BuglfEyHGZI13ELbwCL10oOwLhKJx-Dp3R3PmMhxoiHQAnFSZbqFiGqx1__78KMIXVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hm
X-ME-Proxy: <xmx:nTkPZ7z58tNLa48pAgML20EpaCfOwKSDle8_5FMQoZhteJjFHeTUZQ>
    <xmx:nTkPZ2QBZwgjCWLZvHwC62OSMGMCLPYcJkYCuePbmCsE_8DA_2N_3Q>
    <xmx:nTkPZ-YLMqBuVSxSq9ieoZU0lADo-ELf6Mve5vtQ4oeFOSoTi42WKQ>
    <xmx:nTkPZ3RGpQrDvmpAXn_ZRpst2ylOQpftBtHNKkc6sw4vV_IrDwDMtg>
    <xmx:nTkPZ0fIvTPNfQupD8TAyG6oMGc_FpBuhQno62K1DUGM1Y4PM1uqINwp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 23:57:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6a84799 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 03:55:56 +0000 (UTC)
Date: Wed, 16 Oct 2024 05:57:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <Zw85joY3Hqzx23xc@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <f6a8582c34a7b77aa3e2e45298208050333c384a.1728992306.git.ps@pks.im>
 <Zw8AaF4VOaQO+P2M@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw8AaF4VOaQO+P2M@nand.local>

On Tue, Oct 15, 2024 at 07:53:12PM -0400, Taylor Blau wrote:
> On Tue, Oct 15, 2024 at 01:45:11PM +0200, Patrick Steinhardt wrote:
> > Further note that there are several "!MINGW" conditions in t4201, and
> > all of these fail due to iconv-related errors. This is quite likely a
> > leftover from times before dce7d29551 (msvc: support building Git using
> > MS Visual C++, 2019-06-25), which switched Windows-based builds over
> > from "NO_ICONV=YesPlease" to "NEEDS_LIBICONV=YesPlease". Consequently,
> > adapt those tests to also use the new ICONV prerequisite.
> 
> This appears to break CI on Windows when I merged this into 'jch':
> 
>     https://github.com/ttaylorr/git/actions/runs/11355564982/job/31585450667
> 
> I'm going to temporarily eject this from 'jch' and 'seen' until we can
> properly deal with this.

Ugh, I'm looking forward to the Windows jobs for GitLab CI being merged
down to next so that I can finally see such regressions before they hit
our trees. Anyway, thanks for the heads up, will have a look.

Patrick
