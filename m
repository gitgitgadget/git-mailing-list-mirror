Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844C1DF75B
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488855; cv=none; b=qhS4oc5JIN5dNAvafb8jzdMQ5/psT+zoewXqmcUojYAy3wcpcivB7b5xVA786aFd7xZxsj3TwOMkpY+3Vey5e4N+7QUEPy3GJ6a9Y6JL2itnQ15G8RW7Jy99Q9aHIyR2A2wyd8dolyLAHHGwujINOoogzwKfIR5EuMy4yz/ynxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488855; c=relaxed/simple;
	bh=22YafD5GqOmTaI+GmRSvn+FM2HT2rfahIScZObT2jU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGfZjt32aw6T8tYUYOdy8WSpATbW3rIvNuctdal/VhlWdEOzQG0ZvqrZ/pfSCJmtheqIbA9XTRWQwpIOEdwiQu2uF4nyGZXezZmXwlrH5JH3vhwmMAKODBG93QdsWtvIYOnfmBXVZTBilnER9zPXTpImgvb0rkaZp6MzZnV8l/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZdVva7S2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOjuD3x3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZdVva7S2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOjuD3x3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B7C8EC0173;
	Fri, 31 Jul 2026 05:07:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 05:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785488853;
	 x=1785575253; bh=IxprdQjPnjqhh68BuzHgCHfUDStBIICPFxp9P+qSN7g=; b=
	ZdVva7S2AhhJ71bCQf52F+2GPwhX2vbN8BOZoMyinSeCe1Pzra8kURLEFLIef95/
	9lBbnV9juD8zsxp0DbDsQy9AYNOVBxkSTe2BHNLBWI3mile50gC4wRM5RBkDRRTB
	frkqcfI+APNRbeLtBxaCbNoyhq6gGIpqgDdpHrQDODk/VDENZCUo+IfHA+9eQdqb
	qf9j988uKhUxiascY2O6JbzrQkFTyyKbxP/3hvlQ1oDi6wogb5eBO0jDqhZ/T1wV
	A0lWSao1pWctajO+Q5QlPF9qKPeNiWPBaAcj3sBaseY8kw5aHaaj3i+Bk24ZQnHF
	nb84I08QlHc3/cBnsjxeFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785488853; x=
	1785575253; bh=IxprdQjPnjqhh68BuzHgCHfUDStBIICPFxp9P+qSN7g=; b=Z
	OjuD3x3W4gwC0kkbyzu3/ARiHx3FdOBnxP12Qoa8WkwzgAnHXIyUtz4M9IDGyxHC
	jqRM+5ldJhQHM7roZuj8ldLJtwKe3BZS3AkcClDkvyzFZyOVCvY2/pST39l88IgU
	gV+iLCmCrfwHa1r6d77VyFtuql4Jr6JKhzt0BY8Q8zhedcfhBurR7sxZWjDgLtBL
	0hUOw1CDrMgONED9Ks5WKcOdMRprQN1XMEB/NFepzq72iruLEGFYT8hkO9JHyNdK
	UGM4C1WRYjxtFKcHrEnnKP5DCbGQPCrUYtGj5wgelNChmL4IorUSKETmjY4+ddR/
	0BVQbcUpF5aLyzdksvFQg==
X-ME-Sender: <xms:1WVsanJYSirI0TTf_bToC3hfSDa8Px2fS7OT2ag2WtUzaw8Li6hrnpQ>
    <xme:1WVsaiLVZJXYSow-gUCPqDwiwZk6hNeQqe706DAMjUJxBGR_R6fhOWvxRrlGExx9f
    S_oWz2EATPnDniALs3p1h4ZmxK3hvQ49a9QcxapWUq5GCe-OfU1dF0>
X-ME-Received: <xmr:1WVsaktZrZjjSNQgJuAxhKIOkLj0q5vVIwLd1-u4U_NG7owGnbyFja77-6dHx2nM-NYqhzUc3wAEI9_ryV7gGw-urqGybkuHCsvTTNNNbF9KAfIeQpM32lM>
X-ME-Proxy-Cause: dmFkZTE9BvjOtTQGXphtU8/Y81rKna3/hldMmxqCPpe1OVkx4VQWKF4+fhpJRa0VXoVIzk
    xQNMWCn8vokEP2FBrK5hhA1kdhwuZMfJgwVXrl/LcXbYud8TO4imZ36lKFH0PGnwozyI0W
    k0aglpPuZZ8jBt6NE5WGNqb7rXXSD2ppajs+o9DI4XNb1+nphx5O2y0cuka+xYLU9fHF0+
    9Ld81uQX6lhFeEYcPbZYz7uo3IZFeiuJ1AKZZ9Ut3eo+tzB1WDTfMBUUdaeTmtZmJqPZpQ
    7URY4+dk/w4sVOEQDsIvyildTsJBFc9KSbisfdS6zvFIzkdECJbklS8qSJWihum4oAxLes
    EeqM2ibTinpwPi8z6l/f/uJ7Pqad1QEOszTa+RggfvJLQlzW4zbbL+W8/i42zYhRBaWMFd
    FLAd43lgTqlx9Wy43ppjH89A1+1XBkotyApdeIlo6qy3KeeIByAnFZbhLUtK2kd2gUSlA2
    /9D9ivRj6rXhof86dDFqo1hgRHP6a5WLP7GYYIrmAZllsm5GTW+Et3LT3MtL7kFOSg/mk2
    iY4B/sB/ZqhDPWk+bzIlAyII/dqIeAslZPBkUmpnQGcS3RyQHlcsK59axhtxTf8JyTdtBS
    ZNtN5GF4TeFWwPQ/Wf7uEJ4oFw5Qw53J4uIfwsWDVrXG+iNRTn1lgf53ilMg
X-ME-Proxy: <xmx:1WVsavR0TPQXrtjMBPShSvEEG7uRKymdAfiFoTWxfxuxLk__d4cwjQ>
    <xmx:1WVsaqM50su-lEgeIYuZTdndRKpJdXTU-0q2PGSzH7BrwhDmVEaz0g>
    <xmx:1WVsakZKJXPVdGwEeBr5_Ny5stOOOAf19jBHC8wajXHwnHOUfPMoog>
    <xmx:1WVsakyXDjzc-Jxp2dPTpU0MY-ZQLvhlw_SnHG-lEOu2Xlh-uSx3hw>
    <xmx:1WVsakPr1bHQsvZ8zQ5SIUZLbf9w3RPQW7b8nIex5jocwWFXuRwN9BNJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 05:07:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] doc: refs: put ref migration warning under the command
Date: Fri, 31 Jul 2026 11:07:02 +0200
Message-ID: <ref_migration_warning.b0a@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_git_ref_migration_warning.b09@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I have to scroll down at least three screens in man(1) from the
`migrate` description in order to see the “known limitations” for
it. This is important information since the text says that concurrent
writes can lead to an inconsistent migrated state. Let’s move that text
up to the command description and put it inside a Caution admonition.

This section made sense when it was added in 25a0023f (builtin/refs:
new command to migrate ref storage formats, 2024-06-06); `migrate` was
the only subcommand, and this section was visible from the command
description. A one-page man page. But that is not the case anymore
now that the command has nine subcommands to describe.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-refs.adoc | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index ce278c59bfc..98828041c23 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -35,6 +35,21 @@ COMMANDS
 
 `migrate`::
 	Migrate ref store between different formats.
++
+[CAUTION]
+--
+The ref format migration has several known limitations in its current form:
+
+* It is not possible to migrate repositories that have worktrees.
+
+* There is no way to block concurrent writes to the repository during an
+  ongoing migration. Concurrent writes can lead to an inconsistent migrated
+  state. Users are expected to block writes on a higher level. If your
+  repository is registered for scheduled maintenance, it is recommended to
+  unregister it first with git-maintenance(1).
+
+These limitations may eventually be lifted.
+--
 
 `verify`::
 	Verify reference database consistency.
@@ -130,21 +145,6 @@ The following options are specific to commands which write references:
 	Operate on <ref> itself rather than the reference it points to via a
 	symbolic ref.
 
-KNOWN LIMITATIONS
------------------
-
-The ref format migration has several known limitations in its current form:
-
-* It is not possible to migrate repositories that have worktrees.
-
-* There is no way to block concurrent writes to the repository during an
-  ongoing migration. Concurrent writes can lead to an inconsistent migrated
-  state. Users are expected to block writes on a higher level. If your
-  repository is registered for scheduled maintenance, it is recommended to
-  unregister it first with git-maintenance(1).
-
-These limitations may eventually be lifted.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.54.0.22.g9e26862b904

