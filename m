Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB336827A
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806090; cv=none; b=KpZ5FXAvqp+pzH0shljaNdQE/nCWTvtSbIqQQIAgfYVXQ5ddeEIegyN5qgaawYA7jV7I8JEaLdPh4gT9QDbrlaVAKo91jAgKKa+iy8jeigv4jtDh2qZgV+mzrG4oiM9ElfoUerI42ySGA4dFWSpYeCEpXCMFt0Y6NtNEwyHTG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806090; c=relaxed/simple;
	bh=nBJo65aYbDX00y6a4jWj3LRYOcjv8AnvBXsw7WYoKeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsc00DEYaNgruAspBfxwVW17s02s4vPmexLRxGgqz1oo/qhMbtppZ5Rt++domITvJKc8pNOmYWhroCEhLY17k8sjTKAERcU1TsDDn6HABaTPmP4JYwFZOX+SPeLtM8JsnUjYeAbF9mOmYNhDQEepv4a8vTh0TOVrKxXaUAkfp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nz2ZiXAx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ErgeuKon; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nz2ZiXAx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ErgeuKon"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 025887A010F;
	Wed, 11 Feb 2026 05:34:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Feb 2026 05:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770806088;
	 x=1770892488; bh=Yd8yowcltpzmk/+tpdsO+K/L65b1VmcJjmXwAWAjv2c=; b=
	nz2ZiXAxzKgqRy1RSXIr7KoAg8RtzFIY5ILqZEDlX/fq+4IYnE2nZOJznUmPkDOn
	79RIMexFSfYFMtNxJy/zrabkdgBg7Ct6Gjs7zM8vYJGv1c4wpLVd7Wa4I9GMVc6v
	c21efysTfC83357JdgyUZx0qbRn9gtqkwZFubDE//FNhVDl0kQF/BD+fPsNs85ic
	4CQLcmSthJmHkM70BdEo31ONcadFkb50uhQtrKEL+iZjQXRQmDKltgm3n3NnPkxH
	27kZ+vh1aT2wmnBGcyD9nF3AVMzg2aT8jBbO6DfLRlNS0TbesLXL/DWARI9c6hGd
	HTbFXPjJ7yJ2mU3ciG9dGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806088; x=
	1770892488; bh=Yd8yowcltpzmk/+tpdsO+K/L65b1VmcJjmXwAWAjv2c=; b=E
	rgeuKonTXwzkK2IpG8Y/TaBR/VCKjS+3P+c2OMvKDez39rlMlQOZBapNU+50YqEG
	u8ZfJ+ML8/FiheqEthzeelBKHr6cPii8OL4ch9QVBxntuxVOKOM4obj3xbXO8HFv
	wR9mMphykFDNp4t7ydSz9hbmlpK2GRhb79+yrsxG7FzxlmDxdzq5ZTOHBLXeHK8+
	LbqJhJXMhnWKiFrv0k2MzSSGqwiM6QRDkbeIX/+C2NnPfW8IlqV/7npyWWaNIDvy
	u6TRYTWQoCVzDMyEpVZaRB5kpPG/pepcNFLruduiO63GRE26Gb79ZKSw2o53jy6y
	Q7+kc1/Z4CyGb37ukhQrg==
X-ME-Sender: <xms:SFuMaYQiUKslE1aOnAIDZC2afFw10WYjHVtIIWN4yE_3HHHKi8ltig>
    <xme:SFuMacwKAJ0lJRJkU9doco7CAShdj4m1ujDVB3Z8mtPBBSP5Hs_mOag6x128MOeBu
    jdRzhvJA_gsRE5T_LLLWPL_qhxW0Sx8jE5Brt1JzT5pBF9hMsBBxA>
X-ME-Received: <xmr:SFuMaa3usSw5ogmOREumsCsOimQXtpxKie2wNvrlAZ-858gnvbwCBzFWoqsfaq0CbgGpXQ3U76DVD_E36boDyVrwjsxIYWDy8azRSFvd3lxN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SFuMaa4bzsrs1qmaop7vA9kverh0Y7AQgTgMMCEeUTPWniNnLF6GoA>
    <xmx:SFuMadVSSZwrhpZ9hiTFYmRxaIWUX4mclOQqf4SuKTtj8WYzZ6BmEw>
    <xmx:SFuMaZDwlczXkRZcZuSsE0qvu-8zH5NqmJb9_QBxh3Bqa-sbAgoSDQ>
    <xmx:SFuMac7go_7Tvos69pjueaHlVgih5RbRpTnqzcxfLjER0qRZFbUdOw>
    <xmx:SFuMacygLcE2-G4fvKrRIre2BGUsd18Owi3DBjlgY_CQcu4gLdXVTcjl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3994d26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 11:34:29 +0100
Subject: [PATCH 3/7] meson: fix MERGE_TOOL_DIR with "--no-bin-wrappers"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-3-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

On Windows, we execute tests with "--no-bin-wrappers". This has been
introduced via a87e427e35 (ci: speed up Windows phase, 2019-01-29) to
save some time: spawning processes is expensive on Windows, and shell
scripts tend to spawn a bunch of them. So overall, the bin-wrappers led
to a performance overhead of ~10-30%.

This causes test failures when using Meson on Windows:

  failure: t7610.28 mergetool --tool-help shows recognized tools
    ++ git mergetool --tool-help
    /d/a/git/git/build/git-mergetool--lib: line 45: cd: D:/a/git/git/build/mergetools: No such file or directory

The root cause here is that our bin-wrappers are usually responsible for
setting up the `MERGE_TOOL_DIR` environment variable so that we can
locate these scripts. But as we don't use the bin-wrappers, we'll
instead use the default location for merge tools, which is derived from
`GIT_EXEC_PATH`. And as `GIT_EXEC_PATH` points to our build directory,
which won't ever contain any of the merge tools, we will fail to locate
any of the merge tools.

This issue has went unnoticed for a long time given that we only skip
bin-wrappers on Windows, and because the CI jobs on Windows didn't
execute due to a bug.

Fix the issue by always setting the `MERGE_TOOL_DIR` environment
variable to the correct directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/meson.build b/t/meson.build
index 19e8306298..5ba7efd603 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1208,6 +1208,7 @@ endif
 
 test_environment = script_environment
 test_environment.set('GIT_BUILD_DIR', git_build_dir)
+test_environment.set('MERGE_TOOLS_DIR', meson.project_source_root() / 'mergetools')
 
 foreach integration_test : integration_tests
   test(fs.stem(integration_test), shell,

-- 
2.53.0.295.g64333814d3.dirty

