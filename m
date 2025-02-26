Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CC22422D
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558152; cv=none; b=bfhNhEo4nPP13mReUPHm4VlsntOjgvlbwzugZ/GeFfJ3OX0g292NgoFtIDdioZKr+YmKSA7n6p313Wris26O8dJ4+hweLYzLSunivGnm3RhWZaMOYncDOYL6I4qXbpzCLR6d7R8gHOafhyXNjSP8RIsJmsD4D3StwweYG4O2fEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558152; c=relaxed/simple;
	bh=l0JfGCgysPnwb9WEjz8ksarcYX6MoxZEHd2Md1lXCxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnLPaGtNiuJsXHpopJ9ZP5jNRDLqx8M5e4Ktt2QkjEV9XFhN6Od3CUcwHlYJgxceAmV6DGoYMsDGLjXxUVnhnYPsmLHtOaCLx398nO3DM/xMRUqJU0zRq6oK1DkReZi4hw+E0KMuZWt1VqThiWJtEcB5BSs095G79fXg/PHgj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SAeF/fG2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOdIwaT2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SAeF/fG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOdIwaT2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7601A13809BE;
	Wed, 26 Feb 2025 03:22:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 03:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558150;
	 x=1740644550; bh=OMROB30hlwCPumhd8bLa08e7HVBlOAAz9vhS5XTJI5o=; b=
	SAeF/fG2QfldK5s9capp84s7pnAFa7qQVUEbmJtrNCPg4LpDElaIiyTidTm4pDkg
	lPjNL6j4/yJLmedojILro7PU5Z5yOEgYibYpH06TOFG4+zzwC53loxUXW0VLBzKo
	ONyvuMTBnQkTEfUGGmEWw70pBAtoHj8pjV4CDJcLkKA5mif47fHY35lJf/uKlg4F
	JwVa3pk6d/Ne1XPSq2DjvB7Jqt9f7s/NzRtUmvrLMNkGqoDuoW6g18SI1/LZRxqS
	37YVVKvRs5LBQ2oHDP6InygluEbO1CDQCZV49szIX9NhzML9+whHpQ4kTGUWhzLi
	PuNB53LZ0BDpLLzP7OZsUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558150; x=
	1740644550; bh=OMROB30hlwCPumhd8bLa08e7HVBlOAAz9vhS5XTJI5o=; b=L
	OdIwaT2MRXWe4SMXWehwpLojSfhVcLHIPmWPvK/MoXoeXQ9Z1hU6tClnBe4YU37N
	c8W/1DWtspF+f/ayN+Paih9na/VdVeZPAxcxyDEkSDhsifmYJ1toDkJNthK0kco0
	xL0tARGxssDYgRfApB/r6X2K6xEVrLsgGmbKxK7wkdkIXWiErSa0EKAzabFZsKRx
	vKazQTu2tkyZEmfys2ggAni3Ac8D8Q9NLxdFWBigtJp4lvbzinbjYHQH58rSfx1a
	JGSypvDaPCtkdmwjfdDawoEJO5zFhBRVA2xagmHpQXfIqhq1+FV/uM4JIGJurHK/
	Io6H5RGINjSjAMlGag1ag==
X-ME-Sender: <xms:Rs--ZwnqdOKY84jtOFfH9imO8d5nj_UfywHSAawcieuKdWEPDMXGvA>
    <xme:Rs--Z_3XTUwJ8ktcE3vzMpR_WVyZyR1SGvoy-NIzpUqnmXI6J6lwfWM1rYUdhkeql
    f4iIgFXA3ynCkTUzw>
X-ME-Received: <xmr:Rs--Z-qczucLSrS6c6R43E8rAq8Jlz2quJ9yx_LaL0wkLIDOtdDUi2E_8eWdY9dEvIFWwx2LGDerlZrAya5MzWMyBhkLtEKntvxvrdXxQAJCXxC3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhm
X-ME-Proxy: <xmx:Rs--Z8l3jiwIWIP-2ICE3rAzhvqS_FQ3ShsfFzXbBS4HhG4QMdpLnw>
    <xmx:Rs--Z-1a1-_Zp2TdbJAqRKBovFueMhqIwgfWabHZmUoZooRCYVuLHw>
    <xmx:Rs--ZztBxXPwzlJA1oZs3Tkoj-kSko45ZCRMiksjJLNmkzNbNThubA>
    <xmx:Rs--Z6VZmUKGztNEmsOEvBmEwfOaTFYFuUM9aDzr5SAcaodLKBFjuQ>
    <xmx:Rs--ZxSYPJkIsnE43E90bLeZhLOeC0YXSQtRiOYhKa740yHsz0K9oKjk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e8ef56f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:20 +0100
Subject: [PATCH v3 10/13] meson: prevent finding sed(1) in a loop
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-10-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We're searching for the sed(1) executable in a loop, which will make us
try to find it multiple times. Starting with the preceding commit we
already declare a variable for that program in the top-level build file.
Use it so that we only need to search for the program once.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/howto/meson.build | 2 +-
 meson.build                     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
index c023c104161..92a08b13eed 100644
--- a/Documentation/howto/meson.build
+++ b/Documentation/howto/meson.build
@@ -41,7 +41,7 @@ custom_target(
 foreach howto : howto_sources
   howto_stripped = custom_target(
     command: [
-      find_program('sed'),
+      sed,
       '-e',
       '1,/^$/d',
       '@INPUT@',
diff --git a/meson.build b/meson.build
index ed857aaa4ab..5bf6a914ead 100644
--- a/meson.build
+++ b/meson.build
@@ -201,11 +201,12 @@ endif
 cygpath = find_program('cygpath', dirs: program_path, required: false)
 diff = find_program('diff', dirs: program_path)
 git = find_program('git', dirs: program_path, required: false)
+sed = find_program('sed', dirs: program_path)
 shell = find_program('sh', dirs: program_path)
 tar = find_program('tar', dirs: program_path)
 
 # Sanity-check that programs required for the build exist.
-foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
+foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
   find_program(tool, dirs: program_path)
 endforeach
 

-- 
2.48.1.741.g8a9f3a5cdc.dirty

