Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A938239F
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806967; cv=none; b=LSgqa7TrUGFDvgn1214tbMKjIOgwSXPLfm3TjLQtOFNWeKMIiXsRMg6h71KBboNswrK/k6DPp8nO69U3GsADCr4ixUynD7L2CKpb02QAAvI4fNAOW4RDx9nYNVAJcikuWahR6E/4b00uI4U2GFRuI3F+TKjHpIdB+1AR/YwAFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806967; c=relaxed/simple;
	bh=7Qm8KJQ4l6S+4F79tXRArvBj9wcdro5/m0nqWhm1380=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MlYU4OPQXXJjsO24OLwJSV2uwj7z/gbO9gqmOGNAT0jr/73zpLy5pEH2uNQ3n9q5EXHpQMd0ofvC+PurPH0z2QucyzQu1awl6872SlTBVLDsTYxEI/s2ESiXoZdYEQaCP65AlPgAGyvDV1AJ1kzETgx6GbhhB5AawK1uwe0O1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CWM4aeMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=At679MWg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CWM4aeMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="At679MWg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F0531D001C3;
	Thu, 21 Aug 2025 16:09:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 16:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755806963; x=1755893363; bh=C85GQE/C0J
	eP1NtTn06ZlT/Qk7QoO3Iir2Ajye9ze20=; b=CWM4aeMfo7ocxqZRkxC3M4qsfq
	1GH9yFlh90x4lCykkVqAk2+8wgYO6/mwvSkbzIjzLfIWSsU95o/lTjn4i4N+1z0Y
	OaX8d/rfuIw4oQlhwl7Qo4wNVWaHf5LWraDCIdMCKNwUDXw8RcuBode/WIZzPbjK
	WHWm9E3kh8M1qeyTJ9YvVuZkKdQc8bFPcUjIh9oq4ouCD+TRUtnHq/g4BOCDlgey
	JYPejY5FF1gc68L7rhP/73pz4Bsb1Y2kTTzNfG0PzpQRsOHRpv3J+pvP/OqLuLdI
	qEnwA+a1pBucIb+ufxHXHZBNAUDSBBGwhLdLIGvjz/pSd08fNWcXIgpJq/Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755806963; x=1755893363; bh=C85GQE/C0JeP1NtTn06ZlT/Qk7QoO3Iir2A
	jye9ze20=; b=At679MWgvNyzkE7J0vK7aLgX46ervn5NFRPC6ENVpifVvJfQliQ
	hoogIxzh9CM1pe6lLUDaU/bE30Bk3oxNaRqEQyWNiaOo7jHiUxL5amcjTQbWzNwY
	rfYQNtuuGQuPxboUzSdspGxfE6T6yb9APO7U4wRsTJjaIxLnxeFZKflMn+f3JjEr
	MvcX3HABySPwT+3PbfbH0aHOiCMTCx3SzoWfLMkmuYjb0bmhz61R3FJWZCIOQmHt
	xu1Z/3AN5cAW+ul7Pa3X8G7Hu5/o8oF1rIROIq9fSPxcWrN0U12LptGMcKzSlLzl
	bJUHFlI7RjxF7CmE0jHCtft5wrJjclgrFVQ==
X-ME-Sender: <xms:83ynaLdRFVHe8Mp9FrzkWw4CfM5Prz_PHY3hfQGly890rqX1ttyodA>
    <xme:83ynaOwQdp-dXrmc_g6VwIPl49TFq786E32RuKGj1weicYhokunx0VWpay1nbVJMk
    SD5CJJ8epB78QE-tQ>
X-ME-Received: <xmr:83ynaK-quMjjln_Ip16wHi3cQGVvCad1fVjl4-gfEzeeUTbKEFkxtnMXBat0okgLZpmxpaobvGOUpI_dqBVvFHG84GWbULn9sRA1bO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:83ynaOi6AsMiHqf908xGDyWDPLPfkbUYwOBp9XK0J7XKjRbZNtlB_Q>
    <xmx:83ynaJFkQ0wHK7DbgC4PjrJIkHXYyO7590e_XOfwZSxvBOXNQsNqdg>
    <xmx:83ynaF9zkuyZYZ3zVMn3In-s8F7tEPisxh_O5H9sfIq7PbGpCNbVCQ>
    <xmx:83ynaIx0_5nWuBxY3txrVmoKIH6rpCitMfnWSZBmsJLQQjK8xGYrvw>
    <xmx:83ynaP3jQgHxX71GCHwlYbq8tiTUlozhOioYuVwfwpEcejC-IJ1FudP4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 16:09:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 3/3] doc: git-add: simplify discussion of ignored files
In-Reply-To: <fc2ec305a9eb267b7705c34c1b3bcdfa26207af8.1755636370.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 19 Aug 2025 20:46:10
	+0000")
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
	<fc2ec305a9eb267b7705c34c1b3bcdfa26207af8.1755636370.git.gitgitgadget@gmail.com>
Date: Thu, 21 Aug 2025 13:09:21 -0700
Message-ID: <xmqqqzx4zbbi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -The `git add` command will not add ignored files by default.  If any
> -ignored files were explicitly specified on the command line, `git add`
> -will fail with a list of ignored files.  Ignored files reached by
> -directory recursion or filename globbing performed by Git (quote your
> -globs before the shell) will be silently ignored.  The `git add` command can
> -be used to add ignored files with the `-f` (force) option.
> +The `git add` command will not add ignored files by default. You can
> +use the `--force` option to add ignored files. If you specify the exact
> +filename of an ignored file, `git add` will fail with a list of ignored
> +files. Otherwise it will silently ignore the file.

Nice.  Much simplified, yet still teaches the same thing.

Thanks.
