Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBC3D8104
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165191; cv=none; b=uJexABDQ8NArMrPa8gn0MXolwA/PqULpK8T1qa+Pw6OidkAaE3F4GmR7PO2kaWNHEBby0y1ujylIrdPHp7gFvmX1wyC3mRYdgFxPEvTCFOgCQ+wSNxLMW8Q8gWAvZwZO9HIKtEmIj22/jAfKwPq+WHzAT/pelptMK/URIPyr/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165191; c=relaxed/simple;
	bh=VmsRqBitQeMBttPI5tIAvR0O2CtpUAHwf1BCiM3uyWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5Do9KarSDs8lHsIxIWA0A0d8rcgdLqSVh7gVrVxQ23jlLRPXaADGAuTnwtco4Xl4oCN8mo8yVlNMv0XaAwC5d8y4noVVVj8FQwG55TnXrPUDJCrBzZrs4uu5+1CfuBSvRhmrOiKomkcCJuLJFNb3EJCBjswroziRbw0xyqYcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U3udFWHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrtqN1XS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U3udFWHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrtqN1XS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 90CE6EC0FCC
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 13:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773165188;
	 x=1773251588; bh=4eO0R7qvZ/qfvgO5YnCUvpvueTgJ0JDFRukNypP/VtI=; b=
	U3udFWHIpv5wnAyh/V5cv+hfpeGDSS/Fn/v97EbTtlfNASvAiXZRDKpuYAiR6qRr
	azn5EzCIvCgRA30/0sWPHE+SROROBecN+MTJTo4RcsxLAQeRMJrkOlgBzpKXNuFP
	0yVZEeifC/N01b6kZseO+BAQTBiIwmPv/8Urs4lWQtXQ7z49Ad9WYGgbeToFD2a9
	nKjVHGUoXIbN3nTF8q0Fiq+c4kNJBz+ouXd4Jc5yaS3VMyiOeIFS1BBDkM3p33Uv
	Tl9EvMcs9TZki4hpAa9n2pu0zLvj5gdhlltqb05x6GDt+w6Y+L5BMmC0jLsJYZDi
	IyZVJxdQjUo3P37XpNnllw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773165188; x=
	1773251588; bh=4eO0R7qvZ/qfvgO5YnCUvpvueTgJ0JDFRukNypP/VtI=; b=j
	rtqN1XS1wMpHWLXPmC6njnFSjmDJowKEoYqpT+3HEjHFCty3Xb4o5Otnm+63YQX6
	/aOOHyCJu6PDpigb61jEij41WbOM3dDMlIzwz00eksSvdtZhr2dNGbH3LzjtIl3E
	SKv8G2f+Jf2vYqIgKKULdMcCd1i/lq9Bhn9hX3q7Hgf3lVXuw1aK2yC1VDMEwsp8
	ab0ce80rjrMyjqEft7ltFMtqYGgBhEX4i5Q0ox0bHUvDxtEakQZKlL5uMqRAW+Wu
	T7K9Kc8edf+V9hi3pXCR7G9uSSaZkjatkAjwtMMasKqs4tPI8Hbg91og1/4CfStb
	9KJjBJiZ/PWrJdy5sbf5Q==
X-ME-Sender: <xms:hFqwacZcBm82gy2OK6CZYya8z9o2jNwA0945Lz2iOIYl1iSuSAzWHg>
    <xme:hFqwaeV4N94AcjzGZFBffLFusTYzMxZdQ9rim8X5J3tJgCyYMUecOi5keLV7U82GK
    4EbGWgapoayqG3jEmV6PvHnukzLwuoioDV7ZbG6Z5fL7v98XLoLmw>
X-ME-Received: <xmr:hFqwacmievnczvt-ZyJ52cDWEiIi8744dxcBLLhrGGbzE87ksI0NtDAyzWbKiPYtGCsaeKGo-FZxDTCbqeJC7bsx5U_43fMm9vFg3iUC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:hFqwabxmOS8VWxD_FN2lfynhhFMhApYNiQ--BKr_oACIEP2TqP6Wsw>
    <xmx:hFqwaXibMgzDl8vrUqZ6fsHiuGTF_8nFgRIs5rAAYCwNiM812mM_yw>
    <xmx:hFqwaQXvhM2ewlunnRw2DkTshhy7S5R1Af1QcNwZsDwGWN2Ov_wN6g>
    <xmx:hFqwaZ1M861GpgGjg6MbdhXtdY4fRVnbvbjfpt5D-ZxcgSETcQGD0w>
    <xmx:hFqwaS7dhN8jjglmrKtSdecVraBmfgH7SoB89r35eKQdnMsJ9nP13k3r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3825e15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:53:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 18:52:39 +0100
Subject: [PATCH 6/8] git-compat-util.h: move warning infra to prepare for
 PCHs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-6-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "git-compat-util.h" header is supposed to be the first header
included by every code compilation unit. As such, a subsequent commit
will start to precompile this header to speed up compilation of Git.

This will cause an issue though with the way that we have set up the
"-Wsign-compare" warnings. It is expected that any compilation unit that
fails with that compiler warning sets `DISABLE_SIGN_COMPARE_WARNINGS`
before including "git-compat-util.h". If so, we'll disable the warning
right away via a compiler pragma.

But with precompiled headers we do not know ahead of time whether the
code unit wants to disable those warnings, and thus we'll have to
precompile the header without defining `DISABLE_SIGN_COMPARE_WARNINGS`.
But as the pragma statement is wrapped by our include guards, the second
include of that file will not have the desired effect of disabling the
warnings anymore.

We could fix this issue by declaring a new macro that compilation units
are expected to invoke after having included the file. In retrospect,
that would have been the better way to handle this as it allows for
more flexibility: we could for example toggle the warning for specific
code blocks, only. But changing this now would require a bunch of
changes, and the churn feels excessive for what we gain.

Instead, prepare for the precompiled headers by moving the code outside
of the include guards.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bebcf9f698..4b4ea2498f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -34,10 +34,6 @@ struct strbuf;
 #  define DISABLE_WARNING(warning)
 #endif
 
-#ifdef DISABLE_SIGN_COMPARE_WARNINGS
-DISABLE_WARNING(-Wsign-compare)
-#endif
-
 #undef FLEX_ARRAY
 #define FLEX_ARRAY /* empty - weather balloon to require C99 FAM */
 
@@ -1099,3 +1095,7 @@ extern int not_supposed_to_survive;
 #endif /* CHECK_ASSERTION_SIDE_EFFECTS */
 
 #endif
+
+#ifdef DISABLE_SIGN_COMPARE_WARNINGS
+DISABLE_WARNING(-Wsign-compare)
+#endif

-- 
2.53.0.880.g73c4285caa.dirty

