Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94B1F4C96
	for <git@vger.kernel.org>; Fri,  8 May 2026 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218268; cv=none; b=JdVBGY3SDPtzLI7domnJtCOsy+Ar3DCd4nFw07IxMLgShm4EHUYyCWFSH3uujBjJW8DSPeNytshFKBPQHn1aKYdOa/n3RDmY3H4bJ5eFMNhu/4piLgEVZHOUGMhGJlGuHfGJnfDs/kipx0LLOYhfJSYKqEbjitTESeu7XixR3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218268; c=relaxed/simple;
	bh=c+NlYE4o9Ut0+F9uUGO7AfChztWA8Jf1TnNBTq9kjr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3dAbuQlRTP/zpvgtlNh8X7FDfeGnRoRJOGrLZ14UBm20rWk9amelIIE5xEZREJ/96RkjNj+ZO564qOVxj+Rwjj+hWyC3pNlcWyRX9mIRJXibbp9GQIycgZH56E3t6adHg7NJOVQn24/Ya2M+rDVoieVwA4+LYX5dhe0ztwl0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=afJkTCzm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQ0K1r2j; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="afJkTCzm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQ0K1r2j"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 062FF1D0006E;
	Fri,  8 May 2026 01:31:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 01:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1778218264; x=1778304664; bh=G6RQW8Funzj6DL4KiGs+vsNu0pAGj2jb
	HRZL/ooIusc=; b=afJkTCzmTYGONM7pEmCsJeVXusS7bhkP+5GcTyFKB7HM1el+
	ee125O5KuktVNOoslIEQ5eFLrFE5Bixhpl/uWWEGCJXmYoGmeXHSX9Afncpzd072
	VSI/qinYemVv4EVtgqLet+0rCKxYrBReFleC0o6ziKq+e3fIwwusFskOfaYKsv9m
	2/sCfjYU3kbyYdn35jngvnfVyRf5Qn1nd1BoQKy04ABPTMy/CuQeNRcfVlk5XtNo
	wG2xb6wGmWg/56VoRo/lnYsdT8YoWOvDZaiPYKuKEm/QOvD7TraSyRetoFujfWwg
	PtiHWxb6tgY3amexKTtyrWT6fMGIl2V8kl8XxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778218264; x=
	1778304664; bh=G6RQW8Funzj6DL4KiGs+vsNu0pAGj2jbHRZL/ooIusc=; b=r
	Q0K1r2j/9U11erAYz+qF8gTP+Ce80LhA3rZjVSTWe6wg/l/MXETcSyAfDo90JZ5/
	U5UrXdUY2hOVoRmAqtRbZJE/FqE08UIHfIjKpbbtoIU/SKo0aTWtRj0GTzHtv2k2
	mQoYkN7hiwCgzc9vbU7hH+kmHbkmrGcopJXLCPWhip3JccNMEUOJTTwLhH2oP7z3
	kteP03W4sp3qps4Rf+Pg9Ptgt+CxdrAvitbPTNCBZJ71Kx47dzhZFWCoqxJEmmwC
	FVRrmKKSrBXc6DtlFhBp+646yIPsQxMB/bSAfHtVWvYvTeT0g+6QYrmRuifnzAlT
	8E+icuYmZro9+mUBBkSNw==
X-ME-Sender: <xms:GHX9aZqF6RF7E7IHFgNyhyWxy4e8p9nS07mxnMenI3t7Pwdyttffdg>
    <xme:GHX9aTE2QNZoc5Xz-FcGLBE5V4ZG81ftt0m9I3N2DVgiArKAE6H37sSmrfu6naab3
    2ZHtjVOjNRb3crJu-quRE9Zk1tWKACOKm3Rgkv-YhNVrK9bFp_q>
X-ME-Received: <xmr:GHX9aTkhsZFAb4UM8pwqOE3eMGqYb1xxtCHwGGKvu8I_eYUXrjaUtirCRqOqVvXtdBwAGZ4KPW0s-juEPoN1JF-eKN27Tu5mKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepleejfeduteeftdfgtedvveeigeffvdffkeejteevhfeftdekteekueekfeevfefg
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqshhmrghrthdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:GHX9aenemiOY5wxQ_JK8iCFiOJroHEueuZ-qSGnzAsQdBL5f8Z-t5A>
    <xmx:GHX9acu6Y0S6VAMjGb95jRmT7IFqlwFmU95svcusirrLDmdlpo_TQw>
    <xmx:GHX9aZlr_v8l5ZTA6ooehYQfd1pkjZSGZ5WTU-Wtj0-d3Hdm1E37nA>
    <xmx:GHX9aftP3uD7Oiz3BMgWfwNIsDOjHiSld3vTn58OSsBQm9ttRY8GgA>
    <xmx:GHX9abEnrA81q-K2scfBTQKQw22glUTFSext-8ul2BknSjjKncojX4fV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 01:31:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] t5551: "GIT_TEST_LONG=Yes make test" is broken
Date: Fri, 08 May 2026 14:31:03 +0900
Message-ID: <xmqqqznmeaco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The "test_expect_success 'tag following always works over v0 http'"
test in t5551 fails when it tries to run "git init tags", but this
happens only when EXPENSIVE test is allowed to run.  

This is because the step tries to create a repository with "git init
tags" but the EXPENSIVE test that runs way before it creates and
leaves around a temporary file "tags".  Have the EXPENSIVE test
clean it up after itself.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As we should give individual contributors a stable base, I have
   identified tests that fail with EXPENSIVE enabled in "master".
   With this fixed, we should add GIT_TEST_LONG=YesPlease to the CI
   jobs run upon PRs are created by contributors.

 t/t5551-http-fetch-smart.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git c/t/t5551-http-fetch-smart.sh w/t/t5551-http-fetch-smart.sh
index a26b6c2844..e236e526f0 100755
--- c/t/t5551-http-fetch-smart.sh
+++ w/t/t5551-http-fetch-smart.sh
@@ -481,6 +481,7 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 '
 
 test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
+	test_when_finished "rm -f tags" &&
 	(
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 		create_tags 2001 50000
