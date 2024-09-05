Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF71198E89
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530929; cv=none; b=SRdXEoMGx7pNUVBMklAveSnuRf/g7Xr2hZUAEf38P0InvUi2ALJKzinzxt/1nF9Nq8oBl00cZGFoDdWedFBpLxM4kI/Kq70rEo3pPgzIPyOHHU451CdJU2uulBrYjy3U18mUuYte6tJD/tcvQxLe4ILlKwvtokW2DZCJrwAAY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530929; c=relaxed/simple;
	bh=NmdwQwH70YSI3EZP+4+Gpf+uxPmMSoVE7vtRuyGtN/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adjcmLmip0MqjRevA1H7IFSuU6fwUXX8QOp3N8lNv0eZVG5VxCsFLpyI8ViX8bSi5Xb7Dv0o571Xzuw0TqXZp0iJoKpQR+iPtSo63sv4Xb+9KeJL8JF/q3clifVL/zeKz3SY/Qb9cOyUkZTQa4Tme0zy9mlE64LbxRsyQHqGdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TCUFsCo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4xTIlos; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TCUFsCo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4xTIlos"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D6788138034A;
	Thu,  5 Sep 2024 06:08:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Sep 2024 06:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530926; x=1725617326; bh=0RP7rwyPbP
	zTPjPjN1bM0BZAfcyEU45jtjyxDwylACI=; b=TCUFsCo00KNiC6TmQagTis1aC4
	ctuNaKHVcD57FFv+s5xmxzR4hUEgjUYK7Nj0zh+rImq/uHUkssCDly8GzEPsIPEg
	XJywb6nZ31AZwRtaN74qSjCf+RTPd9ILw5hBbNfu51/LQi2bz7EQ4v4Bqd5lhGiS
	B1kcODQp0nrvuc7VtZZRHB8uurZnGVdcuzXX9FBpRWgsnfOts7auS7jwjKhHwzVi
	3EhSggRUmmVf/xqfr9KA+TdU/nWQOOjC/Z+lVVeeTZPMt0M1W1OVTTWc86MSEjev
	chuuZmwz92UTe23MLpcjggNS8lU0+JAHg07l875KkgJKdVOHVVF7177nOuHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530926; x=1725617326; bh=0RP7rwyPbPzTPjPjN1bM0BZAfcyE
	U45jtjyxDwylACI=; b=R4xTIlosQUoOO+2q0wZfuRLtKwqoa01Y6qiWaPw69sMa
	V9yElpqBVpIW3ZXNnfMwbbPLpBUQjR6JzHAb8tiobBDSPJaC9fh25gV+rvaJh3dc
	DFy7/7utPDgytids9IzoZ5SCb2CWOCk+8BDotmwA6LfFpCdb9Lrm2Cm5KIjrW8AH
	E3mCXq2Sie+/GrEH4HCmvYQ5MfsXzo1JBIDEjzQkfUB8Vcabt3/CNuhAYFgxEoTK
	QRPlEFfjzr/soyrrXxuNtWrwvIZTzk07Iwtfq1LoLWwopLT1HlA/vIkK5SK47PoD
	/PGKLrKN1MPa4wQ6cRCPjOv+siBA1DpVa6QWRPgC7Q==
X-ME-Sender: <xms:LoPZZpdppBMFQ879D0qADSWg4auX_s4r8NXr18tn7eqmMAEhJ0572w>
    <xme:LoPZZnO7CKUuIOQaDKAs7IcwuM8-NhyeTaVrTAult3yKfjcMjHz0cRh7y5GvOo76p
    Nb6qwVqA4LRVhvZeA>
X-ME-Received: <xmr:LoPZZih6hZyr8P3YPZlaMxVqTmnvdy9vZtC4iX-QxkVJjgMAyIcMp8OLfy5lUGEdfIgxElmplSYPhQi9IWDNC_1wiTMOWkHmFTMqJ1AI9L3DMGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptefhgeefhefhveeffeelledufeeggeefledtjeeluedv
    gefgheejudfhveefhefgnecuffhomhgrihhnpehhthhtphdrshhhpdhhthhtphgurdhshh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LoPZZi9fWCLT2JIG1X_Ta2LioO9TNIYZZBEvkcjdDzduM23Jq2RHXA>
    <xmx:LoPZZluFvMLML0zyCOnnNeeun_EsPb-FxeF-QhfNX1Wey3o5PZ0G0Q>
    <xmx:LoPZZhEm36Qy1oaYqXs-QKv5kzSYhod4BgW_poiFG3-eTc78QoFjVQ>
    <xmx:LoPZZsMMgPcxTWfEngtPAaPFOuzfFjoY760GgKehubUJsYLHgrvLZA>
    <xmx:LoPZZphia2nw6Q_ECeUN9Gyz4kmCtglhA4n3O01xvUwN7eExOIlRHAA->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f668152a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:33 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 03/22] send-pack: fix leaking common object IDs
Message-ID: <0d969962a39bb48bc1831129fb154997bd06093e.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

We're leaking the array of common object IDs in `send_pack()`. Fix this
by creating a common exit path where we free the leaking data. While at
it, unify some other cleanups now that we have a central place to put
them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 send-pack.c                | 34 ++++++++++++++++++++++------------
 t/t5549-fetch-push-http.sh |  1 +
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index fa2f5eec17b..b224ef9fc5e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -508,7 +508,8 @@ int send_pack(struct send_pack_args *args,
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
 			"Perhaps you should specify a branch.\n");
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	git_config_get_bool("push.negotiate", &push_negotiate);
@@ -615,12 +616,11 @@ int send_pack(struct send_pack_args *args,
 			 * atomically, abort the whole operation.
 			 */
 			if (use_atomic) {
-				strbuf_release(&req_buf);
-				strbuf_release(&cap_buf);
 				reject_atomic_push(remote_refs, args->send_mirror);
 				error("atomic push failed for ref %s. status: %d\n",
 				      ref->name, ref->status);
-				return args->porcelain ? 0 : -1;
+				ret = args->porcelain ? 0 : -1;
+				goto out;
 			}
 			/* else fallthrough */
 		default:
@@ -682,8 +682,6 @@ int send_pack(struct send_pack_args *args,
 		write_or_die(out, req_buf.buf, req_buf.len);
 		packet_flush(out);
 	}
-	strbuf_release(&req_buf);
-	strbuf_release(&cap_buf);
 
 	if (use_sideband && cmds_sent) {
 		memset(&demux, 0, sizeof(demux));
@@ -721,7 +719,9 @@ int send_pack(struct send_pack_args *args,
 				finish_async(&demux);
 			}
 			fd[1] = -1;
-			return -1;
+
+			ret = -1;
+			goto out;
 		}
 		if (!args->stateless_rpc)
 			/* Closed by pack_objects() via start_command() */
@@ -746,10 +746,12 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	if (args->porcelain)
-		return 0;
+	if (args->porcelain) {
+		ret = 0;
+		goto out;
+	}
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
@@ -758,8 +760,16 @@ int send_pack(struct send_pack_args *args,
 		case REF_STATUS_OK:
 			break;
 		default:
-			return -1;
+			ret = -1;
+			goto out;
 		}
 	}
-	return 0;
+
+	ret = 0;
+
+out:
+	oid_array_clear(&commons);
+	strbuf_release(&req_buf);
+	strbuf_release(&cap_buf);
+	return ret;
 }
diff --git a/t/t5549-fetch-push-http.sh b/t/t5549-fetch-push-http.sh
index 2cdebcb7356..6377fb6d993 100755
--- a/t/t5549-fetch-push-http.sh
+++ b/t/t5549-fetch-push-http.sh
@@ -5,6 +5,7 @@ test_description='fetch/push functionality using the HTTP protocol'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
2.46.0.519.g2e7b89e038.dirty

