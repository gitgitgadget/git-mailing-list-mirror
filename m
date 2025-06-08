Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DD20E6F9
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373800; cv=none; b=sbhCyxT7/xmoIy4jhg4md67HWCqHGL7Old80mhuOPAU3Zb8rN2GfXSeJUXULTFY+mmbuSKFW0cMwwqG/4o04ISVEasKbTkdqydKQjEdQHNBVxvRc+a2/dhv1S7bmWiapESiIdz8ztcHDR0llH5uH8vkhAMlViJdDsZPxVDuH6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373800; c=relaxed/simple;
	bh=DnPFcG8yZ/guSXvPv9Zx6b6YrJ0Mp2NUplCafVVlWU4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=peVWj43M+191ktXkiz64HbJ25hXyVwnTISIPmTSY2uaAqlNJG0H2OxuIloPPu2EEow3R4eZOnipxmJPJfID6LVcDAGBh20TMC7ip97vwXUQputo6x525pjxtL5hvciQz1iBjbA2Hq+VwDXeSINmz7UnMbpcJxHd0rknR+KaKF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edVrz5n7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edVrz5n7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442ea341570so22053815e9.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373796; x=1749978596; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC797iEqmqi+rU5uImdVD2AfYEw9J5pKxM+DsNQIOxA=;
        b=edVrz5n7elQflf7PDt7LIND6O+G8NWlWwyZayOY3x1QrjadkPaIzPMXwdJ167U2jG+
         ndF/6hnUmzkD/StX4w2HhbkY1NwGtJcF6wZFNg72wIT2YH5JjK25cNY/wMXvmq9DwY0M
         +5y56bP9q3k+w1TRKzKp44E+A+8OQqnbG3RXIfD1/g2p5LZZbxOIENAZVXRE5s8ua1sz
         cL1y7ej9hxLVyfOK0+qf47DCPHPxhhpIb8SLJOFwFW1r+szll5SgRpeWZsrRA5Heoz9U
         C4H+hZOWK7s3tjKWgm//Sj3+gxffrRBok7k0dKfA8wowGkILBV/6+2V2t1OnAcLapMJc
         jKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373796; x=1749978596;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC797iEqmqi+rU5uImdVD2AfYEw9J5pKxM+DsNQIOxA=;
        b=G2YViUFVhAigMoNXtGY6lPR7IVejPLRJaDz2MRuicPaET55sNXuCYu2iTZw0XpG8+4
         rySORkyyxODSPTOB/7iEqOdzMyE5UJAtaVQVKysAyINH8EUOWi0XDE97eCZM2tWB3ZqQ
         wXPMZ9Vb2umuCSsXLYiQ1SbaGMgTSLVPXCmKBffJiwXmX6SBWLpnQKVV/N9RUs8Xzkjr
         oYNJZLo/B2f9S07EcbdJeXHZ6hvGj9oXQrDO/5QsFuU1+cdz3ohCmroFEUybZR8uIGzU
         DzY2ZWkWTCA7L8MjCyjYPPcAHzFwRPOdLikD11Ul56lH6xZF+WkYU0yNA1qa0vU6/5XL
         504g==
X-Gm-Message-State: AOJu0Yzn1sCb+Yec+1KyErT3eMe73mCFFIAwQdW1rEdGy28hAk/rHfTS
	eISo7RckApvHh4r8ZiIywb2Z4kcn4wmHTop4QpiWITWwU1tiNaKiWU8S69zCZg==
X-Gm-Gg: ASbGncuCZDXKfOjgvNEBLZi+Mf3GGroW1u1+4VF4EoBbyfni56mhGB82H3bnw2JOZIC
	1YUWtSCOTYQZ9L7uzuTyKiw9xDapMPkeBBzTmF78rdySloLqxrPILJPVedeJszXfTwG5j+akujc
	jMttxPif1rJCm7mr36QhI3516fBdsAoUG0YUvVaq4/nwyMT4+7dMHWZSGMrgpHVD/ynQ6U9wuDA
	HfdGVOixxk5ec2KW39nDLN3AnePqauQM6T1y70m6jx1HiSbRwqoLDNDkXvUWrZ7YS9EbAcy5MVb
	MdlOMEXBh6eqhFtHFf5+UtB9o3V6l1/TspiRpX4JtzA63Jwg+W2PTIKkF7h1A9A=
X-Google-Smtp-Source: AGHT+IF+c0HDPaqDqQifwG7ftnDKc668pjdQDZLJ14S/5zNu64hMXFz3VTLQOacdDe22zZsjIPd2CA==
X-Received: by 2002:a05:6000:430a:b0:3a4:ddde:13e4 with SMTP id ffacd0b85a97d-3a531cedc5cmr7204277f8f.58.1749373796109;
        Sun, 08 Jun 2025 02:09:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209bc6d3esm79848505e9.6.2025.06.08.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:55 -0700 (PDT)
Message-Id: <fa91d919fa072456ae3f69b9244f3757a493becb.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:46 +0000
Subject: [PATCH 9/9] doc: git-log: convert log config to new doc format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.
- Explain possible options in description list instead of in a paragraph.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/log.adoc | 45 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index 9003a8219143..210439f2b641 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -1,64 +1,69 @@
-log.abbrevCommit::
+`log.abbrevCommit`::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
 	override this option with `--no-abbrev-commit`.
 
-log.date::
-	Set the default date-time mode for the 'log' command.
-	Setting a value for log.date is similar to using 'git log''s
+`log.date`::
+	Set the default date-time mode for the `log` command.
+	Setting a value for log.date is similar to using `git log`'s
 	`--date` option.  See linkgit:git-log[1] for details.
 +
 If the format is set to "auto:foo" and the pager is in use, format
 "foo" will be used for the date format. Otherwise, "default" will
 be used.
 
-log.decorate::
+`log.decorate`::
 	Print out the ref names of any commits that are shown by the log
-	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
-	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
-	specified, the full ref name (including prefix) will be printed.
-	If 'auto' is specified, then if the output is going to a terminal,
-	the ref names are shown as if 'short' were given, otherwise no ref
-	names are shown. This is the same as the `--decorate` option
-	of the `git log`.
+	command. Possible values are:
++
+----
+`short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
+	`refs/remotes/` are not printed.
+`full`;; the full ref name (including prefix) are printed.
+`auto`;; if the output is going to a terminal,
+	the ref names are shown as if `short` were given, otherwise no ref
+	names are shown.
+----
++
+This is the same as the `--decorate` option of the `git log`.
 
-log.initialDecorationSet::
+`log.initialDecorationSet`::
 	By default, `git log` only shows decorations for certain known ref
 	namespaces. If 'all' is specified, then show all refs as
 	decorations.
 
-log.excludeDecoration::
+`log.excludeDecoration`::
 	Exclude the specified patterns from the log decorations. This is
 	similar to the `--decorate-refs-exclude` command-line option, but
 	the config option can be overridden by the `--decorate-refs`
 	option.
 
-log.diffMerges::
+`log.diffMerges`::
 	Set diff format to be used when `--diff-merges=on` is
 	specified, see `--diff-merges` in linkgit:git-log[1] for
 	details. Defaults to `separate`.
 
-log.follow::
+`log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
-log.graphColors::
+`log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
 	history lines in `git log --graph`.
 
-log.showRoot::
+`log.showRoot`::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
-log.showSignature::
+`log.showSignature`::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--show-signature`.
 
-log.mailmap::
+`log.mailmap`::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
 	assume `--no-use-mailmap`. True by default.
-- 
gitgitgadget
