Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41F2DF152
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012716; cv=none; b=dTuK095XLtfPHka6g/GpZaoF8UhATT4sfF0uBXls5Lk6DsAnec0GEAYP5esCV9PVzmE/QR2LFe8gSk6pWAzCz5rUPQSlRxULIKD/Tg60Bux1vDV0e72KM+B+ZK0Wwd1q/voQSIl3Dsbh/5//xe7giylw/iWdwWS4e+Be/TawVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012716; c=relaxed/simple;
	bh=+G+JDt6/DhHf993nMZioBRHZoRsTKZO5vIPoK1JROOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dV+hgHNm/kz5uVcprPeGmB5KfgScwglpPc9mxdRGcYR/4sc4Zx7lcRo5yc84S1kRoFWAFcOJm1ug7/Lztpkj1HcJTACRKHflO/iyzCQDi3aWdhw9V0VQAVHOCoV+sbbjyy8F7gwv/y0M9u8ZBRE9E+dc+W6asReCdSj4NEctbvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0It9kgM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0It9kgM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so7374195e9.2
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012713; x=1760617513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsDN9dD7V9W7gffuwBgGs7265Z/PkwzZsW23KxAdU88=;
        b=f0It9kgMiE05K4xFzJEKeui0Ksz6ugMSgnvQigqVZKKEygJQM+8HaNw1jbIUMhBgv3
         N+8TPk8UBISlvTBcso38Nzf5tEoaRD7+TntXfc00ThuUkxcO35Tiv6tJxI1rQWBToB8y
         gKvyfExkWhyx+mdIMHGuvGsDsbdFOoilMXNH+DskFa3EKiZOxt0tzc/jElJ4FSb4sY9B
         6CRXSOKkxLM2vXUASkQMQsUxddGxKpedR/2duPefA5pZ9z5A4CMSDWJdjhoS+fNpVTFX
         ooItpL9EEvxJ/NXE3l6v4n08dRltnyntW49Wq0QaQkYuqnlpDS2gyZQlq6RFAPw/lgff
         ezLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012713; x=1760617513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsDN9dD7V9W7gffuwBgGs7265Z/PkwzZsW23KxAdU88=;
        b=et1rTMXrkrGfN8SOUPk7EOR4xhwWbUQxIHkLeTwuc4v0H++Qmri0xNmr0qC4Ut4DC/
         BVLuKtc2ILaHrOx+fGMqQfJ7l05FLuraHOgMzedhzE7IhFOkDBchj6Ewsj/tT/daWIMl
         x3xxco/4oQP1qWJxsk4nUkKHbrBaZJ07l6jSK7d1U0Gq7KjtxDsq1/jkBQNpw5ae1C0n
         tiB70ze7M3T4h7iRhZisHtBG2rVVodMJfeAqt+KR5C2kkEsSUvfdJTY8hZQ2m2XQ3Fzk
         SWovgunEwvO1cc1pi/h0UWa5ZS0QiROoUQF/VQFfrP+dR0GyTP9I4j3/V5gYrlJnF7Hc
         DL8g==
X-Gm-Message-State: AOJu0YzzX1AnIUlNYdQhhWOFpm+XnzJWJKzpzyZsPpvz5Mn1aSI4ZnpB
	hdNUV+4mOyhGJCTUxeoQMYz42WcvQ9+WnlWDUwPgICd9HrnS2dpORY2MOSHAB+JV
X-Gm-Gg: ASbGncuUQQjHjqNWV/4qJvlmzw6DkMJady/nIMYEq2d2WzKy4CCtTB73AzM6f6A+QPP
	/DJhEIdsIRbCXuVeqRQmnRb7jZYrFMBWQWPtY9aOe8kP/JheA38/349Fnsce1A7EjqZQ/Zn4vju
	WXoUh+Ua45JvcZ1RdeNCqG3kCXcr3SRWztvOQ3SHG+tXqNNaPhM97UYj8JuiRfhuZYGolw8rGtC
	zPKOHtMkCe+5NFQB6q0857je6xsoX/zdIbNhRQO/66dJwIU/SX3AxMQSisa8ycQC0Gf6G74bVqj
	0QZu0n8hcoMH4essSejV9ohFg0+BCDCBXictyQvN82WAkwuO71rJz6ziiMie3vQ2RNlT9+FdsMa
	avK5H0tjNlmRqoyEweIOk2V49Rm+iJSfOd36FiiKSty8W2V2WKxQXFNPjx/x0KI+GuzVHzPXJJs
	viO274rvvP
X-Google-Smtp-Source: AGHT+IEmGvNVUrfYH+tnnDDi8Fe9xxjG/JZla+BQRXsQCMnW8b3ec7VI9bhC7M1/lm5+iUHaLvSJCQ==
X-Received: by 2002:a05:600c:1394:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-46fa9b1706amr48042025e9.33.1760012712650;
        Thu, 09 Oct 2025 05:25:12 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm84831475e9.7.2025.10.09.05.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:25:12 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/5] doc: git-tag: stop focusing on GPG signed tags
Date: Thu,  9 Oct 2025 14:24:53 +0200
Message-ID: <20251009122457.1273701-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251009122457.1273701-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like the documentation of `git tag` is focused a bit too
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

The "CONFIGURATION" section also doesn't talk about how to configure
the command to work with X.509 and SSH signatures.

Let's rework all that to make sure users have a more accurate and
balanced view of what the command can do.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-tag.adoc | 48 ++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
index a4b1c0ec05..3519e5b9b2 100644
--- a/Documentation/git-tag.adoc
+++ b/Documentation/git-tag.adoc
@@ -3,7 +3,7 @@ git-tag(1)
 
 NAME
 ----
-git-tag - Create, list, delete or verify a tag object signed with GPG
+git-tag - Create, list, delete or verify tags
 
 
 SYNOPSIS
@@ -38,15 +38,17 @@ and `-a`, `-s`, and `-u <key-id>` are absent, `-a` is implied.
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
+tagging message, and an optional cryptographic signature. Whereas a
 "lightweight" tag is simply a name for an object (usually a commit
 object).
 
@@ -64,10 +66,12 @@ OPTIONS
 
 -s::
 --sign::
-	Make a GPG-signed tag, using the default e-mail address's key.
-	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
-	configuration variable if it exists, or disabled otherwise.
-	See linkgit:git-config[1].
+	Make a cryptographically signed tag, using the default signing
+	key. The signing backend used depends on the `gpg.format`
+	configuration variable. The default key is determined by the
+	backend. For GPG, it's based on the committer's email address,
+	while for SSH it may be a specific key file or agent
+	identity. See linkgit:git-config[1].
 
 --no-sign::
 	Override `tag.gpgSign` configuration variable that is
@@ -75,7 +79,10 @@ OPTIONS
 
 -u <key-id>::
 --local-user=<key-id>::
-	Make a GPG-signed tag, using the given key.
+	Make a cryptographically signed tag using the given key. The
+	format of the <key-id> and the backend used depend on the
+	`gpg.format` configuration variable. See
+	linkgit:git-config[1].
 
 -f::
 --force::
@@ -87,7 +94,7 @@ OPTIONS
 
 -v::
 --verify::
-	Verify the GPG signature of the given tag names.
+	Verify the signature of the given tag names.
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
@@ -236,12 +243,23 @@ it in the repository configuration as follows:
 
 -------------------------------------
 [user]
-    signingKey = <gpg-key-id>
+    signingKey = <key-id>
 -------------------------------------
 
+The signing backend can be chosen via the `gpg.format` configuration
+variable, which defaults to `openpgp`. See linkgit:git-config[1]
+for a list of other supported formats.
+
+The path to the program used for each signing backend can be specified
+with the `gpg.<format>.program` configuration variable. For the
+`openpgp` backend, `gpg.program` can be used as a synonym for
+`gpg.openpgp.program`. See linkgit:git-config[1] for details.
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

