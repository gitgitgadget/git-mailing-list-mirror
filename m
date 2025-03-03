Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E61C9EB1
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031017; cv=none; b=ZSuGcyOwY8yaMc1xFh/ztJgrhzNVdXW5G6Kny5S6/HRcMkRaxwzU4v/4AvUYhTolB/SiTHakHdfCKxT58nYlsz+qkNO8gHj6TpT9iiUV/fEVc2ft1bUuvHOVa+pX/b/W3CkefBkydq8Na4La8uHdvBWVYYsDSwGswZSPKTAMpwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031017; c=relaxed/simple;
	bh=+GvfY8ZFY1sJ9FE6SyhVDbb7QDwHpqrolACmd6j9rk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwb6t6s44cBe3qr9CFrGsrhQs1VuIy1HauKawR9wHodSdO8i6gT1YBZSvH/hu7VnskGsz76O1kqwl3rNuK17FlqnzLk1BitqzuFILPT8ceHrDnocLosGrGutrQEjbPZD2XMpAflJOQlmAvZkdshhe3x5KVwybw0pkJVkPhl5tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YUs3CPhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v4Xg5Nv5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YUs3CPhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v4Xg5Nv5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF69F11400FE;
	Mon,  3 Mar 2025 14:43:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 14:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741031013; x=1741117413; bh=ICYd3u+zjI
	AtS+fZHre76zy6RmGB5RZ0SFqLH4UFG44=; b=YUs3CPhU4hjATn4HzniLjV9rkP
	tdQfhbZ7DI/n90k87u6p6cDuNk+xJRiljGx+k6xgUawMUFW9gb0Zx4IdvbP+Ojst
	Ge0Mk7m7Ua54CminQzFjfDdaHOK3k6grxU2nHgFHuswf8eEn7Nk5qQhhNzJka1X2
	gCUdAUhIeqouoe4oQgD/FrZgzQHFCLHzwsT0VALQEtMaJH4AdTQYQOekUP2HX590
	s5JuDqd1Vv3Z13yUsxS5WO+JlE1hWJJy6/fERZPq6N76BsWMfRxUf3toq1/xbRue
	Ebau+UXAfOBRY8AOtgNbcs+fH528AXmn8+5IA1D62M/NLOIQ7Pyz2kBvEc/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741031013; x=1741117413; bh=ICYd3u+zjIAtS+fZHre76zy6RmGB5RZ0SFq
	LH4UFG44=; b=v4Xg5Nv5ZkRGH6nrkQkSQni29Wu0imYEmKHlHGTU4idDCe6qVJR
	/3TqStvDHIHjgq6DAMyLXzKd9IqJBW1GNsXt9bFQ7FJNrx9voLo9rZfxN6Ez83jD
	5s/lL8OQp556auXhOCyPSs1Er/jLbx7ZS1TdO+DQ5c8nbjh1Jewau5HZEfjf6Cn4
	oo9IxAtnZz3TgJMV4UBIxqtNONLabJvdR/VNT9wCTIY/X1bk1Ij8ysGZwXWUDmCj
	nmGV9Yl87iVonPQ2gGXOxsyN/Q+RTxfdpQjkUQC2k9PnYgEjkI2ol01IpkH9QQUb
	/gt6L0llS3TJoLHbm2Hy1x507XJvar8S7fg==
X-ME-Sender: <xms:ZQbGZ0D6j2rP6L_Oqf4EF_gD6zvxCyfXC5mU30k2PLcI3eJMv3zwog>
    <xme:ZQbGZ2gpGTULNf2jG-6FxZ7wj21q0cttW6z16_YhkUtp1H8JN7JIiUqaiuj9SkFw6
    ZTo0SVIegwaMV9j4g>
X-ME-Received: <xmr:ZQbGZ3lpKoqrYAAKuCs2xBNHxXfJV1jK5lFtymkaA4ROYk9sMcIwe4_vO2LkZpCtyy-sWQkjG3JynpZcGkjvIMFL8hfEDMBC8NO2517bWaleHJ957Bi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgveefveeihfehhefhgeethfdvffehfeehueelheei
    ffeuvddvuefhveffiefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehmrghnuggvlhgsvghrgh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgr
    tghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:ZQbGZ6wKQV3Ih7mtDMOOnQcJvZxTQgQ_PQ3K9S1ToamDaWgsS_qGJA>
    <xmx:ZQbGZ5TXG18-3eBY9EbO5gU8N4IJtwCjySCdPaCQGwrt1spDy0YtJg>
    <xmx:ZQbGZ1Ze4Be6sh0IX5fD-FMX0B0A_1JACMEcHNEyMwOu06Oz-bEGPg>
    <xmx:ZQbGZyQAL72zSaXwgP64tEPo4SPzADFuCkVWUrwnADIOEE8LD-VtQw>
    <xmx:ZQbGZ4Fv8D4zrP2UXnVEj0u_yrzWx4wwz1VXNekJ1WV9JEGMPrvFhkwe>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 14:43:33 -0500 (EST)
Date: Mon, 3 Mar 2025 14:43:31 -0500
From: Todd Zullinger <tmz@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: phillip.wood@dunelm.org.uk,
	David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
Message-ID: <Z8YGY1QMaIsQTXoS@teonanacatl.net>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
 <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>

David Mandelberg wrote:
> I think that would work. I was hoping to avoid sed, and I was thinking about
> using shell's ${parameter#word} to strip and test for matching prefixes. But
> I can't think of a way to do that with GIT_COMPLETION_IGNORE_CASE. Modern
> bash has ${parameter@L} to lowercase a string, but I don't think the version
> of bash on macos has that. With sed it would just be a matter of adding the
> i flag if needed.

I haven't followed this discussion closely, but you can
also use ${parameter,,} to do parameter case modification.

Sadly, it looks like those were added in bash-4.0, so Apple
will have kept their users from benefiting from that to
avoid GPLv3 code. :/

I don't have an ancient bash-3.x like MacOS to test, but
maybe they've backported some features?

Though if you do end up using this, ${parameter,,} will work
in a much wider range of bash version that ${parameter@L}
which covers various releases in the OS's we aim to target
(e.g. RHEL 8.x, which has bash-4.4).

-- 
Todd
