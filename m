Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78381DFFC
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804950; cv=none; b=fo1JgSm9d8jiX/Bx0dbFpAneVB3xR5Cm+zXAlTAw5cs08CiLuBUMv2/JjXXoaibEnTUmTlmLBUta7kv8XWTS1vcfDPEX8XeVmuBS0s4ZiYOtz8smt6aGeOBbscaQ5u1IhaKRv5jG+vl+25NDeiHFRk3JTVvsW9qOhKcCDMC6OXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804950; c=relaxed/simple;
	bh=9IcNTXBUd0o4txRfeI+KxudzCuhPc9CF2a2s5KZsyg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezwfZYu7hCoViXBIkThC30lK0iBYgQ/KyTA+Zv186Ny2Ns5YatHZmvPSfEDcC2tH/v/3HI3dmvpVfq39Heb8pXoLr4MmrUURTOmjzVE/uw+LHAEg1VFJCnunPeWmGGI/ESTm3VchgSTV88HmKLVcjF6B8zzjlacspA8SqZ79yPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NKgGizBe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g28HaHDk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NKgGizBe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g28HaHDk"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id F1374138FE4C;
	Fri, 16 Aug 2024 06:42:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 06:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723804947; x=1723891347; bh=fx+fvrVoSj
	vsIuZlvZySnZGviWStraFuZLgnbEx7mVw=; b=NKgGizBe5Xfw0DIjuWhFmcaq7g
	hiRO6Q0Vf3pE1sL/7f2ptPWYOy2WhDoAgMHMTi59GNToZFKdDzNZAQD8QdmgPzLR
	W7XCETVrWzK/j70dh8UZVdWumM0yr/lnZHNhVS7GdY/keCZxRHy930OlACxdR8Dd
	G68U5qS6NjfUfJRjAPAx5zk4inYgFLBYlhjdaH4szKApEMNGothlbW8yAJ055kPE
	+9ORcIKjBFaxnwJBPZE1ZRTxhTzFdxCxqR6e2aaS4+ojtqgqNmMf3bf3fqSdT7h8
	DBueOMzkQknEIY2HRtbhz2v2oB18LJom8ObFFe1dtiI/MxLDacTCqftkFOMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723804947; x=1723891347; bh=fx+fvrVoSjvsIuZlvZySnZGviWSt
	raFuZLgnbEx7mVw=; b=g28HaHDkRCBZWkqi6tfCkoeKw3ZU55+eMkQ0B4fKFJFE
	YIghesGLHo+svMx6q9rLPtgR8E4QT27mQTOY87MtApU3q9/cF+FFzhVVwteynMOz
	+GZ01NqKSz+/eYnBzMr+9r3hQgQV4altrugw7YsOzfNUALUr8v4Xq2/XKWsKu9J2
	9SS7Ew5CJm+oAKj5Fke5CntkkZIQ+C4AjwSyHdkaEtOMq+MXh+vzjnD0ks2jUemt
	E/OeR7DgDj7XHse3aaM6IXuMHlQhjEhT/JbX14yqs0KS7KCR/ZiifQVf2qUwUV2p
	32+i0nG6Sjd1cmYeDGxZqro33PD51IWGExMit4LVkA==
X-ME-Sender: <xms:Ey2_ZpiuYV5FHbfjBNfJzBOLi-uskSBVvpZ9HJlpl7kPytWMDKU4AA>
    <xme:Ey2_ZuACiv4x8GPqzLE3Gx_nIPRO2emVA0PnhzxqMNOKN0cVuddPkmLYfasr9auYp
    4lv5z4XIPuUWw2YXg>
X-ME-Received: <xmr:Ey2_ZpHROD3ynW2_MqPdHzP8p9U1BRXfDg_AUi0SosFQ88xgA0_jhi3LdxWLE9mPncfzurTHsazlVWgtWchblMjXfeqSZh4JpkkUAMlF-ef7sjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpihhothhrshhiuhhprgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ey2_ZuTsCFJoxcmi8Yx5FLBkRLSMLRWAN0tgZ6ABBpqwOfBccr5w5A>
    <xmx:Ey2_Zmx5FUlmF8RWSCa0F_e2MsPMk8zTAOcs7opM685euvIa8jAKkw>
    <xmx:Ey2_Zk5XsoEDd4buleV38JVE92fbI85v803LBw0oZTC4YrxQbm0A8A>
    <xmx:Ey2_ZrzR5AUsii05QKwnohPR4Y6FoVaUVnZRp7gRFFTT3uoGdMgzNQ>
    <xmx:Ey2_Zh_IlR8ZdezMaLJqQh1ASPqHgzU-7ZawCXYw4BVRyUYrT6dQNtB5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:42:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ccc208d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:42:03 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:42:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Piotr Siupa <piotrsiupa@gmail.com>
Subject: [PATCH] builtin/stash: fix `--keep-index --include-untracked` with
 empty HEAD
Message-ID: <6067675b5edf36e2eb28e98119a1c02d0a7ae670.1723804926.git.ps@pks.im>
References: <CAPM0=yCJ0snEznK0C+zkmGofWHE3OPWoMXSVGH6=TdM7=rZ84g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM0=yCJ0snEznK0C+zkmGofWHE3OPWoMXSVGH6=TdM7=rZ84g@mail.gmail.com>

It was reported that creating a stash with `--keep-index
--include-untracked` causes an error when HEAD points to a commit whose
tree is empty:

    $ git stash push --keep-index --include-untracked
    error: pathspec ':/' did not match any file(s) known to git

This error comes from `git checkout --no-overlay $i_tree -- :/`, which
we execute to reset the working tree to the state in our index. As the
tree generated from the index is empty in our case, ':/' does not match
any files and thus causes git-checkout(1) to error out.

Fix the issue by skipping the checkout when the index tree is empty. As
explained in the in-code comment, this should be the correct thing to do
as there is nothing that we'd have to reset in the first place.

Reported-by: Piotr Siupa <piotrsiupa@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/stash.c  | 23 ++++++++++++++++++++++-
 t/t3903-stash.sh | 15 +++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index d90e072ddc..fcfd97972a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1671,7 +1671,28 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			}
 		}
 
-		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
+		/*
+		 * When keeping staged entries, we need to reset the working
+		 * directory to match the state of our index. This can be
+		 * skipped when the index is the empty tree, because there is
+		 * nothing to reset in that case:
+		 *
+		 *   - When the index has any file, regardless of whether
+		 *     staged or not, the tree cannot be empty by definition
+		 *     and thus we enter the condition.
+		 *
+		 *   - When the index has no files, the only thing we need to
+		 *     care about is untracked files when `--include-untracked`
+		 *     is given. But as we already execute git-clean(1) further
+		 *     up to delete such untracked files we don't have to do
+		 *     anything here, either.
+		 *
+		 * We thus skip calling git-checkout(1) in this case, also
+		 * because running it on an empty tree will cause it to fail
+		 * due to the pathspec not matching anything.
+		 */
+		if (keep_index == 1 && !is_null_oid(&info.i_tree) &&
+		    !is_empty_tree_oid(&info.i_tree, the_repository->hash_algo)) {
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e4c0937f61..c87592ee2f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1398,6 +1398,21 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
 	test_path_is_missing to-remove
 '
 
+test_expect_success 'stash --keep-index --include-untracked with empty tree' '
+	test_when_finished "rm -rf empty" &&
+	git init empty &&
+	(
+		cd empty &&
+		git commit --allow-empty --message "empty" &&
+		echo content >file &&
+		git stash push --keep-index --include-untracked &&
+		test_path_is_missing file &&
+		git stash pop &&
+		echo content >expect &&
+		test_cmp expect file
+	)
+'
+
 test_expect_success 'stash apply should succeed with unmodified file' '
 	echo base >file &&
 	git add file &&

base-commit: 477ce5ccd69bda5c44f53e3b230f8a9c54217ed6
-- 
2.46.0.46.g406f326d27.dirty

