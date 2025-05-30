Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6F22D782
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611920; cv=none; b=CgWd8RSJSdt6jIouJmmx9otKGfganVqk64IlD1/YE2BGFKxdYXubFy6RTb3JFhS8dyWtXdRBZJgoz/iefKkkZoR0HXHHyXmGcpwcuVACvxH6maflH+nEUnJz9c/61ljGOYj/VEJY49RO8qKrjwR/jf1NItoatbbBuk2zcZmTGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611920; c=relaxed/simple;
	bh=Wp+sD4vGNFHF4/t3MDU2TxvbK7XonR8wn2UuyHayKbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHj9RdgRnGj1rzWjTBGvWxZZ7RzXTZiIWdqVFgYICK52KLyjKv3sZlAEEM4d1JT2VyrhwTIHdXrhjVr4vGGHCusG+TUQ8IYvPO/3vVWaLxX1+MAFqpGAw/yssKj8NOYTMGYCNYfbwsvyeWAWdTIz3mv4RoUqOlRYc8Cob5P4ups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bsr91rpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnTBGWit; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bsr91rpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnTBGWit"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68E0C11400F1;
	Fri, 30 May 2025 09:31:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 May 2025 09:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611918;
	 x=1748698318; bh=fTHFGvQd+iAmd0T76khvECmZQf+97rbuC8mWSZU+HCI=; b=
	Bsr91rpXjBRokgXqm0ZtDufO8LNugwe7VQrXFO0fFCZlqsPk4M4dKRbk+8pat89K
	0RXdLO2ohdQHrt4vnowHiD1kZ+jQEhIFErByFiCjyl33gJYmISAT0wAjdUR4OH6F
	C9dCSrnuEmcORh2O3ET0hx7YOB9AuOyPjE54zXA427XDOlKvoEol1beXm4mAIUXD
	LQlpg0NwigXgYvZn5djT6XiwknJKk1YsJ6f9oTlG6jsj+qaCm2oG2bZAMjqVVnc6
	SL91NnGeVxJmLK2vOHBE3UoTkNZJBr9ks2bzNquTZzvR7ob+MyBcQ6aepZ99qKSc
	X0O+pgxGI5uAg/rKmMBDxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611918; x=
	1748698318; bh=fTHFGvQd+iAmd0T76khvECmZQf+97rbuC8mWSZU+HCI=; b=h
	nTBGWitFLDUA0xNQx/bvmJdmPMNmqf+33vLuWrt7P6piyCWen/g8u2A8i0cxGO4h
	qjKoqVlueMHROzef2blc7IilW8jPsnea8a8XRmM4S357PQ9Y0Yz44vlgt0RaJljo
	9FLz6yvOp3n+yuNoe0vEXY4WqcoFDAS4VvKH1nIrpnobV4K11vniRsJhkmrM8qYs
	IeapnGufGD6B05gNRk4FmPuvYRM9/uySvH+XcidoX0yr/r8Otqy1mp8XBBIQtlaz
	zgRlvCksn+wXj6Y0AnofWdKySQJvW9qtZOYh0ylV5KC+HfkqTtkzZj2ckgBRJ+Jb
	LpjNPk6cbO1RMsbD+/h+Q==
X-ME-Sender: <xms:TrM5aKqWS_E6Ary210kzPqjNubRaNAM7mm2cqVTkDWNxmnlhGSmXww>
    <xme:TrM5aIr-OT-jUwpMhWp_zrbMdUVs3DLcpt6ldWYcUvu3ZVwl3B1PG594Yl8CgEb6i
    VjFy2TMNwY0RUR0pw>
X-ME-Received: <xmr:TrM5aPO0-VDUOnPQfJkrWpdu4wPpu9Ofii8LNT0bj0H2me3q4Thdt0iZBPStggdRrZ-I-GoB5chZrvSeVqwjrnxaNeWntXS-TtCRCO_Lpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfefgvedtvedufedu
    tedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhs
    rgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TrM5aJ7Jy6FeWISiWzEJK5AXFXZ43V8vawTye5NTHRT1JaGd70fghA>
    <xmx:TrM5aJ6Q1BjIawcSeIjEDEYr8kqHFmVY7-MKnPMAByAEv-d5p54SJA>
    <xmx:TrM5aJgj_mL5Tn9W9EZpAkp2J8__fR6f5hwrvHGNF1ynOMktfHYyxQ>
    <xmx:TrM5aD5J7Yw0iFDUZUsOBb6TDhVM3Kjx2cZ8qJisMC4DOfBvOxFKvg>
    <xmx:TrM5aANUrJQ6Qklwu4eQfGD7A3zy79slDshjLh2MKKAv6zDYXWn2qopH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1efeee9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:48 +0200
Subject: [PATCH v3 10/10] meson: parse TAP output generated by our tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-10-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

By default, Meson only knows to pay respect to the exit code of tests to
judge whether or not it ran successfully. This can be changed though by
specifying the "protocol" parameter. Next to the default "exitcode"
protocol, Meson also supports the "tap" output that our tests already
know to generate.

Unfortunately, the "tap" protocol was incompatible with `meson test
--interactive` and caused a hang. We have upstreamed a fix [1] though,
so with the recent release of Meson 1.8 that fix is finally out and we
can start using the "tap" protocol when running with a recent-enough
version of this build tool.

With this change in place, Meson now properly detects how many subtests
ran and whether test suites have been skipped:

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

Note that when running `meson test --interactive` the test results will
now be marked as "ignored". This is because in interactive mode the file
descriptors will remain connected to the user's terminal, and it is
expected that the user interacts with the tests (e.g., spawn a debugger
or use `test_pause`). As such, the TAP output cannot be parsed reliably
by Meson in that case, so the tests are marked as ignored accordingly.

[1]: https://github.com/mesonbuild/meson/pull/13980

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 6fb898a21d1..46c5d068e05 100644
--- a/meson.build
+++ b/meson.build
@@ -2040,6 +2040,14 @@ if get_option('tests')
     'timeout': 0,
   }
 
+  # The TAP protocol was already understood by previous versions of Meson, but
+  # it was incompatible with the `meson test --interactive` flag.
+  if meson.version().version_compare('>=1.8.0')
+    test_kwargs += {
+      'protocol': 'tap',
+    }
+  endif
+
   subdir('t')
 endif
 

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty

