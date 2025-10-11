Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AF2AEF5
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760148866; cv=none; b=Iywdnnm5HHq84S2ad+YtRwCBrS87TX2VHBbJ1/3UwEnyWEKGVaaJruVQPF1vHiuzdb/IxGLiEXEItBsYd5e+T/hb643FyT6wxHrg2cM5uZKjvZTqMSL/aa/Wp1IKb+pYK8p9/VYP4CAq2+hmrm5hEmMal1EDDoNMNX02VIHR0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760148866; c=relaxed/simple;
	bh=7+Ij/wx+PFLwE2MKglrL2o1lCje7bP3zyInH6yCHwdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iym2nghzmN3Z0zRhIvRMC6AbrHmR54eTyr0pCsP4lC+E4iPjBrLE2FTaVd0JO+QNLBMVnqbTne3UaZSDcYxXca/AHPDrbaW80lVW0XKn3bNjdqxPex65NYtnPudSOtbaEgBuxpQVRSNQoQFZUuzQ40YS2DbYBxjb/aaOZb/GaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MgHj+9zk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUgSNECD; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MgHj+9zk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUgSNECD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C79C7A01A9;
	Fri, 10 Oct 2025 22:14:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Oct 2025 22:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760148862; x=1760235262; bh=1yiuoH8DuQ
	nGkBXE6aatRXvzVkVc6IuNaSRd27qbLFc=; b=MgHj+9zkaTQq0FcvbJSKWPZX2G
	VrVTB1I9poYyUINeJV9Z4iU28b14B7/p1CsR1NvkZldtJTOBLVkylb+6GLnAvMNF
	1RnqRQBFCWHgZHnlupkGcxnx2Y/DwpKO+bXMpEiTtytXURHd0NbCrt6k+pw6gnYX
	i4e2VqsEYQdTpg24uA5FJ9Mks3kbrVmrtmMjUTWL8s6d36ZNZG1vmaAqrrZdPXG9
	sU0XYizXIoHCZuFfpooduvIS/xK/b1vYA5iYYvd5amzPQvT8kNwKcWPbTHBJmYS8
	knUNhl1I/8z4/pooTiuPywdlRSPipvIayeutuQGnbK8i9HGEa+MkQZT+5iwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760148862; x=1760235262; bh=1yiuoH8DuQnGkBXE6aatRXvzVkVc6IuNaSR
	d27qbLFc=; b=GUgSNECD3wjb2jhUFK8kMOlwx1S6RvC+Hudyr273pdcjFsCmwFG
	M+f7YfEkpdesdmGWxWKhI3XRDa0Jc/ZD1NuAKbza06d85SEfdmvr3w8uwgA01484
	9lo+yp7WyeFbwqxK3u2L8uzkARGTBpLwjqLEeNnqP1JcoHurVNYOObWr0EWYGRaB
	Psvt4mcBQtZxnwGpsDJ2sG/a7AxbSR7V/Rs8aOap76CuXTPWGMlyjP/wX+JYOkBg
	Rhqugv70PBj4jexcGFWlIqiHd7HXKy2XoXPq3vikce+Z2iKsFztVoyFaGavPHGc+
	nfnbUzVJtqYjyeDkCTIp6ArCMdxmjhdkuOg==
X-ME-Sender: <xms:fb3paMQ6WtzkOS166e1wWfuMiQ-xsuDnjeuI9S8VnBZ-asZygo28nw>
    <xme:fb3paGUEs39vLic202u-O6BMYc6MdC3teDp-85OKEHLJRw7syvQNw74JRbmz6uGDJ
    BrjS2YG-HSxI1xLcth_4HcloCLnuaruFZfUQUj1ZArgfynkxFoC>
X-ME-Received: <xmr:fb3paOTV7Uu7vWcBiAzXc7dMugsex43QGNz95zFcA24kU2r6ZKk1R7VCBxdL8_d6lWQfpC1PbEfGYpcy-xGSuj8Wdw61_I_6Q5hJx_WicRmGfz0Gp7WZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfhougguucgk
    uhhllhhinhhgvghruceothhmiiesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    epgfevfeeviefhheehhfegtefhvdffheefheeuleehieffuedvvdeuhfevffeigfeunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhmiiesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:fb3paG3rExmOy3sAgaGegsGPrkSLE4fhc9iZACjJ-X17OUDkU_LJ3g>
    <xmx:fb3paGcDmX3t3Otqi_xUX3glnQUvRVgrrUDbxMJOPMBOb9ajLiB1EA>
    <xmx:fb3paGN0K0Ev_GqNOa3vf9iRydOIP7pIcssDfBte56WUJM7kiNf4kQ>
    <xmx:fb3paCXpFYM3Jeh8uNMGbcFReQ43Y0dWENsCuKqR0oSncOr0zqPybQ>
    <xmx:fr3paI_DEGScZcBnidnW6rLomS7oF5k2Okho0pRFnF71hCzN5ptBiJ9G>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 22:14:21 -0400 (EDT)
Date: Fri, 10 Oct 2025 22:14:20 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/5] lib-gpg: allow tests with GPGSM or GPGSSH prereq
 first
Message-ID: <aOm9fLW-8_oJQZy9@teonanacatl.net>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
 <20251009122457.1273701-3-christian.couder@gmail.com>
 <aOisaq-rSdwjwo6b@pks.im>
 <aOkTs7G2GGLKajUf@teonanacatl.net>
 <xmqqbjmeafqm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjmeafqm.fsf@gitster.g>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> I agree.  But it is ugly that any tests we have which rely
>> on the GPG2 prereq simply never run.  That should be fixed
>> and, if it were me, I'd do so by dropping the flaky tests in
>> t1016 initially.  Someone who cares about those tests
>> running could debug it more and hopefully fix the problem.
> 
> Let me queue your two patches as-is to leave the tip of 'seen'
> broken for a few days to see if anybody bites ;-).  After that, we
> may do "s|test_expect_success|test_expect_failure|" on those tests
> that you call "flaky".  Are they flaky in the sense that they
> sometimes pass sometimes fail depending on the timing, or just
> simply buggy and always fail?

In my recollection, they fail all (or nearly all?) of the
time in our CI runs and when I was building git for Fedora
infrastructure, they failed consistently on the Fedora
builders as well.

They fail rarely (if ever) when I run them locally, even
with --stress options.  That made it rather difficult to
work out the issue.  I thought that it was a timing problem
for a while, but I wasn't able to find a way to demonstrate
that.

Thanks for the willingness to suffer some test breakage to
see if it can flush out a fix. :)

I suspect there are folks here who know the test suite and
code being tested well enough that it may be really obvious
to them.  Whether there is an intersection of those folks
and spare "round tuits" is another matter.

-- 
Todd
