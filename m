Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB71AB6CD
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109997; cv=none; b=fuzaDK/SuqKw1doU2YNQ/Sh4P3URcYHXepQHFWz/irxOOWw9QFvWXwkumYo/VaPINJGBXRgG3DabfOrsxd9RL7dFCpLoiZpBVLvBCgZPNuqCQ16fghNOKo9LloX7YCsEI0tl4MgEL/WlsXjjHgo9I7JyxfPgfk8ZSBd/Y7KCSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109997; c=relaxed/simple;
	bh=G7WvZAUVv++KwM/xhvHPvls6A8BNIhnM92a60diVpCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsEh1uG1OSqwQ9EKDeV1QYAFzaUxfZmD0+3aThXjni57h2cGvsm4sRdjjdKzshxpAs5z82UshjUB1m/Mz2aFA4oQLICkqrGFJd3XucKf4J+zDwbAPsP4lhwhA8/mldbVE8Pb2vx2BO+SdgJwYdTILQUp9uB9p/PWJc/AntIEX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fCHaM+FT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yawf3WSm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fCHaM+FT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yawf3WSm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A6A311401D0;
	Wed, 20 Nov 2024 08:39:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 20 Nov 2024 08:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109994;
	 x=1732196394; bh=RMSGEiYpC0H9UDCAdTPScmbQYDQ6UEK/WihQv6nS1Ms=; b=
	fCHaM+FT4N51IE5uUI30Y19gzjNrBf+DehK4M9ttZlZY/xxN8J/DHWXe5wAKheWc
	hDIx4njCFW3XOej1cmRE4WeoaytLYfeB1vGKupDywxHg0az7KbOf4jWsiCKt1wfc
	04FXP+uWPWhRmhasg5fJKcq1VZ2UYQLoOJuoIz/MKkGDKEKryZQzWzWSro5euNkJ
	uBQcotvPZyekeHx4//9+oq1aULerkpXFv+c+4dkDUBctDIYwx21GVp7dar22hngD
	pgWoLnBab97C7Htn4wum7u7ynXnX/mOo30boJCLkyhVoGvqln5W8PgisgyYYI75l
	4Fn8nUqc6wNg62xW0/u2/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109994; x=
	1732196394; bh=RMSGEiYpC0H9UDCAdTPScmbQYDQ6UEK/WihQv6nS1Ms=; b=Y
	awf3WSmRCm2/NOCXDbSWWl9W7JyEXYXUDhAwgiIr2jPp+KnG1skGhOwtSLhogncf
	X7aRCqUlgsRGe1tSL+81gJ3PJ4zaaM8WMzjhQTwEG7BlqFSUB7MQAdDXN0R36Xai
	NxTVB9CcL294wRKTDIqC9vDGKUhx+wuZy6ft20QJSiFUm1dpvn4HbE5X88Y6Zbfh
	lF5+AJq69I2jQGpVNQJP9c7dutX/G7nhkgtPQEskAKaU2U+1OoTUdcALRlXFNbxV
	bvWf5WCuYE+eEEHskpqGen5OjsiuUBxd52BEidaHYqhQHvmjG9ksLx1L1SkHmV8/
	tGNukQFOo/OXPp2Gc/g+Q==
X-ME-Sender: <xms:quY9Z0o7zBy7_lIRKQJBiZ6BY0vZZfaH9TJyDHtG8oG3KatlQ31j0Q>
    <xme:quY9Z6rWZ9yQSfbp42Ws6hNwRtbIWldAXNLGfOkf6_xcHWCgwNy6TSLEjWXhS5M7K
    ET-ZkA3jj_5rxN9YQ>
X-ME-Received: <xmr:quY9Z5N6K2ubH2684rQD5OiLoyNsD1twFJHQWw6WjINfof1NDAF2JVrI1FOhvd5SivVMCyHyXE17vtn6hwGJ-O4gxIsmEM0y7P45p0qXWCG50Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:quY9Z76uCnC4OUg8gHcMXhVO9dsNDMtBoEX_A-LNQa53OV2COCW4pQ>
    <xmx:quY9Zz7f9mQY2hz0Cl_p3bH-WbOBO4QtcSBqEm_5_6IEEjiOvGn1Kw>
    <xmx:quY9Z7hdvdvcBgLL4krtMSsDldSzVyoFJ1uivyvX74HmoG3sks9ZXQ>
    <xmx:quY9Z97IERpWhwBlZodAs9GLr4d2-LECuImlRTAUM6oJ_NhMMoF4Jw>
    <xmx:quY9Z21VFKeKB4Votdys_-UyUz2_c4_Op5RoPPjcErWU3hMWiBHL6Arv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f09028e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:37 +0100
Subject: [PATCH v3 08/27] line-log: fix leak when rewriting commit parents
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-8-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

In `process_ranges_merge_commit()` we try to figure out which of the
parents can be blamed for the given line changes. When we figure out
that none of the files in the line-log have changed we assign the
complete blame to that commit and rewrite the parents of the current
commit to only use that single parent.

This is done via `commit_list_append()`, which is misleadingly _not_
appending to the list of parents. Instead, we overwrite the parents with
the blamed parent. This makes us lose track of the old pointers,
creating a memory leak.

Fix this issue by freeing the parents before we overwrite them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c          | 1 +
 t/t4211-line-log.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/line-log.c b/line-log.c
index bca9bd804073df9b77b2859063ac5ad4d3b24e0f..bc67b75d10d34edc726c00c887d57016e40f3a00 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1237,6 +1237,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			 * don't follow any other path in history
 			 */
 			add_line_range(rev, parents[i], cand[i]);
+			free_commit_list(commit->parents);
 			commit_list_append(parents[i], &commit->parents);
 
 			ret = 0;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 950451cf6a66e6c099aa5303ce19230c34cd1fc4..1d6dd982a2a858e9ca03635eb83b1463c9c9caed 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -4,6 +4,7 @@ test_description='test log -L'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '

-- 
2.47.0.274.g962d0b743d.dirty

