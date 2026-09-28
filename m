Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A448033B
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589122; cv=none; b=a8uB3QEEYa3DYb7yCvlPmz0ul5Gujro4oTpMCzJDimDc/dkpmYfhX8mB2zL+uZZCRqMMvpbZLDUcLqpVQFeyve6pS79DXt9eGxuuF5TMDiokn7rimfRb6673kZCSQ9ddNWkgu+P0cmVzHXZ1uAXoAX9xUe8CzOPqiSIFoRn1yPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589122; c=relaxed/simple;
	bh=8XxUZfdxzDz984d3wTR8VqMAOHm32gt16BfJhKkRZtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpNZXfEChS1DbhlwjKMuxeTnr4cFCP74xNtKyqjaqoxzWKyBMut8CbsTP6KdP1wa6YoWg3RWxmAhLNiF7EaKAXq1EByMUsmT+co8qQL/2M2C/EDPvyB9KwAThH1ZYbtElAdoDkgecr0R4m0AoVsLbyrI0a3US6Zvb9itpn929+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xd+0c75R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8ocqcba; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xd+0c75R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8ocqcba"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00EE7140002F;
	Mon, 28 Sep 2026 05:52:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 05:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589119;
	 x=1790675519; bh=Lzi3+wRA0bEef0Pjzko+8yycASrdTv0MdodEe/eYEm0=; b=
	Xd+0c75R17ZAHfHLtSGGiyzTLQVImcRyabl5/RQ4igtR4RS3/ss9i22N77h5j33D
	HjgbMOmfAnU0cJbaBLAR0lbXHeuMpJUdg/jealq2cMPDIM0CtIoVqwO2Wuc/9H3c
	rCp4EG4Mb/qjTnco9yzLC8CSnzaRBuIWE6KDMOwsx0VN4yS4An3kEY448GJjkjXW
	Z8tKjZbhz+i0gIzujID4s5bSTTRxbrEP5j4NWmf83jucNoaOaCevXM40/kLbsUji
	KSbQWNasUMCVrnCEiBWw1JqtT41MuOXzz+/+tDlth8ZnaAxg6zKFXpXteOqgWxSQ
	JtL26Ome5uwd+Qx9XEB5mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589119; x=
	1790675519; bh=Lzi3+wRA0bEef0Pjzko+8yycASrdTv0MdodEe/eYEm0=; b=L
	8ocqcbaWnp2a1v3wr1+8Kw9LvfapQcx9yfV4eShpMWlPpK3Aon+Jh+Qg9c5/BuNl
	8HxDQumd+hOpY+eDvJ9+69Fs7t2Tkp8GD8sDsBu4AwolVmQYQCd6gA7a9FOhmca8
	IWLK0m5pEJEg6+aCiOdIePaW53NIpN9p+GnKZuSogPL3ag6uqqJebOUceF6qTMCA
	xlrigFhkDA8p1fKkU5+l7WrJvKrUkzcBeFi1h0CZCnYJgDRG6N89sDvygPehmeLT
	JTNebEheolk7fSlHsM6bZovOn5v8TtcDREon2Ys75OIRRkokRIbyMeLCg0XIkrJ+
	NXKR7wZGQQeG+IOrNfEZA==
X-ME-Sender: <xms:vzi6aqnei4LeG4ZCQ9mCSaHM4il7a_c7ekUbrXhn8nsaVZBCth8YFQ>
    <xme:vzi6apSbN8N1Wr2G3263zFXCQsTuR193nnBnuTzVLep6r0z7x0C9r4r0_B6YT7x_-
    kpuHuyxjhmGiibB61gXrcrsW7ztiLVOxaOZIP9QJJKOzqYZde1yC-QO>
X-ME-Received: <xmr:vzi6amA-Yg2ISPtlCvriF3wK_xqgcMPKFjnGho-JKC5yzWli9oFGUQ>
X-ME-Proxy-Cause: dmFkZTGtQAXh4+jJgEaWagkcb82oTT49I88r1gORfOnbw9zOsEC3eEeveHhLt5Jfw2on5v
    XuWG9iXWgmqIRN2Z/GMiDjxdNHA6ayW3Ie+7l4DvZukCoWROCz11LZzOoWGtiF8gFhDLN7
    7aAUCEMS/zmCCalfZUHzbn0d6jllDMPvXw+k8hbcG8r4E5fao7QPQ0uPr+TJxjDU/COQC2
    21F+Pr+drrkAwnBFJchnm6CikqiuUUmjxYEzxXwVf/I5IYiMbT5/JKOA+QVINBrlOtpIez
    /WUurV2vlnoOk6rD/Qd8JUnVXd0ZajjfHtVl/qaB47dYWY5DF+vvMgcdRG/7QWKNnkonUk
    1UvsQP98s0I2/UOWJghonfbZb8N3uQe7YpNZMOzhvQK7x1RXL1bNCE8z3oHmYiO28FgPq0
    8PRTOM3cRTvfZ7r9E1sZlkSpqMpUE24S5BR9uaqzj7Lex5zZU2HUTCU6cQRfuGfQ45iQYP
    lBx/idiRSF6F7wN88ZgczrRAsoVYXZ0wWG/th26RCwgjViF1OY0iZCa4xfzu0Dx/Hdwrba
    7hU4qpsiQqgL+hyt8n+I5N35uX4a/kbJvG23qLkdcUUhF41+GT7z4iSEV4VjzxCXwxHHIP
    86D2bsVOgp2hDWi4ZeoJ4aYyIeIjN/w+svcNIB11tQrKN1WcWZTatpyYgJ0Q
X-ME-Proxy: <xmx:vzi6aoRSKaBePA6MWssJJgSUnoxSEZKi40bK-mcPQgVG2z1XkiyIug>
    <xmx:vzi6aso1zEUMsAui3XLof3jw-VEupuftrxS0J73_Mz_KzrC6uygyPw>
    <xmx:vzi6aizkD_0b3Bo6ku84mKcPOIqfUyo9WKpQqDH4ggrYLq1-ViTMhQ>
    <xmx:vzi6apK4JvU_O8Bsxfs6bjxpbx8gTMqXwgTkg4w5zEA3wynpdiuPxw>
    <xmx:vzi6ahsN3CG7qy9l5UBtw7Hvqqd-I8L6YKLQ_q2wWZXjXNZiwg7jm28U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:51:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ebee2a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:51:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Sep 2026 11:51:06 +0200
Subject: [PATCH v2 5/7] builtin/clone: don't apply "core.sharedRepository"
 to leading dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-pks-create-repository-stateless-v2-5-a03612f703fa@pks.im>
References: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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

