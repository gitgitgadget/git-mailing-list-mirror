Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE892E040D
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359824; cv=none; b=JUcaqi+dTZ31uL8YEZZrx2ZBuMsZweCjBMpcswWQnhGmFjLH0ni8dLDS62nTDZXw1wZ8CS6SOerL99mXby/e3Z1j6kfMJ8B+csY870CwcKnMaRkn+qrFMPlQMdl5t3RZrwmaL9zbXgNwBPFkABRNlvlZAMIk/mugioHdAbtVdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359824; c=relaxed/simple;
	bh=/ylOcjp04IZwKVHpRUdxg2ozK5RLjZJ+kKvLT4Lq8l4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GnAKXKrCjfBjQkYdoIulq4ENZh/wS0w6AUq1SvQuN6O7t024Rse5nhoc6Hw8SltFE1K9d06oJ8dv5r3+Qf8i0DhJBbTdxCgLCGt7P7aphplaxoPdz49Cf9gi45Ehcj7qWSDD4h6vowj96Ymh7AWjbTOKI4KfY9q1HmlVtvc3T28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtCCR+1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xjGtjczI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtCCR+1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xjGtjczI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 73173EC01D7;
	Tue, 24 Mar 2026 09:43:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 24 Mar 2026 09:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774359822;
	 x=1774446222; bh=fmW8Hve4/FmqsWoGrLR2UhQkBAbvzdSfZVe8TUJV/es=; b=
	QtCCR+1GO+t6trL+RjgenvntluZIQY+Juku63yp0HkWFr6F9BE0CtXE8T6WH9ydK
	S/iBYTcW6EakaLF+ObZZ1aQS7xdc4LpDX4trdCeSCZJN+FGzRYg+RM9bT4Aqqu1G
	YFuqxdxuu67/62cfSBs+I6Le3kukMLm4EkgsUP5YHy8bZI638TN+nfMS0OX7kQWm
	dLREJVLQ8n43R2d5haAP/q54i0xFVKnPxCBvwJ6kWHgqW0hRSAoaCLKhEXip4lnO
	dhdkc4kyzL80wRHA2XfpSz1d/XngTkpMNwmwubX+m5jOnmLBsItjrjtyRwPE61j2
	HDxfiXd1AhoKv8EaZrzOAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774359822; x=
	1774446222; bh=fmW8Hve4/FmqsWoGrLR2UhQkBAbvzdSfZVe8TUJV/es=; b=x
	jGtjczIEYRlMcPTsT9NrsOVtZ1HzMu/v0OG/vaZ7dhGZMCo+FvA4qn32NuxUsOZS
	ytvcf96nlg6fUdqTNWQxAkQVPzGpQolOL90ChmSosYm97LP/HoxiqanETty59oUS
	uBaQNPfVYbHi9RIpd3J4anOln/0HDERUGniQpf3Vs9umfnKYnSlS8uzpgUv+ZgTu
	64dtQorAKG8pCX5x3TLPjbD2ODJgln9ELaZPZmDffIfwMZ893cEDZoLf4ikVOMWR
	NXGG/KVo+L2+ELlIKv9VuwOhm+JmpvsfaZ2gMT8mooMrFNeY7UhtfVK9vxYZxpS7
	AsOoRFdEPQiUmEdg1ylZg==
X-ME-Sender: <xms:DpXCaQkBYVofZXK2DKqJFbdVAqXSdjkRc9QicZGH9shUh_FQa3DFuQ>
    <xme:DpXCaW1HtseC82oEM5294aqPSgWqyftL2lYO6byZUHH3p7ILN4thgkeAmJ65bRXoL
    FUdVPEz0tzfv-Kw3uHP09Nl_HCwy1Hhqh5f3Hq8uqVv-JEQwIrAZg>
X-ME-Received: <xmr:DpXCaTplLpkEJNameGgNYgGOtnd4XRF2wAG_qoJdasD4LrW3JlfH7sMAvsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddujeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufhfffgjkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeeikeduudegffeiuddugeefgf
    eltdejudetveeuuefhiefftdefleegjeefvedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigv
    shhhuggrghgrleelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DpXCabdDS16nOPZ026pHl_EC3EXA9tot1hZSNswBDz_nrrt3LbSkxg>
    <xmx:DpXCaap015BEKq853zC6awHTmfwGkrSpsBotHtNM8C0Gju_MCOAuZQ>
    <xmx:DpXCaUG224X_YwbMR519kGU7-OBxtQMDHwCJDipVR3_LTUKSRcYg9A>
    <xmx:DpXCaSsTIk5AF4_PqLtLjlqQty6HkMT-Z5KlgY70wmR_isQyB91FkQ>
    <xmx:DpXCafKXVPom6GuTlKMxxm4oJscZQ8kbHJbra3oPBn7lV3Vbvgqyq0H6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 09:43:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: jayesh0104 <jayeshdaga99@gmail.com>
Cc: git@vger.kernel.org,  a3205153416@gmail.com
Subject: Re: [PATCH v3] t/pack-refs-tests: use test_path_is_missing
References: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com>
	<20260324044619.43944-1-jayeshdaga99@gmail.com>
Date: Tue, 24 Mar 2026 06:43:38 -0700
In-Reply-To: <20260324044619.43944-1-jayeshdaga99@gmail.com> (jayesh's message
	of "Tue, 24 Mar 2026 04:46:19 +0000")
Message-ID: <87jyv1jqb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

jayesh0104 <jayeshdaga99@gmail.com> writes:

> Replace the raw file existence check:
>
>     ! test -f .git/refs/heads/f
>
> with the Git test helper:
>
>     test_path_is_missing .git/refs/heads/f
>
> This aligns the test with Git’s testing conventions and avoids
> direct use of shell test constructs.

That makes it sound like "avoiding direct use" is a goal on its own.
Adhering to the conventions is good, but the ultimate reason is
something else, isn't it?

> v3:
> - Fix commit message to accurately describe the change

The above two lines plus a blank line should come below the three
dash line ...

> Signed-off-by: jayesh0104 <jayeshdaga99@gmail.com>
> ---

... and placed here.  After getting committed, "git log" readers
are not interested in learning how many wrong turns you took or what
mistake you made until you finally got to an acceptable patch.

The name of the game is to pretend as if you were a perfect
developer ;-).

>  t/pack-refs-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> index 2fdaccb6c7..4a85d96c6b 100644
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
>  test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
>  	git branch f &&
>  	git ${pack_refs} --all --prune &&
> -	! test -f .git/refs/heads/f
> +	test_path_is_missing .git/refs/heads/f
>  '
>  
>  test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
