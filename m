Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311E1EB9E1
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259632; cv=none; b=XjzW3plSN40koLR3X3AnHwcvaBjPN5/lljeNQ0egNwXIw2RQ9DvqLX6SHhcEmMKMsRq3EjE5Q2NAe8frr3ux8xuQvM8KpswujDPoOshI3Mwnm+y4AD2HO0zFonIzpOsTLyFV8TrsV/jE05a/l4aCVMvcfOPWB3PzxvEeQ26XYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259632; c=relaxed/simple;
	bh=i4DWsRDpgl7ZQe1ce1VxktuGgHG4VTRjbunsxEeNnKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AQcthggkEDHdLowQk5rtFmaBiufLyOwqWPokokBL1brCV1AiR5wbxvlUXfd5HkPf2Gd6prPW5XEjP5MucRGa5ubcxTAbrnHyr9s5JL+HuVpmvkpwcBFd9CS4pHGRHektc9VuvwP+I8cjXbOW6iN74vWZ55Ux2/D60VNQBRVV4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nx4AugGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jWcQNAKh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nx4AugGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jWcQNAKh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94674254018A;
	Thu, 30 Jan 2025 12:53:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 12:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738259629; x=1738346029; bh=FTCjwFiZ+b
	hjrxEDml5FzicsgspNRguo532Dx9XXXeA=; b=nx4AugGWfysvuleHOEHv8H3vFK
	xmf+Iff1GVMIJI2JP7v3K/z4OqWVpCv4NUq7byanF66S3178L18ZSRXGjp04RLMk
	nd4m7vcR7dxjHskH/+IDfurw6PXbsK7ZUIkbN1iePV3gUaTtTPnDe02w9RqsTnnF
	DkgBK7HqzLmAs8ScK0Z/0bZsZtYPZhZfAxM7JGz0O2uMrusGwf5yHzQG39IkuCLZ
	PW414NExAoJ70DnRuQEqbz4bxEEmN4ubpgv8gI+Kv0IVQBwTqF7JZZnvkc2wLFVN
	zerxeP8/sKjphD163hsjsGJBXWBSvB5CV/j37AMkDrUcsLyALG+pLK4bB98g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738259629; x=1738346029; bh=FTCjwFiZ+bhjrxEDml5FzicsgspNRguo532
	Dx9XXXeA=; b=jWcQNAKhujcbUlXYlsl4T8oMaVbRyCqbqlqpSMz7SQno4AnjGY+
	lGzp1MFWgsnEemYP2ZLD/iI/VsjRHwqClFOBgYlkKBagPaKcxcZBa5tY4/iiaySH
	uc8BSWFFuRy14Z+k3rq4UEqIwT64KETX7uZuCfmBvBVuXps0iIzVMNZdxgkhoAds
	ykILLIDVrO6m01NFJk27CcbcWa6Cxg3hEoUb1TlcVLJw6nmeGd3aLYnKlM3GaQ1o
	dFoey2CijyLZSs8IZKSVcLfjPkB8Us73ROtocxOiFVMPExJ/plWjWwg0XHglY/Lg
	u/U07UddY4/ocX6CwzMcWBWNQx+k17Djfdg==
X-ME-Sender: <xms:rLybZ6Onhj-TnqxRsJknDPmXoFK3f0yKJcIFA18tOUCFaS_DRShrGQ>
    <xme:rLybZ4_uKzMM8r17lyyym_0dATFfOeY6sz2y6JsuYKsZL-pI_BnbwOZk0rN-pmAsa
    9Qrt7mMYFDHdx-j6w>
X-ME-Received: <xmr:rLybZxRlPSeHbcoBomF-XXZgOfW6LGa-L8CKT5xuJkB5JT00hvGX2wnubEC9n7_tm7XYWGSH8Ii5aSl3hA20vP0JG76c5W2h-wWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rLybZ6ttR6kXmiiE--1ndYT0X_g7MKQkQizxHTHRoK1nVMepN381lA>
    <xmx:rLybZycY2d_1YIvjyKKtAxe6LMUcQgit66HD2dEbyCyyBFPR6TCLuw>
    <xmx:rLybZ-3u_PEUX1zBFSXvZxun01-24uqJaq-CswxZba-liksB2a1AhA>
    <xmx:rLybZ286dILTsOyHRRiNzn5AHyE665YwTo4IfufM-0T3l2gLjnvXoA>
    <xmx:rbybZ6Q7ye_aPkrjUkg8G3uzZzjaoBfJ0B4YYLfmj8qRBP66_LgfF9nj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 12:53:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/8] t0602: use subshell to ensure working directory
 unchanged
In-Reply-To: <Z5r64p7ZiCoETGnU@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 30 Jan 2025 12:06:58 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r64p7ZiCoETGnU@ArchLinux>
Date: Thu, 30 Jan 2025 09:53:46 -0800
Message-ID: <xmqqcyg4fas5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> For every test, we would execute the command "cd repo" in the first but
> we never execute the command "cd .." to restore the working directory.
> However, it's either not a good idea use above way. Because if any test
> fails between "cd repo" and "cd ..", the "cd .." will never be reached.
> And we cannot correctly restore the working directory.
>
> Let's use subshell to ensure that the current working directory could be
> restored to the correct path.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  t/t0602-reffiles-fsck.sh | 967 ++++++++++++++++++++-------------------
>  1 file changed, 494 insertions(+), 473 deletions(-)

Note for bystanders who may be interested in helping to ensure
correctness of this step.

The patch meant for the machines we see here is unreadable for
humans [*], but the result of applying it and then running

    $ git show -wW t/

gives me a very clear "from here to there, the entire thing now has
a pair of () around it" pattern.  If you look at the clean-up step
each test piece defines with test_when_finished at the front, and
comparing it with the directory name the test repository "git init"
in each test piece creates and "cd" goes into, it is fairly easy to
see that the patch is doing the right thing without doing anything
unwanted.

All the here-doc in the test are now indented one level deeper, but
you can check that they use "<<-EOF" to be oblivious to the leading
tabs, making this conversion a safe one.

One thing that is hard to validate by code inspection alone is

 - This change will change the commit timestamps of the commits
   created by "test_commit" helper function, now that they are run
   in subshells to get their internal clock reset in each test
   piece.

But if the tests rely on the exact commit object names, running the
resulting script just once would be sufficient to notice.

Overall, very nicely done.

Queued.  Thanks.


[Footnote]

 * No, I do not mean to say that you should spend time trying to
   make the message readable by humans in a case like this.  A patch
   that can be mechanically processed and leave the byte sequence
   you intended to give the recipients is exactly what we want.
