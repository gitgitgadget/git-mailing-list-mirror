Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC5443C1D
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241592; cv=none; b=XhEljsr1DpEPB1gb3YbvgBhNHl0M6L6Oa3E3u0aD4gEp9YTt57AeOWHrq+hZDQ7T7ZffU/Xyoa9f9PO7nh/OaAzztV7huMOQt7CkJkImWxwij2DTRzbXEgQN5QvCrB5CLFqBtzoQx8XUbD2Fp43YdS04RGVGz+MMzVV6OSmDKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241592; c=relaxed/simple;
	bh=8XxUZfdxzDz984d3wTR8VqMAOHm32gt16BfJhKkRZtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dI5sIqS5m1UgVDpp6NbP0ajtl+uJyfdUklY40JCWzz31hvY3njgHgofcZgtDc0D1vBiXpfBQI/vXR+2eMyy8FmR+O5EMpzvX7yH0YnNiJXcf+a0PfuzJ0pKJ72vEapMmTGToFDzosz0FFeGGgP0g0LSCxzRVB9CfGDgzWSH/MPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mD5It3Xs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ogoQ8jzu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mD5It3Xs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ogoQ8jzu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F3297EC00B8
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 05:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790241587;
	 x=1790327987; bh=Lzi3+wRA0bEef0Pjzko+8yycASrdTv0MdodEe/eYEm0=; b=
	mD5It3XsGF32XbPY4RFOtGT0g6XJtMmQN1szrKpa+7W/A+2KHKB1a7FErpHOIanL
	SNWRDT6pwjWt1vnHv480PNTj3IVfcTpkoFv/ywpK/bH70UTTRi9XaGeZKpbvEU/c
	zbDV2Vhx5tZVuPZCJf3hbr9pxrvZ6ov067NHFahwJ0+NMbmCPDTTi7+xiu5QXn6J
	C/y6FCjvbuBJzcBN9wNvCyGu+X92nd6O/CZxeTq3QGLXD1PB9gGSlXeptskbjdAW
	m343sOZI6ogpGhd3ryvpLxoPqZ4Wp0y/4/e1b0C7ngMxc7rAVIojkboPtXBZH7cl
	Neh8SD4F8ocwznYwjO1m5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790241587; x=
	1790327987; bh=Lzi3+wRA0bEef0Pjzko+8yycASrdTv0MdodEe/eYEm0=; b=o
	goQ8jzuZP8s4gcJQws485V4ketNcf/p5W07UdgJUIdhYq2ax8xRCqee8DR8RhpO6
	rH2KvZFCRqmOUsFWI8V1vsKId3nZDBmFzcsEovroJLgCES4lITuB0jCfkMqM/Vlx
	Se7UXXISlDHWlNPu5eVzEYdilk5W7aTR0LuiYNe/TgLL/V6rxFjzOPT4Isimzy8q
	DMsWU/Iha4O0+fDGvldBWiphjksHSQmprK6ZJwSCV/X0J08/9emYSB5ZqQw3KJ14
	j9o1dNXC/80MrZe8osJn70X939V2JfJGm7S/t6gn+sW0+nQb3oHQT4joZIxXu+7S
	I0b8FXI9aBDjcPQ0uDATg==
X-ME-Sender: <xms:M-u0aimRoIF4kJtixdiWhQi4BsZrXkdIpH-vpclLeHb1cFqcqnBgTA>
    <xme:M-u0agy5NHqsMwoo8OMMyrvw4SYlitpEbpL4zRGU936XMVY6lr4_OczorwmXFgVAd
    ZttACz-alC7ng_XdnSbJuFWiU6ZyRuu2wnSxrEfKxqzH_Tx-LbP_Q>
X-ME-Received: <xmr:M-u0amT95eFTYJCL3jTd1JgIeuV5TcnV0Q-WO8n4pEEs6DUsVNZAaTL_Z2O5wM_KHpfGd-Q>
X-ME-Proxy-Cause: dmFkZTG2pNBg0N/LAGNDOAj+nGLxMFIIor7EHY4S+hpEEIzp1uYqjTYNQWjBtU8CvkDsFO
    eCHCpjw7Di8S1RJDa4jE0q12X5Ov2TpAKW1KukLXCX9+eBYtA9M81fNI+V9vzuSQPh+sJv
    I9sBUl1ezeqCePTeQCQwr+SIm8FOVLcj2ENN0UqmeD0WrpUsNRFRcVHAOIpDM0X7ECdHkY
    V0G5qTdUenhVglwhNugWnp59V6ooFRp445tE1ACeU+8b2kxo7n8WgRQrz6AqQrf19Ytdgy
    9pXb9mBfTqf1o4cCJ79tp5CIbcpX3p4PyViWIqhIAd8CkzAGb6M10otf9hRSO+Dd/Mkxcj
    FOVP/dcJIXI07LU3QJlPN6KE8hnDG4vTmtJIALVqB9Pwq6TPxxlpWLUPalFns4bY+lqt7N
    rjm5vFchU7x9CGtqzZUcEOdC2qgALsPqDXj8LIhUetVzXKuVDyhI4g8wpp4jnwphNGOJ61
    dAeLdiAoz4pEsgkigaIWEl6O9cHzqYG8Jls8ykn4gOE1wi56EMKDb4RKfCruJK5y2uSSUL
    MNWOP6VrqgcArp8T+cGqpdqDsB3mMMCF9q5BnmR2Qj20xBjj04KtBpwNs9+hvLeRKM7TPN
    mFr9vVJ8N7/9TQVemnvsyqwJhAbrw9W/Ie9IMQBM9PFoD/VRkv6eifoFPlAQ
X-ME-Proxy: <xmx:M-u0ars8OomFADdgsC1UtFOoww0BSkfHZ-PZg1GR0RnttXYem1whpQ>
    <xmx:M-u0agvT5IfBUMNGz6KkvloXhE6shgbwJ7o4W49kh-FHmQeafrKF5Q>
    <xmx:M-u0apyq2EunQBKS6DrPAHCl-WhRcPqOIm5FNKyPuhA3NZ03EpPC8Q>
    <xmx:M-u0aujVV5MBRxkUHseuRc4i9MxAEzuAUnRQgxQdCKqZJtD8HrqLVQ>
    <xmx:M-u0au0w81JVcDcb75v7KNaTzLs928Q4FjA7eOhJEB6XtOuEoJjZ4w51>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2caa5d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 11:19:23 +0200
Subject: [PATCH 5/7] builtin/clone: don't apply "core.sharedRepository" to
 leading dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-create-repository-stateless-v1-5-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When creating a repository via git-clone(1) we create leading
directories with `safe_create_leading_directories()`. We have adapted
git-init(1) in a preceding commit to instead use the variant of
this function that doesn't honor "core.sharedRepository". In that
subcommand it didn't have an effect though as we explicitly unset the
value of that configuration anyway, so we never honored that config.

In git-clone(1) it's a bit of a different thing though: while the
repository isn't initialized at the point in time where we call the
function, we didn't explicitly unset the value. Consequently we _do_
honor the configuration here, but when it's configured in global- or
system-level scope.

This divergence doesn't seem to be intentional -- I cannot think of any
good reason why git-init(1) and git-clone(1) should have divergent
behaviour here.

Adapt git-clone(1) to work the same as git-init(1) by also using the
`no_share()` variants to create leading directories. Add tests for both
commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c        |  4 ++--
 t/t1301-shared-repo.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b14264c33a..e72f8aa325 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1133,7 +1133,7 @@ int cmd_clone(int argc,
 	sigchain_push_common(remove_junk_on_signal);
 
 	if (!option_bare) {
-		if (safe_create_leading_directories_const(the_repository, work_tree) < 0)
+		if (safe_create_leading_directories_no_share_const(work_tree) < 0)
 			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
 		if (dest_exists)
@@ -1153,7 +1153,7 @@ int cmd_clone(int argc,
 			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
 		junk_git_dir = git_dir;
 	}
-	if (safe_create_leading_directories_const(the_repository, git_dir) < 0)
+	if (safe_create_leading_directories_no_share_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
 
 	if (0 <= option_verbosity) {
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 0e0d07a1a1..3bc4bdb038 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -210,4 +210,46 @@ test_expect_success POSIXPERM 'template can set core.sharedrepository' '
 	test_cmp expect actual
 '
 
+test_expect_success POSIXPERM 'init does not apply core.sharedRepository to leading directories' '
+	test_config_global core.sharedRepository 0666 &&
+	umask 0077 &&
+	test_when_finished "rm -rf dst" &&
+	git init --bare dst/with/leading/dirs &&
+	cat >expect <<-\EOF &&
+	drwx------
+	drwx------
+	drwx------
+	drwxrwxrwx
+	EOF
+	{
+		test_modebits dst &&
+		test_modebits dst/with &&
+		test_modebits dst/with/leading &&
+		test_modebits dst/with/leading/dirs
+	} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success POSIXPERM 'clone does not apply core.sharedRepository to leading directories' '
+	test_config_global core.sharedRepository 0666 &&
+	umask 0077 &&
+	test_when_finished "rm -rf source dst" &&
+	git init source &&
+	test_commit -C source initial &&
+	git clone --bare source dst/with/leading/dirs &&
+	cat >expect <<-\EOF &&
+	drwx------
+	drwx------
+	drwx------
+	drwxrwxrwx
+	EOF
+	{
+		test_modebits dst &&
+		test_modebits dst/with &&
+		test_modebits dst/with/leading &&
+		test_modebits dst/with/leading/dirs
+	} >actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.56.0.rc2.329.gd58861e689.dirty

