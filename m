Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BB20E001
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558151; cv=none; b=gX1D2Edq+Tpg25fthvHgcmTAT6n00a9ZDyZWkxsZkf0RYAmLtVSem8XXG0HmArwWkk5mPMIeVsWe0MWZZwWRLr8w0SQX7ts1V3tis23Xlz+2ovgqdKtD6UhvBbrhcaf/91xWmUUtyRDFNCNmUan7oHwpgMJgtnZHcqn90GtJRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558151; c=relaxed/simple;
	bh=H1EESVZGGaDAVlCnwr+0PcRcTi0B48t3mB6W0XGLVBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9f+HSDB33TtuXNSra0m0jk6YIXduhWxOnMbzaJN0sMFmC2XAtqvMvWkLO43xq+JDs7Rstpabr8N/K32kh8SIu0a4DjsHpELWKGnoy3R89ENOXPmV31N+CpM7AOFskwmHWXKf4JbpCFDZQrDjh+D+2z36M2Rhq4fh/HHUpDGhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bz8iJBTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2BXurjB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bz8iJBTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2BXurjB"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C7521140156;
	Wed, 26 Feb 2025 03:22:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 26 Feb 2025 03:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558149;
	 x=1740644549; bh=C7ee2vt8dLNfn4mjvnsdU0S5MGv29otsIlql2n2iGmU=; b=
	Bz8iJBTE9GVy6+dRm8VwOUR04dYQjFnB4KjSWvkb2dX0q8q8PqSaeDpmrTlf7Jpr
	Fx6iVTzSt+zu7o4w96j2cMd6FFw/ETq3T3XywgkPJvysU6hvrX+oyjI6GgVsGvbo
	F8Q/flv6auGWCB0RQstLkUMIa4yzyuy6R7wn3R+ivk/uyX0Barpi/8xcF0w5nbzP
	y7lIyZwqL/ifciqrpPHukjCKp8HzejIzhaHMsSTapXaY9GR35ZSQn7QiicbaT125
	x80wV7MWuhgLWaPnv6wwlgWSKLR9McLorLsG05eSp/18RPuQ9TzuhLgJz5UcwUAC
	2QHDtRqpQk/EnNPxyfajEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558149; x=
	1740644549; bh=C7ee2vt8dLNfn4mjvnsdU0S5MGv29otsIlql2n2iGmU=; b=l
	2BXurjBN/HvlSCzaHJgufvCnplTm71Kv8Xd9cXo56+kfJeB0S+66Hn1aeqKKQ9EM
	6HqOxYUxpxOjzHm8cy1OG1cMapffB2E6GUAJtQmjpPuuK0MizIzGL8sQUuArnebw
	PuOKBf4nisLRCgaQaRHF+JZeDzxE4UH6RsIrM08iVwMvaMcXI4W4Forh8a+G7lKG
	GOB8yS6jeqlD7ek0++I+j8Ef66ODn69xDD6hZgjPoLdiqPGgRPQe4+KpMLEpoBB2
	LFHG4hwi8z+VEMtRT+mp2vuw5+trUvI3zk205ITEHXuZvkyTv/I4qjm47MGjRbvV
	RXhANGJebNrLyU9Z8cCAw==
X-ME-Sender: <xms:Rc--Z-5Yeuhq8HRPobz3V62RAAXnaYJOBDVmRBBIqmfSbIhyFjIP2A>
    <xme:Rc--Z37NW4-YAraZWmll2BiJ-2CfKP_vyShPatSigbIouFuohtoDqDtULuNAnxlW6
    GdWAzeSzEwxxQ3ZeA>
X-ME-Received: <xmr:Rc--Z9cKPjCWuveXsu_LS7HGPJRqkitXo0WNJ0dpRXrkNG0V01cZ5EKGW3qN_ld7F1Mjg5FvhN_oiSoRi38LMAbyNuEpNk0-7JhoW5ERCmQcaHG9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhm
X-ME-Proxy: <xmx:Rc--Z7IzP_1u-npYYpm22aSDqZOIpo-WYrzlKcWEcuenW9wRqnKQEg>
    <xmx:Rc--ZyKzttzbV-Y3GkEj-YTnIVXfbW_uuCMaaGioJ6xxHzK7CWrHJQ>
    <xmx:Rc--Z8xt-T7Rjzo1DdTFCIpUadt9QeubM3fiUzwMFZ7__h66KsTNvA>
    <xmx:Rc--Z2KZhnvdnklbc_N1Nyp-SJ0wFE66NIl3QAnP9TORtGdy0ELusw>
    <xmx:Rc--Z3EyueOK73QkvufZ-VKQ-lUeFXLIFlTOXAAYs4UvlUtGY1Cw_yjh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59d4d086 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:18 +0100
Subject: [PATCH v3 08/13] meson: improve PATH handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-8-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When locating programs required for the build we give some special
treatment to Windows systems so that we know to also look up tools
provided by a Git for Windows installation. This ensures that the build
doesn't have any prerequisites other than Microsoft Visual Studio, Meson
and Git for Windows.

Consequently, some of the programs returned by `find_program()` may not
be found via PATH, but via these extra directories. But while Meson can
use these tools directly without any special treatment, any scripts that
we execute may not be able to find those programs. To help them we thus
prepend the directories of a subset of the found programs to PATH.

This doesn't make much sense though: we don't need to prepend PATH for
any program that was found via PATH, but we really only need to do so
for programs located via the extraneous Windows-specific paths. So
instead of prepending all programs paths, we really only need to prepend
the Windows-specific paths.

Adapt the code accordingly by only prepeding Windows-specific paths to
PATH, which both simplifies the code and clarifies intent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index c8df19804ae..acd6074b32d 100644
--- a/meson.build
+++ b/meson.build
@@ -198,19 +198,19 @@ endif
 
 cygpath = find_program('cygpath', dirs: program_path, required: false)
 diff = find_program('diff', dirs: program_path)
+git = find_program('git', dirs: program_path, required: false)
 shell = find_program('sh', dirs: program_path)
 tar = find_program('tar', dirs: program_path)
 
-script_environment = environment()
+# Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
-  program = find_program(tool, dirs: program_path)
-  script_environment.prepend('PATH', fs.parent(program.full_path()))
+  find_program(tool, dirs: program_path)
 endforeach
 
-git = find_program('git', dirs: program_path, required: false)
-if git.found()
-  script_environment.prepend('PATH', fs.parent(git.full_path()))
-endif
+script_environment = environment()
+foreach path : program_path
+  script_environment.prepend('PATH', path)
+endforeach
 
 if get_option('sane_tool_path') != ''
   script_environment.prepend('PATH', get_option('sane_tool_path'))

-- 
2.48.1.741.g8a9f3a5cdc.dirty

