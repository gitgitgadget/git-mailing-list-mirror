Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8D43CE46
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389997; cv=none; b=cWheVD89XFXcztn3LCeWJ0Q698k3VF1nI27CjRj0Jw/OhAd0RgrQn52DJGwyGQH4ggtPW9RPR5/mFunikSLtTKwRBA3/N5pTbe1VsW1PjoT3bv3w+/fEToR7i8meyx1vHt2EBJB2shFTmXAkly3xX0qMvgEx/+b88gokByzEK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389997; c=relaxed/simple;
	bh=Vn2kdfcS4g27Z6t6OF3zehDnkD6JpiJKP0cFiHcjZpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlwIeMppfRpIrrORHdERk5Pq+1vTnPZfajzpXvwg7RlbfHhb8JYsXZ6ufKEyNqGC9KGhS86sZSX2fDziaam88Ox1U8XietIYaZZzDeVBRke7KrU4a6ARV49te8KeZL/zPM9bMZbsFeCNuK6Jm5g9z/idmeO8dRZ8N/48HjeqD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C8MM6UJl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZF5lVM+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C8MM6UJl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZF5lVM+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B59097A00C6;
	Mon, 14 Sep 2026 08:46:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 08:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789389994; x=
	1789476394; bh=CC9Bq6eg4MgsyxCGl8n9t5tddR8yjnRgU54Jxg9NAk0=; b=C
	8MM6UJldS7NY2EeZ3DdMDdtfK0GoJbHjzUGFLiNqB3b9x8UzchnYRalH74/laGVE
	rQ76vvvmtLgufSMv3zW7ZugVnoXDbbr76twMeEH10Y93WYP8/jOpMBKxitUp5CIM
	bDTjD5m9ZNMvKmS8cP+SxK4eIDAQCfs5cmbMy2TQS4vw+uOd6GpSqvKyYfkZgVtA
	kYCkT9F3i8VR1XPfNrRnPcdjJD2DBhp6RaeRK+exRvuLMDwMGyewV/ui1v7TBhzN
	Hlk2g4bSCStNrDE4Q83RH9QwiZTIueqTvwwI2JhFjP8c1Xw+5oiCem3gGKrRVVxE
	ZvXcdDupDnEdIajiD7oVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789389994; x=1789476394; bh=C
	C9Bq6eg4MgsyxCGl8n9t5tddR8yjnRgU54Jxg9NAk0=; b=GZF5lVM+HUOXZ67fj
	xHPhZzpWA7M5i1RLD31xF8y8RQtf1LpDZ5xihWqYEf4ibyyFJartSRDnFx7DxkNo
	NemNyUZcOreOUw8K59piBCVSgcD/O+aLAQQhc4SYrvOlUQhTx1vBDnN5KExGCOVM
	a33hhfegyDInCKUrEdSzZP3CCXwnsEl9SykIMu5z9kgksYKpyS6++D4ggO4xQbtt
	is5aombanFyPWDhnrJaUsUkF0NyPxF1XdRTicDyU5IJUlGzok/1VUydD7rqfhgZB
	p7NsTxcNGC6BZZgnd6mfHiURIPUmtFyX3eKcVk7SONSXg5ODSCbPuI95SiABjH0E
	f+l3A==
X-ME-Sender: <xms:quynavqNp-oBRSxEAynaWTaY03DiVcbbycB08Gi68QqQC_A5XLq8mQ>
    <xme:quynavqu8fms0LiYKeRF-TY0GiYhD3tM5O2Z0XMwY-BS8WTh2amqJ9RDz9bzArobC
    s0fWKKYLoBmubyb_5chhCrcQCOE8N_MTtVdPsQr5MZqcYXpy0Nqq0Q>
X-ME-Received: <xmr:quynap0S3d1BMd71GqBTbSRHQcRNiSxo2lJyOd2GdVLNt_ZmHYRU0F9KaHK6v-Xw5XCKO6TwsiMUqf13xNXHrPJZ9hM-0RrLsI_TwxxBX7NqKOeuADNUOC2jKN1YtmCw8MbP68r-B9sWECB9>
X-ME-Proxy-Cause: dmFkZTEy8WjatDA++yKrt3sVVFdML6iRX9Hq3w9e/dOk5Inw/5lypFtwLUkT0Sagd2OFsV
    T3FKmcjqMN4uhOcvw330EMtXzWqyv8CyBquxzLOMo3rvM/apP0nBVLaCFTCj6L2GZrFrQp
    jBOgqECBrItXX1u9HovTTgZEfnTq6ckuMATWjQ4LjDek7gIAvZ2Jcf2ijQD73vOvJy85yc
    WJBT8s/sSd4LKsrtrQKwicuryJ7bgv0cF9fE+ZYF570XJnKFiwVACBuMPgvIBStGo+jQpI
    CTqeVIfED9xnauAclg6Nf1m3P2sFHilqTBqbCskG/RCsm8P1v/FdFX0eJEwxVwa+TGW/T6
    ImFNEGkBoZNzhiEJ1IE9C+PWPLju56liSDvqW4bvfBJ7xUPoHvNLSo9uYpRuGi7SL4zj9k
    qnlAwKXKIzN1rdQJrbqZl+9nrkTJ7qVNmvgJr+uYkYeCOls0oZMMtb5YQLYbrOwH7PWsIt
    9+iKVlHriT9P+s9RFw/fgFbZ98WWukPGLnFiF7FOVMk+ruhCrYq3BJjptZsDaTmoEtXmde
    jhB7vlFPrUyLE2CCFubIG4XuRGwbWdZHoS5hHN63XpMAQwWhR//n3Q+BmAbvBF7rBMts2/
    1tJLEx+NZpLL/zVWDob0VEG5aySlhPb0PFlfpXTGA8ygzJwZ3KF+obXcDr/A
X-ME-Proxy: <xmx:quynauBDcIw60cILP9h5-xGLaxVzjivs79E96lYSvA2jPMrIsdwQLA>
    <xmx:quynahekDmW-aTkmsSwiybYYgi8zCpGxRGdMka2i6GxLRwAQefg3MA>
    <xmx:quynajhzdAMnb8hgUeGN9W_Pn0Rlxjd4K3AhTWQggQ4E1PBkYh8kow>
    <xmx:quynapoRTrvcWSq4YtaUCKiHaj4KsAaEk6CETL15enXxMbvZZz0l7g>
    <xmx:quynajAhTbDmfmmijGpOx-EWZHlItIwv8DB5YMAylcfGBguKqIo3zheB>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 08:46:34 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: [PATCH v2 1/2] doc/pack-refs: convert synopsis and options to new style
Date: Mon, 14 Sep 2026 08:46:27 -0400
Message-ID: <20260914124630.154107-2-tmz@pobox.com>
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

Backtick-quote all option terms in the OPTIONS section and convert
the standalone placeholder _<branch>_ in prose.

Update the included pack-refs-options.adoc to backtick-quote all
configuration key terms.

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

