Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996F34216C
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494635; cv=none; b=ITh7rcah3JPhNrBIkMVFoJQd6uGIXltz0yAs7u34pYp3N0etKXayKcH+jubXJf+dAGTw6llKFCEVOT2BhO1XJjYFQ01zNIpih7zNDo5euBTSAlQXiSXdRpsGk+ZsXZsC9hfz2tvHCS+PLdvPDxIqT/ZWANdMYoVPy4696vi1jcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494635; c=relaxed/simple;
	bh=7V5xfeyzMNqwPn7WNbBiz0gKGSeVH5TcGz4yHdZDObc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gfkk/eg+LrvbXayk7ZlGIgR7KQZ+PQSfrMb/n+ae7MIxF2aSYt680in3llRr6ZexiasBh7m6IuyAWwR2kPwnjJJ+afLoCwH0jNblQxLFqcgFA8VQY4fm8UVOuPXyqRJO3EOtqGiGucaW43HjR6/fAdSSG6VAT6FoXyXrDudtkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nfrUp8CO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aNttJUo0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nfrUp8CO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNttJUo0"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id C6E371D000D1;
	Thu, 15 Jan 2026 11:30:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 15 Jan 2026 11:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768494632; x=1768581032; bh=pQ2/i87sSx
	/kbLth1dBuZL6WYq2Q4Dh0AtBPrX9PbTE=; b=nfrUp8COqX38xrOvntPOrW00JA
	nc+0Wi3/ZrB2ustnTiSXvxz8kAkcc08aFSnENdJvhfg4+0Zi+yriCwR3+QJPRFVE
	B7bQrlWAovPJXAdkMh8GY+17Q97pGSQ7cOwVriZ1bGdCv19DwJjY/XiV03hdtEkf
	TwuX2f4cUdsrPlc0iX/E1KhpjnIcCBep7w+scH+V82tr4HvidelEKdtILNUBIYSQ
	8TtzObXLWOlL+5sh006avMvrOhJkuBb5wU0TA6iDkuNUihQ2vArhMiCZS7yJY7Ib
	rkQQpahpXXLd6f5wIcoVktYwhFJu8LzKA838hAe0e0Q6c/DtH2dnLPhmufqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768494632; x=1768581032; bh=pQ2/i87sSx/kbLth1dBuZL6WYq2Q4Dh0AtB
	PrX9PbTE=; b=aNttJUo0mtEJ7pb8GkG05G83nS4SvfmJdOV0p2RnsBNWD4Do9n2
	5dQ+sr2AAOB4S/ua+3mDy7h1Fec42U4WHCzV88ADpe5brivKr19muhdYjlIv1SH8
	G9rY7AvxTihMksfz/LcF3BohBuMie5+6CHf8Ue0gm60uZ+Gi62e1ks0fovm+Rx3P
	4juwOs3HGHR5pWtvG8jhEu+/TcOc2yCj53zl9LbTiYxMReqwgMSqzdfscXT3TtP+
	IEGFTks+L2mEhvuH8iCHyBX3T87WuaHCgL4Nv1dvoILwunjqhk/SNhPWyFXJVXor
	UGmrfPdHGcNrHoHEEv98ohnrS5xA/ZWRDQA==
X-ME-Sender: <xms:KBZpafEQZto2AkAgx1UuJs-FkOJGONhpG3YAoWyCxmAZy1pCRvYOUg>
    <xme:KBZpaTy0q_4BWlk8SW1JYJTrsdg6hzF-8cEsE7Rj0ylqd6IUcl6qjnhyHg42rvIpj
    rZR255IYVUcvMHyfk0qDwObzBpkxLiu8FFTbL_Ogt7Akjzwyovb>
X-ME-Received: <xmr:KBZpaeit1xZXrIu51ZDRdlUaCoXZBaqZ6Oc5xUQf993ydo9gpcbITv-3l80Us_CWlJng10nGU2zmY0oeXKlLisBZQqGmwiC8tfQCrZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtd
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KBZpaWz_veqSojyMlLjX2GGX7EyDp7miqvrGeAXl8JFB_X2asxa9Cw>
    <xmx:KBZpaZJEUjBvjOlzmnCMfhCSO2rcs1N9FUIK3HgPXAeqAARRyRcvsw>
    <xmx:KBZpaVTfy1nAsLSsc2u8iFM0STxZfywMek67nIhMQt09hf33Tm46wg>
    <xmx:KBZpaZqYto0y-K1Pc0BbLXMDnNtBebD24g6VI583FN0LAF5tlSGRwQ>
    <xmx:KBZpaXyBMiclATTTeywkoSJieLq5a1x_it5VvGuZnVTXsbeWSIKViOnZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 11:30:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] subtree: validate --prefix against commit in split
In-Reply-To: <20260115122652.18673-2-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Thu, 15 Jan 2026 12:24:35 +0000")
References: <20260115120936.18491-1-pushkarkumarsingh1970@gmail.com>
	<20260115122652.18673-2-pushkarkumarsingh1970@gmail.com>
Date: Thu, 15 Jan 2026 08:30:31 -0800
Message-ID: <xmqqh5smdejc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> git subtree split currently validates --prefix against the working tree.
> This breaks when splitting an older commit or when the working tree does
> not contain the subtree, even though the commit does.
>
> For example:
>
>   git subtree split --prefix=pkg <commit>
>
> fails if pkg was removed later, even though it exists in <commit>.
>
> Fix this by validating the prefix against the specified commit using
> git ls-tree instead of the working tree.
>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  contrib/subtree/git-subtree.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)

Is this something you can protect from future breakage with a test,
perhaps in contrib/subtree/t/t7900-subtree.sh?

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 17106d1a72..a5822b66d5 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -257,6 +257,9 @@ main () {
>  		test -e "$arg_prefix" &&
>  			die "fatal: prefix '$arg_prefix' already exists."
>  		;;
> +	split)
> +        # checked later against the commit, not the working tree
> +        ;;

Funny indentation?
