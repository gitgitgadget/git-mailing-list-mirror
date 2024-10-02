Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FC195803
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866532; cv=none; b=hd4XD+Lpt9NIVrsCeLTcAll3RwJyiThyV8UqyxJO2Tdwga3cvl6HB2EYiFSlZLyEUGqua6mjsFCPNhATownv3zpVsTvldsbVI6WVHftivCzv/qfUEowJdEJKlFXQQRkG862eW+SMfj4gwd3KYKMNyecnvsavT4H7aKoOzoQXDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866532; c=relaxed/simple;
	bh=r/wNwOqsurCUQapI5uCBonlpAYPKOJda2FJDht6aSDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWYM0atHLtwg5OUcLcyO33ViVKdXSZJyHKlX8MQ2bwCRDkEBKd2pTimjMrb7QoWRMGLzOheVtpzHIpmvs+YXWxPJpDgtzvKVGH4BG4g/N/v1TmMG9MrExaiGVO9sMx46HrT6Vj6RJDZOUd2qlWf9JmWtOUZoS9O0Qm6P8XmK2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JMtUSl4A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJSEandR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JMtUSl4A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJSEandR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9965A1380253;
	Wed,  2 Oct 2024 06:55:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Oct 2024 06:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866529; x=1727952929; bh=KfSspmcjDG
	ZrR6/wFCt+5RT2Kk+oo/sOeOkgThDD4pI=; b=JMtUSl4A4DoVJE4E/ACDLcutyK
	SRGcI/XPWSfhrFZ4VK+YKKnP4/2qsATXgGVfOSetsL1Up8vKGsYtEA9TzkQAVtmo
	402tw9DOIa2SXXsUKph7I//DBDWF+n3JmThWsrr/6BUdazbXk1ClDAmK1JAcim0N
	00Pd+JQWeERffHvEix+0XiY+bmiByvH1BUk5xPDiSEFFxdx+nb5AA7/WcakbYHbc
	24kB5q4jJREXfX+kw0aqNF22mizt3QhF59r/S5MWPnqvPUOve1OBStwOQmI5JmtR
	5QH9Vkajv2bysNIcpdi+bXogHsn5m4oeTCVTWT8KSKqO/RqtQ1UClr4MYMJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866529; x=1727952929; bh=KfSspmcjDGZrR6/wFCt+5RT2Kk+o
	o/sOeOkgThDD4pI=; b=jJSEandR44pn3XvriSu2b0hSoju7sq56MPJxX/hFsRA2
	H3j3jtfT777iYugzykxVWjaabg7ivbMbqph20UD7zr7RT1BMYleAyn/NI8HMeG4z
	vG/3CdyRHTMRnCVfdlwOdoEI4uRQAE3cdHS//YdRgYNMqs0THkzKrVIoWdXOIg/A
	qnIBzZIDSPGaP+vt21h3JtPsYi2TzedIo1OV2h/X1IB5nORmBSiuRE77b+O0qxOy
	M5laPkEcQk1zHOIo9YfbfGN76beBHThoOFEZ3XvGPRYczHZxNmmob0cQuvVUXMwE
	fbbmMAQ6Y/0/PC4HimYFfb69AAofHGo0qrrFpvduOQ==
X-ME-Sender: <xms:oSb9ZvLm-ZwM9v4vqvlZU_kU4euWeXKFNsQY8u4PYJuCZL4ziAUzng>
    <xme:oSb9ZjLd8mZD4nwBanwKmWezSpBqOUjs2kE6cHLWRGe-1vKUTl_k_W1DcMBIes_tX
    Fr_-Ine1-ZqbpGaIw>
X-ME-Received: <xmr:oSb9Zntym0VemmvVR-Md1NtsD2YFwd1kZh1B6iZFW1ezc-LTIgDxKFKgaBf90ANRSt6Mq8dzKiYnGPB4jzGPRWl9FsK_RN6RzjaR_28t79gQD8RJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhesvggu
    figrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:oSb9ZoasUcQAmCPHyr7zlO5tf4h3QDYFADXpMjJeRbU8IJ898NJ14w>
    <xmx:oSb9ZmadknNQc8GfzNQP2qSXuUcOd7nfM7pUFf8FEcPX7G9MmC7QNg>
    <xmx:oSb9ZsBExf1nCZaoK3rnXVSjG9_P7tEMTWos-ya-N9mpJmZItdv8Iw>
    <xmx:oSb9ZkZXYJzylsDJtASnDE5EqEeet-xY8N3pwhmshgLtDhW13XwgTg>
    <xmx:oSb9ZtVIr2rCSdCYI8OmUNWVvXYsOnqpPuEUHDkEiJE7PXOkID1UwrND>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad4c4f30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:37 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 01/25] reftable/error: introduce out-of-memory error code
Message-ID: <94eaef3ae5ee008b5140272e4ce572c041f9c5a2.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

The reftable library does not use the same memory allocation functions
as the rest of the Git codebase. Instead, as the reftable library is
supposed to be usable as a standalone library without Git, it provides a
set of pluggable memory allocators.

Compared to `xmalloc()` and friends these allocators are _not_ expected
to die when an allocation fails. This design choice is concious, as a
library should leave it to its caller to handle any kind of error. While
it is very likely that the caller cannot really do much in the case of
an out-of-memory situation anyway, we are not the ones to make that
decision.

Curiously though, we never handle allocation errors even though memory
allocation functions are allowed to fail. And as we do not plug in Git's
memory allocator via `reftable_set_alloc()` either the consequence is
that we'd instead segfault as soon as we run out of memory.

While the easy fix would be to wire up `xmalloc()` and friends, it
would only fix the usage of the reftable library in Git itself. Other
users like libgit2, which is about to revive its efforts to land a
backend for reftables, wouldn't be able to benefit from this solution.

Instead, we are about to do it the hard way: adapt all allocation sites
to perform error checking. Introduce a new error code for out-of-memory
errors that we will wire up in subsequent steps.

This commit also serves as the motivator for all the remaining steps in
this series such that we do not have to repeat the same arguments in
every single subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/error.c          | 2 ++
 reftable/reftable-error.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/reftable/error.c b/reftable/error.c
index a25f28a43e..660d029617 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -35,6 +35,8 @@ const char *reftable_error_str(int err)
 		return "entry too large";
 	case REFTABLE_OUTDATED_ERROR:
 		return "data concurrently modified";
+	case REFTABLE_OUT_OF_MEMORY_ERROR:
+		return "out of memory";
 	case -1:
 		return "general error";
 	default:
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index 6368cd9ed9..f404826562 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -57,6 +57,9 @@ enum reftable_error {
 
 	/* Trying to write out-of-date data. */
 	REFTABLE_OUTDATED_ERROR = -12,
+
+	/* An allocation has failed due to an out-of-memory situation. */
+	REFTABLE_OUT_OF_MEMORY_ERROR = -13,
 };
 
 /* convert the numeric error code to a string. The string should not be
-- 
2.47.0.rc0.dirty

