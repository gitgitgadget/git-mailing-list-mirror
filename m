Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840C193072
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528647; cv=none; b=QaSuzJldevB2tzqoNWrjEtWavHp/sEoOAdEGym2pUMFaTWD4TpXuni0qa5b1Ha16XNni4eosAD471kbmPmhl7baM8sNXyxJE/o8RHX2QkgqxQ6+jc+5PIyxJgDhh7hVbLWagERrOBAoyb6LkO48uptTnNVSVOstNyP3xZf3HSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528647; c=relaxed/simple;
	bh=O5uJE40NHsbuE5A2DrjTgewn37QO65BGWEyLaUUHfck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLkc/eeC2NteCpXb367JW+XcBY7QfWAecDofOqdSK1VmRfSBiBSstM/ThSBtE2d8vRSzuDBKL6juxPcQVET/kIPJXJ5NvpKy3x8sQ3LEk/iUG01Wa43Ev/s/6eTIJfBFx2IYMubNY2CQif2wizSiYIZc7ifMqZdlgOq9veWikKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qwSZhCRJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4tYREAt/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qwSZhCRJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4tYREAt/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C04F254012D;
	Mon, 25 Nov 2024 04:57:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 25 Nov 2024 04:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528643;
	 x=1732615043; bh=u8G3UxIBTSkHDKjk6cwa520u5DnuEAQ1W3bY8wpQm/0=; b=
	qwSZhCRJgnZwYoTuwz8Gakzp361vqrQuQFupjb6nSBJu+zysLaa10vGveR8FWxKq
	IssQVq8dsJf3OOexDSrtMhelSVuYDH4ZGQ3E7kbD25j5tsv5+aWvwXb6yj8OqZHX
	z5AVYdJhQHiqWVlNNFjxWI0PCe3qETJxZsju7Hc6p3nrWqfeO5Mw7Mb7P33qJNEv
	9gwXa5dd852iUfWwK6zTbKx5tP8mEmctwtikuf7xAFTAYH/YFCa8+WuSD7ABmZKl
	BuWKDMFTEK+nRH/oy9aMRlf39KAuBjUXYYFjTsAtJuHdx5qYsF72Khzcril6pjkC
	Enk7vw7xS73wwXzA5B7ZdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528643; x=
	1732615043; bh=u8G3UxIBTSkHDKjk6cwa520u5DnuEAQ1W3bY8wpQm/0=; b=4
	tYREAt/duaAMC/79IkW1hw3m11/2/xkMzhIbr41EDujEtcZVv1/Wsrc4DheNVDXc
	afqWohC4Klz0tN4IP4V9zctm/bXwcuqvibkJPdQR1AtvJLGxuxI4ZsFgAw8jz+IY
	ExmD8aT78mtGgYSBscU0EeOvQtrAsddg0Is7XsGgeJ/gfjY8NS+DZ+lrughmce/L
	I2AVMcQYt6m3WgyzOPwI+bDCc7XdE1sJsDaF6JWj7WamUN4AC6Qb75JvQSfmM61w
	InMORF8l0y7JnAOhwq5BRzd75IbhEfaP3OpJiLrH+fonph1aEpNdR1xxSgJVdd4c
	EJzUkjG8bNwO4JCiCJJBg==
X-ME-Sender: <xms:A0pEZ0itZADraCVG_pOztNvDw2EYv-t4GNUO6EoM01E1lxfm3urVew>
    <xme:A0pEZ9CT4hRtISDkmJmY78JzB6eB0LvX3FfNNEIQUc56otgw88xCwrdFOhACzIWye
    v_ZVAbFH2Zttsf85g>
X-ME-Received: <xmr:A0pEZ8EnZhASOb-gEQ2s00iQ-H-Z_qE57HxkJdL9uLb-yLLpv0l5jHmTtSH2oi6Ik74s3ljXVPnAy2ThMaH_X4sXAYH4ygXEaSL8KfvZo4LuKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrg
    hmihhlhidrohhrgh
X-ME-Proxy: <xmx:A0pEZ1S_BQyzz1MjIDWt8UIhJxSCZjHQcw4y2LFUPI9WQxTgGdaDGQ>
    <xmx:A0pEZxyzC77whpHGNSXfvXv7O8Fzm-iSXYgqCblRsgWT39fMQA5XqA>
    <xmx:A0pEZz4HnVQ3cUTq7h7k1YIqe9GApdZEMcM6wcM-4E8s4hg5Jr51ig>
    <xmx:A0pEZ-xaI_-l8KE2i0lE8Zj3xB_907aLCi2wJeOqi92xKuIHPEYhEQ>
    <xmx:A0pEZ35lm3zYax8DDCeM5lPvZjtHbWdwysm0aDdstuMVfrnogDJ0Hk6Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e21a76a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:00 +0100
Subject: [PATCH v9 12/23] Makefile: extract script to generate gitweb.js
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-12-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Similar to the preceding commit, also extract the script to generate the
"gitweb.js" file. While the logic itself is trivial, it helps us avoid
duplication of logic across build systems and ensures that the build
systems will remain in sync with each other in case the logic ever needs
to change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitweb/Makefile              |  3 ++-
 gitweb/generate-gitweb-js.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 16a2ef2d1e5664d99f6f1d8ff4224c36769c55fb..d5748e93594eb6181269c2fe272bf7ef980cbe68 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -115,9 +115,10 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 	$(MAK_DIR_GITWEB)generate-gitweb-cgi.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS ./GIT-VERSION-FILE $< $@+ && \
 	mv $@+ $@
 
+$(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	cat $^ >$@+ && \
+	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
 	mv $@+ $@
 
 ### Installation rules
diff --git a/gitweb/generate-gitweb-js.sh b/gitweb/generate-gitweb-js.sh
new file mode 100755
index 0000000000000000000000000000000000000000..01bb22b04b8d8910608fec6376f07d570ab02a33
--- /dev/null
+++ b/gitweb/generate-gitweb-js.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+if test "$#" -lt 2
+then
+	echo >&2 "USAGE: $0 <OUTPUT> <INPUT>..."
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+cat "$@" >"$OUTPUT"

-- 
2.47.0.274.g962d0b743d.dirty

