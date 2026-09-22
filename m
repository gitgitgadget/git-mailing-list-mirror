Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165B4B95D3
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108539; cv=none; b=lMNWQ2wLvtgfPR6j9ZA7GfnXW+3mPAZur2LOdTOJZCdI8FDY9dNxyWIi0lZk50Br2Noyf5CMQ0g0LP8XLja8BeelIpJimUArL3YXhfy8GALseY2h1Bv8FIRju9hT9Vcbc9gdihZBYahPBRJqMp47ls+wiqmJNiFKMK6MweygXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108539; c=relaxed/simple;
	bh=LlYA6ELcbLcqWZrlRIvTjm+ForHhOpZo+jJ1fp0Yne0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KamY1aRNGzvb3ErhPoOOpaK3pfXVA0CXI0UyM96TuDAht2ghqHQAGryQB52Cwfv4227/6mgirvmO0TYbXqXWPSCDw1l/IRxseDMQLX1PD/0GM5jePVtRp3YJtAbnKFpS7ULIrMg3EVCLHXsdjmQslWCkscHN96mmEfGT4jbZaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HRKoQpNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fz5yqRLz; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HRKoQpNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fz5yqRLz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 59C6113000EB;
	Tue, 22 Sep 2026 16:21:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 22 Sep 2026 16:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790108518; x=
	1790112118; bh=aF4dZw5/rgaulb0TFhB/6s0WjsDnnkO2hH+iq8z7ag8=; b=H
	RKoQpNFm32iymlu3gcCLBvxmJkdqNnTRV95T6EqQJbnVQVyQsUwtWbgf4Ujg/sPl
	hGQNjmn1Qz8L5HLF41GIIS+wIdV+MU18yK7HFOHKHedJaHjZ+G0DN/NHu3mf5QlK
	svchvJwW52usfSCKyBxgpNZDqY9IHq93zKfnsAa16YWCkptAmkXqb5Drz8DXCwuZ
	+mV/d+YAqlmJtWrVFaag67NMkSISFfHWwxiHL4Z3yvcu/k9wbrxVHSB5nno7F/TP
	Yw45MIqB9DYjUyOoiwkBL1zoXKXFs1sJau4qh9IbV87OOwc58+veWbWtnkoHnA/W
	Bio/vRTgfzO/0Wh3NRzqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790108518; x=1790112118; bh=a
	F4dZw5/rgaulb0TFhB/6s0WjsDnnkO2hH+iq8z7ag8=; b=fz5yqRLzFW7K+D4Aw
	eI6uHZH+cRJvCsxmnr9b7jrUsLM3E6QcYIIet2QfSJ7cFn/12e+8FoW3Ta3w0peU
	r4R0W2K4atvqfmLw4+Fs9zdcLe/L5vTddPsLFa6y0ev1CHpNqUVaG9TfTKzzcsye
	ls9gGZlHl8K/wBjEabJshDve5HTdV2EWMw6mPS9WhoF+Gkel4LtD+Z2x9HhutqPr
	x49mfKJSVLLWMRL8rrH1LW1r0YSQz81T8E/v4TlX6DqTuJGsvM9DbLXH4o09QK82
	8fDTtulCHF1n1fHRLJRwc9hTajp7bF1WNW1N65yUPamQnCyaUeb5XkfgQCRjc8ec
	GRDnA==
X-ME-Sender: <xms:ZeOyatyWAYwG0nXHLp_1sHAO38yHKNHv8v0WmPZldZYz5cGNjfkTLg>
    <xme:ZeOyajSDmr22k_IWF3GVNlj5l5MT_OecjwzspdCkh8jx8XDLiak96mlfp8KrcBpru
    QrjFpzR646uldomnIXt58MudD0OeN30qLBNsnobMDF5jHxNBMyPqrVw>
X-ME-Received: <xmr:ZeOyak-L48xDND6lw3ykCHqfnIbGZxFYr2oUJ2-gE3lH-RE65gmFxp33dNwnIyacYspH7SvCpCPff64g7SmuBRHxbhrNF8OKsVZlib1FTs9J1g>
X-ME-Proxy-Cause: dmFkZTGCYogreECxIvFvsaYuJwFw9zKXvYK/3LuFDw1I6XScytqA3DmIYi28PuUsLEdtBi
    DkuyipRnWjlzPZ5XdPDeK4dLAIz/MHdOVl/S7PUdtAa9+u9ElbebxHhsmqa5ir+bcMnOrG
    MTYZ0MpAsdVc2p4ShIvC5H6Vm6trk/af9xTcLbMvIgaHZQEyn7c6zL79tYTTpzL4W//0Wa
    0ykV/A4EwZvgPXX80OVtok5Lm15DK7Ay6gGv4KUWxANL0/0uj/ASF4+DO7CaNBziVaFL1Y
    QEqkD/oe2jWozyA54GCEgYdUIKePAvSGu5VfOyaagqjSRvQ/Me6amtB5o4d0pMLchUe0aK
    vB2d/7r9YVf9baecAXM4kqkh5NmAqAcYtMCbATXm+9lIC58pWGWFWia+FkdsxzTriw6CQO
    ydWVHZ1KIP4abpwYfOPXRtV8ZtNKX+LfKNKCMOkkMKMRtj3Ywa9k8B7kKFIHfljMUHsgRf
    uIagyHd5XnmIrkSamCi0o9YgO4HuS8V8y09W4ZocTwCP0Phw8LRvfoURwP/7O0oLnj3JYX
    OQejSQNB8o+SqDe6OBSv7exjOJ4my+AfcvxJpMph0+WuNCgUDtqlNm//wNNHc2zZwZxRTD
    sx/L7RFanLr84f8JeZoSI+b+3gl3/FmdzyjtQx/71EXVimuVsj86UWZrFVgA
X-ME-Proxy: <xmx:ZeOyaqqTucKg3JHK_I2qKo7ZfVhpncaehtfXCRfD1bfdw-LgYdlcmQ>
    <xmx:ZeOyahkZLRrG37w7Vgrx5YHU9DKemsWBIYhHWtY0ePEFK3PfzIgfBA>
    <xmx:ZeOyahIRZBimQ6ee8VHJXED5-DTuki-pDPRYxJPhl-4Jr98pXQQdvQ>
    <xmx:ZeOyamwjHn6jlDA9oeoRIQm7gmqWtWbR8Nl2xsfFbQZIShs3zOlYDQ>
    <xmx:ZeOyaqunLXz_1Xnlf3YE-6JfijdQctm7S9vMTKB_y6vst-bPlb6GWSc6>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 16:21:57 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v6 2/3] t4009: modernize
Date: Tue, 22 Sep 2026 16:21:51 -0400
Message-ID: <20260922202152.842793-3-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922202152.842793-1-markchucarroll@fastmail.com>
References: <20260922202152.842793-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old tests were written in a different style than modern
ones; for better readability and test error messages,
update t4009 to the modern style.

* run everything inside of a test_expect_success block.
* write title line on the same line as test_expect_success,
  end that line with a single quote that opens the body of the test,
  and end the test with a single quote that closes the body.
* write expected output of a test to a file named "expect",
  and actual output to a file named "actual".
* write here-docs using "<<-" syntax, so that they're indented
  uniformly with the rest of the test.
* make test names more clearly reflect the functionality that
  they test.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4009-diff-rename-4.sh | 142 +++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 74 deletions(-)

diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 59e71e3acd..e42891ee5a 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -10,68 +10,64 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    'prepare reference tree' \
-    'COPYING_test_data >COPYING &&
-     echo frotz >rezrov &&
-    git update-index --add COPYING rezrov &&
-    orig=$(git hash-object COPYING) &&
-    tree=$(git write-tree) &&
-    echo $tree'
-
-test_expect_success \
-    'prepare work tree' \
-    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
-    rm -f COPYING &&
-    c1=$(git hash-object COPYING.1) &&
-    c2=$(git hash-object COPYING.2) &&
-    git update-index --add --remove COPYING COPYING.?'
-
-# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
-# both are slightly edited, and unchanged rezrov.  We say COPYING.1
-# and COPYING.2 are based on COPYING, and do not say anything about
-# rezrov.
-
-git diff-index -z -C $tree >current
-
-cat >expected <<EOF
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-:100644 100644 $orig $c2 R1234
-COPYING
-COPYING.2
-EOF
-
-test_expect_success \
-    'validate output from rename/copy detection (#1)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'setup' '
+	# prepare reference tree
+	COPYING_test_data >COPYING &&
+	echo frotz >rezrov &&
+	git update-index --add COPYING rezrov &&
+	orig=$(git hash-object COPYING) &&
+	tree=$(git write-tree) &&
+	echo $tree &&
+	# prepare work tree
+	sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+	sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
+	rm -f COPYING &&
+	c1=$(git hash-object COPYING.1) &&
+	c2=$(git hash-object COPYING.2) &&
+	git update-index --add --remove COPYING COPYING.?
+'
+
+test_expect_success 'validate output from rename/copy detection (#1)' '
+	# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
+	# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+	# and COPYING.2 are based on COPYING, and do not say anything about
+	# rezrov.
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	:100644 100644 $orig $c2 R1234
+	COPYING
+	COPYING.2
+	EOF
+
+	git diff-index -z -C $tree >actual &&
+	compare_diff_raw_z actual expect
+'
 
 ################################################################
 
-test_expect_success \
-    'prepare work tree again' \
-    'mv COPYING.2 COPYING &&
-     git update-index --add --remove COPYING COPYING.1 COPYING.2'
-
-# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
-# both are slightly edited, and unchanged rezrov.  We say COPYING.1
-# is based on COPYING and COPYING is still there, and do not say anything
-# about rezrov.
-
-git diff-index -z -C $tree >current
-cat >expected <<EOF
-:100644 100644 $orig $c2 M
-COPYING
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-EOF
-
-test_expect_success \
-    'validate output from rename/copy detection (#2)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#2)' '
+	# prepare work tree again
+	mv COPYING.2 COPYING &&
+	git update-index --add --remove COPYING COPYING.1 COPYING.2 &&
+
+	# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
+	# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+	# is based on COPYING and COPYING is still there, and do not say anything
+	# about rezrov.
+
+	git diff-index -z -C $tree >actual &&
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c2 M
+	COPYING
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	EOF
+
+	compare_diff_raw_z actual expect
+'
 
 ################################################################
 
@@ -80,20 +76,18 @@ test_expect_success \
 # anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
-test_expect_success \
-    'prepare work tree once again' \
-    'COPYING_test_data >COPYING &&
-     git update-index --add --remove COPYING COPYING.1'
-
-git diff-index -z -C --find-copies-harder $tree >current
-cat >expected <<EOF
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-EOF
-
-test_expect_success \
-    'validate output from rename/copy detection (#3)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#3)' '
+	# prepare work tree once again
+	COPYING_test_data >COPYING &&
+	git update-index --add --remove COPYING COPYING.1 &&
+	git diff-index -z -C --find-copies-harder $tree >actual &&
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	EOF
+
+	compare_diff_raw_z actual expect
+'
 
 test_done
-- 
2.53.0

