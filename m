Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A003188724
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523204; cv=none; b=lIAl1WwqksE+33BD35p6Al9z4yo5mi+6i7YswU0JnSXR95pmnaPVfN9BKpJaQDZvnYRxm5PK0iI+6C7vd1/0VgMWUxK19H8vW5YxLGM4Gbhlvu2N6sEVrH4IC+P8Wb2Dye75Upz9B0WahOjJh+W/tIyoPjE2zNz74bo2XTW46fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523204; c=relaxed/simple;
	bh=OTYT4rJDpWI/M6wac1G+KsZiHoBvyumgOKn77GukJ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAs1Apb+tVraD54EwcCp5+AVztQxrkqIJ6DCskddcbZE1NJGrrl3eI0/0v7NxNyW/8DpZtETp1ZttKEbf9CoVLW/9Xt8StemNPP3L88MqA329z12hSfK2m3CmIyJHGVd9JNwuwNdzasQFxHM5aUJQKj0rymhgsyyL9ruzW2tZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bQglg7PE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEjdaGCY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bQglg7PE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEjdaGCY"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 594B61140166;
	Mon, 25 Nov 2024 03:26:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 03:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732523201; x=1732609601; bh=/JevjFmW8J
	nJej2L3W23GMhqi769lTBgrGlwZcV3BE8=; b=bQglg7PETW+1tTQwpyr3uWjq2F
	HBLkzjb42bqoX4L/6GXoI/5SwrUr/7cLk3jKIjcP+lQ3Xn4vDecA11aKA0wy3Q5n
	NxmKvHmDho70z4UddNrBlnMuGRA2y+vAGXKAZ1k7Qzb9qvxZJamWmhzrSqDoDxjn
	ToV2M2gjdf1oOrK1NmIditJUIuDxbSoW3szxvLnzQXPzeCz5halsKOO1ZuRN0thc
	8sDEFtlVGYz3zu0pIuoJcYAQ9uHv4obYRuTFQWoModkY1oM6YXNdVZn8Y0dSzbxw
	+A+9b1Djnl74KFeqLuARRO61ciCCzPTcYVKORb418GHdfcPyY0eYVcJ0hZNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732523201; x=1732609601; bh=/JevjFmW8JnJej2L3W23GMhqi769lTBgrGl
	wZcV3BE8=; b=YEjdaGCYDAK7Y69T4Fh5cdV5MwDWt/t/LKHXLOGPjqYnzuEC4MG
	6gOS7OrHMwqPKOBhBEvDJye82DVm5nGzjVnkOS9UQoeyPsbUU/FA5i2drRF7JU4Y
	vJZhoR8I33Q7UQnX63v/5wQjc29bBlHq/j2t2+AJy4RBwvExLIxskepS/n83x5hu
	0n06xfH1GrF5vQIi8INeF9R2IzH9lG+UJYDs7HN1EbrZSwF4B98djgcJ/7Ln9q9z
	wgapdI/MI7qhYhggYhR/7B5FkWqWYFTjQ70rtLgqahF+Lz30YJ6jUPVLrfejagMn
	yNY1HCKHfpKgw2hSUPDUCrchlZs7O057uRw==
X-ME-Sender: <xms:wDREZyxcTMmXrdXqZKXPXTieDcjUibg9nDHo3m6asp3jgOmrR__9Tw>
    <xme:wDREZ-Ti2LiZCXcONN59faQxm-U5TUaIyglZTDx7XI4505SCwzP0Jkkprpu3tuSt5
    uWnM1XoRsyLr0WvGA>
X-ME-Received: <xmr:wDREZ0XLwWnyfWtUjsPs_tCYUYpvCW2VRlMhSJCa-LnQEcLjGg_seyi-IWQTe-jcvbvOJ9ZlroSu4EWcrvUf64j9cgubEjUQaSXjC6N6JMNC6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhgrrhhrhiesvghluggvrhdqghhoughsrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeif
    ohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopeiihhhihi
    houhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:wDREZ4j2oqJl7618tZQQeVSKUaEiOymcPlL8sjMStLJTFiiJidPXOg>
    <xmx:wDREZ0DshBriU-Q_OBmo9qIV-vH8cHm3MgsZPk11R9bWx-LhFHhfsA>
    <xmx:wDREZ5KzwII_ZOR4B_KbCFn4A2nZvZ2ka_hIWqmIOLv-EXNi9w0rxw>
    <xmx:wDREZ7Ayl2bJbSH375RbRfJAzp-6C3-cvHqiXUhRLnPZ9rVt-JlRvA>
    <xmx:wTREZ39nWhqK17G-h4FdUZqMfXi2oiIDQ7-e02eDF6PDeCs-hJR99UsR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 03:26:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b725dd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 08:25:36 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:26:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v2 1/6] t5548: new test cases for push --porcelain and
 --dry-run
Message-ID: <Z0Q0sSsUXg47gn6Y@pks.im>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
 <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <7cedfd718c4f2d6fed7420a3341e82c9287d2085.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cedfd718c4f2d6fed7420a3341e82c9287d2085.1731603991.git.zhiyou.jx@alibaba-inc.com>

On Fri, Nov 15, 2024 at 01:15:32AM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> Refactor t5548 and add new test cases for git-push with both --porcelain
> and --dry-run flags in order to cover the issues reported by Patrick.
> 
> When executing git-push(1) with the "--porcelain" flag, then we will
> print updated references in a machine-readable format that looks like
> this:
> 
> To destination
> =   refs/heads/noop:refs/heads/noop [up to date]
> !   refs/heads/rejected:refs/heads/rejected [rejected] (atomic push failed)
> !   refs/heads/noff:refs/heads/(off (non-fast-forward)
> Done
> 
> The final "Done" stanza was introduced via 77555854be (git-push: make
> git push --porcelain print "Done", 2010-02-26), where it was printed
> "unless any errors have occurred". For the purpose of the "Done" line,
> knowing a ref will be rejected in a --dry-run does not count as an
> error. Actual rejections in non --dry-run pushes do count as errors.
> 
> The new test cases will be used in the next commit to protect the above
> behaviors of porcelain output of git push.

It's a bit hard to make sense of this commit: does it introduce new
tests? Does it refactor existing tests? Does it change the test setup?
It seems to be a mixture of all of these, which makes it hard to see
what the actual change is.

I'd propose to split up this commit into multiple ones: one that
introduces `restore_upstream()`, one that adapts the test data, and one
that introduces new tests.

Patrick
