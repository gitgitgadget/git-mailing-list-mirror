Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EC19E99E
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832130; cv=none; b=mrBKIZrF09frmjx98F5KeY4msDF1nLCZNucWtPkKSKLaMYPQruFEhk53AmLmscs3Hh/wjMWTmR8wbT75ibnBC0++MuwRjAgaW63WjaLLxR6CV+GsQZNQLYMbb4zhATtwEvYOJQhaLISfqwecnBYPQc5GsmIq4MkEE0ISrzYmAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832130; c=relaxed/simple;
	bh=n0f1XCJp5sTGtpkm5VwIPJ9goKkSQQ+xmheNRz1SUJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ol5M5F5AdNyGvs2YNAh1KbfxqqhHZB26YKUI8HkvAVpcSpDiJBA7HivWjq9oFnsWUVYCAy9o0/2UZa4cLW6Eh/Qqg90wkEuxoUxOv/Cb0Ciau9IoFKgWj2IrURAbRbOTwa075ltpOIf8nLi433tUyxrHugYmRT7ATOVUjtE8hJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZRF/hM2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oD/nqS0l; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZRF/hM2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oD/nqS0l"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D34382540105;
	Tue, 10 Dec 2024 07:02:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 10 Dec 2024 07:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733832126;
	 x=1733918526; bh=nwaPGmVOuZKUpPKpKFaqliSlmVSJnrB/Ki7/Ot1STjg=; b=
	ZRF/hM2XtUgpuUoxPPyNoI2qChrGP1SBhOfCYCB3IV++dBrjVetGWxQBvhvxktZY
	QgG0K0GhlBjlVAN5Tam9utBQ8En2a1deT7eGultPCvaN9UfFw5FKWCrLhibejBDR
	aVugF5l5z0TWaotUaAWZnFM/DfJRV7IL8CsntN+UG5eThlmibnJfZA7n0ZW2HT+C
	+fDxkeAOiZI3fm027fbrk3qPp/yJKF2JfYpkzjhrehcNAWsvVucRnFMxT+yKGyUz
	HGgA2GqgIwBaLRu50U0BrmIMaqTnTtKIzVB2dfIAgZza4NUuiTNCX/rJFvf3OQ0N
	0QthhoISr8q2sFxwdQ1Anw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733832126; x=
	1733918526; bh=nwaPGmVOuZKUpPKpKFaqliSlmVSJnrB/Ki7/Ot1STjg=; b=o
	D/nqS0lrNhgzOqJjnZa/jtMKsgE10iHwZvpfvEO+jt+NQSWYCbe+Y8AdQhx9OVTD
	kLDDYaQsIqM61GE2HgBQaxfHt6hegQfukxAx39Zi5z0oUt/1oCe8uHHhQKeFZ7gW
	64w+f4dDZ+7c9e/9cBjAoZlO0chUks9SUthupPnnVD87cFJozNL212hTLESxifH8
	2uMi/90oujOfFOCUpk7k6iiOPoInWcn/KQnqB0TmPQ1jWXaz09bZ553la1l7yTsf
	GfJ6cMYtbDVteAjKKV0aasEX8L3YqU/9G0O9rItGGwcm0p5+KtYUQnLG0dBN+Glb
	ONzbJzaKQaNI4ekis19xQ==
X-ME-Sender: <xms:vi1YZ6RcsGdT4nsblqalBdpkkB884oCKRle3vrCu1Ep9d3tYJkeTVg>
    <xme:vi1YZ_zleIDa0NpcE92XJ35xdlpBOJ3AxORuYUSzRAJXj7RodUdWgKlm22duc5Xck
    JB_VH0SLf3f0nLeWg>
X-ME-Received: <xmr:vi1YZ32sytXZBjhlLh16t4BSvuYGk5haiZM0QuH0hNH0xDH4c5pX6AptVsvcEa3qcXtgBMihe-SoBVqWDEieznmS3v31W2a2ji5z0JrhGb5D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:vi1YZ2ArY8xgHV-2ZrF3XfGtyRATFG9q5MLL9KGW8eo2IcxWdz2lpg>
    <xmx:vi1YZzh89ZffRQz2AVHTF06fUz_Vajt85jzaudKzurCc6qs24og9Cg>
    <xmx:vi1YZyrQptXDWO8toTjg45YE3PB9_DceUu8pP7IvQf3NNWX9Ay7log>
    <xmx:vi1YZ2jvYZzl0t7Jkt1fsGKIkJtQHNGnoQY6CLt1g7W2utVUR1MATg>
    <xmx:vi1YZwtRhTdO79HqcmfxfPKpelDPxqBPNBTte4DqYHdHOUJws_MPNq3o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:02:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3fe24240 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Dec 2024 12:00:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Dec 2024 13:01:46 +0100
Subject: [PATCH v2 1/4] gitlab-ci: update macOS images to Sonoma
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pks-ci-section-fixes-v2-1-e087cfd174f4@pks.im>
References: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
In-Reply-To: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>
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
2.47.1.447.ga7e8429e30.dirty

