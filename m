Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6B1B85C5
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848661; cv=none; b=V0YJ6Q1tl/fPP/gQmNDoDxaWo8vuXurRP+H3BUnB+DV7VJKiaRknyq8PXSgrqbQCUaAMmnUntCj2aGtB7CK6sDiyAw6MbH5hmCt3UOSarUaZWrvxRt8bfyZarADqWx+cUyXBJmp95ddgVSoORMOq1QgqjFRfckfP6y97DKvGCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848661; c=relaxed/simple;
	bh=WOlUFlEY5UxreIDxSL/97GNYpWyx8mITNHz223DfQsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjYavYPOWCWD1EXzPlRRSfyuo2VTT/+Xw8iVjW+EkuVR3yp42666jQUWpokS/uljpPuPXefcJ7DrsCueZBpbnt5403TyxG8J+h5ygyVKce4qUXj5Rmry2KVla7kKRBqNNiIk3p11n9ZppljJca1MSgrP1cG/JVILWgulW4tSfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pJ2buR8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOGJACpE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pJ2buR8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOGJACpE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D5471140111;
	Mon,  2 Jun 2025 03:17:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 03:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848659;
	 x=1748935059; bh=7Ha1FlH6QjZqe4c56hFunHnAz0DdpwiqBRT+P4Cotqo=; b=
	pJ2buR8mh9OJTQYobeSeuBgz8TpGVDmVoduX1Qcc17LXfbLzmtSZ7hI5E4bzpgDg
	PwmhhwHDhpPmSGRrfGSoh+OVC2M/82t27EsCJ7nOtlTEu9C0MaNK0u3V3+gUYTMc
	en2bTU/GoFwZUvqoAKENJUkME7svt1pBD5nFJquEGIjH0jZkUrXJW2lOewqFhJK+
	KBEjdn+EZuIZ+y4d00b3MzUa8MWBkONeeGWdAHEwDAvnGjQD7jzh4lSEBBkhWo9f
	cuTKid4LVGUzvdINeS87QASniFtxp9Cmv9v5D+yr5UbbsSPF86OPYgo2JMvnWCQ5
	hG7Nuwxytgju4wg1UXkJQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848659; x=
	1748935059; bh=7Ha1FlH6QjZqe4c56hFunHnAz0DdpwiqBRT+P4Cotqo=; b=d
	OGJACpEDy8+/lFBR5QAdwFocWeGT/FpwaP/KCslGEYoZs/xKDdmYY10HsJVGJz9g
	ijXjYmj4dnh56+DNAvbVSn5Apl+rjiiClH4cGfn2t+7v++HKuBwzZ8ZcFcPYlaAd
	phDo9FBQVm0wIoMitIcb9wyFPMe4evlZ5WLv7nL73HQQADIATDnZCheJaklbNx4M
	vLxhjzwml/S6tkmZynhTBv3+SvM4LpZiXCcXzDM0NbbvngcwiDtDIZfmeCNtDTxl
	V81Y3Ubj6rHCXjY32GCZRUB2hfpAHE+IsjpkNONkkhWXnOsCZU20FaFjLrO4q6p7
	veNDRxA3kHz0sEX3RnTtw==
X-ME-Sender: <xms:E1A9aHgrFgJO_j2cKwWTmXxFaqy8xXbs4s4MRX6mzv_hkrFf7DTH3w>
    <xme:E1A9aEBuFDlsolVgQZIY1pQWfLt7q9376VcZKPrgLPwD1lJmGBgZaFmQhBJrmogy4
    X6E0ktBQf0Aor6-Uw>
X-ME-Received: <xmr:E1A9aHHJIMP3L5zH1op_N4qxD8rCc-uzhc39EO9TrWIwXpgg93gBRD8UcdEi-_UhAWnUpSEDEhAxhRg07qlcMmr7MqvS34odfQnf_xZmxazEPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihroh
    hthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:E1A9aES3AIETDRY65vFu5DOWtPOdM1DiP_AtjvdJmwltnmawg5cmWg>
    <xmx:E1A9aEzk6LhjY3BTsJ3s-6VPKNaMIrxmY3oJPiZn4A6CqMlhT85Nyw>
    <xmx:E1A9aK4YPNeftAwcANowkPO2PS0vYzoxQAb-YETjBpVm06ffG_7XwA>
    <xmx:E1A9aJxnyLn3DkhMRVFFjGRN8lw79-Dg-AYixv2i7OdCI3OfVrCayg>
    <xmx:E1A9aBlFRwUbBIF62N-7laz0FOE8rEWPdmkepB2AJzzFM9wcDWHWP2Ea>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7fbf2a1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:33 +0200
Subject: [PATCH v3 07/12] builtin/maintenance: fix typedef for function
 pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-7-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The typedefs for `maintenance_task_fn` and `maintenance_auto_fn` are
somewhat confusingly not true function pointers. As such, any user of
those typedefs needs to manually add the pointer to make use of them.

Fix this by making these true function pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cfbf9d8a2b9..447e5800846 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1533,20 +1533,20 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 	return 0;
 }
 
-typedef int maintenance_task_fn(struct maintenance_run_opts *opts,
-				struct gc_config *cfg);
+typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,
+				   struct gc_config *cfg);
 
 /*
  * An auto condition function returns 1 if the task should run
  * and 0 if the task should NOT run. See needs_to_gc() for an
  * example.
  */
-typedef int maintenance_auto_fn(struct gc_config *cfg);
+typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
-	maintenance_task_fn *fn;
-	maintenance_auto_fn *auto_condition;
+	maintenance_task_fn fn;
+	maintenance_auto_fn auto_condition;
 };
 
 static const struct maintenance_task tasks[] = {

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

