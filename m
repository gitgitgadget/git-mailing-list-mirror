Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678D1E377A
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502931; cv=none; b=RbpnBZBrEtOH5BZUMbklWZ/QKBDCYRqLndKY+IToRIbRzXEig0HBgAgbylKe9LMAjg6RwLhWU9ZhJBMbNuV5SDA8m4sZuwc8V43zqkIfK2cRZykH1kUFFLcZ3JqyNiD422ffUQ5kGpR4KEOF4hmWMI+fcd66z38+fnS0ugZR+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502931; c=relaxed/simple;
	bh=OQGmQSCkfSKjk8fEnuofL7rHrAxYJOdAfxPtpjC1S9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOIqGBDTVY5wR6YrArPxjjkgJ/l5jPGAW/Lr7INsye5Uk+GYv1vQ3Df3ufwCS8A5HwsC84ipzSr91IhPIuFpKZ66jlBIkmPqS3gNnxRZzPXyiReOgSZH7ZWYneYN3K0j2aN0vfgnjCUtjuQQXofwYsBKvx5FMvHayWVELB6e964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1L/NQxho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GfT+3BBR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1L/NQxho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GfT+3BBR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B43F6114022B;
	Mon, 21 Oct 2024 05:28:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 05:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502928; x=1729589328; bh=bgVzN/KIMS
	O611sZhY1GbF183+MuJo5gR3wqjpq/22o=; b=1L/NQxhojZ+LN7nyqe6GFcYFty
	JKBRHOVW6jH1VRAYLc7AchUeu6iRHYmdrSbYty0u/Sg7Aa+Og+mHWl7jA90osZUJ
	SQoZr8jZUk36wHwWJwMfrG/3TXHxlphtQrE+3dRCa6PLJvSM1ww7awjF8PNvTzSz
	hO6Q+a3jb+l172rEGrhBDSd55EvY7vTrS5p8hfnhHfWAmd9N2cXaHOxbIyP35WfA
	7dj7ytCFYj/d2Mb/YX+cgSlSUBugQi9GSJHyoY4wVMTzBztf8XVC+EuXg0B710zE
	/Hlfd3FiwHGdqgVzD5EahoPOsw3nDdNdsVg7O1dgxti2v8t9UgUW5UL/Bb+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502928; x=1729589328; bh=bgVzN/KIMSO611sZhY1GbF183+Mu
	Jo5gR3wqjpq/22o=; b=GfT+3BBRaGbMnG08Whkgkh6BBk6e7hC5ShyFQXSp7KhY
	FmxjFV/im1XVk51FerMRYRtTo56iyFkUrJ0nkmIbWEiI+n3O1t1sPyd5Cvd0YJ3j
	hjRIbjfBInJsZsvAKVq/904V1izBuCxztnqktyknKBvjlU4/arfOyiUbmfN3yC3P
	RbOD/o8sI0seSn53caobt/DCaJNtOhu0XT4xjZhexA+a2SscIznhrvCcNJuJGsdF
	7NOAdYdf9DAmqT6OzqJox4qJ5CAXtLpBBXxIPPZg/76XJKPJ/T0EhY3/LctED/2L
	gJ6s+pV2PoJgLhtRtL2G6hKZ3rfaXRXivuLHN3X17g==
X-ME-Sender: <xms:0B4WZ5Dczlx56UsTwZPolpzK8Iwlzne75D1FdmB0BfupdfceyDjdyg>
    <xme:0B4WZ3hl89otQIqy88ehZnJ6CjyAegLbX9DBgCyyrb5Q_CsCAnLwYpZ-45lxC0j92
    t-B_VF-ZU_YoSehxA>
X-ME-Received: <xmr:0B4WZ0lczHiZuDbwtGzQUGXfWBeDSl0ivmUlWRKZclCN7wFeujPnRT9rSwWsBuiJWgADIQC3y194KJnjEqkafz6_2a3I1WTimRwy4HtWKGvF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:0B4WZzxNHLBFdHXcTXnAhB7JHuIjAGNJYTJJjaMshBxVchQnJ8pJkA>
    <xmx:0B4WZ-SOBOGoKeCelFzuLcKRyMlsDD6WrRd2SsFYMnyyz9qKxX7n9g>
    <xmx:0B4WZ2ZLaNqvkoIXl0KNnJr26TTZfYr2dHmzCaVwEErDmG0DjkCvbg>
    <xmx:0B4WZ_RPyxr-5P84_ohTwobiZj2rvgfOXpLyYXb27h47x8QfB7T9qw>
    <xmx:0B4WZ8d3rBPOGApirZ5fS_dmKYYLCRfOS8ZsAzKd0ummvo642TE4NurE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6b0d65d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:21 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 14/22] builtin/tag: fix leaking key ID on failure to sign
Message-ID: <b700ab9079ff0f84269dfbb5e6b6aa7af67bd903.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

We do not free the key ID when signing a tag fails. Do so by using
the common exit path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/tag.c  | 2 +-
 t/t7004-tag.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 93d10d59157..c37c0a68fda 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -164,7 +164,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	int ret = -1;
 
 	if (sign_buffer(buffer, &sig, keyid))
-		return -1;
+		goto out;
 
 	if (compat) {
 		const struct git_hash_algo *algo = the_repository->hash_algo;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b1316e62f46..42b3327e69b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -10,6 +10,7 @@ Tests for operations with tags.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
-- 
2.47.0.72.gef8ce8f3d4.dirty

