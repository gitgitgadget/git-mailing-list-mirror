Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B6221544
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648621; cv=none; b=rYP+FJsESyoIzFRvlx1W0i83RPZtM5rjR9/UhND47eyK30km4nYa+gHu/TxAoO4qXSjSJVSX0Aui84ovXo5pHDWnIGbxcFvFBEUr82HitEmnwlW3bnVoJwgBlZtun9mR6jkAOtrjVl4w+1O7YFMXYQ2lpXznIyyLH9pjqzCQunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648621; c=relaxed/simple;
	bh=AHY6yqq8I8Q6t4ApnwkfB0XZrd7nl/GJPXWvIUCk/Hs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI7YBl+o1aUCp8DqokZTgobqUNlKiKfmaqik4KVyjIMNeK9FgC116yp0DYi+aI2cZz224DJxWHpmAes7Mx2iFoaUfaemF7tVXWtjqXLhgKxeKK4MmVyRoMbmilYtIspig1OiGIKXdr0rOspIGasq+usS0+cthzynzun8Bi7A7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZXWBEvKv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sk+8CmIh; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZXWBEvKv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sk+8CmIh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8742B114022F;
	Mon, 10 Mar 2025 19:16:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 10 Mar 2025 19:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741648619; x=
	1741735019; bh=8oED9MxbrneP9B+6F7cbrHGr4h8nbNS8gH8EksJt/QQ=; b=Z
	XWBEvKvOfTKMRk6r+GfTRPaDnWDxg7o2iBG0A7H7gVkug8VGyarqTBd2QEwah9l6
	WubkUOUxLMpBebIdiqCisNzoemwDJXtJQR0OvTqpFvmoojWIEVSfsuHG7I3eUb28
	K+iL2xdYiiU34zGCpf266tSOEdewUn/QkxZuB8RYBYkJARjXaHwE/iV+BeyNOR3p
	R/KXNaBHySrJIWnuGVdrX1W4237V0UE/EIONTIlAGPiw2yPArQcsu+dv08PCYcvF
	uYSVAb1AlhFCML+BeycEAis/4OdfLtX0mPuKC8Srs/VLZI+0JonXlm/wDRg9CDZS
	XtsOJZk0BtV+S6X1bgwPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741648619; x=1741735019; bh=8oED9MxbrneP9B+6F7cbrHGr4h8n
	bNS8gH8EksJt/QQ=; b=Sk+8CmIhEy2Ad70rAnEIAb0n08/n6+/h89YtPfUJqDzb
	9oQXMyiD78ULbLDEUW5MurYJb+C3zFPFKbNF9M/oW7+SG/6JZpu1tlzsd9mqr/I1
	VYYzht7xvO2ZUkbYMdCPW6/3caYRwqhM76I7DERVLi9BM4LF0uDIC3GuAccqXTBQ
	TiOU7IT8IRO2g10+fT5t4LC/GNAZwHYtBV3ZrL4JnDo/USYnq5ZrXNZBS0ueM4om
	x0aG9OwcgwYJv/BFeB6s5pxjYquFiCULwDtTQxINzHZjhAvl6SatRRr0dj0OAYWq
	HgeTArnl5r894HQH5MzjDvFUVZO7qtYHv4Qn3S+Szw==
X-ME-Sender: <xms:63LPZ-6GWbkTyDhamUKIy2KFxE4WxHLZ3sIzSUUId1rWymgrb_rXkA>
    <xme:63LPZ35jtmljyD3Ank7S5m8SEnC05KElVIs--eHCyn0VjhkquHKBz_0DW85Sqo_SS
    3-8yuVJwT_6C7Bznw>
X-ME-Received: <xmr:63LPZ9fok9Nro0DJ7J9SftmOCAp9fORKLZdOY5pUR1hHXKHoxuA-SmEg4c-mYmQYOyXhjsklZII12tWpQJ1CWsOiEHPAtEMFPaxX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:63LPZ7K5QlbBM89hI9beyMkxGM2Xp0fArJRSy7Iuf67A4CF4g8jQBg>
    <xmx:63LPZyLBmnWLQFtOhPl9SAYamU4uyIptVhecQKR_vFw3AtXT2ttXkQ>
    <xmx:63LPZ8xjpyRowWPd1tc0bJstPuKD0hEOxPUOtjaZFhrc1bd-5lnkTg>
    <xmx:63LPZ2JXnFkIl_rWIPDFd7WUoOM6vTLbVPHIv6RkdHKgZ4heVf2WMA>
    <xmx:63LPZ5UQnAviyUI_YcJgcYGSSYWWlMpAyE_YO0nHag3rmQSfPBaoij4d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:16:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 3/4] t6120: further modernize
Date: Mon, 10 Mar 2025 16:16:51 -0700
Message-ID: <20250310231652.3742490-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-173-g4d16673c2b
In-Reply-To: <20250310231652.3742490-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is absolutely no reason why a pattern given to grep to find
'warning: --stdin is deprecated' must be quoted within a pair of
single quotes, or the pattern to look for the literal string as ERE.

Quote the test body with a pair of single quotes like everybody
else, and quote the needle string in a pair of double quotes.  Also
use test_grep instead of "grep -E".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6120-describe.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index dcb526e37d..71e261394a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -298,11 +298,11 @@ test_expect_success 'name-rev --annotate-stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'name-rev --stdin deprecated' "
+test_expect_success 'name-rev --stdin deprecated' '
 	git rev-list --all >list &&
 	git name-rev --stdin <list 2>actual &&
-	grep -E 'warning: --stdin is deprecated' actual
-"
+	test_grep "warning: --stdin is deprecated" actual
+'
 
 test_expect_success 'describe --contains with the exact tags' '
 	echo "A^0" >expect &&
-- 
2.49.0-rc2-173-g4d16673c2b

