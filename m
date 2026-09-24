Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB449B22
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241587; cv=none; b=HS9TBsGaLpXCXjFEJQ3iiqEbaGH4OyT0YQQUKDisE+r6Qylr2hl/K6PC08VIm4WCu6QkuA7u2rY/NqQ2hFptHycwYP/lmtsJLh3+8eAm8k1sSBbCkc2PpIkhEEQZ9Dk7qybV5+Ll15/Lcx6k2jQ0dZp2xoiBTy1O3b9Wyxa1Q/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241587; c=relaxed/simple;
	bh=jd0Mrct8o375cWw6SCIJI9k3Wf3zSYqq8bETMpEw5c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFgwMgSSV+EXPSL9OVOuu3hrwjIRqFlPbcVFq0wsm8YdfJMKV3U6I673/qWl59ydGSd8qfwX2XqISFstqBS34FBs1XU3BwzRWDg/mAtCW7kPhyzWGfkt9LHKKSEURMdpJMWFGGDrQ/tAeKoyrwuTF8KLMAIOxrPbie9k5suKawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BQ9I8h9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQeUC6rc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BQ9I8h9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQeUC6rc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9223EEC00CC
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 05:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790241582;
	 x=1790327982; bh=McZ7kRVt8TEH3TZweFbM5KOot393HAUfnMmrT2hvgcg=; b=
	BQ9I8h9yJEZezhDw5X4HLhpqA4f8qi67cIsHxDe6QSj/4/HqVPV4Ie64fI9QWw6v
	qvTpKldda+ZKv9ChoIMmkqHjzfQdB8EPEy9hRuZbUUYB2RjXo9ypU0C0NIqL8NAy
	JczFcKMMQ/2A8ToGG3gr+hk0DFxPQ7RLr0WD3KkRr1n091zr2KZsNGUi+uBj2ZPL
	fcVW0JNNhGmSQOfa4CWJrbLYn4IwsWV8zvmNA+8EUlMZMx4XwtgaG/O9IyLwgM93
	RFTzwTu5LzoMfGbX9qOnGBENJNTyTuYPiur79LeAUEeZpHdv+KRO+eIUhxrOXXma
	Lmadh22GE59DumN4b0O36Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790241582; x=
	1790327982; bh=McZ7kRVt8TEH3TZweFbM5KOot393HAUfnMmrT2hvgcg=; b=W
	QeUC6rc+zj3Zw5dVb4jV49Oz5AUiEscNjSchqsNYLXiraKPzwnB9VmEIOo+zl9md
	I7ILTATDMOcZRg1qMXf4Zztf0rzCMS/M1go6uOi0puZir291CVDjQYB95HwKsvFW
	/JVyLdAe4jLGiPzOHucIhi7brCePc+ykUrlImq5Pz9dMl1EkDThRkaW8MttHq9HV
	vQr2ifX/lHG5EKUOh/70t/5mgDADWAik9+rEIGHDpyBMvm1QrUg8oBROETWlSFjz
	rkzTukNnLq6dBeoumvmFvw6JfdWS6VTMs/IsybghA8c3lMkKZEY+/LnwzZ+GodPN
	gMea7mtbTmL2nuHLZQNeQ==
X-ME-Sender: <xms:Luu0ahT8ovZh74EbOewPvJafblKk--r47WHhINVpXuo47mjgARprxg>
    <xme:Luu0ahth79Lg-E5wQBgVtgOIDbqwFjqp0mJHcrsn-PgzcCMdHn98mX0FSNjOjKC1g
    Wo3lqgfOYlSxF06FL9Okoy_nZuToVfKRSSB3NPUmr2uu4mok84QXck>
X-ME-Received: <xmr:Luu0ascFMUxq3ZnvMfS6w9F3qs2GkHtCqL2772SELkeXXZZNqSxeocjp_SgPbgEuV6_zyy0>
X-ME-Proxy-Cause: dmFkZTFPodOiLWcdqf6sGstU46dIiqXidIFd9cR4fooPG2VzhuQs4sgHwSSL0mI+zYrJki
    puKwTM6PzOLvhrOnHha7/ZqJXKFWeUZ7pL3PmhkuvlpM0SAOkWbZk3xZQvHRMhKdNhwt4b
    RD3a0i1KaVTQhiwtqarc8pf3XfoXA6W5MTyTZacFoe6F2umLNsXJ1ouYl3pIUvkblQZagq
    My5ETPa7FIKiTyNS2see97qCZqfu7GXNWEANEz90j9Xl651gCUX4FzvDgltnokz25gMaTM
    HthS5xNHFJNXlc52D+rP6WxTTQ+lRC0R4uRCl7fXgiak8N0bh0v8/Rl7rSKJ4fouMiwlCl
    8Rfti58r3Z3UM8fp72cRyxD3JBOLE7RVMzdBqm0HKm2+2R3xPzWEqfT40lzOjrFMmNbluT
    +xv/+z4E8B72HZWkgc9+8OPMs/S6G0f9RdlUpV/otrpZYM+BXsGhghDbHH01kDjQCtgduU
    pSw1SpV9XIGdOLatwYaxPklcaWdkdpKNF9siX4rGAaLECfPWbyQfibbockeFkVeGvqoDik
    7I6n7Ql9wlrlp/r7X/ezoItgPEm7mPevX032Bb16BDYUUmaiW1AqqH8ps2NgW9AmS7YeWs
    SxzkUSOTjohY7SllQl7IaLLW+4ucmJg94jwfX0V5XJ9c3nHDvKiR0LPSNwVQ
X-ME-Proxy: <xmx:Luu0auLA-cnnMhNUqAKG-Id4s8KK-784L39kxi74AijVyAbcFuil9g>
    <xmx:Luu0aqYhH9A6leHwNj_Z2x1KPFdxbtwTlHpcCYV51vFXErVx8Quflw>
    <xmx:Luu0aptkL1CYhn-AbgRMZ8Qnfmb2Ylx73X4UIpkFyS11gt0Dsn5ZIA>
    <xmx:Luu0anshdPBu8nThSel6uYMJ1XIb60JybzicZq_GcCQNS0wsa6VN1w>
    <xmx:Luu0atQMSMT-1e2a7u8rQmx5rRYWbGpFYt9YLYY8IzBhQX0CY3UMztMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 949db1fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 11:19:21 +0200
Subject: [PATCH 3/7] builtin/init: refactor messy creation of leading
 directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-create-repository-stateless-v1-3-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When creating a new repository via git-init(1) we potentially have to
create any leading directories via `safe_create_leading_directories()`.
This function optionally knows to handle "core.sharedRepository" to
adjust the permissions of the created directories.

The value of that setting is taken from the passed-in repository. When
creating a new repository we don't want to honor it though, so we
painstakingly:

  1. Save the current value of that setting.

  2. Set it to 0.

  3. Create the directory with `safe_create_leading_directories()`. This
     has the effect that `adjust_shared_perm()` will exit early and not
     adjust permissions.

  4. Restore the old value.

This is extremely awkward, but it achieves the desired effect that we
ignore the configuration. There's a significantly easier way to achieve
this though: we can just call the `_no_share()` variant, whose entire
purpose it is to ignore "core.sharedRepository".

Refactor the code to use that variant accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 5c22eae2f3..e45268f1ff 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -131,15 +131,7 @@ int cmd_init_db(int argc,
 	retry:
 		if (chdir(argv[0]) < 0) {
 			if (!mkdir_tried) {
-				int saved;
-				/*
-				 * At this point we haven't read any configuration,
-				 * and we know shared_repository should always be 0;
-				 * but just in case we play safe.
-				 */
-				saved = repo_settings_get_shared_repository(the_repository);
-				repo_settings_set_shared_repository(the_repository, 0);
-				switch (safe_create_leading_directories_const(the_repository, argv[0])) {
+				switch (safe_create_leading_directories_no_share_const(argv[0])) {
 				case SCLD_OK:
 				case SCLD_PERMS:
 					break;
@@ -150,7 +142,7 @@ int cmd_init_db(int argc,
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				}
-				repo_settings_set_shared_repository(the_repository, saved);
+
 				if (mkdir(argv[0], 0777) < 0)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 				mkdir_tried = 1;

-- 
2.56.0.rc2.329.gd58861e689.dirty

