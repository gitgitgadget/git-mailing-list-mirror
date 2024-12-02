Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B85204F6E
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141105; cv=none; b=WJJD8igzcZB+yhRlWh3gv5/qFXx7NdIDGULbACoX6UZca+c/xic32N9vIEnM4mAAbO1T9tWVMQNwRnhnTY36Mv05f3DfeybfmZlw6zdogxiLW26a13A/GMg3s0nlbXA9df03feUseWm3p028yJGVa/+0gA/TiOueqyvejANPx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141105; c=relaxed/simple;
	bh=uzG4D6f0cRD73qE2kSPWnhPEUclXnvOONMhtgDEFfCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5nn7j0sr9wGDVR+cr3mDz3pGHd13/HTrDV/jlJ1JgTgd+yywCSzn2afTntX+6A2S5lvIHmDzMdciFSQ6RGn137bdVl2PeChJ633yTg2ES4Di3VGJ84tcP9LcwJKVHIFU47M/G/Q3tZeufrQwLx1+nPma+Q3jO/xb57dLvM9Pg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RD6fZB2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xfrFqP2m; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RD6fZB2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfrFqP2m"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AAC6D1140191;
	Mon,  2 Dec 2024 07:05:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 07:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141102;
	 x=1733227502; bh=Fz3/RqVx4WQHgOlLd9G/Uj9F5oXMMZuDotUJtdP+2Wk=; b=
	RD6fZB2YS9ZEu4X7ml2TMccBCqQUdzLbR8oaqa9yaXMfXz+x6Q+lsxOUwqw0sSIY
	wkTTP6FOhj+LgEvPOWQ9ynxKVmokuGEi1ExwtGETzrB+2W2eW8i5v8o3NChuHU0V
	/VElXJzIK/v5Zt9ENEr/+bPTS1NPHbnKnkSgOswR/BB59YSa9T6ueQS0jpPLdlUp
	gLqJ2aZ2tGbT+U7MNR+vTMTtPBsmZyb6wnNFIvcLTwnP6ywWqEntZFGC2Tk+4HM6
	lEMCz45Qbn2NKS9tQwukKLMk2f4SB8zGtYOI1csFCtN1udqt9nudciyG16xxpPId
	FQTm2yECS0ABE2NnRMchrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141102; x=
	1733227502; bh=Fz3/RqVx4WQHgOlLd9G/Uj9F5oXMMZuDotUJtdP+2Wk=; b=x
	frFqP2mRaesr6hiMw4N9Sd3sMSTzMOSDQA4I4WOEI80BP2u302xCRQoi8jysI9zF
	Lgwn6d7B1msUo+3wxBkjEbnFnn2kZ6Q9JRhjuSfoqiYQdWaKoDUx+YYf/oZxsZQO
	Kd59TJMdk8bgUxhsIkEXqBdwJrh2g0G1eEDBqA7spygfFUmIsiWfOFKnWko0chMZ
	Dn3/lBgEjSC1PmBA2SkVbf4+UtXjq3wAFQFJGfCGveVkHDUsyX5emcbRUo+SlGHw
	h+2YsXFOura2dGCnov/VIovueWoOgiXnUMrYPpjDUSz91knqNlVLeDrmXBNXsmRp
	hqqxBfKX+voRlQixwkq4Q==
X-ME-Sender: <xms:a6JNZxYfV9MmTUVI5NormdE99O_5nuWmhbatPZNdIiX5QE9MCqbxwQ>
    <xme:a6JNZ4YcREbvhkINWcu4tnxdixkod8VoRrDDR3TuxrLuu4fd0vNx6TOh5XvsIX367
    00orqgIVQiQSZwYaw>
X-ME-Received: <xmr:a6JNZz_hiJPLAoSxpIkM6NuC8RBnLrqPZ3ZGKJ96vU0aYtx3BjvO4yRfu7YejlOMGuzsF_DYxaPAQ0_embCgZ_0vdZTRKtzzrPCrp29lHM-8uq8cnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:a6JNZ_rtnVh4n_NGb4211R5dMq2ar4V_S6AxcGG5RPdGrOXFkCvcbg>
    <xmx:a6JNZ8qzyAnJdwt08E_G0XnOQ5927GYe7TVHvehtVUmybDGk9Mp2fw>
    <xmx:a6JNZ1SlGufTog9zS-33DTWFczvBJVKnCJCnwf2ollezSyIby2iSSg>
    <xmx:a6JNZ0pu7woWvO54MuYNPfZat7Nic51iJaHmgPy-YMePemw_aU2f4g>
    <xmx:bqJNZ3Xh6k02o5ZViMM75Txr4OcuCfgG-oplB_j3dgws9BC6BFV6Fupu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:04:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22529b6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:33 +0100
Subject: [PATCH v2 01/14] git-compat-util: introduce macros to disable
 "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-1-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

When compiling with DEVELOPER=YesPlease, we explicitly disable the
"-Wsign-compare" warning. This is mostly because our code base is full
of cases where we don't bother at all whether something should be signed
or unsigned, and enabling the warning would thus cause tons of warnings
to pop up.

Unfortunately, disabling this warning also masks real issues. There have
been multiple CVEs in the Git project that would have been flagged by
this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
the vicinity of these CVEs). Furthermore, the final audit report by
X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
that it might be a good idea to become more strict in this context.

Now simply enabling the warning globally does not fly due to the stated
reason above that we simply have too many sites where we use the wrong
integer types. Instead, introduce a new set of macros that allow us to
mark a file as being free of warnings with "-Wsign-compare". The
mechanism is similar to what we do with `USE_THE_REPOSITORY_VARIABLE`:
every file that is not marked with `DISABLE_SIGN_COMPARE_WARNINGS` will
be compiled with those warnings enabled.

These new markings will be wired up in the subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e4a306dd5639b58a4ec4d2a6269fb649348fb4e7..31a059820f3b1536a3c1a887390b70098a6fbd09 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -44,6 +44,16 @@ struct strbuf;
  #define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#  define PRAGMA(pragma)           _Pragma(#pragma)
+#  define DISABLE_WARNING(warning) PRAGMA(GCC diagnostic ignored #warning)
+#else
+#  define DISABLE_WARNING(warning)
+#endif
+
+#ifdef DISABLE_SIGN_COMPARE_WARNINGS
+DISABLE_WARNING(-Wsign-compare)
+#endif
 
 #ifndef FLEX_ARRAY
 /*

-- 
2.47.0.366.g5daf58cba8.dirty

