Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB412C54D
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656908; cv=none; b=p/Haz0WRtppVws7coUU3B2OULMQ0pCB0mawB/VjR4RbYS4CropEmdlnt1ctTivniYf4/QL244TKssNzlD4nuDFfRfqTkmYVrt7sCuPSBaY6HxmBh3t6QOW6eH99jsT8z3qazZSvy821pW9LJiJaaXxrMNleZvU2JKXnVrzekG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656908; c=relaxed/simple;
	bh=HzymrDDDsKtR1d7tENTc3ovwbVjGioDmmhL0J/MX/Uo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rttUYfqRKgFZPvf2OWfG+BINTkP0GWqAIf7w7L5s4IQ3XrWkj47X7dAs8xZnuJvUyUBdfhHvA8MjIOpI4wcR51b6OsJVcOBpPmGqHKYClRGkGtHq/VdI1vbdmFeaIc57E9jQwIda4r4NHEwALgvObZdfSRnXccdij0B2+PkITaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iCO742PR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hd3Ad4kE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iCO742PR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hd3Ad4kE"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 600FE1390588
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 Aug 2024 03:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656905; x=1724743305; bh=WYWz8+UTOt
	qlzlTY6sQ7k+op7JkFSJq8uGAVlG71E38=; b=iCO742PRXTyPYALmGdbOEsLkGZ
	aMaq4FGxxbH6/1FhLr1iHu2cUB3FItDxIhQBIdKt4Mzl3atwodSocf1AW8TC0Slf
	JgaNpZnyQiVYQM+z0lPVdxzLsQsC81N/OfXeal80IGx6E2bxQuI3386H5opVIPcZ
	21eS/o0uZ7s1tpSx+SlyJAVVGqMAuBJFL7+du0rieqhM+vYL8znJlwbUxqaY2F62
	CG6kWM90kXPAksyf98w2PECrOrLhS9pqecAw8oFVwTtYsZ54u1A+i8EA6aF55j9y
	U/jVFTpU1aNegDLYQ5YPX8IhbiIXRjHvpcpKWgHXoB+pLhtudOLPiBCLfURg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656905; x=1724743305; bh=WYWz8+UTOtqlzlTY6sQ7k+op7JkF
	SJq8uGAVlG71E38=; b=hd3Ad4kEGcBi4/71sRIj+KZjmkTCWfP+LKKWQDMWj4X+
	t28kyW5+CsHyRcrC3vbhWS/ULhldahstWfRkcioSsVRZL+usI8zIVdcILnqyBRI3
	56B5e7y7g0SkA0HUC6QtE23JEOHhtUM2q10wCyNGmk4jgFd7lfO6GTq3/tpnE7c4
	yXKSY7XIrBM6FmQpWmDwMRaL1DfdoAF4bcaOvQkp+ixH4YlJD3qzMuTh4Rr1/kkw
	+CeXNpOVdLQfQrS5sFyYihHOfpEte+IMoj+M4Ta42Z8e2T48GNV8HoTNKSVuhShV
	jiunaUorls7YV865pZyTKUy8zrPQWTe5NAda5mTo+A==
X-ME-Sender: <xms:CS3MZpqVjIHMjA5pEPhJUlF4wX6jLp-ckx4lNEW6qvng7rAkCihIGw>
    <xme:CS3MZroqMjW5hAIY5Y3aqru3zR5VO3dA8FocCnV7YhH6mpigsVcmmKa5baANpSozc
    2MyldPMAFYgO9YlLw>
X-ME-Received: <xmr:CS3MZmOll188X_wnx1VAzhnnuRPjFgQSwadFxj2j2SNk4PCtzbQOBk46QB7jaqxqKRnf8X6-SEhVBNufdXXhUorZvUFXn4bSxpc6xahtbQ4ZppU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeekleehtdefud
    eileevffetkefhfeeiuedvgedtffeivddtudeufeevjeffudeileenucffohhmrghinhep
    hhhtthhprdhshhdphhhtthhpugdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:CS3MZk7JT4hkTWzf-r9SGeTd0r_IJATMsow5ihAaSnZv0ZHFUwIQNQ>
    <xmx:CS3MZo6OAC21qyJxASZZsjWD8OCFtAoUsG7sBjb6wXgXgQmZEuJZRA>
    <xmx:CS3MZsjiHrliURfOqWTDdFPWskgDQRZRSy5-JDpQQU_RQdWd-Z-X8A>
    <xmx:CS3MZq7Q44RlRjnkGfnzPEd-jMk4eqGlYqmQh0PLwQ2uL60HbPxVpQ>
    <xmx:CS3MZmRw7cWIRIDZ7EaWpyz_4V2amCKsAesqNJFdrFWB61C5Rp3HGfML>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd23c945 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:42 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/22] send-pack: fix leaking common object IDs
Message-ID: <a13db9777f096e2000bfecc3eaf900df7e58ddb8.1724656120.git.ps@pks.im>
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
2.46.0.164.g477ce5ccd6.dirty

