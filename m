Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E221494CC
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760097100; cv=none; b=P/gB8kSWGd88IjpfEF/HB86k5QfEcJ8Le9iHj5Up1CJKPKJZ0zZEaq7Vo+mM+EZZJLavxo3oAvhemwiQGGtYKmFCxkYoi2nVELKym9bsomOkvbqhsFd9ooUrs6LPBT4v8M5gO6ja6NMW2+QvPL6g3Kgk7baOjj3dyZDe99WA3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760097100; c=relaxed/simple;
	bh=BUzt5zNNDzpHdkB0M+TCVnj+NjKCO3aRl7cVre0k53Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY3/Kq1oc+tPHd3UcPOa7i6MoNolBDA21D65uK805uDFjiuOANLca7Lk04+3zGnqphP0wkMmWGvnkH49wN6tNENqB+I+xV7JHL+E4vfxzN42sS2NfgwszEvtPDhXyR8Vn1Kcmr6qJGxEOzYaTx1eEPliykqW4ig6u7GoSIa/qio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A04McHuS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkVdR4WC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A04McHuS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkVdR4WC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0AE514001B0;
	Fri, 10 Oct 2025 07:51:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Oct 2025 07:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760097097; x=1760183497; bh=XDLYIF7WyL
	ACJrMeAqXDwXsgHBGqViW0ndCOZCZRizc=; b=A04McHuS5V+AklX/456LOUdA2Q
	1BQLuPjrAL9+K16P3CDs+J5qNxKUvPG+UWf8TOWAYDQayPr/EJ/9EByffbl3VytS
	0mocFKZLGSu2mlpMmqdWnADyZ2tlAI9Pob+em8nzYiOtXvH5GhWijMVY601YzCd3
	LvNv9lYwgRWMj2n31wSAygaZJ2LTLdkO2UeTcjVV4AcCpzwXrbfbCg52g26IdoFq
	tL2+wC6Ug5708wFfyqhGJeoRrzpzZz48rhH6rkLMtEkPTEnKebC/zq/Go4yJjRoK
	SV7vOu0ZkN6ZP5IOuC0Ggmz94+R8pZNGggJMhFQAwipBgxIcitA5AjQBWNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760097097; x=1760183497; bh=XDLYIF7WyLACJrMeAqXDwXsgHBGqViW0ndC
	OZCZRizc=; b=SkVdR4WCx3wGt6OXjLD+sLLVB3DBiTdrkVNM9rZhpfRyBtduIU1
	izxpHe8fEwbuIufMncbCQVUBWZ6u6F1jgzL96rei1hTBBvLB3fgRPsGMoX5JfGCH
	3s9Ec9A8rwxNrhcf5g3aSCI81igS7f1cvKyxbLEBQeh9gOZQPdJKkoqnOK8h7dCx
	bLQD04UUMTjVpqS/MO2hXgdJ+2m0OyKPBUypEr1pq2EMRVRrs22hG7JfMs477ppw
	VXGrhFcY5fHJudKPyaaOU+DOuL44ldUhVePus1Kas50HKPILGjAVSiiNK+H/Vuum
	LLmGC1y6MzKNKnKYKIlphE0TXf78cm1NkHw==
X-ME-Sender: <xms:SfPoaCDcjVCYynbqdQFk2rJdC3LTW4mbKeJb3e-yx0CZpYrGRoZqDg>
    <xme:SfPoaDZg2IjtqBOcHCnV9da9O231_Xn0mMjxzmUboMG40BTjM3Nmh9VLw59W2kj-d
    1bUYo-SpgLjFNmN4SbkGR3VOWks4pHbQKUFHzvOi6rtiGdJIxxfDQ>
X-ME-Received: <xmr:SfPoaN4NbNP661LwU0lY67dT-9wjVhMOys27I_uVsfTHYGPQOFwhu-om5bgOp4IL5rr8CMjPsh7tFsOAEIRX-0cGJunAnPvqTjpZy-OOxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SfPoaMaFwOugtoljgupmDtFhYatPqq1uOu2NQ0KmEgyd965ReBlVOg>
    <xmx:SfPoaEiWxpR_4vjCu5MvcG1ZHvC0vH2cvzSH-scmBH6XxbbsGmcqHg>
    <xmx:SfPoaF8G78G7F75WUgUk3g_qM1vliWlnT4mQzOItL0ZzIR0wLJuHUQ>
    <xmx:SfPoaHpYTOpcnrObnr5oPMzSDDpT-mBo40nD5fpJ-yvRobXW1bBTWA>
    <xmx:SfPoaHqbD70m79i0yQ5PIeFygn3buQbGplFXIYBBGB79d_q4hUn3BqUV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:51:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1369910 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:51:34 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:51:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: add a explanation of Git's data model
Message-ID: <aOjzQ7-88m5e_YJl@pks.im>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>

On Wed, Oct 08, 2025 at 01:53:41PM +0000, Julia Evans via GitGitGadget wrote:
[snip]
> +[[blob]]
> +blobs::
> +    A blob is how Git represents a file. A blob object contains the
> +    file's contents.
> ++
> +
> +NOTE: Storing a new blob for every new version of a file can use a
> +lot of disk space. To handle this, Git periodically runs repository
> +maintenance with linkgit:git-gc[1]. Part of this maintenance is

By the way, this isn't true nowadays: Git does not use `git gc --auto`
anymore, but instead `git maintenance run --auto`. So we really should
be linking to "linkgit:git-maintenance[1]".

This tool _by default_ executes git-gc(1). But it can be configured to
use alternative strategies, and when using scalar(1) we actually use a
different strategy.

[snip]
> +[[references]]
> +REFERENCES
> +----------
> +
> +References are a way to give a name to a commit.
> +It's easier to remember "the changes I'm working on are on the `turtle`
> +branch" than "the changes are in commit bb69721404348e".
> +Git often uses "ref" as shorthand for "reference".
> +
> +References can either be:
> +
> +1. References to an object ID, usually a <<commit,commit>> ID
> +2. References to another reference. This is called a "symbolic reference".
> +
> +References are stored in a hierarchy, and Git handles references
> +differently based on where they are in the hierarchy.
> +Most references are under `refs/`. Here are the main types:

Not quite true. Pseudo refs are outside the hierarchy and are in fact
treated differently. But root refs are treated the same as any other
reference.

    References are stored in a hierarchy. While most references are
    stored in the "refs/" hierarchy, some references with special
    meaning like for example "HEAD" are stored directly in the root of
    the hierarchy.

I don't really think we should get into root refs vs pseudo refs here,
so maybe this is sufficient?

[snip]
> +[[other-refs]]
> +Other references::
> +    Git tools may create references anywhere under `refs/`.
> +    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
> +    and linkgit:git-notes[1] all create their own references
> +    in `refs/stash`, `refs/bisect`, etc.
> +    Third-party Git tools may also create their own references.
> ++
> +Git may also create references other than `HEAD` at the base of the
> +hierarchy, like `ORIG_HEAD`.

Maybe append: "These references are called root refs (see
linkgit:gitglossary[7])."

Patrick
