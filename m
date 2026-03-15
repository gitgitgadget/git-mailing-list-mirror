Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FD1CBEB9
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773553847; cv=none; b=a2lvXZEKG92Bvh2YXDR0O7cTNJkN5Cy9zcCa54F5O4Zc+o5I740/4bpz8RltbgqlwcGrVUxwTb/nunX6jL/4mVyK0PwmRBXKS6vhBd/ybCneN+M6AglNSfTXzGu9j0rv0QCxIUTjMPGDQNRnUVDJbj2DNS6TYPbpbqshsH3uiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773553847; c=relaxed/simple;
	bh=hSo34MwKbhk6U5ijTXn/Q6bacSPnuKmREwcxCznG/AM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyuD8+ZUqX52+2jOHfq/b6nffWQ1MJDbOsLP77qNNYTJs13x/q5jHpJwMcx2hNnEwIZ8ZZ50+gokLhG5MjF1AJCube7rYqiAZn5k7SbA75tbKPlDIjoplj7xSZwY1aBIilHkjodRM5n1Wqz1zj+LrJYaVU804Fgl8qgvrxjOtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fz4Fh0l7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vDN2fQch; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fz4Fh0l7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDN2fQch"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C2DBDEC060E;
	Sun, 15 Mar 2026 01:50:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 15 Mar 2026 01:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773553844; x=1773640244; bh=w827tgUpaG
	pZICX7cQjzH6Hf6p5alUcDxcMt6lNUXSI=; b=fz4Fh0l7v7Sylb+6EBzagnwWTU
	QWd2PTdutczffLQwb0wK2ExvwCYy/phtH0jOjqrPwdRqKVV+PFyDWgft0z6bKVLo
	wNxiQnNdLyGpZyNzYk+7LoHBzpUdl9U6kKvNiTBEF72+8nOBjhoy618R82TYA1wW
	CuFrn27VTWtGOKy9uJLSLahhqG94X+Iv0gfYI6914KKdH6kfSUJP+J+HqtTakUP3
	+EZ81lmrUS6DI4S+HTPV8S19SPrHMiEQeoSV8vwINj7d0vd6n8auCOQcM0eN3ANt
	GFcw9YIRFZWL/W6F1qkU/ItfsfMTVkBEMy16Sl5Hw/xl6ZywDeghiH7sheLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773553844; x=1773640244; bh=w827tgUpaGpZICX7cQjzH6Hf6p5alUcDxcM
	t6lNUXSI=; b=vDN2fQchNHGmqb0EsjRCr63NQrDJ3jFJGAkNJKhbr9dY9F6vRKh
	zXEmHKI7uYi31CLhN1tE2ioOdPmRujyUVe1bxTPxLon3bw7Q9I8W3xv4xAvXPE2k
	vdsInHWi6f6xS27rSX+TWdcw9sYFre9ifIRJTB30Hwil6+7FxHQvl9IdoOC1wKGy
	RVi1oGNWXaXpKE1xSkLvx/s0O/z1ZY0dNui5GbzaujFY71g66Syl03k+dS4CrKY3
	SHSYAUxRi+hRIS5m3AIBWPkdq4bW/GkW7HZb5UkEZzcMuOoqOKOvp66/DCKAZG19
	1dzgfws7p2dzB43yHc01KBc0sIw7NyjShlw==
X-ME-Sender: <xms:tEi2aTWR6MXGXZpymVtHe_gb-mIpFHs5HOVk8MW6204IjxYjbdFEyw>
    <xme:tEi2aTBpKbtwGEUbDdNYbGu2GoyP6SeHJGXuyatGV4_Jv4Ydey5iAf-hgnhvY8AU4
    _MTy7inKKWZlmFrfW0ryU5h1xgeGro65b4-zAq2N3Ii8AWpBuCQEA>
X-ME-Received: <xmr:tEi2aczx4LGldsMJLUpG0_OenjkJYNLCfc-oC_29Xd7Y_-PZhDvkfswx2GkXlmkfQjyomJtC3-mf-mS24QBfh_c_COhIyjCODw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tEi2aYC_3o6auTmbdosOk5u5uN9oL-3O-oyzpoDb-NFr32RKWz6CDQ>
    <xmx:tEi2aRYFRunh1XL0eAGDHPhJSj-yM319FPtTJXeDz1ekaSihTGrSvQ>
    <xmx:tEi2aYhvOwqhsftqLf3OX9qqVP3arMLso3njGRPSRrCg9DRo8t_XAg>
    <xmx:tEi2ab62tfAbBwCfb4swvr_SZH677F-b4bk2cw1Msa3HUkapmqX1dQ>
    <xmx:tEi2aWuHgw4PzhuM5s3Sx_TpZJ6vDHVM_l0gDtb9yZHDFW3VnMjUrEjd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 01:50:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0008: fix "large exclude file ignored in tree"
In-Reply-To: <20260315034851.2261530-1-mroik@delayed.space> (Mirko Faina's
	message of "Sun, 15 Mar 2026 04:48:50 +0100")
References: <20260315034851.2261530-1-mroik@delayed.space>
Date: Sat, 14 Mar 2026 22:50:42 -0700
Message-ID: <xmqqv7extzd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Subject: Re: [PATCH] t0008: fix "large exclude file ignored in tree"

Strange.  That is clearly not what this patch is touching.

  Subject: t0008: fix cleanup in 'symlinks not respected in-tree'

or something?

> Add cleanup to previous test for file that is unrequired to test the
> size of the ignored exclude file.

This description is also inaccurate. It seems to be talking about the
next test in the file ("large exclude file ignored in tree") rather than
the one it's actually changing. Worse, the next test does its own
creation of the "large" .gitignore file and also cleans it up itself,
so there seem to be no need to fix it, either.

    The test 'symlinks not respected in-tree' creates a 'subdir'
    directory and 'subdir/.gitignore' symlink, but only removes the
    top-level '.gitignore' file in its cleanup.

    Add 'subdir' to the test_when_finished command to ensure the
    worktree is properly cleaned up after the test.

or something, perhaps?

This patch has some disturbing characteristics.

- The subject line and commit message describe a fix for the "large
  exclude file ignored in tree" test, but the code change actually
  modifies the "symlinks not respected in-tree" test.
- The description mentions a file "unrequired to test the size", which
  doesn't logically apply to the change being made (adding a directory
  to a cleanup command in a symlink test).
- This kind of context-mixing (applying a correct fix for one test but
  attributing it to a neighboring one) is a common pattern in LLM
  outputs.

Is this generated with LLM sent without any sanity-checking by a
human?

> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index db8bde280e..18e048ee8c 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -946,7 +946,7 @@ test_expect_success SYMLINKS 'symlinks respected in info/exclude' '
>  '
>  
>  test_expect_success SYMLINKS 'symlinks not respected in-tree' '
> -	test_when_finished "rm .gitignore" &&
> +	test_when_finished "rm -rf subdir .gitignore" &&
>  	ln -s ignore .gitignore &&
>  	mkdir subdir &&
>  	ln -s ignore subdir/.gitignore &&
