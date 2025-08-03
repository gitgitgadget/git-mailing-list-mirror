Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B12571D7
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203949; cv=none; b=FnGeg3DUCTeRgl0WZQKyofOsH8XdUynIBQYq/u51fqRr7/z0Y9FblnVZz2zh+Py+goFBKfmFySPev/AiIiIKbxA4Pa46CZTm8dySRdZfWUtjS13JqaFirKBiqa5JqtvovCPh/+3sGMhXHvPth8Fa0ygd15z8a+ggfacFhehKzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203949; c=relaxed/simple;
	bh=HL0M84fMmldR5qCGr2Ha+C9ypg0knSAyFnyx6GwxQbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d64vcpS5Gi2m9cZgRi0JxQvPyvDDrL+tBDgqWBg98cU790j4wkntmTZAfjc7dSSnAu3SSAISOtWCbEVzGvu8L6OGUY/mpuFHfprhKGENbHhvfjFjWd/XYcdmCRCPjkFXI0Dkd2NEKKNdT8hR3T39yP88sOwoSNIyemrWRAFs/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eylxk0S9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fj5jzHlD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eylxk0S9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fj5jzHlD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83BDC1400350;
	Sun,  3 Aug 2025 02:52:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 03 Aug 2025 02:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203946; x=
	1754290346; bh=JUEBlE8uUWz7wpXO/Vtutlts1rTe22PMjg8Axe/QXD8=; b=e
	ylxk0S9Gx4g4YRkZ4d6C+6KIRomoAYLS1bAZvOXuNT3LJ8SXB1iA7Or/8EkkAFY1
	2eIdFozLNpdODWVbiaceSGVino4M3hSx9oDbrbeMg6wbQO7xjfQF8vgczRmpgbVG
	ZNKZ2C+Jf0yQQZpEUJFxWzNf1sa77RHPcoE2ViZqaTC7hOAkSmowz/+vNraIN2Gp
	+F5EhEuqwTez5UX0VHt8sYJWaLzCEYPFeL37BXXrQAErfcPhapB153NfPBUUmXbz
	Xg81t0piNGc+ag99cOzxQb7/+S8icZVa8emA/GTGHP/xFr+Jop9mmsKpJv/7vq4B
	Ycw6R71YN4l8MWWYBAhqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203946; x=1754290346; bh=JUEBlE8uUWz7wpXO/Vtutlts1rTe
	22PMjg8Axe/QXD8=; b=Fj5jzHlD1SPI7e17iu4X4Ld3pN+hzUFb2AMlZKov7zDo
	1Tzih7NpkSDWLLbc3QONstFWvMCKtJ3TBDUY5LuB6L9aHP6apXF5TLQaJG1I9vIZ
	ypUYgFL176PnEsuAGf8NeCefu03Xw35yFc8u0Hp3QmRQCyt0L1av6CGYPU1IUuNa
	IL2t4DyJUiz24B+dA2FVi7kji9Nmr1UAUUs2ERKU8E/Rp7qrluNjQAGBB/c9u0yk
	550ozgbNXa6h+E1WBLbWerNUPdoviCqh/tOqZVH/zuMoYje40lLj3MLf2emu+1V6
	HfDxsDhwqeuXGLcWZeqxsga/C44rmR+lVDHb54FEEg==
X-ME-Sender: <xms:KgePaC0LUGp5-_70n-WtXsEn48dI-XXIeOOxabNZWmMw64_IOt8Fjg>
    <xme:KgePaFQm5LUzGj5R3BIJn-LRLoGC2zpSzR1XzJZK-GXQaigs4e7h5bp_A8OZ_FryS
    I5ar3HpjjPz9vYnYA>
X-ME-Received: <xmr:KgePaMsS3sGC_3cm1bZy-dXAitT2aTgRE4aAHHNbLTC-ieQEusRFuKhK4mna2beLzOgGhBpkaMhpdrw0o413mAyKV08kGSYTl-q7Gzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:KgePaCbgWlenO5xm2VasLjPWWXL_jPEl8eLbsN3RjmlEEUvXaYY6Zw>
    <xmx:KgePaJt_swuQ36q5R60XAdphALLk31iG99-zHLET-GQByBaSWI09mA>
    <xmx:KgePaMFJiyijLjRCVqjUuoqBK593McP0PFqEvFUrW6C_Vh-_UVXPKw>
    <xmx:KgePaMzET3XwINZ9FnHXAi_5LLT9QJ2id7polyGyWin27xQxr-mkEQ>
    <xmx:KgePaFYhj7tSwXm0rOe6bFbVzQtJJE39NahDycoxpK9GycTwBOuZ9nic>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:52:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 1/7] string-list: report programming error with BUG
Date: Sat,  2 Aug 2025 23:52:17 -0700
Message-ID: <20250803065223.3325111-2-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065223.3325111-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065223.3325111-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a string list that has .strdup_strings bit unset to
string_list_split(), or one that has .strdup_strings bit set to
string_list_split_in_place(), is a programmer error.  Do not use
die() to abort the execution.  Use BUG() instead.

As a developer-facing message, the message string itself should
be a lot more concise, but let's keep the original one for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 53faaa8420..0cb920e9b0 100644
--- a/string-list.c
+++ b/string-list.c
@@ -283,7 +283,7 @@ int string_list_split(struct string_list *list, const char *string,
 	const char *p = string, *end;
 
 	if (!list->strdup_strings)
-		die("internal error in string_list_split(): "
+		BUG("internal error in string_list_split(): "
 		    "list->strdup_strings must be set");
 	for (;;) {
 		count++;
@@ -309,7 +309,7 @@ int string_list_split_in_place(struct string_list *list, char *string,
 	char *p = string, *end;
 
 	if (list->strdup_strings)
-		die("internal error in string_list_split_in_place(): "
+		BUG("internal error in string_list_split_in_place(): "
 		    "list->strdup_strings must not be set");
 	for (;;) {
 		count++;
-- 
2.50.1-633-g69dfdd50af

