Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B34448D0F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837878; cv=none; b=owghhYalrW78thqkmK+WuPS+lqeGxdeQ76YnDSgzKl99UWy/hbu6ipnNSRGHZWUYAHNPIkdD5CMPx8JIxe/IGDo4nmeeMgyqrbHevI8tpGmhynbRf2GQTwo1DI4u1PQKroBYD9nNo2ocMGj+l3GO/oMO9ttDHCdx1YZ7VBnv38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837878; c=relaxed/simple;
	bh=CmH7lcSKpD76iWsUnsFWv6kU7NXd3pUSVFBat3rztlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KswaYboPD5j9AfO9L05Jf5l54YBR39Vu4rJ2pxrg220TqZCU9vHWbH8RDkyH+l7b1U71eSuzHt9VVDVNIpCvi37zOZpNQ5MgJNuwFVRa6Vn4Rabnbc2psbCxUHyUeOGkd2DywQsoHRdhvcOj1Bg395+IfexnIbAAH6aQw0uZIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKytHZjP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKytHZjP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so14953065e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837874; x=1786442674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDpqp8RGL/EMpQ0fXa+w7hTQJWAg4bqs2JViboUjLVc=;
        b=fKytHZjPobfl1DI+co+XKMgl/2u9REinTKWczDkmxcfgrzdxS2LoTorrFYptKnlyka
         Kq2Sm84huFrNSOW+EnNUsa4lI5SG8l3nq91PujaJk+08Nn7g8YtzCbN3Z1X4+fg0HsZw
         y5zuckoGT+k5T7sYckPtAh2SF7yf0pKOC8BbS9vRMd6DqjuE4RSu4WZ8uZ9qBqili8m/
         OE/bt6yi/Hpg2Ux++9azyW/VAcZOQz9mvwX0NJ8AZ3QtOId/JQf/Fx7FS5a6wisR+j8t
         jvgaGaIoQCK2sRDPOr7q4neFu6az7jK8rij3mNHmY+CCG6jRPhMfpG2yx27D3NzRzYr7
         32Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837874; x=1786442674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uDpqp8RGL/EMpQ0fXa+w7hTQJWAg4bqs2JViboUjLVc=;
        b=Mco20oqnSHNMuJgmCjTPTf86LSmQiPJ/QVl1nFjAm5JfTwN6k7KSAwndiymFe2zhbV
         Njlx47bgMdVxa9XpnSfxGJ3ayu4w1/KHiagulYpRn+1+vYp/k9eXceWQ0AhOfrpfAFhp
         T824andXCrC8ak1oJtxXSPMUUL09sAN5dI3mymHLouslOXay/5fflR1P6iNG1ZFcoILZ
         4pMv3IWJuw3jemttmveUZXlWyDfC5wFitmh1rCl0P2xCtWejDwEsbc0Jmk996wOvpHem
         3Q/Fv86WYudLSBvrRplotnW+KNmbJnSHuRLcqZwZ7wBfKBy23KhJxS7zZhVFEcXRdS7r
         JnSw==
X-Gm-Message-State: AOJu0YxbBc4g2WNLxqU0p4Bp2E8xYXqGm0nRjSgux7CS2gpDsnthqpb2
	yKJYiwvWwvRuhPxdrWzyxVnevUtCWrbbWBXcjzEsYaWvnhr9rHbFt8tIjAYa3A==
X-Gm-Gg: AR+sD13H0gSQknrZ3TeMrs7ku7rR6MZHN2Gkpwf5wBrfLZ/+bI6HTqxImzN3OmyixXq
	haLMI385JgOPMk4aSRWQX1Z0o7mhoXVFt3H5hAruIFOgUsULRqR8tzlSAfnGGyf0MtfwlTIjaFm
	LXStRkClOo4s1JpKgt8UlOoUN/owRWgjK5qcJfxw803zuhpNfsrN3ft7css8jKIJqGkZHrL+c31
	UoJy3e/xIQLy2CFhClv1Dg2FNhrnuT1PlNJWo8htgj6ZHjiElxOmvyTvHDlY2Ta5zV/n1AFOwCw
	rlATIzXMK3/I2xUYz+Mqe+Lq87+l7J5ClSIFrnsDCtlLgB3EugVbZ13FhcMsquEULpPdFPRzMGj
	otsqZpdrsgR5ZEDWVtO/dSjYuO3c4jntI6va+0LL0+pr7eBQQ4ND3rTZfMiy/uXYjJKxzGawoW0
	AvR+iyo0sSadJA3zjGXsAbc+ljVezeXjcFXtIBxHadpUfq/N61zhsoOe4YEqsVIjC4Ivb0eo0wd
	YX3e2e8P9Xh5K/lsKAp962Weydv4wYJbXUme3LNF26OqrU60aNaAG0/y1adcmjnLlz+dcMvqg1K
X-Received: by 2002:a05:600c:8b13:b0:498:8e6:d464 with SMTP id 5b1f17b1804b1-4980c65cd2fmr332595445e9.14.1785837874009;
        Tue, 04 Aug 2026 03:04:34 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:33 -0700 (PDT)
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
Subject: [PATCH v2 12/12] fast-import: remove useless from_stream argument
Date: Tue,  4 Aug 2026 12:03:55 +0200
Message-ID: <20260804100355.1299498-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that a previous commit has removed a call to parse_one_feature()
from parse_argv(), the former is always called with its `from_stream`
argument set to 1.

Let's take advantage of that to simplify and cleanup the code a bit.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0df7a31014..9d827f2224 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3840,27 +3840,27 @@ static int parse_one_option(struct fast_import_state *state, const char *option)
 	return 1;
 }
 
-static void check_unsafe_feature(struct fast_import_state *state, const char *feature, int from_stream)
+static void check_unsafe_feature(struct fast_import_state *state, const char *feature)
 {
-	if (from_stream && !state->allow_unsafe_features)
+	if (!state->allow_unsafe_features)
 		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
 		    feature);
 }
 
-static int parse_one_feature(struct fast_import_state *state, const char *feature, int from_stream)
+static int parse_one_feature(struct fast_import_state *state, const char *feature)
 {
 	const char *arg;
 
 	if (skip_prefix(feature, "date-format=", &arg)) {
 		option_date_format(arg);
 	} else if (skip_prefix(feature, "import-marks=", &arg)) {
-		check_unsafe_feature(state, "import-marks", from_stream);
-		option_import_marks(state, arg, from_stream, 0);
+		check_unsafe_feature(state, "import-marks");
+		option_import_marks(state, arg, 1, 0);
 	} else if (skip_prefix(feature, "import-marks-if-exists=", &arg)) {
-		check_unsafe_feature(state, "import-marks-if-exists", from_stream);
-		option_import_marks(state, arg, from_stream, 1);
+		check_unsafe_feature(state, "import-marks-if-exists");
+		option_import_marks(state, arg, 1, 1);
 	} else if (skip_prefix(feature, "export-marks=", &arg)) {
-		check_unsafe_feature(state, feature, from_stream);
+		check_unsafe_feature(state, feature);
 		option_export_marks(state, arg);
 	} else if (!strcmp(feature, "alias")) {
 		; /* Don't die - this feature is supported */
@@ -3894,7 +3894,7 @@ static void parse_feature(struct fast_import_state *state, const char *feature)
 	if (state->seen_data_command)
 		die(_("got feature command '%s' after data command"), feature);
 
-	if (parse_one_feature(state, feature, 1))
+	if (parse_one_feature(state, feature))
 		return;
 
 	die(_("this version of fast-import does not support feature %s."), feature);
-- 
2.55.0.492.g44bba30fd7.dirty

