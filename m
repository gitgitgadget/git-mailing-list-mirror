Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4348A2A9
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993677; cv=none; b=k9rTQiy87yJvnd5EvXYAEuJRps9Kqra4JfaKYCaNm+0SpbpEBrUgO2/ca9A1pP0Mx43xy4uMOkesD+gR2kdoyzbdKtM4ocb3t4KeFP9HKOZp6QJz4IkVjMaEDltxBebeYT9/T4B/+es8q2MtvM6m6bGr/ly4xD128bjdPJYKHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993677; c=relaxed/simple;
	bh=Qrsfy1ePgmKQCOgbavgQ/xUZoprC67F3D0Qsdcitg0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EddMm4a7z5zOszMgdjaH1K1PtWOA+K16v2NPBF6MTVkdMi6RhXfFfQ+bwqEngqF+R43pYVc33oZTNvxBc2fe2QRdU4NbZlnPCzfuYShp3kqe7cxQTT+TAK4aDe648mzHsivcN1TmQ9v/wY/eEFdDbyeGXChxl8DkMeNZOKe/r4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xk0uEoGg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIZd2/MX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xk0uEoGg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIZd2/MX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 39FDA1D000D7;
	Thu,  2 Jul 2026 08:01:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Jul 2026 08:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993675;
	 x=1783080075; bh=pCM7U7wlbHjuewBLjleiDe7QptB+x61P80rVHOUn+tQ=; b=
	Xk0uEoGgNWHrZC3Rz/L8xRXGdYOZspTSBjbW9H8XroEuQaaR7aLRYCAnnkVz7dCI
	Sm9LXXaHM5I2hMUv3Zv8YEJzBCS50Fn6H8kKQvGu39xquhyArQlKg1bHfQsPV5zy
	B8RTqKqcvjvaikbbhJ2IBN0D2QRAKOTmOrjJCcnAl37IxU79xCJinu3J92aKqvRk
	MQJAiKwshDEOzmOUWxczhcvvQrPaLZZvUpufWxIWQ6BNkRt1iOZGM9BQisVFVnX9
	i9LdH4Af5WlUKM3yvqgvaAWjoe+hzpwH+EsouizVAvgV4ESxDVF3BokpZzuG9NWx
	1cSv5QXrfntYgfcbpzMEeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993675; x=
	1783080075; bh=pCM7U7wlbHjuewBLjleiDe7QptB+x61P80rVHOUn+tQ=; b=k
	IZd2/MXqqRqmeNKildyhEHpvHlwlsebtEhJhXRJeyuzxAYkZwTviYuRw88WH5S0V
	p2k8RvtGplQjDdjeaDBa4zEY2n3uRRR6f7TKCPTEsGrOKSFvwCb2SWcyUlutNcI8
	gwm3yR2ELxLCsvQ41h6XkgvDH4aYMScSCh48DpqcL49rswDKdRUuqI/SlotQqaX8
	5qBSqLfJHwM3uO3vGp0ukS1pKGFcVrX9U+4Xu+xVpe5z0VHSjyiOJiembXHbg9m1
	Ga+9XwnbQKWWwi3iid0T3A6Sta2ZOQpG9Y0LIrjL5b8GP6fA5F0vc+srZOeOfcjJ
	8gXExkCzTEZ2cr4xkgMPg==
X-ME-Sender: <xms:ClNGak4rQjE6tnvkNpnUsdxaD_A1cJ_1WiN03ECail6hL7z3_U518A>
    <xme:ClNGatV7zq2ACpTZpPc7pOBL_Q97xSci-U3i4Ygjc-iRn7JqLTB1-Mdo3dur3hwwf
    T3p0xGmCMUfveYBMmHh4l7Gh6v6gfAlghnk6G_dSCmmvRVLE5O4TWA>
X-ME-Received: <xmr:ClNGag0gBpf3-mrPyU0TETsNVaYxGyJXEoZDghsreG8R6ZiQ0mwo0tmW84dy3N6vD0OXjjKAXC611t7mD3JgMsCaODwd_4GNWdsX8utE9GiwQQ>
X-ME-Proxy-Cause: dmFkZTFKRuGr2hRzAUTsckBDbUzmc2CIqUaKpOWIZ6wUBUu0Y2LdUAvzpfBRYhpwJV6Dfc
    eiq+yJFbLd6v2Rlsjf1A0euRr17015Z8LnyBc1fz65oQ0IvLLbU67Dk7nE4RF7Y6DZZVJf
    RsagJppKHa7bHZxeNENN0gXkX9DBmOFMYk4hi6Jx9WE4n75BlGOeF4OvIDq5xRIdSZXi29
    4aiTr1nV8FERMNK8lCzvAG03/SjxmyrpQy818avaEyF/K9oFXhmo2c9vVhYUQXr5cE+Ek+
    eNv/0ikIjBxtEvFjMJv20MGxngdR3//vh9MSU9Q6RsU+Px2iCcW9sUSbFunLIrJs0JHOt7
    Y44TLu/rAUgYehWxq9lerk6sF3KnSK22kjuiQKCNgyq80UnIaiiJyiGGRm8iVeT7xgewUl
    TaCb700JXau/YcFr7tu4DMsyBkVxoMP1G/CjGaJq4zZW3vQl42Wc7Ov6eqj5SDAan/VAph
    JEpT75mAkr51eT5oG4dqdZlGyKkqInORBLh9A7aU7RVlGgiDj2IDBQhFSiAO3RzjmSToAM
    9pzqwWkIavfvL7PyVYl51udG/RJWtirO6BA5ThC5OwyPnB+tOo+5S39w3bInnW2GtqKK55
    NRQ4Dhf0VmllaR3vm9qQJYnxmOQ74WcaVCEWPBzVTyb1VpvyWd40IW3NlJiQ
X-ME-Proxy: <xmx:ClNGai3XLYnT05bCsUwrRSFklTuvVjV81IxXPTHbfU7Q1fRfChlqNg>
    <xmx:ClNGar-HtGUO2L5JOQFln7YY4QVFCQglVUPHIqWNVbfe0S5BNynX3A>
    <xmx:ClNGan3neFB8TFPjCfN8C0QdGsT8uIQdEKOgxo3OJrNwW3_wR4FrbA>
    <xmx:ClNGag_ogx674E-6oZqyQPkkTncmDbLNiymFAy6JNkoXP5Xk8Tn7eg>
    <xmx:C1NGaj5xGp4G1zhXgIAEloDKs86W5aHBMUk8yoq9MNIzg4_1oTiYClNp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f6ab6f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:00:57 +0200
Subject: [PATCH 4/9] t5608: reduce maximum disk usage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-4-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

