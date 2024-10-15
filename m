Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AA1D0492
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992715; cv=none; b=RUK0zMGfhnv2yknJdv41EFz3hY7GGwMllUn+kOItI2buX4HbNBgaFRVaIS5m49cCiHDjcK4bCtAyy7rWDw10j4/Zcb8me91/WTsGkJAmMtfJFOysdDRtYgHJWBS19aCS6jjB4c6sQg8i/nM8ZvsgadU5BiERa1g2XHldiNDW8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992715; c=relaxed/simple;
	bh=hLfCNLvMOBb89LEU+TtRPa8R3ybKDgxyUzmGaWU4zOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgdmsH1A0NKI0M5Y66/2QFuX8sAdClyFEUDXYVh3406kz1FJk6q/7cWlDZ8z5IfyMsZDVsdVs6NlzZqgku38Jr+dPv5TLIiMiF+oOl9GvrATNnC7/h2a5bfGrMmvrSjhK/5tPssFpx4wYgcawoL5XaDeJ74a7QGkALiYaqzpv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EXfj8jjy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZximdTMh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EXfj8jjy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZximdTMh"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 6257611400B9;
	Tue, 15 Oct 2024 07:45:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 15 Oct 2024 07:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992712; x=1729079112; bh=hjj7S20kZJ
	rEZVr3DWHwGsMz2ZsAl66LRT0d7/enBGI=; b=EXfj8jjyJK1Tenfs4qbH477PU+
	zJxWR3pAespHlXFXi0Ff7WDe2ifv+TDhXqtNncuFyeI47KATXDqWAcqZSYZG2ux5
	aL1SaLkEHkwJhUfkITAAB/HF7jkFhnjvZtabZmXdzwmCGJ0U5RcS957e3GLWKYzR
	ANOmy4RxqMD476F4NSWroKzL083gN817Jdd3xffDygUAQZvoLs4afB7hNf1DVfSy
	u5RRNCqq9FpgQWg0EhtRStvNfHylriYGxdVAoE31JtENBL+91e1C5IUXAZ9bfapK
	cVj40lhBbHUqwLeeYNKB4zHt2Sl3uMcs7Aqw800JTn6lhr1DymFCe6/NW0Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992712; x=1729079112; bh=hjj7S20kZJrEZVr3DWHwGsMz2ZsA
	l66LRT0d7/enBGI=; b=ZximdTMhaoxNYI6yP5RsefTSavX5wnwjWhzEQj+3BqEd
	Hqq0uz5NVGrQxBGLD74KGE5aEYLQcIIPBJ5dBdFUvB3yewwUVugL20qU+2Ab+tsW
	mFYars3Re1Y4HO8KiMulxU+403j8YwTeJO9ceMSPu9mDe4HmC6JwNrVZcspsbQVs
	gZyI6dfFsIc0HokeeRMf5cEeOJ4C9lEtL9Juig0qIyn28BHKOiyZtuH3qYiGG/lR
	WFBQFOQ+A8UUUPH7CGrtpqharZ4EHSsu0ch2myPJkQcKc144dG56nvGKBhAKvVK+
	9b7rHKds+TXLO9bEzGzVXV5/syCu+VWl/n5Oa044Aw==
X-ME-Sender: <xms:yFUOZ7Zcl5sfFQowh30oHEaLUCLJtFeGD5P-f3O1kxoFittkXuZTlA>
    <xme:yFUOZ6YZfNBTso4_2Rkp8EhynbbQJnJY1OgLUWzxVW6yEoD6_WRKi4mUiCKojsJI2
    KA0eJqxAMIJ7zfUrA>
X-ME-Received: <xmr:yFUOZ99nStRMcHskNfENmZtKjAYtzm2vjqHLKip3MO2siWJq_MbeDdCdquqR3EX5EQ1lBX4OZ07Dq0UlgT3-XHyA72CLRTSLaELs46wczsZAeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yFUOZxoAeKXSAj5XzCvwxxqHThRwBnuOed5eLIoGshG4q-acR5HrSA>
    <xmx:yFUOZ2orayTFzLNxa1J9Z_iKXywWHSk9wlFTpyn76w0XGO5ac8RV3w>
    <xmx:yFUOZ3RUQT1yXTgcyYMc7htZRgZ5mfLh9zw9t9d4CjVchGC9e2wMIA>
    <xmx:yFUOZ-q-PqzT8RNODcuYGUm57S3rzG5gqmqlbMbRvJQh_JPdhhGKgw>
    <xmx:yFUOZ5VUTJ-tW5AXgwhn2XsDbSeYW6Ax0P6bSGBjhQw6_ADRWvlXiDpB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26a1e6ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:43:56 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/10] t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
Message-ID: <a514f5d14a7263750f1fa4bcc04e3daf2901c3eb.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728992306.git.ps@pks.im>

When assembling our LSAN_OPTIONS that configure the leak sanitizer we
end up prepending the string with various different colon-separated
options via calls to `prepend_var`. One of the settings we add is the
path where the sanitizer should store logs, which can be an arbitrary
filesystem path.

Naturally, filesystem paths may contain whitespace characters. And while
it does seem as if we were quoting the value, we use escaped quotes and
consequently split up the value if it does contain spaces. This leads to
the following error in t0000 when having a value with whitespaces:

    .../t/test-lib.sh: eval: line 64: unexpected EOF while looking for matching `"'
    ++ return 1
    error: last command exited with $?=1
    not ok 5 - subtest: 3 passing tests

The error itself is a bit puzzling at first. The basic problem is that
the code sees the leading escaped quote during eval, but because we
truncate everything after the space character it doesn't see the
trailing escaped quote and thus fails to parse the string.

Properly quote the value to fix the issue while using single-quotes to
quote the inner value passed to eval. The issue can be reproduced by
t0000 with such a path that contains spaces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1a8ee5c002..241198ba95f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1572,7 +1572,7 @@ then
 
 	prepend_var LSAN_OPTIONS : dedup_token_length=9999
 	prepend_var LSAN_OPTIONS : log_exe_name=1
-	prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+	prepend_var LSAN_OPTIONS : log_path="'$TEST_RESULTS_SAN_FILE'"
 	export LSAN_OPTIONS
 
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
-- 
2.47.0.72.gef8ce8f3d4.dirty

