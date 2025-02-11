Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291D261380
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294413; cv=none; b=BPhVZQteBF7PJUCW8ByX7cfr2ws9aG0crh5e+6trpx282ezGfAsNR49DgrrHMS02ecmm+Lx0MUeeH5EAC1n7XDLHuTIj7vcfHcnsSyUB8j121++aGAFWN/6OZMnlJjVF9elyeqULvMSrcpKnaSYI4VkX8RpSTC7wE5s9pb2gQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294413; c=relaxed/simple;
	bh=1aHAWQ9c6RCIFHMfUw/qsqQ32N9w5nkMNm9XGlyBVPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mer80r6hkEhY+pQDdMKXHjnL10CTR6q+CSivIe19Zu1X57f53+SMeh+uqUbeKp3+udM6Qkw+TQQql/TllStpq/uVJfd5hgdOV39kYGlvwHlyKFqUfcrOz/zsnTaEuZyKXgTi3XLijnj6hP6psdMoubjfHbCGMjutjF+B4EWJ/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mng8oRbH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0cbRZ15V; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mng8oRbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0cbRZ15V"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27CA71140196;
	Tue, 11 Feb 2025 12:20:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 11 Feb 2025 12:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1739294409; x=1739380809; bh=GmTkGrvESCULxATui0eBJAix4i8pSpRg
	dnywDXtx3Vc=; b=mng8oRbHrpD42hMcdZojwoZTMPmxsdXWc7J40ZlHPIzhvkOR
	9D63dWrGfcyEXcb5XrNwCCyxdB+f8Y0DUinBxHhXM04u7puV0E7txQaTIzaIKKHq
	pkqsRyBL5yN2k83I2fvNlN+hpV90Gznkbh+lJHDIG9Q86rMeUNPhgVXA3iuYkX8f
	eo17ffbC0feCGGa8Y+JFY4Lii8MfjMSBzQO+oVi9VKjhnk3Ds8DdruTI6lxadp1v
	oQraaSS/hCDZcf6veC1NQk+UECT+SeOhISXW7VgOUmXdFPJ6cXsLxFXxTKHfQnNh
	E7FQIpc85xb0AhXWKStEolv2Ao1McDsCuSwyOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739294409; x=
	1739380809; bh=GmTkGrvESCULxATui0eBJAix4i8pSpRgdnywDXtx3Vc=; b=0
	cbRZ15VEoT/ZTWrBAVly30HTGa7zD52msBqlUy5quWVnb6PGBZZe/kz79KLGfpvc
	OjyAsJb9+thSpmb5vmhxuGa+4L0XiXCHMq/J3CMrBdi7/zFWE2CwWGeFNpGO4Bjn
	ZoSsSbYjo/C2ffcckGPGCNJpU/HebMv/7kQTfx+PSGARBdEiRvGTGYczzHpyrvOQ
	k8xQIIPFIjPwrgyADdlQFd3uA+D/Zf2TmwF83OpdH9EDFu4XubZjqNNPun5BBGJc
	AOWtyaiD5K6FS61nGyd3kpMtDUL3rft51tn9KyQoI6FPeJBvLZyBn3odeVRCp51K
	BABIBTNOLV/f48m4rfdYw==
X-ME-Sender: <xms:yIarZwB0oMdvqqsAkgCHcZsxjnF3QBEUvG0-69t68cQ4kzpKwH3TIw>
    <xme:yIarZyiAf1-fBGQivS7XxwKq9LKSMrTJbnynJeDP5kIpsJPXydveuIDo0_aHGcB5v
    yrx5JJ4F0UOt41WBw>
X-ME-Received: <xmr:yIarZznZrQKtcCKZowIYgzPAYe-oyMein4CJxMJVnS_VzRWJHUIS7cftTs02JSdqJ9boLZBcyYus2oAdvPqyuYwRl8PvSI_ueb1m4E8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepjefhgf
    efvdekfedthfejgeffieevieeifeegueeihfejleeufeffjeetkeffffejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehinh
    htvghlfhigsehinhhtvghlfhigrdhnrghmvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yIarZ2wfnkj1q9w9PE2GiT4byjVxGvpRg9uVU_AA0dCUheEA6FPqbg>
    <xmx:yIarZ1QtYtd-H2ZDa755m_fWGZqRdnbZWgH-Rapr4NeUkVdYOqIC2g>
    <xmx:yIarZxZh3Qvv-Aldw-w7Q3754bOYDu35U09oUUKmzEd9JZHSTYXLGA>
    <xmx:yIarZ-SrYfmQzQkLnEEibzu4K8ckq0xmq9yqEqa3ThqCt85Xx1_8RQ>
    <xmx:yYarZzNTP5hrnaPRdmhcQ3d1O6CmS9UDHbrTJMTeQaFsJUcIjTpAPXxJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 12:20:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
    Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] doc: centrally document various ways spell `true` and `false`
Date: Tue, 11 Feb 2025 09:20:07 -0800
Message-ID: <xmqqy0ycz9dk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We do not seem to centrally document exhaustively ways to spell
Boolean values.

The description in the Environment Variables of git(1) section
assumes that the reader is already familiar with how "Boolean valued
configuration variables" are specified, without referring to
anything, so there is no way for the readers to find out more.

The description of `bool` in the section on "--type
<type>" in "git config --help" might be the place to do so, but it
is not telling us all that much.

The description of Boolean valued placeholders in the pretty formats
section of "git log --help" enumerates the possible values with "etc."
implying there may be other synonyms; shrink the list of samples and
instead refer to the canonical and authoritative source of truth, which
now is git-config(1).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Noticed while writing <xmqqfrkk1l4i.fsf@gitster.g>, a review for
   <bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name>

 Cc'ed Taylor, as the author of fb0dc3ba (builtin/config.c: support
 `--type=<type>` as preferred alias for `--<type>`, 2018-04-18) this
 patch butchers.

 Documentation/git-config.txt     | 4 +++-
 Documentation/git.txt            | 5 +++--
 Documentation/pretty-formats.txt | 8 ++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git c/Documentation/git-config.txt w/Documentation/git-config.txt
index 3e420177c1..76042581ec 100644
--- c/Documentation/git-config.txt
+++ w/Documentation/git-config.txt
@@ -213,7 +213,9 @@ See also <<FILES>>.
 +
 Valid `<type>`'s include:
 +
-- 'bool': canonicalize values as either "true" or "false".
+- 'bool': canonicalize values `true`, `yes`,`on`, and positive
+  numbers as "true", and values `false`, `no`, `off` and `0` as
+  "false".
 - 'int': canonicalize values as simple decimal numbers. An optional suffix of
   'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
   1073741824 upon input.
diff --git c/Documentation/git.txt w/Documentation/git.txt
index e89a91dd0d..c029a297db 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -472,8 +472,9 @@ Environment Variables
 ---------------------
 Various Git commands pay attention to environment variables and change
 their behavior.  The environment variables marked as "Boolean" take
-their values the same way as Boolean valued configuration variables, e.g.
-"true", "yes", "on" and positive numbers are taken as "yes".
+their values the same way as Boolean valued configuration variables, i.e.,
+"true", "yes", "on" and positive numbers are taken as "yes", while "false",
+"no", "off", and "0" are taken as "no".
 
 Here are the variables:
 
diff --git c/Documentation/pretty-formats.txt w/Documentation/pretty-formats.txt
index 8ee940b6a4..07475de8c3 100644
--- c/Documentation/pretty-formats.txt
+++ w/Documentation/pretty-formats.txt
@@ -339,10 +339,10 @@ insert an empty string unless we are traversing reflog entries (e.g., by
 decoration format if `--decorate` was not already provided on the command
 line.
 
-The boolean options accept an optional value `[=<bool-value>]`. The values
-`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
-sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
-option is given with no value, it's enabled.
+The boolean options accept an optional value `[=<bool-value>]`. The
+values taken by `--type=bool` git-config[1], like `yes` and `off`,
+are all accepted.  Giving a boolean option without `=<value>` is
+equivalent to giving it with `=true`.
 
 If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
