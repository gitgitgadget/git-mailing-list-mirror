Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA10182B4
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564187; cv=none; b=hPU12yAOG9VgBlXH6BYt0D2EkXcAojrQdSUbgH9pnkahNJnRiyGmswbW/y5WYs/ZFyR3TiLF8F4jaQuU1fc0Nz1VpqrlggaoaSxXQ9OLcLQYzXAgvPa2Gj1orXXCnDigO6+qqeb8ygqesG513pS0IlIAJYsjfocVQarsAThab6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564187; c=relaxed/simple;
	bh=pljnWVpzU2u50I8hSC8w0jcote0JTitpYt6RB63fsKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ZgHomSEOCS1Z9P8atjm2W9XJ2ZGaGh7xBi3kkgvMF1Tt93rqToMrjqtIgucLfoDi9Sy2wtyQlPJDujSrPdeZ5OxqNShDHxyOxF9BnoSQL1+WygRsyin/gY6jzL0YEDkaNto7ktwPinCfYamjN55Gwm4IoesQ2FS1bz+KP3qnokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WlyhIpXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijp1j1uB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WlyhIpXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijp1j1uB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F53A1140173;
	Mon,  3 Feb 2025 01:29:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 01:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564184;
	 x=1738650584; bh=UFjIgOBfiYDqyaX8f0WOZ5XtOqCuJlVz74AMbLVmuB8=; b=
	WlyhIpXh37R0kgfvETfV8m+qf7pHBd0vrArfE/i+DCqki13PrP3i/wAeqrx9OD/B
	ivjXoPPWybzN+e2iqEJ6EjjlaY/FGwL4zNHsa8hqvzaeOPOql0oVQIfCHrgrVt+P
	uHL6shUQGvg1pDQsXkwYjCJGoURvDNV7YCmtioIhlc1iKvvO50mGJYxxPVr2AWB9
	En+6y09kVKyCoMy4wsXE00vqJpTw7VOmf1U38iHiD8M5tftwElsuMuW9Bnh0P+3C
	ixVHNk0Ao0CgnjhQUEbL0+luufmgEIOsMdnFMktQevbytf93vseCCW/64VhOJFto
	ZqEF2ydZ59qLnMk7zJg4yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564184; x=
	1738650584; bh=UFjIgOBfiYDqyaX8f0WOZ5XtOqCuJlVz74AMbLVmuB8=; b=i
	jp1j1uBnWnpQQ5lhOIsdpxmD0tMYUdnyROM3iu/RdXrP+QChlSeW7xDMy60pXt3s
	vFOzGIT72udp+wLdbm2wRSlGGn2pDAHY7Z14idXRYVXgXhV+isljq0n9Hfcw6GWw
	YyTR4d3PuoZB4pymy7um+k87RfJFHicF9cHA2iIX+FAyiGkr+bjhFI28Ltf/BGh/
	HshD34AggB8CcOpJpFBDaN+jIA1MRPbDlg+XTeaz+v08gSsPRdJleJTbzz7QW0zn
	9Cp7fy5CVI25a7SHwdYToVxyfSPxvCGIGPt3OqFFJKZtBzOG8Fs1gd95pVNgXWta
	KVxi0komxmjKoR7g9owMQ==
X-ME-Sender: <xms:WGKgZ3VcRE2dMrhQ8D4j6RDaOzr81RUXz913kFj0fVGeuJtZg2ijiQ>
    <xme:WGKgZ_mX_kqcBbsSqNd-OopcaG304b-LE_RMXnrp1zWMDRyaurW0z10Eu47_efXif
    _5iwamXxwNH-J-vXg>
X-ME-Received: <xmr:WGKgZzbD3KniL_wZqISUtIu4slH9H_8qwPdhQ5oN3AoiQv4ORnDUvTGETpzM7mizhDUJEfApIywf-uh8W6aeAjOFh5smBG8HX6Ke61KihzPfoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdeh
    fefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdr
    tghomh
X-ME-Proxy: <xmx:WGKgZyUODbmOSCuDgdod3xAmeDUK7uoKRRnIlcKthPniQcss9BKgtQ>
    <xmx:WGKgZxkIpOHtNXOrNy0T3vx8GnjgvzMqMRoMGf1sq6ZajCW4jlY46g>
    <xmx:WGKgZ_eEEBjHAdFu_tARPB38YobWbjfYti9ep2tq0GDyYpeCBzEV-A>
    <xmx:WGKgZ7EY0E4D1eOVzw97g-mAeJYhkAJXEs_TWK8izvAU2xWjYmfJug>
    <xmx:WGKgZ6Csrz3GxJbf3jtQ4pk5DLChJ8I_Ys-4N0cmlxKEuwmJ6Xh_1tYE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3663fb3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/8] transport: don't ignore git-receive-pack(1) exit
 code on atomic push
Date: Mon, 03 Feb 2025 07:29:30 +0100
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtioGcC/5WPQW6DMBBFrxJ53bE82JjQVe5RdWHMEKZtMLIJI
 o24exyUVuouXf6R3hu9q0gUmZJ43V1FpJkThyGP8mUnfO+GIwG3eYtCFQYRNYyfCcZz6sFN4cQ
 eIqWR/AS08AQ+tARGW2+MdrasWpE9Y6SOl+3H23vePacpxMv2csb79T/2GUFBVduyU0hVZ+iQG
 ckncVfPxabzYaYosdJola5rlEee5HfPl3CWH8vBfXHjGgc8eOnDg9R/Sb3XyqB6hjQ/CaVCjc8
 kmJzg9o3B3OBsZX8T1nW9AVNb41+SAQAA
X-Change-ID: 20241113-pks-push-atomic-respect-exit-code-436c443a657d
In-Reply-To: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Hi,

we've hit an edge case at GitLab where an atomic push will not notice an
error when git-receive-pack(1) updates the refs, but otherwise fails
with a non-zero exit code. The push would be successful and no error
would be printed even though some things have gone wrong on the remote
side.

As promised last week, I've now adopted the patch series from Jiang Xin
to make some progress on the issue. The series is now based on the
latest master branch at 3b0d05c4a7 (The fifth batch, 2025-01-29).

Changes in v4:
  - Rewrite the commit that adds two new tests for `--porcelain`.
    Previously, the commit both reordered existing tests and added new
    ones, which made it hard to see what actually changed. The reorder
    wasn't necessary though, so I've adapted it to only add new tests
    now.
  - Fix the URL prefix in t5548 to also work on Windows.
  - Document why it's fine to start ignoring the return value of
    `git_transport_push()`.
  - Improve comments to document behaviour better.
  - Link to v3: https://lore.kernel.org/r/cover.1733830410.git.zhiyou.jx@alibaba-inc.com

Changes in v5:
  - Escape heredocs where possible.
  - Link to v4: https://lore.kernel.org/r/20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im

Thanks!

Patrick

---
Jiang Xin (5):
      t5548: refactor to reuse setup_upstream() function
      t5548: refactor test cases by resetting upstream
      t5548: add porcelain push test cases for dry-run mode
      send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
      send-pack: gracefully close the connection for atomic push

Patrick Steinhardt (3):
      t5504: modernize test by moving heredocs into test bodies
      t5548: add new porcelain test cases
      t5543: atomic push reports exit code failure

 send-pack.c                     |  10 +-
 send-pack.h                     |  13 ++
 t/t5504-fetch-receive-strict.sh |  35 ++--
 t/t5543-atomic-push.sh          |  30 +++
 t/t5548-push-porcelain.sh       | 443 ++++++++++++++++++++++++++++++----------
 transport.c                     |  17 +-
 6 files changed, 406 insertions(+), 142 deletions(-)

Range-diff versus v4:

1:  ef3732a280 ! 1:  2d04ec6ca3 t5504: modernize test by moving heredocs into test bodies
    @@ t/t5504-fetch-receive-strict.sh: test_expect_success 'push without strict' '
      		git config fetch.fsckobjects false &&
      		git config transfer.fsckobjects false
      	) &&
    -+	cat >exp <<-EOF &&
    ++	cat >exp <<-\EOF &&
     +	To dst
     +	!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
     +	Done
    @@ t/t5504-fetch-receive-strict.sh: test_expect_success 'push with receive.fsckobje
      		git config receive.fsckobjects true &&
      		git config transfer.fsckobjects false
      	) &&
    -+	cat >exp <<-EOF &&
    ++	cat >exp <<-\EOF &&
     +	To dst
     +	!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
     +	EOF
2:  c4a57bf457 ! 2:  31c8b10e7d t5548: refactor to reuse setup_upstream() function
    @@ t/t5548-push-porcelain.sh: format_and_save_expect () {
     +	if test $# -ne 1
     +	then
     +		BUG "location of upstream repository is not provided"
    -+	fi &&
    -+	# Assign the first argument to the variable upstream;
    -+	# we will use it in the subsequent test cases.
    ++	fi
     +	upstream="$1"
     +
      	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
3:  67928693cc ! 3:  a8de197677 t5548: refactor test cases by resetting upstream
    @@ Commit message
     
      ## t/t5548-push-porcelain.sh ##
     @@ t/t5548-push-porcelain.sh: setup_upstream_and_workbench () {
    - 	# we will use it in the subsequent test cases.
    + 	fi
      	upstream="$1"
      
     -	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
4:  6e0f0f791f ! 4:  9e4f3be9e0 t5548: add new porcelain test cases
    @@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
     +			baz \
     +			next >out &&
     +		make_user_friendly_and_stable_output <out >actual &&
    -+		format_and_save_expect <<-EOF &&
    ++		format_and_save_expect <<-\EOF &&
     +		> To <URL/of/upstream.git>
     +		> =	refs/heads/baz:refs/heads/baz	[up to date]
     +		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
    @@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
     +			baz \
     +			next >out &&
     +		make_user_friendly_and_stable_output <out >actual &&
    -+		format_and_save_expect <<-EOF &&
    ++		format_and_save_expect <<-\EOF &&
     +		> To <URL/of/upstream.git>
     +		> =	refs/heads/baz:refs/heads/baz	[up to date]
     +		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
5:  cb985baec9 = 5:  093b50d785 t5548: add porcelain push test cases for dry-run mode
6:  68ae698e4b = 6:  9a1851f06e send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
7:  525cefd4f2 = 7:  e789913922 t5543: atomic push reports exit code failure
8:  19cdbf991f = 8:  52101a1f14 send-pack: gracefully close the connection for atomic push

---
base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
change-id: 20241113-pks-push-atomic-respect-exit-code-436c443a657d

