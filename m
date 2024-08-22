Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78017C7C6
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318249; cv=none; b=rKAez2KNkUVf70xGCqwIc3WhmreceFAJlY1HgQqHvkf6r13SuvzjkclLdusnqya6HaUdnX6e+ZVPZE3CqMPy+q8ojyRubrd/lmEV4BpNh4o32aOEsOaCvZwTYlXqX46L5BtCpK1SW9QbD9obg9J55yL4sLssBRUleFb3aEF7JqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318249; c=relaxed/simple;
	bh=mcRQa9G7hy7QauywfNNmby8ICn9wUCkZYmWcBv9yqGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4pEzfGMFhhRgdupgmQ3PkAIzfJPpxaOtTIUA3n4OISD6FHrA7YTf9U11AFC3EsTq/MlpqTHEOGMU/gulxX2KDodxGtZJDhZzYDLEGOWr+UbVgYtUjhNH1Xi0OGtkOOQt+wfX6vN5HIDOcLx5CyDwfkh9qmwTtGqZiLyOcbctMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jv6GbxXM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWTrq9+u; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jv6GbxXM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWTrq9+u"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 430841390049;
	Thu, 22 Aug 2024 05:17:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Aug 2024 05:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318247; x=1724404647; bh=HX6AGxmsBS
	j0RUbqpwNe1xuthWI35IE6uoPJO6H0/dQ=; b=jv6GbxXM6R2mx1jdoAH1Ri7eIf
	P27bYDJDLcMSA+JT1QH/0p7btTkSlYUogdPdKehuNfH5vIrs+iULojcIx3CNNOoS
	K1OkABO5tNYFxAuoiH8kasnQUrlVxtCmxPR65hvUNxpD6JHeUuJaYabIyIHff88Q
	E65BKa9J+hB660qXdZWwtshww+wdzKdknHuth1IHfsvJfCkfgd1rsK07oVJ7CRH2
	8NAp5WGTM9oJ3UB8lEx4CrkpJE+sjRFA3DSZDEWXemXbPGS5MNbsV4nOQMMZa6N4
	+6+0DtQd6AJfzvVGvwes7X/fHJ+sVpUIQtCzZZFFb3P4l9NlcSGSs/4vj7Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318247; x=1724404647; bh=HX6AGxmsBSj0RUbqpwNe1xuthWI3
	5IE6uoPJO6H0/dQ=; b=bWTrq9+ulLwGg6o3+uMSPgSQhNJXxdnJS3f6sNprpUDx
	40Gd4pf5CtKG3AmBFsEX/UhXP8RbNFMsn1WPBFVf27g3iCX05HYNlLio0HeFC7FF
	hIBrZAjWE5+C59EXLhmLHq7sBNu9WZmortNxgz5JRinZ2g4jN/efg2Z0/GriPAvm
	wUw3YiBu6Ejh0iXv66VAgdtqZu2MGR3yI96rjyzwmQUoUZir/XDILLFjrfj36+XT
	hdpnjrVJSVuS9jVLvlKbvbrHp9PDzAsheck9a7MRUcUvLydTVQ98sgNm6jjN6e6e
	AuGhHxiklvt08AlGJ7pL6k9DbREb+BoVc1i90uoMXA==
X-ME-Sender: <xms:JwLHZmYEK7zTQLVI_bPaHwGbxq0OPDjI4nKC7M76Yw7kdTHpaOwO-A>
    <xme:JwLHZpafQo5KBlx2A1YB0ZDiQYfs9OLMWr8utkG60Mq2QvJuexRiltvyNYzpnzaXn
    ZhfA8k5ejo_M3oquQ>
X-ME-Received: <xmr:JwLHZg8PZ5f4BWWRFuLuTcZV16A2HMSorKzS7iaSAh5kklQ4XVvfUhIEhsIDwjGLWpFA6zvfLjIsMO2zYTvIzcmkDaDaBWvucvZRLvaxgqIn7k4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:JwLHZopPIDeEY2ZGHadGmH6QPDaMVuF9R8K0_KPzgg65NCskO6Us6Q>
    <xmx:JwLHZhqes7tAninvpOfsW1wq1ydV741XPyYhF1rv6XaJIkFwS0CGlg>
    <xmx:JwLHZmRJZBhkyDKbeCY3JZIv6dBAXdrf6fj3RYiUPK2f_jV2x_bKGQ>
    <xmx:JwLHZhqpcE-P-CseVS2zOgQjpt0ngFIFWygoa-0ExJcL8PVumJA85w>
    <xmx:JwLHZo2U5n3D0gO4eQF7udmJPJPHX9MTzalEqKcITP2gbCupmovAoMKk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d079212c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:51 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/20] builtin/merge-tree: fix leaking `-X` strategy
 options
Message-ID: <c62c5e9604e05ae7d65926b90832ba9aff84044a.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

The `-X` switch for git-merge-tree(1) will push each option into a local
`xopts` vector that we then end up parsing. The vector never gets freed
though, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge-tree.c             | 13 ++++++++++---
 t/t4301-merge-tree-write-tree.sh |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9bca9b5f33c..c00469ed3db 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -533,6 +533,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	int expected_remaining_argc;
 	int original_argc;
 	const char *merge_base = NULL;
+	int ret;
 
 	const char * const merge_tree_usage[] = {
 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
@@ -625,7 +626,9 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			strbuf_list_free(split);
 		}
 		strbuf_release(&buf);
-		return 0;
+
+		ret = 0;
+		goto out;
 	}
 
 	/* Figure out which mode to use */
@@ -664,7 +667,11 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
-		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
+		ret = real_merge(&o, merge_base, argv[0], argv[1], prefix);
 	else
-		return trivial_merge(argv[0], argv[1], argv[2]);
+		ret = trivial_merge(argv[0], argv[1], argv[2]);
+
+out:
+	strvec_clear(&xopts);
+	return ret;
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index eea19907b55..37f1cd7364c 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -2,6 +2,7 @@
 
 test_description='git merge-tree --write-tree'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
-- 
2.46.0.164.g477ce5ccd6.dirty

