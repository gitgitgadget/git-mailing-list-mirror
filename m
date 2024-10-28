Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1618C035
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730092507; cv=none; b=mG4jBNe2UxSW8GMXGiKWYv3TyFWQn0ds9beb26hVeIJS7N02uhYnKl4cwpD9/9dHPKm4oU1BxwJY+i9PE56vENMqf3mHHnVHcFQOsGuXtPJvT70vrYtN/ZsmdJAv2tJ5GCQjxG999I+/Q7oIPhc6fKCzjgZrvzjq4yHlboWB+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730092507; c=relaxed/simple;
	bh=Z/4qMw76+grCRJ8d/I8TkCfeO7Kw8DLRN8FazI38+LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN1yXhOyS4l5BGT2I6rnxnPi4AsAQ573bt5pABgkc2AB4U/jcQVpD/qvdg3SSMo/OyhDXrfbUsPhg6PQYFUBamgIlJFuEVnB5aCs21QNxPR+w3t4Deoe+grMvwdhnyvHhCK75fwdg4bmatZQTWhrM5ns3A2udJcAQU8AYfopwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yVijD3X9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6GAjh4W; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yVijD3X9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6GAjh4W"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 059B311400E7;
	Mon, 28 Oct 2024 01:15:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 28 Oct 2024 01:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730092502; x=1730178902; bh=Yxz9faquWF
	sj/DeEKMBuezAIsWimIQXLtWZGVw12WkU=; b=yVijD3X9NjUj6ZJL7WHDhrEMGp
	s4F8yI9sfb6J1AIe8KF+eBg296DYQ00tCv0L2RoaVGMsyE7C9G1brg5Fa6V1za3C
	inxCSmwdBpktr0EfqtuqO5HppV5sTWIU9SJNrclWU2HJwPLNqGeoQe4PD/sbs7VP
	jh1b6M6eLDg9lYou4DODmyrudcfjgmx62kROR8FWD3OjLHTbaGUWrKbg6FQWwqr2
	WSVpvAe3RDCmjIoqpQJWDJsEOW0J3Jk444zVrlEOQDXD0PwFIIEY3FjWEw36WNdd
	DNx9MxTXEYCeIQn4zqMqpzv/CCWy3CDfIT+jQAQnZesySEhI1yNS8trfLftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730092502; x=1730178902; bh=Yxz9faquWFsj/DeEKMBuezAIsWim
	IQXLtWZGVw12WkU=; b=M6GAjh4WQbiBEfYgP3U7b7YU04WM0okmCr6afqOzDvjg
	MadjziVJLr2Wa9Tngl8SvgjtktBDp7dET0XIm2iiPVIYBi1LFvYz+ZCTK39yLZXj
	Ic6IMOz3xcyd8X1lGuU5C1qOrrLv0TswISKpqSS87vxXDzRg2J4wr2Z/OzJGFu+N
	jRQFva/yjkr7Ay11FyzGDpILWqhilcMqngAwWkGUIOyxP12HWxkytdPriTb0b++s
	l+GISYUt7FBk8M0xJkqWgPxFSHSb1zcRe6R14Gkmbmgo6sg/KdRuDP4UCd2mJxk5
	A7Ez46Te/0nFZ741QslFF3gfHRhTwr4hrkUSTNbxoA==
X-ME-Sender: <xms:1h0fZ4EIVjjIKZ4U-Ns2MxchPDiYio6H6q-nyhE3q_d4G-lp52Tmrg>
    <xme:1h0fZxWhJ0UX-zRl_ypWEGgzvPAXb5Hiho80ZR-qlSWAqTE6zDaiJMhXlw6UN-YvT
    qRHn3qDULFoh_HYFQ>
X-ME-Received: <xmr:1h0fZyLMVLmPrIcoYDX4gy1EKQzmDNxl14hXTnETKd97dm13PaGuuuSmAPOYYbPvWsRfa6wcwFB5tEmmNhOWNXIhzFD8OhRJZOwo57fe3AJi5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1h0fZ6HivAhqHWV7oJbLUUHQjfBX2zFcpzxfmSih9o4i8rxxcGWurA>
    <xmx:1h0fZ-XouDIki0FwNWl4vxBp8GkYCwcxDGCMqaXQSUah6qL7201D_A>
    <xmx:1h0fZ9OD-4O_lVyFn7Jd1TfwFOIx1f2P4dhP0cglpM_pGbPr56QZIA>
    <xmx:1h0fZ11EqB2sSTiYMWMbX1CGd6tVUBxBbK8dsnZvXfXYzQGFydsGSw>
    <xmx:1h0fZ8whiU5srEWmUsCMB_3TMGotcKAjhXfzX4Hl_T114dkZSOhRfCki>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 01:15:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e60bb001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 05:14:53 +0000 (UTC)
Date: Mon, 28 Oct 2024 06:14:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t6006: fix prereq handling with `test_format ()`
Message-ID: <ccb2d7cf817a181fab8fb083bdc9f1fed4671749.1730092261.git.ps@pks.im>
References: <zod73s7j77gjj2f62clg3utxlxnclbyhjjz3yc74x7zyh35fzy@blwhzqefxyrs>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zod73s7j77gjj2f62clg3utxlxnclbyhjjz3yc74x7zyh35fzy@blwhzqefxyrs>

In df383b5842 (t/test-lib: wire up NO_ICONV prerequisite, 2024-10-16) we
have introduced a new NO_ICONV prerequisite that makes us skip tests in
case Git is not compiled with support for iconv. This change subtly
broke t6006: while the test suite still passes, some of its tests won't
execute because they run into an error.

    ./t6006-rev-list-format.sh: line 92: test_expect_%e: command not found

The broken tests use `test_format ()`, and the mentioned commit simply
prepended the new prerequisite to its arguments. But that does not work,
as the function is not aware of prereqs at all and will now treat all of
its arguments incorrectly.

Fix this by making the function aware of prereqs by accepting an
optional fourth argument. Adapt the callsites accordingly.

Reported-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Oops, good catch. @Taylor, let's maybe queue this fix on top of
ps/platform-compat-fixes, which currently sits in next.

Thanks!

Patrick

 t/t6006-rev-list-format.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 2a01a62a2f..b0ec2fe865 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -75,7 +75,7 @@ test_expect_success 'setup' '
 	git config --unset i18n.commitEncoding
 '
 
-# usage: test_format [argument...] name format_string [failure] <expected_output
+# usage: test_format [argument...] name format_string [success|failure] [prereq] <expected_output
 test_format () {
 	local args=
 	while true
@@ -89,7 +89,7 @@ test_format () {
 		esac
 	done
 	cat >expect.$1
-	test_expect_${3:-success} "format $1" "
+	test_expect_${3:-success} $4 "format $1" "
 		git rev-list $args --pretty=format:'$2' main >output.$1 &&
 		test_cmp expect.$1 output.$1
 	"
@@ -218,7 +218,7 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
 
-test_format ICONV encoding %e <<EOF
+test_format encoding %e success ICONV <<EOF
 commit $head2
 $test_encoding
 commit $head1
@@ -394,7 +394,7 @@ test_expect_success 'setup complex body' '
 	head3_short=$(git rev-parse --short $head3)
 '
 
-test_format ICONV complex-encoding %e <<EOF
+test_format complex-encoding %e success ICONV <<EOF
 commit $head3
 $test_encoding
 commit $head2
-- 
2.47.0.118.gfd3785337b.dirty

