Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684C33E7
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029076; cv=none; b=HVYkcodCiiL6N8EQ3XPnBAag2M5Ak/swVKruibqZ7NnxnMraS4V4/1x48A88pXSNbNoQ9xsUg5snsHmCqXuSW1AQQtlLOGv/r1ugYtiiKdgoLHglgdNTt4Xl3s2HMvo9cnt3xyLWG9fVaIrN9YEsM6r/XScI4VSbn2q2rYUhgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029076; c=relaxed/simple;
	bh=m+pZCYFWGM6DdH4GBZqytZHgd9oYmU8gS+vrCAVcYro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u83sG22UVS4IXQoU7039XGM8ErZFovwh5LNkgDHkeszJszW1/Hy8A/x/L+Fk3ck/5aa4cS1bWx8g09kWjnyA4mgCv2vdK2SojbA0xEE9WpZkVYdHO5OWL9do5fieGhbxQb8e9GrJoAPLy92JvUVYeiYxuHCI2v95BscZDV893gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Di6Y/Fkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WvO3g9TJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Di6Y/Fkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvO3g9TJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E97311400BD;
	Thu,  7 Nov 2024 20:24:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 07 Nov 2024 20:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731029073; x=1731115473; bh=S7fPUg84Wx
	WLSzPJ8UwOhYtv9T8CYMOR/jJyImtfyuU=; b=Di6Y/Fkd+LxhRAPjPSaxWV9weU
	R86rTJQw40oLmbS7q2lsgUCYq6CHxhc0s3MVXmvwBT67xebQOpVmkNyptqkDPrQG
	X3EP3H/agOf8y4Bpd4al0Kzd5luKMK6BQnc8ukk1+BMLrtDOQGx7GcSvXCR1D5nV
	GitbvQODQYQh308btP/8+z2gbJOCyg7i1VU6OjW/XTXUX5KcvcPV82lXLUiP+E5k
	R35x3R47LSEMxqfR3CjA7SqXa3XDWCP2PCnMGllLUZZFp40gbF1mcf93x6f4gpZc
	D5y32GwT1bgsAig47FCT2aKUaQ+EyCj3ocq+meryS65Sxbiz1eYIg5OfNDPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731029073; x=1731115473; bh=S7fPUg84WxWLSzPJ8UwOhYtv9T8CYMOR/jJ
	yImtfyuU=; b=WvO3g9TJJlGNwFHLGzosgFiUXHTvlqBAPtrepcyeFRiwrwfxzzE
	Vgxxeem0fCwt4CtSPC/DiIXggOPPX1oSxBQGzqjIcBoOEY4d1DV7kbmAO+RaElsB
	ADVNSkRRd4Sm5bFHx+sJdyIcdPS42QdfSfZKsXfZr06Gy9G033RNIa2HIf5qgOHI
	qRsEOU7YpU0uhHwcp4M0kYR+UHkfpQv+xBJEBVrSUOytXnVlYoWYsJYgA7IAueqF
	gqfv7vGjPqWZ2njuP2MSEoD1Qel5jWZwLxjdas/UWGBjDl7KeyPTjjqKI6Poh9WZ
	EQVXSSRKnOBlsPuqcVA7rLOCx0JU9tLSqYA==
X-ME-Sender: <xms:UGgtZz7XRCbcuHuKJCYgaPIZo4R0UvpAD40ltKgJamTl_iH-IuK-vQ>
    <xme:UGgtZ451z527bP0a9T4wA2OvWVe2ILOhr5bGL9wLSKlCIqWhephPgMFKW5HFcHY2o
    1YQgw4ae3cl_Mk7TA>
X-ME-Received: <xmr:UGgtZ6f5Og9oztYRnCqMZ5Bdr4GpA3dIUx2vMsrpjE7j63-4DkU2PyUX6qkOvNOCE9mhjyZ5tXTqU9qffwZ820Bzi6nDz_AQYMpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UGgtZ0LCP7VKrvOoTcngJUAGRoY4slyk0rkyegdoXdayFst7Px-ViA>
    <xmx:UGgtZ3LGyAH2b6RWnu4fmXanUSWazQrHRDZd7ka_nyrN0t1Z6Addaw>
    <xmx:UGgtZ9yGxXLM7gLtcA8KJ7TLu63hy6fWEglEA4ACpZb-ANt5ujoITQ>
    <xmx:UGgtZzKlseJ5KCQ0oh-76x6mpBBEUf2vg3RTBMmy_tVK9zWbgu5w6w>
    <xmx:UWgtZ9g_EWeZ0h6MOX8W_U3tnS8oGbXkIIUm1Ham7x5m0j6SO7Q_OLbc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 20:24:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] git: remove is_bare_repository_cfg global variable
In-Reply-To: <ZyzlBZnL-K3S7Env@ArchLinux> (shejialuo@gmail.com's message of
	"Fri, 8 Nov 2024 00:04:21 +0800")
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
	<3d341a9ae4ef1d2776734fa82a45913f91e6083c.1730926082.git.gitgitgadget@gmail.com>
	<xmqqv7wzsijc.fsf@gitster.g> <ZyzlBZnL-K3S7Env@ArchLinux>
Date: Fri, 08 Nov 2024 10:24:31 +0900
Message-ID: <xmqqjzdeqzzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> I also want to ask this question. Actually, I feel quite strange about
> why we need to add a new parameter `is_bare` to `repo_init` function.
>
> For this call:
>
>     repo_init(the_repository, git_dir, work_tree, -1);
>
> We add a new field "is_bare_cfg" to the "struct repository". So, at now,
> `the_repository` variable should contain the information about whether
> the repo is bare(1), is not bare(0) or unknown(-1). However, in this
> call, we pass "-1" to the parameter `is_bare` for "repo_init" function.

Isn't this merely trying to be faithful to the original to avoid
unintended behaviour change?  We initialize the global variable
is_bare_repository_cfg to unspecified(-1) in the original, and
for a rewrite to move the global to a member in the singleton
instance of the_repo, it would need to be able to do the same.

And for callers of repo_init() that prepares _another_ in-core
repository instance, which is different from the_repository, because
the original has a process-wide singleton global variable, copying
the value from the_repository->is_bare to a newly initialized one
would hopefully give us the most faithful rewrite to avoid
unintended behaviour change.

At least, that is how I understood why the patch does it this way.
As you noticed, too, there are ...

> When I first look at this code, I have thought that we will set
> "repo->is_bare_cfg = -1" to indicate that we cannot tell whether the
> repo is bare or not. But it just sets the "repo->is_bare_cfg = is_bare"
> if `bare > 0`. Junio has already commented on this.

... places in the updated code that makes it unclear what the
is_bare member really means.  The corresponding global variable used
to be "this is what we were told by config or env or command line",
but it is unclear, with conditional assignments like the above, what
it means in the updated code.

Thanks.
