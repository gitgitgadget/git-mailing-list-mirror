Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCE2EA148
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763285; cv=none; b=rLh+dpXTRmOdbv5eGwYFJLLxqyehCA68ZHCTXIyBUHaLC6+K7oLga+K6PaY3pePs2RkQnH+mNxwwOtZOMaoWjbm49Lc/Zyi39lDqGQdWax2DpqkfWnihkgxX/Hwf+yJSXcNqxytpmLgCr33bFdfXdnrC1ueag7k8A7f5l6HXOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763285; c=relaxed/simple;
	bh=HZPdkBqdP2DHDAPpLpk/wvtWOkLSrJ+LBG170m7NhGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uytopt5ALmXH4bAeKzRuOERaA0Y3Nmxq+ygvWH7u6yzCeLs8jMMQp0EeiJL4dPaHQK9KbtduR3gRdEELlzYTaFuFMbMp5BRgwRgM/WN50KeDfZS450v9pNYKiq9odTvBHQmmyXr5DqYT5P/4RBRG3yJ0dkU+QEp5K5eLzJZQraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=imGePRn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6T/NPE2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="imGePRn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6T/NPE2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 28E28EC00BB;
	Thu, 21 Aug 2025 04:01:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 04:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755763283; x=1755849683; bh=F6Ct5w3eCp
	4mVmWjRSw0tzkK8d7m6DwdY9pNzndBfm0=; b=imGePRn7mPzZ1PN35J/BMz8VtK
	Flgt1YVJ8zVAISgrJd1wJ0iPWs7msBM0ZMJNEW5W7GsqvmhcNbijrotQvsvFd3QB
	K0VDgQWy/wXKh3uVZdu+FkxhOcXdFfFUPbLfyPPIJgdrbBDNqrSjihHpq7lbAy+9
	n0tMOjpUsxrPCghUI4isDFcWBKmEeHccQKz6nSzJ+PNjxy/NrgMkpgRwZ/OhheRW
	naHrrb14th/2o6nfSYW9uU0xsJUo3LjwMz4QsHrTArbyMm33xha9Mnq2IDEPSR5A
	Uxx3lOB6XO6kv5eMtwSMGgh2cEFakeb51Vx+szUm1ZLh8pz6x18avUhsuMwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755763283; x=1755849683; bh=F6Ct5w3eCp4mVmWjRSw0tzkK8d7m6DwdY9p
	NzndBfm0=; b=n6T/NPE2iWLMbFmPO4C5EaQVxsca4PqDFGOZSBMt21DG8Pw+Del
	YsTSxU7tEhZBwzUF33g23W4kR4XeDK4Ug0GEzuqZ4YeES7hgNc0yc17fG7vu5Vb5
	NJmUcZv7zHsVcY/+0CFOEoOpXqS6atQc7Ap3+FPiMH6hiNPwl9zrCOgUvZ+SxMDl
	r6b022OG1XQPLyy9ZgtH6OadH7cmcFlOQsTk9NqjTx3/rPQPPF5iKsODeWFLIe9C
	Zcb1gxEZqntkFG6M7DpcF/nrttz2sNEa+zp9UK7Ew71CKLBfZo/oMaZTqmJgXKfN
	exlIwdo+Ail3hvz0aX5eUhNJJhEEi65u1FA==
X-ME-Sender: <xms:UtKmaEgy9WLEWQqskew5p7AHi3DzFpUBvf-xPcmN0pnRv8sGW84TMQ>
    <xme:UtKmaC8647SDdgSRHlIyM6cu5qO99Jjm_k7eic5RDntegp8-rHCQb0K5_0c-b4mUl
    lymgrGIS01Gm-FyGw>
X-ME-Received: <xmr:UtKmaJOfx_Wl65LNHdVIh-E1fvVzheLatDiC_Luy9U3PezBbt-ttCG9FtqWYQozZsVC_Vm0Jtyfe0QrzuzcWhk-JyUATGuKPNeAPRkb3jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhh
    rghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UtKmaGAOyy1LPmJzYsx9cJ6kTqQO50oNnSK8NeWmIdjM-YsZgtILRw>
    <xmx:UtKmaNOqiXwaZ8uCyG0YcBh9OiLUuP8rO5aHBLhNUKb-9XC10KX2pA>
    <xmx:UtKmaNcwiaTbtjvuO68VGyQATMmAmGfm74xYz330zKg7mKZ609-k4Q>
    <xmx:UtKmaO7oRGbEs6xqH0Q0jtm4IVuZCxStV850AG1lVLOdWupvWN4_3Q>
    <xmx:U9KmaK0xoRyFfuo2JvKYJajXSiLOK_z9y_GlILdpk8dYmyut7tkNMtF3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 04:01:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d5cd548 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 08:01:20 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:01:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
	peff@peff.net
Subject: Re: [PATCH 2/3] path-walk: fix setup of pending objects
Message-ID: <aKbSTN-rfGzadPsm@pks.im>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
 <xmqqh5y1ak9o.fsf@gitster.g>
 <c6ab0985-2a74-406b-9685-cc65f8748515@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ab0985-2a74-406b-9685-cc65f8748515@gmail.com>

On Wed, Aug 20, 2025 at 03:42:11PM -0400, Derrick Stolee wrote:
> On 8/20/2025 3:02 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > 
> >> The core problem here is that the "maybe_interesting" member of 'struct
> >> type_and_oid_list' is not initialized to '1'. This member was added in
> >> 6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
> >> 2024-12-20) in a way to help when creating packfiles for a small commit
> >> range using the sparse path algorithm (enabled by pack.useSparse=true).
> > 
> > OK, in other words, the bug is fairly contained within the path-walk
> > traversal.  We treat things as reachable not just from ref tips and
> > reflogs (where path-walk code can use the tree object to compute on
> > what pathname each blob comes from) and the main index array (that
> > has paths, even though it needs separate way to compute than those
> > for trees), but also from places like REUC and TREE extensions that
> > make associations between pathnames and objects.  Are they also OK?
> 
> The key integration point is the "pending" list operating a bit
> different from walking directly from tags or commits. I was trying
> to reproduce the issue from all of those other sources before unlocking
> the "singleton" nature of the problem, and failed to do so.
> 
> The resolve-undo cache (REUC) is something that I had not tested
> previously. Adding "git rm --cached x/y" to the test in the previous
> case leads to the 'git fsck' call giving a "dangling blob" warning,
> so that could be an interesting way to strengthen the test. Thanks,

I also wonder a bit about the future -- if we ever add a new source for
pending objects, would the author have to amend "path-walk.c" to take
this new pending source into account?

I guess the answer is "yes", which does make me feel a bit uneasy as
it is very easy to now corrupt the repository.

Patrick
