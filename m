Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CE20FA94
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046403; cv=none; b=EsqKZwZETimpnKx6J4c6gYOOAQ3DTzYIytgJLESReax9YOPZJn8ZyWYcpnSaP4uref7lKbnJ7zsYkCR6n7+IXCj0UQxBXYhrP+jBJJ0EnFn2lxTe8bdFTkMGvQkjLQ6dE1AfmGveMDHih8CDaLCBu2ypcu0ZTolm5BD29q0IQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046403; c=relaxed/simple;
	bh=p00/jMpcRq8C6b7I4/uKX6YagCmMkU4U5lCGQc2DMeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BPPLzPZrYdXnnJAxOCz+EGjRWfuX+Y32zdOc6oCccyEw6rfT7jmgSKXsTw23k5GbZuuS50InoxajCIOSAguQV4XssSdTbhsnK2fxr+GBowUbq6bf0mCiep4LdKz4+LflIIbQxgxdzM5ahqIgm/oDwzosF8/2lsl8wONQHdHjZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HYS4lgF2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pnhaVDdm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HYS4lgF2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnhaVDdm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 070AF114019C;
	Mon,  7 Apr 2025 13:20:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 07 Apr 2025 13:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744046400; x=1744132800; bh=43drij68cn
	MvklEK0GU04pl8wrmtY9TucObpRDIKtU0=; b=HYS4lgF2zw/ugA/dIsaN7prP9t
	Ap3Ym/V2LEAXd0jSHZFUpgJLazIXJE4drhs4fg5oNCTw6DM6XS2haZalk5dME/z7
	ObtpnjN6oetl5fMiG2BT0t3JY7Fmy7CoDRIxSbtMewFbhCho7cLC7DLGGNS5+z6M
	iIAuDkmGbIHiXpn/3XkWRi2fqUmHskfnBaPB6TaZdk29teS0GBESKi/u1pzGpKKD
	Ajq58JtdXxjEG0Jtk73+WHH7zrYKaVbfyssxiaBTEamI6Knu0n7EkQENiNuMktZi
	zs9wSUJ4/KxY9/JTxtCvMjVzLbIRazVlgHeYu6eg3GtV5PHJEoLc4M6VyqdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744046400; x=1744132800; bh=43drij68cnMvklEK0GU04pl8wrmtY9TucOb
	pRDIKtU0=; b=pnhaVDdmC4ZuVr4b/M1amwpre0SL8RbZouNZlmRGQna+yu+EHDL
	Zk1H8UZ8deibh0vXI8/Pn3nJBmC3mOeMObZiVci5WlJr3R4CF2HGnzrpdREAUKQi
	DQK4VRr6UtBNUPL22IwlGCDyF+If1pt69mHOsGnq9v4wbcQ+quukxsmPVDfJQxuR
	+pRZ2y+knZvLQvOBD0ZxnqQDShEi+BGOUce+0iPzuyM1KpiDBcvr75q+Fn3fsv32
	lFexR2S51wBnqZiqnKqSbXfbdxp1Evjm3wrXADizad7cFH3AlMgCDHrFju1lKT9H
	qWNfxmtQIL0BWYjyXelfSOe7jmw0xZcJNSg==
X-ME-Sender: <xms:Pwn0Z3A_3JYB0KuJnZyzQyyZWaiCeFuePkIinBDjsV7dWJ8Y_uOEJQ>
    <xme:Pwn0Z9i--_8HACwFuHbqfab11w_KatUA8ElSXK395_hmEfT4TcIanX_fPRX471Boq
    zPjTNhi7jk0VsVGbQ>
X-ME-Received: <xmr:Pwn0ZymqJmJMjSQ1eKwwt1nM3Ypas3Sr7P2nxHL6x-rkx72yfnAvoDZ3Eal3Wm9NHpIMBf6J4mYRDjx5JFtvkbsyhx7MaDMd31oe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhhohhnhi
    ifrghnghehudefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghl
    uhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudes
    ghhmrghilhdrtghomhdprhgtphhtthhopegrnhhthhhonhihfigrnhhgtdefsehitghloh
    huugdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Pwn0Z5y1BjgudvobJ-Y-qbsTDlWe4lwv5ToZALcdtVShmHU4-xKI7g>
    <xmx:Pwn0Z8Q_GdLyPAM9UQyfryDqgXpWDWd4ZMUmAtKX8IHI_oiuiBSb1g>
    <xmx:Pwn0Z8baoGWJqYlaEwKq_07Qxz6dTxUYt_461qbZd4_ymkKNuF2wcw>
    <xmx:Pwn0Z9SbMJ9Ol2ewQ1aykuGpaa5XZwflR71V9_9NGD_jEioV5zkDFQ>
    <xmx:Pwn0Z2JZNQ46EWNRtTadA5yQ1rPfUvQF13-zE6WA5Me9027loc5wocxh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 13:19:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: ps@pks.im,  git@vger.kernel.org,  karthik.188@gmail.com,
  shejialuo@gmail.com,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com,  Anthony Wang <anthonywang03@icloud.com>
Subject: Re: [GSoC] [PATCH v2 1/3] t9811: avoid using pipes to expose exit
 codes
In-Reply-To: <20250407111824.46518-2-anthonywang03@icloud.com> (Anthony Wang's
	message of "Mon, 7 Apr 2025 13:18:22 +0200")
References: <Z_OEAxJENE_mGkVa@pks.im>
	<20250407111824.46518-1-anthonywang03@icloud.com>
	<20250407111824.46518-2-anthonywang03@icloud.com>
Date: Mon, 07 Apr 2025 17:19:57 +0000
Message-ID: <xmqqo6x7nb2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anthony Wang <anthonywang513@gmail.com> writes:

> The exit code of the upstream in a pipe is suppressed
> thus we lose any exit codes of git commands that are piped. In order to
> ensure we pick up the exit code, we can write the output of the git command
> to a file, testing the exit codes of both the commands.

Sort of correct, but ...

> ---
>  t/t9811-git-p4-label-import.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Missing sign-off.

> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 5ac5383fb7..5abac938d0 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
>  		cd "$git" &&
>  		git p4 sync --import-labels &&
>  
> -		git tag | grep TAG_F1 &&
> -		git tag | grep -q TAG_F1_1 &&
> -		git tag | grep -q TAG_F1_2 &&
> +		git tag >output &&
> +		grep TAG_F1 output &&
> +		grep -q TAG_F1_1 output &&
> +		grep -q TAG_F1_2 output &&

Think what these tests are trying to do.  After a "git p4 sync"
operation, they want to ensure that tags TAG_F1_1 and TAG_F1_2
exist?  Does the test want to see a tag "TAG_F1", or is it only that
the test is written in a so sloppy way that grepping for TAG_F1 will
be happy when any one of TAG_F1_1, TAG_F1_2 and TAG_F1_ONLY exists,
making its purpose of verifying that the tags are in the expected
state pretty much useless, and that is the reason why it needs to be
followed up with the two extra tests?

What is the desired state you want to ensure after "git p4 sync"
operation above?  I do not do "git p4", but you may know better than
I do, as you are the one who is patching this test file ;-)  I am
guessing that you want TAG_F1_1 and TAG_F1_2 to exist and you do not
want TAG_F1_ONLY to exist?

If so, instead of grepping around, we should be testing that in a
more direct way, perhaps with something like

	git show-ref --verify refs/tags/TAG_F1_1 &&
	git show-ref --verify refs/tags/TAG_F1_2 &&
	test_must_fail 	git show-ref --verify refs/tags/TAG_F1_ONLY &&

no?

>  		cd main &&
>  
> @@ -208,7 +209,8 @@ test_expect_success 'use git config to enable import/export of tags' '
>  		git p4 rebase --verbose &&
>  		git p4 submit --verbose &&
>  		git tag &&
> -		git tag | grep TAG_F1_1
> +		git tag >output &&
> +		grep TAG_F1_1 output
>  	) &&
>  	(
>  		cd "$cli" &&
