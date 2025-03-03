Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD923FC52
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034716; cv=none; b=mD4JGB4OCiVSWr8A4jxVSxoyTUNPAeWfAXT8QcgZcsN6LZVIbVZ7BHND48zvZPqkm3Pw+pwhaLL4ARbJeZLr86k9FOA3MYFlZbaiuGV+Lma8R35hWRa5ykJMZoj5DPmwlFWIbQudAX/VXLkpCws6BNQteqYVHIAh1a95JkHUA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034716; c=relaxed/simple;
	bh=lhDaxaDmX+my5TOfGuVPSi2aEStnviYFZ78827Uiqck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzDM+vbZLm5jZmejXMU9GNHQZwFpvEoREmwCUoNjWylu4JWixnNUJWceZHmaK/RKIIxOoFCAb2qV1EhvUZaw44qI9scSEOYYnWf3zp8DmX9ujDz2vKkWqimXQaPLAFvBMhk5D14+sD9cGDLy+qhtg+0JdjqRuFK49eL1xXNZioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNvJIfW5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+uf3g7i; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNvJIfW5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+uf3g7i"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 876CB1140189;
	Mon,  3 Mar 2025 15:45:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 15:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034714; x=
	1741121114; bh=9ufVZViWSxS9VVxJsKWpenUWOsZaFv2aXnxXysTPLqg=; b=b
	NvJIfW5cQo3ZzM/6RNBnn6Wmi51tSAO/ykyqooFn7RFrbvRzPzxKX2rJ+cJpGdxu
	1Xw/n7t8XKNhaC9vDN3/VZ6BBbrM0LdzPBqCvdHWW5jjJ+arEvsjY2MHwgLmOgaR
	tyONbnV/f2+ISfiJZml4OGLfWaxJ+E27y/skS4qhbqlZU5u/zyHEVjh95ILBfIEz
	e+WBDRkMgw8IX0RVpdETC+NEeL0Ko4kWznRbMZmm2EdXmqGFW0DsVYMpG1+PNLVm
	6bhe3EFuBYH54bbK4CNxrFTDTlM7CG/z3jzB4veqjvYovtgKqGdm6qtrznJ3FJyG
	AQ8QBm0WM3fLDVl0wLoRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034714; x=1741121114; bh=9
	ufVZViWSxS9VVxJsKWpenUWOsZaFv2aXnxXysTPLqg=; b=o+uf3g7impCf2Zsuk
	UCg1jUgX6XGHvKuRBOC+xV0h7V6ufqkWJJwMkHqAII0TbP6R1f0N/SvcGRzmsqr/
	jyt9UcOnTye7bCZy2pT8gn4N/iOr/b3jFP0YtKPkEL1pEobxgoqkg/v08okocdnp
	JS3mt8VF+vWYjHHm3Ca33Q57uz+T3JjwU+kSQrJg9JjnS4jGjj6g1Z/+oVPb0zJm
	GKVp5q6KREYBRIaM6j0/SkbXXdopFgh12K500587HL7Zr8uXkpcIVfrQ9JaDeeL2
	7m2M50vlp122puoGMRm34Ln8zG7I+BVa7dv327iF2Jafc+qjfcCSOhN9OqtGGwOP
	WSunQ==
X-ME-Sender: <xms:2hTGZyKYVhKk1CMwM983i4TGnxZX3J9wH_uQZjOMYGFPo1XfrobXIg>
    <xme:2hTGZ6Ju255HnM-HQfN5cq9kJ_DA1Rj0oAxal62jrJEk_CPJVSo78ETjT-KiW9FKs
    moTp_2o--gxpGAT0g>
X-ME-Received: <xmr:2hTGZyv_izluJ6ghmpYpuKZtqPq2rQb0UAwiGYpsj2FV1eaNiMzhClTglsWslqfC7bBOr7tzTiwJZgvwJ4d2t78WpnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:2hTGZ3azYxKN32_JLYyoXlmC759vYuTginbLId7jmBolGHc_wPt0hQ>
    <xmx:2hTGZ5Yxu2j8DcZSE38Na1HB87G7enSsSxpMeszQfbplyVg3gofm5g>
    <xmx:2hTGZzB9bxGs5oYqeopCUavOWiNYFNzXno7nXkb6P9o1EFADBylHHw>
    <xmx:2hTGZ_b-zhGsYE6gYWUDUGqggxv2_A8l82hGqcOs-igonwqFcsdo5A>
    <xmx:2hTGZ9FYuEsfyodRDxw47dK-xnwNKw3Km9Eh0B7wvUPGgpbqiW7Zhl_u>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:13 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 30/34] trace2.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:28 -0500
Message-ID: <20250303204443.360595-31-tmz@pobox.com>
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
 trace2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace2.h b/trace2.h
index 901f39253a..e4f23784e4 100644
--- a/trace2.h
+++ b/trace2.h
@@ -31,7 +31,7 @@
  *
  * For more info about: trace2 targets, conventions for public functions and
  * macros, trace2 target formats and examples on trace2 API usage refer to
- * Documentation/technical/api-trace2.txt
+ * Documentation/technical/api-trace2.adoc
  *
  */
 
-- 
2.49.0.rc0

