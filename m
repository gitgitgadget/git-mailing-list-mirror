Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D63B27E9
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070670; cv=none; b=JOS8IT6f78p0YQUINupDgNIIxYi9Aegfv1XYm2a1sD0gJ6JH/4h7O7ZuEp71OipHlsoq0UUiizitZucbDi1bmiaFX9+vqfmdwZNGZR9nXtB1s8AE5VumlbdGwU/rlWuOes1Yplu2k0v9HBXNEZI909F43M8n8+9CzVxVpWum0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070670; c=relaxed/simple;
	bh=Qrsfy1ePgmKQCOgbavgQ/xUZoprC67F3D0Qsdcitg0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnuc2+5abJvmsYKorjhSEP3urJLdTrO+Ns7MO1MD5NwvEia7Q30LLElNQT0nUR6kHWp/ZQN7qMIZ1PooJNWesnC+QWFvo0aXZFfFjkhDal//8cKVbWypfjGhlWZfTj1+MGB1qn9JRxB1D55aFmydzgaaNeOqj5h4Tt3PBPXDvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OcFqxsle; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2xMOqIT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OcFqxsle";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2xMOqIT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5441F7A00D8;
	Fri,  3 Jul 2026 05:24:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 03 Jul 2026 05:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070666;
	 x=1783157066; bh=pCM7U7wlbHjuewBLjleiDe7QptB+x61P80rVHOUn+tQ=; b=
	OcFqxsle55GbG2f93qOhE7JVuIgXmQN7xhKfvHw4n1adXXAlaPOerlJm+Y+JWqCD
	4XntJuh8zevwDx2nvXcOABbKeLDGmYMHnOCheQtPtwtreZY1uilkIr+I7IUvCRc0
	36Tf0bjlkTPTnMzwVGvX0UBV/0mNxZZcXpJKUoRvlgeFtM9MtAt6lOiok9/2GV6g
	S5I2AcbxeIUvJJ5ZiGqYNl7pZeuHqJ261jhIoeV++ctFBc9XQoMaXOkHOr/qkgzQ
	0C/j4zYpP/XNZZbv679bC9EX2BpEffBoDTJi0thV999kEDW9EgpubeKvbfpzWfXQ
	87wugQiAeuA0NFwajgdUSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070666; x=
	1783157066; bh=pCM7U7wlbHjuewBLjleiDe7QptB+x61P80rVHOUn+tQ=; b=P
	2xMOqIT9YSFWX04iTxsaHSTApXIhUeofvOLdkF+hhDVW1NhiAEm22lOciqM2+b6m
	rwNHz9AejFHd8eiVHrFbvbZ4S8Ne5neoDAkGM22lZUx0tpgP2niaDNNjob2k/eSl
	7wAau3lBtqsdcjOPgmS1xA0mbik3JAhDMrUdvK+So/oMZJGyQBQP9qChoua7Pham
	IQv2w6Rn8uLbbQ55KiDcGhZ0fouznHW37WUDr0MCpk33iv7jcOqKpvV20xZ/vaB3
	rNMQanBQnOqrNSWsXU1u3xoj0KKl1APCM86TCkZhLwNQJHpB9b6JxPa7p0WFchKf
	og9XR+5fYNSj0WRiOyxQA==
X-ME-Sender: <xms:yn9Haqy-Bv9vNHQGMIdxVz7fq3UYTFCt5BSBHqYtYIcOn48OJugk5Q>
    <xme:yn9HatKd6q5YD8FArp95C0iB0WP8dtBR1PYIK6oFAIaXVH2hEt3Gams0phGj8Px3r
    wzY0gSM2rtH9A8pGgjy1aJPFtfz04PP-XWVr563R0ohYw69Zyui>
X-ME-Received: <xmr:yn9HakpxWoAX4qquiyKAs2mAzfWPrKA4-htXLtZSg3CF7-KH7ng0CXleBDNqCNq-q_VVkyT8ZY-jioQ3ohaAA3VwVNs0GdbczE9mwDGsSw>
X-ME-Proxy-Cause: dmFkZTFyyNOLAcshjgVd4Q9FXxgzHw2qDJRjTUAvWuBVqYeS1MyOxkL1QG5dKt9VZ/5NYc
    LnChgBFugEjGNqn1M8WPg94Dc3uINRvg43BZwl++VXe4wBnviUmQAV55q1lqyY9KsfTWOT
    vGnCMyKHWZhdXHRc6KF2/qw/OHM8tMLo8xwsMTBUhdu77axrQwlpo28CdcSR8ec97pwpz6
    u/JJAK0kDrcUWeg06bvhiU0v8M+S5R10ar79laPC3mAo21ViXFcg6s9vmJ8olk8ZCnRmMh
    jfE6JFlQiz7KvvXg/RGPKn9nii0HX0eSWP/VtECnLrjd8vAPtPbSwyN8LUX5ySsC9mnTKH
    Q7M/ofJGZr76K3i1os3bWztZYzAIWkDwE9BBAK/czwNk5/EohAxz07tNDngK3b0tqk6tkC
    4AiGbIqwcue8AG6xYqxmpuyISc8KfvCDu37gbTK5TEIKfgczI0IFFHMgvrmeeJx/Zz6hCB
    csZWZkCUg9DSO9UALb8olnWY/pyOOm1AE+cV4pV20wJx/umlJBN14Y0JtEOhO9JbsZR3ol
    O+XlWceMN2eBh23ZAnmglejdAMro9nkL1hiPMnhQ611Qok/l41n9p9qWZQxSWrQtwZt4Kv
    j7ahGFMLtKq1V/6sBPvmAK0gbs5p23Hm8XHj8v0fgSNj5U14L3Yr0thYd/Hg
X-ME-Proxy: <xmx:yn9HasLiIwrqZ0uvqSVI95FvRpi-6Lr8qsNhE9mdrR6KziV61-3BRQ>
    <xmx:yn9HapSV7wpwtPyQpuIX3d-0-fylFl9yb3-cp_zNszImk58WSo_REA>
    <xmx:yn9HarsB0ih7k0dyHmP2AA1cvRxBDonkMpdONWxQxfRrXcLOB45ofg>
    <xmx:yn9HaqYGlidHTpYU4dYMGJwAYha8O-eByPbA1Vl3OhXdD_xu-J7b8Q>
    <xmx:yn9Haj1yRvph9t4dhdc6mHlaEWxXfQZwPlLssSgl8UmIx498uMFAF1xk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62c6a393 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:07 +0200
Subject: [PATCH v2 4/9] t5608: reduce maximum disk usage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-4-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

The tests in t5608 perform a couple of clones of repositories that are
somewhat large. Ultimately, we end up creating:

  - A setup repository that contains 2GB of uncompressed pack data.

  - A bare clone that contains the same 2GB of data.

  - A clone with worktree writes a 2GB packfile and a 2GB worktree.

  - A second setup repository that contains a 4GB packfile.

  - Two 4GB clone of that repository.

Some of these clones ultimately hardlink files, which ensures that we at
least don't end up with more than 20GB of data. But at the end of the
test we still have around 16GB of data, which is only a tiny bit better.

Refactor the test to prune repositories after they have no use anymore.
This reduced the peak disk usage of this test to 8GB.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5608-clone-2gb.sh | 66 ++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 4f8a95ddda..5d56debf1c 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -10,45 +10,47 @@ then
 fi
 
 test_expect_success 'setup' '
-
-	git config pack.compression 0 &&
-	git config pack.depth 0 &&
-	blobsize=$((100*1024*1024)) &&
-	blobcount=$((2*1024*1024*1024/$blobsize+1)) &&
-	i=1 &&
-	(while test $i -le $blobcount
-	 do
-		printf "Generating blob $i/$blobcount\r" >&2 &&
-		printf "blob\nmark :$i\ndata $blobsize\n" &&
-		#test-tool genrandom $i $blobsize &&
-		printf "%-${blobsize}s" $i &&
-		echo "M 100644 :$i $i" >> commit &&
-		i=$(($i+1)) ||
-		echo $? > exit-status
-	 done &&
-	 echo "commit refs/heads/main" &&
-	 echo "author A U Thor <author@email.com> 123456789 +0000" &&
-	 echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
-	 echo "data 5" &&
-	 echo ">2gb" &&
-	 cat commit) |
-	git fast-import --big-file-threshold=2 &&
-	test ! -f exit-status
-
+	git init 2gb-repo &&
+	(
+		cd 2gb-repo &&
+		git config pack.compression 0 &&
+		git config pack.depth 0 &&
+		blobsize=$((100*1024*1024)) &&
+		blobcount=$((2*1024*1024*1024/$blobsize+1)) &&
+		i=1 &&
+		(while test $i -le $blobcount
+		 do
+			printf "Generating blob $i/$blobcount\r" >&2 &&
+			printf "blob\nmark :$i\ndata $blobsize\n" &&
+			#test-tool genrandom $i $blobsize &&
+			printf "%-${blobsize}s" $i &&
+			echo "M 100644 :$i $i" >> commit &&
+			i=$(($i+1)) ||
+			echo $? > exit-status
+		 done &&
+		 echo "commit refs/heads/main" &&
+		 echo "author A U Thor <author@email.com> 123456789 +0000" &&
+		 echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
+		 echo "data 5" &&
+		 echo ">2gb" &&
+		 cat commit) |
+		git fast-import --big-file-threshold=2 &&
+		test ! -f exit-status
+	)
 '
 
 test_expect_success 'clone - bare' '
-
-	git clone --bare --no-hardlinks . clone-bare
-
+	test_when_finished rm -rf clone-bare &&
+	git clone --bare --no-hardlinks 2gb-repo clone-bare
 '
 
 test_expect_success 'clone - with worktree, file:// protocol' '
-
-	git clone "file://$(pwd)" clone-wt
-
+	test_when_finished rm -rf clone-wt &&
+	git clone "file://$(pwd)/2gb-repo" clone-wt
 '
 
+rm -rf 2gb-repo 2>/dev/null
+
 test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'set up repo with >4GB object' '
 	large_blob_size=$((4*1024*1024*1024+1)) &&
 	git init --bare 4gb-repo &&
@@ -61,6 +63,7 @@ test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'set up repo with >4GB object' '
 '
 
 test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone >4GB object via unpack-objects' '
+	test_when_finished rm -rf 4gb-clone-unpack &&
 	# The synthesized pack has five objects, so a large unpack limit keeps
 	# fetch-pack on the unpack-objects path.
 	git -c fetch.unpackLimit=100 clone --bare \
@@ -77,6 +80,7 @@ test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone >4GB object via unpack-obje
 '
 
 test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone with >4GB object via index-pack' '
+	test_when_finished rm -rf 4gb-clone-index &&
 	# Force fetch-pack to hand the pack to index-pack instead.
 	git -c fetch.unpackLimit=1 clone --bare \
 		"file://$(pwd)/4gb-repo" 4gb-clone-index &&

-- 
2.55.0.795.g602f6c329a.dirty

