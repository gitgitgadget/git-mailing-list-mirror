Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568E4AA023
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365488; cv=none; b=TQ+QSCDA/gOblQiXd8YixXDq7iTntGpzbY4eruuax3dwl0G1MogX58iKSW89FTxiYM8IBQu36lYadw5Wf+1OF8/iUCVkFVTM8XP6rkAnlzK0OM9e/osQSHw7fdLe6Lhw37HgBMcwMXz4bsI0uIpwANtGbZCaWWOSlGbwh9rctcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365488; c=relaxed/simple;
	bh=aRC9pej6rlsSprMpZ0JnODtoHkO8lX8ZnvkZ51Pc/lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz+4tMYqpqGGSATHGyWm1kO8VXLThg0OhPNG1PrWh4TrdKpPGRTxzf/vMk+vCFECNeCMsUq+2hh46WNKwSTJOy9CjKynsa8m4OV3vgh9EnyFroheLcGwhbJO7eoNuXRmL+ApUUTMboQEOKw+NSqVAFvfCVdxnkgy4QxOgFxQEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ+Vj/zf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ+Vj/zf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48431648f33so29290f8f.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365484; x=1788970284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VUwDxrnyq62H2HfrtZWccUQ2lx7QGoM4pzrUEvC3z4=;
        b=iJ+Vj/zfrE7J2fKx/Uuce5ysbc8p0fEIjo5zR6c2vt1ep+hKQttKoY5XF5SOFdN6d+
         +ZMjjfq/kwGCRv7TAZaDuOO8R8Uwif5WCcdOIwvSlXlOmySxqZmXfSIa0cHWKJbfNKFm
         +ug21WOezYbqN3+O5hLCx+dqxxH69TgUOyi27oF7JpOd/yjmkOMnjra70+q1/cChh6FO
         qcuD1VibICZZNBXBXkJiptpvC20JFZvBjiS5M7UB4YcW9/ceEq9OJiva90d7rAv8gojJ
         RnS3Va/5R9fB3ER8bWHOEaELIacL84uSFvVAOWQ9d5qCdoP98yvbFugV3uiLXbD1MYEb
         bL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365484; x=1788970284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VUwDxrnyq62H2HfrtZWccUQ2lx7QGoM4pzrUEvC3z4=;
        b=mZe7G49UEndlLXRAOFU+RogA0iEcZWRynQwR9oZNXjtLPPr10e+7vP+LS1A4UOBwBa
         ykuFVywT6/5e+Sam/WmDRR1ajk6ta9f3TnsvdmOOpNBZVFdlAc08qX4e3029O8En7lTH
         Sy734YH56GTlaILklpORNrXszKJ1TSvdbSVNoC7T3bKQigoABddebshFx8FBNX2vHxax
         fqu1dbUn0VTv5dorUhkJD38G97lBW4hD5xGnf2SM7LTg60P08J8jxl+YJLltbfvO7LXj
         lqZrOSyyxF37PJ15vSPP4/XEQ1iJDAhDb00qqVJuBRqzF3qekqigjPdxM5mMPEoGIFUf
         h4Nw==
X-Gm-Message-State: AFuF++l744jLLQpJxU85Njgm7PAGG8YTszHHdbiDA7gdQ+3i4KBtM0T5
	xYE6fnNaNvATMjeWfb/uLqXHePZCI5rV2O4xvDZNblZNRaTEKLPevv0oef+gdYRF
X-Gm-Gg: AR+sD10Yvup8NSyIyuQA/vuSs9XGZw27ZbIbGCkk+V4cD45uo9jk3NfUL8RbP2uIOX+
	kA+N+hRtyyfsHfzFyK3R5+j09sRzQ2gkUAg4F3p3rE1q+tAB6xqAPtqpAAPqyBX4nZ9JgscJ3MO
	J0FwdZ6FLwKjh93xPxEnWd4GSvzxt7rgGdkl9p38v4C3TWDUyKYikaP5LFHym3FYQ70T67+iNhd
	ws2DnwHATMxFb/xNESb0aPaRDtcqk/tT0bem1qaNmDg4VsUVgoYNPD+QcEaPqca2w431eCUJw8x
	U9vZ+veASGmkks4iZDyzQaovNTvhlcHCIGu7pFi9ZJ+vCKzVzL/ctfDZu7MYtkTOWlnl83GMPgp
	h8LOKyp3m1YF2VODdVIflOpTBiV3nFKXoANFXE9UB42/HVL7MK/L/Vy8nzFhetvcU663kl72awB
	mPdxRRPPIMQSBvREeQVMSpstBzq47pLhiZMopr4+QUX1eTsKO8RFfJQJi5qjiDRUX6maDXtODWO
	q2TjMs0tJ955BLH5TnwIgK7Vo6KtXXDWENC7qfCYZi8M3o+PTzNl94kZEym6L55PGOOD3yZa6Jl
	wTp7Bmg9wD3YmEsqtTdXjhIddcFbFWUDJkxGWQus+xogQEv+g3Sdfht9shAXyJlXh4fDs5/2wsc
	ylXcE+9jqS7k=
X-Received: by 2002:a05:600c:19c8:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49cee5e8fe7mr5222645e9.6.1788365483581;
        Wed, 02 Sep 2026 09:11:23 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm50938075e9.4.2026.09.02.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:20 -0700 (PDT)
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
Subject: [PATCH 4/6] parse-options: add parse_options_takes_argument()
Date: Wed,  2 Sep 2026 18:10:45 +0200
Message-ID: <20260902161047.476753-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.787.g3f9e2241eb.dirty
In-Reply-To: <20260902161047.476753-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
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
index b3d19446cd..70851a385b 100644
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
index abc73d8399..b96e93508e 100644
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
2.55.0.787.g3f9e2241eb.dirty

