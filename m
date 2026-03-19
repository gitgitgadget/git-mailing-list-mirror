Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF243988FD
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898429; cv=none; b=Q6mlmgj4L5MOp1iCuAc2kO5C9CS8RXLc3DiMhW5Jv3HtJV9dI0G2uxlD0jU8+bm1OuL64VpoJ4CYK9veDnqEZiAx0GIT5MnJVwUa9SiBD98rhBMW6ulQYezzGf+ra28PA+e93taCPi8XvXMRyKYynCmyMoTAwU7qFArDIsjTEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898429; c=relaxed/simple;
	bh=FfSuzkjw78d8ea2MPVaI3t/hRBE+U5pP7ilIdUAlUsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3b3vZbH01Tf9c++iUr4/EZitZHOn3JqtpSv2E9vFLCpQTN2A3hsdxVec0vICJXwdYFIslPtQ9MJCHZO9XWs0ObLcTglGA0yLfyFLFSoC+Bgn5sQFFRvjl67IfltP3af+GneaejL1mn3UFAC8GT+bC78ZcYxFMZk2rerbtVpdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AwJwkzWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlKOKubb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AwJwkzWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlKOKubb"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AD1C8EC0219;
	Thu, 19 Mar 2026 01:33:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 19 Mar 2026 01:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898426;
	 x=1773984826; bh=bx8PGJ45F8wsNLftFPc5Gw27DFZnvlIfL+kcPF8EH7w=; b=
	AwJwkzWamxKL0ixuFR9rRodY25yVnZHPEVcKBNYBNbEc7kMXg9DOBjOuUMKqbYPt
	kjEAUMMmHhbv5v9s17cXui9lnY9nsrJlEQp4a10SGsJzE9MnMaFzOwSYwTZK+RhJ
	jrqSP0VeoKXOuy7PcKpOosZwxp8be98LvxvaQVaLQAPYCDaFmv7TzmvO5tnUrvub
	giSmtW7a/Tk70SFrIITwHwPlrftBH+tJ8H+VT9h7LLVyabrtGJxLzwVl2CBQKMzl
	JeI7EI5C25+2DD58QZuroI6CPHB40eSO4aX1p9F2kPDHiqIh1UFz7TYFcEKGqnoH
	BhVwdFN9N1Q2oV3YajqxFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898426; x=
	1773984826; bh=bx8PGJ45F8wsNLftFPc5Gw27DFZnvlIfL+kcPF8EH7w=; b=K
	lKOKubb6uMyDcrlQeKgQAb3EnBqiD6Fpo8pzCLxuQpBSIwcqZweWXIXO4McIYlKo
	S1cmqXN3loX1tjdGp43Obbm3+sEDvFap8WsC9VJz8xXOzik0cyz6XDfQ3Zo14SnT
	UHx+WYATa7+idUfNTGYWVGDomJ90Ed4dCOG4NAvUv8h8Dcq9jTu91AgbJ4sHPtYl
	0n6P2U1qRXJc3rMlSQ1VMmxTiHol29ogJcRwzhlciaLfnFLSGmTsLrsEMALtYafT
	nTJUCrU/ZEW3qQNltk+eh2EUzb+YPONe6PpzAAApN8QTnmTg6qmBip3Zfq5eMa1h
	b5Vbw8WY3xve9XbS2T/BQ==
X-ME-Sender: <xms:uoq7afdTTO_ddVTEjL2XQz-WxrduWMIHVztvZtNkTmjB98Y0pN_sPg>
    <xme:uoq7aWvURJYj88YDehAKhaCaNPNjIMOvBNQzGO40mLGs7hzFzanTPATv6pvZOeDeR
    Xy1ZaLv9P0tLWKJym_KwIc9uGK7TVOmLvZkvaiQ1YA92yf-hTycpw>
X-ME-Received: <xmr:uoq7aYlQ4KPI6W26iMP8b1ha_y3-JUrnFCcqjrxmFbctDanRwBFFxHWDa9FqWMoZZrjoX7Q7FPzDGShMZJ9qfraIHg5vKAF4yfZifHPwdOXH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejffelleeftedvffegteeglefhteejudeuhffhveeivdfgjedvteelgeelhefgfeen
    ucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:uoq7aQy6JV_R_mjgWKWgjsHUZFw4uw_gcXBl1o-9VCbeQfZrK9UssA>
    <xmx:uoq7aSNHgKnIphiu-CWyd6NPuh8gXUSbUzgzHzucjV_EB90bGQG9jw>
    <xmx:uoq7aUr9PFHZIuZ6E3nswOLcqdYHe-6B7sd_MW7Wfea7I5E6aubQGQ>
    <xmx:uoq7aTGvg1eadAeKhuDsZzRNtCpOlexZRhJrDjCafpnqminOTmM9jw>
    <xmx:uoq7afBre9hugIYNfMcYS0sXSdgZ4YKwLzrewvvVP995bd8jFBWKN1NT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5b8971d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 06:33:27 +0100
Subject: [PATCH v3 8/8] meson: precompile "git-compat-util.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-8-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
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

