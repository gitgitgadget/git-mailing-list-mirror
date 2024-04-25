Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA198614D
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040336; cv=none; b=QH73zrbuVbNtjkF2c5plLc3W8pVmLifaNDYn6m60gXeVYPAfiOaXpsqWaPR/j8gu1gxA1w0Ptr4bQ/zIzJYCp1eS0NBKI0vg1PtwiWLEWs47n2ONsb6WJdx4cDNWRY05TDdnFanI8N+ltV4HVrgkjJKZTithRjmL7mstdFB4648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040336; c=relaxed/simple;
	bh=PJW2fhdLtPgovMXAYEH9F+/W+8nhU3at4W5RS9yLqFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ksLed6CCt72PhyZmOqKbBEaSmNzFQT1FRcty0FBd/c3ZoCnicaQtZzZ+msra5SIp4tXtABrbVwY7O7qGhrhPKNZyaHlwRjt8JoLdXb8FF6p6/jicx6tdEyDsi2wuIl2lT8p8hJV7wzRKfSxVrBbm0W4elW8qAGyjf1jvqSKrQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBn-0005rW-Ce; Thu, 25 Apr 2024 12:18:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBm-00EFFK-DV; Thu, 25 Apr 2024 12:18:50 +0200
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBm-002yLf-1C;
	Thu, 25 Apr 2024 12:18:50 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Roland Hieber <rhi@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/3] completion: add docs on how to add subcommand completions
Date: Thu, 25 Apr 2024 12:18:44 +0200
Message-Id: <20240425101845.708554-3-rhi@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240425101845.708554-1-rhi@pengutronix.de>
References: <20240425101845.708554-1-rhi@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
PATCH v3:
 - change the wording a bit to make the text more fluent

PATCH v2: https://lore.kernel.org/git/20240424215019.268208-2-rhi@pengutronix.de
 - fix typo and superfluous "-my" (thanks to Junio C Hamano)

PATCH v1: https://lore.kernel.org/git/20240424210549.256256-2-rhi@pengutronix.de/
---
 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 566f32d412ce..5c0ddeb3d4fb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -31,6 +31,13 @@
 # Note that "git" is optional --- '!f() { : commit; ...}; f' would complete
 # just like the 'git commit' command.
 #
+# To add completion for git subcommands that are implemented in external
+# scripts, define a function of the form '_git_${subcommand}' while replacing
+# all dashes with underscores, and the main git completion will make use of it.
+# For example, to add completion for 'git do-stuff' (which could e.g. live
+# in /usr/bin/git-do-stuff), name the completion function '_git_do_stuff'.
+# See _git_show, _git_bisect etc. below for more examples.
+#
 # If you have a shell command that is not part of git (and is not called as a
 # git subcommand), but you would still like git-style completion for it, use
 # __git_complete. For example, to use the same completion as for 'git log' also
-- 
2.39.2

