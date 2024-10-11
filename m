Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D5208216
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624754; cv=none; b=j1PVVZ8ye+Fh03Pi8ER3jWbUZEhidZ7XMWOkJmhUWaJ24bWimXTc8Qgc59ONOzoxbrIYsMYH0oz8RYBz+yNYYFbYHj9T00J5Mvfxf9NjI0+j+CG5Oj14/1LR50s+5YN1t3EcWgPSq+8bzAAD3c9P+SgTtWMn3OOZZFoJ7EejTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624754; c=relaxed/simple;
	bh=wAfvhPFldsAk1ENfmTWyT2kjMkc39kSM/wL7UH3uTns=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9v5i7VKiF3nEi7BpdHn7uNwpz+nc2T6t0oGzj2F/DNC7Q6RIhUF0vxQTymM7T4pRae65uCNwUGumKIVESWOvAfZF/eBBadGnqTCsC7mzgGy85Va/D0Sidk2zTYkF0z9VcPMkSaXXLMbWRjqu9KCY/1uFsw+wEIjmetEvfQfxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=glNCUW5G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFVMIyyJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="glNCUW5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFVMIyyJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 629E51380123
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 01:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624752; x=1728711152; bh=tZObAy4DHE
	F/a+fzzNqxX5HuWJEycgm/nu8ulIuXZV4=; b=glNCUW5GlUeksgM/BHvkn4Goxw
	Uu3l4KvI+r83yPBAwt9eKqDRZyudASPgd/bI8tgrr5frTFTxe7KkMt78MJDDmekK
	Q8nh4qeqSZOy+7C74VVFqpGjMzW8sOP6nSk8QOHL6m03CMhRA6nkPX/gFAMcVxsj
	wAVqxq55jnnbsCLWAepRllnIrSf6jPuvCxQNJXnNBBZnasr1msxOTSL8TumrW59r
	otXyKKXHm4oU46ZFeh5xT/ZJyyvnnxEOlfR+LZRUDwFhPXMQpSHA14d9mBk2rM8P
	qUxwLM2uRDbn/BmhevzisL1AK8aztePQlAWd2g4ezGP7bXaZrt6M7TSwjj/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624752; x=1728711152; bh=tZObAy4DHEF/a+fzzNqxX5HuWJEy
	cgm/nu8ulIuXZV4=; b=TFVMIyyJkak1kN686Z8KdYm9t85E/3KNKRfME/9xEB2C
	yye516mb95i6i4Sgm0SKJWZ4CSqSxJHLnLDmEo2RUBVYfVkXPwcjCgJfeBcNpBBZ
	L/gLqoXCkzzTq6wBlrG69QKFhjjuLc1Gdvf6Cn53eZ0e1P49J0h+zg8FnkhsXTx6
	VX+K/HwO4zJ+aMzVOn9b0FNJkIFgzrBLY8Cm8ykp+eZp3NJm/qsEs0Ad6Fs4TfUu
	Lc43sa6Jsm5LKPGsPX8MGjvbHAIgpPPwKlYa9FVWw5qU5j9fHmq4FCeMZZITeDI6
	B7D8rQ5VfCUCPHPKN5tS+xDO0lR0KUFdcpEp6Eycig==
X-ME-Sender: <xms:cLgIZ0Rb-pmDKYr0UMYvjqIC4l957fkRZqpeXTqbijMxr0ogd704lw>
    <xme:cLgIZxwQPuAVU-8wQyRDG19R7yaN6nF2HHLdeUnHi6q8PejIeLgCYnXxfRuEhASdA
    tZ0VFNG8fcqKLkIFw>
X-ME-Received: <xmr:cLgIZx1cFlbrZOiv4eDa0tlxyu4McIi7aJlP-tGnCjXRbXKhveEd3mcJThMAGbsaUODUSW_BvFdHKFV-VyCf3HwbczXi-nMQcw5MzuPSd1d9cC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cLgIZ4Cy5hN_E2C_cG7IMzDWlWSSFVCoAFAD3Vp25Vw-l9WFlHg_tA>
    <xmx:cLgIZ9jE3Idlu8g7Q2WK1p1dz2ZR2teTL2AZH4T2fAaOPTpvg3zuWQ>
    <xmx:cLgIZ0p84Hlh8VXxIDUo6TqlUqheNNpus3BlYjgK1xtzR-RRY__DOA>
    <xmx:cLgIZwj5FMewPlCc3nv2Re7t4ODWIoUrlE7a_5Wy7EiJD6aBpe3_fw>
    <xmx:cLgIZ9aNcUGwd--BJkqTS6DWMVAs-BLGg6oe_bXsffeH89zJL3Az3ESW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6fbcbbb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:25 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/21] pretty: clear signature check
Message-ID: <5d5f6867f918460001f62aaa78f24cf3cbe53a3c.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

The signature check in of the formatting context is never getting
released. Fix this to plug the resulting memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c                         | 1 +
 t/t4202-log.sh                   | 1 +
 t/t7031-verify-tag-signed-ssh.sh | 1 +
 t/t7510-signed-commit.sh         | 1 +
 t/t7528-signed-commit-ssh.sh     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/pretty.c b/pretty.c
index 6403e268900..098378720a4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2032,6 +2032,7 @@ void repo_format_commit_message(struct repository *r,
 
 	free(context.commit_encoding);
 	repo_unuse_commit_buffer(r, commit, context.message);
+	signature_check_clear(&context.signature_check);
 }
 
 static void pp_header(struct pretty_print_context *pp,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 51f7beb59f8..35bec4089a3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -5,6 +5,7 @@ test_description='git log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 20913b37134..2ee62c07293 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -4,6 +4,7 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 0d2dd29fe6a..eb229082e40 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -4,6 +4,7 @@ test_description='signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f7806362..68e18856b66 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -4,6 +4,7 @@ test_description='ssh signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
-- 
2.47.0.dirty

