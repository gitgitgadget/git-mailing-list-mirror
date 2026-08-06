Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DF3D6CDE
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997270; cv=none; b=YZ2ULTrAvliQfGZ5ITOBBQnBBHEk7X1QEPJ62lNtI8i1JGZrKEPR5QVdGnT02xNAegerH0pZ5RuaFjdigNzXjp/NpSDIVrJOjXOx1UozFbLTdKBwRclzN+DEns6D00mB3DhmPqkq2qVSxT6x9pICYhQdQRBFSB3pMa/ImhZV1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997270; c=relaxed/simple;
	bh=o+qjkban5oLvpd8b3UHvdCEAR9NpIFMawGRDUuDs3pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXCI5L1q5FJywe8qPS1+jgMnS1Rl+5BGfK8H+Horr8bfRjWY/4sU8nSYQWw0FNHSB2nFBNnA6V3307fCXKuOL3ck++N3AgA8gF+EoZjlm1FhDKtwVB9R88R1EjTkmN2u+MIGATJb7Gelz9AzRbcQpLZoaGTLMyi2cSaHUA2iDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RzLy19w4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbQTLZPw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RzLy19w4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbQTLZPw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC3CC7A0122;
	Thu,  6 Aug 2026 02:21:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 02:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785997267;
	 x=1786083667; bh=HRa2KQM9EMPJqsSA/av2EsP4Tb2/qpVcRg/BaVG9WOY=; b=
	RzLy19w4ntpAS6BuCvVGICo0XyrU4bo9PTAvYUHJh246BV8wUBGQfVj8mhN9PCUQ
	ZjOqpqSE86J1qKR2Miy5TL9QM4Gy//5jmcGRtG9mtN+7jHFjncC/Oj7xnXApEeLs
	Mow2Hfx9kSpudXA+Mh6K9jNjRFLpenTM/3frTDjvqz+GpPPIIj/O5D04HWG3pHUQ
	eMEEBnnVvsy7lVwHqLpETvFLaOr02mIrTYd5bPUIk0KZauVcg5x2+QUGBMQxca/Q
	R0M21RfsYIZ3cRlxNdJa3rjNkNUum08fgMscBEfXhWGgniSbGgqJcV3aMVB1eq/S
	FDXoURlHaVLUv8L9oPVUjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785997267; x=
	1786083667; bh=HRa2KQM9EMPJqsSA/av2EsP4Tb2/qpVcRg/BaVG9WOY=; b=V
	bQTLZPwPo/tUAnj4a5/m3F6wMeoWCFT7gO6K/YlpYoIzDHGo87LYsOcb9f0QbknM
	zr4GYGRJnuherngbqp0C+EGp8JG1Hhn2Wg4E2cLPbwKNeaaDLj5tlMBL0qdv0gBa
	Fb5cQ7KLEiwUPug4krC7M+dHrpjhGabKBtEtw/K1kutRIXABW+aItr1mh8CauoeG
	XZzR0K9jTC9vCa6BkT7eBVbCQOVQ42oP4Gw3MfFSeCoZ7oEZSHycYU9cPgP779rG
	pxKRQNJjTMkqOpgiA4MTlVyVPWAKJtT24dn7UeDoBuaIEsM1wyf9p8zvF8DEt1+6
	hcx1DqtYuXVzAztP+zfQw==
X-ME-Sender: <xms:0yd0aoVqBhlXo60XHaO-nJSDGajHh8aC1xNJOid6PfBi-Qq15l-w1mY>
    <xme:0yd0aje_Nw_23lkcMfwPhTwg790CottbDkdqihipvi6Y4VHCnOv7Tq8FLXuhGlAHp
    ws0v4Fq5VYrIaiuK0hzHi09m3M2sDbGG3cou5FM38FcUWAafgqurHo>
X-ME-Received: <xmr:0yd0aktnTiwbAZ4l1nUKgaie96_JFaQ2l7MTBaiSDq94xJagtrP6kfbNG0EiEFNpqbGXIohQDpwiKjlNLTi0GTAm-3VKYnEvHRQaoZc>
X-ME-Proxy-Cause: dmFkZTFhdQ2PvCZTQPE7rdyQfzfBRrUCpxo8RixZOF1sl+kEL9ioLP5AlFuPaXml2Le+Q1
    IuY2iO/fkpaciaS/feL+AdjygfJXCPouVMv9vg0hD96y3Jifamdi2n13UnRY5Dzittuj1Q
    5rs0I3K9aJtEyelHSl6NXjn/mUSm5lVGuok8Ie+6MUN3WPfUvLgCOe/FwfSldWfZhYDqFC
    gVXyhfQGSd3VzfUNOXuMXVmbtzgZv8Nc6FYzq+dAVkckq13Yayzo8A6ajypLhEwtnnVDpc
    TVLewLoyqa0wQ01/vBqBVg9vvvuNvoNgJB32eb4zAuCj0luznUXW9/ssnc0R/o0l1qUvo8
    2LWSegolpZNT4kTHlCISTu5lZI1acmU4EvQWFGU8W9kYUgYhXGu+ZUoWIIKZRvuEa4AR7s
    /WmjZFAm/wIWvsLXPtFaDpMvzOQTFCtHqAOCSSdMqLxJHBdR0ffzAac6OhvGp68aUuDK8m
    Fj6Bu4GZlOoq0PSklpK58TqSmzUxdU/mMiE7MxEoIYKmvFwqgCjSlIwIgP3sBRNAyI+/s3
    L6ixQJ9/5CBz6z7vlvBsHX8xM2C6iW7AfHuQuoAJyYAW2lZ/AWpgeNAGVFrIHfq1EupKea
    5T+PLbC8Yy/Kjo30fe0jaxpte72ujP3aQL9TlmqTUbJVJYRInEE6ncyqCRbg
X-ME-Proxy: <xmx:0yd0ai-H9BbwK3r78NElrCASKpAfLF9keByhwkAi3ukaqhMRn4GNjg>
    <xmx:0yd0av2F-w0wRsIVbubDZ88vICqabmixw6LiANx-XJbOqzyilLxIYw>
    <xmx:0yd0anC0sd2t-WNRRTMtYaHcp3h3PWlBTv6ZTbsl_HHugSLIBdQQgw>
    <xmx:0yd0are7P9qpxDTl9xCAUhKgLMjf6-ziiGNQjFocRl3Y_L1XWArO_g>
    <xmx:0yd0aiMaw1t_TBL46SW0IIIeuwxLSX_bpefAtySAGboX4VmxEP8XWbpD>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:21:06 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/2] doc: refs: put ref migration warning under the command
Date: Thu,  6 Aug 2026 08:20:21 +0200
Message-ID: <V3_ref_migration_warning.b24@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_git_ref_migration_warning.b23@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz> <V3_CV_git_ref_migration_warning.b23@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I have to scroll down at least three screens in man(1) from the
`migrate` description in order to see the “known limitations” for
it. This is important information since the text says that concurrent
writes can lead to an inconsistent migrated state. Let’s move that text
up to the command description and put it inside a Warning admonition.

This section made sense when it was added in 25a0023f (builtin/refs:
new command to migrate ref storage formats, 2024-06-06); `migrate` was
the only subcommand, and this section was visible from the command
description. A one-page man page. But that is not the case anymore
now that the command has nine subcommands to describe.

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3: add Ack from previous round
    v2: use Warning admonition instead of Caution[1]
        🔗 1: https://lore.kernel.org/git/anLvVAyckm7S9Vo0@pks.im/

 Documentation/git-refs.adoc | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index ce278c59bfc..3b5af936ed6 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -35,6 +35,21 @@ COMMANDS
 
 `migrate`::
 	Migrate ref store between different formats.
++
+[WARNING]
+--
+The ref format migration has several known limitations in its current form:
+
+* It is not possible to migrate repositories that have worktrees.
+
+* There is no way to block concurrent writes to the repository during an
+  ongoing migration. Concurrent writes can lead to an inconsistent migrated
+  state. Users are expected to block writes on a higher level. If your
+  repository is registered for scheduled maintenance, it is recommended to
+  unregister it first with git-maintenance(1).
+
+These limitations may eventually be lifted.
+--
 
 `verify`::
 	Verify reference database consistency.
@@ -130,21 +145,6 @@ The following options are specific to commands which write references:
 	Operate on <ref> itself rather than the reference it points to via a
 	symbolic ref.
 
-KNOWN LIMITATIONS
------------------
-
-The ref format migration has several known limitations in its current form:
-
-* It is not possible to migrate repositories that have worktrees.
-
-* There is no way to block concurrent writes to the repository during an
-  ongoing migration. Concurrent writes can lead to an inconsistent migrated
-  state. Users are expected to block writes on a higher level. If your
-  repository is registered for scheduled maintenance, it is recommended to
-  unregister it first with git-maintenance(1).
-
-These limitations may eventually be lifted.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.54.0.22.g9e26862b904

