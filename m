Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA18158DAC
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611916; cv=none; b=E8Cx/9mroM8ghwD3QDchepaiBhmImmGI78rl4mX77r0xCFJ23+YmJI03tZgTT46xK0xNDoHGIEfzXbit8fLwXJHMKe3kuPpZfgvD2CU695jwplplqb06Rvul39opxnH7+pQwj7HLoD/2ecwWweC6N6I6VMCmrFKzvbzyq90d/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611916; c=relaxed/simple;
	bh=BNhvF5eEH7BRcR8gVBCedlqmtY91m86lO11T1b33Bps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZrOg+7km26px0Vaac3usPzJSQnkVLxZCGXXW/fq0B2VhD7YLa1afwrKfVGRWFZ/WR+yL+8Z3WFDIVIlQofauLQdZNQ1euTOAD5ak5ttk4cpAysE02SuZQ7T+tVdfnH7NCjUZ1z33lOulbWlDMePCEwvT/p32/C6HqYfEGSasKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T74ZDw8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1IFot3r; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T74ZDw8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1IFot3r"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F7E21140104;
	Fri, 30 May 2025 09:31:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 09:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611913;
	 x=1748698313; bh=KNXor1CfcJlh63VOnH8fLU5gv2Y4Ujge1F7nb2ENgc0=; b=
	T74ZDw8e7yY06iDSXFcuAImdRKgdBmQpVICOvv3OQPkf0rWJxxeJtjyqXiJMYGwL
	JDWshu781E79jtue38nAXRLjczmw5wJgdjuGbij/WolhK2ukAjXsouj4CSEZrST9
	SY3AQ/FpstWYjJ+lHWrGNgx0uA5RkemP8ikun1A/zKmlI1jj1JCWqDs9Zkollgpd
	CjGh8XvnRFgxhztiOf9/4z7aOpOQQP5ujJF2bdYdAWuImj4hhEfsBfSV5fPY4cc3
	UGfECQWFy0zwjOYnBCkS7pfk5VLP+6HudVzmeJihyVcNs5/tg2ZD1tH3oFqgr33L
	EOeE0c0knZhb+UMPHSBZTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611913; x=
	1748698313; bh=KNXor1CfcJlh63VOnH8fLU5gv2Y4Ujge1F7nb2ENgc0=; b=i
	1IFot3r0d7275aYSSc48L6AwU0m1hzgA3uSLyUpq4pcI5VGkFyh9SM3wjd6NpC+j
	1uE9MIlc/mZSIkEY0uppakyPB1edj89c0cS0H7hPd86gP3GyUnuQv+nZV1gXVsKb
	2PezS72dS9pwZmiS7r+lNqVr/tqEQrMP8aLFZEkovCXbfvDdxaDT5YOoFUkHCNrX
	ApsVGLANlJwmzy++MNAmSVyRHq00dWiNrOkKysON1ae9UUx1slANR+iLeI2A7N5z
	zKiDMDqLQILp+e9Id5j+iHu5tgNqFkJVl+gQA1BVN56BzuPfREgrFJVijhvYqeBz
	h9tFo0VYz+TWeCv1S/r6Q==
X-ME-Sender: <xms:SbM5aOp4cQvnAN3Aid75s75zlp7tkm2HvJRZVmjjEgZCLiFsXYRJlg>
    <xme:SbM5aMrToH2cC3uBnqUUNiRonW9bQb5XXwhxsd4gkvhx60xIaD6kibUaN09DlPSiM
    hdeBCkQBHrv9s7zSQ>
X-ME-Received: <xmr:SbM5aDMBWl1PvlJQJ0_ffSObRZzGuV8KgIlS8H1DO82oHB_oYuGyv-lkj7B169WF06jiVmS63zr1toWDKwuuKMBFPcok45uQd34MrkwQig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthho
    ohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgr
    mhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:SbM5aN7ATTaMH8y8UVOgHhG9E9g_gzbefR3BwtANWBD17c2ibq4EUw>
    <xmx:SbM5aN5WTodHtgjZ7HOa3yhMCqswbxB07dAik9Ep0wbwBR9mZxEmzQ>
    <xmx:SbM5aNgM9RfbxYnJo7uiwyv60mtQ71PLxJC7DySWgpoSOMjff8QZqg>
    <xmx:SbM5aH4ZnvZFKBbtHMly0YjNkV5BiPIxnmxB5i4yO5x6MS-LRu3EZw>
    <xmx:SbM5aEOmsW4E0mW1X5ZOCLg0dVtYyxJZ9_vczdQrC4SXC9h94Iv86I05>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f21e306f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:42 +0200
Subject: [PATCH v3 04/10] t983*: use prereq to check for Python-specific
 git-b4(1) support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-4-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

The tests in t9835 and t9836 verify that git-b4(1) works with both
Python 2 and 3, respectively. To determine whether we have those Python
versions in the first place we create a wrapper script that directly
executes the git-b4(1) script with `python2` or `python3` binaries. We
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

