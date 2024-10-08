Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B143BE4E
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352097; cv=none; b=NdQG79xo5HCczDuZ6ONcBFkZA48aCVM/Awr6e+thr8etsbrOCkWqTAl3HSzSQmtAGyZI+c6tkJtF6WKvZqbfQp3z8AxQQtlm/td95v+8kvbxeG5ldZ+fqXbGi/8uCOxqVscYlXsHyzbW5zHpv2/PgwToveQBiZCRXBIwwPCaD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352097; c=relaxed/simple;
	bh=lbIiv8RuZDSDK5X63xYp3eLh8kVir85Y/Mefg5XGYEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbXGZtgpx6joIgePZYuBxYKNAL4jTUIWO00sjhU2Vr8a3k3RUDEFWeDB0Iet9NVAEIrOGBP498C5FWojpiJ7Mg2MMchJo9iFkMiV5uD3bm3UGJZEqnt/7hdKsnfewIVUlhAWW5hW1X8ydZ31tAz3pJikUyIzvVYhrGP00gZQ45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nr9ffgTb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMNEPYTP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nr9ffgTb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMNEPYTP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B345E1380246;
	Mon,  7 Oct 2024 21:48:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 07 Oct 2024 21:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728352094; x=1728438494; bh=YEJ9heXQbr
	rKpLFbE3ofYV1rxS7WUpu2MRpnceijzHI=; b=nr9ffgTbLn9/kuzPmC63prWR8u
	VDdCAKpz9qImqsbxfs57I4XEhGSNVwgOh5GYevj1ZQxYSR/j6o2KWtFrMPnRsH6a
	29XOR2A1WHVDxT+iXVI+o1W9B5ftmiFzyi98EvVHEu7xCuAIQQA08xRC+59x2xk/
	VXtdW4EBQhUINTwtqp94viD1810myPRgheaZVVEb2FVuwDD3iCk819OdLJedvtIO
	w9YLd6pJvizBKYOeJLtZkbzPH8e96ILyASSuP3ScFoUBJ3JmZFd+tc0fCI0ytU2X
	rdrkAAmVPWDCP2pZhdKwlO0Z6pPyl0lllmUHzwbUU+QEzrJHw3f9B2YtnEbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728352094; x=1728438494; bh=YEJ9heXQbrrKpLFbE3ofYV1rxS7W
	Upu2MRpnceijzHI=; b=TMNEPYTPcZIhen0slhEemjzw1UwVoSztg2gPZTcpfUf/
	JCA0IvZklMEWAZNrkJDnMzhJ/MBx8bIY0NcgXfrb9hgzI1XnighaFmn5NXLfrjQ0
	5G5pcgMfF2U+nkjTbd9bFeqqkwidaJV+bVWhzlDHF+6S1BF3jB8zpFQwVb5HMLi1
	b/OCmpKhNGisSWZEPlTtWQVUyZhW1OA/YG3asWqP4yPzGerav+PlSc10BCea7bG3
	NaYdtNf1iIOF3Fmc/pObFcl/e8rGBzq0bSglvAEBRSLhY0Zm3Y75p/TGJR+S+ueL
	WT/57gWrenFghJAjWncqavs3ujCfmRjUaYT0iWCRMQ==
X-ME-Sender: <xms:Xo8EZyKyxD8lqrHli01PskXC0uOFqPMmvyR19X2TP71t9UEdH8iujg>
    <xme:Xo8EZ6KAGNqqdvvqSOdUEfBbbJrcxeM1Kp-xXBd7tIh32pKbw0s6j69spKic0bEml
    R1frA8lOvktImbgpg>
X-ME-Received: <xmr:Xo8EZyupuOiq9Vz58IEzaHmkUjcnF_MlMLj7sy8CLHB_LrTIpSt5PwSYExhTywzNd2KnBT1bTRIwfo6cisZL-OHeCkSXVscMNlfRy3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Xo8EZ3YVJIE-KzBE_elu6RzJ592KijZ81i-Sx75XkZVGMzCEUYz92Q>
    <xmx:Xo8EZ5brsMBhyM3oNZJvnvdrwLD8ndgyEmNGSMrqG08GGa6lZYdtoA>
    <xmx:Xo8EZzCvK8LwkitlVqtINVGyUO9kviZs4KP_ONOQQEaFP5Lj0gsQ8Q>
    <xmx:Xo8EZ_ZI3H4_4v2R1USKvAUcDw_RcqkVhtJzLThn_4WJT26gD96DFA>
    <xmx:Xo8EZ4XANdb95uKFyKBLyHGzFOOKl_k7jK2rsQ-LO2chUz4NSofTnu5w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 21:48:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
In-Reply-To: <pull.1811.git.1728328755490.gitgitgadget@gmail.com> (Samuel
	Adekunle Abraham via GitGitGadget's message of "Mon, 07 Oct 2024
	19:19:15 +0000")
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 18:48:12 -0700
Message-ID: <xmqq34l75pr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> The test_path_* helper functions provide error messages which show the cause
> of the test failures.

> Hence they are used to replace every instance of
> test - [def] uses in the script.

It is unclear the use of present tense "they are used" describes the
status quo, or the way you wish the test script were written.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  

Also, for a patch like this one, which is rather large, repetitious,
and tire reviewers to miss simple typos easily, giving a procedure
to mechanically validate the patch would help.  Instead of having to
match up "test -f" that was removed with "test_is_file" that was
added, while ensuring the pathname given to them are the same, a
reader can reason about what the mechanical rewrite is doing, and
when the reader is convinced that the mechanical rewrite is doing
the right thing, being able to mechanically compare the result of
the procedure with the result of applying a patch is a really
powerful thing.

I probably would have written your two paragraphs more like the
first two paragraphs below, followed by the validation procedure,
like this:

    This test script uses "test -[edf]", but when a test fails
    because a file given to "test -f" does not exist, it fails
    silently.

    Use test_path_* helpers, which are designed to give better error
    messages when their expectations are not met.

    If you pass the current test script through

	sed -e 's/^\(	*\)test -f /\1test_path_is_file /' \
	    -e 's/^\(	*\)test -d /\1test_path_is_dir /' \
	    -e 's/^\(	*\)test -e /\1test_path_exists /' \
	    -e 's/^\(	*\)! test -[edf] /\1test_path_is_missing /' \
	    -e 's/^\(	*\)test ! -[edf] /\1test_path_is_missing /'

    and then compare the result with the result of applying this
    patch, you will see an instance of "! (test -e 3)", which was
    manually replaced with "test_path_is_missing 3", and everything
    else should match.

And I did perform the sed script, aka "how would I reproduce what is
in this patch" procedure, and compared the result with this patch.
The patch seems to be doing the right thing.

Manual validation is still needed for "test ! -f foo".  If the
original expects 'foo' to be gone, and has a reason to expect 'foo'
to be a file when the code being tested is broken, then rewriting it
into "test_path_is_missing" is OK.  But otherwise, the original
would have been happy when 'foo' existed as a directory and
rewriting it into "test_path_is_missing" is not quite right.

This check cannot be done mechanically, unfortunately.  Hits from

   $ git show | grep -e 'test ! -[df]'

need to be eyeballed to make sure that it is reasonable to rewrite
"test ! -f foo" into "test_path_is_missing foo".

For example:

>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean &&
> ...
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&

this test creates a.out and src/part3.c as regular files before
running "git clean", so the expected failure modes do not include
a.out to be a directory (which would also make "test ! -f a.out"
happy), and rewriting it to "test_path_is_missing a.out" is fine.

I did *not* go through all the instances of test_path_is_missing
in the postimage of this patch.  Instead of forcing reviewers to
do so on their own, mentioning that the author did that already
would probably help the process.

Thanks.
