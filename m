Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932D2DEA9E
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886976; cv=none; b=tB3CIB6kw0gCJ00GhWpzfdaHuXFexzX0DWBnGdpBVLCJfb3tfX9JNqPBQPxmawFmgCTeTqf6zKLhiRFcts3gFOsbwuU6xtdRK+44+vR49l3rxCfwVYN3rtsst8j0hB30k3STW0oNFXNqQXI4VgfyIEsmXaWdhuNMrQ/42KQTPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886976; c=relaxed/simple;
	bh=aZGzLvOdv+wG3N3byLC/PBXAK5AbzMXBYkQ42MQjUpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o8rHBi5UZOYOXzvanOi7JsOZN6YXRH6Lprr2lColoyukdN1L0RXWHi+T/Q65JvHX0UhP0SnGJ550xnS2OOgpE0zFg+wYbQXmU5IZX+euiwGRdCzxRPAp694j1CqG1i1sYOinmivDpm705UCUGRq05afKku5lwBa5af0GrWTGG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hl4NyccW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHQpBm/Z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hl4NyccW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHQpBm/Z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 288011D00044;
	Sat, 31 Jan 2026 14:16:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 31 Jan 2026 14:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769886973; x=1769973373; bh=ienIcIDcEX
	MFn3Y4E6UkR2cCBhLtl18xwFy7zCPd3d4=; b=hl4NyccWorDNn1NSjy0QOxkYcS
	DkH34GpSNHco+fjxH9RQbRgmC4wAatpXkL+JfM9YiBaa3UZ21wNgKzoV/sAnNxZq
	Or4QkgeW2LIrkuzzYON0FFGZ5Qd4+d2ZgDAZMw5lpN/nb/DNtO7q7IaiJ4iYkXdc
	SDKFhWG6PMmdwTGuAh/hhFqZSwdGz8Te/WrF9fXB5soA//Iq7ouzHwGGzEUeznyK
	41SPUBy1P3/JY4MCWQz+BCecQuCuvdlPoTIyqS2S5bLEzNtgZy0w9pl86DH3ufKs
	mvI4LypB+rfZyzxo+pf3fAL38zf+voh/wl32gMvLbAPB/eHEF6kmiolcpf4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769886973; x=1769973373; bh=ienIcIDcEXMFn3Y4E6UkR2cCBhLtl18xwFy
	7zCPd3d4=; b=iHQpBm/Z967VGGJIj8m7Ml9D2lbUPeYacGWULVEyO9Fec/QqyQU
	kVGq25DZ8u8P1ph1pgfaXyNFM7CsPJdyFkEDgzwEERJepU/yhIzN6qaKsBErM2EX
	aTLgE6QkuX6477HqyYmtHsystMQg1+sWgMTLHhBeefboAkjXVf28diagPRNdDXvJ
	iuC6xOrVQtNp96NiTureU1Pb6pZnDDXB0tLRrmqLk73smSdK9vWN8i3T/x8g8ySW
	FuJ17002CF/IoG+WfEkx6xVFYp3B8Rf3wj8krRNDyn3hbXMm5uZF2xF/ZdR47tBh
	MywaB248euHD77JBqnRlTA8+0a2QRkxfhtQ==
X-ME-Sender: <xms:_FR-aRc8obzisonsloJfihL1wgEkJnhazbOJXVfo_vRRUEhuFCGv4g>
    <xme:_FR-aWMABufs34ToV4kUESiJZJ6xS-rG9HuQRxDmS3uSLy7psO186nqghNt2s7AZP
    9VeDcSMoiiL9jhRcnEQ2znV2xPFuPLriVYQPQgyhBN_hkJ9obJF6z8>
X-ME-Received: <xmr:_FR-afgpFWXXsCW3kPEH5koD7fmXtiq95iMSILIv0E-xPnOP36z1bJND7U_0yFEIW05QEu8lTOir87FgL4zI0ZAgWElc9EGLXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfefieduvdejgedvfeduhedthfdvkeevgeeghfetheelueeltdelfeeiheeg
    hefhnecuffhomhgrihhnpeguvghfrghulhhtsghrrghntghhrdhinhdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_FR-aZ28d6cIP_WtGM_kf_K-qSa7Zqb6JP4m8ZZZg0wnOuMjliid3w>
    <xmx:_FR-aZiSbZUVM9aSKS3gVeSRIRVIerHYAl_w1XPRlelVjdIS0WFVwg>
    <xmx:_FR-aZdIElRah1OECVHj_hJJw2kVRbpagcMUvaYyMjh5C3CX96Ixig>
    <xmx:_FR-acmlH55rxrJE18oIdZm3845ljjoWo7WDr-_7cBfYEtbqcrgI4Q>
    <xmx:_VR-aTB2G6k9aVrpjnJkSY60GsZNzVfczSgOuR4GTZArUv-hEPIhMg9t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jan 2026 14:16:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <xmqq4io3831o.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	30 Jan 2026 08:42:59 -0800")
References: <xmqq1pj8b22h.fsf@gitster.g>
	<20260130105954.59636-1-haraldnordgren@gmail.com>
	<xmqq4io3831o.fsf@gitster.g>
Date: Sat, 31 Jan 2026 11:16:11 -0800
Message-ID: <xmqqv7gh4mpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> For those who follow the naming the upstream decided to use in
> cloned repositories, init.defaultBranch is probably the last thing
> you want to take as a hint, as these people decided to _ignore_ the
> preference of their own and instead to follow what upstream uses.
> For that, refs/remotes/origin/HEAD would be a lot more stronger
> hint.  If they call their primary branch 'trunk', these people would
> want to call theirs 'trunk'.  And for that, these people would not
> do anything with init.defaultBranch.
>
>>     git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
>>
>> That's uneccessary overhead, that could now be replaced with:
>>
>>     git checkout @{default}
>
> That mirrors what I wrote in the previous paragraph.  Those who
> follow the naming the upstream uses, refs/remotes/$remote/HEAD
> (here, "origin" may not be the default remote) would be a better
> hint than init.defaultBranch so calling it @{default} is misleading.

Thinking about this more, while I can see how using the
remote-tracking branch that is pointed by refs/remotes/origin/HEAD
may make sense, I see no sensible reason why mapping that to a local
branch name by simply stripping refs/remotes/origin/ makes sense.

Stepping back a bit, the workflow that may be helped by being able
to learn the value of "refs/remotes/origin/HEAD", in addition to
@{upstream} and @{push} would be laid out like the following:

 * The project uses 'main' as its primary integration branch.  After
   you clone it, refs/remotes/origin/HEAD points at their 'main'
   (i.e., you have refs/remotes/origin/main keeping track of it),
   "git fetch" updates refs/remotes/origin/HEAD when they change
   their naming if you are using a recent enough version of Git.

 * The project uses topic based workflow.  The idea is each topic
   gets its own topic branch, e.g., 'feature', and participants join
   forces to bring it to perfection, after which 'main' merges the
   completed 'feature'.

 * You, as a participant of this project, fork your own 'feature'
   local branch from the remote-tracking branch 'origin/feature'.
   You publish the result into a separate repository of your own,
   different from where you cloned from.  If you fetch from there, a
   remote-tracking branch 'refs/remotes/publish/feature' may be
   created in your local clone as well (assuming your publishing
   repository is called 'publish').

Now, you have @{upstream} that is their 'feature' (that is kept
track of with refs/remotes/origin/feature remote-tracking branch
in your local clone), @{push} that is refs/remotes/publish/feature.
Comparing your local progress against these two are useful to see
where you are, how far you came, and how much others you see in
@{upstream} may have diverged.

In addition, the overall "progress" of the project is how far
@{upstream} has come relative to refs/remotes/origin/main, which is
the ultimate target that you and your fellow project participants
want to see @{upstream} gets merged, is a useful thing to keep track
of.

So in that sense, I do understand why somebody may find it useful if
there is a handy short-hand for refs/remotes/origin/main (or
whichever branch is pointed at by refs/remotes/origin/HEAD) in the
above picture.  And refs/remotes/origin/HEAD already does have a
handy short-hand, which is 'origin' ;-).

But step back and notice that there is no mention of local 'main' in
the above layout?

As Kristoffer said in another message [*1*], I would too expect that
people would not work on their 'main' (or have their 'main' track
the upstream's 'main').  So the utility of the piping to sed we saw
above is dubious, unless we are talking about quite different
workflow, but I do not think of what that other workflow would look
like that makes a neutral synonym for 'main' useful.

So, enough about refs/remotes/origin/HEAD.  Back to your original
idea of using init.defaultBranch.

In one of your other messages [*2*], you reported that you were
having trouble with repositories without init.defaultBranch
configuration variable cofigured.

Doesn't repo_default_branch_name() do the right thing without being
noisy at all even in a repository without that configured, as the
function will fall back to the built-in default?  While I do not
think of a workflow in which a handy access to the value the
function gives would be so useful that it deserves a short-hand, it
would be a reasonable candidate of what to be called "@{default}",
if it proves useful, I would think.

> I am not good at naming things, so instead of calling it @{primary}
> let's call it @{dumbo}.  With the realization that what branch
> refs/remotes/$remote/HEAD points at is a good source of hint, I
> actually think $branch@{dumbo} does make sense, and @{dumbo} should
> be a short-hand for $branch@{dumbo} where the name of the current
> branch is substituted for $branch (i.e. similar to @{push}, I
> suppose).  As you may be interacting with two sets of branches that
> go to two different remotes.
>
> In any case, it is very different from what you implemented as the
> @{default} in your patch.


[References]

*1* https://lore.kernel.org/git/7b62316f-a30a-4895-808d-baa20be0f3af@app.fastmail.com/

*2* https://lore.kernel.org/git/20260131000923.70152-1-haraldnordgren@gmail.com/
