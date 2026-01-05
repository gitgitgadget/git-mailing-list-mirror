Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FE2356BE
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767583462; cv=none; b=q4uLaqwCj4MyFk2mynJh1mhZ2YFl+aArQlAx+141UwY039klAxC0wvwFS8Pwf3vkrpk313eVEubhxRJ8vazPWaL8fqOOb6Fg/59sq+WhDhkjDi1V+/IqeeszQfCVtY2tHnrn2aFss2poO4xMOhU7K/Vvn5+oEnHETpkgt3ewoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767583462; c=relaxed/simple;
	bh=0GKiwTKtpluCUdJ2PJfkFVZhysyCxsuLvgaC9XXg4KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0wZKiZb+2ZzxmieyRG2yvUl3XtXVqjahZEC7NeN4OIOJnm6Qr8N5ckDZ9s1sVemymIpkMWLBXgvt9M9T/f1fe4cMX4lUa2g346CGRAGwui0O96YnA4owcl8p1CP9LGl9GMXJLfdhjfFCg7mz+LhDZiysao/ic0V2KoglfyyRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J5INMUnQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfX8HPZp; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J5INMUnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfX8HPZp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F7291D00039;
	Sun,  4 Jan 2026 22:24:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 04 Jan 2026 22:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767583458; x=1767669858; bh=3V8eRXVkoH
	37iB3MtcM2GjaS6Z3o/K4A0fZ4SGYOGaE=; b=J5INMUnQ7ZSjEapGrT0kGY0Gns
	ZTW636+aBTkmQ7SflC6+AFIKDJaYiDrGXG094V2YJMn5/qz/y2O9qcwYQaXUGKJm
	mxUkKon0eTTip1bOoLAgl3IdlfnfM7E1QU6YmE0BpWEMZYx7ZH0SfUPueDkkAt81
	obw8wgwb5y0K3brc4oXXesWEA+t40AgiZGbfsBKmCaKi3ppal7eN7+ANdGUG7Duh
	ZV1+kpQDcAc8xsfh1skd/Y+toZ7bEN9cWuSODgdTBS27t80GVPxJSex5K2yviFTy
	XyAj+jzz+HnUtZ5vYuVP9NerhIg/QSJKvdRaoHy9TnQ+txFnX2DRPgJDYC4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767583458; x=1767669858; bh=3V8eRXVkoH37iB3MtcM2GjaS6Z3o/K4A0fZ
	4SGYOGaE=; b=hfX8HPZpf7Ya6XD/sly/zkfnaWlKSHKp02MD1pKJgpwYulDnFoY
	QHpXFKw/5udaYoeWR8VRHwzzF4BE0PVKGYoPDSmMgfLbMvm7evjoWIBmILyBEX2q
	paqNF6yfuVPYtow5X/vp83PuEs5WZnAwxNi7KPYDYl9x4jaskVMzAyiSUIHvDZvU
	Bald27FI3pRHFNYqqKPYs3xa4M8COJ9wFjcNw9iJcB728kymg1URiDGPN9fDX6RT
	iBdugnyTLkzM8hL4VINWegVh67QBCUdaadfGSHyjzzfN1CYB/L0X/ciEWRNq170x
	QCGExhxQmwt3sR8KM2ISOzl8CxK3CsqBwIQ==
X-ME-Sender: <xms:4i5baTZ-ltN-mt9vbytnnAKvMHCind0naYyRqmmCXpHDZADz0PVyvQ>
    <xme:4i5baZ04Eiz18Og3owQg9s-0Pzv-rQIPeb8hdcOlr6NVUXHFE_YLx7aXdA4mFRg53
    DKeoCbKuQ5WEPFgkR-6qJoq6P-oHUB8QjAAmP2cojfMMYMgCsIM>
X-ME-Received: <xmr:4i5baTUx2a2xMHO5z18582vI7iV1a8PBsllOcEGFg1dX_E9FHhbf8hI5RTvEO3MfuTzVclUy81kZuYgRgOQXp4doiHRdIIHdu1gAbXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeliedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrnhgutghhihesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4i5baTUVVmOD5rn_oxVWr0SZp_KrGjqHYbiYZKg1NEC_HNiMjs7Jlw>
    <xmx:4i5baSch8o-u5M1F1ALL6r2aKdyC4DVZ-K8R8IoD7DOjHDah6TDqtg>
    <xmx:4i5bacWoZkBP4daZ8J7ue9Ekp4-xEREWMzaJ0UXRG_ShLsHfzNXabw>
    <xmx:4i5babfjxYAmCZBn6-imWHvcN4E8q0nAq9lzeT8RnFm6l_QYEK_GrQ>
    <xmx:4i5baR85L5HUfpNYY3V-uUiQWfj1dE29UGLAMMc6IlppMHsbMCTR_pIY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 22:24:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Chitester <andchi@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t1420-lost-found.sh: use test_path_is_file for
 error logging
In-Reply-To: <20260104161536.45384-1-andchi@fastmail.com> (Andrew Chitester's
	message of "Sun, 4 Jan 2026 11:15:04 -0500")
References: <20260104161536.45384-1-andchi@fastmail.com>
Date: Mon, 05 Jan 2026 12:24:17 +0900
Message-ID: <xmqq4ip0n3mm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Chitester <andchi@fastmail.com> writes:

> This test will fail silently without giving any error message. Use
> test_path_is_file in place of test -f to ensure this test errors with a
> message.
>
> Signed-off-by: Andrew Chitester <andchi@fastmail.com>
> ---
>  t/t1420-lost-found.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
> index 2fb2f44f02..5fbb1d10ed 100755
> --- a/t/t1420-lost-found.sh
> +++ b/t/t1420-lost-found.sh
> @@ -29,8 +29,8 @@ test_expect_success 'lost and found something' '
>  	git reset --hard HEAD^ &&
>  	git fsck --lost-found &&
>  	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
> -	test -f .git/lost-found/commit/$(cat lost-commit) &&
> -	test -f .git/lost-found/other/$(cat lost-other)
> +	test_path_is_file .git/lost-found/commit/$(cat lost-commit) &&
> +	test_path_is_file .git/lost-found/other/$(cat lost-other)
>  '

Looks correct, but given that what these tests want to ensure is
that underneath .git/lost-found there are only these two expected
files, I have to wonder if the output of "ls" here is expected to be
very stable.  I.e. if we rewrote the whole thing to something like
...

	ls .git/lost-found/*/* >actual &&
	cat >expect <<-EOF &&
	.git/lost-found/commit/$(cat lost-commit)
	.git/lost-found/other/$(cat lost-other)
	EOF
	test_cmp expect actual

... would it be a more direct way to say that and is easier to
understand to our readers.

