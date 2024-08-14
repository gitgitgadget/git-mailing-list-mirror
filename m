Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24B14037D
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618366; cv=none; b=kIRnvag2kk1ZohTtPUx0slboj/KIqAADU84z2pH0xfS4tKfhEimumJW6mLp9G256SWivgT3a513QXeDl1uTBwUl3Kr3xbKFLigdLDw1neU86LflJIFpShgBJbATFHEyNGWfsFnw+TF3P5tZMUTxyvGff4g/WMNj6HcVOhtP69rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618366; c=relaxed/simple;
	bh=yrlhgSdKEnDhi1HUwtx7k/dXX5LhZXH9LP34Q/lwjIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZM+9enJIXw+vziT9hh74NXLpKjlqYplZaJRtTiwVzD7WkVi6Ru1qLUgxXAhjXAsLxX2GsBky+T0NFk4MrFWGXrYUCrOgkWw+mEPTcZAsAwrELOMP2FFXJbwjfb2TtQZgLl3kOZjbOAWdFMZ9VB/SSGu+l5g5pZ64HhW+4x/uKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oh0/dU8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qLfUSqij; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oh0/dU8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qLfUSqij"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AE296115173A;
	Wed, 14 Aug 2024 02:52:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 02:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618364; x=1723704764; bh=vBXD9cXde1
	d+k0rRqwemqouzQf8J3Q5zX7ul7aMo7qM=; b=Oh0/dU8Vj/SHOu6/nhVvi7AS75
	LqDPm6k4+gPA/ZwMvdylHFDE0EmVbpNd4r0TJsRWVCaZYe6W67W46mnLDHn+pki4
	aprjwjMeFPz7NCQdJUad2j4+veQ8mqQEaI0qmEcWRW+GdpGkusEWnkCeKrNrRgXU
	ZWs1HPtkYrxjayoLSXzOyc4gKaeb2bjBNAGkf5QSS0wPS84RkeL6O7fmyjfJjWzt
	tXqqNuQ8o+SG6+YGV0eOPwXL4A/B1HuL4EeNI3CHumxbRJVM72X/YGK+7Ny3LlL/
	ZQwo+4v5JIQUXmrqOEgiBA39KAs3SwUeHyxsIB/pG4aiUroTuBV0AM0QDjCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618364; x=1723704764; bh=vBXD9cXde1d+k0rRqwemqouzQf8J
	3Q5zX7ul7aMo7qM=; b=qLfUSqijpjPHXB5J2AoXN0+ntLDbyB+vq9w/ZnJoDu0M
	sMlCUDwvv4W3c3ulAWOTqHd/J1HjLHPAhrdVrYHhYTJNaX1ClHPMf2lPN9N+mfU7
	74X9exFj+UrNdbIfldsoPxe8WQqTnshUcgT3BMQmccRlKPcC+iOXvvPq8HMU2wWA
	Mm2al4nAEUJksSZPyevgWxfSfQmnEY6eO4KdRPW+/HKhxtyUbOCGw8SSy2HtLiVP
	mPhPVJKl6pcBRemDSFVfGpVQ1ZUZpKUAjGy9TIIkNo70mfQ42EM2jWyO+kLjLrXo
	Zthjj5UbhawzEk+HBunaFz396bwv3AcAE21FoKDY2A==
X-ME-Sender: <xms:PFS8ZiVV64dCRkInBaMC8nUNqQAfK4KRfeVpaYnGH6qrBmjLc6P7vQ>
    <xme:PFS8ZumaxCmBFa8W15kE895_dNmnc3N4JigVPSx15hkwff0KSa8wz0S3JUryGad0N
    SV3kRlX0yFeLoLTrw>
X-ME-Received: <xmr:PFS8ZmajD0DMYbWz0_BOZIQoyOTOO5sv3ivIrfcsak_ie20uTC5eBrrycNkzibR7YNwhOXjTbYuRaQ27ngMh1Zs1lLCzJlJum484IWwuKSJ9rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PFS8ZpWiYa7T7P7-HcRw0VPgXw3cNGyCBKzsogBKrx5eD3fvNnwP9Q>
    <xmx:PFS8ZsnbQ0s8_qHOBTltRbbSMxN1ux5M5RdYFMpc19mTTbG2vqBqQw>
    <xmx:PFS8ZufGjW-EMrZ9GfP45wk37r7_Ll_jJygUACjdsjFdRdq7KD_eKA>
    <xmx:PFS8ZuHLogHY6VQwZq8vOUbEbFjCXdgdf1KsMumuSNL3PZEcb3KkYQ>
    <xmx:PFS8ZqZNnHmOS885gooAVVBrydNNXw1wZ-fRJ_v-cEQJvTslcT-jr84Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d08d3a29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:25 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 17/22] diff: fix leak when parsing invalid ignore regex
 option
Message-ID: <85f6ffd61099fd6194c8fa8491abfe01a9195298.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

When parsing invalid ignore regexes passed via the `-I` option we don't
free already-allocated memory, leading to a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                  | 6 +++++-
 t/t4013-diff-various.sh | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ebb7538e04..9251c47b72 100644
--- a/diff.c
+++ b/diff.c
@@ -5464,9 +5464,13 @@ static int diff_opt_ignore_regex(const struct option *opt,
 	regex_t *regex;
 
 	BUG_ON_OPT_NEG(unset);
+
 	regex = xmalloc(sizeof(*regex));
-	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
+	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE)) {
+		free(regex);
 		return error(_("invalid regex given to -I: '%s'"), arg);
+	}
+
 	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
 		   options->ignore_regex_alloc);
 	options->ignore_regex[options->ignore_regex_nr++] = regex;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3855d68dbc..87d248d034 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -8,6 +8,7 @@ test_description='Various diff formatting options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
-- 
2.46.0.46.g406f326d27.dirty

