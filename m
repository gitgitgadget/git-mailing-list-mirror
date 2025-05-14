Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404E18787A
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236867; cv=none; b=tsy0ad4Y5HSQubStUt3DkYSMm7nCxx6yUmf8fAwLpwJGRCEzplMb9MQWBgP9UxcK0SX2xFDrHc4LQ1Cr0hnNjnq5mEAChjDB2gwXUlaMNiBDAgD2aC7uSOnvjWP86M2+BJiezrppBcLlU03ryaXUdH9U1quEJazb5ib5dzsnFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236867; c=relaxed/simple;
	bh=9Av9XjaV6ofJ8OQq/+m+lkW0AM1H6PpfiA6GEH3M6dA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ELS9MO5Al9iHKSFnPKcDGbjCqCPzhIdarFgLKtTwo20VoCaxjHOiJc4nLfgpNaXLJfcRHhj5fG35xdsNB84wPJIrXKGSkQ8UBOJsROoYcUQ4mG9xH5Y29y2q4IiasFTEYFFjRNkgT3RHg+kXzRgwveYDFuAv05yWg2ZqFCrcepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gZ4PJk3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LLDU6z0O; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gZ4PJk3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLDU6z0O"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DCE821380184;
	Wed, 14 May 2025 11:34:23 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Wed, 14 May 2025 11:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747236863;
	 x=1747323263; bh=CP+PzCNkDt7Cbqf1vp+lZnI7aeKSND195mYWXDf6Kuw=; b=
	gZ4PJk3xrblvm+3/gAEeJo1bFpf3q+OjBsBQq1M3QvCnef+turLWmLH//JVP2IPX
	QbQhQfd/ncXUCOcC+HFDqYVWGlponp9ZP8KXnJ3iLdhw7ay1faZu1sh2r1xmEeQm
	Oz4Qt3I4YyRxCMXbSBsUHvwA0ExbxfAmXO6jLDMfvZteUbTEeCCpdZFVCa79prnu
	QSPZQaE1JFI76kggDe6ViL8jexMZXyx+6/2FAeHijNA1yghz5L62hIrmfwFkFaIq
	/eHGc0o7h3XMo+AM0Wr0P9YNSnSqR1+9dxFPvHJdnJMSftzQ+LYSatnWurZ4qb+s
	NXAEgq9x+Q4hqs2Triv89Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747236863; x=
	1747323263; bh=CP+PzCNkDt7Cbqf1vp+lZnI7aeKSND195mYWXDf6Kuw=; b=L
	LDU6z0OxrP+Mm/GFe+8gxMkNwdbf0LXiTvwp9uo2mllbkm+hIAqtnuLJ6FoOeiXY
	lYeg8EqYWecU5eXk6Iz7H6jhBMNE1uyTJ9u6tPuFY2rWRovmSoeTRz4FpMi+XhsS
	sW8TEAVkXgPOmP1PrvRBRyLSDc7rb6TzTI/DjuEVke62kY8iPPFb2P6Wvmhih4vn
	DciAjglc0iOgrN4DDMoombH5apKTKHCT7YePHDGez0xgS0txOELlp0+pkXwfC6+7
	ltHx+hINsTtX+IM6SZ7L6Nipnv48krc0nxU/nEMY6J3OJJJmzeTCq3vuQMPGbXcp
	/JmCXGO5lUSzr0UZ3W6Ag==
X-ME-Sender: <xms:_7ckaGTQ_e5IZHNDmgDi9tZf9RD6qpaT7UJlvwG2LFf0YieriCXnfK0>
    <xme:_7ckaLyuced6qZxdZdxeI11frZecoHqTrGWRHqwwqS1wFMf6A7hoVeBAuR19Nud_q
    Ul7rGtGt-eIUqNBaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugf
    elteffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_7ckaD2mFMPdoOhUBq82QQJ3jZVtQeFGObfvcfj6r4jae3X0KBxY5w>
    <xmx:_7ckaCACRQja0SWMPwBIqGRVKU5xuiPFeod1v0zeNTzLaq9_IzNH7g>
    <xmx:_7ckaPhrDnf05o1aAXTJOPUpVsNGJNJKlJlC1wYZOjduHPMNJvXTKw>
    <xmx:_7ckaOpkq7-E5NszzqjXQp5EVaf8DFFZE05aju7ALvv458Oa08rV_A>
    <xmx:_7ckaG8Mv5IDpUupz6c0Ozqnzt3UaGNR1pF9hJ2vOictZn6aWFyPphfa>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A462E2800087; Wed, 14 May 2025 11:34:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T21dafbefef3d3536
Date: Wed, 14 May 2025 17:34:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>
Message-Id: <be8de818-0e04-442d-9639-d34888df10cf@app.fastmail.com>
In-Reply-To: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
References: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
 <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 0/2] merge-tree: add new --dry-run option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 14, 2025, at 02:24, Elijah Newren via GitGitGadget wrote:
> Changes since v2:
>
>  * Converted locations missed in v1 in changing --mergeability-only ->
>    --dry-run
>
> Changes since v1:
>
>  * Renamed --mergeability-only flag to --dry-run, as per suggestion from
>    Junio
>  * added some commit message clarifications
>
> This adds a new flag, --dry-run, to git merge-tree, which suppresses all
> output and leaves only the exit status (reflecting successful merge or
> conflict). This is useful for Git Forges in cases where they are only
> interested in whether two branches can be merged, without needing the actual
> merge result or conflict details.
>
> The advantage of the flag is two fold:
>
>  * The merge machinery can exit once it detects a conflict, instead of
>    continuing to compute merge result information
>  * The merge machinery can avoid writing merged blobs and trees to the
>    object store when in the outer layer of the merging process (more details
>    in the first commit message).
>
> Elijah Newren (2):
>   merge-ort: add a new mergeability_only option
>   merge-tree: add a new --dry-run flag

All I can say is that this looks good considering the comments on v2.

Interdiff:

```
diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
index 7dcc1780619..74716b91019 100644
--- a/Documentation/git-merge-tree.adoc
+++ b/Documentation/git-merge-tree.adoc
@@ -65,11 +65,11 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.

---mergeability-only::
+--dry-run::
 	Disable all output from the program.  Useful when you are only
 	interested in the exit status.  Allows merge-tree to exit
-	early on the first conflict it finds, and allows it to avoid
-	writing most objects created by merges.
+	early when it finds a conflict, and allows it to avoid writing
+	most objects created by merges.

 --allow-unrelated-histories::
 	merge-tree will by default error out if the two branches specified
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 579e81d5184..273ec171e98 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -596,13 +596,13 @@ int cmd_merge_tree(int argc,
 	if (dry_run && o.show_messages == -1)
 		o.show_messages = 0;
 	o.merge_options.mergeability_only = dry_run;
-	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+	die_for_incompatible_opt2(dry_run, "--dry-run",
 				  o.show_messages, "--messages");
-	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+	die_for_incompatible_opt2(dry_run, "--dry-run",
 				  o.name_only, "--name-only");
-	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+	die_for_incompatible_opt2(dry_run, "--dry-run",
 				  o.use_stdin, "--stdin");
-	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+	die_for_incompatible_opt2(dry_run, "--dry-run",
 				  !line_termination, "-z");

 	if (xopts.nr && o.mode == MODE_TRIVIAL)
```
