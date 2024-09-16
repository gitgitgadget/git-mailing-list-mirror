Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F015697A
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487152; cv=none; b=jfn4u0F4Gv771rHuouFCcPaNwhciTqQwy+45BgJxzCaCfLnazGZ2CRMN0mP8RFf50oUg5RqbTHU3eX02+c1zuyDurSCO5+2kV48agTHiqrNSZUgglx/6BJOfojIKk+PFihb3ZvBabu6MWPg9tIINNr/QhMAgONtSGz9esfMazPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487152; c=relaxed/simple;
	bh=v7JFcoOx0cYV0QIqK3dSorD0lv5CpaXjBg9RwRSkxlc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9SKgJHTVvUrmF8mrSLxAktwXkVjOVWx98Vi3BX+QW26qLvtnOYN5x5LwsnM3L26TJgKlT1mrdP2KwGzbx3KxZ96GdTJB0R+7QuZhf3Jq2xUguomgS+odsE7oMlnOvPpapdfyibKrmd0BxaVAiZFEheVdvzbVuZNKG3MWAbhWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qMUqJRC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQzH9kYo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qMUqJRC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQzH9kYo"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DA5C13802DB
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 07:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487150; x=1726573550; bh=lHFAlHgbhB
	lHEqBkSK1/tn+JLT1Jv3KU82uUrQkJm/I=; b=qMUqJRC4jpjY20/BtnCHg6qCLM
	/Ec/fF8NNBCsy6n52ZfO40CdYFDi7YpjDGWRUbNxdvJIf4qZXVml41gAdbcf9MVV
	xzeHAqqA1V4J3TaYFHDBRP8tOzMXV0k/VPQGmkgNg4Y7yqELjb9W9LO/B8Zt9OeL
	7AC44OAIeU9hethrhUiWFRF5w/Oj992tx71SJ9EQiOQw+LxIWXP/D6Zzkos4FOVz
	IzyZtaWC3ewtiO06JDxdiBLTIPhM5na7ev5j0C8cWl+91gleKXA5ntCUP3P9bpD6
	HpimtcCbo0HVZNoC+quvRebQ9FdkP2b4Jhve57NebfTaBQJ12rhsRez5lCYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487150; x=1726573550; bh=lHFAlHgbhBlHEqBkSK1/tn+JLT1J
	v3KU82uUrQkJm/I=; b=lQzH9kYoj5Ud3T6V+nWQvUWT1Gc0Ry6qrgBjjhjAZkt8
	JtcZQoXpo0paQaDJWeY7jMUt2CEd3h6a4togvpq7xCRNXV+4ucDZYQdGUgWYPo/t
	2uPPz1vllEfeh0S0Z9ekomoqB+mLf8xZObjSBqa9osqMW1aDhtjLQGcHGafylJIu
	O0SMWcsd7lqce05NhQMqybdd5o9crhwGA9E52V/W/urOdVq3zQoq/1f2+aV1ZW2g
	gdkPuJLVhU7u5F/XXQaop/UvHFQTw/r2AK8MQak2Ot+ktoUEkY0IMloVS0RL3E/e
	0S44r0dGTck5YpWGdxnlpC8fDyM2oDVBqbIn+6uctA==
X-ME-Sender: <xms:bhroZvIRhCkL1UIACWzQRyUEabJkGIryHYgh72I9riDCsPuaJEVwQg>
    <xme:bhroZjIsaQRZReqGEhtzCO7PhW3taQDtvgtDKkrvpQYfcyk2WeLcbzsM8VhHSlG8z
    m2kaNoyWRHciDixsg>
X-ME-Received: <xmr:bhroZnsV9W-RgXCiaWFbbliH6-xKqfE1SWQ4yGrKPWFMwWIsfkzZf9iEAXQB7pIThT30GMS5rn6mP5qgH5zGu4wBBmen15uke10dJp3vedxbISHV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bhroZoYT7pimIrwRoENvgfDjsYYl_AClPZaB7Uas368HPutKVNs6kA>
    <xmx:bhroZmZ4tHIlBcY_awvkmotX1aK_PKA8xSclGgNP9MDSBSeoaZ7Uig>
    <xmx:bhroZsCD8e0_SodbxJ8z0i9LwEVy-pXsCF530DqBHoGZKRd2PjSz_A>
    <xmx:bhroZkYq0bP65aNfFlubJqG3mY9JeG2ev11fPQLs4A_zNtR8E2pPYQ>
    <xmx:bhroZpzJhbxGUZchhPDvawYHWmd4VJCOfXNlDJgs6B33T94M669JM-0M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5977512 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:32 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/23] dir: fix off by one errors for ignored and untracked
 entries
Message-ID: <d5c9cccb8291a1941e6ee1bc8023232e8d5384de.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

In `treat_directory()` we perform some logic to handle ignored and
untracked entries. When populating a directory with entries we first
save the current number of ignored/untracked entries and then populate
new entries at the end of our arrays that keep track of those entries.
When we figure out that all entries have been ignored/are untracked we
then remove this tail of entries from those vectors again. But there is
an off by one error in both paths that causes us to not free the first
ignored and untracked entries, respectively.

Fix these off-by-one errors to plug the resulting leak. While at it,
massage the code a bit to match our modern code style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir.c                                              | 6 ++----
 t/t3011-common-prefixes-and-directory-traversal.sh | 1 +
 t/t7061-wtstatus-ignore.sh                         | 1 +
 t/t7521-ignored-mode.sh                            | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 5a23376bdae..787bcb7a1a4 100644
--- a/dir.c
+++ b/dir.c
@@ -2135,8 +2135,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 			 */
 			state = path_none;
 		} else {
-			int i;
-			for (i = old_ignored_nr + 1; i<dir->ignored_nr; ++i)
+			for (int i = old_ignored_nr; i < dir->ignored_nr; i++)
 				FREE_AND_NULL(dir->ignored[i]);
 			dir->ignored_nr = old_ignored_nr;
 		}
@@ -2148,8 +2147,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 */
 	if ((dir->flags & DIR_SHOW_IGNORED_TOO) &&
 	    !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
-		int i;
-		for (i = old_untracked_nr + 1; i<dir->nr; ++i)
+		for (int i = old_untracked_nr; i < dir->nr; i++)
 			FREE_AND_NULL(dir->entries[i]);
 		dir->nr = old_untracked_nr;
 	}
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 3da5b2b6e79..69e44c387fa 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -2,6 +2,7 @@
 
 test_description='directory traversal handling, especially with common prefixes'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 2f9bea9793c..64145a05b1f 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -2,6 +2,7 @@
 
 test_description='git-status ignored files'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expected <<\EOF
diff --git a/t/t7521-ignored-mode.sh b/t/t7521-ignored-mode.sh
index a88b02b06ed..edce10f998e 100755
--- a/t/t7521-ignored-mode.sh
+++ b/t/t7521-ignored-mode.sh
@@ -2,6 +2,7 @@
 
 test_description='git status ignored modes'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup initial commit and ignore file' '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

