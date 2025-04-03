Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EC149E16
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656763; cv=none; b=TA2gSjnIANlQb12WEKUUksNeamCywqLvIDmSsB31fg+6xGYD0Ret2CAHiRbHBQ7up107Ftpj5B/p4TpwkwTLIxRIXdMncKvCRqK2r+ZdVssRa6fLgyhe7IVPSH8Z9RuhfPNefiA9Su64yeJdlcyyzxNsFiMKJPxcSmjtGhyHyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656763; c=relaxed/simple;
	bh=rMNNJAgwDNpH6Uluyz/6cwc19tUAVfHd/S5OeM2HSdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryNJ9QhN2WIXYslEyhX6pZRJjqyM4oQjmFVhG78RCVvY8VrB3gc7nEsXyDmke6FZBBhW5ScQW8RyJg29M3hlA1BEUBWQew8/w6R2r1nHgRrGEQrH1ynROxCx2xNZdLhpdUIZgfEgZhQwCxjgOpzIVrXvUtpR6yUjMjMw+2UH9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VRTpwqF2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dpdiq1gj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VRTpwqF2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dpdiq1gj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A6D911401A1;
	Thu,  3 Apr 2025 01:06:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Apr 2025 01:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656760;
	 x=1743743160; bh=TT0Q899adeQgSTJDHzedA3DaOpODUFO1iiGJNJ0sfC4=; b=
	VRTpwqF2kdEp0I1Dz5ckLgvxu3EoDlRI3l0cqAz8frCBgcLUTqyc9VO+GlJt/oBC
	3zGMp+agM4F+5KmKP6pM/1rkwYjEvDqJBQruCCKmEfBFqyYYUdEIl5AX1kFQTYnk
	zRDBQJofAn8voYVgkVnRYC3Rswh5lwVerYZH5KMpvhZhoisMmol22DYsHV+Fl0P4
	eCSmJqRDuGyBAatZMz6aOQBjdP7fI68aBegk2+OB3SEwBmjBDFiFUYcRkmGhWicp
	2xoXtfYGSTbHVxbZpGQJZqY8i1PnIra/jDGvuOV3YkE8qAl2C+Iv/o3VcLi/NTFP
	eoUm9hOiK3G347mbPUBnxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656760; x=
	1743743160; bh=TT0Q899adeQgSTJDHzedA3DaOpODUFO1iiGJNJ0sfC4=; b=D
	pdiq1gjPQMrkwtceMwksdLVPzHMxozZFM4n1wTSuPxi8C9lxe9En+WKjOSoGaZCH
	L4BaOnfFDc+YR0w3062aTPl3QSy0BDnzAvMD6GJsJkuh9cGAI6PQL3s7HYf8ioXK
	jAQ/GXFzNu3vpNIn7QX7Hv8B+XgvewB0836Hb+PkxJk0cM7YIJVObGcXMT39GQu2
	S0NTQLiILD507cFCRBW1kjVCY3G0kmxZy6e0jQCR1DYcyY2qZFmPRkRiwqf5mbBW
	jhbnGl9Ie9ukqI2rTnR8p2MpURTqn0iGitbMGfA0tZ82fKv4if1xWPhekzLQXRSa
	UYkZ/diL0fOnMfO/9Dt3A==
X-ME-Sender: <xms:OBfuZ-YI6_2BtDyyBTQR12O1WymHxQal2LrL0FAk3tW9nIApdmyH8Q>
    <xme:OBfuZxaKDzfFMIGXmYCqvwPZUr_ciiYujMLIpkgSR7BQwTRPxHc4cZSbgziDs3P0D
    rfNcygfuJQp_TsDDg>
X-ME-Received: <xmr:OBfuZ4_nVb-9dIO3d_u8un7PmaNjD4tgt4WTfLXoRQXJdDd-N3CffbvYV0xP-qsd1dJGCOBxNX2kfRpcFTYlEaBwIaIBmGynj9R9E_W-COGSpRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OBfuZwp-VWR2vSJSUe1GY24qNWUOunNlrEzjWIJhOibCdlF2wA5I6w>
    <xmx:OBfuZ5pqH6EQG0qdwx8eyfGHvd3lChXyAoVT-qNYO8_ccGz2M1yGGg>
    <xmx:OBfuZ-RbBSfPcNJW8UDbZqW0r0FPUY_6dJqg26b9VxZgs1q2BlqCfA>
    <xmx:OBfuZ5qJpE6oFDZcJGJJBnSNY3u-sWfystHu4SVRE7vNzFNKmCbtRQ>
    <xmx:OBfuZ8MbRTJoObdFxzfJ4Mv3R7CkLU_qkoKnQTXFt1P17CFJBwCvh7sm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:05:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f38c759 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:05:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:53 +0200
Subject: [PATCH v4 02/20] t: refactor environment sanitization to not use
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-2-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Before executing tests we first sanitize the environment. Part of the
sanitization is to unset a couple of environment variables that we know
will change the behaviour of Git. This is done with a small Perl script,
which has the consequence that having a Perl interpreter available is a
strict requirement for running our unit tests.

The logic itself isn't particularly involved: we simply unset every
environment variable whose key starts with 'GIT_', but then explicitly
allow a subset of these.

Refactor the logic to instead use sed(1) so that it becomes possible to
execute our tests without Perl.

Based-on-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1ce3b32fcac..a62699d6c79 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -499,24 +499,20 @@ EDITOR=:
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
-	my @env = keys %ENV;
-	my $ok = join("|", qw(
-		TRACE
-		DEBUG
-		TEST
-		.*_TEST
-		PROVE
-		VALGRIND
-		UNZIP
-		PERF_
-		CURL_VERBOSE
-		TRACE_CURL
-		BUILD_DIR
-	));
-	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
-	print join("\n", @vars);
-')
+unset VISUAL EMAIL LANGUAGE $(env | sed -n \
+	-e '/^GIT_TRACE/d' \
+	-e '/^GIT_DEBUG/d' \
+	-e '/^GIT_TEST/d' \
+	-e '/^GIT_.*_TEST/d' \
+	-e '/^GIT_PROVE/d' \
+	-e '/^GIT_VALGRIND/d' \
+	-e '/^GIT_UNZIP/d' \
+	-e '/^GIT_PERF_/d' \
+	-e '/^GIT_CURL_VERBOSE/d' \
+	-e '/^GIT_TRACE_CURL/d' \
+	-e '/^GIT_BUILD_DIR/d' \
+	-e 's/^\(GIT_[^=]*\)=.*/\1/p'
+)
 unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB

-- 
2.49.0.604.gff1f9ca942.dirty

