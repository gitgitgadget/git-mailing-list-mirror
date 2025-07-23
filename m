Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC7214A97
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279728; cv=none; b=E9d8V9qoPbpBHnWewtXKf8Sqonj5e9th8MLfToN9jZkzs6ncIUuR1gGGlTlagLPJHeZgjuIOS3km9mvdv3WITd2A0+25tz5wV9dhkCCO6j4yBm24pO0HkhTdjtSjE5Z1HcHp2vFWVbMu84eoKVzeJYgGo20p4WAkASrkaNL96Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279728; c=relaxed/simple;
	bh=fFJOwzhMAj6nax+uQhWovCodHuGzjlKEX4J0/22cp6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPh2GIJy3OIClJsDjmAcqGy4T118piH5UyHqrgAnwFyWyG1k8QQa8TN0T/RLVIJYygJxNb9nn0Q+UNtOlkKi3xFSZ+1Bozd7YCAHplU2xXvYpRjv8Bq+YqXMfb2a8AARRZDdOM2XJXx/OCGr7Vzftokh7Db0tHxWCUNMvGDqwoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cPXjHGfx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STGMWacA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cPXjHGfx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STGMWacA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3450DEC19D2;
	Wed, 23 Jul 2025 10:08:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 10:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279726;
	 x=1753366126; bh=HY8PqVoRRZJEsCI8UhWbDuKxc8s9xMmVGIOvFe7F4EI=; b=
	cPXjHGfxyaHJnp+9txQolSyVH61wHBLdwfPunFMe6IRK7AqTDqaIkdLuwYOGjeyt
	zCgKdwy34JbINCIRsXZYqR6N82wZAhfuJIdFCAg2PND/RGFnp5CaIa71ryK2f+AK
	I9obTwYTa8VloEQiHX3aehNkVfepnfuMgfKsdkW9r+aiPHX9+DRIf6ooTzyqaNE5
	Yocwhwoc6E0bGHA20QUCMrprc+Qy1YUHhooq2JpD//S3ucUHsoKF21aoPeQEK4Gn
	v2nNbuNeP39BdpRVrh4Y2Cvnw5J6qQWF5uEAao5MqrG5/7y23ZXVEnafmHxYYscp
	IFoIiaPnTgUQI+0imem91g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279726; x=
	1753366126; bh=HY8PqVoRRZJEsCI8UhWbDuKxc8s9xMmVGIOvFe7F4EI=; b=S
	TGMWacAR3dGSIeGRFS8e5SV6hJz82vaGrEw1rqdsQKQylfBOcUPax31s17r4p2Db
	xkNO2nZtFbMjwjUMUZ4K11uyVl4zA0KV8FECpL8DcfRGKPTw9i59MgZdM63bWDo7
	QpyXOUkRrFp4+c2Ngd+jBtMixbP3/dSY5r77Rh23AHBYnzAHmAXZ0IzcJKbKDa0k
	i4GXcl8/JfzeXpmLkhxrrOrmAIEUxe47noJW5XwmazOUqo4btrpqZ6de0tqu5Khe
	uQJ7mDxHen7+AzkvXWaK4rqFAqMBoMdWYuvjK/GWZ43KyQUEoATOAW70hx41SHRb
	KviDzYE4a13PRSbP1CTkw==
X-ME-Sender: <xms:7uyAaG-b3NrTISmfsGFLQWRGApxJtTuPq08gp0iubMA0cCzd-UEknA>
    <xme:7uyAaG7eMCSp-WPUm5jvirjHejmkK4h1jSsEQ9w5vq3ArCXyTRokrSJ3GXNstWP_-
    VsgAiQWYYGMDUcETw>
X-ME-Received: <xmr:7uyAaN3R5-n4FTS3x1o2kgrGGf0zE7N91ud4CUEfnkllllr5ocnty-XzAJ1qQq9XN6L8I_5oc8cpaSbfR6mAKUptSEc1vE0SVjupKBk5VtCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7uyAaNBmw-UozZ5S9_Cgbdh4Hrg45xolHhOJ0FZOF3rmv4S3spjIOA>
    <xmx:7uyAaP2R6Senl5O-KnvqWKMDQy8vrFwglDcsPreN9lZQ7pSYlQ6sTg>
    <xmx:7uyAaHspba7uxfDCFmZBXPXOG8rio7McVcjvZQjVjvvsOn6gMX9JEg>
    <xmx:7uyAaP4i9fCAPH9fHbQ0ZcMaK294VYxhuaGdS3JVOOq0TjEdDPYt_g>
    <xmx:7uyAaDMHLfxhpb56x_b-YDGh2d8tf-61w-mSSd5CeTmjq9hkvJOy-O4R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6544db0e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:26 +0200
Subject: [PATCH v2 05/21] config: drop `git_config_get_value()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-5-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_get_value()`. All
callsites are adjusted so that they use
`repo_config_get_value(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.h               | 5 -----
 t/helper/test-config.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/config.h b/config.h
index 5dc330b88b1..e90c1c4d335 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_value_multi(const char *key, const struct string_list **dest)
-{
-	return repo_config_get_value_multi(the_repository, key, dest);
-}
-
 static inline int git_config_get_string_multi(const char *key,
 				const struct string_list **dest)
 {
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 99c91512173..1953ab846e4 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -121,7 +121,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
-		if (!git_config_get_value_multi(argv[2], &strptr)) {
+		if (!repo_config_get_value_multi(the_repository, argv[2], &strptr)) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)

-- 
2.50.1.552.g942d659e1b.dirty

