Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF202F3C26
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162844; cv=none; b=Jaif4sxix6Fx2l5PAz4sd/ovh578v99UFju0aE/ajZ/JETT4Txf+VX0buy4Y67DlcMYrV2GkXILl3pHgjnQCdCNtYqgSONwjKJDDXZJsmcINs6cPOBsUej725RZyhYSJ4JBpXeVCOGhGrJEQPeoTtoGi7pieDLiGJ/oRJquiSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162844; c=relaxed/simple;
	bh=5bKlR60e6gzTnVoiBm6qm6Ld0hlq6010pZGDAdhqGOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ib89qiepnl1fuOdj+8AlT8U2tsmtOD78zmvTpj3xSW2MznKT0qzB1fUr2r+npStMHpwXt3GSzYmRLWHLAVMCoTTS3FLwvrNInEQ86USFvYkuxQ0aoeILDtXmxGUuvlXGnZxw1OcPUNOx1Ak+uRZFFdXcaErrjdW0eBiax1t22dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dAVr3lPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BsI1ApeI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAVr3lPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BsI1ApeI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA80614001CD;
	Wed, 22 Oct 2025 15:54:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 15:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761162840; x=1761249240; bh=m+S9v07Z67
	kkd9AT0A0FSsuoN3iJpCuTDiNezlejIRU=; b=dAVr3lPgAyNGHyg0Kg1e+9CDHp
	v2yW27/eqBNV31CRwWc6Q/luP0HRALh4/XemohJHcW9cwH3miSmkEaBRDmD01mjX
	6RYG4/rb4YXTqJIeTG94/fbLCk2A4hL0tC2SV143f003hJK7xyOLNqmyTpKuKFF+
	K3nS1IL2aef9T7OLVPkkfI6t31ZDfMH3N67eF/ROtJbsRwQ1vWBG7TUyyWSphL6a
	aH/iIdP0I9Ehdll/A0p2qNCRdb4TjUjKSp1UM0ITmZVOA0JqelNgnX4+rj+5JiF+
	xYEGvQqiIeGLNS0fpxGB91QSfkP8srvGFG9KwAi7SF0776VkJ3M5k/LOS/mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761162840; x=1761249240; bh=m+S9v07Z67kkd9AT0A0FSsuoN3iJpCuTDiN
	ezlejIRU=; b=BsI1ApeIvAzgnqLcK1j4bQPMLy5w1XqnSfLDGuASsJ9/a3WQjmo
	99u4h6I+8Fr6lNTg2gZmxkCKUoxxt/MEYx+DBwjauRRupZFkfGGmM+Zi1Csx+Bt/
	Lf94KkIfAQUkZ2tzs0ANlpUzx5+tWi+EKMl8k/hYM7455gxEbZZF8T6nni1jg/aP
	iAkJnPehECZb/Lfbf2GEtXdgLNdE+dXILzq2k4TnLukmSwxIpx2fTbeFAGd5PGRC
	5NMIuF7Z0ZmDlnznRSNlVBjsEWTLP/z08Vv0jAE1h8OLkCafXu1vAga1DU6Wdr8L
	5kAmdnuxV6gy/3ZUfHuISEHfOEqXQ8aHtFA==
X-ME-Sender: <xms:WDb5aEFa--3rQVNnBB3yPejdP8Fhzp3a6_0DmkJQcY8r3mz_EBu67A>
    <xme:WDb5aPnX1bezy8vG8nC46W_bTMtGb6H5Dol50w_-YbteqAS5V3KBWWALw9p5Tj1wl
    khNYOu1omLS_0CZjQCDdYwC2Mpnvgj8hIFhm599mWdh_soGnUzAQg>
X-ME-Received: <xmr:WDb5aAaH5liABbofWNmdRpxQS1FrXqJekXkdJJsK7xRZto74BZzGccjlE-TAO4FNgifajVIKXXCCxDYPiAkdDt7xzmmfVxIh901t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gvpdhrtghpthhtohepjhgrkhgvseiiihhmmhgvrhhmrghnrdhiohdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:WDb5aMFPrjNrB_ERRrXCM373uFx-lWZ-MlnQKF1R3xlzfURyNhxrGQ>
    <xmx:WDb5aJIvgMjgB6RIUxQq1q2jCV0zfUwxonifI1nBwTecQGZlCvrD7g>
    <xmx:WDb5aPPMNlKogU4jWGJ5C28k2s-jKXlOFEz1KkjCE_Zefav08poqFQ>
    <xmx:WDb5aBnxVVsFFPAeYG6TWZbxfZwozBbxBMgMMdcUdDOml80e9nScmg>
    <xmx:WDb5aCKdqA4uOwMWNCoz6CzsEoHEwkIWF3QFi94N8DESXT1PWoGNQsyf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 15:54:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org,
  Johannes.Schindelin@gmx.de,  jake@zimmerman.io,  peff@peff.net
Subject: Re: [PATCH v4] diff: stop output garbled message in dry run mode
In-Reply-To: <20251019163024.18939-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Mon, 20 Oct 2025 00:30:24 +0800")
References: <20251018094823.31173-1-yldhome2d2@gmail.com>
	<20251019163024.18939-1-yldhome2d2@gmail.com>
Date: Wed, 22 Oct 2025 12:53:58 -0700
Message-ID: <xmqqms5iyap5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> +test_expect_success 'diff -I<regex>: ignore all content changes' '
> +	test_when_finished "git rm -f file1 file2 file3" &&
> +	: >file1 &&
> +	git add file1 &&
> +	: >file2 &&
> +	git add file2 &&
> +	: >file3 &&
> +	git add file3 &&
> +
> +	rm -f file1 file2 &&
> +	mkdir file2 &&
> +	echo "A" >file3 &&
> +	A_hash=$(git hash-object -w file3) &&
> +	echo "B" >file3 &&
> +	B_hash=$(git hash-object -w file3) &&
> +	cat <<-EOF | git update-index --index-info &&
> +	100644 $A_hash 1	file3
> +	100644 $B_hash 2	file3
> +	EOF
> +
> +	test_diff_no_content_changes () {
> +		git diff $1 --ignore-blank-lines -I".*" >actual &&
> +		test_line_count = 3 actual &&
> +		test_grep "file1" actual &&
> +		test_grep "file2" actual &&
> +		test_grep "file3" actual &&

I am puzzled by this part of the new test.

> +		test_grep ! "diff --git" actual

The "test_grep !" is to make sure we do not leak the "patch" output
run in diff_flush_patch_quietly(), which is understandable, but in
the new world order that even raw, name-only, and name-status honor
"diff-from-contents" since b55e6d36 (diff: ensure consistent diff
behavior with ignore options, 2025-08-08), shouldn't we expect empty
"actual" that does not say file1/file2/file3 in it?

> +	} &&
> +	test_diff_no_content_changes "--raw" &&
> +	test_diff_no_content_changes "--name-only" &&
> +	test_diff_no_content_changes "--name-status" &&
> +
> +	: >actual &&
> +	test_must_fail git diff --quiet -I".*" >actual &&
> +	test_must_be_empty actual
> +'
> +
>  # check_prefix <patch> <src> <dst>
>  # check only lines with paths to avoid dependency on exact oid/contents
>  check_prefix () {
