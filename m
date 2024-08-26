Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08E13B2A4
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656940; cv=none; b=uTxFvxsV7G/FzI0CdR2+R7wmxsHxlYibz3DFsD79h5GNZ0i9ANZeWvhTgDKVFZQfQH1zXB/rEAb19ni8SmErYExE9wodvrtN91PzUiGoFeH073kodgDc79pwf0tvQP4Csaka6QKpvXQCDBW8CssNNw+5A/+eD0DBq0cYMZ6cXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656940; c=relaxed/simple;
	bh=hxKdzmblehKtoi/6iiVVDwRdlpwS7ClQwzv2NAdhNHk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5BJOz0C/IxX1mhRFIHAwbZH4+4L/rp6k0zWF1G5QAe0h4xyF2f6Sg4k7xHiEePvrvqIKwgQKsih5isgIgwNIvTKBzjPtYe36I3JmFlFDup2mLb8EYJ4CYpdKmUQ0h5UwkXnuwdjJ+b8VbLtbckhgLFLFSUZOICaXa6aVi/x2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aXDnCaAl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqI1cR1w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aXDnCaAl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqI1cR1w"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B6581390824
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 03:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656938; x=1724743338; bh=5EQhvc6MpX
	R5gksLhElsxWeVCc7KkJZsR9M9PagCoXc=; b=aXDnCaAlfzRA3QfKm+gz7U9A9k
	MSKp+eIFeAu6ukC5tPnXCWyCmLJRJvtjPnqU63qlGBafHajsC4pVIQb4LKnP+0Kd
	Vo9hb6dOrf4mUpAipUfcsH0l7h6UeFUlJLo0bwqSxg6/7Yo9M5z1UgIiXBXzBxbj
	GwN6fwok11Hy3N0HsTFHaX9zhHJt7tBa5kzIaDlZ45YUFXCa5O2nprMdTmOqsshz
	Zlk8InxFi74vd5/tqw+EZv/e8wfNeoviC8B8oT8vKv+LT/1PlNt5WadWddO7eHZ4
	Iqax4vMHBr2tkd/E/Xb0a77Yq7u2NEEZFv2F8Rlbgo93qWQlIff/DRgqBhTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656938; x=1724743338; bh=5EQhvc6MpXR5gksLhElsxWeVCc7K
	kJZsR9M9PagCoXc=; b=mqI1cR1whGKnQ3ML/PX+tgOA9sJpWM8qNznxcTWd9u5b
	WJhpkCL2b5Fh8G1RHiWcEFwBfDultZLlOynpYyIlrO3/FE4LmDNU9A32x0JLrR0n
	gyB+dXhe6U4uXPFIebHbM1mOU5dbWDizHQtm3cvwNGdhkgM4vsN0YxvV0073hpw9
	YpVVd0Cnr7nGJE4HtpEKB/2odmeUsIdIz/fwvsGDU0IjtvETNGLtDEaM7MCTCeRT
	hoEfur5qREnq8yqahc0Qblb6Lgav5B6VTeirgD/eaOW5DaMi68gh9J0peu84BNJf
	YP3cRB23PoicoYWdEw0/Oo69wwmXwbpu/Faz6tl52A==
X-ME-Sender: <xms:KS3MZtYMxSCzwz3uD4sOeXcnYgvyW4dUsTFixlRjy3L6U28Hkg3Img>
    <xme:KS3MZkbXrK44HmQw3UDJWddkFVSOe18YqRQARFDsGaLFK-vsvuev98VIMz05Kj_I2
    _e361acxXkxvoi1Og>
X-ME-Received: <xmr:KS3MZv_k6MgrTSnJEYpuamwZ3FAjt2StAPNdBwYkvgvpmqrxMXGWcp10ci3dSpAYms0QQ0b7FA-9WXUKPvCY4PjCfVQ-MdeXz8LVjQOiT4hAXow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ki3MZroG3kqLWJU8jsXZ8wSwMGNIdaet5mmIyW9_nVilTcY_oPpZuA>
    <xmx:Ki3MZoq9Txb3I7br37BjR6KvGzQuuyCVLHpbz8AONBBMPfS3Av75yQ>
    <xmx:Ki3MZhRMXAyHGnPTMZT-2xz77v6A5WsA3_w_0Eg_bw6aJDdShaNIeA>
    <xmx:Ki3MZgrusxzKgTtldvuj74YWvmhQojZUDHvCqakJNQsBzBWWINuQPA>
    <xmx:Ki3MZlBvBSduuE5Px_Az8SHYiP8HausSa6T7WtJOxgl2_fTTD9oQbg4F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf4f219b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:15 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/22] shallow: fix leaking members of `struct shallow_info`
Message-ID: <2a63030ff09f938d705c117406b501ecf81f67de.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

We do not free several struct members in `clear_shallow_info()`. Fix
this to plug the resulting leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 shallow.c               | 9 +++++++++
 t/t5538-push-shallow.sh | 1 +
 2 files changed, 10 insertions(+)

diff --git a/shallow.c b/shallow.c
index 7e0ee96ead9..dcebc263d70 100644
--- a/shallow.c
+++ b/shallow.c
@@ -489,6 +489,15 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 
 void clear_shallow_info(struct shallow_info *info)
 {
+	if (info->used_shallow) {
+		for (size_t i = 0; i < info->shallow->nr; i++)
+			free(info->used_shallow[i]);
+		free(info->used_shallow);
+	}
+
+	free(info->need_reachability_test);
+	free(info->reachable);
+	free(info->shallow_ref);
 	free(info->ours);
 	free(info->theirs);
 }
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index e91fcc173e8..6adc3a20a45 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -5,6 +5,7 @@ test_description='push from/to a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
-- 
2.46.0.164.g477ce5ccd6.dirty

