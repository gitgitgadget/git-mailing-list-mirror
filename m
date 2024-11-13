Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658F186E5F
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497074; cv=none; b=CM+yYU991jeTJkVcV0Rg2QD3bNWc2bnftfDAAJ4Oyvwv6/Hy2gVyGK1rFKTviVfwMxZhqdrhmvaeGhaeBscHpuwoHOx132yYBFa4AUgQm/i93qe6DlofYKn9xtf8l/wxX1hCAY5KwvwExEjAfr5r1mWeJM+9aD5hC8R0IEYIhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497074; c=relaxed/simple;
	bh=uQlxkJq/vVhh4iU6mTi4rJ3TAxWWvHT3AJMeQ5/cR14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWlGy8AFY3wCCRYcjeHWlsEVr3AiSCCJSusOeIEtWCtu3tf71bR9PAyChUD8DzAxwp0dRKSg3Hrvahzu5UEgiDQZfiTsSpaEfQbdTvdgHy61buCm3I22od6SzJuJ5EOEVKPygmW+jOZ3z/u3WyyIH0ydixuNz8mCUisrYUP5CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JcASV+H6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGl1Qkq+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JcASV+H6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGl1Qkq+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B85E2114018D;
	Wed, 13 Nov 2024 06:24:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 13 Nov 2024 06:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731497070;
	 x=1731583470; bh=VKn9vJuBHmQttnr7l4wjp+ulrF+cLUIP5gf0FDvYEEo=; b=
	JcASV+H6IHUwOZCkGJX8yYCC7KE+Z/A9HXUnUZ5GPnl99wHxsRBc1GcKizRxRHHG
	R+97SFDdIVoYsuxQJV1qm4xiPmKsm9h8YSOXHxL4MnvgS1dagQ5E8/YYkW8MpXFA
	kvNNxQa/6eNYMXh29HTA2eqw9Gjd4rJzUYjNnI6Ydxst8oXHNrKBYQ3mVhnGdy4y
	oAVajL8ew8ZBgIFRW34c4bD3ODO/L54sJ0pbbeLS2qKGK7clN3RIiQbS3bTsUVwd
	4cQdI0FLFONhalcEAgKNq35/lGkPyDvF4s38G3MIlWCTdaGWZw/C1pSUHyEr6chB
	DmUMYmAD62t1/Dr7DAZUvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731497070; x=
	1731583470; bh=VKn9vJuBHmQttnr7l4wjp+ulrF+cLUIP5gf0FDvYEEo=; b=Z
	Gl1Qkq+MyNFMpew5oIv23WDDbzn3KiSzsdzIkJsDvzFDFlvGXX1c8FRGJQQzjtGh
	Ve197hEFRI4GrhfRZGU9KIBCHCrOm5IY7dtJVSwOoqEpMJlegSiisBw7cGuqiaIY
	jMP+D62JbfQ3M/LnL4CXFSVtamKx8ouYtzttXhxl+hriyl1iZdcRROnYmHmvcq93
	MKdddSrLdSnDGvbr2jFeZKNxPl4eUwlCTyQ9Y8pAAw2IjZTXf7LbxR94VukTIKnV
	Xq+gxRLY9Sy13/5s1ryiW5g0zMZKq/01M0NdeVqciBHlAQeo0r4s2e43bpH+ylsE
	/+emxN38IOHJB5cLOa4UQ==
X-ME-Sender: <xms:bow0Z3Jh5i9fMydZv7KGCFWUARgSZmmP7TQm2YBi4dVh_eF2YUwhrw>
    <xme:bow0Z7IFslnfZvMpk6yu7sGYgkghRcFUyRWZpUCvPx-TeXYc7KhB6MthqHMtuWAOi
    8d3yqk_ysM19g_SQQ>
X-ME-Received: <xmr:bow0Z_uwYrUZD7MADsAYQ3QgtffzbAtDXcRJ9bCf3No44f_ZyZKdnVUJRwfkHD-hkHwP2Petlli4760SNpWOw9G0Cz7vxBOjMtOYwxXqAD6U7mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihhhihiho
    uhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bow0ZwZJTvygMHLRt5H2QfXZDaGKHw3MGabEvnEexQJwOFsljvdFXA>
    <xmx:bow0Z-Y_vITQwDzRtnyYkTOKhXLsftp8GvyJcF9OwNnnyXL_FiMOVg>
    <xmx:bow0Z0B1foLeGqhdSalXUXV0tBqRp_9pWRagf1n7c3QfSuEO1vc5TQ>
    <xmx:bow0Z8b9zDbwnOGEBTlN0i7ep0-787ftcZrVUd5OTFoGbIcQTa3U2w>
    <xmx:bow0Z9kj_dqfAnApFvh26n1NRUuASjb0XfmWO18z9MVz3MKBv2xbbcVo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 06:24:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9805d2ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 11:23:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Nov 2024 12:24:16 +0100
Subject: [PATCH 1/2] t5504: modernize test by moving heredocs into test
 bodies
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-pks-push-atomic-respect-exit-code-v1-1-7965f01e7f4e@pks.im>
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
In-Reply-To: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
X-Mailer: b4 0.14.2

We have several heredocs in t5504 located outside of any particular test
bodies. Move these into the test bodies to match our modern coding
style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5504-fetch-receive-strict.sh | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 138e6778a477650ecbe2dc3e480c5fe83d4bb485..0a3883043baf5c4c0fc43b52e8c5fc375f10a56a 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -65,12 +65,6 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 	)
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
-Done
-EOF
-
 test_expect_success 'push without strict' '
 	rm -rf dst &&
 	git init dst &&
@@ -79,6 +73,11 @@ test_expect_success 'push without strict' '
 		git config fetch.fsckobjects false &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (missing necessary objects)
+	Done
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -95,11 +94,6 @@ test_expect_success 'push with !receive.fsckobjects' '
 	test_cmp exp act
 '
 
-cat >exp <<EOF
-To dst
-!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
-EOF
-
 test_expect_success 'push with receive.fsckobjects' '
 	rm -rf dst &&
 	git init dst &&
@@ -108,6 +102,10 @@ test_expect_success 'push with receive.fsckobjects' '
 		git config receive.fsckobjects true &&
 		git config transfer.fsckobjects false
 	) &&
+	cat >exp <<-EOF &&
+	To dst
+	!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
+	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
 '
@@ -130,15 +128,14 @@ test_expect_success 'repair the "corrupt or missing" object' '
 	git fsck
 '
 
-cat >bogus-commit <<EOF
-tree $EMPTY_TREE
-author Bugs Bunny 1234567890 +0000
-committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
-
-This commit object intentionally broken
-EOF
-
 test_expect_success 'setup bogus commit' '
+	cat >bogus-commit <<-EOF &&
+	tree $EMPTY_TREE
+	author Bugs Bunny 1234567890 +0000
+	committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+	This commit object intentionally broken
+	EOF
 	commit="$(git hash-object --literally -t commit -w --stdin <bogus-commit)"
 '
 

-- 
2.47.0.251.gb31fb630c0.dirty

