Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9813A87E
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656964; cv=none; b=ZVXwlOn7x/cTPPYDTrnR7oxTMCsHO6gcdIGHwc9rCgoYr68MUHi7PngcXD1lmz2Fp7XwroZn1KftHWLW1RLg4tNoBjkRHoJKyd1ZscJ+Qp848wJyhQtV0An9VOQaJ6iVcpY5ZEywi3/UuZ2e82nxY2sNqp4hIJUPSiiWZcjzHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656964; c=relaxed/simple;
	bh=LTThUPn676cxjqfJgzSCWLqo2VVtWXpnLtaiWb6nbQk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssmk1caX0IHU0Dz+G1hVmgaQGUbdHfD0LdD+S0Jb9ANxkohu4IHCoV+K+mNpS+Xu7TVORJUrCQ1WhVvXb/I6nnlQD+UuQDWvryWRs2hJ6qCBbcR0g9YFTC+XX1pFYS23Po3bOgeUmqYjGDtjuPKc6KiuJTSPmVfVkz8phXx0iGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZL2gXHDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFhUs2Uo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZL2gXHDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFhUs2Uo"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 70DB01146D06
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 26 Aug 2024 03:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656962; x=1724743362; bh=OVhoNNK051
	vHa3VLcD+wlU3SC/L8Zb9VowoA8Z3tao4=; b=ZL2gXHDVZPjbD200o/3ys0HagW
	gDdwOyYRH3RwXWkRMtUtdGtlGOO694mApBveZ3JtOKdZARn0J5Qpk0VWSDPfjICR
	n7Ut8eS+rpDBmlkc8kfOaUO5iPlUunULIvtY3jMcKb/Ky/yCESkSB/lgBW6lSL4p
	D6cUXwmRlV2PLXdfcVwz9jnqRPjnc75J0QiAP2lkspf9DJ4jdFIXFru1mBU1q49e
	BM3uoqFijmkXdvwsqBHfzTd6JCG0VGYYPTd2M87ShRaYP/vwT1vRVQJRWoGo1j4m
	w2PBPtJgPafBgpNBR47f7yK0GguC/C79awXIa0OwHVfSZ94FXvK897W412Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656962; x=1724743362; bh=OVhoNNK051vHa3VLcD+wlU3SC/L8
	Zb9VowoA8Z3tao4=; b=AFhUs2Uo+dqvkUgJPEG8mYGR0/61/qzZ8Eou4ITEOoj8
	Ni5t5hJlbTa7Mv/UD7J73FQA7XpFM1VVZU3bBViqMM/DWLirGxc0LZr0u3Yf6ril
	7DFQCPymGz93UUau9YQcZyDZPwVTn9ZFhx/86zBh8fbCbavyO0G1PXC9xbyGO2ZU
	8PD5aZiykRET+znayIRCOjAt7XHFsEXH4xoiH/i2WDIeAs/Cfcbe7sZAN8OQPoF+
	tR2iXvP0hpc9QEAaUtZ47ee0EvfdZa238mewOVjevvyKUjKoHvpDIjzhYl2JHkbD
	DpASwV3dbD+y+MoYdZrUIZnsCnC/i77DiiMa9gS+1Q==
X-ME-Sender: <xms:Qi3MZnLrrfTgCXDzzoJmIC0Kjj_rqqs9SNkBU-PfSDJS-RWfizMEQw>
    <xme:Qi3MZrLHo6BpCU4mgVdD9ZHCst0l_NGMdvSor8o5wyVWCbrrZrYo_nu6c9TjRQ7w9
    YwMztfJtRRl2JVwPA>
X-ME-Received: <xmr:Qi3MZvtKnvbCCOQB4UlD-oAmlumbV7TyElbJY3VW5xslxq7DjNLPiHUuXqxjTvJE7rUD_1sqbdmhTMaltujrn0O6l8XT1FZT6koEe00_k01JZXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Qi3MZgbbCkeVM_3UX5AW2DuPPb3UVKYiJ3FZUwG2P50sdH6kiglk0Q>
    <xmx:Qi3MZuZpMlqwCRxOINFd8AxeK3URlQGyhj19D_bkoH1MX58WOeVXag>
    <xmx:Qi3MZkBXike6jdii777h5NcI78brHF0B1dWdZ-h4k4LseUcKakcAMQ>
    <xmx:Qi3MZsY36CHJWGFd4-AzvJ0zcmQStvUECAFLk7DLcCi-3lqIadBaYg>
    <xmx:Qi3MZhwBpGMmjlZ8mtmRqt-bxJsEcbu_dDbS4GXYQvg4gK3hggaoVSJ->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d7e5701 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:39 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/22] merge-ort: fix two leaks when handling directory
 rename modifications
Message-ID: <da1c23a9ccf8c797ebcbe6ce5a8243c1d051fad6.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

There are two leaks in `apply_directory_rename_modifications()`:

  - We do not release the `dirs_to_insert` string list.

  - We do not release some `conflict_info` we put into the
    `opt->priv->paths` string map.

The former is trivial to fix. The latter is a bit less straight forward:
the `util` pointer of the string map may sometimes point to data that
has been allocated via `CALLOC()`, while at other times it may point to
data that has been allocated via a `mem_pool`.

It very much seems like an oversight that we didn't also allocate the
conflict info in this code path via the memory pool, though. So let's
fix that, which will also plug the memory leak for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-ort.c                         | 4 +++-
 t/t6423-merge-rename-directories.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3752c7e595d..0ed3cd06b1a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2710,7 +2710,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		struct conflict_info *dir_ci;
 		char *cur_dir = dirs_to_insert.items[i].string;
 
-		CALLOC_ARRAY(dir_ci, 1);
+		dir_ci = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*dir_ci));
 
 		dir_ci->merged.directory_name = parent_name;
 		len = strlen(parent_name);
@@ -2838,6 +2838,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	 * Finally, record the new location.
 	 */
 	pair->two->path = new_path;
+
+	string_list_clear(&dirs_to_insert, 0);
 }
 
 /*** Function Grouping: functions related to regular rename detection ***/
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 88d1cf2cde9..4aaaf38be68 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -25,6 +25,7 @@ test_description="recursive merge with directory renames"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
-- 
2.46.0.164.g477ce5ccd6.dirty

