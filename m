Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907120E314
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037068; cv=none; b=I7HPK9N2THvYbcy0ZKd/v5Sz3k1RVOSThsnuvUngWRoCCCqNPt7vGD/dS6FPmSZK+j5wS9QJjgq1JQJUSpPa31GrUqI68eKpVkyXraDsKnhAhpsBDH1zgChAWtuz5CiK74LltXEZlL6J7IiRdNL+SEDib1IOEnT50u48nZjR8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037068; c=relaxed/simple;
	bh=lyqRlJvB9HnOByLWhiaM4+cyYyXvRzahFs9FfaLe/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noYl6JxTvWVs063Ku1B5g+Z1tbRtLhkkxVP29y8NwMXGyRS3TjnB6oIcgsiKsNYA19rey8cR4PFrbWNURpJ+HavUj0LoYCphaV2WuunyABPUlesdoUANBeqxAgwnV3tuNaioi8T4Z11v43HRkpknQoByZ8jSusQtSkS7c7PnWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KEVFGqZp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZAB/JYJI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KEVFGqZp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAB/JYJI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65DF91400253;
	Fri,  1 Aug 2025 04:31:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 01 Aug 2025 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754037063; x=1754123463; bh=mLcCPU+5C2
	Cbh+8ImakHAJtFDso+sJk2E/ttMzrX/3A=; b=KEVFGqZpTNqr6Kb3iXg8+EMMFp
	kFXiJgGNNsFxP1AWAGWxpjjQtxx+z3BJkIT9fYT2HjQCyINVUlvuhj9sRSRJmjMb
	0aXzgOQBGLF2ClnUdtglUJrNKxTuDoDjMIpHnOgmZ7+CIf8X96wlPR1/cALA1DEO
	WG9bVtf4TsoECUkRS1BRNgbo9s1WBlotOE58JhJH0+RbJpec12+3BDGEk/BGUnoW
	HU2s6dU6ILeBsDaKwWUhvt4iM4mLnfWNapuHHbQ4HA+FKiQkY25wON2TfhNOR4qb
	MMXtzNgFjv+i0FI8EEBuIR5PjQVLwfys+PNEf90+//q4eS20yL7nidE1E8XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754037063; x=1754123463; bh=mLcCPU+5C2Cbh+8ImakHAJtFDso+sJk2E/t
	tMzrX/3A=; b=ZAB/JYJI675BR6tyPNaiFNZigLiefSeWxc8Hz4WzQkrszTloTrQ
	OvMCV2HjAIiP6ry6UvGDNuK3BUKSEFaDdui/f/aHEQ8FL/bccIh+yksKbcasJL/5
	Zw+/hcEBv/XUP5GRkU4XhE9I0Yq0WaQPP0HNew4TTuGkfW4o0epp5XqIhPCd+x7L
	Fmdkm8tzKuS7MuZmG1MckBt7eEFBvsp2Ddg+OkFrXcezEX2FMj0EdxD73NjgRkqM
	vem7k9IJ37b93AdYsEExsPuXd/z8gnW/0Tjbe8MjxbrQYNqU2vNqhQ6SVdEFNYrG
	+2/3VkWRehUNVs2TGjQLL2iu6ubAPueGniA==
X-ME-Sender: <xms:R3uMaEF0KxGBm0BDMbDpFHq7qzV09fOkBagcjHc2GKcBpPP4OTEY8Q>
    <xme:R3uMaAnuXBiTyVVOrkP-y0jSvx1rYhCaIB8TTSOMmEJPuVgemJcq_OVXp4WcO8miP
    kRwlquAMALco2U6IA>
X-ME-Received: <xmr:R3uMaHnzgwTCBJlr2iHfEOhJxMlfEnJ20ZqG3AGeu4kTQgXhOrlZ8MXa5SutmEai4FeGbqD-U6K1FIog_k9hvFEdaASZa_hAsFqeePWqzwii>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:R3uMaBvc2kSAWGCemp5COrKFfqwghwEJ5ccA3Vyny9_uJqaUuOjhfw>
    <xmx:R3uMaKl6ZVAHDlkhpzNxtVzdpNGGk376U2ZEKSWxhgUlM_pE5fakBQ>
    <xmx:R3uMaMsZCHfoIN1VTu1jxgjtKmJqLr8Nrv5kHGlpz9VWcVO_v3kQHw>
    <xmx:R3uMaAce8ikaMdXR7iTqOQfVVcz2EriWw24QiR7wXKzpz_qLfH1R7Q>
    <xmx:R3uMaMgglrVLaxxYi7XcN3nngeC55tHAUgk4gWWTwq41WwEwlvx8SfwG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:31:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27ca8801 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:31:02 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:30:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/6] t6423: fix missed staging of file in testcases
 12i,12j,12k
Message-ID: <aIx7Qp_epPOpk8OF@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <3b3b258cec5f0080beb64501f7510f7acbc3a91b.1753197791.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b3b258cec5f0080beb64501f7510f7acbc3a91b.1753197791.git.gitgitgadget@gmail.com>

On Tue, Jul 22, 2025 at 03:23:09PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Commit 806f83287f8d (t6423: test directory renames causing
> rename-to-self, 2021-06-30) introduced testcase 12i-12k but omitted
> staging one of the files and copy-pasted that mistake to the other
> tests.  This means the merge runs with an unstaged change, even though
> that isn't related to what is being tested and makes the test look more
> complicated than it is.
> 
> The cover letter for the series associated with the above commit noted

It might be a good idea to provide the message ID of that cover letter.

> that these testcases triggered two bugs in merge-recursive but only one
> in merge-ort; in merge-recursive these testcases also triggered a
> silent deletion of the file in question when it shouldn't be deleted.
> What I didn't realize at the time was that the deletion bug in merge-ort
> was merely being sidestepped by the "relevant renames" optimization but
> can actually be triggered.  A subsequent commit will deal with that
> additional bug, but it was complicated by the mistaken forgotten
> staging, so this commit first fixes that issue.

Okay.

> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> index 69de7a3b84af..c2032eb6cfa1 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -5114,7 +5117,7 @@ test_expect_failure '12n: Directory rename transitively makes rename back to sel
>  		grep "CONFLICT (file location).*should perhaps be moved" out &&
>  
>  		# Should have 1 entry for hello, and 1 for world
> -		test_stdout_line_count = 2 git ls-files -s &&
> +		test_stdout_line_count = 3 git ls-files -s &&
>  		test_stdout_line_count = 1 git ls-files -s hello &&
>  		test_stdout_line_count = 2 git ls-files -s world
>  	)

Should we also explicitly check `git ls-files -s baz`?

Patrick
