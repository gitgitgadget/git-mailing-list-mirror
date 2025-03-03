Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204A23BFA9
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034705; cv=none; b=pM++pmwYKaQL62hMAUAdtpJN4Yy+xVpl9bHoG+wXxCRk26oj1xWln32Jy2RUYJ9lG1SGgFNulmpNo/Hi5hYjCvmJ92s04mytKAaGbfL82ZdVdFWl7IN/aO6KD6of8P8KWEIfACiPcb9CZGJ59R0YG1O8BBY2hyOl+dSw/jalByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034705; c=relaxed/simple;
	bh=uhgDiFvDHrowzQ+6KwDoxd1/h4vjt3PwHOipFXK4XEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/HCjQ3lQtdbkLi26ajitpEafthzzlO66Dir/kcjhFMYfytloybL3sv16ivUbfqsuWk7yq22d3hLk5bt3FjfsKVwXbBaK+k1Sldt8NexnCa5tFv8L64ShxWnQQATrZ7oKcif3BUgqaD3ZZwj+JDpMoLVUNjQ/XiBS2W4ZGx8VxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e5DGTPuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eteW2nJI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5DGTPuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eteW2nJI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 949C9114018E;
	Mon,  3 Mar 2025 15:45:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 03 Mar 2025 15:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034703; x=
	1741121103; bh=E/ZOI9rMeqxFbt7gvifGmBzAhvCycnPvqdj01X7Yb/k=; b=e
	5DGTPuP0A4+VUbI5qE/LKXSU6u1La3fXGDzRESYKZY1wo5Ewu31KlYY/FXmj4kWy
	BBxVpeB+4paN9CAlfbCmD5tYlqako7b8xHGwtmoyglLAOE7r6F/CcgTbd73Ll00T
	dtaEM1qupwjo8JsCmlKBseKnQGH+x1wL10I37LGdyd+lTa5unr5JlM/uuY2vCMFz
	LdklDRutMYI8nGiKaVkJmFh++k64+61oNaqI79jGYPOnH2cr8d0HTz6wPdNmkOHe
	rPO6mDQPKqSZUF4iwZ/omsbnRz/ZJmasFjQDSpP8jJyu6W/KsY/6tiJVT8KT+GAW
	7Spnd8700AZyKuA+WBViw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034703; x=1741121103; bh=E
	/ZOI9rMeqxFbt7gvifGmBzAhvCycnPvqdj01X7Yb/k=; b=eteW2nJIPmP5BInUk
	1Pr6pyH1dac8XSM9yi2Ffq2pAORMwA2WbV4ymQIi1Q9Jo0JHuhywXbv1ZsicX/Xp
	ZqLNRhiR9okqLIPGyIzf0gW9qNCxqANYJFj5xlLS4Ffv8kv9q1ycf1Vz1p5y8WEU
	wUxbVwrS4CCXZV1323hAQWPOtrvbvtbQFbCAQp1MfZ7iTxUsWQ5gQTdOqFiSBLsn
	ZTrDQ08EOLX2fdrhf/gqIxgHwv90NQrRYawTWiGMrpINP/0ySJk9VpqFMbGajEqx
	w0yFbrGSzMEMo4DcRhqxLUpEgOEcYAxSH/HkdeiRqMRSFKkLTYcnTA++4rH4RJc2
	3JM6w==
X-ME-Sender: <xms:zxTGZ6ZQwpD140qgk2jeiKdQ0urKamJVZlQHKgkjj7OTpFVzbvpJqQ>
    <xme:zxTGZ9aWL8wCJx7f5jdV7offTul356aW7FlNnxw82vdDPa3irNRkYfGNMS7nWca4n
    nGSs6TEXDoB05Hk8Q>
X-ME-Received: <xmr:zxTGZ0_Vb0rU7Hr7FSYz6dul0am3XVPRYSfLPgdUq0tqSB8CuYjBgDuwBc5_FVcxFZRYyvA9w3jpz3l9j46x8gEOidY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zxTGZ8o4-pZWc00YrSo5wjpHY2yP-TrkshvoqwEEpMsmb15PMZuYPw>
    <xmx:zxTGZ1puC9qvOGIeKpDbOZzKMKyY2_d_st8dmJjlCqG0SmEn856apQ>
    <xmx:zxTGZ6R04WN5yHOLIVBX7uWqEpfW07Od_PtI5d_AHNp8fyoDGIzdrQ>
    <xmx:zxTGZ1qTl0cMnnQZKh1rMRHs5S4BxNsH8m6ntyuVUYuBCC3FVb1GTw>
    <xmx:zxTGZ8VK3oRA4kOO-S14lKNEDIuRBgoG1D6x_00iZSL0PcNwfV11ol-X>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:03 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 14/34] builtin.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:12 -0500
Message-ID: <20250303204443.360595-15-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 builtin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index 89928ccf92..993a583872 100644
--- a/builtin.h
+++ b/builtin.h
@@ -63,7 +63,7 @@
  *
  * . Add tests to `t/` directory.
  *
- * . Write documentation in `Documentation/git-foo.txt`.
+ * . Write documentation in `Documentation/git-foo.adoc`.
  *
  * . Add an entry for `git-foo` to `command-list.txt`.
  *
-- 
2.49.0.rc0

