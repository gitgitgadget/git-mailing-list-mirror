Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888CF136E3F
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293768; cv=none; b=mg2ZNrESbYln0D3tJwOkxERvCAV7xyzV5ZjzihnxN7Ta7E0LdNzNxEP/RRxHovrn8NGsyx4lyb+vamEExqobH8DOghpsw1vz+r6oSF6OjKo6zRisD1B+IdcsqHrZcX7BWUbHdu2WKfmnXBZN6CW3cPOr4iU+Vw7xYMNguPV9+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293768; c=relaxed/simple;
	bh=7b631q3aOCfhmS612PyDgswxOfa53ljowFZ3hen0XYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyW6b1tme7+BLdSuZNpC+1JSrWdK7DeCJo1PiYTKyBkzjUlFy1hy5GbXQHWx9st7LerMYtbDpuPTcnOSH+kZhTpXYLahSytpJaBdgsV0mV/2oDX+2FF/EaFjU5GwERrkLgHW7FInO+/chz2Pmk9k3LrorUm+KLZrldX6zO+7XLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ji36Nhsr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cYN6/quN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ji36Nhsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cYN6/quN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C4811140181;
	Sun, 10 Nov 2024 21:56:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 10 Nov 2024 21:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731293764; x=1731380164; bh=+UgbajP0/J
	leO9RzW3jwSM4/T2B77H4DfuDG3F3cfM8=; b=Ji36NhsrPUMJRrIefCSb8F/Fah
	wisXtfgbD/nPxd05vO3wDL+DEwR+w+zW9U3bMs8Rc2Nn879Pq+Mww9mdkoO4tT5b
	HnLUdi/4FNJMV70JvSDmt9xARHS7AwH7COBz3crKWbJ2HF8OxG1z43XBU2ui83ai
	tc06YkI7AyeZeblWfH/71Ct31+SwCRgFYtorlqQtzjj6oIw4lMZVqgUoln/xbZoA
	WDDQTjPf511nhxAhEwrFUtU/CgNdE8lni/6zYvJbXmx2fA61aPTLXwwAq8BiRHpC
	cVD41yelDW+fVVC7tKmQv/sHA09F6g+7r9p+2nPfKsDyxXJf2aEjtsJRNxdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731293764; x=1731380164; bh=+UgbajP0/JleO9RzW3jwSM4/T2B77H4DfuD
	G3F3cfM8=; b=cYN6/quN9q4CPafximPOw2iuXunPv8Z/2ZY9pDDt7tjXXEKAvRY
	68QuN67Ts2mQUm9Qw9JkQePA4ymUpaP5ASgJSRDwm/bOZX8wolqY1R7cCsJBT9Tj
	fqIQ5N1xv3l4uF9F8QG4JnRRI4H/0GCa0Mcb9aPGPis5v680c+ETen0CDtrEmfph
	Myiq/dbeOE8tWIEqDgV/0DfcyVQS2Lqvl1m21XkBHReKk7qkQ2iPL/cAUV8J7aCi
	YEeUMWfXnyuJPtcrnAVM5/0bk9VKQLvGdJts+VxFsv1AupXrYq7Qzq5+e6/etYHA
	o3KJN2pd0RjZPM7ANPz4hPxV1GhYrBcwS2Q==
X-ME-Sender: <xms:Q3IxZ22UJefBugJjkpkIrLsoOp5lul7frQ1CAAOmT6FZg4_Lmr3LHw>
    <xme:Q3IxZ5E8zNB5e55S3dROLwTrvQ5zDIx_f0EgWNZ81jciO3SwCzO2ByFY-bssoL6aE
    b4o4XnJfcz0WuGm7w>
X-ME-Received: <xmr:Q3IxZ-5nbPALAUFVLkvloqsKifNhTBABBtCQJ8Zy8XwT0bHzwZiVZmLwhojS4nDwF7Oe8FCxOQT-UJU84SEEtZNOqNMJh5bFXhXf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhhntggrihek
    ieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Q3IxZ32A0zsppBTgA04lXyqMZnbNG-kpElc-vY6zYZs7UzaY6Lj2kg>
    <xmx:Q3IxZ5HH_ZOQM441q7OTStrQE0EDjS8UA-SKV9-c2FpvZtmp0JkP3g>
    <xmx:Q3IxZw_b7Dzr09aIREifPF0fV1ymhspIw_-D1T-gxR0nBCY91G1CFw>
    <xmx:Q3IxZ-lQGiRyL_tcRb6uoxaWHP9vneRM8FWpI437TnI9sE37IR255Q>
    <xmx:RHIxZxGYVAmD3Pzv4LOnU2uRwfDp6Z3_8q-nlcLRcOlcUbTVwaIMEE8v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 21:56:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick
 Stolee via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  ps@pks.im,  johncai86@gmail.com,
  newren@gmail.com,  christian.couder@gmail.com,
  kristofferhaugsbakk@fastmail.com,  jonathantanmy@google.com
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
In-Reply-To: <f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com> (Derrick
	Stolee's message of "Fri, 8 Nov 2024 10:17:24 -0500")
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<ZyUqr/wb5K4Og9j9@nand.local>
	<2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
	<20241104172533.GA2985568@coredump.intra.peff.net>
	<xmqq1pzqwnck.fsf@gitster.g>
	<f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com>
Date: Mon, 11 Nov 2024 11:56:01 +0900
Message-ID: <xmqqo72miim6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> Jeff King <peff@peff.net> writes:
>> 
>>> That's interesting. I wonder which cases get worse, and if a larger
>>> window size might help. I.e., presumably we are pushing the candidates
>>> further away in the sorted delta list.
>
> I think the cases that make things get worse with --full-name-hash are:
>
>   1. The presence of renames, partitioning objects that used to fit into
>      the same bucket (in the case of directory renames).
>
>   2. Some standard kinds of files may appear several times across the
>      tree but do not change very often and are similar across path.
>
>   3. Common patterns across similar file types, such as similar includes
>      in .c and .h files or other kinds of boilerplate in different
>      languages.
> ...
> In a depth 1 shallow clone, there are no repeated paths, so any hash
> collisions are true collisions instead of good candidates for deltas.

Or #2 and #3 above, where large boilerplates are shared across
similarly named files.

> Yes. This is the downside of the --full-name-hash compared to the
> standard name hash. When repacking an entire repository, the effect
> of these renames is typically not important in the long run as it's
> basically a single break in the delta chain. The downside comes in
> when doing a small fetch or push where the rename has more impact.

Yes.  Due to --depth limit, we need to break delta chains somewhere
anyway, and a rename boundary is just as good place as any other in
a sufficiently long chain.

> The --path-walk approach does not suffer from this problem because
> it has a second pass that sorts by the name hash and looks for
> better deltas than the ones that already exist. Thus, it gets the
> best of both worlds.

Yes, at the cost of being more complex :-)

> The performance impact of the two passes of the --path-walk
> approach is interesting, as you'd typically expect this to always
> be slower. However:
>
>  1. The delta compression within each batch only compares the
>     objects within that batch. We do not compare these objects to
>     unrelated objects, which can be expensive and wasteful. This
>     also means that small batches may even be smaller than the
>     delta window, reducing the number of comparisons.

Interesting.

>  2. In the second pass, the delta calculation can short-circuit if
>     the computed delta would be larger than the current-best delta.
>     Thus, the good deltas from the first pass make the second pass
>     faster.

Yes, the early give-up codepath helps when you already found
something semi-decently good delta base.

Thanks for a good summary.
