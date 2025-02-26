Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AD610D
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558146; cv=none; b=BUNOvFXZBNgJEpUKxSSNl5hDyztV/N4x4AeFtxxh1/qaxBckzXNiFuA4Qs2oP3Cf3AoX26SoD7L0OlTdgYEuUa1eLTQ+g0DJcsq2JqgV7uvzsYokfHMMXjbRA+afkD1GzML4ahiB9uOEonmkBLdfOzAfVHSCiouWLD+MDiSLozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558146; c=relaxed/simple;
	bh=YlpBnpmeIR6Z8JCoG+exK96Cj6R1kyIMJoq2TPWJ5fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTB8UPpjbHaOWnDSEkkGzTYjMweRwgDK3fRsjMKkVSGtuBd2T7GrKkgQ/+7HfIe+wNkwAiXyESj7GWPWeB4eKbjZORpLUW/njeqL1BSNUGvzu3Dm3wwr24ND3uBL1eZup3ia6yKtdhMtaM/JKBX2XWh5SQIm0Jcx+PQCp+GYvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fbPNWRsg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TyxvWGRP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fbPNWRsg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TyxvWGRP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D63DA1380EC0;
	Wed, 26 Feb 2025 03:22:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 03:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558143;
	 x=1740644543; bh=KfLn9AroK6CohnB+V/MFpm0q9r74UaYocgHQW5zpenA=; b=
	fbPNWRsgJGlGrQAATJ488VOZGGO4fva+ThWPonbG/5R15FZtWSs53J7xL01TRecC
	24WvkjCThPYHjrnd0+JO653DJS2wXKFwQ4Tfor/plPknuX0QC4B/O1pgswa1wHym
	NcLeI8Q8K9JGLXrDTzrtAomEB1YhlIs+mei60VEcwK1Bw6h59nfdVK0nMZy5/Bww
	oc0d/Ima1l/t2OhVu/RPw49icaJ7XI4WC5+bv4ml1P7bTdyjH/aytLvxkmU6T+ng
	pDrFVgYbhb5fmX4EIdTVtBHsKgojja0eybdvdGwyBD0thJcduoTVbv3Nb8Ee23kp
	lMiE2yrVSQGGctTpIt+jcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558143; x=
	1740644543; bh=KfLn9AroK6CohnB+V/MFpm0q9r74UaYocgHQW5zpenA=; b=T
	yxvWGRPOJvR+UZnAcCBbuYY243iBm54rkEn/8L8ojXKFpVuvFTQV2BEtliCZqDd3
	GtRftGLP2AsZhIQaOAtKnO2Ao6nKR6paCjZdItc33a4mP/Xxwcy90L8eEEemUPJV
	88qyjMBXvJ16hLBhQbvmmC8wsFTaGj3s0FCvnSuWRdUO78lZQQTatIx68aXwW5Ts
	5uLq5pjW5JTFaEyi474jiDf/wIERxw1287BueJSVexAILEPBHbMO5UqfBPKiYYIV
	1t9OaSkRyUCzY8JbiTdTN1V4H29o9+opSVbTu7alo1ksRZokT+6+EEyDDkhAft8J
	TL0rJwaDLy2n064vQYQxw==
X-ME-Sender: <xms:P8--Z-OZWLya_jFw_v_ZUrzAUQRpuXuuVrjXI3O1hnNIl645sPXTTQ>
    <xme:P8--Z8-TNctAgBASjJ725W-L9tMJzC5U7SEq3SUKgLYiMSyAFunlTbJoLt0SHXJyn
    8xOnig8bfBm7OwuxQ>
X-ME-Received: <xmr:P8--Z1RB0GQyZ2x3rXrJae-JxupA6Q91V2nopv--GlvJCuioNFW9QNj_-oi5tiSep0vRH8JYvzqdUvG8EPtsosk5Q1zylWvZIRMrZ3xalk33Wccl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:P8--Z-u0sF3J7h6iVAz2gaYw2xJyNkOvaQzfn5OFBAJjwOPMbAxx-A>
    <xmx:P8--Z2fur3U4U7FaeBW9femnRtzYAovgH7JHxwxmsMOkiBtZgYM9wg>
    <xmx:P8--Zy2o88XpIyUP-x64Mw_-8Ihs_-cR3oQWrtLsOi0hLR3tURC8hg>
    <xmx:P8--Z6-a8LMkb-DLwumhdgYdZTmqqktqOvIsJ4CGE_PCjv7iPgLixQ>
    <xmx:P8--Z14wUwPqb2XI2Uju1acTnyddP_jMaVZXoj9z6GfoUrCBoJIreqp6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5bbed647 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:11 +0100
Subject: [PATCH v3 01/13] meson: fix exec path with enabled runtime prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-1-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When the runtime prefix option is enabled, Git is built such that it
knows to locate its binaries relative to the directory a binary is being
executed from. This requires us to figure out relative paths, which is
handled in `system_prefix()` by trying to strip a couple of well-known
paths.

One of these paths, GIT_EXEC_PATH, is expected to be absolute when
runtime prefixes are enabled, but relative otherwise. And while our
Makefile gets this correctly, in Meson we always wire up the absolute
path, which may result in us not being able to find binaries.

Fix this by conditionally injecting the paths depending on whether or
not the `runtime_prefix` option is enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index dbc1dab605e..1f83dc58c24 100644
--- a/meson.build
+++ b/meson.build
@@ -691,7 +691,6 @@ libgit_c_args = [
   '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
   '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
-  '-DGIT_EXEC_PATH="' + get_option('prefix') / get_option('libexecdir') / 'git-core"',
   '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
   '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
   '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
@@ -1466,6 +1465,7 @@ endif
 if get_option('runtime_prefix')
   libgit_c_args += '-DRUNTIME_PREFIX'
   build_options_config.set('RUNTIME_PREFIX', 'true')
+  git_exec_path = get_option('libexecdir') / 'git-core'
 
   if compiler.has_header('mach-o/dyld.h')
     libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
@@ -1502,7 +1502,9 @@ if get_option('runtime_prefix')
   endif
 else
   build_options_config.set('RUNTIME_PREFIX', 'false')
+  git_exec_path = get_option('prefix') / get_option('libexecdir') / 'git-core'
 endif
+libgit_c_args += '-DGIT_EXEC_PATH="' + git_exec_path + '"'
 
 git_version_file = custom_target(
   command: [

-- 
2.48.1.741.g8a9f3a5cdc.dirty

