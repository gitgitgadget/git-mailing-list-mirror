Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB94477FA
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791096; cv=none; b=FZSc+asW5Lup6sTttGoXzozyaDI17YcNKf19z6kZHLWdiS0/kQtr5mOBuU2vjipJ1vKbvRCH5WmCGJZK9sh5vAVQZvt5xYFmq3Qfno2VRbrHK8dh7xsHsq7RADu/BZ6xld8RYLKfXe4HjHruwOCYOLFItZbwOqnqc/BW9zAwqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791096; c=relaxed/simple;
	bh=8HuOlOvreEw9YlNvm/XkRAVCj2KRaHZ1Unb4qNqD3V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4+c1M7JgkRaQKc2E211cwoK8ZdrkyFi2XuleabnV5TTn82GV8e50RvRCRafOD0ylKfZWWr8X3ojEGnyN+GvdxSVHESlio9oJXm12NuMaP9SSrf205plYi8K2m73xsszPuM93yhDGQ4W83Y7fBkKPqHa/Vpqg0nQVmbbFxDHnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyRttOsJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyRttOsJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b060ec084so863769f8f.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791791093; x=1792395893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc6Y6JEz0F/DkxKjLvLSaBvP4XZARCnVxAX0DTnRg1g=;
        b=FyRttOsJhMYYriLqYShsiDAlMKQNpc4cNoRH3s69B9lhEhXX58sO0BTPuB1eRuGJ8c
         8VBWXT9D0fc3h7+TcWoQnFq732umwS6chUOZQW9CxaD37kGzTn/CoRcCYwySq+FKxzGz
         r40jNFAptHmQGvNralBnoxMhuxuvGMedHFvmJWfEzsbaoJUT3TmMo6qJTDGrv9lCCYIS
         nwcd5MfgJ4I5o4tCXVVOrUilFkUcf1gqCJGeof2O2i0+l+w2TJGeSs0R+VyOsVqyvA7l
         Xp/ln6yaMbHXndSXeq7Q7vdtrGTiz7mmfKV9UEdzay1slZ74OwgoyWjG3VXp+NdK26VJ
         AfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791791093; x=1792395893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rc6Y6JEz0F/DkxKjLvLSaBvP4XZARCnVxAX0DTnRg1g=;
        b=1Up5AzMBkZd09TDPRb9dCZfAlrY4QVjf2ULQ9K9q5e5jOqILQSS0Zl7PI/cZhvRsWT
         NdFu3EDuRqh+sc5rEDdAQSjRglSdPANGm7tNaLSskcuTggXgV9B4yP8IjWCtAJjT37S6
         BLE/mjRq1jDqDluoJ+LgJJik/rmIYoVlPO9FQoprgIt/6ThnpMqLtmCWY0r0miesFBKp
         BA67U6Uh2teWo/u73q6Smj+/sOXzosXxb1TEkTO+HdI8LVQTIxcjEiBI/S2da4I5kiWW
         3CI/7p9Ygj1EP3ZKNCUipS5qPxVeMjl0iSKPHo/vyy7K0vF5uEJlYTRZbPgq0WVlvaDF
         rlqw==
X-Gm-Message-State: AFq9FYL5wvBn2K3Nx6yGYsW5gQJKwYf+tP+4i5mTUaJmlEO8dLLjgCqP
	WUrTTetAAsLQvcoNCdybJ7mKf2hLv9kdbvbJkFW9HzEeIHUE/fDSqZg5bUpZiQ==
X-Gm-Gg: AYBFou2Ud2zmGws29J2DgDwoBpLQA4/0O8R5wNtFNw2eUnnzN3es8NigYlJPBRn45sL
	N+5CHVQF+MGnNriSlcvooesu2IkOcf8UMhd1JshwtRjXs1vvChowMdFguRcApFnytmK9L2bLJBe
	qHxVsQmf/gBp+UoOxziKdcw3e0Lp7i+51SW6agztdgoQvCbo0c8sW9t4uEaJFA9AKg/K4IfskVw
	2nMwP1Tl/22f7JedqX/hBS610gNM6sFq/gmX/aTWEeK4POIs3i1kZ6GJDy61iEQvz1C9zyKmPyH
	iCAZVhJl+UDjzwDFNgTUTx7W+oo9gc3oT1LLM+DLW/XShT3lcFFX3Yg9jaVGEY9OgS7QMAdFDkE
	naWWFY0ieEIDw9S/9JojehBvL4Cld4gi7Te+RzYh01PWxQ33hbQ+6arQzrFU0lbGcA01spurH8G
	Pc+96+JJQKkp1HSeRnRFvuZjXys/z8dgwRInn0+U/m1gRaMIDWmrSSMg6jGSDlWBlQTO4FdvCx+
	RSIkUL8m+DOrk/mVOY7M/krFEOm0th6+/czKEwdVxngHwGk1PQHzHRlpDV86Ph3ViYLuyOR+Kkc
	RtM1zvAAJ/cuGJty1DGd5Z/JkCAmh9jySb3KIMTUR+YOSjzq8z3i4oDoS50xOamepjJx1on0y70
	KbS6cPWFc
X-Received: by 2002:a05:6000:25ee:b0:48b:e50:715a with SMTP id ffacd0b85a97d-48dbace01abmr16892316f8f.34.1791791093073;
        Mon, 12 Oct 2026 00:44:53 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db99b800asm17680723f8f.22.2026.10.12.00.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:44:52 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 1/4] parse-options: add parse_options_takes_argument()
Date: Mon, 12 Oct 2026 09:44:10 +0200
Message-ID: <20261012074413.337183-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092
In-Reply-To: <20261012074413.337183-1-christian.couder@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com>
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
next argument when it isn't the last one. It is considered as taking a
value by parse_options_takes_argument(), as an early scan can easily
check whether there is a next argument, and would otherwise wrongly
take that argument for an option. show_gitcomp() keeps not appending
an '=' to such an option though, as it already did, since its value is
optional.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c | 35 ++++++++++++++++++++++-------------
 parse-options.h | 11 +++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4519ead9dc..d7cbb5a343 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -841,6 +841,25 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
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
+	if (opt->flags & (PARSE_OPT_NOARG | PARSE_OPT_OPTARG))
+		return 0;
+
+	return 1;
+}
+
 static int show_gitcomp(const struct option *opts, int show_all)
 {
 	const struct option *original_opts = opts;
@@ -862,20 +881,10 @@ static int show_gitcomp(const struct option *opts, int show_all)
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
+			if (parse_options_takes_argument(opts) &&
+			    !(opts->flags & PARSE_OPT_LASTARG_DEFAULT))
+				suffix = "=";
 			break;
 		}
 		if (opts->flags & PARSE_OPT_COMP_ARG)
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..589f8d9008 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -420,6 +420,17 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		  const char * const usagestr[],
 		  enum parse_opt_flags flags);
 
+/*
+ * Return non-zero if `opt` takes a value, which means that it consumes
+ * the next argument when that value is not stuck to it with an '='.
+ *
+ * Note that an option with PARSE_OPT_LASTARG_DEFAULT is considered as
+ * taking a value here, even though it only consumes the next argument
+ * when it isn't the last one. Callers that care have to check for that
+ * flag themselves.
+ */
+int parse_options_takes_argument(const struct option *opt);
+
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
-- 
2.56.0.116.g6de20f6092

