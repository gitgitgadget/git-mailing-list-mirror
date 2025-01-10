Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD520B7FA
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513740; cv=none; b=joCoBjbHGKZwbcWxHbpvoXhl9ybCJYwpR8fkER9U1QQANzYlGzYCyl38pfZZ2P/zzh61/AF3VJoU6R7bD3LPwJ+8zp85ukYpBEAzJyzjhZaSmo2ETO0jk8tg1IWLP0ltGrxQuXMNEKPJzTV1Kdq0tmee88ghc3EnvvYFA5XaHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513740; c=relaxed/simple;
	bh=CN47lfkQEGh/MIFggTTeVWfInfTVJyw/mqnUcHuvQuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRsfytw+k7i3AMEzI9CYczPi0G29E1I7MT22wNfm87fU+4mY7GE6UvETT1XH4a7goPdxkBowkuOiAYNO8WEvIjZId6R/iKUGNw12/LQTlAYoGcQ0muh6HcSJoTJ/DgZj9BT8VrtjsPqA6uwxUVCD34S8FU00aS/rtxWrHV4BmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gHoNol8g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdfpZSaR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gHoNol8g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdfpZSaR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C300B25401C2
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 07:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513737;
	 x=1736600137; bh=K/19v4XSfaZ5z1ldSZGdR/9m8JSOwJ1YEr4m4Ff9vts=; b=
	gHoNol8g5Z0O8lU9iCzmilOIKB0Kiz12d50WxcjXkW++yih0BcjN7MrvUr6DW+Yv
	DAdGlP9xtt7U3yI6d80sH3G0MAp6gMVW/ebc0c4w9PVXB/EtTZB8Gdt94Cq3Dj3C
	41BeY1qRiC1HpWXE8Lehb7umnn8IJB/GzMHFdeAw0CU99TYwLwnrKYm86eJOriud
	BZ2bPMCW8vUF75ZXMC/mjTQLrXPoshmzK2dySu7ZibomqnUB0u2kStaXFNLoD8Jl
	8pd5TVXmz3CrGfl1IfPljmYsPp05JL9kdyqScAf4mqqQdH6qiNjo8pKi7UMevxLu
	eIiw1CmRqTIbfhjLPvl5xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513737; x=
	1736600137; bh=K/19v4XSfaZ5z1ldSZGdR/9m8JSOwJ1YEr4m4Ff9vts=; b=g
	dfpZSaRDhdWOC9zvDoxqmKCATED7k4WtKIfj6BhqCFaYLk4KYmzK0OeMKxuzshm2
	KE0t98IaH3MrXay0lFwR0qpRE+RqE9Z/pSjo6kGhs+KrVa2P3UhumNRZwO+t1JpG
	U1+nZ0KEgamhNLQpTb1vi6wUgDimOHb/NXebbEOFye7XKmN6Nn3zsLGZPOobReXl
	wFTq/2LWojfaYhUbA6o0SPu4cWV3KjepS/PIIUhIiEFR6VOlgg6MyAN4+SKLTu+J
	3krbXcpa+TNTPgSAXyLzJA3Cht3JWLCsLsCLvv/f01/93KyAtk29md4PJQ6WTRQb
	vBxii4QhEjgBrZ1+vtFbg==
X-ME-Sender: <xms:yRiBZ5nCA3mC4DJksiyJT_ie2KTvsLdTsdb5KDdQtYu_9sn-x6ZtVQ>
    <xme:yRiBZ01tcUJ51oIG9Gt5-VznY66Lem6MYx4kRIPED1ymBvjCfiQkipKZTTCOlMJA3
    Koh7mV9yNl-0sgcMw>
X-ME-Received: <xmr:yRiBZ_oP27KXBU9hPOb8ZHAq9nB3MlgLdYenTuh7WiUKuQ14VIEZi6DLL-HR3YgKRuE2RpPlOyOXDlzcDxxahAQt-xIaHbSnjXwChwiU-FHBzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yRiBZ5nV-8I1WStEtbW-goKz5qdIyWwENWyyCimqmmAfyVk-SnfOng>
    <xmx:yRiBZ30scRrOUTQSs33bIAqHyAoLMgM4OvoTAEkpXf10ViA-wv0sJw>
    <xmx:yRiBZ4vbStrO9sWU3t_pXNUcIb9xUaYuMCSuoAtx6a86qneHF6xIYw>
    <xmx:yRiBZ7Xt35MOntZyo02CoPm045i3MYloPGsCcivtgN8YjcbySzF5Ig>
    <xmx:yRiBZw-blI3iTpCVL07I9CSav9pvkMBvU0JOlCnqaCLAqaRTwrPuNmF_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 062f9dc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:29 +0100
Subject: [PATCH 2/8] git-compat-util: drop `z_const` define
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-2-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Before including <zlib.h> we explicitly define `z_const` to an empty
value. This has the effect that the `z_const` macro in "zconf.h" itself
will remain empty instead of being defined as `const`, which effectively
adapts a couple of APIs so that their parameters are not marked as being
constants.

It is dubious though whether this is something we actually want: not
marking a parameter as a constant doesn't make it any less constant than
it was. The define was added via 07564773c2 (compat: auto-detect if zlib
has uncompress2(), 2022-01-24), where it was seemingly carried over from
our internal compatibility shim for `uncompress2()` that was removed in
the preceding commit. The commit message doesn't mention why we carry
over the define and make it public, either, and I cannot think of any
reason for why we would want to have it.

Drop the define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d50f487c00d7958e871bb9a98419e55f866cdd1d..c4b4b372b473ca0af2a4f5f60554f6d3df74f112 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#define z_const
 #include <zlib.h>
 
 /*

-- 
2.48.0.rc2.279.g1de40edade.dirty

