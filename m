Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB639DBCA
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165177; cv=none; b=SSKBA2q/OU1y0tjYK88qR9v8Dt0iYf4f/hjTP2RdiUNjI5aq36Ge8H7Gx2Q1wTLSJdByjZHjbBX+pQQJn62ZMReiQ2w8sLC5x32oe+Il5Mc/WEWCn7ooIPaRVmZUw5m7d50S9JIZNRel/HERXa7iDViFbd/gvPXpaDSYgYD8MEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165177; c=relaxed/simple;
	bh=xnzGyIziWiTWNY/6I2RpCBpjqKfodc9MAM2vZPh6FmQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nTeTHIGADcMvimHM1UmK2mcOI2WEoSX8peIFJcMF1F5vybpKM5HcwsdJONZhcRXir/5leF7iNrerwpQ/VuuiTydV6h0Vegn6vQTAiFT2yd6Z6WF5vuq1t9dVacV/eazf+8X+CT6pLtfPe+0vA6CKjCct/9yF4hkdkfbFxldeOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aoHtvPaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1uQctAT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aoHtvPaW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1uQctAT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 24D5CEC0FCD
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:52:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 10 Mar 2026 13:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1773165175; x=1773251575; bh=PbgESy1jjA
	ujEtA+drKAjRlMzDVPO1lSeJNU3Y7hK78=; b=aoHtvPaW1/FEqHNb2jqJEVUOfH
	eHd0WvvHBQY7vlcfWzX3tAoga+oS2UMaXabvMsOZ40IhBNGM+KOHfcTNW+qiTLO+
	t1WcJIOge+vZgpj/u5019Q74EJu6oHOGBUTCo2Y25cE4IEqBJ/xmvsDNaA+WXzkN
	BVL/NdpDy4zG4cOUq5jesETyIenwTAYTmzaKnFDnvUsrjy+3PJeL1E5xygzskysu
	4FE3tYLugweysQ/pKJTA+5MMXFJiF8QNgDHM2J80acs3pI/+gZzzBxglHt2EHXmI
	Aunirg4xtRZlyfPcN/jtyGzeAdtxUGl77idnn+4A955XCHwq2JrVKPbf8W0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773165175; x=1773251575; bh=PbgESy1jjAujEtA+drKAjRlMzDVP
	O1lSeJNU3Y7hK78=; b=g1uQctATPEum0QXpsf8nd2vcLQxRKtmjZElbxqngz9HZ
	ORdM9KWeajo0x/aEnFjd3Znkr06VDJEHMQN3UIwCAY0m7CS4cpF+oLDMcc07Qg4y
	dpVnlS3GeYB13tUyWiuzN72eudh6sloXQiTgvMWQ8fRtZqv+jGNmah9rFiyXu3NC
	UJ/EjrsuCM8a2JMXw95PoH6+3HQMaDjDK4PSXTmD3BeLIpOaDHGVZp1WLrUqi7oe
	y9ua0JRWkn5NVho/B64BZZtjfH2TX93s1MhLqMIbwcu8HFvjGydjF5KALpFWCK2l
	VHgHgIbRXC3fuGu7P/qCFhCNQVmfRpq8+neSbIvk7A==
X-ME-Sender: <xms:d1qwad2dw3UtqD_kfC14zUfV9LYpddBxrZvNNhIPJJtn68fkcNJBQQ>
    <xme:d1qwabDZerjEUcpINdZQsGl5huJhTTkj5onQVnYOOyeBan6qAXr05yJwBWDvnmMQ_
    FMSE_sm90vHn2dOm52wRvm2aaEjAmqfXrtZJv20EWufRrM7P0lQVg>
X-ME-Received: <xmr:d1qwaTg7RbaIvBQr8x8DyksI8GnItT04k1At103X9RLp1envAfuCKnkPbXQjDR4cctZEZqXUCbe52tTlYPDpoQKFv0LWF6LizGUP59ql>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpefggfevffelleeuffefuedtjeeghfeuudfgheeuieefgfekveeihfeiveejffej
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmrghkrdguvghvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d1qwaf8HxF6mvDvvnsc7Xds3BgE7_kepeqsR9-JAlmviklWiLl9S1g>
    <xmx:d1qwaf9235oOxEto8rRe7zTZxSAMHiGekF3_cFYn1yAASZ-aMAMbcQ>
    <xmx:d1qwaYCxzUxNI2N_00goOh0hdsIcI_8L3Vcc_Q9qHuTgRGDvSkFhPw>
    <xmx:d1qwafycDDJHuZqyQ6jGv9L-LpBPrUspMZbObRn1aBd4uHzwySavSw>
    <xmx:d1qwaTFVVjmTX7z9Ms9f1-HYfZ5-RxOHiDThm5owvDw0GHrtk_ksf_4d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:52:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9556e72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:52:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] Some build system improvements
Date: Tue, 10 Mar 2026 18:52:33 +0100
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJasGkC/x3NQQqEMAxA0atI1gZqrS7mKoMLW6MGtZZkRgTx7
 haXb/P/BUrCpPApLhA6WHmPGVVZQJj7OBHykA3W2NbUxqF3mBZF/+d1QI6j9Mhbkv2gjeJPMQR
 nKhuaunUEuZKERj7fw7e77we6Iw9ycQAAAA==
X-Change-ID: 20260304-b4-pks-build-infra-improvements-cc4012c5364e
To: git@vger.kernel.org
Cc: 
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


---
base-commit: af2c8a61818d773325ef2324dd135786a03ebca0
change-id: 20260304-b4-pks-build-infra-improvements-cc4012c5364e

