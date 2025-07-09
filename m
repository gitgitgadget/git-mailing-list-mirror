Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA026B2C8
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042228; cv=none; b=tw7EO+hhdFYnWskCWlXLctepHhH/jkZDSlkPcIHCe8z4PSh/nJkkaciDy7JUcWkISTMrd1AaoLuYj66oPhtiJUdijP5sAhtYa09m/uFGmaWarvVZptFQL4OXzr8MS6ideaDyZapicKeXfkvv2iiZemdSg9PJYtrgb2rJHSHh+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042228; c=relaxed/simple;
	bh=FQ4/0bEniOVehYgPCsv3+iZBm/81eI88fA3cncZIukQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJ+aTyScem1jjN8DUj6fERO4fP1DUtfxxcYPJ6Q2wC025KBd+A+zfXk/+RsGrR943r6p6s2r85RZLlpIT/PZPCXG/BZkMVC8OdF3XrDRV0vnrJRd9badP8aP7IqS3ff1oYUFND9j8MPEQffZS4IEDX8MM/H/QJZnWpqqaGJBY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tc0GUlnX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZlJI33ad; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tc0GUlnX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlJI33ad"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A7A514001D6;
	Wed,  9 Jul 2025 02:23:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 02:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042224;
	 x=1752128624; bh=pH4wnLMH79Yrqr6hkpWGYfzt3hbg/0/IkqGgR48wSpY=; b=
	Tc0GUlnXm3RtO5pZMjjDQTRPgom9zYHs6mkkKsfDf0LVb5tyPWB/EMy3/8pf7jid
	+EJyzdAiLjxuCgnRotKi6RMsj0rND6O/NvBa8tkqzi2yxH5Ot0gL77No4zQn7oOW
	9ymJ53c8hzMeynUyEVq4fPy/eEaIU3OcTIa40klb9wTug5tiL3FD+C6p7G4vS2ch
	IntQ4BVKGzLg/BW596W8amNQJfc0IjkW91WlED+2rVDOqImOmOoxHlv+eN+v6QeX
	rtaDm0GphQS0KxoiMpY5XV+yWJbUwre7pc2WsOFdc8swIYguFAE0YA131C5xc3Sn
	LWVarPVyU/PEq6rLuZA3lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042224; x=
	1752128624; bh=pH4wnLMH79Yrqr6hkpWGYfzt3hbg/0/IkqGgR48wSpY=; b=Z
	lJI33adiy7A25iZXBt6Te6xYPg/8levK87bJW+LaSIWk3Ue0vGJ91DBD+UQJkB5Y
	4bM0J6vu1pWJx6qwqy/2RwL+8eWwUA6u9JG/Mgoge+uc5KnJ6g6RuCj4cTalSoge
	EQ64tWTLVHrGDqsxvAT6gD87rxCXO3kRXaIuVvU84Eau2QOfQQG/hn3OiWpBMl4N
	yJd/a98dBXEJgp67liF5BO99/mdLFKAVE1CxHPXs2X+c84wBMfYD0kSd+rqRIQxS
	HK9l7ChTPSOYuuSqfnL6L0h7Yg9VqV0CcyrWMW3wziQSr7rW1eZB9nocxzv24qG/
	LL1sUgJlq/JikR9O6AO6w==
X-ME-Sender: <xms:8ApuaKyiFRy3hdfqAFP3a-TAu6T2sB__xitjqB0RKY0WuvnOvqhbiA>
    <xme:8ApuaKGfocue0jh0nTUS3xC_4lQm9j4ID-oRQsNhpOG115cic-Ifb6pnDty81Wgww
    YDzxeUc0HMvz45gjw>
X-ME-Received: <xmr:8ApuaFb99AEYcSkjpM3jj2MRdznxlaEVS1FdFn-zns1CCYcf-iqbDI1Gvlvl4fbnVDXx6xX-1KqCuC1fgr2zrHzYtdMsz2T533E34SxRmgL8dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdr
    ohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhs
    rgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:8ApuaEB9DYS5FeoN3SA342Bt06yoCjB9QS1QdPKAPdWJg59emo-J3w>
    <xmx:8ApuaFnPrt1CqX3sLm8dVbeszSRa2cQhzSBfKAw79-7Lzj8zZKuAGA>
    <xmx:8ApuaNz8UFmCS9V0E1YIas-Vo654wNT9WxlUL-bfJAtjxQ7ZKqlZoA>
    <xmx:8ApuaHRvYiLgobyjSvJt2hPo43fusOKVJzwA8-vfsC7ZrPMDVEI0xw>
    <xmx:8ApuaPbWXzm8Gvw63uOSDnsqw1_IAaD8WWKFUz75zYxbq7wneQAN_tMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:23:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09ea251c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:23:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:35 +0200
Subject: [PATCH v3 1/8] meson: stop discovering native version of Python
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-1-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

When Python features are enabled we search both for a native and
non-native version of Python. This is wrong though: we don't use Python
in our build process, so there is no need to search for it in the first
place.

There is one location where we use the native version of Python, namely
when deciding whether or not we want to wire up git-p4(1). This check is
invalid though, as we shouldn't check for the build host to have Python,
but for the target host.

Fix this invalid check to use the non-native version of Python and stop
searching for a native version of Python altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 7fea4a34d68..4ee1a55b0bb 100644
--- a/meson.build
+++ b/meson.build
@@ -866,9 +866,11 @@ if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
 endif
 build_options_config.set_quoted('X', executable_suffix)
 
-python = import('python').find_installation('python3', required: get_option('python'))
-target_python = find_program('python3', native: false, required: python.found())
-if python.found()
+# Python is not used for our build system, but exclusively for git-p4.
+# Consequently we only need to determine whether Python is available for the
+# build target.
+target_python = find_program('python3', native: false, required: get_option('python'))
+if target_python.found()
   build_options_config.set('NO_PYTHON', '')
 else
   libgit_c_args += '-DNO_PYTHON'
@@ -1979,7 +1981,7 @@ if perl_features_enabled
   subdir('perl')
 endif
 
-if python.found()
+if target_python.found()
   scripts_python = [
     'git-p4.py'
   ]
@@ -2202,7 +2204,7 @@ summary({
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
   'perl': perl_features_enabled,
-  'python': python.found(),
+  'python': target_python.found(),
 }, section: 'Auto-detected features')
 
 summary({

-- 
2.50.1.327.g047016eb4a.dirty

