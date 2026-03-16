Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A038D006
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655713; cv=none; b=fScvg0EhuYpu9k3QsOfqClWIQVFCvN9ifKOCJhV17HTd8kOORah9/ANVGWRW08y8hnrTQl2jrHrPAhHYYrkfhCAk7GVeh2natNeQ0HX2TLH7liYVvdeebheq34PIjqZyDOTeN27UeR2yLVCiAj6sO+IExWM7B9et7GIbuCJbuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655713; c=relaxed/simple;
	bh=FfSuzkjw78d8ea2MPVaI3t/hRBE+U5pP7ilIdUAlUsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1XzeWS4DW+kN0VPRU2dN90bkBH+rHX6/gs29LGATEOnSKwlLM9heDXohCxekIt0rwihXaFXTFO9svkIr6yAUAum3rPYcg+10sg3+hP9HyaXlzCYKR48faA0UQ+H6xN7Ovsh3wPHeGwU+gfLKIYDNJZ0BRB6MAoKeId5z+VqYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YJyBuT1B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfqWRwTY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YJyBuT1B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfqWRwTY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 17347EC00B4;
	Mon, 16 Mar 2026 06:08:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 16 Mar 2026 06:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773655711;
	 x=1773742111; bh=bx8PGJ45F8wsNLftFPc5Gw27DFZnvlIfL+kcPF8EH7w=; b=
	YJyBuT1B2kN778nxEhzekHjnNLO37QGr/vv5BmFuaMyC8+AKPh0fb4som+eP1J1E
	DHbXzfY6ELytFqR1w6RvP6IKUNOzIOozCHDlBV5Ob3QmbdOLOmMg2qoAlJ+mU/9f
	wbrqEMzO5PUhxJr/jlW6UICPAXAHIk3C3xYU3izrsWlk5yae/T2OL7hEkCTFSN58
	4E4UzBeVY6VHR1ROc3amuq9ctDfgOfz26UO/8sFCYWqjMxRQ4ASEv1sZxWBYbzSh
	YjFgtS/SvIPUpQZBy1y8kZzXXWERlxOqyZHfXGK3IDe8bLUGW1b/n7178HTAAqP4
	CpOM66QtCtNQs3g8g2/YIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773655711; x=
	1773742111; bh=bx8PGJ45F8wsNLftFPc5Gw27DFZnvlIfL+kcPF8EH7w=; b=h
	fqWRwTYF8yuH4Re8jMoRqjw9WwwGa/lDUozopquMpqTL7HJH0DK9+GSrVSqE1Qtx
	qxsckhc8Sf06w4BxkQ21lalOFCdo4enzCVJMMniruKxo+kt9eN5lAqBkS+4ZLtQV
	U5Vo+1Fx701gTR6qPaEND4ekRGt0DZ4EknLo2pL0AO4nTnRaGXVlFdVxN5XPY7aj
	bWRoxN+brRzflSLDyLMxqK7k6DJOutxdPNp75gGILJw/hFZYA77t+D09cM8ZOzP5
	fL8hLfzawEg6InSN2i7mjbbAZDpR9hbr1ybxYQl9fQchr0QZ7e0QKm2FIpUU6RfN
	6qrOnHWmtSpGweWJFwSgw==
X-ME-Sender: <xms:nta3aTkdnuc64ZI6rkhGRzLc1zqLbgNK3ZMDT44q4BvqMMKT0zcXHA>
    <xme:nta3aUq1P-R4t7oPBoVEYM-cSMMaxrb-bEVVUw7L3KfqDIbc0AyJWFOUwhBisqGgy
    eDzd5fN3WbmzfLt2gdgpZkF0wfntsqY8fMvAP8po2X1UbxDdk9i7XE>
X-ME-Received: <xmr:nta3aUHieWXDLk4iIeQ9w6oiekku6NWkRPNMvPHgS-U20n4ofvxDx3Srx1KXXAgB6kbFyBfX5PoRp-6iE-QTABJINqTzcALxGfZUOySy7c0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejffelleeftedvffegteeglefhteejudeuhffhveeivdfgjedvteelgeelhefgfeen
    ucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n9a3aYwJrvZY0qln5dTdLjJhjX5LvQaw8xNUdwDeWpVElwl6myg2aw>
    <xmx:n9a3aRrsqCGKyHDpT2176H6PgQ-tiTM0ndFSBT5fGz7Ct61juOX0mw>
    <xmx:n9a3aajJMGjMK7vWN4uQFAhT5F803zYBX1HLkit01oVGf9DL-ME_nw>
    <xmx:n9a3aWhf5WsfB1zsj00mVOKuwP5AaQtfPbMUfUCmZSY9oetschXfWA>
    <xmx:n9a3aWDRcogtDMht7rcdGZARbOWtNURn_HMhxB-08NV79USX9V1itNQ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:08:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6b55058 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 10:08:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Mar 2026 11:08:03 +0100
Subject: [PATCH v2 8/8] meson: precompile "git-compat-util.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260316-b4-pks-build-infra-improvements-v2-8-4b2c2c0c0425@pks.im>
References: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
In-Reply-To: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

Every compilation unit in Git is expected to include "git-compat-util.h"
first, either directly or indirectly via "builtin.h". This header papers
over differences between platforms so that we can expect the typical
POSIX functions to exist. Furthermore, it provides functionality that we
end up using everywhere.

This header is thus quite heavy as a consequence. Preprocessing it as a
standalone unit via `clang -E git-compat-util.h` yields over 23,000
lines of code overall. Naturally, it takes quite some time to compile
all of this.

Luckily, this is exactly the kind of use case that precompiled headers
aim to solve: instead of recompiling it every single time, we compile it
once and then link the result into the executable. If include guards are
set up properly it means that the file won't need to be reprocessed.

Set up such a precompiled header for "git-compat-util.h" and wire it up
via Meson. This causes Meson to implicitly include the precompiled
header in all compilation units. With GCC and Clang for example this is
done via the "-include" statement [1].

This leads to a significant speedup when performing full builds:

  Benchmark 1: ninja (rev = HEAD~)
  Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
  Range (min … max):   14.195 s … 14.633 s    10 runs

  Benchmark 2: ninja (rev = HEAD)
    Time (mean ± σ):     10.307 s ±  0.111 s    [User: 173.290 s, System: 23.998 s]
    Range (min … max):   10.030 s … 10.433 s    10 runs

  Summary
    ninja (rev = HEAD) ran
      1.40 ± 0.02 times faster than ninja (rev = HEAD~)

[1]: https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build         | 2 ++
 tools/precompiled.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/meson.build b/meson.build
index cd00be1c23..2002f4795e 100644
--- a/meson.build
+++ b/meson.build
@@ -1760,6 +1760,7 @@ libgit = declare_dependency(
       c_args: libgit_c_args + [
         '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
       ],
+      c_pch: 'tools/precompiled.h',
       dependencies: libgit_dependencies,
       include_directories: libgit_include_directories,
     ),
@@ -1820,6 +1821,7 @@ test_dependencies = [ ]
 
 git_builtin = executable('git',
   sources: builtin_sources + 'git.c',
+  c_pch: 'tools/precompiled.h',
   dependencies: [libgit_commonmain],
   install: true,
   install_dir: git_exec_path,
diff --git a/tools/precompiled.h b/tools/precompiled.h
new file mode 100644
index 0000000000..b2bec0d2b4
--- /dev/null
+++ b/tools/precompiled.h
@@ -0,0 +1 @@
+#include "git-compat-util.h"

-- 
2.53.0.959.g497ff81fa9.dirty

