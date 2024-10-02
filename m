Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB41D12E2
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882153; cv=none; b=sJac4EimTRIbG0un8hs0/NyviH2M/HhuPV8dB1IuKRW97+dVE2fSJIWTfria/kNyBYGwauCgyFSvFsJY8VwCsQ5dapkS/szIjNPjnlV4qK0J7f10yxJJ4GpsJLX9pSOnZDd9Bs0R8CfCV7bSFvlGkaoO5YCan2jwdGO0jDHL5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882153; c=relaxed/simple;
	bh=/jUPGf2+33Ex5BXMDpZWACa9853/5uZx94/wfQ3n2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1fOaxh7TqITcOTS+dh3zAaCGkeJWcrJnBctJTziKxQ0spS0IxXB7E9jshf2JfSPfXiazP/xYpA7f6yZyZ/9+rucL3rQfv40jw6iigeH9ko2O9jJcQ8P0GqWo3fWGJ7ZKAx0bKgh2l47CyTu5pNQr4aVoUhDgYVVkxd1ZuHZYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cVQHXQ46; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RMX1MNJE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cVQHXQ46";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RMX1MNJE"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CB801140185;
	Wed,  2 Oct 2024 11:15:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 02 Oct 2024 11:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882151; x=1727968551; bh=SrEiT2kY8D
	Puu81dimq02V8vxJ9z1CpQ9d7YfE574IY=; b=cVQHXQ46R8Ap2ZGWnmvSvnP1O3
	0vNHnHnbycNZlI5NVKwBrbCdiYAVDcNiDHnbwmBueqC4Mr9yZffOel4S+0LCyAAG
	7ASKqSrL+gBTFdV+TwbqGGRHwGaTYt4HXNM0s72DYbYH/vuxDfp8z81sQLJrWwxf
	9DsVKjruzC/qSTyhs4D1zZj6rxWFLH8e6Cdn7sYWYaDf0ziHltoO/Ur5zpC+5wQw
	CIJjM1na4Uv7cxbR1pIOOlPMowtyb6C0GklbsTNLCeq9ZR6IKvrKMeT8vBdzoWX+
	CxC9bO8k/WFNwcifBUWLSOM5UWsn29q//ykSC+yBWvVEIzcdK3d4VHCfNlhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882151; x=1727968551; bh=SrEiT2kY8DPuu81dimq02V8vxJ9z
	1CpQ9d7YfE574IY=; b=RMX1MNJEWe0DDvmVB7C9Nsdsp60Lgc7sg0PzdTVoPTb4
	92TPRCNV6EmJ6ew5B3HSUGntriL4Kh8/AvkSEA0mQpeJ65voE2ap2dVxwl3+Ul6c
	JHZBZ8VjAGa5QwDOocn36w0JKQVJ5arV4fGmwDfwH7unCqa0HoHR+SJRSMiEsM1r
	FL1YX141d1oISnjy3EDTrUa4Gdx/k8J6mDumSWMQKyn8pZ2zw+mU92u0jRFmz41z
	b4nEzT8KuBpmMX30tHf8YywxAjUe/Uywzru56fxsGeIHP0NAT2R3EIZ9H1T8KCoZ
	jdpfQBI0vbG+TcMtXw31AV6EndWZXND6hvnFOBJHRw==
X-ME-Sender: <xms:p2P9ZgiZk-0SH2y-JPktvjBonsBZ7AEPx44OnQMW0lXDUv47QYkdrQ>
    <xme:p2P9ZpB0qw6rLVYYqV8omilorjamCULlSmv9miSEfZZ9Sk18du9Erk88Iobpb6121
    vN7e11k5weXjsQyEQ>
X-ME-Received: <xmr:p2P9ZoFZ2pVyJmJjW8jp2BJJ_YO2MvjLAyNhk-kgoLAvPCJdLwIh8x4VZknhIcbE7NrwYEVE7NZEfezU4U-RiHVbHB9RehI-sj_TZrnZDPiKbaP3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:p2P9ZhRuMaC1aH4QmhiTDB0kupGfL1rXFAWiUWqiWjMOS92TDUF--g>
    <xmx:p2P9ZtyapaxDDRlKhMNBQ-UUw3WVeQyfFzz3R6sNno2gDb0gvIhhTQ>
    <xmx:p2P9Zv4zW1cPjLlIJADTLdQHIUUGysCjCD-ZbbMPg6T7XnRiY3zKYg>
    <xmx:p2P9ZqzoUMcNPLGzJzWRWl1Ln6HgdvaMn-0zw18kSh-nLQK1cWGfnw>
    <xmx:p2P9Zo-nHt9bAbfvx15lwTboxJGxOzBqlUJ7W09IdsxBKAOYyZD0TO8u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4fe1bd6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:14:59 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 05/21] t3404: work around platform-specific behaviour on
 macOS 10.15
Message-ID: <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

Two of our tests in t3404 use indented HERE docs where leading tabs on
some of the lines are actually relevant. The tabs do get removed though,
and we try to fix this up by using sed(1) to replace leading tabs in the
actual output, as well. But on macOS 10.15 this doesn't work as expected
and we somehow keep the tabs around in the actual output.

Work around this issue by retaining the tabs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3404-rebase-interactive.sh | 38 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061..da4f3e6caf 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1917,18 +1917,17 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_cmp_rev HEAD~1 refs/heads/third &&
 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
 
-	cat >expect <<-\EOF &&
-	Successfully rebased and updated refs/heads/update-refs.
-	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/second
-		refs/heads/third
-	EOF
+	cat >expect <<\EOF &&
+Successfully rebased and updated refs/heads/update-refs.
+Updated the following refs with --update-refs:
+	refs/heads/first
+	refs/heads/no-conflict-branch
+	refs/heads/second
+	refs/heads/third
+EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
@@ -2178,19 +2177,18 @@ test_expect_success '--update-refs: check failed ref update' '
 	test_must_fail git rebase --continue 2>err &&
 	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
 
-	cat >expect <<-\EOF &&
-	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/third
-	Failed to update the following refs with --update-refs:
-		refs/heads/second
-	EOF
+	cat >expect <<\EOF &&
+Updated the following refs with --update-refs:
+	refs/heads/first
+	refs/heads/no-conflict-branch
+	refs/heads/third
+Failed to update the following refs with --update-refs:
+	refs/heads/second
+EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
 	tail -n 6 err >err.last &&
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err.last >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err.last >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
-- 
2.47.0.rc0.dirty

