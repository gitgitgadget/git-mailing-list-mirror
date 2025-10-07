Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED811239594
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840243; cv=none; b=OVbNSMtwBb8XQmlVQQWt9CGlVOXNZlBfMCOEndJJrYb19Zj+XKprO7ONdBguaK2HFiKWeChf743snKgjTuI9NyjfPZny26jgMObfJkGnZx8OfRh56LopC+pcQJZFcybpKbfl6K4x9dRLY759P+JQhsa/ioveush6tKpOJCbLt7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840243; c=relaxed/simple;
	bh=alAL0qlriwM3AW/9DSKMjrdB9q/CZnJTQXbk1L8j1mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmHvKpnWZX3hk+l0N5ryAV/SXJ0Ng54nwznQ2WqnA7ycdx66ZOEe4ojxx2gDBKYq8cQVGOlPH6VNuF0OT04z5QnX0WMjKeYEZHDb9eulB//uHVnuPvvIClf+fkOutFFEL3G6CSUHlBKpadBtNRhyoamy0nXePI7yFPNRZBUnqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxU1BJox; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxU1BJox"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so66961315e9.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759840240; x=1760445040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq6sj0trHR7w/2w0ljzCDQ4msjqlTq4O1b/dmJnodJQ=;
        b=AxU1BJoxYTI9vogI6Wdxd+XlI8BOcqf9EbmW7uYy8t9J3S6Wt2Tx6ExWl0SogoW259
         Aj6Hia7GSqfsHDTrO+yYhxg93vDNbJf8rLh/Icc2pnS4EEvpcny5Ht2BqqXDnkhPVFT4
         6ybb+D5fgnWnRIVUGpNWEY5DtClZSwd9aA7p681eCafXzHDTGgVj7Chx2F5dYbwTLXOn
         5Aas8yk5Ul72LhkLzOjFeFz2b1YVBnL8W/tIUmX6Mn/mTnGsXKKhcUfsc+DvDtYs+I1y
         hHt+aplL6LFizSal33Uyu66TSXj4zjxlNmsz/JGvZIFh+/mJno2Bxl1cWH7kzUujU8ql
         VBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840240; x=1760445040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq6sj0trHR7w/2w0ljzCDQ4msjqlTq4O1b/dmJnodJQ=;
        b=BvGQZJRe3oYOXoxoXJgpF8GmuJoSbkK7Okn6+0ITvDmm7Kzol9/RttesLJXGJcY8TO
         6RDOf0ChpizQ7KyUSbTdEk6j1fvBPpID4X3EU25rbwHZLHyXTq7191RZVAU5vV3CPFTa
         rViriPdCSgfbmqUoU9hJZaHmJonGJUBAE9KQO/5afxYsUcPAWvUxDSSY+wNqH7jkJgJU
         UbPvttZ3xkq9opyv9MfKTf1N+gMRJY2UXjgLYPyqVZA2tZMopDm1zmefif/HF5b1i/P7
         khuq3grC/dH2WTCH5YRq6uu65KHliWD4+ERDflCQ2xtarSOBgc2OWBnmu+7sjj5dIVFk
         3+oQ==
X-Gm-Message-State: AOJu0Ywm4dlB7MZrAVkds67NSAxCxSjE5W/eD4clPwiPpfeq8IkZJiT4
	TKfcfJnW5Gb3rlDOXs5wyyJRVGwI6Gps6R0g+pL4H5JTCUK0wl0/B0HXNM+tMRX9
X-Gm-Gg: ASbGncu7wr927eHeOSqRhZQmeTvKmqnB/Hr3JY433sODTHEC1Rw7TP7Vc/FCGJAO7I8
	0XokZnyvxf1L/exbo9vUiJJGZi3uMerr19kr4QItUGzjVumOT/3xjO4BMMA+knPghJGqDC6SUzZ
	T8XHPkIWYrxZnqCtfzukxlZat3u88UODsvR1aX9iY2CnefF2FSEgA/KwwAJNoTG4Q7OtgHCg65O
	58BY29Zeu5I40VrMJ0/S3xO0qnpE9wvHnvKoiMGfcnG27TvlV65jwnrkDeCTobke6lY9OsytqT0
	Acg3CE8OUjbLZhSck1ZjrJIC7VnC38aFMAO6qKbgEpo2XdVcXNASNgC07VjICRTu1k1u1qIxIFP
	/GtYMbrgIRMpr1tFAfkyTc+UcH61MRuUrUh3QcsaBT1ICQaJ5sF9fkjy3/ZN9xd11OdC1nS9Egw
	==
X-Google-Smtp-Source: AGHT+IFZwMNGeHc3G9gIS6GmX/1nM1fP8LCX3SKrI2HgY/cIiMkXOFTOpCf7CT6Ol321Ji3rGKaTCg==
X-Received: by 2002:a05:600c:6208:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46e711535dbmr104974795e9.27.1759840239602;
        Tue, 07 Oct 2025 05:30:39 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm25476185f8f.43.2025.10.07.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:30:37 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] doc: git-tag: stop focussing on GPG signed tags
Date: Tue,  7 Oct 2025 14:29:54 +0200
Message-ID: <20251007122958.1089680-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251007122958.1089680-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like the documentation of `git tag` is focussed a bit too
much on GPG signed tags.

This starts with the "NAME" section where the command is described
with:

"Create, list, delete or verify a tag object signed with GPG"

while for example `git branch` is described with simply:

"List, create, or delete branches"

This could give the false impression that `git tag` only works with
tag objects, not with lightweight tags, and that tag objects are
always GPG signed.

In the "DESCRIPTION" section, it looks like only "GnuPG signed tag
objects" can be created by the `-s` and `-u <key-id>` options, and it
seems `gpg.program` can only specify a "custom GnuPG binary".

This goes on in the "OPTIONS" section too, especially about the `-s`
and `-u <key-id>` options.

The "CONFIGURATION" also doesn't talk about how to configure the
command to work with X.509 and SSH signatures.

Let's rework all that to make sure users have a more accurate and
balanced view of what the command can do.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-tag.adoc | 52 +++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
index a4b1c0ec05..9117754ffb 100644
--- a/Documentation/git-tag.adoc
+++ b/Documentation/git-tag.adoc
@@ -3,7 +3,7 @@ git-tag(1)
 
 NAME
 ----
-git-tag - Create, list, delete or verify a tag object signed with GPG
+git-tag - Create, list, delete or verify tags
 
 
 SYNOPSIS
@@ -38,17 +38,18 @@ and `-a`, `-s`, and `-u <key-id>` are absent, `-a` is implied.
 Otherwise, a tag reference that points directly at the given object
 (i.e., a lightweight tag) is created.
 
-A GnuPG signed tag object will be created when `-s` or `-u
-<key-id>` is used.  When `-u <key-id>` is not used, the
-committer identity for the current user is used to find the
-GnuPG key for signing. 	The configuration variable `gpg.program`
-is used to specify custom GnuPG binary.
+A cryptographically signed tag object will be created when `-s` or
+`-u <key-id>` is used. The signing backend (GPG, X.509, SSH, etc.) is
+controlled by the `gpg.format` configuration variable, defaulting to
+OpenPGP. When `-u <key-id>` is not used, the committer identity for
+the current user is used to find the key for signing. The
+configuration variable `gpg.program` is used to specify a custom
+signing binary.
 
 Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
 tags; they contain a creation date, the tagger name and e-mail, a
-tagging message, and an optional GnuPG signature. Whereas a
-"lightweight" tag is simply a name for an object (usually a commit
-object).
+tagging message, and an optional signature. Whereas a "lightweight"
+tag is simply a name for an object (usually a commit object).
 
 Annotated tags are meant for release while lightweight tags are meant
 for private or temporary object labels. For this reason, some git
@@ -64,10 +65,12 @@ OPTIONS
 
 -s::
 --sign::
-	Make a GPG-signed tag, using the default e-mail address's key.
-	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
-	configuration variable if it exists, or disabled otherwise.
-	See linkgit:git-config[1].
+	Make a signed tag, using the default signing key. The signing
+	backend used depends on the `gpg.format` configuration
+	variable. The default key is determined by the backend. For
+	GPG, it's based on the committer's email address, while for
+	SSH it may be a specific key file or agent identity. See
+	linkgit:git-config[1].
 
 --no-sign::
 	Override `tag.gpgSign` configuration variable that is
@@ -75,7 +78,9 @@ OPTIONS
 
 -u <key-id>::
 --local-user=<key-id>::
-	Make a GPG-signed tag, using the given key.
+	Make a signed tag using the given key. The format of the
+	<key-id> and the backend used depend on the `gpg.format`
+	configuration variable. See linkgit:git-config[1].
 
 -f::
 --force::
@@ -87,7 +92,7 @@ OPTIONS
 
 -v::
 --verify::
-	Verify the GPG signature of the given tag names.
+	Verify the signature of the given tag names.
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
@@ -236,12 +241,25 @@ it in the repository configuration as follows:
 
 -------------------------------------
 [user]
-    signingKey = <gpg-key-id>
+    signingKey = <key-id>
 -------------------------------------
 
+The signing backend is controlled by the `gpg.format` configuration
+variable, which defaults to `openpgp` for GPG signing. To sign tags
+using other technologies like X.509 or SSH, set this variable to
+`x509` or `ssh` respectively.
+
+You can also specify the path to the signing program for each
+format. The `gpg.program` variable (or its synonym
+`gpg.openpgp.program`) is used for the OpenPGP backend. For other
+backends, the configuration is `gpg.<format>.program`, for example
+`gpg.ssh.program` for SSH signing.
+
 `pager.tag` is only respected when listing tags, i.e., when `-l` is
 used or implied. The default is to use a pager.
-See linkgit:git-config[1].
+
+See linkgit:git-config[1] for more details and other configuration
+variables.
 
 DISCUSSION
 ----------
-- 
2.51.0.438.g6987fc0bae

