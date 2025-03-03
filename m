Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168223956A
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034702; cv=none; b=s/xwlpaol2i/Y0PaDE0wWJ/sE+S2LWkAoOkMn0YYMTkw8eXElZZxnAXL1lI7VldQTn4mWPdBIXPUHRX5L0snqIaEIf9QjCYwn/n2Pe3K8KsmtrX9DduOAa7HIFzOE8nhcQzaWlSdmy2CDKA6qV2K3C0hsLru+q5nb9vWEnZlgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034702; c=relaxed/simple;
	bh=M6L5z1S7kv1lM7M0HBodw+JtxkUS35hlrlQ/f8UmBfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/eNKhw8Ij3hnWXOAZSfN5PWZtM0Edu7R/FmuL31Lda5uEpv2wsiNbHSGvS2Thy8dz6biEBLtjb+jR2kb35F/fPlGAtmrVTocoZ04MmYAkEXzxTP2rxz0h4CjuGLt2HxcqbtMDPW9AtEpzWU+qd03r+GyHK48OSV7Q6lJM9Cfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fMsJzoGZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLfnSH7G; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMsJzoGZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLfnSH7G"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8D6111401B7;
	Mon,  3 Mar 2025 15:44:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 15:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034699; x=
	1741121099; bh=F7O9uWkteCv1Lzhtl7GFIPBbK8cWw/aQ1Han+87nTXk=; b=f
	MsJzoGZ/nbKVJE6JqAFScXAD48HOGkIofn6Hjr1sIv47Ue98RakxFeMDVozH+4R4
	PPALwjlbTDpmMWqhbLXyFhI06APLhCu1UmS0xCdjPLIx8JgR/mCEXDV9RXtTkT4G
	ewgqRCO7ho6m1xJpuaspvNx6pY6SauxGtvIulEeCB9FvjOlHeEcqFscUZJlBCtVo
	IUVm/PSqF+v8S9NIDie72Ysp6xQ/SSxMi1KKqHVhU72rnGpomHL/8kYA497TgHQ9
	iUoVxLi3Y232RUknX4I2jpQGsMmjAerl4sWW7o1R6F83dx7e9Hmtr6qCXk6wYpOr
	mShPz5+6xYmF/uVmQ5TPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034699; x=1741121099; bh=F
	7O9uWkteCv1Lzhtl7GFIPBbK8cWw/aQ1Han+87nTXk=; b=lLfnSH7GQvV1ZK6Bg
	kRCaA+onkZW8qTMMv3FNFgANfaOdmdMleCa+AJI6LXuSwfjYhnMF0vSW33j+1A9R
	5GMagl6zKP9/OCLI5ga8EGXvNQPbuqSVc5t+W+ehFdNj3ZaLMr77qyUxtm/jxg4P
	zmcDBCdObQ7IhNDyeKFYpwGkDPjM3xDA7VZj6xbR2IbDwGEiX9oilHtuFE/xcH99
	quzxpTT9k61vvxCsfiz1rHN9YffK206nUM4K5x2teqk2Omt2ReA/JGiHaveKpYTV
	SBeP96Hc1dwcsm2lP74OQQo9zMh8SYpWuFF9uJO7YMPKPpXr51SmDLy77Ey7HIhx
	xqESg==
X-ME-Sender: <xms:yxTGZ7NC1nF0ObGSs9SS5sCs_rXDIqBeFBcpoAgKPF4oNWH97ntr0Q>
    <xme:yxTGZ19UIfeXQ7UibXR-LNBbIr_UXdnMEL8lNJKttCtGWZRSV-woo7se47m-von8e
    330rCvl4rfX74k72Q>
X-ME-Received: <xmr:yxTGZ6Se8kvrKdUZ1G0TjWXgDg8ZeEY58lc0wVqwsEV6KwXU3xEMcSCSYl7ftV-s_PguIKkgw81j8MwIuouLM3doMBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:yxTGZ_tP6AzybfbLtfysu27vGN273GwTjp_KPSNRJs2GQdKS2UlDBg>
    <xmx:yxTGZzdUbdhGxea26mfEeY34vCnibWICZS4R4JRrSwPnFFqdtUHiig>
    <xmx:yxTGZ73h0DU1-zVxZH6vSj7HSx4suIzXOMJjw4xs2WQMHvKEu0EQCQ>
    <xmx:yxTGZ_98mQctwQibLQmFla87VEt6Bppo3YfU8ivL9TM04WkkFAJDJQ>
    <xmx:yxTGZ_7hGpWsnq7PoBWAM76HjS7HUJttlUUrZANv9ociTYl2thlG1Poi>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:59 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 09/34] howto/new-command: update reference to builtin docs
Date: Mon,  3 Mar 2025 15:44:07 -0500
Message-ID: <20250303204443.360595-10-tmz@pobox.com>
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

Commit ec14d4ecb5 (builtin.h: take over documentation from
api-builtin.txt, 2017-08-02) deleted api-builtin.txt and moved the
contents into builtin.h.  Most of the references were fixed in
d85e9448dd (new-command.txt: update reference to builtin docs,
2023-02-04), but one remained.  Fix it.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/howto/new-command.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/howto/new-command.adoc b/Documentation/howto/new-command.adoc
index 880c51112b..ac73c98be7 100644
--- a/Documentation/howto/new-command.adoc
+++ b/Documentation/howto/new-command.adoc
@@ -48,7 +48,7 @@ binary); this organization makes it easy for people reading the code
 to find things.
 
 See the CodingGuidelines document for other guidance on what we consider
-good practice in C and shell, and api-builtin.txt for the support
+good practice in C and shell, and builtin.h for the support
 functions available to built-in commands written in C.
 
 What every extension command needs
-- 
2.49.0.rc0

