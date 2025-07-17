Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC329CB49
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749389; cv=none; b=h7IQVghsgBKAJkpcp2YTmkqes5lYd9q7fRrvPoHejuQZ5b/bFp0huIYazaCu9WT/2okO4P0hcUWIGft4TxJzeDxA8APgoCcqhdByW++yZSyxr+D1MMIB8t3JSJgImBIhR4rYbG7jKPVp1xuNh7VlEBICp1tk0krx3Kz/xzeBWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749389; c=relaxed/simple;
	bh=avQnMqwSZNhGo+/Kh5Va3ep0TwTk06ccPCd2Vuc6Dhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sbi7pVfj+wTqDJNlz+VTg9OXych55LqaYlgE6+8t+Q/OZ1aElZXkEXAuj13EZsZpQTwa4KY/3J/XNq5arn8En4/xRa4n3MUMyom4o6WEGLb16iyiPs0ymqC0AmU4MFW59ZFTqJmL3BGqpJIFMz21RxWLwAVFm3FbCwDJfYZVwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sCzhByMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hCcd1AbL; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sCzhByMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hCcd1AbL"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 87AEB1D00112
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 17 Jul 2025 06:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749386;
	 x=1752835786; bh=hVQUTllx/p7xkctExV5nwzlxhUp+GhHbwSxYj+ddgAc=; b=
	sCzhByMn7DqITWgQNEqM+0WLvYZiwmX1WSI9d0w2R7a9/Tpxn0DIt1/ctpgm48k4
	w0EF5cuOSU0eFJnAwxVVw8/cn2AIxtfE2cwmZ/aR95fL23Z0YeB0kYfycxKF7fm0
	3fVeKss8FqsEl4SimMbkeYQyUeIslHr2XR4ad6HeTXvqiMA14irTXJ1z6w8/nNnP
	NvWjvUft4Ffi1Zq/9q+g+PwMcj384UziBSsjsgHh5zxHEIWEvMcpFVcqm5GddlOG
	umzU7eAx0+npsggwSlqy1dxksJdAI4938d1BJuSjhYdJruSCD6q4nEmc9oKXVVPr
	xv6K6GFcVHgoLJPXoYW20Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749386; x=
	1752835786; bh=hVQUTllx/p7xkctExV5nwzlxhUp+GhHbwSxYj+ddgAc=; b=h
	Ccd1AbLWK2onMY04I4T+7BdFX70DFqyGvQC99YTh9kund/BlOsGlNzu4iERzAQU7
	1PQa3lIeE787XG5Sb/MYMR8qr/dqBMZtaE/0/5CmP+uI5TDt6j9DLH4yWu+edALH
	qF88jRxYq+eUD0DQWVBlyJQcPFdmrq9wc+vCpx2ttc0nkByH95dOmPQLWq/in2BD
	6o/izovyAjl+dkqrTD7vRcZgauFKVB5fhg0c+SDqAWoFtoZNdlSL4KoRTB5bVRLn
	HIFiAhhXD8p7Ypg5vcWWubg/s84KXzV4WuTwdnIqZT53NQkc/B6bIzWc3dJm7kVF
	5WX7je0LBKA7NxIxAi9WA==
X-ME-Sender: <xms:StV4aE1XKvDDWr5WVvkxWwQ4cWcAzo1rv5IB6js1SVHYnLf8nm-l_w>
    <xme:StV4aBHFlAmufT3egq3r0XBtfd33LXtONsipkjALPFhuGEhoELXmB8gPrZloy9e2k
    Qr4XrmK-E-8kMR1OA>
X-ME-Received: <xmr:StV4aGSvho-dW-NCo2K_JjdvanCueX-VoKmTAK8uQJte8jxuxrzWc87_gGm_3pFS_eNohz0nJX7OI7bPCp6udi1G-8Qvs3z0obijFeJ0zQUP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:StV4aAB7QSdMoCb6qMDIgXf09fiJjFokMyZmlfsXNQANMNreDBs2DA>
    <xmx:StV4aO1LDrE-nGZfoDNC6PURer0OBXpDsMV6wBCOux0OUyCLHI6izg>
    <xmx:StV4aGVLyM7AFmsyA0GnIKIwUCtI1g_yahMk1fCAy4z-gA6gNUYCNw>
    <xmx:StV4aIl3tO6RZZUfjCLvCTcAhIjpAJPFG_UZp_LZBZeFZcCVA-8FYw>
    <xmx:StV4aO9fwQjTFIcTz-EFMHYtwLpeV6w2ZRR8AtdR2fB8vqrAUr3XMFUT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e25b44bd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:25 +0200
Subject: [PATCH 05/21] config: drop `git_config_get_value()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-5-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_get_value()`. All
callsites are adjusted so that they use
`repo_config_get_value(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.h               | 5 -----
 t/helper/test-config.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/config.h b/config.h
index 5dc330b88b1..e90c1c4d335 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_value_multi(const char *key, const struct string_list **dest)
-{
-	return repo_config_get_value_multi(the_repository, key, dest);
-}
-
 static inline int git_config_get_string_multi(const char *key,
 				const struct string_list **dest)
 {
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 99c91512173..1953ab846e4 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -121,7 +121,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
-		if (!git_config_get_value_multi(argv[2], &strptr)) {
+		if (!repo_config_get_value_multi(the_repository, argv[2], &strptr)) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)

-- 
2.50.1.465.gcb3da1c9e6.dirty

