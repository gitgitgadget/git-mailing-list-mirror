Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1D38C41C
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258403; cv=none; b=s3rmpBz44j1LOO0uVr1KNjFKzxh95dJdh4qKsq9yGlkRAm73Juii+oZVKKb66k/GZ66tOux7blU5r6oI22k3KiO3OAGh/0L7r3eaWdhfABM4PsJZePrCZV4MHOoT2+w2WM1P0DVcLjll4M81mxxubV1S8eVrtYYVqEJAGqxfE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258403; c=relaxed/simple;
	bh=YXT7/poVCz51SQ52IQLErSmPA1zRE6DtveYVXQBFA0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuaU27gxXMtFVt4kc5gejh0boOPcrnOOB/SmMq0wxvUi+YEFP11XrFxkpq1KnruZ+bEwc/XZpdmmmkHMaghB5zgRWyB/m+lnO6LYrUGu1y8uMWgR4CNKDeXexhhPUNZ2yfCI5xGObU6D7kmJdUFaMMlYKYi8/41BZWgDEGdmJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BqSVfAnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZErLDUG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BqSVfAnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZErLDUG"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 14E4CEC0295;
	Wed, 15 Apr 2026 09:06:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 15 Apr 2026 09:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258401;
	 x=1776344801; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=
	BqSVfAnz3FLIUmY5ILrErDLM4lq5SiFId9dg2wWen9BvEZc+7tg2b80KlLqPi+KM
	4D5ZJXNQvsZdVEUqtHrhQEjMlJYAGiC//rP1ExKjbwMI7EYC0gmbqR0LRUrbqFsO
	oggZUdaCmwFx8LBOYPyUvtNqN9qX9Rdiedfv88exSKYvdQ1gk6LdjfdSFk/YjdVM
	ZlHaf9Ngy580hD3wr9Ss99pMpRahjkf4Nom9IwuJNd1OHFSK6E60e2fR+pk/k1d4
	+dik0Xl+6aTnGzlpug3q9xXpn3O/Wkl8haWqygBA9+xdM42P4YN8xXNGxoMTwjrJ
	RrVjd8Yl6I6o/WlUnfyBNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258401; x=
	1776344801; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=M
	ZErLDUGWopemVsvX5ZG+oAwOWz88xqAGUuByzf/csTiGf2leKJP0MeTAniEZ8yHx
	D9ik2Nc3lSu1lNRwXwXQDp4CqGyKKE/OLBqmulxgYwD35Wqu0lA7RJQRQr/yF+fx
	SRHjbpD2jEr5v6UQFkZIYQId2dzx8pKZ+3Ec/fm3LA25Fw5Zy9o3PDuI16O42Ejq
	vKe/FKuvytXqIndGYNp+bBOqd6TI4N854eYVFljgZNNOyAL1Hc8dB5fxmvWecjSm
	WKYHL5dlBpsureUid+kULZfC66ptb03YmCmVC5sMYnHgt78upt8tZuIWHzRnefmF
	0Fiqsz74iB+/vPV8v51jw==
X-ME-Sender: <xms:YI3faSslIGZiWMrIB4a020crtCsS97bpqjrcimLBaxlw5qGJc1t7gg>
    <xme:YI3fae5sipy6_Wcgrgo-nfEP6JORG10QpHgsEuEZBj0abYGQuLeW-h-iRZ-A_yFqL
    oDpgmWhBZSyt7qoMihKc_RSbUqpIj7rNN6CdXHiEadZ9wxrtHA9fA>
X-ME-Received: <xmr:YI3fabI9tAju8CqUUaT_AsidEKaZ8MU331jQ_Byp-SVn30Mj5XRQF067XsBBnMlOrxOa-fg2oWfbWYlwgZRi_5ufY7qZXl0r2dl_U_0yc8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YI3faW60Dsk1_IWz-ObYF45tJGnLLcpOCZvjDGVUK1us2ogxkDjgdg>
    <xmx:YI3faWwiJ_UO2gGydzuUSiIDIt3t8Oy7F4bCvoW3k0HEakO18pgDBg>
    <xmx:YI3faSYxuPgjk2Ym7k8Dg6QPyNtt92dyHrts4Vt4o02dZw6EJknZyg>
    <xmx:YI3faQQbcBMkQsmeqDcp6Pk4yytSu7vnIGBnF48mFXz4UMl_AmqjtA>
    <xmx:YY3fafqLHpm-YVTQoXf45S3Ko4MkRT3UinCfHEnHj6IUp092VopTZ0MX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 252bc19c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:34 +0200
Subject: [PATCH v2 01/12] t: prepare `test_match_signal ()` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-1-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

We have a couple of calls to `test_match_signal ()` where we execute a
Git command and expect it to die with a specific signal. These calls
will essentially execute the process in a subshell via `foo; echo $?`,
but as we expect `foo` to fail this will cause the overall subshell to
fail once we `set -e`.

Fix this issue by using `foo && echo 0 || echo $?` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0005-signals.sh | 4 ++--
 t/t3600-rm.sh      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index afba0fc3fc..84319cf169 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,12 +42,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 1f16e6b522..a371ea690e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

