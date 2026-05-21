Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CD364049
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353974; cv=none; b=NFa6It6ji22nEd4Kszn8RiVlOS2S4BF9yZ/8yJ5OXIWVks9tY1nHP0c+D45GCMWT1X7z6vVpRj+6UpzrYszDmt3j+I+2OSFAgDDBwQkyhDtzcpxTzB8AwaGKUAPRNG2JP2WTM3h90aYSpQAKZuYO/qfT9zjP/TzGoH1tYpvBLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353974; c=relaxed/simple;
	bh=hDvDrYhZXNlfqyucd2dRuUcbzzHxwLZCa+Nl+/pxvaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmfaAc9KASBopORdYPfCyjxYHZwtWbh/RTSZJuyDFu3PxI1E+jF7IkGKLb6RoHZ1eHa1RLtV3Q8cM6MGp9iz4ou1XJSpbL3ihbJOwLLjdk095ZkrYwbsjAgOIDZsdXpatfNkT5y4+glev3T/YQPzb8kj7p5jrewQy5s4d702KR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Za9AqMaR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XTpSjsdt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Za9AqMaR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTpSjsdt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EFFD140006D
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:59:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 04:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779353972;
	 x=1779440372; bh=+ai6rdLJ4gIPfn6lgqrF2TJmS28cdIiXYVT8OQ1hawo=; b=
	Za9AqMaRqvOOx4uCwWFY4iRvMoLxiu1TXpK/grB9CpAfyug68x6TKi6Dehlt7NPj
	cn3fL4UMZJWUUcsbOG7PCyabtlswRjhp12hpfUH0x0XuWBNmb68HkRMCBqtJOYfN
	y1Z1E1vvbwsQQXdBlnU38tLV8qMRmdfuWA0jV3k1L4UGFyXca+H1+3AhA4oz56E/
	YgwtRZ9V3XehfqrtTZfL6lfxm6SSJS9SIWYuNLhvICkjQNhW3cFbp35foyf6IVFL
	+O5LjGa6jDu3g8HuuqHtgDYPwUzMTglChFyweDw4OIFEJagXQGb0d1XZeWmfzewn
	jloo5/1HpBSBg6CA/oNXZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779353972; x=
	1779440372; bh=+ai6rdLJ4gIPfn6lgqrF2TJmS28cdIiXYVT8OQ1hawo=; b=X
	TpSjsdt4NVxQ7K8wrxvefwHX5Dwz+N4w3u50m8C9sEhKjEKvJ9PF8uPNFLE4b+Ln
	PUR5s87ZhOKaj5Mb1hpua1vHmzFFHZ2SI1dLXxvdxeCBx5Ny/ACDMPyYQxdemRt6
	pN0IOEn4S+9dQaW/+VeCyAd3dJmJZIz1X7hKN51YdmwpWZ8uE7SjjHJxR1Cz6Gzg
	/Kshn2SBgTcB2PM/Wd25i0Pn8HjY24OS1I4ZSIEZz3u2nUHoXcHV+RroL6d24HVn
	k4HkOEHqOdj2DKrOQYrN3DUu280xVbakkO5ZoIPPZtuasaWoBiKq/8N5NB00SWN9
	TLJNputW02QxjvgdX9I6Q==
X-ME-Sender: <xms:dMkOaotQWctSzaO0Vh_XQbpwueaiT1eb7oR3nVCSTf27KoOOQhu5pQ>
    <xme:dMkOasZBKERMcczZaA4ZQCKYn8IgOBRdjq47mlk-grrGxBY9cfeyPjCP1LmJlVZHP
    NyqCQWgY9tiXUlzrX-YL_RA3EoDl55T9Toj02Wx-qTxfc7p0yBf3w>
X-ME-Received: <xmr:dMkOapZQ5gIrJNjd_jz5SqaLWELNtiTSYCxNR2F3sX4QccILtYnk5C7TKR0EFcDfFX8X1C5Ii55rikUyauI2TSD8mM-cVmtMrDmULRJtk4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpefgffefheffveeijeeuffevtdehgefhteejfeefvefhhfeuiefhkeetkeel
    hfehudenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dMkOagWVNO81MBwDBqLV25X0jS1SNmjKwgMm3HXLMk31Omq9ZgiKKg>
    <xmx:dMkOao3mBm9qxWiQa9aTOc_v99nQWy7D4jpINQfxtEjOZLLShxvRrA>
    <xmx:dMkOavbEuQrlmsBoCQmR_uh6eS_rdxX1tajOoS1PP6oRYbK73pvPuA>
    <xmx:dMkOajrq1G3VQFZN7kIfPUrw7j-T6V8d6qiRD657XMjau9PxhEdSXg>
    <xmx:dMkOarcvvO1AWRr0TktZf5Kfq2--8NK0E_Sku7R7Odi7FroFqYFhBZSP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:59:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8164038f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:59:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:59:24 +0200
Subject: [PATCH 1/2] gitlab-ci: upgrade macOS runners
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-gitlab-ci-updates-v1-1-53bb46ed33e0@pks.im>
References: <20260521-b4-pks-gitlab-ci-updates-v1-0-53bb46ed33e0@pks.im>
In-Reply-To: <20260521-b4-pks-gitlab-ci-updates-v1-0-53bb46ed33e0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We're currently using M1-based runners for our macOS jobs. GitLab has
since introduced a new M2 Pro-based runner type that is available for
all GitLab tiers [1], which upgrades from 4 to 6 cores and from 8 to 16
GB RAM.

Upgrade to this new runner type, which results in some nice speedups:

  - osx-clang goes from 26 minutes to 16 minutes.

  - osx-meson goes from 19 minutes to 13 minutes.

  - osx-reftable goes from 23 minutes to 14 mintues.

[1]: https://docs.gitlab.com/ci/runners/hosted_runners/macos/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 83ec786c5a..1c6777acf3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -79,7 +79,7 @@ test:osx:
   stage: test
   needs: [ ]
   tags:
-    - saas-macos-medium-m1
+    - saas-macos-large-m2pro
   variables:
     TEST_OUTPUT_DIRECTORY: "/Volumes/RAMDisk"
   before_script:

-- 
2.54.0.926.g75ba10bac6.dirty

