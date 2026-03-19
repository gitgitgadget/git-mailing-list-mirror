Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75C1CEADB
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898410; cv=none; b=NAmHZWkTg9livzQmb4wdn5SgPRO2S0VNd2eIq+FDlF7B4guACwmEwNNJE7JKmLX1arnzgRf7JAK8uVcocArDa6rFAYr2I1+ImAS6jKoWZ6i3s3T6V4vjEwc/FGEVxBDF0gV2uXQbb+GOo8Lti7sZwPCxtqtqixerAC8qlFNa1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898410; c=relaxed/simple;
	bh=pUoVktBOIqOCIh5GomkaQc+vLjYJMX/ZsuxHMBZN3RE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=OYxVvZmeMLWIr8lEkn97DI0156M9FC3j4Q3nvE1zJEQ0ArvU9xdoyJ/a6ib/fuqXCc6msfkvkrKEI9+z59nyTSQCk9ceDktuH1NDVSVKGkThuKu7ZRhHKoKMkciVLnNVAA2xmK6a9LMRgFIiLGENR+GrM6YwpLHQyIClk3kmyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nfe8XkA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5MvfMLke; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nfe8XkA+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5MvfMLke"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 92A5AEC0210;
	Thu, 19 Mar 2026 01:33:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 01:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898407;
	 x=1773984807; bh=9wm0s41TAEO+oZY31S/Pcw58yfQBYoVYcgR5aNv8IiI=; b=
	Nfe8XkA+ybL+DdqrB1j/pB+xa0JQYdDSLQtoF4dYtbRnd04BEGVEAykCTei/BzKW
	LxEOCECvpXMM9yQUMAF9dgNsFJG3ULUcX6C6LyomX34rF9ysj9eLmtXqkUwj8tTW
	s9M85JVdVV59j192RBtW1+XX7053k2Fnv0dvg7DSK19VXzVhtckxAsP8tBUEsj2X
	zbi7MeYyvOrqJI7uRbt6h3GsvjGVWlFJdZfz9U8yVJuKYgFlD/kgtg/Cp2HGcAvT
	oG3SiOMEWsDHIgNkWIUVBmxDN3xMLTEIwAOZBcwGCHzB1PSX/EcsA1Lu6EIPfumk
	wy2PSfRAqNLLGNLE34i18w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898407; x=
	1773984807; bh=9wm0s41TAEO+oZY31S/Pcw58yfQBYoVYcgR5aNv8IiI=; b=5
	MvfMLkeMf9750qMvlTOI/Alr3vRizDuik8C5hLpGIQPzXX+YwYIG7/VNoYXvSNXD
	WKcie9uX0HyXy7ZiJmkzGPE7qxXX9jpOiYgwd9gmLoHYYwhteauSuep9+RuR3KvI
	kU5VVBYyeN8bZTP9cste6mrPgyW6cCgoxe0xh1yu1wRrs5pgqXya5SjimTlaevea
	1kap/lMAe5g9C22yOgVmsY1nqVZ393z4Jm6gPL8ckTqWt3NTHv3nPtJfUp2t/e+R
	rj8bYiWKTlfpmY9hbbafmQ56HpXqNqwfEWF804dRxuGTi1y0ZSAJWH3WrriFbvX/
	iJRuccnRYqy57fHzbbaeg==
X-ME-Sender: <xms:poq7aVeB0OjYafSv7VAWzfdz-vMblYVPw4ECuppWaIVlfG-XFoUQyA>
    <xme:poq7aUtm0Kije575BJoEUM5XV4OiAAiD9KoqVrnQJgFXcDRLQ9bwCJMAGSP9Jt8oS
    Ri_GYNZdFAKiHCI5kma_DomvZhacUlpcNb8ANcQCqpZTmqzRyUNaQ>
X-ME-Received: <xmr:poq7aems3KibdLcOp9GGBXbStRR4IZX1KeuQJ07mAfRSf1ay9vql2KkQpjAaeMMVbLzKncbb5CraDtb65qsxrDhWIxcTxU-2YlO5u1Ruy9ie>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgeetheejveduleefkeelvdelgeehudetgedtuddvhfekgeevvdekvdettddvuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmrghkrdguvghvnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    shiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:poq7aexOF6Ic_EB5YuQDb1VhWSXv-mfI2XD09R9-OfB5V4Z-tfsPvw>
    <xmx:poq7aYPqnbQTWJxbFHYdyGnuPOFa8nFQgYGCTRGe7cNWCGEF_Fyeeg>
    <xmx:poq7aSrNI4rhjJrM416j8d_BYbfRdWB1M-zKq3fIUvT3Oe6_pl2h7A>
    <xmx:poq7aZFxDdNiGxedqU18whhV1hA0Z-QAmuPCFbEewB-zKQTxHzAmwg>
    <xmx:p4q7adA-vq9DEk41XKctSdRNI-7zlRPRDKfI7l7jGtLKFcS0AbdvQpzb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9efc0d20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] Some build system improvements
Date: Thu, 19 Mar 2026 06:33:19 +0100
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+Ku2kC/4XNTQ6CMBCG4auQrh0zLaUkrryHcQHtIBPlJy02G
 sLdLcQYdyzfyeT5ZhHIMwVxymbhKXLgoU+RHzJh26q/EbBLLRQqgzlqqDWM9wD1kx8OuG98Bdy
 NfojUUT8FsFajVLbIjSaRlNFTw69t4XJN3XKYBv/eBqNcr19b4q4dJSCQLQuHpURnqnN6P3InV
 jiqf8zsYyphulZWWbSoVfHDlmX5AGRGi2YYAQAA
X-Change-ID: 20260304-b4-pks-build-infra-improvements-cc4012c5364e
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

Hi,

this patch series contains a small set of build system improvements:

  - The first couple patches introduce a new "tools/" directory that
    contains items related to our build infrastructure and to our
    developer tooling. This finally follows up on my promise to do this
    back when I did the spring clean of "contrib/". [1]

  - The last couple patches introduce precompiled headers into Meson for
    a nice compilation speedup of ~30%. It's 

The two topics are not really related with one another other than being
related to build systems. I decided to throw them in the same patch
series though so that I can introduce "precompiled.h" in "tools/".

Changes in v3:
  - Improve commit message.
  - Link to v2: https://lore.kernel.org/r/20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im

Changes in v2:
  - Turn array of precompiled headers into a simple string.
  - Point out in the commit message that the precompiled header is
    included implicitly.
  - Link to v1: https://lore.kernel.org/r/20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im

Thanks!

Patrick

[1]: https://lore.kernel.org/git/20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im/

---
Patrick Steinhardt (8):
      Introduce new "tools/" directory
      contrib: move "coccinelle/" directory into "tools/"
      contrib: move "coverage-diff.sh" script into "tools/"
      contrib: move "update-unicode.sh" script into "tools/"
      builds: move build scripts into "tools/"
      git-compat-util.h: move warning infra to prepare for PCHs
      meson: compile compatibility sources separately
      meson: precompile "git-compat-util.h"

 Makefile                                           | 76 ++++++++---------
 ci/run-static-analysis.sh                          |  2 +-
 config.mak.dev                                     |  2 +-
 contrib/buildsystems/CMakeLists.txt                | 18 ++--
 contrib/meson.build                                |  1 -
 contrib/subtree/meson.build                        |  2 +-
 git-compat-util.h                                  |  8 +-
 meson.build                                        | 96 +++++++++++++---------
 tools/README.md                                    |  7 ++
 check-builtins.sh => tools/check-builtins.sh       |  0
 {contrib => tools}/coccinelle/.gitignore           |  0
 {contrib => tools}/coccinelle/README               |  2 +-
 {contrib => tools}/coccinelle/array.cocci          |  0
 {contrib => tools}/coccinelle/commit.cocci         |  0
 .../coccinelle/config_fn_ctx.pending.cocci         |  0
 {contrib => tools}/coccinelle/equals-null.cocci    |  0
 {contrib => tools}/coccinelle/flex_alloc.cocci     |  0
 {contrib => tools}/coccinelle/free.cocci           |  0
 .../coccinelle/git_config_number.cocci             |  0
 {contrib => tools}/coccinelle/hashmap.cocci        |  0
 .../coccinelle/index-compatibility.cocci           |  0
 {contrib => tools}/coccinelle/meson.build          |  0
 {contrib => tools}/coccinelle/object_id.cocci      |  0
 {contrib => tools}/coccinelle/preincr.cocci        |  0
 {contrib => tools}/coccinelle/qsort.cocci          |  0
 {contrib => tools}/coccinelle/refs.cocci           |  0
 {contrib => tools}/coccinelle/spatchcache          |  6 +-
 {contrib => tools}/coccinelle/strbuf.cocci         |  0
 {contrib => tools}/coccinelle/swap.cocci           |  0
 {contrib => tools}/coccinelle/tests/free.c         |  0
 {contrib => tools}/coccinelle/tests/free.res       |  0
 {contrib => tools}/coccinelle/the_repository.cocci |  0
 {contrib => tools}/coccinelle/xcalloc.cocci        |  0
 {contrib => tools}/coccinelle/xopen.cocci          |  0
 .../coccinelle/xstrdup_or_null.cocci               |  0
 {contrib => tools}/coccinelle/xstrncmpz.cocci      |  0
 {contrib => tools}/coverage-diff.sh                |  0
 detect-compiler => tools/detect-compiler           |  0
 generate-cmdlist.sh => tools/generate-cmdlist.sh   |  0
 .../generate-configlist.sh                         |  0
 generate-hooklist.sh => tools/generate-hooklist.sh |  0
 generate-perl.sh => tools/generate-perl.sh         |  0
 generate-python.sh => tools/generate-python.sh     |  0
 generate-script.sh => tools/generate-script.sh     |  0
 tools/meson.build                                  |  1 +
 tools/precompiled.h                                |  1 +
 {contrib => tools}/update-unicode/.gitignore       |  0
 {contrib => tools}/update-unicode/README           |  0
 .../update-unicode/update_unicode.sh               |  0
 49 files changed, 123 insertions(+), 99 deletions(-)

Range-diff versus v2:

1:  051b66376f = 1:  bc18fe2f2d Introduce new "tools/" directory
2:  275a96c805 = 2:  393b42f433 contrib: move "coccinelle/" directory into "tools/"
3:  afc5a1f8b9 = 3:  00284934e9 contrib: move "coverage-diff.sh" script into "tools/"
4:  909d996f56 = 4:  9dceec07dd contrib: move "update-unicode.sh" script into "tools/"
5:  6396ae723e = 5:  af0ce83627 builds: move build scripts into "tools/"
6:  16b0e9f4fb = 6:  8cb7ea8245 git-compat-util.h: move warning infra to prepare for PCHs
7:  b4cd150fdf ! 7:  495335a97a meson: compile compatibility sources separately
    @@ Commit message
     
         This is okay for our "normal" library sources and our builtins. But some
         of our compatibility sources do not include the header on purpose, and
    -    doing so would cause compileir errors.
    +    doing so would cause compilation errors.
     
         Prepare for this change by splitting out compatibility sources into
    -    their static library. Like this we can selectively enable precompiled
    +    their static library. Like this, we can selectively enable precompiled
         headers for the library sources.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
8:  5899e0318b = 8:  6923592b62 meson: precompile "git-compat-util.h"

---
base-commit: af2c8a61818d773325ef2324dd135786a03ebca0
change-id: 20260304-b4-pks-build-infra-improvements-cc4012c5364e

