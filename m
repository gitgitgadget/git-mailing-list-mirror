Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575517C7C3
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318255; cv=none; b=SVJwU45U26jWIBdXglf6yhZEKM5KtC7SXynmTdtrTTo4pK++VblwXqHmky0u/93ztknWskqx6OUks4w7JlssAw1OH3ZAFQ25cynRyyzGy+t7wNCtRd8zlhsahpfJ0pfYrZp7wTxXpSiKqJ0rUFGBoGCtzJSkOAc4H2/DfiR3UT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318255; c=relaxed/simple;
	bh=+efCFzN5AJynIXOyAn8If4Vqm3JpKtRIWXMyvKo6mk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhDhTTp4O6bfrVWtZyI76cIHVCQjA7+JIgH9H69bfVfGhKZPpZqlDe6Xjaxn6v/4p6LIoqNuMn0+6G5yNaKblvMzxQweKKOu2zqZ5ocdgpTCFopjr56FYsk+TTs4ltVRLBjPZPfcLjZmB2F2tiQDCEo+H42g9qe3ySdEgLwo/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PoYreMbh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oo4Y98YR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PoYreMbh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oo4Y98YR"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 55539138FF98;
	Thu, 22 Aug 2024 05:17:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 05:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318253; x=1724404653; bh=bAkMX/B++S
	8eeyt+CSPR2tJB/BpVSX65rkau1VWDiR4=; b=PoYreMbhG9eaDVAh6VaX4Dvl30
	1Pwv1TDMkM3HhY59UtntmkRHTuTErxePjvOIFXSWxqqXL56A3ygHsVXxxcv/lC8g
	bUT9M2/kx30iwPdoUrifXLrikLN9yTqREqh5BtCA85sxv5liBocqbBTOsZ4h3R0h
	IVI3Py0A9vHY856+VrZ3neznGYEn8mb62G67/dKIbgzdoKiTqi5rE2/BQpDiCfx9
	hym8QQUP+K7gorPIQyaHD7GQnV6zjEfbRhGlzg8gSSQ5HfFMtlZ8VIM9Zi5K1G1N
	p7FVFcIhcX5f/0HLu//KSCJUrp+SrlNoy2l4v4oANb3irKE/wnVrGJjCO+lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318253; x=1724404653; bh=bAkMX/B++S8eeyt+CSPR2tJB/BpV
	SX65rkau1VWDiR4=; b=oo4Y98YRmzuAgAdzkz/dda4tbdsjgFBHir8fXIbYqMBt
	5ZM81bhGb3agNblPGuUQ1mbe6LJMYv2p7RbZwt0OdHefylEiNT9uhm5Ge+W1K2LJ
	PPWZiNY0a1PnAn0J4NQD3TWn7oWFpcNNDubIqyxnZKhmsPbZodUxseTvEl2/LYGX
	+R/IRJq8tBu4MgzNmiJrq8A5ArWX87fxmXk511+aqs9HQ6KvSunxDhDjdzjhyddt
	v8F1MWE5ivmT53bhv6i0siNal+Md4YSp86bkWXr5GhZCayLQiKaeVVvUsNwWtEUI
	iIU+KDH11iOq4cWRureoCKDzq8CQ8vGaIkH//FJkGA==
X-ME-Sender: <xms:LQLHZolUZoj-KR2Nw862S0Auh3mYgHhLOFPigg6ZiG1nRnNulZvVkQ>
    <xme:LQLHZn0wxwdP6ZCpz29rE1v2JbHtRc0qht39Q5aDhtexQYRpmLbwj_NADj8ctd0i1
    qaGolJk_XXmKHwLOA>
X-ME-Received: <xmr:LQLHZmpL_FV90UQdy9AdrjbxV37VZlqLT5cM2XqxXcwtwWJfzNcnThCdJCOMv3OlzwcBM5KiBbT9HIsZiP9pR_m_84P1UCApGlRXhzpV9UqAmYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:LQLHZknEyP7cyLHr-p3QDB2-FtbegFJDhh_8iWw23-Nq45U0vp0dCQ>
    <xmx:LQLHZm3tZFmAaQC6c_KrLOj62p9ZcL4BK6OQ8sURR46cM-6yLg1WhQ>
    <xmx:LQLHZruhq6SVr2tjlh4es5DxSQ2tMtEp1XJJLbskzumaFB-35YLr-w>
    <xmx:LQLHZiVwYwVVPJQ2-JnQ3LIuaDirxRqiECHYpEfvtOSvaAA0RSSrxA>
    <xmx:LQLHZkBbBfbjKd5jrVCTj6O6xJ4kx5aIOE2Mh-C6AQXpa1zTvu4LX87o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a988ed0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:57 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/20] builtin/archive: fix leaking `OPT_FILENAME()` value
Message-ID: <38487f3f65b7ab0aa1351a15efa8494b6e040f8e.1724315484.git.ps@pks.im>
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

The "--output" switch is an `OPT_FILENAME()` option, which allocates
memory when specified by the user. But while we free the string when
executed without the "--remote" switch, we don't otherwise because we
return via a separate exit path that doesn't know to free it.

Fix this by creating a common exit path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/archive.c      | 7 +++++--
 t/t5000-tar-tree.sh    | 1 +
 t/t5003-archive-zip.sh | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index b50981504f3..63f02990d11 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -100,13 +100,16 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	if (output)
 		create_output_file(output);
 
-	if (remote)
-		return run_remote_archiver(argc, argv, remote, exec, output);
+	if (remote) {
+		ret = run_remote_archiver(argc, argv, remote, exec, output);
+		goto out;
+	}
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
 	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
 
+out:
 	free(output);
 	return ret;
 }
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 72b8d0ff02e..7abba8a4b20 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,6 +25,7 @@ commit id embedding:
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 961c6aac256..01f591c99b9 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -3,6 +3,7 @@
 test_description='git archive --format=zip test'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
-- 
2.46.0.164.g477ce5ccd6.dirty

