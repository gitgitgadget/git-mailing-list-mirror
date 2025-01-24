Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D901D88D3
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742376; cv=none; b=B8itc1BCkCnGKRS2hMPxo1QfZvzWVdsOFrEJqPk52DvNYIMo8fHywWGgSFUdxVEVjSYmhDt7zPN6iLYPHU4oa5/HZvv5o5l8ijMqBQAzu7vCM1ppyItnk1kl033qRMn1X0bZTx1FztvZ9dYR7pfroP5vmEOoNsBrTXpI7w1snEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742376; c=relaxed/simple;
	bh=t+UytN7id+7T3P0Ao67m3SnzEt6ucSFk7BbboOVdf0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNVf3k5WJzRUP4effYpZKcPx0gwlZbETZWKafiX/D+nf2VaLRu5iPUfig6eKzzlUwrpaXjhHHOq1D93MPMrrb/fhhiK/Leqqorli8J3oVBuVNdm6c0nzH/Rzcr5s86UOjqRC9y9+qi3YMfG8D3J7j/J74e7a5jRt8xGrpUu5GCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hL/snYI4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s6elLzLQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hL/snYI4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s6elLzLQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F436138011B;
	Fri, 24 Jan 2025 13:12:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 24 Jan 2025 13:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737742372; x=1737828772; bh=0KAOrQzxTh
	tGuiZwwdM2rv/2sOkyLihzYrNIe78Cqcs=; b=hL/snYI4Ih7zOg7Nfd69mQHHEl
	ZqkukVYc4RLQ9b6h6eLsumy/5S8S8OlA4yPY508Gzxs8foCgrg5H2MxnUuBUn3rc
	JLhrdoq1ZKWQBFPXxiJOTPKRHYJJ9VH4QW9JckH/NSlNdYlZA/kkOatzvNvWFhpR
	i8JXHOgwH86lbyqxjRLX9eK1poPnZCk2paRoKDvMCLDp2dpl3JvC+0M43xLD0wec
	ZQrSw4dX4pIt2TYX2UubtqM9WINzxAiE8ZC8Qp+cz8V+X1hDra3JDALwtCmvynZJ
	OTRzXC2RIQW43goqivmjaRPAt4jdFcHcMN18/unISC17QW193D8vk3mzqC9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737742372; x=1737828772; bh=0KAOrQzxThtGuiZwwdM2rv/2sOkyLihzYrN
	Ie78Cqcs=; b=s6elLzLQOazdJGeth5EvYg8vTjKmbky3x1eKxduplhyGSmMl6ml
	htgkITqw3KYs8d54/b+Dff0XjL+5Ms/XU7zieWQG0ORUKBrmSbPHUloroGAuwpLM
	/A1/f1CLI0gZOw0Fnj3hzRg8dV78z8Zta8sXd3jl1olqUlFC30ETnFgy7wZZ/+Oq
	xyJsSirZIzYwUvKSnU1N05CtmLGF29Cpld0Q+sdokd2010oCDevL05iCHvOdbLzZ
	lVr7cB7iksBmuR0KKs5cRoTpWJNunWKZXTG/KYRvxdKRNvqOduuNp63S1hqUxYbX
	C49ukgab659BoyjJslixL3RPLPlS2MAnsFA==
X-ME-Sender: <xms:I9iTZ5m3-io-AKCjALF8U-6EiDlftLIIza21dVbS-sgJkGdhsEiKzA>
    <xme:I9iTZ02-tcTmTfKbnk0ZS_3qqyDmJalxf37qq73PdrRwoZXM4X2TsCaP8IqPp0VjH
    86X6XAu6JGAyOHGaA>
X-ME-Received: <xmr:I9iTZ_qMtzafXtPMuUIuQFtSJ0SkuS0AHDCMIyTH0UmucCm9mO03AgjZj0y7Ll_Ke4Z3rBjOz3rhampJou2f_eqO68OAsCM7z4Ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:I9iTZ5kOKzy1jPdl6TNzsss_DO9zg8Uqp6ET5HyEZ3xlcHpKP5vthA>
    <xmx:I9iTZ31xwqylariWI-tAANk6xXD8UKFilR1GGUbxC75-3VfGYxU6FA>
    <xmx:I9iTZ4s848arQWw2J--5QnyuRnDS0lcDscJ_eEeie8V_SKGZwb9NEA>
    <xmx:I9iTZ7U656M5dDh264kbdCzfqvYOKIFxDmr1_XVLd04v9kx1_yNvpA>
    <xmx:JNiTZ1NS24w0CzqH31AA0bnD7Iic01oFUNzIFYOdVaLF0NijigGG_zOd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 13:12:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/6] t5701: add setup test to remove side-effect
 dependency
In-Reply-To: <20250124122217.250925-6-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 24 Jan 2025 17:51:40 +0530")
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-6-usmanakinyemi202@gmail.com>
Date: Fri, 24 Jan 2025 10:12:49 -0800
Message-ID: <xmqq5xm4ytb2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Currently, the "test capability advertisement" test creates some files
> with expected content which are used by other tests below it.
>
> To remove that side-effect from this test, let's split up part of
> it into a "setup"-type test which creates the files with expected content
> which gets reused by multiple tests. This will be useful in a following
> commit.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t5701-git-serve.sh | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Nice clean-up.

>
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index de904c1655..9394235fa0 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -7,22 +7,28 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
> -test_expect_success 'test capability advertisement' '
> +test_expect_success 'setup to generate files with expected content' '
> +	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_and_osversion &&
> +
>  	test_oid_cache <<-EOF &&
>  	wrong_algo sha1:sha256
>  	wrong_algo sha256:sha1
>  	EOF
> +
>  	cat >expect.base <<-EOF &&
>  	version 2
> -	agent=git/$(git version | cut -d" " -f3)
> +	$(cat agent_and_osversion)
>  	ls-refs=unborn
>  	fetch=shallow wait-for-done
>  	server-option
>  	object-format=$(test_oid algo)
>  	EOF
> -	cat >expect.trailer <<-EOF &&
> +	cat >expect.trailer <<-EOF
>  	0000
>  	EOF
> +'
> +
> +test_expect_success 'test capability advertisement' '
>  	cat expect.base expect.trailer >expect &&
>  
>  	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
