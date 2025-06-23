Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB528CF6D
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695019; cv=none; b=kTamrgSWiwm1aiUiFlzPyAAnr6p3ODBpRxeOPfWMHr2YgxDdyJja2y4LIAB9Rq9Cgkh+iRgvUX8k3SfZpouxWPoaJ636fqMLyRLLLteLzNd0WTQllTdoqxDK27ETIBgL4BfWkx5aGELKBKkYlBujYfER1BOODiJ7vhSA3fp7ioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695019; c=relaxed/simple;
	bh=E45OT33i0i7J31wXkKCSl2j9Oy4Z1By1YF1GfnxUR+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ghHaoQL6lQdMghVh6GBdkmEUf9CDdKApkPFfUxXeEj2KSeZh5rN8XE1OQBDwEAJ3Q7ic58YHjbDnGoXEwupvrXTWwTu4ut1mTPA9sCG9bnPFHBNpRI4qiD7qpRZVBk55QsmgUG1Gyc+kSQ/BOrCpE4NrubTC6oE9Dw/2T0K5X2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2TuKnfFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUwqu55C; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2TuKnfFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUwqu55C"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A1B25138034C;
	Mon, 23 Jun 2025 12:10:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 23 Jun 2025 12:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750695016; x=1750781416; bh=R1pySobboP
	JXRqVKEzAyQ7aPtxvr85u47MCybRbIfow=; b=2TuKnfFnyxWLTfnf2PzGE8Fqs9
	8GQEhuxteQZgwEDbXvtNF/mcIyGWoxhDrcifP1G8suvXobfUhnR93yL7q3BKn7rG
	cvY7p3aYDrzOmnrGAHdsvET2HARVDJzFMeVcJVC6uKdg0Su0bJS6GdErm6S9oSpI
	ic6REtFL7EEXeSt+wUKFhxVvi7X9DSHnPQfBVjHnTDXMES+4QVbvzfQc35fZriiZ
	5Mwygwbzq5zkzCUKWxanEryeDm/5kW4KtDDNY5fKWYTLjMXIMb/t2ZrnIMUHSQUc
	rdTasU2XPPtsvjarCmeIUcCepTCWHrr3EE2UD0D5EwI3E58f2qPAkgdnrkMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750695016; x=1750781416; bh=R1pySobboPJXRqVKEzAyQ7aPtxvr85u47MC
	ybRbIfow=; b=OUwqu55CO/b6s3KDTJJySgTWIpIy2i1mcte2PzDzcr3eLL/GLv1
	bfM8ME93JLJM4mzrmTC+1UnmTaNSEttE73Lh5ldDnBlNLV/GjUlHooxuaGtuhVXm
	RLiA0TIljcu+njMOC/soHr1ZZpdPOuCPAogG/zMnBLf33Cb9W7gEUWRt1B8Xx3jp
	etIe2df/mhGPZCiOYpb1oNUCsR/Sj0vIRr/lyEUmhQHRR/9md4QSGEBmIjZaYYGN
	PaIEMStGu100TKQEBL9HOcLBJO9FHprCzPYia4CQnNaJ0u9DD0gQnBaWOAwcNUzk
	sQblnzpu7KhPxBL4ER/JiSVUo5HWZR8uZtw==
X-ME-Sender: <xms:aHxZaFBWD0lAzES6c-ZymFBHv1W-Pat5Xyr5jcsaj_8uMJXiDkYTiA>
    <xme:aHxZaDi8yRz4Q_volca3-Dh1k-ci8m_y-4NSRiaQL_K2_pUz7fSIKfekGOehvYq0X
    CxFbT91Vos4oefcEg>
X-ME-Received: <xmr:aHxZaAnM_4u5U56BfxCTDuNnjFrPNNstXtTZt7KZKrl93Uo-mxg3399BNfxM3k3vkJEd67I142inj8a2-SbEq75Iocfmf7ZEPNTk644>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aHxZaPxhaZgatxXPyR00-mWWUgK45F9rM5LIi1TeM1ELiRbECX1rVQ>
    <xmx:aHxZaKTkeqtv1XEXsw3eieXPbophlb9bLvwb6DQhHQA4n3py1sSDoA>
    <xmx:aHxZaCZO1ex9rq_QoRoqD0adUazq0M9W1hKVK1soiL4EltLIdK-mPg>
    <xmx:aHxZaLT7rex541pl5TKs5px3ALBpbDZX7Lch3wzs-zo7H-6KXSc8Gw>
    <xmx:aHxZaB-4vEfQQdU6KcufFoGaYIVuNh4UtQyvViuhJfCAhRCdGGgQB89G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 12:10:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] test-lib: teach test_seq the -f option
In-Reply-To: <20250623105625.GB654412@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 23 Jun 2025 06:56:25 -0400")
References: <20250623105516.GA654296@coredump.intra.peff.net>
	<20250623105625.GB654412@coredump.intra.peff.net>
Date: Mon, 23 Jun 2025 09:10:14 -0700
Message-ID: <xmqqikkm782h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The "seq" tool has a "-f" option to produce printf-style formatted
> lines. Let's teach our test_seq helper the same trick. This lets us get
> rid of some shell loops in test snippets (which are particularly verbose
> in our test suite because we have to "|| return 1" to keep the &&-chain
> going).
>
> This converts a few call-sites I found by grepping around the test
> suite. A few notes on these:
>
>   - In "seq", the format specifier is a "%g" float. Since test_seq only
>     supports integers, I've kept the more natural "%d" (which is what
>     these call sites were using already).

Yeah, that was the first thing I started wondering about after
learning that "seq --format" is a thing.

>   - Like "seq", test_seq automatically adds a newline to the specified
>     format. This is what all callers are doing already except for t0021,
>     but there we do not care about the exact format. We are just trying
>     to printf a large number of bytes to a file. It's not worth
>     complicating other callers or adding an option to avoid the newline
>     in that caller.

OK.  Other than the newline, the update to t0021 changes the actual
payload used in the test, but it does not affect the characteristic
of the data (like how compressible the result is) all that much, I
think.

>   - Most conversions are just replacing a shell loop (which does get rid
>     of an extra fork, since $() requires a subshell). In t0612 we can
>     replace an awk invocation, which I think makes the end result more
>     readable, as there's less quoting.

;-)

>   - In t7422 we can replace one loop, but sadly we have to leave the
>     loop directly above it. This is because that earlier loop wants to
>     include the seq value twice in the output, which test_seq does not
>     support (nor does regular seq). If you run:
>
>       test_seq -f "foo-%d %d" 10
>
>     the second "%d" will always be the empty string. You might naively
>     think that test_seq could add some extra arguments, like:
>
>       # 3 ought to be enough for anyone...
>       printf "$fmt\n" "$i "$i" $i"
>
>     but that just triggers printf to format multiple lines, one per
>     extra set of arguments.
>
>     So we'd have to actually parse the format string, figure out how
>     many "%" placeholders are there, and then feed it that many
>     instances of the sequence number. The complexity isn't worth it.

And it would deviate from the normal "seq", which would contaminate
our developers' mind, which is not a direction worth going.

The changes look all good.

Thanks.
