Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C839E6EB
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477842; cv=none; b=MS8IJIKlkQ8eKa5M4A48GfDbaCDpil+yz5kVjOdTUU9ZlIfirbvvfyr9qab0k/eZHbJvn0Ly8upMX4t5TyVqv08fBN36ddgRXVV7/YldUUaLf1LB4PPq4FZNeci4Um+Z/ksBngI+A9HXwHvho7jca4xz9mEVM+sS3Qy/LAgJFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477842; c=relaxed/simple;
	bh=D0CJsW843SdWU21xXwm0R+oSpjn7TXvURHOKcJ8y3Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF5FsXerdpPo8qyEx9gGSCLllYnWXZbOqPbIqKS37oVNBipqh7yC8HKSQdIYfZOyPQEeIq6yTueVQ0FMbU0YwMJz5NtY+hadHOjqZF4OrFv/raJhZGkO/WTXjYUd2yrfbGti9OOvQ5IyC5oOQdNs1DlHt/iXgxyw7PDtCDRdnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EUZ7PpTF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4ppnEj8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EUZ7PpTF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4ppnEj8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C433EC04B3;
	Tue, 15 Sep 2026 09:10:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Sep 2026 09:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789477840; x=
	1789564240; bh=zXljf0ApW4+WHsfH0OhFBfHTrqD+0qWxRpTyyJBzqug=; b=E
	UZ7PpTF1bYZIByX/wXzPgZGi0dQjXAJRJ8cT+Bc6tD3TRC8/OHrr8B7sTsneeMdz
	pzy+ocOHQAjd5/DYnWQkw5AHel2E9m22t28iqqgmH1cbuaHjNLzgM6UP3I3yQa6e
	lxnB3t7NivX2BA4jUv9pDQzr4s+M6+B7pXVi8BXjPjaBFjoa9fl0V5f1qBTeoUu/
	pI1j2CtcZ4AWPyB1714IvIGVLPYH/d3jOBp9mkdxrKnZIal0UhoLezu9UBdNDFci
	91jD9Bdm4IqwlK25JTXHISDvf99nLWZ62zeHV2nJmypVXASTBwry1NawFX9M9/2f
	6UpC6xKlFDTvyPytbrf2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789477840; x=1789564240; bh=z
	Xljf0ApW4+WHsfH0OhFBfHTrqD+0qWxRpTyyJBzqug=; b=c4ppnEj8esct7T6PK
	BYxfnEAbparhHF3FETyD/3Uc2nnyT43Fh9CT6d7wUklKP4Mt2zFvtZacuhq73i6v
	STMCXPhJa37uQFKeLzaleXCF8rkm5lprLaBEDghNPfduIurGjKZFjNeC+L6d5pQs
	3KUPJeM3EjSrF27lA6N57AggHU++5cxDXdZAcIkJoomFy2LQYlT5wmf5ZuE35RB/
	08w77+27CAGLPOeD6JEooP6G4Q0sUXu0Anw1JpzCGN9uQZrJ9NIFXqChDasvhnm0
	lmjkaMKCuRemWzZxM+7aQtGB3GrZCwRFMg0fv2Wbg/1DmZwVpASKXWQH1TSdXNQt
	mG70w==
X-ME-Sender: <xms:0EOpagkdpXsrgzbEYM-NI7_rj2xsD2SBIxzOxuh8fxRJlfAKVE6C1g>
    <xme:0EOpanRqgUFolTbENP0xOf7aSTyEYParItT5u5YVY8CWJDql7ide7ggQYQi_f_IMC
    l-pgfJc3deDwHsAzSXQ7DMt2odHpbt6wJfbH-o0d41SnlvsepGtAds>
X-ME-Received: <xmr:0EOpasCTLBl2w6Ry68IErV1FFRpjTnG3wApjCkBBuT_8MGF3iNQgBT7Zv5veuxxQqTH80lTsAlUQ7cwWqkYki9VAA8to_hEFWDUn8DJiDdFvUtkjcHK4fzI-tpqiM1aN7C0G332yoFVG9y5w>
X-ME-Proxy-Cause: dmFkZTGaL/lTLcRn1DJsnPWw44q0NNKOzA5ar1GEYzN4sNiu+Tn1DLpDhZloNx9XKLPG5F
    FwL6eWhbw2UwZDvX2hzDSZT8MmuRDmlR88/Qh0x8eXqR2VtB9AvTeVLGn2Sn1mKOhy97BI
    3M/XeQSuR98fAH1WgT61U7Oo0gmhwbPuxzqSOz/JVTYkz2AIAWBp6IxM0YI67GEsswwO+c
    OQmvlMudtthr/sna93fGII5fkeXCVdiJpYT1bmq8uVz55AzULtYXk7l/cSKIVhPwp7f5gr
    oAYLc7DW1GG4K0ll1laI3EHX3y1VkOFsKRGxGWpYqsEW8RWjQswEznrhGgj8JaTACOSxH7
    cj0aDaR3ErcFfr3+BYN5YglV3tgw4Y0dm8ndOJMsTSP5O3TOXb7AfsCNdW0GtKC4QMgBz2
    fWPenVdOHSZy31NSYM8KmdSIkSgda3RPyi8MxmpcpsFE16KEwQ3dUFdp9NutVD3U/azatD
    i+TklSSgIMkEMJthVz9Mcvl2KgF89K6nPLP2hjsJFS5aNraKvNyuIy2hYCmPxSJvx+/n0E
    rLfFYoBoh9okxWFWaRp4NPj0kkrTGIZo2G8EiMJq7FeRpfXYm7N3QVZZ2CwAgXj1ZZ7Ng3
    7V6wzJrnzMfVL+n8mHDofyMxjXmUIq4zBq/J6ghb0EQh5i/l/l/JOQRErSaw
X-ME-Proxy: <xmx:0EOpamTsg2JA3xds_4GXDWOy1G2lgLLOFk_yMQc0wIFA4umoTvYxUA>
    <xmx:0EOpair6HoeKbQ6rIlOKuYdXb7XwIo7JqZHq2uiiPXvOWMdmBhcBQw>
    <xmx:0EOpagzBO3IEQCedEiuzRqGoPLB8JJofeOVTrasANUBdFFkdg5-ICw>
    <xmx:0EOpavIDxR_3tdl7MU5kfNBxCbgC7Nubie_BKa58POf7VolW3O9eMQ>
    <xmx:0EOpag4wKSkYg9vpRfFRa-FFLcPnyCNgDObgSmbD4QwGMt0fvjgtYQZp>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 09:10:39 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: [PATCH v3 1/2] doc/pack-refs: convert synopsis and options to new style
Date: Tue, 15 Sep 2026 09:10:31 -0400
Message-ID: <20260915131036.393249-2-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace [verse] with [synopsis] in the SYNOPSIS block and remove
single-quote formatting from the command name.

Backtick-quote all option terms in the OPTIONS section via the included
pack-refs-options.adoc and convert the standalone placeholder _<branch>_
in prose.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-pack-refs.adoc     |  8 ++++----
 Documentation/pack-refs-options.adoc | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index fde9f2f294..69e018d07e 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -7,8 +7,8 @@ git-pack-refs - Pack heads and tags for efficient repository access
 
 SYNOPSIS
 --------
-[verse]
-'git pack-refs' [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
+[synopsis]
+git pack-refs [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 
 DESCRIPTION
 -----------
@@ -52,8 +52,8 @@ BUGS
 ----
 
 Older documentation written before the packed-refs mechanism was
-introduced may still say things like ".git/refs/heads/<branch> file
-exists" when it means "branch <branch> exists".
+introduced may still say things like ".git/refs/heads/_<branch>_ file
+exists" when it means "branch _<branch>_ exists".
 
 
 GIT
diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
index 0b11282941..2263648b39 100644
--- a/Documentation/pack-refs-options.adoc
+++ b/Documentation/pack-refs-options.adoc
@@ -1,4 +1,4 @@
---all::
+`--all`::
 
 The command by default packs all tags and refs that are already
 packed, and leaves other refs
@@ -8,12 +8,12 @@ This option causes all refs to be packed as well, with the exception
 of hidden refs, broken refs, and symbolic refs. Useful for a repository
 with many branches of historical interests.
 
---no-prune::
+`--no-prune`::
 
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
 
---auto::
+`--auto`::
 
 Pack refs as needed depending on the current state of the ref database. The
 behavior depends on the ref format used by the repository and may change in the
@@ -29,7 +29,7 @@ future.
 	  maintains the property that N is at least twice as big as N+1. Only
 	  tables that violate this property are compacted.
 
---include <pattern>::
+`--include <pattern>`::
 
 Pack refs based on a `glob(7)` pattern. Repetitions of this option
 accumulate inclusion patterns. If a ref is both included in `--include` and
@@ -38,7 +38,7 @@ tags from being included by default. Symbolic refs and broken refs will never
 be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
 and reset the list of patterns.
 
---exclude <pattern>::
+`--exclude <pattern>`::
 
 Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
 accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
-- 
2.56.0.rc0

