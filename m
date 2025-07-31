Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D719BBA
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987535; cv=none; b=bSPYaehiXilogJvwPFE4viAVmH9haQ0favKYwcIAmuVnP1VqfDc78ar6wLHJi1Mtdy2BCOdsmLk0EMcplp1kCtFPX/cgsjoxZFGO8cJeqZE5Hr7vjdx5Zq/0AY0bkHXx/yQq+TyywRPnSz5aQqA8rTYk6obIzZY93hN1Przmbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987535; c=relaxed/simple;
	bh=fyWbQDUEZ0m6qX9F03QJxdG//0ygHggkrPmOdfOsPkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d3cAdJlBteWI4BTkDYb5iiLxt2FBlMRJKr2vPX73tU7ZZXOaZS61l1uCEgHlW+WYgW1hTQr4qC/wwmEqEu16Rj79tcMaeW1Ch8A8c/NcwGwHkcTsNBpP/h8hjSq9c9ayQ7Pia23y9eMlUpM1emuYD5OJpfQFV1KDA/QUXYZ+Wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fbWxRD2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvw4PjSU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fbWxRD2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvw4PjSU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 89AFAEC1208;
	Thu, 31 Jul 2025 14:45:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 31 Jul 2025 14:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753987532;
	 x=1754073932; bh=CE5cIz1yJcagpJQohkAn0J1SDMSmM4Ln12RsAg2MCok=; b=
	fbWxRD2FxmC9N61oo6sJNjXnrMA4n7hD9ZaQD91o/Kb+q3uWbqLBkttWRUkUtB5x
	GdenIrxt/BblOEolnyk1O9xabD4HVdbo+jjc28yFw2/p85zGVHEe5huAXvORCKai
	QIvT9KWfQuDkyxNmv2cBxQ23l8mglSXP8VljWR5FUdAN3R8xcJq/8xxyLTWeAQK6
	YTBUN8odHEoHMF2AkYkxTmA5gnOwQrWQZgHVEpicc+PVFuuJvnLRCGKT5b1BAldl
	UhkePC8peuZ5rSqQ5huFiKq9SzjCoFNLk2J/jjvgqqWQEFzUr0FfGltdtkZtaiYj
	/kaRTwyWY5MI3KmXPVKXMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753987532; x=
	1754073932; bh=CE5cIz1yJcagpJQohkAn0J1SDMSmM4Ln12RsAg2MCok=; b=k
	vw4PjSU84RYKSy90regmoYlT1IFzNL8cQRSeqaCLlj7k1gRmrQ5Ut5N1KUHpmlcO
	7VOnoEiUeGnNySTZwLaV0uL63ConrzSP4Wzc8kmb3Bk7qJ0D5qPjHAiLHh/1lYBN
	tzbvVSN/9k+8rGlJ+AYpt7Uj81PHvhhRQVcmMVU/LLa+CpU/l0OkKr6DQ8sFQ/m+
	FtAwm02+n2VfkrR0hrUvzUOFdlACv/anisk5E8GOOrOopCwvS/GF/vtGHxz/vxT/
	lnNjhK7VmBYW1NTiYuJD8xJBvMyVEPUNm1XtWrcMiNBQSizQsDoWCpj97WGq+t2L
	flUKpWKAv/7/pnBHGahBA==
X-ME-Sender: <xms:y7mLaKMWSi1UisT369-iS8hi5EsbUCHLspr61BchBcZZ5oAM9fg-GQ>
    <xme:y7mLaGjxafyXgm4aI5TfZsIREuEhxMbleuLHLxId86GsTXIItJDy9QTJztlAzvUAw
    eByfSpvf7O9tYq0Zw>
X-ME-Received: <xmr:y7mLaHunjvJuYxXr1CwWfuTvGSAJzb74lVXyCKmtKlc-qnEDHtDMqHxjtxWThgrpyLCPneWCN8_aYbyhhJnHBap9yAc6SqToI6qBKTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopedukedvfedtvddvvdefjeelseduieefrdgtohhmpdhrtghpthhtoheptghhvg
    hnjhhirghnhheskhihlhhinhhoshdrtghnpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:y7mLaMSlTshwVlPGW4wgknfgyo-P9EqpFF8yqscgPFr4RwONIPV_6Q>
    <xmx:y7mLaD0MaA0o_CwN8Tf2zLEZiVj96dpAPD5Sylig-JuwXVXbWDMbDA>
    <xmx:y7mLaJtfYtKAKNZVhmIe6KdsLpkCJSY8PgPn-VvVU-R3q_IM7kPZNw>
    <xmx:y7mLaBjyFBHaPlMCzHefQ908Bd8f0SN0E9xeSEtLIcl2tG6t2fEGvA>
    <xmx:zLmLaFaI-yW2PnTRwQR5eezlBTsonQLo-ePhTlUtspz2FpiKx8EWzCC6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 14:45:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "chenjianhu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    git@vger.kernel.org,  chenjianhu <18230222379@163.com>,  chenjianhu
 <chenjianh@kylinos.cn>
Subject: Re: [PATCH v2] t7450: inspect the correct path a broken code would
 write to
In-Reply-To: <pull.2022.v2.git.git.1753933780883.gitgitgadget@gmail.com>
	(chenjianhu via GitGitGadget's message of "Thu, 31 Jul 2025 03:49:40
	+0000")
References: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
	<pull.2022.v2.git.git.1753933780883.gitgitgadget@gmail.com>
Date: Thu, 31 Jul 2025 11:45:29 -0700
Message-ID: <xmqqtt2sqjw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"chenjianhu via GitGitGadget" <gitgitgadget@gmail.com> writes:

Somehow Justin and Kristoffer are missing from the Cc list.

> From: chenjianhu <chenjianh@kylinos.cn>
>
> Prior to 05e9cd64 (config: quote values containing CR character,
> 2025-05-19), a repository can trick "clone --recurse-submodules"
> into running a post-checkout hook shipped with the project.  The
> test was written to make sure the trick would no longer run the
> hook with the fix in the commit.
>
> However, the test did not check for the path the hook would
> create; correct the path to the expected one if the bug were
> still with us.
>
> Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>
> ---
>     modify the “foo" file path to "$PWD/bad-clone/sub/foo".
>     
>     cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com cc: Justin
>     Tobler jltobler@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2022%2Fcjhxmx%2Fcjhxmx-git-test-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2022/cjhxmx/cjhxmx-git-test-v2
> Pull-Request: https://github.com/git/git/pull/2022
>
> Range-diff vs v1:
>
>  1:  c2d1d8fe884 ! 1:  6434587a075 modify the “foo" file path to "$PWD/bad-clone/sub/foo".
>      @@
>        ## Metadata ##
>      -Author: 陈建虎 <chenjianhu@kylinos.cn>
>      +Author: chenjianhu <chenjianh@kylinos.cn>
>       
>        ## Commit message ##
>      -    modify the “foo" file path to "$PWD/bad-clone/sub/foo".
>      +    t7450: inspect the correct path a broken code would write to
>       
>      -    In the t7450-bad-git-dotfiles.sh, when post-checkout
>      -    is executed, the actual path where the foo file
>      -    is created should be "$PWD/bad-clone/sub/foo".
>      +    Prior to 05e9cd64 (config: quote values containing CR character,
>      +    2025-05-19), a repository can trick "clone --recurse-submodules"
>      +    into running a post-checkout hook shipped with the project.  The
>      +    test was written to make sure the trick would no longer run the
>      +    hook with the fix in the commit.
>      +
>      +    However, the test did not check for the path the hook would
>      +    create; correct the path to the expected one if the bug were
>      +    still with us.
>       
>           Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>
>       
>
>
>  t/t7450-bad-git-dotfiles.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index 14b5743b962..f512eed278c 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -401,7 +401,7 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
>  	git -C repo commit -m submodule &&
>  
>  	git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone &&
> -	! test -f "$PWD/foo" &&
> +	! test -f "$PWD/bad-clone/sub/foo" &&
>  	test -f $(printf "bad-clone/sub\r/post-checkout")
>  '
>  
>
> base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
