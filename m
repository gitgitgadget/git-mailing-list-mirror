Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A12FB09B
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345360; cv=none; b=d638EFGN4Og5stVbRmMXpgl0aSziY7j+H86FbJgHlNQ5CaTgy7xPlF832z7qLHLaJYscIOWWFf89H7HIaVp6l1ludU3eOK6S81Lv7b6xcffbi/FNUmx3HMuP/P5JxkFDf3UBqje3sP0RJ+s1baws/kSHBgHkAAruqTFY1kVy3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345360; c=relaxed/simple;
	bh=n2Nw/QaI752DFSmIcDC96UIt2Ttvsxdo5sanCeHD/no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfnlippAbWv21gMmRzqq2KSos/evxmFVh5jWUv5HrLIVJz2+ewa78P83P6+B7I7Mpky5jM7ZNaE2US4f60uoHytGkvdCpeygDuGqXCEMT3H7MNsbfnAvgZjesSUUyNa6BuB2eBq/CjcbXIXslWwZyuMbD1jvjOmlK4S9J5FIE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAOIsxle; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAOIsxle"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso3301950f8f.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345356; x=1760950156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dfh+usPmbdzLjuB/iInn5Euoj9wrZnVaX/71DemamA=;
        b=HAOIsxle5KuE/83Uk0kJmV0Pyb8ev3XzwrjWKrEHZWCAIpMHkOEXqrzNGaZzrl6WPo
         /HyRvxG3vbt64Cgn3l63fLs5AKaTHdWAdZLicDeaTkflM+FQM3AMTpoH32dg8qwp+2u6
         7YKuVZlk6oFYZ2y0fHH6MU5EojKZj73asMnCuCmKnVbWWW7MrR+IxSWxMdyWS4pRnHWg
         ifqnU1Mch9gSHJmxg4HH4LCeEirphsGYfJ3OcfMJzIMDZVvIt1RGAeqkW/mD4MVrwv00
         zIktOuc547S9zHN0lYyvX30c9v4KelYo0yesZ3vdbWl6J1VNEXuVyNzk2JQFA8N2engn
         Yx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345356; x=1760950156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Dfh+usPmbdzLjuB/iInn5Euoj9wrZnVaX/71DemamA=;
        b=twKro8dV6aSt2H5qf3xNxr+NjDX+YmVhI4X3e7g8oH3f6rNI49W4EsWpBaGQ0QHWJC
         wpwiKYcFrkx0Ta6GT0yLITGLiV0Z2mOJ3tu0K0c9lIew77Ra+4D0Pkya0cIiSLDEROeo
         YWkU85w7C04cWOuHt1l+NuASfvHcKgV2216MQub9qDgZ2gyyT19K+XErrTljdUql7J+f
         vfu+05Eo0tyVPLE0bxdWYvkAyxyP3Q31EGkEHat3niFgKkUEOBIKjDuFAe/NaT6DBm/n
         5qB+QHChj0uB0zdYYYTvKjmWWZuZ6tF1wLyIfsq5CfkS4nMzwYC5S96yoFv0baSqijgV
         LMyA==
X-Gm-Message-State: AOJu0YwR8h4RJhZPn9T7gqM3jEPZPFcoU7U6TkzpkZZaeeK1n60jyly8
	I95OBNoU87TfbSsATwE5XQXeidYnTA23lEpCjip7zPpBfxg4WY9jc2d7JsmxkjkD
X-Gm-Gg: ASbGncvWmlO+E6+W/rNK9n1udJELobRFeYnEazHTzrFw7YMJ9I70YkTRRnO8WQmqpBP
	bbtJvqRFeU1kOTEnAkCnOa7eif3uCx3JxfXXT0y4a0ESN0lBPEdcxgDD/D7dlwZV9FwDj26HhS5
	xvL7TZlPSnHOWTfbtNL3YK9NNup3BlWbOccHlQ8Ub1pjX25cUZETFIHD93+QlqERVH0hX0hBRcF
	9J1q119xgXXylMcp+9Hmy0D4n0s2nfXyrT/Tgld/eIlRyBjnr+4EdHjJYhv81Ee5joUGifF38B1
	FcHmCneepN5Enu6Pwr2uP1R/jNB03OHQ9jXUzaSmPNumRHDbRbBID1CwsZb8iAJqBw9+cvPUqBk
	IpyRcrE4PCyQQl7BhgcyvAe8+QtW4DNj+5SKtP6fytV4L1kzJKzjhEuhfvfdtb+eIYrdC
X-Google-Smtp-Source: AGHT+IH9nL65D9YkKTlrQX8rF2QdLh+YhRddZqd23R/bc+AzJ4D2vLXaMopsZ9HqQFECe2hq6QhBtA==
X-Received: by 2002:a05:6000:4028:b0:414:c2e8:a739 with SMTP id ffacd0b85a97d-4266e7d64a6mr14673204f8f.31.1760345356319;
        Mon, 13 Oct 2025 01:49:16 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm15630220f8f.13.2025.10.13.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:49:15 -0700 (PDT)
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
Subject: [PATCH v3 4/5] fast-export: handle all kinds of tag signatures
Date: Mon, 13 Oct 2025 10:48:56 +0200
Message-ID: <20251013084857.1646783-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251013084857.1646783-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the handle_tag() function in "builtin/fast-export.c" searches
only for "\n-----BEGIN PGP SIGNATURE-----\n" in the tag message to find
a tag signature.

This doesn't handle all kinds of OpenPGP signatures as some can start
with "-----BEGIN PGP MESSAGE-----" too, and this doesn't handle SSH and
X.509 signatures either as they use "-----BEGIN SSH SIGNATURE-----" and
"-----BEGIN SIGNED MESSAGE-----" respectively.

To handle all these kinds of tag signatures supported by Git, let's use
the parse_signed_buffer() function to properly find signatures in tag
messages.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c  |  7 +++----
 t/t9350-fast-export.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index dc2486f9a8..7adbc55f0d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -931,9 +931,8 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	/* handle signed tags */
 	if (message) {
-		const char *signature = strstr(message,
-					       "\n-----BEGIN PGP SIGNATURE-----\n");
-		if (signature)
+		size_t sig_offset = parse_signed_buffer(message, message_size);
+		if (sig_offset < message_size)
 			switch (signed_tag_mode) {
 			case SIGN_ABORT:
 				die("encountered signed tag %s; use "
@@ -950,7 +949,7 @@ static void handle_tag(const char *name, struct tag *tag)
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_STRIP:
-				message_size = signature + 1 - message;
+				message_size = sig_offset;
 				break;
 			}
 	}
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 21ff26939c..3d153a4805 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -279,6 +279,42 @@ test_expect_success 'signed-tags=warn-strip' '
 	test -s err
 '
 
+test_expect_success GPGSM 'setup X.509 signed tag' '
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+
+	git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD) &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
+'
+
+test_expect_success GPGSM 'signed-tags=verbatim with X.509' '
+	git fast-export --signed-tags=verbatim x509-signed > output &&
+	test_grep "SIGNED MESSAGE" output
+'
+
+test_expect_success GPGSM 'signed-tags=strip with X.509' '
+	git fast-export --signed-tags=strip x509-signed > output &&
+	test_grep ! "SIGNED MESSAGE" output
+'
+
+test_expect_success GPGSSH 'setup SSH signed tag' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+
+	git tag -s -m "SSH signed tag" ssh-signed $(git rev-parse HEAD) &&
+	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
+'
+
+test_expect_success GPGSSH 'signed-tags=verbatim with SSH' '
+	git fast-export --signed-tags=verbatim ssh-signed > output &&
+	test_grep "SSH SIGNATURE" output
+'
+
+test_expect_success GPGSSH 'signed-tags=strip with SSH' '
+	git fast-export --signed-tags=strip ssh-signed > output &&
+	test_grep ! "SSH SIGNATURE" output
+'
+
 test_expect_success GPG 'set up signed commit' '
 
 	# Generate a commit with both "gpgsig" and "encoding" set, so
-- 
2.51.0.438.g6987fc0bae

