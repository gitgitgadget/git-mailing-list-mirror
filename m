Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A81A0B12
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832131; cv=none; b=oZAuE0C+hifSKzVq8qyvOyTecUZmAYg1FxPjhLhgyQVPzCtHlNJ9D9bx1eOtIhViVvyGJB9LPCbMkxNwjQQ6YWbN8pQr1hZPaY3poDNXPzjlpYttH+mdyQcMkc54VYveiuwqEqyep6PeadvvO47ETULmNQgGjIMSwC+MWnm2K20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832131; c=relaxed/simple;
	bh=SpnoYTTc6Hlai9QoweaivZpQv1jX0wMwOkr+w7BQd9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSf3Zncn5OJyOGgYkHGEA3PbjCN3AEfitINZMdKiuJRPgVZVJ52wmqoHFyAraILoJjs/CmiqNAHiThzt1Oe1HSoaHZxJPGJmig6W7JA9T0VFWChbgmVQnIRncRkTAK2nNgwR95f/lFxFVxVgCF7yEnCce5qIwmq0KpJyiXem8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OFlHUuRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2gSxSLC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OFlHUuRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2gSxSLC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DB912540103;
	Tue, 10 Dec 2024 07:02:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 10 Dec 2024 07:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733832128;
	 x=1733918528; bh=4ZCJggiHDlitNgf7JrZPECm8kOigY2ndPal8rO1FE+4=; b=
	OFlHUuRP18/mDRkLzs39OVefGzZd2+++iFzFoxmOuvwnkA+zZMg270ebIkag0Ygz
	GrVh7FRKl31vMC4+qgoKrxi1aM2QARqSYdt/vpaeevYhJFzAE6kFIldF7MD2WEnh
	qtfeWDuEipGQyicLhj2YN5955/aetq/2pJI7Hbk3KnoaJNFALhb092HpMs2UKX9I
	mTtlJp/jh0FUVKza1bqwdf4gsquG9oLcWCuUIqTcMXSDnqgSvCuGBi25AF8KfHWu
	/cPMk5n8IG1sJrl/8kDwoTrqVAYj40HJv0tPaUNe8nbIrTIqh8is4XWV8aNohFjs
	4RVWnRvgoYn+6bti/wxYpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733832128; x=
	1733918528; bh=4ZCJggiHDlitNgf7JrZPECm8kOigY2ndPal8rO1FE+4=; b=G
	2gSxSLCvncmX26db3OopHF7lXOdCVaqhe0vqan4lHfE7mVT7rueG2gnsA3K+SkUc
	WRTVlBWDh/2iYPAglvLPYHz1GTl9rWvooJ2aqNdfimdxgpW4euzrzGczUvbctLt4
	X6uWPiM8cqgZa0pu53xZtINvXKMFmzRrlxFXN1EBJCRigsHc2udF8VZigo4u8d+m
	AZ2hcU8XVlh1nrsPbyA3OOi6ZIx2ZFHzUyVvjGgmhCtM3Cg1Bs95LLmmfFV3GdPq
	b5F3JxFmpUUoQHrAxlycy046r+a+KhRnSa9O/Qp2uiENk8iXH16gdvXfvj379d2D
	lpczAk5zH3dJuRghXyJ5A==
X-ME-Sender: <xms:vy1YZ09wClW2SoVaOFxDqRDkBAELMtVjEhH9TjZ3KnA645woEKVljQ>
    <xme:vy1YZ8vnIumEXSfe_9NZczmwS1XU-GOANh4ol6yBjrPbeoXaLcj4dGm6btDHWuoPp
    0rPNb2oAps2S0M8rw>
X-ME-Received: <xmr:vy1YZ6BroVDFoxg305LmclZvy4fwx_fq05dobyndptVCCFE9Inr0hWksvfYGZa1QQAOq7N2aFkYjFI-iUDaPZ82mAh0NcGQlnLnHoaqyy7dx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wC1YZ0f_z5frB9h7lo_dxBLiDvryQ9XCv_gvEa1aY338nrDKe3L1GQ>
    <xmx:wC1YZ5M_oaa53l7ql3HHu8Ufb6aSJoeKvm-Z8W14p8LFstDwDuRz1w>
    <xmx:wC1YZ-m_MGi3db1IXfgGrXLC_iOzwp_EfG35Ln7l09NMK5iRLG1yGA>
    <xmx:wC1YZ7udlpSV8z03yUu1b1eULq4q_qSIXXgq79XhUND6jDuT5K7MXQ>
    <xmx:wC1YZ6rZzw62Btb0Mo1uWJkTmiU7s01atBvfrwc5qWtz_7uwk8La-qQ3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:02:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 926e2d8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Dec 2024 12:00:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Dec 2024 13:01:48 +0100
Subject: [PATCH v2 3/4] ci/lib: do not interpret escape sequences in `group
 ()` arguments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pks-ci-section-fixes-v2-3-e087cfd174f4@pks.im>
References: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
In-Reply-To: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

We use printf to set up sections with GitLab CI, which requires us to
print a bunch of escape sequences via printf. The group name is
controlled by the user and is expanded directly into the formatting
string, which may cause problems in case the argument controls escape
sequences or formatting directives.

Fix this potential issue by using formatting directives to pass variable
data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index a54601be923bf475ba1a9cafd98bb1cb71a10255..f15f77f03a06120afbee438cee76ddc2683e1fa2 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -18,7 +18,7 @@ elif test true = "$GITLAB_CI"
 then
 	begin_group () {
 		need_to_end_group=t
-		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
+		printf '\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K%s\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)" "$1"
 		trap "end_group '$1'" EXIT
 		set -x
 	}
@@ -27,7 +27,7 @@ then
 		test -n "$need_to_end_group" || return 0
 		set +x
 		need_to_end_group=
-		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
+		printf '\e[0Ksection_end:%s:%s\r\e[0K\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)"
 		trap - EXIT
 	}
 else

-- 
2.47.1.447.ga7e8429e30.dirty

