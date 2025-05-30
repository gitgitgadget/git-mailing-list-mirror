Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5E2905
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611913; cv=none; b=Fs6JWzFZ7ejJ15J+plbgi7AVGL6rOEZoM0sXimXQ+8Kuw2NSdV8odHIEv/oMV0LsOWoDDISuJF5wr+aDBj8Y7xCF8aJRsvQzqbd9O8l1YI/E1Jv2gWxuyv2FKdhjzfTmK8KneH6wRZooUBb7LKd59i+PJJTxlrQSR0JTPuWYDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611913; c=relaxed/simple;
	bh=fy7pEocMbfkInyKxIH8yDnaQALWHjLXs3i+vX8Yz18o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Cz33lVDNUXm1Nqo1okZxphOT20liiRb+a5Mm3//dIiEQ+vE1VwSD0yCqdzLqsLHQJyWFUUdSHJ7o88NTuE4tmbbGpAwY1aYRoajuSG83yFKEukBKbiwKyvR/WvUux15FonOTmls2IyQa63lv/Qqdu33g32cwOJRSvBTeJp6fQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FdvXivkx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=agXBXiMd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FdvXivkx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agXBXiMd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 25942138026B;
	Fri, 30 May 2025 09:31:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 May 2025 09:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611910;
	 x=1748698310; bh=bI8RFpFokjRoTHWe63MMRJh9XNT2iOqUnf8ESeZ+HTU=; b=
	FdvXivkxGzHbDDbOv0Bo7V6xpbr44OIRCmhwEQEnaqvgNnqjT0XPDtGe8ljDm4xg
	eqqoNxeoxPeVcmYn2MmLn0jnAxRv0K6ihYXYkAUhDcbr4L5EJ87K+8hLgO9VN3wv
	DUpDJzTYBN+FuAbZchJcBFDF5CF7nOJz4xb4VnVmVZuT33oClXonyEc703cy/4F2
	51eOY4cKRRHDebRPvuMgG4xFViVjMbnTRPY1rNZv7MVVBqdOSPEDtmXJ79U6RUkr
	qEBjq4uVdkATTTQ/H9MpX7GT4t6eHJH8ACg11YiJbo8MhRC5oHWPtilU4b3CMxpb
	tYUOhDMVxogLDMcT1xov/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611910; x=
	1748698310; bh=bI8RFpFokjRoTHWe63MMRJh9XNT2iOqUnf8ESeZ+HTU=; b=a
	gXBXiMdB2Hp95Pkr67f8h6SLGEc9UeaWghd0BpkQzB9vBGYftnmzIVLPXFDOsGGg
	v+mn9MS4LmjKvmEe5oeRaEDOYrapAnXWn268BUepdTjZM1+sCqTynUEsTvXBH9WS
	eIlk98s+JH1vQUsG6rk/+EW7tYQFH5KuDTAtvoJhiWdtrAwuGkGsfM1vWPFjnloE
	WlO7MiF61AysFH3mdjfQ8Yl0xMqzsZFpv1mZdtqh9hws39w/dIbxkQcHxa8b/0uC
	TeYVLhNn683kJlKPTFyQHlMM8EDJne5tZp5mghaZJwFGzSwaBj1e6RcMILbvuRSh
	SM/i2w3SpFZT4SOEUhPHw==
X-ME-Sender: <xms:RbM5aO__OIYnrRYoaUqSB1ym6GFhJAkTKJKPXh5Jr77G5QQyT37JrQ>
    <xme:RbM5aOvOf9YMe80F_Tb1ohOmrMkogOvxQfOIxVSbPyc2WuNOkHeST0zlx71QqgFof
    MKdT-C-RbAq5FtJWQ>
X-ME-Received: <xmr:RbM5aECUVqqesyALUDhwee0uU2rgbTsRVu-E2RdmdxJB6LHJgn6dKbOtaGE-E1MTi1Noix4PI7Q1771CQlUoE6zUt1kr8Rcn3vclPZ5L6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfg
    jghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdeivdekjeekkeeu
    ffdttdehudeutddtjeehffdvfedtleffgefftdejteegfefhnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoh
    epkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhiise
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RbM5aGcL8r_v1BrKMEJnQnTGffC-ohZ5RC9W9QmT5dgo_ZhktMgipg>
    <xmx:RbM5aDMphUGnWNRpQ1Yh1sO920VOIXoXNpfpZv0E4eQIoONS1wJgvA>
    <xmx:RbM5aAn5oD7-RaP2j0DQcSzmMSRG6-5wyeYZ6qaNS27s9y1IUBESrw>
    <xmx:RbM5aFuwMR99g4OdBor0jJQjKkll9cGl_YK9VlgdkM-jKc4r95yzTg>
    <xmx:RrM5aAhMg3yQF8LmcUxz3rvsfPx0wWL-Qir9RPegbLGUPVZ7TdhoorMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4437850 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] meson: parse TAP output generated by our tests
Date: Fri, 30 May 2025 15:31:38 +0200
Message-Id: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuzOWgC/12MQQ6CMBBFr0K6tmYYSiuuvIdxMcIgjYGSljQaw
 t0tmBjD8v2f92YR2FsO4pzNwnO0wbohQXHIRN3R8GBpm8QCAUtQWMnxGWTPwQ1yolHmzI0GRYB
 UiOSMnlv72nrXW+LOhsn595aP+bp+SyXoXSnmEmRJRHesFJKqL+k/2l6smYh/Kpq9ikklLjS0x
 piT5p+6LMsH7ceZJuIAAAA=
X-Change-ID: 20250429-pks-meson-tap-1eed604a02a3
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Hi,

this patch series starts to parse TAP output generated by our tests when
executing them via Meson. This has the benefit that Meson starts to
understand skipped tests and reports how many subtests have been
executed:

    ```
    $ meson test t002*
    ninja: Entering directory `/home/pks/Development/git/build'
     1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
     2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
     3/10 t0029-core-unsetenvvars             SKIP            0.15s
     4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
     5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
     6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
     7/10 t0020-crlf                          OK              0.81s   36 subtests passed
     8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
     9/10 t0021-conversion                    OK              3.45s   38 subtests passed
    10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
    
    Ok:                9
    Fail:              0
    Skipped:           1
    ```

This new feature is only enabled with Meson 1.8 and newer, which
contains a bugfix that we have upstreamed [1] to make the TAP parser
work in `meson test --interactive` mode.

Despite the changes to Meson itself, this patch series also contains a
couple of fixes for our test suite that caused us to not generate proper
TAP output.

Changes in v2:
  - Add a patch to fix an unexpectedly passing test on macOS.
  - A couple more fixes for broken TAP output.
  - Link to v1: https://lore.kernel.org/r/20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im

Changes in v3:
  - Split up the patch that silences output into multiple patches and
    rework them a bit.
  - Remove redirect that was retained by accident from an earlier
    version.
  - Slight rewording of a commit message.
  - Treat unexpected passes as failure in prove(1) and when executing
    the test directly.
  - Link to v2: https://lore.kernel.org/r/20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im

Thanks!

Patrick

[1]: https://github.com/mesonbuild/meson/pull/13980

---
Patrick Steinhardt (10):
      t: stop announcing prereqs
      t: silence output from `test_create_repo()`
      t9822: use prereq to check for ISO-8859-1 support
      t983*: use prereq to check for Python-specific git-b4(1) support
      t/test-lib: don't print shell traces to stdout
      t/test-lib: fix TAP format for BASH_XTRACEFD warning
      t7815: fix unexpectedly passing test on macOS
      test-lib: fail on unexpectedly passing tests
      meson: introduce kwargs variable for tests
      meson: parse TAP output generated by our tests

 contrib/credential/netrc/meson.build         |  2 +-
 contrib/subtree/meson.build                  |  2 +-
 meson.build                                  | 12 +++++++++
 t/meson.build                                |  6 ++---
 t/t0000-basic.sh                             | 39 +++++++++++++++-------------
 t/t0050-filesystem.sh                        | 30 +++++----------------
 t/t1007-hash-object.sh                       |  2 +-
 t/t3600-rm.sh                                |  5 ----
 t/t4000-diff-format.sh                       |  2 +-
 t/t4041-diff-submodule-option.sh             | 22 +++++++++-------
 t/t4060-diff-submodule-option-diff-format.sh |  9 ++++---
 t/t7401-submodule-summary.sh                 | 18 ++++++++-----
 t/t7815-grep-binary.sh                       |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh       | 16 +++++-------
 t/t9822-git-p4-path-encoding.sh              | 13 +++++++---
 t/t9835-git-p4-metadata-encoding-python2.sh  | 24 +++++++++--------
 t/t9836-git-p4-metadata-encoding-python3.sh  | 24 +++++++++--------
 t/t9903-bash-prompt.sh                       |  4 ---
 t/test-lib.sh                                | 18 ++++++++++---
 19 files changed, 133 insertions(+), 117 deletions(-)

Range-diff versus v2:

 1:  b5ae3aba1ad <  -:  ----------- t: fix cases where output breaks TAP format
 -:  ----------- >  1:  15702b96125 t: stop announcing prereqs
 -:  ----------- >  2:  444a5e8a72f t: silence output from `test_create_repo()`
 -:  ----------- >  3:  dd24e16f93c t9822: use prereq to check for ISO-8859-1 support
 -:  ----------- >  4:  5ea96164181 t983*: use prereq to check for Python-specific git-b4(1) support
 2:  69d4b420eb9 =  5:  783cf673a22 t/test-lib: don't print shell traces to stdout
 3:  ec921bbb183 =  6:  726795c9a11 t/test-lib: fix TAP format for BASH_XTRACEFD warning
 4:  e463fb29a8a =  7:  df1be586474 t7815: fix unexpectedly passing test on macOS
 -:  ----------- >  8:  e0b06f9ffcb test-lib: fail on unexpectedly passing tests
 5:  58173827436 =  9:  0f34503b28b meson: introduce kwargs variable for tests
 6:  1242bbf74f3 = 10:  d28b9306b46 meson: parse TAP output generated by our tests

---
base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
change-id: 20250429-pks-meson-tap-1eed604a02a3

