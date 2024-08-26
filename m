Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF912E1C7
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656912; cv=none; b=VtmqJj/5gtFtnKQPCO5M7E7NKxrcJ56kHXnelG6UcM/WxnDAytNMJMCmijBWb7Fknis6WveoLg1QDYncUDY4SBYCboyij5eAx9KsPYX9Ql2FHChPJ2yrGpu53Uz+2sTIQoSRjclrgPY6wWBX9hbolEZ79bbRHLoerhT7H0XWo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656912; c=relaxed/simple;
	bh=WC/5AgUF892GYbXDSd8q8kr0+uFNTp/ma1Y1S4v6uFU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfhE2Jkq+h2UqvIL/DwVUI3jgM9subViJYqrNf3PhzPGAUyFsBKFy8o8XeEnCa8AI+7Fp3HxoiBDHOULk2y8vlcD28/NMjoN8xRnSQaiWB/OQkzGG3A+F5tDYiW7tBmiT8IhDNepPOnMhjyhi12tZ7LLz9KRcz9oPUUw80UWliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nejs8bdb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GwsuNB4z; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nejs8bdb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GwsuNB4z"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 27EB61151AA7
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 03:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656910; x=1724743310; bh=Vg23uvHDsu
	R5qkd9ozb+QiWcuxa6pF1S7gMbVivwp1U=; b=nejs8bdbQUxM1jvJjC2HXmgS9s
	iWKUF5c95jgN/WaDVsM4dbGts6RenQZk6nOqjR6ga1AKTQGX8tm3FACtWFrmcpuK
	GqUKST7qbaL/EpkHXA2k+i1plocbxvvx96eBoknFIQxx668OpuxO/AzKaZFWCHKK
	BHOJrMqH4kCnh3GIg3DzQhRVqcjWoQxcJj5SNYjXzr1Ho6Qv3lAAZkU8W74B6voS
	/MCtouvTqzj5UH2xSEoK2jOVolzIH22NVqPcKqHPghS2ziSNHgQdObY5lbPCD4nm
	R2EskRaXBwA3/WBG5x6ANwxwPuozpQrgIf3OA9M1x0hhOsDhos82rKxJIKwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656910; x=1724743310; bh=Vg23uvHDsuR5qkd9ozb+QiWcuxa6
	pF1S7gMbVivwp1U=; b=GwsuNB4zisIIIddr5OCWBGghyv+pktaEXMUgSENZSp/U
	hZPXSnCULCthdeqEEPx18U1aO9sscNQEAXXv/+pfehLpJiybJf2nrkIdQkcgpzAS
	ftrACoJd/PiF0qaePS9ipQ48ZJj9na7lnP7kcXRMoRBYlVUsIkpui2Ig/kYd3dbq
	86NhAbwV36iu3Z1aILG78Ixedw65MwqzxBtPlFiqOOQNX5+/9UBHbcebeOqWKOxp
	Ll4cMta+HX/h6tkzdCNjwjGFt87mt1c3I1Z8BPtQsHpTGdb35LmblXWI2rsAY7v3
	XA8KosRYn7lmq+U/iYsAr/g+x8oT2vyUXCr1FwYSPg==
X-ME-Sender: <xms:Di3MZopRYHXpmMwUywAzhMc2SWrKPVg0hXSWmr_wf69lNnA4OMEU-A>
    <xme:Di3MZurPcqJsSIL9eJXqQhGS-xJvXHwvN2hiG2dsryp-klu0DxrEmHzRwVv8SNo7e
    PJM2jxK-wSsVAGa7w>
X-ME-Received: <xmr:Di3MZtMax-ClR2GjEVcjmtrd41kWiKmmD1LHWiINz8cmOwyw-i7h778mMnkIpHVGkM2mCvUMn2z0y-Dc3p7E_ecZVMX05JeRiKFJ9YJyHO_OE5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Di3MZv5pR5ApOb9NzH5sNmxC4Lvnv8_0wDCpVXpqFfis-mv6Tfqb6w>
    <xmx:Di3MZn4ZDs5M3QMoHrY3i50eZfxB3IUZOED6Cp_eZAqqfxtf0cHz2w>
    <xmx:Di3MZviq9qupldAA00VWNxfBFer_ZxHfrg9uvQqoh1bQ_jeJ8YdDuw>
    <xmx:Di3MZh4t3_QU7yQ7KSnSPREQq0rhFGbJwW5m-Y-Aq8gf3Ho1MifN5A>
    <xmx:Di3MZhR3FiNaf6qYxWQB59dGoApi0N-Ar0tyYG_ltjqKreiU4p_-IMg7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 481e2594 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:47 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/22] upload-pack: fix leaking child process data on
 reachability checks
Message-ID: <77023421e189aee6837cea9b25841ea258bc06e3.1724656120.git.ps@pks.im>
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

We spawn a git-rev-list(1) command to perform reachability checks in
"upload-pack.c". We do not release memory associated with the process
in error cases though, thus leaking memory.

Fix these by calling `child_process_clear()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5516-fetch-push.sh |  1 +
 upload-pack.c         | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9d693eb57f7..331778bd42c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -19,6 +19,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/upload-pack.c b/upload-pack.c
index f03ba3e98be..c84c3c3b1f5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -709,10 +709,13 @@ static int get_reachable_list(struct upload_pack_data *data,
 	struct object *o;
 	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	const unsigned hexsz = the_hash_algo->hexsz;
+	int ret;
 
 	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
-				 data->allow_uor) < 0)
-		return -1;
+				 data->allow_uor) < 0) {
+		ret = -1;
+		goto out;
+	}
 
 	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
 		struct object_id oid;
@@ -736,10 +739,16 @@ static int get_reachable_list(struct upload_pack_data *data,
 	}
 	close(cmd.out);
 
-	if (finish_command(&cmd))
-		return -1;
+	if (finish_command(&cmd)) {
+		ret = -1;
+		goto out;
+	}
 
-	return 0;
+	ret = 0;
+
+out:
+	child_process_clear(&cmd);
+	return ret;
 }
 
 static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
@@ -749,7 +758,7 @@ static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
 	int i;
 
 	if (do_reachable_revlist(&cmd, src, NULL, allow_uor) < 0)
-		return 1;
+		goto error;
 
 	/*
 	 * The commits out of the rev-list are not ancestors of
@@ -775,6 +784,7 @@ static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
 error:
 	if (cmd.out >= 0)
 		close(cmd.out);
+	child_process_clear(&cmd);
 	return 1;
 }
 
-- 
2.46.0.164.g477ce5ccd6.dirty

