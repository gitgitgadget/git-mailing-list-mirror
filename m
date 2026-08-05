Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D023DB651
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956610; cv=none; b=ujZXSzfuAU9Gbtv2C91PSra/H728O3V7Gtpa4yzdO1KgR1EkZyD2Bdzg/YC37ouMgpUEpiW9rd06aVgB8MggCscIMXx+ZEL51ZTC5RNoIWZYaiU8UAd+OrGmICdVS+fMW6faKY0Guu/dWal3ZaX8znaBapYZwvAiha7oHG7lSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956610; c=relaxed/simple;
	bh=hENKPrGqCWoVo9oHAweNGq6GCbYbNjd1jDsTJ1WCS1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIOs7Wi6/jrFWGrQsDvHP4ChRnwx0kgBuIvS8H7nwwMvf0+3X6IxxWv+22G+ttTozD10x8DG48Gi86BDi5ZhsbL9+RKBL2ERCHcoLQLR37/tMoFZH3tmjkRXz0pmVWicITBbvehh5uID7pXDuAQth8RxGpYf9CaNkzUQ5biaQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Wxjfp1WH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hOe+R1ye; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Wxjfp1WH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hOe+R1ye"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 364727A0033;
	Wed,  5 Aug 2026 15:03:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 15:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785956603;
	 x=1786043003; bh=IYK99UxdZNqQgnQZh0pEPBNpBTyckED0pG+4ejWuRS4=; b=
	Wxjfp1WHIFdXEalhCnyvB7NTX/d+9T02Rm3SEC3yiNGAocGSfyOfBVr1eiB3a8EN
	qAtS1nYoz8/TJOqOnPx8gW5N+bsaS4ApHIa1eGrF1X5dOA2GR9bNJ2ILrYnu/Ihg
	Qw1l8IxRDxlTiiz33abzjSxvljoU02ShOLzi2iWQ2SYHv8QgMT2yE49i192yKIfZ
	/Ghq0qmhaX1dB/sxjWlBiD+UbyaYxZ7wpbQQ/0QnPPqw3wEODb1e8ti1LZZBs7JF
	tzD6mSGFx4QINy7oHskCHlKFo0oVnVOVOKNsKAOnqzGq7m2qbie2ONzRvHv7WK9q
	K7SvoOk4BnVE/zbn7DsfnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785956603; x=
	1786043003; bh=IYK99UxdZNqQgnQZh0pEPBNpBTyckED0pG+4ejWuRS4=; b=h
	Oe+R1yejWKJmhTWjExGXrfueAXUg6yYwj7D5FcvojkSzDlbe5WLOGx5Q6+7XI6px
	AiJc2CHp4p7x5c8dxEh9RvxsJTnvGiFE7jGRkA3FZLdAlUhWOokVbeG9HT6NxT2W
	2Ny/6/PaStgpyPkhrm3czc4paTBUec7tbQ6hk5sZl79vNq6771raQri6IpS+Koap
	Jj88xXWAm8gz6mcQmTbazG8X3rPuzWfiKFw9iLBhMHrOy2Mnh5lRnd1aF4nLQBDM
	D8ne8fdn7C8tAreyd8gfX/7dzBnLGEPb7gr3S1Lvt0eWm1pSDQWPcLw1KpUnrFAX
	Iu2qS+ZLPgqmUzfFG3pTA==
X-ME-Sender: <xms:-ohzavGU1Cn5OQxpnV09NeT5A6Qy9Z3WkPuLX8qqnamVZgSFso3jMeg>
    <xme:-ohzajWxrnyFjwJpwKXnJ0pmUDzELTQoen21iWwx7g9am8rcppa7eimyz_CfmwSzo
    TjXNZhC_YtwEl2YqIWi3BoywpCIIj_0bFJa8QTfH2ECmcGscOTJkA>
X-ME-Received: <xmr:-ohzamIfXcrCGl6_92g9Hs1kVAFnKrQVLBFvBGwwbzjrqGd0ixZ8pW48GSuVRaQCrwGf42z2avVw0VE5lAqajR-NFB265-9-MQuITHSTKbYvCVr3jXG0quA>
X-ME-Proxy-Cause: dmFkZTEfKT0/5nMtnr3adXnNklPXuVJO7ce/t1tFIYe8pOFluyLFYpzIsUqrEwhY5UdHN4
    5e8mzJrZTAsPwMn+WF/CxVZ+PcQjp30SfxZ1DMh8uNPnPNe8IbF7M5J+z/MasUdpcFtzwc
    liUop4yDgGRzzTkUoJAJeCVTA74mdzZ+ZtiVeBT/zzRKu4A+zLPObRzYMkFaK3y2BgDInr
    A0oW5vPVuQ9Qg37cNI+3GFCydzjYEFV5sl+x2QLJ0wDTgK/9HuyLHOoRGooQ4Sq68a5bdt
    BvsqbfhLVP1/jevMONXMkCpdZLSziUpzr2q55zfBz2qVPuwpiwQrE2GxK1bDO2sJeoLfR1
    39qC5Voyk9MhhU0LrAf51BFftDoK9Dc6Z2keZRfUv00TrXgwIToa9zkWB2rooHjRDiyH02
    ZYcXXYAgGqrYyZrMVp/CPFi91FsJUKi+EidxRBb91gP1xMPseieStnWYzbFOBny3y669HE
    7MOn5qrBYvjXMP1xCbhVvZwbq6JvLGYCYR7LD+RIj71SDgHnHjpQdF7vfdnsc/0NUWUGPx
    O94V+pPw4I1LM8WrnzbkMhVOFiaX9rx1ouAGw0fVk3Y/7uWjxSEB1AX0deDImTW9bdpT/B
    SorCcxE9WGOOrRR+1oWyPc6Ek/zaEi5bMbUHA7vPFyldL/wMfmfuaWO61Zbw
X-ME-Proxy: <xmx:-ohzar92UJeazSiLdF1K3rJJTUprARWhrv2mE1Lunem8Hr1x9rKQ5A>
    <xmx:-ohzahJfR38trGXz3ANnfzhuif2hj7nhtB7dyZAjFbkx-zYFS133ew>
    <xmx:-ohzaon0-9-UuVfN4WlI98gI1uO3_EwiqX7HAI0XPCqS1qSIf9-FUQ>
    <xmx:-ohzatNHMYDyJel7bR8bkTPPZFeulq0D2Flo4OI71EPq5xI76AuHvw>
    <xmx:-4hzahqUOpClstMBCWp3zXzPhWgMI2tNpSPzaF89yK4mJ83mbmBoUTfy>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 15:03:21 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/2] doc: refs: put ref migration warning under the command
Date: Wed,  5 Aug 2026 21:02:35 +0200
Message-ID: <V2_ref_migration_warning.b21@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_git_ref_migration_warning.b20@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz> <V2_CV_git_ref_migration_warning.b20@msgid.xyz>
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
up to the command description and put it inside a Warning admonition.

This section made sense when it was added in 25a0023f (builtin/refs:
new command to migrate ref storage formats, 2024-06-06); `migrate` was
the only subcommand, and this section was visible from the command
description. A one-page man page. But that is not the case anymore
now that the command has nine subcommands to describe.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: use Warning admonition instead of Caution[1]
        🔗 1: https://lore.kernel.org/git/anLvVAyckm7S9Vo0@pks.im/

 Documentation/git-refs.adoc | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index ce278c59bfc..3b5af936ed6 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -35,6 +35,21 @@ COMMANDS
 
 `migrate`::
 	Migrate ref store between different formats.
++
+[WARNING]
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

