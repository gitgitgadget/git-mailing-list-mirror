Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A319D8B2
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846700; cv=none; b=V4735na6r9O7+a9n9+Z+q2UNY6UsPajJetVYIyi3T9P68NpwILUmLf6g77J2wTU6V3a53zXHEKY3n6SBe5g5SZJVDax5L+60/MK20KWLOlUAAtncE/9JLrrXxkgjWGR3rO/Lq1RuxWIDwAZULsh31Y0DzRc42g/yWqxwOkeoXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846700; c=relaxed/simple;
	bh=3jmXJ1MBcjvLv06y8/5WmeAVnR3/Gn6IU219+nS1n/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNLu/4Go51iJ6lt7f1bvrXDszKwm0oQfjV7ygK0ZNvNfpAmYT7J3XsaSczRwnO5tsVQp30TxTglMKovQjOFluSzKgd8JOEwgWaUMoy2G5u0l/N7ANO6k9WuJ/UbC8gAW83oo4Q9z9u7htDOd1c2sxj3EJ4TMKRT/jD/XBhE3OIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MouAD1vp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eI7NOEva; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MouAD1vp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eI7NOEva"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7593725400B4;
	Mon,  2 Jun 2025 02:44:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Jun 2025 02:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846697;
	 x=1748933097; bh=qXamG5VC/Pu2y5UA13TD85X6arRtrUOYNr47ZqiD3xw=; b=
	MouAD1vpJlp7BvS6pIOvXZ7uOXJcrq5J9wLVjQv8R+9bKABFNhUzj/iDV+YJGs3Q
	L6Gs54AiVDK4QtwuXsrtmQ9UlfNGpdYQU3CEMseAmz/ENg/5/q08Gm3ggwekscR3
	ONMDntQMspRuEEETyjGl3fYsmWhRKj8tnve5EjrZN2s5/9R/G423bRpTw7GaSc4Z
	TLYq++nnFjgb1fS0IItcnP0hRC4TsUqnrHkUEDbMPfZrPZxNeq+Kx2etxOm/2pZo
	BfHCwydvdecA0oN3N17b7EFCW+tjl75QaOL1Gp4tuJbzui0Z5oeDFud6Kwid/DB0
	7MIEWPvO/8XNIY5GaW9ZNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846697; x=
	1748933097; bh=qXamG5VC/Pu2y5UA13TD85X6arRtrUOYNr47ZqiD3xw=; b=e
	I7NOEvaqdX7CO3zm/U4SWQVmUYXaRJ+gG5CxInFeF97zkTheb0GktEuupoKoj3ql
	jOhr8VS5n8xkOYfUp/Vpiydt7qyO9WWGqFllyEZwh/vOm6JljmljluOTN96NEXgl
	rHEUXMBDunfo4nzwLjIvLESEkBWVeXQgVoiOPDh8GKPJHj5eRCqJ/IuSgRzhR35g
	GVjaZSXEghEk3wZEsRgoUe3Sbx4l0xssCXctBr67Hpa9cyobywICSoCZ3w++8zfA
	MOkS49bugTQlf3/0/Y1KkjRGFG5N4/4go1r5RKn+xT0R/RADI+ldN1xX2o/4Grmz
	MaF2D5UJNly/EIb4LmoTg==
X-ME-Sender: <xms:aUg9aIsVXaJQvzeTpcVhZj67KHHZqTYBum0-y_QL5BIk8RH2Yzfzmg>
    <xme:aUg9aFcqF3GQIserH0sO801stwHU3_hp2j5C1c6pl8bTKdjRmQYye4uSayrZvt1sl
    jHpGZZ-2VHPPWKDrQ>
X-ME-Received: <xmr:aUg9aDyJe2jyJMNvIadT7p0ZKI0op0CR0FH3GZjbI18ClV77SWRXPxLR2D6mwpAnfAjzYKst2tlWBLS_QB2GLSHKc19FHSt_f-8RjdKSdaliJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    gvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrg
    hmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:aUg9aLPCGEpqZKwtDnTQXePZSh6fxCCYUD9iRoDCUfS3nmYHydiVWg>
    <xmx:aUg9aI98v74iChnaaKgjSeBpQIJ_aHzcHpR_9jxhHwsoGs2UfUC7yQ>
    <xmx:aUg9aDUfK5jSz_nsL3dktej0EvjY421pAov6ONDPyWMY9Sf_fVtYCQ>
    <xmx:aUg9aBd537UJUJ3AyRUuVlVpULahW-_XiPaCMBQVcp5YYGjseUs54Q>
    <xmx:aUg9aKR69O2yVyp4Kqdxpm_WtoKj6bwf7ic--Jei4mrm-0OKMnQolcjX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8de214a0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:44 +0200
Subject: [PATCH v4 04/10] t983*: use prereq to check for Python-specific
 git-p4(1) support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-4-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

The tests in t9835 and t9836 verify that git-p4(1) works with both
Python 2 and 3, respectively. To determine whether we have those Python
versions in the first place we create a wrapper script that directly
executes the git-p4(1) script with `python2` or `python3` binaries. We
then condition the execution of tests on whether that wrapper script can
be executed successfully.

The logic that does all of this is not contained in a prerequisite block
though, so the output it generates causes us to break the TAP format.
Refactor the logic to use `test_lazy_prereq()` to fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9835-git-p4-metadata-encoding-python2.sh | 24 +++++++++++++-----------
 t/t9836-git-p4-metadata-encoding-python3.sh | 24 +++++++++++++-----------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
index 6116f806f63..b969c7e0d5a 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -12,23 +12,25 @@ failing, and produces maximally sane output in git.'
 ## SECTION REPEATED IN t9836 ##
 ###############################
 
+EXTRA_PATH="$(pwd)/temp_python"
+mkdir "$EXTRA_PATH"
+PATH="$EXTRA_PATH:$PATH"
+export PATH
+
 # These tests are specific to Python 2. Write a custom script that executes
 # git-p4 directly with the Python 2 interpreter to ensure that we use that
 # version even if Git was compiled with Python 3.
-python_target_binary=$(which python2)
-if test -n "$python_target_binary"
-then
-	mkdir temp_python
-	PATH="$(pwd)/temp_python:$PATH"
-	export PATH
-
-	write_script temp_python/git-p4-python2 <<-EOF
+test_lazy_prereq P4_PYTHON2 '
+	python_target_binary=$(which python2) &&
+	test -n "$python_target_binary" &&
+	write_script "$EXTRA_PATH"/git-p4-python2 <<-EOF &&
 	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
 	EOF
-fi
+	( git p4-python2 || true ) >err &&
+	test_grep "valid commands" err
+'
 
-git p4-python2 >err
-if ! grep 'valid commands' err
+if ! test_have_prereq P4_PYTHON2
 then
 	skip_all="skipping python2 git p4 tests; python2 not available"
 	test_done
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-metadata-encoding-python3.sh
index 5e5217a66b4..da6669bf711 100755
--- a/t/t9836-git-p4-metadata-encoding-python3.sh
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -12,23 +12,25 @@ failing, and produces maximally sane output in git.'
 ## SECTION REPEATED IN t9835 ##
 ###############################
 
+EXTRA_PATH="$(pwd)/temp_python"
+mkdir "$EXTRA_PATH"
+PATH="$EXTRA_PATH:$PATH"
+export PATH
+
 # These tests are specific to Python 3. Write a custom script that executes
 # git-p4 directly with the Python 3 interpreter to ensure that we use that
 # version even if Git was compiled with Python 2.
-python_target_binary=$(which python3)
-if test -n "$python_target_binary"
-then
-	mkdir temp_python
-	PATH="$(pwd)/temp_python:$PATH"
-	export PATH
-
-	write_script temp_python/git-p4-python3 <<-EOF
+test_lazy_prereq P4_PYTHON3 '
+	python_target_binary=$(which python3) &&
+	test -n "$python_target_binary" &&
+	write_script "$EXTRA_PATH"/git-p4-python3 <<-EOF &&
 	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
 	EOF
-fi
+	( git p4-python3 || true ) >err &&
+	test_grep "valid commands" err
+'
 
-git p4-python3 >err
-if ! grep 'valid commands' err
+if ! test_have_prereq P4_PYTHON3
 then
 	skip_all="skipping python3 git p4 tests; python3 not available"
 	test_done

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

