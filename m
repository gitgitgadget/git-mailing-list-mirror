Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED2156F3B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487156; cv=none; b=QNP9tn1FDLDb8GO66LMu7ZpaV6XRP/+OQc7jAP6aRHpgb6f3ja6KdXjZDPnmXJcnr8NwFHE6etw7mQX5+9Xwz+EhVgidZpjkqsRATV0aEbBWg5+s54E7v6Z6cqtOqVGBpIAZSgPxByyaJtI8RM5rRYUEWgMKydjNK8J+EubEs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487156; c=relaxed/simple;
	bh=RCVrddIgjR4AOmOSfVM+GFZLZ4PleHp0ku5SMo2pVxQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcCbr8FcCnTlxFrZudcU6VSCY1JtdJP/xcu+OFzXlWnWMOZ4nMia84s3QgUNCxKZJPnCmLIBXzru1AMGmFuVyiIXZmJ3CBwB/r9BZEqFaqvHwg3FJ6/zl+ceNV36kAUvByrLlw8X5CgIQ4HfTduX1bdluPZL58yHYSSLbDUWhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ChDhnD/F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=npJr1gz8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ChDhnD/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="npJr1gz8"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 412D211401BA
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 16 Sep 2024 07:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487153; x=1726573553; bh=JyZjmH7Kvm
	jlchaQDnNyypinjsHDYhtshZ+A3X8iJOw=; b=ChDhnD/F8sfQXdCKdBsv6XVFyH
	OT8ma4c7nF3wn14oTh8PLJ+MhrmxAl6Tc4+0RQ9DyHXvl8V9ZueQHAfbpK9fzu9h
	CIX5AhJ0ps/vPPdsASP+YbKEcwxomgyj7DS5Z0FYjockLUHLaV9lECPd19pS5d8x
	pqbFoGfmgYq+96tK1SasIvqPFNRcSxAJlgjsXPgitnCTIUzy63eagajemzxnADsb
	NhMOpypF8GIifRCIFvM+6CiS/uXAOjDYlCaVyrO20UG1A7fYTpmxMhifjB3wzRBo
	WEp/qqnzbeVQIuXTymLEaF2F/SiNouFmytktgkUfoqEJWqmYltSkwtFcBr6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487153; x=1726573553; bh=JyZjmH7KvmjlchaQDnNyypinjsHD
	YhtshZ+A3X8iJOw=; b=npJr1gz8IVW+DQy6FpGHIwObkDGF2j6aULsknUOBgDs+
	e7Wmw8NaXiA4D2O8KhyopMYai+CVp1THDTyNVY4achZKC+r0h8I/vE83zu4UoUGu
	9ibLZnC83uF3cy7VFM/RHfhqwM7EcVrHLTKX1+HWwL8DI53KLfN5oqHe3YbyVMia
	1jMCl+BKaDJo8rv8f5s0jnfeVMTrW9VHXBE1ye6Zxr3iBhmMA/okS1DlQUOljf+H
	8zsAJbOT+TNDM7NTtuols066hPjkmluTZn9KbuML8v4i9itJ+orMfYhCp4Rhuz1E
	tRl5gRlmptPPS76bMgrxYLSpFTMmzmNjyBEDgfwlVQ==
X-ME-Sender: <xms:cRroZikoOzunQiFDG1D1GAUyFaVge3z7O-eR6cfHL78c1iXEMCLjdA>
    <xme:cRroZp0LBzr_bixtB8IJnAEEMRYLmp-HEashD7Ip5qc13h8VY0m5eSYla4JUJg6gn
    6ZfmYdFeMAuRK4MoA>
X-ME-Received: <xmr:cRroZgpYi9u3lJQpQe5WjXC5qOKcZBzVS4s9PiokR-kx-YqTPQUhAgMy4tQx8LEL_yYxll7-BHAOfqEO95dxInUHOT3DkyxIhANl5x-ytdqTeMG5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cRroZmnkiMVWCWy4VMuFKRHb8-6XlRIgWBoPMFECgwRRaW8HDy-uzA>
    <xmx:cRroZg1bj_Mh9bGiJOcUy42Nicgncjoq0Tpt9dFoJaG-3mOeXIWwqg>
    <xmx:cRroZtsOujZdyyA0hU3WCGD2tp5gG08T9I2brRPbx-OrKQCIaFz_fA>
    <xmx:cRroZsWmEoVzWKUEUT-NBv0VrktVjnOPmKfEhCsrr5vQLYo0bhAXwg>
    <xmx:cRroZt-zBtLtkpnXhKYcMR_hM5-fi8kgAcJlfWUcqKZSV7-9GYFMJSfH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b16972d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:35 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/23] builtin/pull: fix leaking "ff" option
Message-ID: <747c9a76a288d6fbfad85203e0bccaaf4b6db282.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

The `opt_ff` field gets populated either via `OPT_PASSTHRU` via
`config_get_ff()` or when `--rebase` is passed. So we sometimes end up
overriding the value in `opt_ff` with another value, but we do not free
the old value, causing a memory leak.

Adapt the type of the variable to be `char *` and consistently assign
allocated strings to it such that we can easily free it when it is being
overridden.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pull.c               | 11 +++++++----
 t/t7601-merge-pull-config.sh |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 4c54d8196fa..5d9d9e467e5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,7 +84,7 @@ static const char *opt_squash;
 static const char *opt_commit;
 static const char *opt_edit;
 static const char *cleanup_arg;
-static const char *opt_ff;
+static char *opt_ff;
 static const char *opt_verify_signatures;
 static const char *opt_verify;
 static int opt_autostash = -1;
@@ -1024,8 +1024,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		 * "--rebase" can override a config setting of
 		 * pull.ff=only.
 		 */
-		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
-			opt_ff = "--ff";
+		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only")) {
+			free(opt_ff);
+			opt_ff = xstrdup("--ff");
+		}
 	}
 
 	if (opt_rebase < 0)
@@ -1135,7 +1137,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
+			free(opt_ff);
+			opt_ff = xstrdup("--ff-only");
 			ret = run_merge();
 		} else {
 			ret = run_rebase(&newbase, &upstream);
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index a94387a75f2..7fd8c086af3 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -4,6 +4,7 @@ test_description='git merge
 
 Testing pull.* configuration parsing and other things.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

