Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF92200C2
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926694; cv=none; b=K71bnBBwo6XCcvQVaRce68wRF/pqwcyoYgiF/IUAsRSJDzPGxyhDKnpCXol5M5NlraUF/m55XVmKfUdm68pJp6xXnAY9FT94+rD9BYHIKH27BJmGoevKpAE8mJ/NLhB+vi4BlVfHEM9LXTiZRmqHRqTwMufo8ziTt0EUd/9Ixgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926694; c=relaxed/simple;
	bh=22DurlyZGc5xinqrlMJFzll1m+c31uNEj8GNYdMva0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rafgn5G/oc1WOAFPOerbLr1bFZrXTl0C3xCWxMysyVsCikg0WuNl7WFR8SQIjx/O/rl+L/d7vTZTaCKcoCerj5bc41Psj8bxAKNLntrZCudR6MxbpqNuWsf9s7lHP3o5cycYvbYAXiZ6U/YU+rcIkGJs2LusGRWqBp+Vgmrbm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a76JpWyp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=muEovyiA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a76JpWyp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muEovyiA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 774B41D000B9;
	Thu, 12 Feb 2026 15:04:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 15:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770926692; x=1771013092; bh=3XU5PRA4Z4
	DXd4MAsLZnlnFpA+ShiuUuA0F6fGo/RsM=; b=a76JpWyp+85iqaT4AzvWnqD/Ji
	A2eUJFCYJGas6NW7xEyKDoU0/Di0VDVwChDyUhGPm9IRYCor8mxNPlUdtWj1aDZs
	zz7knjGTBOG4aTdpJX502rucyBuCU9kiNTZUtYj81cg9yiusTRP5MznQKGGxTSSn
	wc7bIbVt9I895WAkMcFSfgOO4SyrhwtzXuC7odoAp7zJpJ5xT2nhEnPVYfhBgiiB
	/gXJIHDT0eHM2xMi+cA0itw2Qa2f4F7DQDbIvvc0LxEAZBWnZ2HfUlCP+hIAQL1L
	+y6gSzTqet/Mvufso579fzlFWoAxSkn28ARHjmWnezfzOg5UoxR2VefB4VDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770926692; x=1771013092; bh=3XU5PRA4Z4DXd4MAsLZnlnFpA+ShiuUuA0F
	6fGo/RsM=; b=muEovyiAffZBIgbvjQjIBCP/HVtJ23mPhNRDquiY3OSwq8xWkfJ
	Hi61qWpIZYKiDzXoOqGZZE+iVocyoA7hutF/CluspP2uDFSZoE81+qXejJW7WEWY
	AqWGStKZpI7x178wfP3LTocADlW8eNLIGZ3j9JAh9FuadYxl0d4/1StdPdXVCoRL
	bCTo3HVHGngtAOZJ9upAYa6PrWcgYoVwytcoslYVhljTWzyp7Nfc8m36Tl7NTAxO
	hTeJnTEPxRaZ3a0/KW8Jm/r0AIhL1klk1iaHsDlOvDZ703HU8OyKD+yJYeiQudiQ
	pXSL0T1jX3m4v5gUUoQH6QnOeo3CEHd+PBA==
X-ME-Sender: <xms:YzKOaa42TkphmgFdW2ugXUSnM48FpXNAQwoZOyFwctiWs1JTp3Od4g>
    <xme:YzKOabWTp-ZGTMCYA2aLW9M6joAIpDLqa6f8bk-l_zHncY7MJ57ajGzkmix8zQ7kj
    Mp9PxDZw6qyasJr11sHOOzpOKhdOmFoh1udqaSpsVQ_pL0LgKj0Uw>
X-ME-Received: <xmr:YzKOaW2KaBk6ZBy-qYGLEomYxDZJ1gTX7aIGp_y62CjbYNzqbcciP9vZ0yE6wLw5f2za6YPZl52WzvBkGsFYRXEO08UB9dv_lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:YzKOaQ1iJ8kEsovOczPvd9J5Wq1_RuSN2vqI9aB0WihYwa6yXBuoNQ>
    <xmx:YzKOaR_pORwa0t45pbmFDd7V0oKtzwE2tc7jm6JXQ_0O1LrLOF3yDQ>
    <xmx:YzKOaV2dP-EJ7oKnagFuN6zLdve72_xtx2CExdLkM86VgAxnfNuEzg>
    <xmx:YzKOaW-YBjWKeVzzxWyd2LpGaOR_i_Y3tef3IkuPjw-bL9QyhDXOgw>
    <xmx:ZDKOaTcAyIZqLZlzhonlrYRtHdlISA9bpSk8JOowNxx1CmhXg9VUn_1i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 15:04:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] builtin/history: perform revwalk checks before
 asking for user input
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-1-1ce03d631c1b@pks.im>
	(Patrick Steinhardt's message of "Thu, 12 Feb 2026 13:44:34 +0100")
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
	<20260212-b4-pks-history-dry-run-v1-1-1ce03d631c1b@pks.im>
Date: Thu, 12 Feb 2026 12:04:50 -0800
Message-ID: <xmqqcy29ohi5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When setting up the revision walk in git-history(1) we also perform some
> verifications whether the request actually looks sane. Unfortunately,
> these verifications come _after_ we have already asked the user for the
> commit message of the commit that is to be rewritten. So in case any of
> the verifications fails, the user will have lost their modifications.
>
> Extract the function to set up the revision walk and call it before we
> ask for user input to fix this.

That's a huge usability improvement.  Nice.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/history.c         | 69 +++++++++++++++++++++++++++++------------------
>  t/t3451-history-reword.sh |  2 +-
>  2 files changed, 44 insertions(+), 27 deletions(-)

> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index 3594421b68..6775ed62f9 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -263,7 +263,7 @@ test_expect_success '--ref-action=head updates only HEAD' '
>  
>  		# When told to update HEAD, only, the command will refuse to
>  		# rewrite commits that are not an ancestor of HEAD.
> -		test_must_fail git history reword --ref-action=head theirs 2>err &&
> +		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
>  		test_grep "rewritten commit must be an ancestor of HEAD" err &&

This ensures that the editor is never consulted?  How?  Running the
"false" editor would give us a different error, like "your editor
exited with non-zero status, telling us to abort" or something?

Thanks.

