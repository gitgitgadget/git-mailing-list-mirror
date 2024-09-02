Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6EC20FAA6
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284920; cv=none; b=I0U/h2E5/Z/8kQ5qzJNJEkM+D7opLhflwcxXEihG9c/U4pqnab0VLJnWy0IIO6/ic4BvO0qMsavVQP6uUXUiGuti3HLKKV82rGSnnKlznsp7fQFmNfu5+y/bLqcKMnIb6nj2Xz8L6AiW2wh54ef5nmZ1xhfS4MF92KiQvw+Qjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284920; c=relaxed/simple;
	bh=JlcwPWGRHHGlw6zyCRsk7y7cL74itquQth38kurKaR8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNshvDANdpdS30U958e0cClPAGmxh16LdEcfTJNpfr9Tv9DEhrlkRFrAcZD+XF/8j0lFAdzfQP/gB3IytfIURq//fpVtWiwrSZcc5G4fYxYxA1c4PeZLZ7JLfFsVcge6HQDd0daGJ13d23fx+YpSrqxepaDBxPMRrJFLRxIJ0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eNP7w9nL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlsJM8ci; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eNP7w9nL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlsJM8ci"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id EECCC1380303
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 09:48:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Sep 2024 09:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725284917; x=1725371317; bh=TDTJ2D34Ws
	pj1/ratWnIn/3lVisgW+39ObOgZNBVZ38=; b=eNP7w9nLAZddFQuC5hFjoNVM4K
	DHd604odZuodUmPlUgFiU5BuOOtDfa53A/r0rghosphSDqysG0FStCRHsFlwex9P
	TVNErg3wEw3kKaUND/oUqUkD1tgKddjtLYlzMJcaxr0pu1/4xv+K2oZr/Bk48tic
	r3gaJui5F6kLaW7YjwOjHPjlWa55XiCT+mfnFa+x2aWnnm16SDyQ2ceVIr8y58eo
	8D8BR/R7bVlCjT/WeEXrvReqxtE4anfoqdJdeeqMsE144mhA1hNUFgIPAr6nFLgY
	lNRbD/soDO+QUJT8SGUfuA+wMYJ8vNkXnGZPFlWMzFJ48wa+1fyNHPp0Nh2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725284917; x=1725371317; bh=TDTJ2D34Wspj1/ratWnIn/3lVisg
	W+39ObOgZNBVZ38=; b=OlsJM8ciZHhmi5kuvDsEdx3EMu8tnRqmgrHoB61gXufd
	dvQv2Ihni2nLHLZqw0Tz7w2N+ZyY3L1UGnBMexkdNQ0VdaYVQXtj3DFRh3WYJWnV
	2oVYGFI1J1JhEa4va2KnqJbR8RUpjb/RytmJOMMH5B5OMu4OsQAaHDbHiRFXJrtD
	jukbWdv8SVrLLQSclL4vQXJIdjDTziNEnG0MHIcPbZ5OJi7ndH6Q3Td9M3X/+gC4
	a20DM81WTUVFnyg+8QohPWTVEO84Qw2zJSwf4QW8FsMnxnVZ1fWUBDwSwSLaAZ8Z
	mdAYaqqexKcVNoiBKkc5zjUViaLkTkd++t3g3jD3yw==
X-ME-Sender: <xms:NcLVZssrm6gSlpeW30XxEItBoAhTsNE0422eFFg5ICTEYHS2krCYyw>
    <xme:NcLVZpcjhOSWpmKwIr1TV0o3ZnplwUNAiPIlEgDbbrCdzbhIxq-USueIa9c6R3wne
    y-aJQwCSqrf7iWsJw>
X-ME-Received: <xmr:NcLVZnwp0bz-9NrgJZmiULB0M6eSldTs3mWkuhSwxYWny03n6eE3576WtUqItzsixHX4iL2Gw0cCkKZhQQXJKES3_neJ2L6Q9G78vRhxNAO4YQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NcLVZvN9h1sKmXD-Nu7ErVCZVzqsB3XHuOD9GqP7SYebtNJPg5RFtQ>
    <xmx:NcLVZs-2IMbHbKDIguNmi3xj8PltXAJaiGLJZrjOrY2jgPKVYeommQ>
    <xmx:NcLVZnVs5kl7Kiy3rHvCp9dJY2mf4VhTya1NwKvSACTjg-L_xb2ZNg>
    <xmx:NcLVZlfdBmEQFsVrzr7V8QExPIcmu6EVle0IIDA0HYDzqPkX5BrL3w>
    <xmx:NcLVZqk0JzD65ddheGGDOlOhXY1x8i8H70ZbVWDzIlqFy58IIYf-1nZV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Sep 2024 09:48:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d51f4a1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Sep 2024 13:48:31 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:48:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/2] t0601: merge tests for auto-packing of refs
Message-ID: <3a8063e8b2c05315a5cbe8159a6acae43c12d39c.1725280479.git.ps@pks.im>
References: <cover.1725280479.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725280479.git.ps@pks.im>

We have two tests in t0601 which exercise the same underlying logic,
once via `git pack-refs --auto` and once via `git maintenance run
--auto`. Merge these two tests into one such that it becomes easier to
extend test coverage for both commands at the same time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0601-reffiles-pack-refs.sh | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 60a544b8ee8..ed9652bb829 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -161,13 +161,6 @@ test_expect_success 'test --exclude takes precedence over --include' '
 	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
 	test -f .git/refs/heads/dont_pack5'
 
-test_expect_success '--auto packs and prunes refs as usual' '
-	git branch auto &&
-	test_path_is_file .git/refs/heads/auto &&
-	git pack-refs --auto --all &&
-	test_path_is_missing .git/refs/heads/auto
-'
-
 test_expect_success 'see if up-to-date packed refs are preserved' '
 	git branch q &&
 	git pack-refs --all --prune &&
@@ -367,14 +360,25 @@ test_expect_success 'pack-refs does not drop broken refs during deletion' '
 	test_cmp expect actual
 '
 
-test_expect_success 'maintenance --auto unconditionally packs loose refs' '
-	git update-ref refs/heads/something HEAD &&
-	test_path_is_file .git/refs/heads/something &&
-	git rev-parse refs/heads/something >expect &&
-	git maintenance run --task=pack-refs --auto &&
-	test_path_is_missing .git/refs/heads/something &&
-	git rev-parse refs/heads/something >actual &&
-	test_cmp expect actual
-'
+for command in "git pack-refs --all --auto" "git maintenance run --task=pack-refs --auto"
+do
+	test_expect_success "$command unconditionally packs loose refs" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git config set maintenance.auto false &&
+			test_commit initial &&
+
+			git update-ref refs/heads/something HEAD &&
+			test_path_is_file .git/refs/heads/something &&
+			git rev-parse refs/heads/something >expect &&
+			$command &&
+			test_path_is_missing .git/refs/heads/something &&
+			git rev-parse refs/heads/something >actual &&
+			test_cmp expect actual
+		)
+	'
+done
 
 test_done
-- 
2.46.0.421.g159f2d50e7.dirty

