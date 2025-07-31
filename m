Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5A1D7E54
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973834; cv=none; b=D5jzOHPyhztgpu+6iRA4Gg5bpyuJdRf70dlZ6Oo+RcNoAUBXDTA1ux8SIljnQimbbFB76xSgn+onuQqOzhuJCnySJvtGpdUIjTSizIlmDQdIg5RRQFe3tN9qKadm+4bgPHpJETJAP9cQzz547MUWfzqXfa1QGfv+tyMwO7U7lhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973834; c=relaxed/simple;
	bh=wrbUIwWnBzXRDwHJo0d5skjpA1EwdIoX6pXZW7NDVO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kz9iS9a6BcS2E3AnNO17oX1kmVgpD3iHZILJD0dSUGVJE1xVFVYsWMPOzIPMf6rcjNd8NpShgQWCPrBzXIiKbHku4evHxndeZknI+VHq/DtEJSGSKKjD4QR9qINT3qRdV+0vyC8gjAzgBy+RrVI7/jl24CTdzy5aHq2P06GEWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cvNe9jPM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U7I8t1Sf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cvNe9jPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U7I8t1Sf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D5858EC173B;
	Thu, 31 Jul 2025 10:57:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 31 Jul 2025 10:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753973831;
	 x=1754060231; bh=5/HKvvCrN/i9ixeZpp5Uhkh4QC1++6vTWZvFZxUSdEA=; b=
	cvNe9jPMzz23XQ49iD27ft1Nf+HyY00Bx+dieBlK4bKZUIFhGlVuQzAQdvQyoupT
	e8GTc/V/n30qKoe8cLz1IO5XDFraNmti7j6jpKR3+We3FjX+YNX8v5y6huaNH8/V
	+4YRRcuf8RMjIQF4lulkzokltO6pCQ+lIY3HKcbL3e19qQndLxqJoYBrHa5tCug/
	rSKHJIhBbd1sKoO3/cu9nq+UsWM0E4Lo38WjjWd8BH6X73JK54e9f/e38n4JsUCJ
	TE+0B0tiLTiydw5XhSuKNa+PwAa0fq6KbB4Iu9XvnoeYZRcza5TEHl0vatUsXq7V
	OEhs8Kdw5DDneLAqr8ejfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753973831; x=
	1754060231; bh=5/HKvvCrN/i9ixeZpp5Uhkh4QC1++6vTWZvFZxUSdEA=; b=U
	7I8t1SfWVdX2cx9mE9tFG73yp8do/AIZB508ZlxRSCmDt6z1cQ6QNo43nVmzIUYG
	EC6rdg/h1qcGl+DJJdqDOVVcx23g6YXBvIbJE3zWyBr/eFAATPY/8diiz6+9VvDz
	soc1z9THEd8CRxoHkV5U00PSWbnXhpfbhlss8RAk1YzfM8fBHRazfr/PYprCuR3Z
	cbv93d3d4BWilqQSi+SdjvH5+ST4CQG1Y92olBSalUDvC8TpWv3nFGj0MJrxqj5k
	XJPoEqO++RNHNKQkacw3FF8bp3JMgPRR0P/YjYr6wVNBHhU+vTOrE54CwilVhyul
	IstJQK2Qbs9G4FAx5k6Bw==
X-ME-Sender: <xms:R4SLaLOmEtQaerIeaPEc2f07DGbmgM0svrG1p2UYxpQV-0nskFzTvQ>
    <xme:R4SLaOYmfT3pMwZpboocZxfQCiU5IvAF8M4uRtkHI-vKY82pNOMFc6xNnEgW8E9jx
    Ip6LOxKZ-eYjIU9jA>
X-ME-Received: <xmr:R4SLaKujMdNYDq4A4k5xeXxfwUiqHuPwEfFNCF1L0aj130iCcvPe44dkp6trpPhG971SNJkqs6rfCGQcWSBPGBkBExGR9G4xeHj9b659VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:R4SLaAMhSBdfuJKGvC0WSpiSQkgz2L4Gzii6AkTjEONuITe8AQukCw>
    <xmx:R4SLaB7fUk-L5tdaeEv9qlciA70q1l2egaceQ2VZR-XqUjnT5dltlA>
    <xmx:R4SLaGRqbvwjdeAeqThW3oi9K0I4G2Dx673Ynids_67BtNyL4tgXzQ>
    <xmx:R4SLaOAol3niN2ZPscslmOzNXz_Gkqj4ABrEyRxUKDE7VE_Sd_kpDA>
    <xmx:R4SLaKppfVQjUsKzCVMdX6dnU1k-hoJxO_hCVz7PyQQGHgoj70Q8ANoT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 10:57:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 173b7ded (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 14:57:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 31 Jul 2025 16:56:52 +0200
Subject: [PATCH v2 4/6] builtin/remote: determine whether refs need
 renaming early on
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-pks-remote-rename-improvements-v2-4-dda6f083674d@pks.im>
References: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
In-Reply-To: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

When renaming a remote we may have to also rename remote refs in case
the refspec changes. Pull out this computation into a separate loop.
While that seems nonsensical right now, it'll help us in a subsequent
commit where we will prepare the reference transaction before we rewrite
the configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f63c5eb888..34ddcaf5f6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -741,7 +741,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 		old_remote_context = STRBUF_INIT;
 	struct string_list remote_branches = STRING_LIST_INIT_DUP;
 	struct rename_info rename;
-	int refs_renamed_nr = 0, refspec_updated = 0;
+	int refs_renamed_nr = 0, refspecs_need_update = 0;
 	struct progress *progress = NULL;
 	int result = 0;
 
@@ -782,11 +782,16 @@ static int mv(int argc, const char **argv, const char *prefix,
 		goto out;
 	}
 
+	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
+
+	for (int i = 0; i < oldremote->fetch.nr && !refspecs_need_update; i++)
+		refspecs_need_update = !!strstr(oldremote->fetch.items[i].raw,
+						old_remote_context.buf);
+
 	if (oldremote->fetch.nr) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
-		strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
 		for (int i = 0; i < oldremote->fetch.nr; i++) {
 			char *ptr;
 
@@ -794,7 +799,6 @@ static int mv(int argc, const char **argv, const char *prefix,
 			strbuf_addstr(&buf2, oldremote->fetch.items[i].raw);
 			ptr = strstr(buf2.buf, old_remote_context.buf);
 			if (ptr) {
-				refspec_updated = 1;
 				strbuf_splice(&buf2,
 					      ptr-buf2.buf + strlen(":refs/remotes/"),
 					      strlen(rename.old_name), rename.new_name,
@@ -825,7 +829,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 		}
 	}
 
-	if (!refspec_updated)
+	if (!refspecs_need_update)
 		goto out;
 
 	/*

-- 
2.50.1.619.g074bbf1d35.dirty

