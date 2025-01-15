Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFC1D9A6F
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972639; cv=none; b=FuixUQUXJ8K7+dvHVijBLctzwEBFTR48MZB9ezPBy6oJm77UWeeBGCKF/OtwU9g6VKpqFGrAAaFtcwGCJYlqAexbmNoG7NnWz4p3ThRR1OP1IIcyHw56ZTtyd0/M0R5j+EqbtH4xN0c2L7aRbsCsV7Gv1fOMpOHLY1uNpOUzwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972639; c=relaxed/simple;
	bh=2eBcb7RA2kvcWQcXhaD7FWqs3zKlJ0Dosw4LDoJ6jlQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=DheyIk9beintFJyFf0McegaBAUvBdLcq825/o4XLi7iMTa0q1omO7cte7Ak7XenC/kicjVo9m38RRiP6IUvReOV1992vpiUH/mftWCPyEsDs3l6r2zL2ZYN1GpFe4Xh74DpLd2/+9xwIdCiLJWEEtuMo09hf/lbgNL9gkV00sEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iriraD4I; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iriraD4I"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43622267b2eso1117865e9.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972635; x=1737577435; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bkiYjWCsNGEalujTo0xma0moIRxCzBGYwSSvnuPR14=;
        b=iriraD4IwINFS7fZThQXYyCF9+qCcc5v7ZRtouYXqSkvtkzn3w28shawxGDaVZ79oP
         Yi9Cm9doXaiPw3vFVLQu/Sy8l6ZH7lS1hNJX7WAoGCEzBjUlHmbsMrHhtH/jUtVy7gVV
         Zw9G1G6HlGRri8rjpXHi3RNfjFgclfKlF/stOwnZP8v/q+IQIDDhYfHshYvQJRFFeHoQ
         A1Dj8LeXrp0WaaAtTIjdIgJ7HnWaYt6K99unDgH+3Jp/s6EWyA3bF7D0Uq8ZLwGWSBj1
         DjluBs9bOrvk7PkJ+HvcObL10BoJq/SAt0E6cNkVY2j/Ro/5riVOVdtW4WtedAgcmZ1z
         N+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972635; x=1737577435;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bkiYjWCsNGEalujTo0xma0moIRxCzBGYwSSvnuPR14=;
        b=nNmWqJOSGN6HH71DHibXt5LwcZGSDQve7tDjQygYIAyQv7HBz5u5BhpdWbQTtyJJp1
         jxt1C/2x4omzRNmiexZ1XlGNvg96QinyrN8xzMSweK0xCMoZvVDfzd+Azf2lDxnyitz+
         SOES9fFHa8ggLQ+gj7BUcDHvTxuCh1k9zCjwlkW1QVca7Tl761n9kQ3PXzIWl3fHfJdb
         b3iTW6s8HY9kDeTrd1W8quJzpxEOtng+vfxmPr4WbVJuGvfZJQ7bYW+EmYMSlQJq+HB8
         djYIEz3eBreaOkeck9uWWfLvs372VRRROISoYC12ankr4O+I2T6q6F4z9FaNoe8PO+nC
         e9Hg==
X-Gm-Message-State: AOJu0YzY4j/HajDemlhAyi+dGfyUlXfxefR13J7GpOnev5tuLdcMmQd/
	u/+GR7UTwZAzMbjUKiGhC5SXRKuHebkSCNJARnvtKr2g2ZcuRqeuE84dLw==
X-Gm-Gg: ASbGncsVL7PJ4voSfd/z5MBIKsmc4XMEIFoJplSvLYDK4HA7u62+b9E+xfBFVgNyzU+
	ndpHKoVUdFJnfCndL3hcP8JgoB6WMShwYqAdMkua75OPPDFhe3fCNV4IEwOJMSYQwtys9nSP1nM
	IKTvYG8e65Y1IKKEP17UznOB59ELIZFdsBoqes7yeQvfWYIcV+I1xyi2+2zfQyGqs41re4xXSg6
	2UXG+r/OgysdQjfsEr7GAeoBn2zS67A2WfI2kdqVjcKHujtGIAw2weB1A==
X-Google-Smtp-Source: AGHT+IE71xHaJcrd9X7bBj63fFDxeZqRUAt3KDIVaj71ueHxhmzsKxeBgyU6NwNCRUhg6ETVDEEvMA==
X-Received: by 2002:a5d:6c6e:0:b0:388:c61d:43e0 with SMTP id ffacd0b85a97d-38a8733b9e8mr32787060f8f.48.1736972635265;
        Wed, 15 Jan 2025 12:23:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c3428sm18116145f8f.87.2025.01.15.12.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:23:54 -0800 (PST)
Message-Id: <28316a709da913c624873291d96ed5aeddc6fc90.1736972628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
	<pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 20:23:48 +0000
Subject: [PATCH v2 5/5] doc: migrate git-commit manpage secondary files to new
 format
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/i18n.txt           | 4 ++--
 Documentation/signoff-option.txt | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 3a866af4a42..baff780a7e3 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -34,7 +34,7 @@ project find it more convenient to use legacy encodings, Git
 does not forbid it.  However, there are a few things to keep in
 mind.
 
-. 'git commit' and 'git commit-tree' issue
+. `git commit` and `git commit-tree` issue
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
@@ -50,7 +50,7 @@ of `i18n.commitEncoding` in their `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
-. 'git log', 'git show', 'git blame' and friends look at the
+. `git log`, `git show`, `git blame` and friends look at the
   `encoding` header of a commit object, and try to re-code the
   log message into UTF-8 unless otherwise specified.  You can
   specify the desired output encoding with
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index d98758f3cb7..cddfb225d1d 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -1,8 +1,8 @@
 ifdef::git-commit[]
--s::
+`-s`::
 endif::git-commit[]
---signoff::
---no-signoff::
+`--signoff`::
+`--no-signoff`::
 	Add a `Signed-off-by` trailer by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project
 	to which you're committing.  For example, it may certify that
@@ -14,5 +14,5 @@ endif::git-commit[]
 	leadership of the project to which you're contributing to
 	understand how the signoffs are used in that project.
 +
-The --no-signoff option can be used to countermand an earlier --signoff
+The `--no-signoff` option can be used to countermand an earlier `--signoff`
 option on the command line.
-- 
gitgitgadget
