Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E791FBEB9
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480860; cv=none; b=dn5JZX37Va3Ujcy0xBiWzV8E0Wc/oT+uELZpwEk9Y+UYY484br6cZQ1pF+geroUnXIS1BjUGmBC7p7DkmXExCWwRvpZc9J/EVlU6Uq5Z2V1FKf9KSbmqi0ooStdc6oZyhD4duycx7u20Q0aetHvin9dneZqECKN0rLENDuADcrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480860; c=relaxed/simple;
	bh=jvSyuzL8Cgti+WSwNArd0F9PGqU9gWVkkcTW4NXC6fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rH05LfDWWIUlsFRLBQvFPSbkDDl2TtycpPv2WqCBvjuFpAtmNfX1ewRnOnXPGPdkYK4tPM9oaPYQPddJ8AGeVUqhOmuYHuYEV/SlZoU/Dyedl4EPkdWE0iOA73+41xAbwmD14moloCaXXRagpu3qi8WdqTwLq2uQLx4o6faPimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sLPR3Ej5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WdFmv3Cj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sLPR3Ej5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WdFmv3Cj"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB0A42540199;
	Fri,  6 Dec 2024 05:27:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 05:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480857;
	 x=1733567257; bh=xfoL0jmuLSLwJtumy9GRlADBdpY8qiI7GazRXl4V34s=; b=
	sLPR3Ej5JJs30bZfoJVOZ837JTqFk8Q8aiNgmuCDd2gUDWEVC78uEsQzP2b5mf12
	pIaYOxfHyo7FYKwbxtGQsfsiP8oLeva/ZdPB7QS9qHS0RzyvkSwun1ESUvE+RTc+
	3+Tu1y1UOXcEwUHzNPjlALOXHdGXBtyAfvzSuqZxNqmtjZqIIlVpW4cJslBs3ndv
	lP348DRTk97hWzDMLOP83wu4bg7vr/jdkBqNyU3vhwIuwEjXXCCgQ2vcbvUurkP/
	gNfIendnAGF4AVfBcDVBE2GzBOysMwSlsU+OW55YrWrou5Zj/ID01OHms8Mspvtj
	5ETvQ9HqAawYo4AhK0bBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480857; x=
	1733567257; bh=xfoL0jmuLSLwJtumy9GRlADBdpY8qiI7GazRXl4V34s=; b=W
	dFmv3CjW0i4Igjjtq2UdOSJ8S7bHWgHRfrojBVh/SRN7abpPS0b8ocjhzuftk3Is
	U8BoMNwnBhHV3S+7BkIFIX6ZABVW209fIWyi1v5g5E5rs4X2sEU7mMuAmN+rVoZZ
	SCZNFmleupox7G1IessAkMzimjr0kRayvxPJYm8hAElcMk/vj0uunuDKbf/k47ze
	P1qJ//XmVhRcQvOYTkAtNU2BVRaUUw7AMq8LU4IHAL/q7nhzKgCzerDu6TgeILP5
	420Zge2c1bml57ttCxdugGaL4kD08TiUMkjwV6ZeGrXCh722xyCalnW5na2CF0lb
	gZn8GpscK9El0w6O89NeA==
X-ME-Sender: <xms:mdFSZ4X1qt8gHx0eICr_kugKyx9_qNiay7YPdESuAObIHS_Vet_3WQ>
    <xme:mdFSZ8kj8shOdXANxTStQ8iGNNLSX3Wl9bCwoz2_LuMHhPDJmBKag4aLnErmIhp_E
    MVCiImSTrjtuYBvKA>
X-ME-Received: <xmr:mdFSZ8Yq7F3WJFmGRLOAylig1WL6xTeBUYUrpkM1NGKB101crZ1iuogn-zwfODcF1v15IlxpfAucWiuZTl1-fdnqUGMR5XPfIhJQWVyStVzD2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mdFSZ3WGZ5PkfK6AWTqx92wnuuzybfaL5RMa8tHP2oy8h9Go-zzCeA>
    <xmx:mdFSZykiAWwuR3mJo3OVHmMjS7Fw_iVZeIBhOjVsk5HcxdIorcyTwA>
    <xmx:mdFSZ8f93o3OADkejWILWr1hw1Ug1nBwwhUPS5KhYJW84nmgfqfQug>
    <xmx:mdFSZ0FpBLhvTW9LuhS0B8wUGk8rBkuZAEMa98XFfrQ5oC9y1HXgaQ>
    <xmx:mdFSZzB_R2Aq8_r9O7DjMv3GvZgK-AnrTjo5lVBoBPzcP3T8kwALBvxM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 83943075 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:16 +0100
Subject: [PATCH v4 01/16] git-compat-util: introduce macros to disable
 "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-1-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index a06d4f3809e5664863d4d0f312c88b3e1364ee74..e283c46c6fa06e4079851296a55c9bd5472a65b4 100644
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

