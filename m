Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF7331A7B
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353977; cv=none; b=QXUzHyu7RC2PvA+OtTvZuCtJ8UgdHHFxG8TGTs45QZ71YAfl7dVQxz+z/7gvrdP1eSrWoecUD2VL/TSKshK4SNZVcyQgbEPt/AiyOdrVrBQb+Hg2/yWj5MJ0Rw4lS8aTpF7B6YFPWJdu3m2atLtycAIoOWDHS5m7mT0Th209siA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353977; c=relaxed/simple;
	bh=bhDqT9w0RdhPbu/YNLteYpBttzXW8cbq0kzChI83ab4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuHSr09z5iL6UjZ595b8gn+di4tXENPU0AN/XMYA6L4oJ6U6FS7F8mirbUN4lFQOB08X273wY6W20lyOi5jXLD4b5jgcBqhs46JYoJd+D79bl7qNKf7MRbwvZ1N2Qk9hHAuNr1U4aXnJTQLFlq1S7aZGoGoppMAINiQV2L7suYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hrEXABrt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kj6cCKL+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hrEXABrt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kj6cCKL+"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08AB1140006D
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:59:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 21 May 2026 04:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779353975;
	 x=1779440375; bh=C3j0r7fHi2lucorREOBJR8WiB40fk67il+TS18T8R54=; b=
	hrEXABrt4LscEcs8PVcMDzYDT0jAs/G3nuxVrCjs1/vECH7KGHyJLgE8wpci95XV
	qo2CZ+/Srapx7yqjSwNSGCmRyXfT/OYWjDbsK4A0XIysU/r0oTV6Soj+OWlbSvqQ
	HrfFuo1IjgFky+fr/5+lIPfIVyymgQiGXfU6VHha5EXYEW77PjEOiX6+maKY/Qmr
	SCnYLCfiGnZGN3OWMHI03ALKgFANj+a583Jcq//S9dlQk/V22NFgu7sSKjQw9jX5
	RVxBJKIb+2Fay/XmR1HBpvr9kruX3+txyFWQKHKcM6B3hDCoAe5iUVTDWGY03XXg
	RqfEh1mtWlYMJxVJGno2Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779353975; x=
	1779440375; bh=C3j0r7fHi2lucorREOBJR8WiB40fk67il+TS18T8R54=; b=K
	j6cCKL+/kp+LtQ3Tj0V9n5owHcoObHq1m7XdtrmdqWEfhNw29mESAaweRKJdIzSh
	QoberKe6KeS1PekPfmOFl2shxR/OKKODE4lnh0u51KDPoMUguW869mJ1nl78tg1L
	5oYbWBs5NFHL8GTKcRONsmtIXQzvbJblMl4A9/7e8dmAbSXWNbO7r/2k9SwQqG6B
	vzbpLNy1AVS87zm/Axyv2MTBKqfHkG3CfIfvBr09bz+J4M/hoVqwjiXQ262WzuB5
	oh2fMcrEITL/zaW7sJt1RO6jP7Xn234bEzqj5uALy1fERDV1ULgL+HGTgD6X8Tut
	8+IKS3ulVJ7F8X0IicKuw==
X-ME-Sender: <xms:dskOarnS3RhtQlaqK2FDNiKGX4y4SVpMlQOdDPF0YMpyagu_BglzVw>
    <xme:dskOalwD8TjYLPGWnRz-FviNa-muz8fG8XKOBE_nhU1J32K58dFkab6m4n3TUp4-e
    fN84E90sd77h1RljOjQ8ioboWt4PqCGvzw7v8xjg7u5P1rDxiXtuw>
X-ME-Received: <xmr:dskOanSBlST0CiTg_vujovUOu4hTFbhwFWrKTHR3nPTvAI5issHVT5Sl2Ou0ERDGd6fSgaZZAiwUA6libt1zHSSFL0Wbx4erS7fzKdvV_UI>
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
X-ME-Proxy: <xmx:dskOaovXWz2eieo4ZhYbsl1lCkGUujKhyVDwA-izfCkGkNSrnK2mvg>
    <xmx:dskOapudCoNk4cjSegJJ1uh9EsyC6Vd6-IQN8Cz7nECLknJMhBop6g>
    <xmx:dskOauxJrctkGU3LuNFu_XzQeh-KOr4xLqF2d4F8H0zbsnO3qG81RQ>
    <xmx:dskOaviKwUVJmWWvvIbaCL5-EEdWp_27i-SF7nKU0Ljyi768mtrM9w>
    <xmx:d8kOar0f8XjQmyASAARBcfPkYPX-wQgZEWeqc8PBxquQfYpzRrfGD4Z3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:59:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acc8994a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:59:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:59:25 +0200
Subject: [PATCH 2/2] gitlab-ci: update macOS image
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-gitlab-ci-updates-v1-2-53bb46ed33e0@pks.im>
References: <20260521-b4-pks-gitlab-ci-updates-v1-0-53bb46ed33e0@pks.im>
In-Reply-To: <20260521-b4-pks-gitlab-ci-updates-v1-0-53bb46ed33e0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The GitLab CI jobs for macOS are all using the macOS 15 images. While
these images are not deprecated yet, there is a new image for macOS 26
generally available by now [1].

Switch two of our jobs to use the new image. The third job still
continues to use the old image. This ensures broader test coverage until
this old image gets deprecated.

[1]: https://docs.gitlab.com/ci/runners/hosted_runners/macos/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1c6777acf3..e0b9a0d82b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -104,10 +104,10 @@ test:osx:
         image: macos-15-xcode-16
         CC: clang
       - jobname: osx-reftable
-        image: macos-15-xcode-16
+        image: macos-26-xcode-26
         CC: clang
       - jobname: osx-meson
-        image: macos-15-xcode-16
+        image: macos-26-xcode-26
         CC: clang
   artifacts:
     paths:

-- 
2.54.0.926.g75ba10bac6.dirty

