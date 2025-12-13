Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E012F5A5
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765590395; cv=none; b=Vz4iJJWd8ODRNg2hKHX1tBoqMTtfmKNjdKEdySKHeIYTJjYThk4Hln3MX7anAdCJmueHtsATXUZDxe1RFcLjU40NYeUCWlPMI/2MwMCqGCo/rx9ltHQecO/CV9OIwTnPKeIAdHnYnHkPqMt7R36SFa781wqn1WxWf3hmp6zNvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765590395; c=relaxed/simple;
	bh=fCfPVWSGbSvO1WvqRPy6a4DllwmkQIQY8ClKVR8fQfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITKn+vWwFfqeYk++yyz5FsNuuQb4gQPDxuXo2CKSQEjk01gaQS6x5LWUTVUDKIfauM92pTOPFpMm6QV1cLQ05i3/0FY6eM8E3OejHaKsLJSeo/WpmWJ+/IVOHiefZ95n2doxXhwda5EWZQgpnr5SST9br1rFm/RdAsUhO9KKC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DcxN0+Q6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQlBHtBi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DcxN0+Q6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQlBHtBi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 61903EC0539;
	Fri, 12 Dec 2025 20:46:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 12 Dec 2025 20:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1765590392; x=
	1765676792; bh=R0Jan/lrJQLOdd0r1uXHU+NqC/Czd02sJKJuefaW0Sg=; b=D
	cxN0+Q64kS+jazxH1eWb2e465l1VjVwyRfQZYFGk8KWIxOo16PrAhFJPKWUz0AGc
	8NFBYqoMOTKqvRMpTmitiPP8h0J19WA5LCfas0RMUL3mfrXsbCrzF+W/en4rMIgD
	iBqZBAuubJUhGLDl/l20w2Yqwo4vM27HTcqZECfsAPJ6bdUTob4yBKeiL80svAdQ
	+9BrnkkTtkduP42+j3nz0ipbCwAWnF27vy9lhWLOVL7mqIuvVdF2uYJ9/vairQLo
	jznQ/wJz3Lfm/mo8vLosYAcvdvpkuqLAq/qgS6nGTpbc02ZhFCUt3aE6DMpCUiEu
	T/n1s6HI96vH0F6FoYuRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765590392; x=1765676792; bh=R
	0Jan/lrJQLOdd0r1uXHU+NqC/Czd02sJKJuefaW0Sg=; b=aQlBHtBiy1NzPEB3z
	OWlunjCaPmyTHT5P5hkrLvYMmjxkOBz1tH42398/Bdy5wPUJmQJsezJ8JtCwpbic
	qerZIiELQSoklXfvvMdgxTeb854ONxqb2DVn7wbzD3Q7esu2+xjI9WOw85tiB30W
	oRkCzpYTLcxAe+mayKWKF6wYj6P1R+jJkSjvauVcl6i9eeUsRM60ow3xmOID3QFK
	ts0pSBFmXBCp6vid3qSQhKKNn/+y62glBGI7hKbQPru8gVK8v74ePSzE4zN/IsEn
	XszSCeuTsbuiFF/fFvzYVNCRMJAD3IwYS3JDJmFgCuRu8ZQMGU/gdtetWtVKCz+W
	apuzQ==
X-ME-Sender: <xms:eMU8aT57S_b3pNzto1XNFd2d-EOo2ry7oQGDzxqyTvpiOIW10o9LAA>
    <xme:eMU8aQUl18GvFpT6cQFAJBXmzSQkuSFYextMSwwyeyCL3mkGKIT-t2rGjak3zB0rQ
    doJjOBkmoE0oCLPDocPuqyNJaw4OJUr43VbGsOD27bCzTKAnUMc>
X-ME-Received: <xmr:eMU8aX1J935iug78dwZyCiEUAPBezBO7_INSGezOBuTeVaoHJfHItlnFGxbR4Lz3Gm4ubjfXiWfxErToPdX6wLEbvQuwmZkU9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvffelhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:eMU8ad0bV0mbop2Mn75SlQS8fFz5CW0dqRTnwnJ5cJytogQ7yYF1KQ>
    <xmx:eMU8aa_mPD1mPbamOaBGl2Afq3gAM6e6qFGj41Zm9TLksbB5OGtbtQ>
    <xmx:eMU8aa3zFEDeFoPjBaQfqsr48y6jrCS0ZOQ2wnUAdM6n9Lk0eYSIng>
    <xmx:eMU8aX84KDPk-rMhMD_S53m1TpfJeKI5T33TwjcFDnyxyIUIqejPng>
    <xmx:eMU8aU-qQiRauUZPA9O-QWbykIhTkPOlkTgIWdplgIQroSZS258Gnjix>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 20:46:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 1/2] coccicheck: emit the contents of cocci patch
Date: Sat, 13 Dec 2025 10:46:27 +0900
Message-ID: <20251213014628.3380826-2-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-357-gead5eaf5b3
In-Reply-To: <20251213014628.3380826-1-gitster@pobox.com>
References: <20251213014628.3380826-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Telling the user "you got some error messages" without showing what
the errors are is almost useless in CI environment, as the errors
cannot be examined without downloading build artifacts.

Arrange it to spew out the output when it fails.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7ca2118813..0117d0008c 100644
--- a/Makefile
+++ b/Makefile
@@ -3521,7 +3521,7 @@ else
 COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = $(COCCICHECK_PATCHES_INTREE)
 endif
 coccicheck: $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES)
-	! grep -q ^ $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES) /dev/null
+	! grep ^ $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES) /dev/null
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
-- 
2.52.0-357-gead5eaf5b3

