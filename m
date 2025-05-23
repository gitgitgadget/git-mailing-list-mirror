Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29545213255
	for <git@vger.kernel.org>; Fri, 23 May 2025 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043162; cv=none; b=j7IvZTEGtEdOba9XKdcz5IosWhWhxQB5waHTKPJw27Rx4uB1tBDms3sDBpI6HLIdzvF0uB7rsi4WBuy7yqDO7vBmmF1rhmyStRuU7v+gH3JwSp+uL3xBpg8xvSKrVgQZoiznONy71k2hU+5BrtktZYRfY+Dhh/G9Y2oHWrvG1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043162; c=relaxed/simple;
	bh=EuPZBt9l1FDc/vAb47vrsLEDpKTLSxFICexcRx1kkL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=juAw9isYxS/yPHbQOEqtkuqloTm91bhxQqgAlYbJYyXBdpDJawSgMgR9IO2LPwRnxC7kVATb4vmKUdf62nTpEqNdRRQMocN4f1LjdQn74KYXwvH+s91hecUPPPY0jpTwzSUa2Gq8ATeOp5fXCTbhmVbAVlszBbsGrV685GrkTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o677msA8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7EwomOQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o677msA8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7EwomOQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 201C911400B2;
	Fri, 23 May 2025 19:32:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 19:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748043158; x=1748129558; bh=l+Yq2CNIhs
	OU+MRAni/JTWmIfZxyyRjX8DGC9c1CAfQ=; b=o677msA82sQWmchXerNj722FPF
	k97gi82GofwVl760quTAzpJ/Eq78cibiGDQuzPnZNLF2eYu9DheNvJE0b1G6f2p5
	ErfYnky+qKgpWXu9V/jcB+B1X06OYV2I2Jut+5ALa3OFJnQ1vC0d50pjrrqeVO3q
	g5ZrJ9kuHrVK8kTDXWbqWpSgjAURvZ3AXl/QXxwPtz1kcBuzAQAkIUE/PTEmCO2W
	Mgq0JUPgpjDA7CkP7LxYvRBjHgUZkfp6nn5Z1s2b/NdG4HSHakdeWwr6uymljKCM
	JT3p+FWuaa+BBMZWdsZCQyxF2JauoxV/+lHReCH+GoshQxV5KS8JcsJVPUEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748043158; x=1748129558; bh=l+Yq2CNIhsOU+MRAni/JTWmIfZxyyRjX8DG
	C9c1CAfQ=; b=K7EwomOQDxmZZv5lkgZFVznizbH+j1ah+tj3fxC36RLV8oDwMSC
	BPPDEUOUZvolzdBhnJeP5++LR8zwEzRpDVH8SKvqALKQXcJxDPVYgjWHOiUiermX
	kfi6C7mrwgimSkykFxZX/h5Y7hYOdddt7uStsgoP5DO61IsT3uhg6AiiiozNjmHm
	XyIt3YtTiVBEah+dWWnpy2HzlAeSlDC81Ykwspalp3xtRe5pPoC4WiwUMLacojUA
	fCspcJWGR/f6lJaVQIj5eC0UwNoXSwJpLMbMTphdIksWKfiW3viqAsPoco7Xhz/+
	6aGCe+lmlR7llwW8oQLRw5xxM6HkEkJuJqw==
X-ME-Sender: <xms:lQUxaFnJGTUK8XETi0AJWmejTireXItvcgNhxpKgWjqwOZYZhC2qcg>
    <xme:lQUxaA3N4tqfLyBLvhiI1b3u8DEIQ2dKzydmvdtvYEKTU_-JRi5ZrqaRzDmqf6pqL
    sC1-piyx2nzJUY_XA>
X-ME-Received: <xmr:lQUxaLpUJzw579HFqmJVWq81XIUp_9K2RdsAJMl-ML9DbK2CFDCc4kEWEN6-oyzr0ny8sp37ZEb-M6iaqne90UAAxZhFao1vno-xH1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddujeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfe
    ehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:lQUxaFmbOZ-km2HwOYqpNMEDAHvhIxAi3avxOKB_zA9-6YUwQGhbqg>
    <xmx:lQUxaD3faC1HqE52fuIO7EnkwmOq8S3walJttj5dBn1MUxJHcuKpVg>
    <xmx:lQUxaEt3WsEwWLOX9b1xABP1NHaz1bpv7j1PuyqtVvayjkXc2pf1Ng>
    <xmx:lQUxaHW-cxBmCI5P3FMC8Od-1TRU6ZJVaKar0quMnUZaq4uHxwImSw>
    <xmx:lgUxaJmmdY_rWwji2SuavuSEn9x2ZRAAl78XnSWs315q6CYPZIL2icMG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 19:32:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/2] t4129: test that git apply warns for unexpected
 mode changes
In-Reply-To: <20250523172154.93810-2-mark@chromium.org> (Mark Mentovai's
	message of "Fri, 23 May 2025 13:21:53 -0400")
References: <20250522220235.8650-1-mark@chromium.org>
	<20250523172154.93810-1-mark@chromium.org>
	<20250523172154.93810-2-mark@chromium.org>
Date: Fri, 23 May 2025 16:32:36 -0700
Message-ID: <xmqqmsb2vr6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Mentovai <mark@chromium.org> writes:

> There is no test covering what commit 01aff0a (apply: correctly reverse
> patch's pre- and post-image mode bits, 2023-12-26) addressed. Prior to
> that commit, git apply was erroneously unaware of a file's expected mode
> while reverse-patching a file whose mode was not changing.
>
> Add the missing test coverage to assure that git apply is aware of the
> expected mode of a file being patched when the patch does not indicate
> that the file's mode is changing. This is achieved by arranging a file
> mode so that it doesn't agree with patch being applied, and checking git
> apply's output for the warning it's supposed to raise in this situation.
> Test in both reverse and normal (forward) directions.
>
> Signed-off-by: Mark Mentovai <mark@chromium.org>
> ---
>  t/t4129-apply-samemode.sh | 61 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index 2149ad5da44c..082e56db651e 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -102,15 +102,23 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>  	)
>  '
>  
> +test_file_mode_staged () {
> +	git ls-files --stage -- "$2" >ls-files-output &&
> +	test_grep "^10$1 " ls-files-output
> +}
> +
> +test_file_mode_HEAD () {
> +	git ls-tree HEAD -- "$2" >ls-tree-output &&
> +	test_grep "^10$1 " ls-tree-output
> +}

The script is about testing executable bits, so it is fine that the
above cannot be used to expect a symbolic link (if we wanted to
support it, we'd just take the whole 100644 vs 120000 without
support to let the caller give abbreviated input).

But then it is curious that this asks the caller to say 0755 vs 0644,
not 755 vs 644, which would be sufficient.

>  test_expect_success 'git apply respects core.fileMode' '
>  	test_config core.fileMode false &&
>  	echo true >script.sh &&
>  	git add --chmod=+x script.sh &&
> -	git ls-files -s script.sh >ls-files-output &&
> -	test_grep "^100755" ls-files-output &&
> +	test_file_mode_staged 0755 script.sh &&
>  	test_tick && git commit -m "Add script" &&
> -	git ls-tree -r HEAD script.sh >ls-tree-output &&
> -	test_grep "^100755" ls-tree-output &&
> +	test_file_mode_HEAD 0755 script.sh &&
>  
>  	echo true >>script.sh &&
>  	test_tick && git commit -m "Modify script" script.sh &&
> @@ -126,7 +134,50 @@ test_expect_success 'git apply respects core.fileMode' '
>  	test_grep ! "has type 100644, expected 100755" err &&
>  
>  	git apply --cached patch 2>err &&
> -	test_grep ! "has type 100644, expected 100755" err
> +	test_grep ! "has type 100644, expected 100755" err &&
> +	git reset --hard
> +'
> +
> +test_expect_success 'setup: git apply [--reverse] warns about incorrect file modes' '
> +	test_config core.fileMode false &&
> +
> +	touch mode_test &&

Use of "touch" makes the readers wonder a few unnecessary and
irrelevant things, like "does this test care about the timestamp of
this file?", "did mode_test file exist before?", and "what contents
did mode_test file have that the 'touch' tries to preserve while
updating the timestamp?"

Saying

	>mode_test &&

is much better here in this context.  It makes it clear that it does
not matter if the file did or did not exist before, the only thing
we care about is it exists as an empty file.

> +	git add --chmod=-x mode_test &&
> +	test_file_mode_staged 0644 mode_test &&
> +	test_tick && git commit -m "add mode_test" &&
> +	test_file_mode_HEAD 0644 mode_test &&
> +
> +	echo content >>mode_test &&
> +	test_tick && git commit -m "append to mode_test" mode_test &&
> +	test_file_mode_HEAD 0644 mode_test &&
> +
> +	git format-patch -1 --stdout >patch &&
> +	test_grep "^index .* 100644$" patch &&
> +
> +	git add --chmod=+x mode_test &&

Very portable way to add an executable file.  Would work regardless
of the filesystem.  Very nice.

> +	test_file_mode_staged 0755 mode_test &&
> +	test_tick && git commit -m "make mode_test executable" &&
> +	test_file_mode_HEAD 0755 mode_test
> +'
> +
> +test_expect_success 'git apply --reverse warns about incorrect file modes' '
> +	test_config core.fileMode false &&
> +
> +	git apply --index --reverse patch 2>err &&
> +	test_grep "has type 100755, expected 100644" err &&
> +	test_file_mode_staged 0755 mode_test &&
> +	test_tick && git commit -m "undo append" &&
> +	test_file_mode_HEAD 0755 mode_test
> +'
> +
> +test_expect_success 'git apply warns about incorrect file modes' '
> +	test_config core.fileMode false &&
> +
> +	git apply --index patch 2>err &&
> +	test_grep "has type 100755, expected 100644" err &&
> +	test_file_mode_staged 0755 mode_test &&
> +	test_tick && git commit -m "redo append" &&
> +	test_file_mode_HEAD 0755 mode_test
>  '
>  
>  test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
