Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786C19CC28
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609257; cv=none; b=GSBVOXT4aBQ710pFauj3EQqqRTaQECWPqqxzb3jCWLZtJL/dTihGoFExMtLy7P3IM5Dxmp32c0dwIJ7prHBCtfgY8/k3OWR1fwAa1zhwyI0PK3ezOCnXUEyTSJyutFexrsqkCz7T552tyBhchLa8u2xi2hNIe5zqiU5v/wNDrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609257; c=relaxed/simple;
	bh=1LUalMXS+Q1YAgku5tmEolGKT0uMQCjy+7WW/7IeDRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M01Qhal8dCHtZ/JlZs6xoZdA8SRn+Ns9GajxPqWFDiah1/v/FvyQ2Nbc8i/TcbRzQkBV6J0ieAHW8saQWdVZz9oe0bRgADGENPKhLZXGD6c2h/+Su6t90/ubcWlxjGOmchN8PLSV/LDT7138ojaxCUl+nNeqMLXL0pA6CRtpvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eHir9sdO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JzopH1Re; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eHir9sdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JzopH1Re"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 288EA1400071;
	Mon,  5 Jan 2026 05:34:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 05 Jan 2026 05:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767609253; x=1767695653; bh=VwxHWwW9FE
	vA94nAb45Mt3YlUy4ppSH36cN4ND+ef6A=; b=eHir9sdO/PHooiIBtv0h7CREYj
	a8h7SeNc9AT7YCgQcN3zPk6M58ed6BLw0mWI3QvO+EoRyXjf9FJvQpoQMcka3L6n
	sHq4lSt264HvPduN7rgw1t/e7FejRN3O43jFh7nxzoQo4a9Kudo2rfQi6T1Pab/Y
	8jBz7htZr8vFtxsq4GcAn3ItqDdJF/KpE+yEruocnisPKFSQM0wnBAuwW0oplUr8
	dLsCq7DvhHk6lHz2VDeCwkTc7i889PYnRgWh/hre8uXAiQwQmyD30ya7SyARWXIm
	YFN+2YBDUMI+0v1z6KtO8BhZMSONka16UA3jCc2pCpAocOrQNgOv+20Vvvxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767609253; x=1767695653; bh=VwxHWwW9FEvA94nAb45Mt3YlUy4ppSH36cN
	4ND+ef6A=; b=JzopH1ReMtD+sFtKcO5NKgjXKd+DDeb0O3s7gBiJiCuOMEvkWds
	ECO9CQljuyR+/j0NFkVwEmyaL/qSoA2U7VJ0q0l+lMA/RbaqKLjM/w4xs2fdl/1r
	63ZPHQgSaobS99GEFN7GoUdQ7NwLIwkpccUo0oQOirtbplphd+crXbaZSH6aEhta
	4qW8NQXpcogf4MFZOVUDAJk3ICLDXdJAQyKE3J7TfG57GlyH3YBfIC7av0oyycAe
	WRcooPpWvBcAZUESgJQ+QdVEaN4Jt+bmh3MrY0YfnSb4ToUj2mT04o1teiipSXUt
	XRBUxOJaabLLS0xZshL3SLXYhMVeiYfAB1A==
X-ME-Sender: <xms:pZNbad27BOYNNe-l1qa3_MruQDvyEDkWMQJtgxr80q7m4rMbyV_fJg>
    <xme:pZNbabiCWrjlQTl77xoP5q0Rn7Dq-k0IGa262P1PdM73yuq1oa8G4a9zFTomPc1ib
    kJ8mrfnAnL-MD4EcHvLFDqRBKn82E1RYV9Hx_AL_h9-YfaUQFY5Ng>
X-ME-Received: <xmr:pZNbabQAGRaxhv0WGxeMB8d6xJF4ZZdhZfuvmPwUiVCSOZTQNrEmqoUSUECnq2SJxhJDmAPapuhb6C73fNaGvH2w_H897vJODTlUt_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhgvshhh
    ihhguhhrghgrohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pZNbaUiIAYY2gxMTqUqKy2p5c_UIH9M84c65uwevc6LmdnYqUNdgWg>
    <xmx:pZNbaT4y2etH64Bwl9XWZcqvRC_OJSNYKrVZbbNZK1zbd-zwPCGY9A>
    <xmx:pZNbaZCZV66Svk4hrFcOiOtpiICO740d4JL8Pcn8onIo4Xi4rndgEQ>
    <xmx:pZNbaSbM1s2_sTBxux7ZZ9dXUt4DRYd2-z85SAAxptOD1oFVUGZvkQ>
    <xmx:pZNbafjCCe75cpM6wzNmHjq9DNISfpOGQ4qMLXZbzLUo8SUqRXZSTKx6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 05:34:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [GSoC] t5403: use test_path_is_file instead of test -f
In-Reply-To: <CAG7UgEQeOJq0S87btjy8TT9as10bCAJWKEUTfNafa811iM8qwA@mail.gmail.com>
	(Deveshi Dwivedi's message of "Mon, 5 Jan 2026 11:28:11 +0530")
References: <20251229185737.2328-1-deveshigurgaon@gmail.com>
	<xmqqjyy2dvni.fsf@gitster.g>
	<CAG7UgEQeOJq0S87btjy8TT9as10bCAJWKEUTfNafa811iM8qwA@mail.gmail.com>
Date: Mon, 05 Jan 2026 19:34:11 +0900
Message-ID: <xmqqpl7ol55o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> I can update the clone test to follow the same pattern as the other tests:
> read old new flag <clone3/.git/post-checkout.args &&
> test "$old" = $(test_oid zero) &&
> test "$new" = $(git rev-parse HEAD) &&
> test "$flag" = 1
>
> Does this sound reasonable?

The open-coded four command sequence above is repeatedly used
throughout this test script.  I find them quite ugly but more
importantly, they have exactly the same downside as your patch is
trying to correct---it is almost impossible to tell where the test
failed and how from its output, because these "test" will simply
fail silently.

If I were in your position, I'd probably:

 (1) first declare a victory with the current patch.

 (2) as a separate series, on top of (1), prepare a patch that
     replaces these "read old new flag, then check $old, $new, and
     $flag" sequence with a helper function that can be called like
     so:

	check_post_checkout clone3/.git/post-checkout.args \
		"$(test_oid zero)" "$(git rev-parse HEAD"  1

     Leave the implementation of check_post_checkout just like the
     original, i.e., "read old new flag, and then test these three
     things, failing silently".  The point of this step is not about
     improving the tests; the point is to make it easier to improve
     in the next step, without changing what the tests do.

 (3) then update the implementation of check_post_checkout, with the
     implementation of the post-checkout hook also updated to match,
     so that the helper now looks like this:

	check_post_checkout () {
		test "$#" = 4 || BUG "check_post_checkout takes 4 args"
		echo "old=$2 new=$3 flag=$4" >expect &&
		test_cmp expect "$1"
	}

Hmm?
