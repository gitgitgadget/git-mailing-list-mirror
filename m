Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6C45FFCB
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150990; cv=none; b=S8ObALcuTnnsT53HILorNWorwDQ1ga3ppjW26QFX8SZgJrrX85txXdxAX4TaYw5jIcq2is5vVXqeEXnlXyOGpcCWyjZxPBQD7d1qeQ3JyVUI9uhJD5kqsOg4aqNQiJ5EwHZBpnxUP4Dxop5g+547aU8GYbLYV9ATxKMlIxa9JQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150990; c=relaxed/simple;
	bh=mSVr8UREUeGBUt4bURV4sAp3Ih3Sos8xQEvx7lE0l+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcEsQPPG286/cPs/1PaTfHi0UsalpPb6xQVsKYPrfZeBiLGl3evOCSVJ2UcqDHwlqIX0ldcm8FFb2aMvHm/xIM/PbF5b4sjxdFgD2u9zq8GidOpbOLwy8ZFpQMhteemU5YUMFaQ5gD0pGpKaukI1Te7ehIdX28bbZpfftrnnmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGemZGZo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGemZGZo"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843e397f74so370245f8f.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 01:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790150987; x=1790755787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+6oTkmciTU+4eCBXybB9q9Ud6bl4DUR1ugdw2B2Djg=;
        b=EGemZGZo+zl0E6S1icUm9A76KkpLO3OIjRTLAiIxoG4fHHZHh96EX48HLZJK2hF6sA
         qMj1zUyJ3J4VRAG+rvG2eVUipdzvTARFcQplc9Q7r9FV4vYIJVY6Ujn45A2meW/MBmky
         jOBnerv3Ed+exce4rT744emfp1Xwgn+MSmcrG1UREq450Aet4oVsDDXblGdgeoO9VDw2
         Z7B8GXHpA3je6Q25LJVVTRSc+zSxWFZ14r7SpRSOukL8V4dJscjzF3uhYgIsus06dhzN
         tsj8kROMJt0ObXLnoHm8GqxTIxWKUUVlfrIsvR+UaNRlnK3YxSrno5U7ECw5SDZvuXgF
         2A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150987; x=1790755787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+6oTkmciTU+4eCBXybB9q9Ud6bl4DUR1ugdw2B2Djg=;
        b=e9K92TmFgG1f3TLBkbALm8vEth6Nqtvyb9vukbHnu+l2jQaliA/As3jRY82L32l5l0
         Z+tfWxmmd9kk+PhH83pe56ZxXNIQZ8hnlDsOenyPLcAHEA75Bv8Y4PIPjZBhowX8Tawn
         zv2VoOU8L4OHUMuCFyx+Gqzs7SIqRQs/5E5fkSG2M8dL+W6EomTekw1H8Q2HJSMZq+gP
         Jv2y+UA8mZmqyPwHpcLhSuK1jDLKM9qOmbaz83eY+rimF8wONq6oLmGYcoozLqTZezMI
         3TU4ojiigQ9k5XIPidkbn5paEXbVBVKhiyKOemMU8UM78bPtjTSAa560kjZmfsjaLlWC
         7V/A==
X-Gm-Message-State: AFuF++mW1A2jZG3H8fB3Nqkt4RL1yJjP54pYOLNm5Rv2uR2ylDbJQ5gD
	iovnP3jVa097e377QsiExFxXtkI7m1vutESvFaCLHu8UHWXx+n5MIkz2THKMQQ==
X-Gm-Gg: AYBFou2KHfebPQUXb/tWkkEPa49aOwXcEykIEe2fNFzpSXmcMK20duEXKRwpL2V/PLU
	f6kvQa/qZ+lGb5Z0jfw1Pa/Ut9ZSfyT0lSJ/w4NYe3MSFlwPdVeuBz8ztkR3ddTmRI9P2xz8Zea
	/+h7J9ChECJckaiTI4htPdrxGr+6IRwwHKYEtMDtoTTOdqoHZc6Fmp/dKDJUqo9VjoftFPxcA/h
	hyseVA4M21Od/tcrlRdUQwD8EcTuqmTeGWtCdPpN6yFYG01+Mlhqkn0PwsMkVVU6xP8PEQNkWRR
	SrqPXC4BBNcjvyql3tjIREjav0v14KVd+6+3Qtwzk+VVcB3mcn/Syju/UsHcJ3+5+ZYYzp23wCn
	57VWInd5NGGOPRCxxo8GVy9tmTVdhl4d3n+SlWGQX1c9Cw0of8W43vD5oJVYQ+JuUMcG8rYMeRF
	uUux9mItt4TGcdYb/cNKchFApwJXQqKbOXjE3TEsVnRgqFUSRS1sFmqn3LGPIYl1bSDlpGyZgTE
	JSl2EeubYoxaD9mnYtailO3iRz8b5QgJPOSod88ism4zdF/5RJyNxSKxAU9Q42LRsqdV2PSEp4A
	BnRZrd4CRSL99dZsXmxQwNQJdpHMqD9qfun/D3SgfwqwGmtWfEHtgdfEVWqi1sH1KS3XrSK+OFq
	qqUM9Y10MRQ7cSVtWPKY=
X-Received: by 2002:a05:6000:65a:b0:487:25:71c7 with SMTP id ffacd0b85a97d-48860fc032bmr6532511f8f.12.1790150986922;
        Wed, 23 Sep 2026 01:09:46 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm5037470f8f.2.2026.09.23.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:09:46 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/3] parse-options: add parse_options_takes_argument()
Date: Wed, 23 Sep 2026 10:09:26 +0200
Message-ID: <20260923080928.1534413-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2
In-Reply-To: <20260923080928.1534413-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
 <20260923080928.1534413-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether an option takes a value, and therefore consumes the next
argument when that value is not stuck to it with an '=', is decided by
its type and its flags. That rule is currently open-coded in
show_gitcomp(), which needs it to decide if it should append an '=' to
the option it completes.

A following commit will need the same rule to find out which options an
early scan of the command line has to skip along with their value.

So let's factor that rule out into a new parse_options_takes_argument()
function, and let's use it in show_gitcomp().

Note that an option with PARSE_OPT_LASTARG_DEFAULT only consumes the
next argument when it isn't the last one, so it is not considered as
taking a value, which is what show_gitcomp() already did.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c | 35 ++++++++++++++++++++++-------------
 parse-options.h | 10 ++++++++++
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4519ead9dc..a132c1ea12 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -841,6 +841,26 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
 	}
 }
 
+int parse_options_takes_argument(const struct option *opt)
+{
+	switch (opt->type) {
+	case OPTION_STRING:
+	case OPTION_FILENAME:
+	case OPTION_INTEGER:
+	case OPTION_UNSIGNED:
+	case OPTION_CALLBACK:
+		break;
+	default:
+		return 0;
+	}
+
+	if (opt->flags & (PARSE_OPT_NOARG | PARSE_OPT_OPTARG |
+			  PARSE_OPT_LASTARG_DEFAULT))
+		return 0;
+
+	return 1;
+}
+
 static int show_gitcomp(const struct option *opts, int show_all)
 {
 	const struct option *original_opts = opts;
@@ -862,20 +882,9 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			break;
 		case OPTION_GROUP:
 			continue;
-		case OPTION_STRING:
-		case OPTION_FILENAME:
-		case OPTION_INTEGER:
-		case OPTION_UNSIGNED:
-		case OPTION_CALLBACK:
-			if (opts->flags & PARSE_OPT_NOARG)
-				break;
-			if (opts->flags & PARSE_OPT_OPTARG)
-				break;
-			if (opts->flags & PARSE_OPT_LASTARG_DEFAULT)
-				break;
-			suffix = "=";
-			break;
 		default:
+			if (parse_options_takes_argument(opts))
+				suffix = "=";
 			break;
 		}
 		if (opts->flags & PARSE_OPT_COMP_ARG)
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..f29e73f85c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -420,6 +420,16 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		  const char * const usagestr[],
 		  enum parse_opt_flags flags);
 
+/*
+ * Return non-zero if `opt` takes a value, which means that it consumes
+ * the next argument when that value is not stuck to it with an '='.
+ *
+ * Note that an option with PARSE_OPT_LASTARG_DEFAULT only consumes the
+ * next argument when it isn't the last one, so it is not considered as
+ * taking a value here.
+ */
+int parse_options_takes_argument(const struct option *opt);
+
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
-- 
2.56.0.rc2

