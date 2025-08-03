Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B527EFF1
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203994; cv=none; b=F2IDzf/b3jUhwoHSHM7SnsZwZY8IIc+xKsid3Js0P3cTdr4VLNHSE0PfgjSw3//H+CUvSGr2+AWn9mHHOsbJq99ggBx+l9gg3fnJfApkFeEok8+T/qrSvEC8qGox/2A63IBi/2pf5iqH1778MX3fbkYlSEh5S/58pVZxTdWnQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203994; c=relaxed/simple;
	bh=T8wjUpdcZ3Btx9+dQuXumMNZ1choPjjbD3xx14udjHU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KskGul+dB/unrYGOP10Yc8ZflGnohL671c+8/5dQVA5xxK5ke2gOG2C+tpuFnvayjO8d/3MBk6y1Dd7EEybCqwXcQR8sIySxb3Z0XMKyGpgAGg7OcVVD5im8uFZ4pQMjmCT0doJkEszx1rs5xVfQW4DA8PnSi118JYFNFtg72Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DJ/AXFSQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdyFvIA3; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DJ/AXFSQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdyFvIA3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CA22EC1275;
	Sun,  3 Aug 2025 02:53:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 03 Aug 2025 02:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203992; x=
	1754290392; bh=9YRhfgn56AxyZc9ZxizVvaJEU4M4d2Ock21L3LajxoY=; b=D
	J/AXFSQDtHSgPYVaKoNKKnvTGligS7exbrtWhTPlUlkwWy6FE+yH8UEzOvZa3sG6
	gNPGCQhbudmJ/9PwbZ8AonsNBBphnkR013aVsWv5EAUxi6HzUSJtceZw2WAY3clc
	vmiI75L3g3uZ9HalzDB1ymoQ1aAkMAow8+zIse0ZMYDrJqMi2IKg1CVJzxZmNRGU
	nu+1YAbDsnWPy+XRvXgKiIWfBxKi1u2YH6WeKFR5uqxD25FCiIcKKcQzhkSnV0Co
	kPyH8PYrF5LONgTfc8/oceBiXyoDOpxVqZYn6zG5SIyuFTl6A3c8fDpxxDV7CJz3
	lX3RTai4QtPtXXUDq2QwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203992; x=1754290392; bh=9YRhfgn56AxyZc9ZxizVvaJEU4M4
	d2Ock21L3LajxoY=; b=MdyFvIA3Thdga3lriPDnbkCP6mucbKCLmrJ7X2nvbUc2
	kcXS/oG39ol3LK6RL6uoOzP1e4lumvoqMVpuf3rC15et61FiigkULvmFBQiqw9yR
	CxV56g7Pa1HIoeaccDsSwdTSrBYTI04xsqNY4piVwKaWdPgtbyDHLxcWcewqglFh
	Qzy8dLLwnytyHjKKiO/lyOAyuvLakoKt2bKfugqAxeOb7K9VxdwxhBvP6Oigdrnn
	y4NIuybffCZbnwu16yz3nB6RfhjJnynMeNyofoGA79FXD9PdIT8W2TuDvKJP3A3b
	vQjKPSTtA+caTc8bYgdahnx8oEQanM/SX4/DzDl9rw==
X-ME-Sender: <xms:WAePaGgMVrL89uusrSu1q69X2RDlpPQPLq1km5cJGznD6PAv09mSXg>
    <xme:WAePaHOu8RFeqHcD6lXpXN6C_R0Pos2fM7PsaPJzdllMsPnhaTSsgF73y82t9YvVf
    kaDl03qt68Bo_ZRbg>
X-ME-Received: <xmr:WAePaP7hgHqkyAeWfP_n96elJl5Zfa-UNL6b_l61MyRB4AYu6BBTgmjXllUxV0X9oEJnWrczq1w1bhX63VVFvb0s4uQzBzKVDZttGBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:WAePaN3q2HcxFFz-ohpiuunDwRoOQbcD_90kTezOMbU6MPaSU9c8RA>
    <xmx:WAePaIZ5srG0tkMnxngr4qLrI4EKjx7sR87onmYaCEIRIAaGscmE_A>
    <xmx:WAePaNDUSBn0euO23SbjHEwFUDkLVwYUNn-IqAa7tUo7FbNFW3IEWA>
    <xmx:WAePaC90x3QMUF5Iluh1SHdZVxN1mCvmB6akiCD_5IjNfXEorMp7rg>
    <xmx:WAePaBFcTTDo0WU3wXAp5AcA7SIyuwaZv6fRhRQZDhQbYDudYXb5me7D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 05/12] clean: do not use strbuf_split*() [part 2]
Date: Sat,  2 Aug 2025 23:52:57 -0700
Message-ID: <20250803065304.3325286-6-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065304.3325286-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065304.3325286-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

builtin/clean.c:filter_by_patterns_cmd() interactively reads a line
that has exclude patterns from the user and splits the line into a
list of patterns.  It uses the strbuf_split() so that each split
piece can then trimmed.

There is no need to use strbuf anymore, thanks to the recent
enhancement to string_list_split*() family that allows us to trim
the pieces split into a string_list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 9bb920e7fd..38780edc39 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -674,12 +674,13 @@ static int filter_by_patterns_cmd(void)
 {
 	struct dir_struct dir = DIR_INIT;
 	struct strbuf confirm = STRBUF_INIT;
-	struct strbuf **ignore_list;
-	struct string_list_item *item;
 	struct pattern_list *pl;
 	int changed = -1, i;
 
 	for (;;) {
+		struct string_list ignore_list = STRING_LIST_INIT_NODUP;
+		struct string_list_item *item;
+
 		if (!del_list.nr)
 			break;
 
@@ -697,14 +698,15 @@ static int filter_by_patterns_cmd(void)
 			break;
 
 		pl = add_pattern_list(&dir, EXC_CMDL, "manual exclude");
-		ignore_list = strbuf_split_max(&confirm, ' ', 0);
 
-		for (i = 0; ignore_list[i]; i++) {
-			strbuf_trim(ignore_list[i]);
-			if (!ignore_list[i]->len)
-				continue;
+		string_list_split_in_place_f(&ignore_list, confirm.buf, " ", -1,
+					     STRING_LIST_SPLIT_TRIM);
 
-			add_pattern(ignore_list[i]->buf, "", 0, pl, -(i+1));
+		for (i = 0; i < ignore_list.nr; i++) {
+			item = &ignore_list.items[i];
+			if (!*item->string)
+				continue;
+			add_pattern(item->string, "", 0, pl, -(i+1));
 		}
 
 		changed = 0;
@@ -725,7 +727,7 @@ static int filter_by_patterns_cmd(void)
 			clean_print_color(CLEAN_COLOR_RESET);
 		}
 
-		strbuf_list_free(ignore_list);
+		string_list_clear(&ignore_list, 0);
 		dir_clear(&dir);
 	}
 
-- 
2.50.1-633-g69dfdd50af

