Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D62367A0
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491754; cv=none; b=KpWtZM2R/X7ysIi8++um2wty0Hw5o8YAlPdOMR/5mmNr0DQLBdS3OwOycPl1Ws6x1pUYnimCLEPCXlHzprk/cKfN6y2sGNxSqC2lhxRAmAx/2xlfn76FrqZflElaL6F4r2Tz5lCf81mEAW2E+H/ruov0XcUTiJzUrGIpZy/l3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491754; c=relaxed/simple;
	bh=4sc5BX84z6D84vkehwjDrwZMEh8wRq9+ZUznd1TB1iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DytyP2NcYQLYfS7R3SsTNXRw+I44wyepb/SBVpLu1JLd8wM4DoRjzjkvE27SurQW7KwFt5O/AVtpb19+9SrmA42HiD6jxr/t+tOTGqrQL3qxIFYVdlTr8Emfgz+PsPp8FaMqu7+P4VaoXHBiBHtAPAdjcfhJgekFHFB/XuQp53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByOX7zNi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByOX7zNi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df7dc034cso3891085e9.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757491750; x=1758096550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up9GNRv19hkso/0FXunDe40lTClZzKQtkiTOZZ+02lo=;
        b=ByOX7zNiC/aMRRIPnoKQHJM3Oa/Js6bbih83J61veHRFTlBekZicRCK7Oh4U6EFLGo
         NFJHEGLuJ8CWDz6HR57TXkz5TL2MZI1lyo/974CSq4TA0cdqpvOFmHqEaAuK17QxZx45
         mKPBoDXBKVDoyKCxSYA6PbzN9vRJ/sTuwkF7n0r0jMo7/QmcPFxB/HZX1klnDukx2Icy
         TFHJNL7BIUptR3ALkcsR4grerbW59R3CiWLCDUZ1juibgmaVQaBMjuxLQFd4Tr/CUHvd
         fFUSFGzEFvcPukDQaGDurXdoDVB8OXiV65bg2vaTzeIqs0Lf6VECCWrvqZsIbGhUBfA0
         Pz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491750; x=1758096550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up9GNRv19hkso/0FXunDe40lTClZzKQtkiTOZZ+02lo=;
        b=jDHkD3KXD0eITvi/k+6bZDqZ9ulx0s858sinvMvkpddpq2tcDkgiibvSMPu9U2jURP
         Cv+5QOd0dOpXtoJrWDFdwCfI6gdQQJ/Mu83DFmGRyqZ91c9w74IqPZtLfzZA65OYkMA0
         mwJDq3K9GyYTeU4tYfKHvpLQFZQAQ/p8BCJQQf9/D7nlQQ7pn8UagSeQyd6eU5rzhnIy
         NU2qybupXee5DPAYVhdOc2E8hP/4Iv5oL80/dYqZFXLeQK34ISMMUM/c5IMRPjNKQe24
         whvRAfCD4Ge4mTHK4MrLbTilZoTEGDBGlIF83YnXOfOZITGjlHLAQJ09wM5zPe7KMN1i
         CnsA==
X-Gm-Message-State: AOJu0Yx3vt49JvzZmJcAOdcVkeOraSqBVnx2v1zGBazRBeLlN/EIOZAZ
	CNdpdpHAU5Mee+TAvqjQ//31NsAkUGqBAA6fADASl4wSqKGpPyrduZHPnvj4Ag==
X-Gm-Gg: ASbGncty33TX0XBbzfZ6E/ceOLfPoiUxi65PAc0bpryzTWaU5w36xoJ8T3pzV4162AG
	z4rTS2Buyzo/rrnOGY1wvmnLZr7l60WA31Od0OCF9f+jFHmj3MbaueQYhqwSNHRJO7s1+duUcNP
	nLyxiaQ0H2EprfSaVO5wwqLTr53KCc/vA+0+KHnTU2BPCRSJU//j1rn0zM2eBt1NZybqnUjg8Fd
	zK9bD1/Mu5joVsnSGBLpinO9GdlcSMsPsTf45VAa2Hszt9uBEJnPXxRMchMy75IURGWD4yCvwU/
	Mgj/fqNQ8BxGyzZoQz+tLI0hE9i3tgK3yevaHZAI1w2DLhSqWJYF4wru36yCqvawRQALTPuq0v1
	X/hq+UG/kyF1/yUc+hXWbDJyHlLZGns2zsBUlV0s130GECbEJLzm2xwcFbGTGaMeO+juKhL8isa
	qvwYJT
X-Google-Smtp-Source: AGHT+IF8Oa5RuM77m/yYvPA/9FSrLGJvedO6Ext70tbdN1q8Qah9QNyNT46tOh/mQtQ7knouHhELKw==
X-Received: by 2002:a05:600c:1c26:b0:45d:db2a:ce32 with SMTP id 5b1f17b1804b1-45df60bdddemr29184415e9.9.1757491749735;
        Wed, 10 Sep 2025 01:09:09 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df820d686sm17965735e9.10.2025.09.10.01.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:09:09 -0700 (PDT)
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
Subject: [PATCH 1/2] gpg-interface: refactor 'enum sign_mode' parsing
Date: Wed, 10 Sep 2025 10:08:38 +0200
Message-ID: <20250910080839.2142651-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.g61112aeac3
In-Reply-To: <20250910080839.2142651-1-christian.couder@gmail.com>
References: <20250910080839.2142651-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of 'enum sign_mode' as well as its parsing code are in
"builtin/fast-export.c". This was fine because `git fast-export` was the
only command with '--signed-tags=<mode>' or '--signed-commits=<mode>'
options.

In a following commit, we are going to add such options to `git
fast-import`, which will be simpler, easier and cleaner if we can reuse
the 'enum sign_mode' defintion and parsing code.

So let's move that definition and parsing code from
"builtin/fast-export.c" to "gpg-interface.{c,h}".

While at it, let's fix a small indentation issue with the arguments of
parse_opt_sign_mode().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 23 +++++++----------------
 gpg-interface.c       | 17 +++++++++++++++++
 gpg-interface.h       | 15 +++++++++++++++
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c06ee0b213..3994a8f898 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -37,8 +37,6 @@ static const char *const fast_export_usage[] = {
 	NULL
 };
 
-enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN_WARN_STRIP };
-
 static int progress;
 static enum sign_mode signed_tag_mode = SIGN_ABORT;
 static enum sign_mode signed_commit_mode = SIGN_STRIP;
@@ -59,24 +57,17 @@ static struct hashmap anonymized_seeds;
 static struct revision_sources revision_sources;
 
 static int parse_opt_sign_mode(const struct option *opt,
-				     const char *arg, int unset)
+			       const char *arg, int unset)
 {
 	enum sign_mode *val = opt->value;
+
 	if (unset)
 		return 0;
-	else if (!strcmp(arg, "abort"))
-		*val = SIGN_ABORT;
-	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
-		*val = SIGN_VERBATIM;
-	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
-		*val = SIGN_WARN_VERBATIM;
-	else if (!strcmp(arg, "warn-strip"))
-		*val = SIGN_WARN_STRIP;
-	else if (!strcmp(arg, "strip"))
-		*val = SIGN_STRIP;
-	else
-		return error("Unknown %s mode: %s", opt->long_name, arg);
-	return 0;
+
+	if (!parse_sign_mode(arg, val))
+		return 0;
+
+	return error("Unknown %s mode: %s", opt->long_name, arg);
 }
 
 static int parse_opt_tag_of_filtered_mode(const struct option *opt,
diff --git a/gpg-interface.c b/gpg-interface.c
index 06e7fb5060..2f4f0e32cb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1125,3 +1125,20 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	FREE_AND_NULL(ssh_signing_key_file);
 	return ret;
 }
+
+int parse_sign_mode(const char *arg, enum sign_mode *mode)
+{
+	if (!strcmp(arg, "abort"))
+		*mode = SIGN_ABORT;
+	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
+		*mode = SIGN_VERBATIM;
+	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
+		*mode = SIGN_WARN_VERBATIM;
+	else if (!strcmp(arg, "warn-strip"))
+		*mode = SIGN_WARN_STRIP;
+	else if (!strcmp(arg, "strip"))
+		*mode = SIGN_STRIP;
+	else
+		return -1;
+	return 0;
+}
diff --git a/gpg-interface.h b/gpg-interface.h
index 60ddf8bbfa..44856cc55f 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -104,4 +104,19 @@ int check_signature(struct signature_check *sigc,
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
 
+/* Modes for --signed-tags=<mode> and --signed-commits=<mode> options */
+enum sign_mode {
+	SIGN_ABORT,
+	SIGN_WARN_VERBATIM,
+	SIGN_VERBATIM,
+	SIGN_WARN_STRIP,
+	SIGN_STRIP,
+};
+
+/*
+ * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
+ * otherwise.
+ */
+int parse_sign_mode(const char *arg, enum sign_mode *mode);
+
 #endif
-- 
2.51.0.195.g61112aeac3

