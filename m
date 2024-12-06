Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4F1F03F6
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483436; cv=none; b=tckS5NwXC9KFzpGBTmDyCYbbu+/4NKGwNxcXF625L7A/S+wDMMIFa+GefkKj9vzpwjK7erP4x76xchVV/5hMU/mg1KorCcdBsfEo3ARhaEWK38gWBPn3mN7ZBOgrVe1mnliYKIIGmiPWpfmqXkjLoyRWBAPM+CR0qbRWZnljZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483436; c=relaxed/simple;
	bh=NqVbaJi+uxrcPG5Zk/W8wWKSdAFa5mDyiaIv8JB4wF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANKzqLUFyusWk+u/kvk0+yxV7fsApkl9aIC/sIhhts9JdrIyvZP93cNbPMRbGzAMid5bwaqTByEZINVRbKmMIV9DCS+qKpQlTJoR8oD6H+Dd9JZJrAFXOZrbJ6OaFo6C9caeIfh8Diyn9h848zZ54es2aQUyZg9ZP2O20YmJDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JlVb6Etb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smD3cyad; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JlVb6Etb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smD3cyad"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39B0A25401E2
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 06:10:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 06 Dec 2024 06:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733483433;
	 x=1733569833; bh=EMhHdp03G3XmOaYu9ioqu0bpzLGnkdaNUro7FfitjWo=; b=
	JlVb6EtbeB2qJGm5eHvrio3xjr/oZBSpQZBSaTuHw5Sw8/N9na1ZxLVl01QyUtai
	DN9fAoZI38OUBhgd/doqFY0vUCKa/sOfCXi5CT6+T/ECQvuoFYJ3DadGvyqI3pWr
	9T+3CzHxcz7fveABiCsb2EDQSHGAO55kOa5n6009uf3fQ7KMyna4m7QiV9/DnJYb
	lYOxVBGVqWA3O/3Pitds4RfzGrk8HmCiXpolYokjBEDfidZ48iW+laOm/tM+bseL
	VqGa8weUTLPzUWj4VeKBoT6b5mIjKb0u5+LDDDxzFJMdcFV5z/+7eDK0tQKs5rAz
	jzIh6OAp7ZiTL0GA38CjCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733483433; x=
	1733569833; bh=EMhHdp03G3XmOaYu9ioqu0bpzLGnkdaNUro7FfitjWo=; b=s
	mD3cyadIYFT6p4rCooXA1d/5MhLKEYOcmTpNzPVbdMcV7oOISK7pTvd6b8TgSX0m
	K+TYKH9aE2mDvm1fU2rmU+ewVI7DVf8su1PstqJDEsbsHf0QL/IfXtQmju8uLRhO
	91tvJ08zc7TQb/W2hu3YJbzFkod4spCSUNvs4/yOafZT9spttAHnkzhnD3QvLJZq
	8cZaTJEOMrDi+pq/rI8GXGLJgJGs8knjaoQE0ivXrnm3503bI/5SpVnk5M8nzt0I
	S2yRYt7UIRpobJ6WjIh8qEBTHSeriuASi4l5DsEp40td8fPy+VzHhoeO1q/ubOH/
	ZceGHk/f4izGwtyTLchiw==
X-ME-Sender: <xms:qNtSZ2BnUMNiawmUmQYfklwaa66VpMshUly4S9udKmxYcs55v8C2Dg>
    <xme:qNtSZwhgkjpn-UoinTt79Np7n63Lw1lE1oTHaqIC6WC1utzutlnFU91_mIbkEd6A9
    bKXXrjjr8GHj3G-vQ>
X-ME-Received: <xmr:qNtSZ5lrWuE0BVGA8CeKzobyYVJTMcCOraghZ9blMMq8hH1NUFqyNKQDnl0lN3v_-uTL6hY4_7LBDgT-bXTC0d3JNnWpUdkirFqFB8vFoxgCLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qNtSZ0yyGlRZqxe0d7PgHpHjTmfHvo368PrkhXsqGkxUlQK4myETdA>
    <xmx:qNtSZ7T24U09_g5o_gn-GYTN4gQvMN3loAuklalZM08r_tFPEaEhJQ>
    <xmx:qNtSZ_ZesjM23wI6DQ13iJrakgA5SWumKBAws6GRhNR_tYkwcXir0w>
    <xmx:qNtSZ0QEqZVlZbusbZjSlU1llgl9cP3Sg1pMC47ZoFuqmfb6ND2C4Q>
    <xmx:qdtSZyI7gYCGtHRewpEdc7zwvptwoxGfnWilJT4Nxhkp3l3rZuSZF-4f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 6 Dec 2024 06:10:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 86543c46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 6 Dec 2024 11:09:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 12:10:13 +0100
Subject: [PATCH 1/4] gitlab-ci: update macOS images to Sonoma
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-ci-section-fixes-v1-1-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
In-Reply-To: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The macOS Ventura images we use for GitLab CI runners have been
deprecated. Update them to macOS 14, aka Sonoma.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 526ecfe030a43e0a5a83ddd35cb7c96d46ab2485..61c56ccac8fdc940075d91dd4cb0b54ee33d5199 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -99,10 +99,10 @@ test:osx:
   parallel:
     matrix:
       - jobname: osx-clang
-        image: macos-13-xcode-14
+        image: macos-14-xcode-15
         CC: clang
       - jobname: osx-reftable
-        image: macos-13-xcode-14
+        image: macos-14-xcode-15
         CC: clang
   artifacts:
     paths:

-- 
2.47.0.366.g5daf58cba8.dirty

