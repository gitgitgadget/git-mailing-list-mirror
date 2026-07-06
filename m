Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B094949FD
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319062; cv=none; b=aUXadirD6yk5qWoOgjBbAp5hUEMM1+Nt03BfNLZtrv0wicsw9KUdpTUtAi3RdMIJdLqt6z+2C7wJ+QdmJTn7X5fAKx750n7CJPDXNeRraoZFNq9bvA4x/R0HoOvxr5RFVojEHUfpbDSORv8YP0rc6VT4nTwCnabGGhUZXSgWZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319062; c=relaxed/simple;
	bh=Qrsfy1ePgmKQCOgbavgQ/xUZoprC67F3D0Qsdcitg0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3OGo4M328IILb/qMQNir/Zkm18XqwjoGgmkpFWVhb/lUaI1TIsRddOkJOZZf8O47i+8uHAv//1gMgnjF7hOXimjmojxF0rNn3rrjGVWwxWtr+p8gFp9cRuAYDJ2kGRwEsLHoEZMAA3Pp7PXg3i1ie9VG+4EI2B6LfpDhkaiEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QLSJ3leK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3gKp61f; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QLSJ3leK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3gKp61f"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6024C7A00EA;
	Mon,  6 Jul 2026 02:24:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 02:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319053;
	 x=1783405453; bh=pCM7U7wlbHjuewBLjleiDe7QptB+x61P80rVHOUn+tQ=; b=
	QLSJ3leKufHWsq6BJAxRzAcZBDkPuu41iUZBfJKp9m9us6Ye5Te3nMmZd9SKLAV4
	DyVl8NXTgjKjt6SSfXJZxJ4sWcQNMh6k5uCPAo7vq60o+fHec5EOwX0gzddo9tl2
	dav5dgMeeqQxFXmBcICux57ZVqXM1SedreuDLMUkBmXXnQL44OrRjekAPjICbTQv
	iKEH53XkynXe0B+W8v2caXVAeDYuVR+g+Wd/vojh4R7p4kxfWxyVg3MZZHxvEL7G
	MWGpkvt5d3YNQdSNHvk2yz5Bm+q0Eoj4lJH0RLTEQUxAVlIcU8heryBC73r+VVH+
	Es2O8lkGUqrlm6zMfO9g6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319053; x=
	1783405453; bh=pCM7U7wlbHjuewBLjleiDe7QptB+x61P80rVHOUn+tQ=; b=C
	3gKp61fwlrpmla2r07k8Ll3nuNsSuY9HzMzJitpSd7bsHXwjk+YIVCzr5BNinH/u
	hL8wcnlCgWEz3PD0EUs4l2wGEhFuqg2v4ywIEbquZqxHMQsWIrOpJKBAAZd09kbE
	Imn1wEEg/Jvos8vFEZIauaipQesNFnUyKzGUBNBfyk3aSaDfwrvDtO/lDuli7kG5
	aYkmCJNLWkqB5+ZyZdOMxvygEkblpXaFIMrG59/XZJPx5dpVU33PtLnVnRcdL+rO
	bafySy2nWSOQ23t3La56mzH4zIfXcC/fo3UNc8bg343BsXfbgAofarKnS7mxoXdi
	oG0QoDRnkzP4KLcs1jEwQ==
X-ME-Sender: <xms:DUpLas0ZcbpGItGjQZAOUuaUv9nsFYp8SR0iWQbjgJE4Q5bSIwICkg>
    <xme:DUpLat8Qf6lpuPijJ770VfuqeATYP6TuOWxR2IXptN_W6q_VH40loB5apPSJH_yRB
    ekqGJWIoHcPjaXo9YSFP8fQZDDZm7QmxWoNsF2uREarskVOhNhMXC0>
X-ME-Received: <xmr:DUpLatMb6eb6B410rYLpSJOAWtSTEeCp1FELKrOrA8uoql2MrMq0N_awElsdB3Fw5_uDBW3_Sf9X2ocqyz8nIGnX3pNMrtcx0y0pwjZZ8Ys>
X-ME-Proxy-Cause: dmFkZTF17AfV6XO0usBmc86SAi5z6HQuck7ySRe0CZv4Tr7ef2D3PyPjdsrtHyrohmH5LM
    8PibOrmJdKU+XpIRahlbOkv4t5RR+XfuSuX6lZMmabUVlOs7MlOrLXE/cLabyZc4Fv+zCv
    BpnvpqVjroE/BWbCWz3ZnipN08RC+nXAfSKIpH46VmGPJGbn5G+g3EkcTy7SZTmmR7Elgf
    IeX4m8AzzXy51WFxCzkp1N1kUJyuoz9WBD5Vq7HYK4I3wDyTPuKmMzn5wzekCvdmdVDSpk
    Fz5kiu5pS0lXX9SFGHy76iVY3USPY4dYFkeLQPYVWekcah4ZWrnUhCll2DXoPQGKbW7VVE
    PBVm0zXDVq4PNiY/hGtgUESetYMaQkBPoDBjpP7j1udM8D7M4vT7tRTqRcSV0HD/uY1KuQ
    /5oR+H/ADyi8H6ld+e9mYkoRXME0SJ2hPLHB3lHHoV/kMvGePQoeEQRFzw9YFRa8wwyeMI
    Sd5XtEamgQ0AMXDm/mhEWQhek2JyQEppYfzHljmt0D7kzF+eX+qCznr7v14hRLUyHnQNoU
    CfEdSKAKS0m2+mmcSLfX6/wuP9+pzr8pxSnte4SQtrFwYeonPpZv/X6NtJ0bnse1Nzpbtf
    rEz/mHLrIqzz17PzqE3TENM9//FpMkoJf3Exk4OD7ot6E2h8odWBbaWqyv7Q
X-ME-Proxy: <xmx:DUpLaheVZeaUXyzzLZ8Wpd_fIhe8v8JPJM8tHlSfQueXNG6kXwiIxA>
    <xmx:DUpLasXhfPXVfhu2NSZy-7sO6Y5h5pEdch_XmpaPiMGIUMP_85Jxwg>
    <xmx:DUpLaph4m7R77povsdkWjevqurO230hurF_PbOe7iWwLgXFj1gbelA>
    <xmx:DUpLar8w5OayyBuq_OGZu1G5uv77Ix8liu2Wp4khdBy8LwijiTE0DA>
    <xmx:DUpLai506XfrYthFjgyqMRmB6WCRPdf5Z9ypgJYg5-bZ6cenr5oy7BZ7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b10f7448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:23:59 +0200
Subject: [PATCH v3 4/9] t5608: reduce maximum disk usage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-4-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
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

