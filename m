Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816828DB54
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535018; cv=none; b=WnTl3F01jjJ19ViFo4O2/y2lwXOFI4bbuSYA3KGPvYKkP7FcfHWmLCOTIupYrEn5eZ0DbbxhJIfuL7Gu0sVAZL099EePuroRkG5Qpii/Edhh+U3e2SPqwm1G16BENA1tPgFsO2BBJE2Z6dlFjByOZWLZM54ZUPw/1kljjgqbN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535018; c=relaxed/simple;
	bh=pvdEgr2OMh9tSPD22gr1dFFGAjTVD2KyR1MAiISTp68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhbPXtXuiH5XlbyS7xHYFMoJ8jpEzIY9pYeW4fQn+d0tTBJ6dQ1/xepPHXvDL8rpOA1FrnqHob6qiyxvG2KbmgkaJJZXycC2z0x5ldsnknsLQpYKbDDhMdVavESio34gjvFCXDym/ZOCEvDL9eNbMo3YugWkuK5kHY/+rFR+2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CkHfo3u0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JaPq48H6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CkHfo3u0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JaPq48H6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CAD641D00281;
	Thu,  3 Jul 2025 05:30:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 03 Jul 2025 05:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535015;
	 x=1751621415; bh=bY18c6Na0HcGj3JnbNTthyY1geHUvQDdMU4gy+XbLh4=; b=
	CkHfo3u03LqvesgXyo503FNCO0SAOArZM4RTGsQDPd8y96DVIskRTULschYMSCuA
	MHHRum4tJghhya1R1iFvvRD/nxEkV9aiXtVa9EnnHeRsliokBWCBIMs9bndifY9o
	Yzn2KtDmTNli53GC546hfElyBcQAxMj91/bWHIggVwjygPDjqpjcO+VFDuJ076rJ
	rGMgauvUZ/grLGTd1PHXN+bz+0Z6T8K/Tl8mvlBIoXXUdYSKyJZcVjqQXGMV1MyL
	o57WjRfmEnMf1+lwO5opAEmRM3pEylfrYgxtZejjOSY1CBxs+X6LlmbQ2QkGfyvJ
	8vtAdV/Y1qI6cY3xYsqMvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535015; x=
	1751621415; bh=bY18c6Na0HcGj3JnbNTthyY1geHUvQDdMU4gy+XbLh4=; b=J
	aPq48H6/J1+LHlINHbApOt33VB0cYiYwz0hUPoQBVSbG9xSIY8RDpza2Z3h6XQLa
	+1EKo6DI/UAbzoVx8SjovDKUQ86bZ5PtSreWNtGNR34SeCR6vduq+aEiC/NBdcG/
	jc5wd2Z0cpH4lyXBfrffoI/kuPq+MXafsQGT7yJvqDWhNO2u9HJMPj4T57TVV1pA
	C5cotPS9XRwE2IOHY04n/+2MihR2RJkkLYnbY2GwkBMqTq0c0DGD0E0JszQQm4HV
	Tw/3jgeU7DmQTK8HZgfo9M+A2+1laQmvclSB0Nu7/2T8IY3ZVP16E3ooJkPEe6F4
	yHzp/sRzhVnlso6CV5R2A==
X-ME-Sender: <xms:p01maM-94FYMc0W_s96hUT0oZBFS5HBzxyPuKQKtbh8Hy1AYQYs2mQ>
    <xme:p01maEvnAq1UdOCN4lO4IFQd6DgjCJKiMMrAjx0uGO0nRUdqVYFppEcropZn8pJaH
    cfpcCj7LPtPXdnrWQ>
X-ME-Received: <xmr:p01maCA1joDtHQf0rn5ncEADDqYHXQkQR-Ifyh1wQKzlIRQ8n8JIrxU8V8qg6jbYFMloouCNxFq0MX1TK5tKnbeiVDqbyMV-DR34x7b4pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghn
    thhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhm
X-ME-Proxy: <xmx:p01maMfKqn5Ma_oAi6VwutgTAD13q71kMU6tb6J1TkHsesc74IjlMQ>
    <xmx:p01maBPlnh5838Oq5Acn9lxGU4pRcnmHGJt14rp98a1FC0ETgSkmGA>
    <xmx:p01maGk34fPO49g41kq5jJz2mONd6BhjpTgKRrs-7T6JGKd72g9HxA>
    <xmx:p01maDt_FsTC1w_4leVf83S8PvF_d8KYPf8N0wEi7Xd2rXI7yn8avw>
    <xmx:p01maN6HvwGe9Bw_zL15AB4Pqx48ymzfa898tKUx4Ks2ZNWZm8ALpVuX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d52f761 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:43 +0200
Subject: [PATCH 1/8] meson: stop discovering native version of Python
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-1-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
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
 meson.build | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 7fea4a34d68..21fdff0f496 100644
--- a/meson.build
+++ b/meson.build
@@ -866,9 +866,8 @@ if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
 endif
 build_options_config.set_quoted('X', executable_suffix)
 
-python = import('python').find_installation('python3', required: get_option('python'))
-target_python = find_program('python3', native: false, required: python.found())
-if python.found()
+target_python = find_program('python3', native: false, required: get_option('python'))
+if target_python.found()
   build_options_config.set('NO_PYTHON', '')
 else
   libgit_c_args += '-DNO_PYTHON'
@@ -1979,7 +1978,7 @@ if perl_features_enabled
   subdir('perl')
 endif
 
-if python.found()
+if target_python.found()
   scripts_python = [
     'git-p4.py'
   ]
@@ -2202,7 +2201,7 @@ summary({
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
   'perl': perl_features_enabled,
-  'python': python.found(),
+  'python': target_python.found(),
 }, section: 'Auto-detected features')
 
 summary({

-- 
2.50.0.195.g74e6fc65d0.dirty

