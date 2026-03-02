Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F0371876
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486672; cv=none; b=MrMd58QAYv04/JBQqyvCqi53WO+93/tyy5x5Gebm9XodOL5FWTht0PWQ5aJkZgN7ky2ylAx1ob38F8H3liWLza47H0qCa6ThOTNoXeHXX+CUpaaAjvv2ZWKHvqD1V0VtlosyJtn+hWJvKXCqQ+u4EqaQ0kz54EZlBNgW2jh4rXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486672; c=relaxed/simple;
	bh=brMYZguopQy0APOcqDRxwxnslF0oxw9k3LaQPWXTrys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWUZFe4DuWJk/BgMMXTvtefPHhTd2wHbw8+2jsJlWuSZSRRQqiu2CjajTkxVrxsteBXuaqnKbydLBOwXOL9xA31mLHcXnT8Dn2UcJ8coKOXuP8EsR3JqfCi+eXFOJc/1glPFe35Km+B5VI5ufnyoNCh0uM5ybQygG0W7jZLHals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lRx8DX82; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1S6tcTI8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lRx8DX82";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1S6tcTI8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6836C1400104;
	Mon,  2 Mar 2026 16:24:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 16:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772486670; x=1772573070; bh=9rFSn45rK0
	DSZLVVjjqDJR9grOI9ufxsT6t8e6YInUg=; b=lRx8DX82FvJsaCtrlSu9a9/1HF
	gv3+P2B9yi+zdJgyLWGVKR5bDvO5J0lPqrW2B/B1203XNz8TfBtjLIvP2kEVJMQs
	kloX0+PoJ00PSmUsQ7aYMK8yZU0SbPN7hmOMGuKRtN9vOeRPScEnQrW34zlQMThi
	9HTLAMJSoh5ez62wmJwy64oKWpbwW+Ss0GsJvWaiRiOvFGmPEiDCP63iRo05H0IM
	1JguNH0IU6cQtZfI4Zj8uQXSXI0laP3FgTn0iGOwUTIaE91qbSs1n+zW9o+dOKuP
	LuhJRikIZAI/EHElAese8SqpoNJw1OS8axmsOitCNBevWdAKuGjCKmVAbWHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772486670; x=1772573070; bh=9rFSn45rK0DSZLVVjjqDJR9grOI9ufxsT6t
	8e6YInUg=; b=1S6tcTI84hCgCacUIKSyBTDoFrOIWdU3g4H4mulE7H9gLhKTCAG
	O0M+5FxHnsWow63RJ/j4Wk84LVT1fgCUGzKcbxJQ2bp27wQ61F2oVJ9t/dPNMyXS
	uATKbH2YmkYBMmTXa5xgpReATBfJXuTxaiq/tkC+/Z49XNu1aIaexJae4nJR7jfw
	NqS1HVks9ahtJsMGubAR6eyU+iDdjOAcWIjxgEgkt1RcbXHl292sQOnpP3OsobJ9
	SMarLiDh5md1a2FFMZ0QjrffNUpMf5+e4BxMA9hE9cb1Z+EEa32Ns5cl1R6dWcf+
	orXEfa9f/yU4KjLCZv3dMW0G39nU3J/fFLw==
X-ME-Sender: <xms:DgCmaXO4IEhk7BN1Gq_l4KG3BK5ivskS8O2bXRkyplr2e48RXCtcPw>
    <xme:DgCmaY-b2EJUhE7c1OlwCO4CZ3Ij31CXm4TYvgBKPfuTnfSUAoX6ABBglu3igbcro
    SECvNk83E63NQd2rKRm1DB_uD1wveZPeixetJGqNlWr8gLE65Z6alU>
X-ME-Received: <xmr:DgCmabTDuumeMLyDbkdI4D6GkYsAPYCWbvk1u_D0VWuiV9Kb3Df8S4ElwguFqB4sXSb-rb413y7XL7KozWnFWJn3hJUg6fTM3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DgCmaakZaas83yaxTpMV9A8pdT6IziLk3MI_2y39sYTrKtKJNRnn_w>
    <xmx:DgCmabT42kukxgciCyBZWEny40PviCex_HEl3OACwUKJXlNYHRIfEA>
    <xmx:DgCmaYPqM7Q1ENOEfrbEmicDi57piJt9ZMvRX-9oMwDgjgyq4WQYeg>
    <xmx:DgCmaUWfe7HJgeknmIfe8VUjiETcKW3o3tLIOGWh9jO0AxgLG0Hqkg>
    <xmx:DgCmaXN2HXHCXkjolqE2IaoCIzistMmKpA2lhm-yIriHWQb8R0DAl2An>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:24:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2] t3700: avoid hidden failures and use test_grep helper
In-Reply-To: <20260228070020.89668-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Sat, 28 Feb 2026 12:30:20 +0530")
References: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
	<20260228070020.89668-1-r.siddharth.shrimali@gmail.com>
Date: Mon, 02 Mar 2026 13:24:28 -0800
Message-ID: <xmqqh5qxzzzn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> Replace pipelines involving git commands with temporary files to ensure
> that any crashes or unexpected exit codes from the git commands are
> properly caught by the test suite. A simple pipeline like
> 'git foo | grep bar' ignores the exit code of 'git', which can
> hide regressions.
>
> Additionally, replace standard 'grep' with the 'test_grep' helper.
> This improves debuggability by automatically dumping the contents of
> the 'actual' file when a match is not found. In cases where we were
> counting lines with 'wc -l' to ensure a pattern was absent,
> simplify to 'test_grep !'.

Counting the instances of these changes, there are too many hunks
that fall into this "Additionally" category to consider them "while
at it" changes.  In other words, this would want to become two
patches, one to break pipelines to expose the exit status of Git
that is upstream of a pipeline, and the other to use test_grep where
the original used grep.

>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>

The trailer block does not allow blanks inside it.  Remove the blank
line.

> @@ -544,9 +544,11 @@ test_expect_success 'all statuses changed in folder if . is given' '
>  		touch x y z sub/a sub/dir/b &&
>  		git add -A &&
>  		git add --chmod=+x . &&
> -		test $(git ls-files --stage >actual && grep ^100644 actual | wc -l) -eq 0 &&
> +		git ls-files --stage >actual &&
> +		test_grep ! "^100644" actual &&
>  		git add --chmod=-x . &&
> -		test $(git ls-files --stage >actual && grep ^100755 actual | wc -l) -eq 0
> +		git ls-files --stage >actual &&
> +		test_grep ! "^100755" actual
>  	)
>  '
>  
> @@ -582,4 +584,4 @@ test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
>  	git add "$downcased"
>  '
>  
> -test_done
> \ No newline at end of file
> +test_done


Wait.  What tree state is this patch meant to apply?  If you made a
botched change in an earlier attempt, your "v2" patch should *not*
be relative to the tree state _with_ that botched attempt.  It
should instead be a change relative to somewhere stable in my tree,
pretending as if your "v1" (which introduced an incomplete line to
this file, among possibly other changes) never happened.

So, I'd suggest a two-patch series that is:

 - refine your v1 to remove mistakes (like the "incomplete last
   line"; there might have been others but I do not remember),
   keeping your conversion to break pipelines, without changing
   "grep" to "test_grep".  Make it [PATCH v2 1/2].

 - turn "grep" you touched in [PATCH v2 1/2] above to use
   "test_grep" instead.  In this patch, if the parts of the file you
   did not touch in [PATCH v2 1/2] has only small number of similar
   uses of "grep" that is better written with "test_grep", it is OK
   to change them to use "test_grep" as a "while at it" change.

Thanks.
