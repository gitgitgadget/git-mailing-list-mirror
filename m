Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679015665E
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956733; cv=none; b=kSIfzQNYx63p7SvsJwHOl7gvUlPQD0Vy60qM+fYHSrUrlWkGHvXwxLnBJ6hxwks3BhzeGZiqk62ppAUpiRbJDPM3sahXEsdKtHO8fY9HFWwVrDPdeWCKlnTPoWvelmt8aeZn7c8PanjbDPtAvP9dcFvKzyf+QV0RKZ/aZjdAhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956733; c=relaxed/simple;
	bh=4fF/iFrjxK/J3QpnRV1j6dp7MSqBm/+pP4GwPUP5FC4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VgNDy/mM951RHQiRbJdDgeyvVAYeeFgFiuySalt215+8eJsdJVnNGf2uVO+8FAvQSeGN/r7W2PLMlIpzw4IbYhzs6kxW0uMLkjfiN77FYLzKoXp/Ga/Ty1xwO/nib1zaJaBlBIZzxyJ0hnAVs0WWmTIC0M8Errj/jIu1AaH8pY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5OBp3+V; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5OBp3+V"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so373278766b.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956729; x=1728561529; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0DF9CUo4h1Na73+EuFg/X6NAeFMdLBd7VLvH+ogCGI=;
        b=k5OBp3+VYT4Z6nxTuNr11jZhemDeJNVCxlkDPt2gof1FhGdI+fG9B3V+ioV6zIi0qN
         7Gf59ZBKlg/tSXtHDVtAv6ywdP33v7b/l1jG9h0If4sg1/igQO2R3iTyenb+blD6SkAm
         aL05q+0xe8xFgDwWpuFUhECm4MKCSvNKD7DIW16Fajx/PPelSsiE+8lFAECQmhzhekTj
         b/fpQL17z9pi10U5brjWbdj8gdiyHvzUTnqvO0Kz+7hBNi6Vjeyh3h1VGD0zy4A56j+R
         jjR+83fPzcwaNsxTOX5V9iZw1lwvyv93JkpchJwyx0vlD7KCOJGm83Cj+34ZNt3iZB2o
         zBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956729; x=1728561529;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0DF9CUo4h1Na73+EuFg/X6NAeFMdLBd7VLvH+ogCGI=;
        b=LRGmKqBSIFddWAPZnZ0q13sH2jgIE0oCMyfrU6vGYjzMq0IpeWIP743XeFNFs5Dt/9
         VnTcE+9Her8EeYGoJCmdpm1Ro/+Pw7SYlh+qQUKmqCtnwEM3MV5TUscaoIBfXhMx3AMG
         4hkXdEJFlICi/wOWqf7m4toEo3tiXBdCPvNahzuaLQLrDIUL4oxgkHuWebjhCZkTKgrV
         KSgLQJDZGFFuAbm5B0PSw/WRYgGsOjgVlKqmxT2IoOKdqF7sUZ1p8AWTOC9z94dk+5u5
         K0Lwu+InNCDjenJbggCwqm/hQzl3lRoIr8iQblamKzUMGOdx3mEZicBUHifn9BzRhr2G
         2zxg==
X-Gm-Message-State: AOJu0YxKIWBtQKFvZusQMVOSx9DX4K0/XRtNsaTWOrb03AE425MgVs8t
	h0vXvNM8Cf44D221YZfjCO7+HmEW4x6uhSeFyhUXTkhyTChy5gS7xaW1IQ==
X-Google-Smtp-Source: AGHT+IG21Z3H+ER9I2bvOLV3k2G4pQPDJdGN/TIxdLjTjwqvGPGbVIQXHvMTE8pOw3S1hPtHT5ugHQ==
X-Received: by 2002:a17:906:c107:b0:a72:7a71:7f4f with SMTP id a640c23a62f3a-a990a03b4b2mr339193766b.7.1727956729190;
        Thu, 03 Oct 2024 04:58:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910470767sm75901966b.153.2024.10.03.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:58:48 -0700 (PDT)
Message-Id: <94d2c034b4a82ca1024b2a591aef990688f95862.1727956724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
	<pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
From: "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Oct 2024 11:58:43 +0000
Subject: [PATCH v2 2/3] line-log: remove output_prefix()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Jeff King <peff@peff.net>

From: Jeff King <peff@peff.net>

Now that output_prefix() returns a const char * type, it matches the
behavior of diff_line_prefix() and no longer needs to exist on its own.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 line-log.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/line-log.c b/line-log.c
index 29cf66bdd10..63945c47299 100644
--- a/line-log.c
+++ b/line-log.c
@@ -897,16 +897,6 @@ static void print_line(const char *prefix, char first,
 		fputs("\\ No newline at end of file\n", file);
 }
 
-static const char *output_prefix(struct diff_options *opt)
-{
-	if (opt->output_prefix) {
-		struct strbuf *sb = opt->output_prefix(opt, opt->output_prefix_data);
-		return sb->buf;
-	} else {
-		return "";
-	}
-}
-
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
 {
 	unsigned int i, j = 0;
@@ -916,7 +906,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 	struct diff_ranges *diff = &range->diff;
 
 	struct diff_options *opt = &rev->diffopt;
-	const char *prefix = output_prefix(opt);
+	const char *prefix = diff_line_prefix(opt);
 	const char *c_reset = diff_get_color(opt->use_color, DIFF_RESET);
 	const char *c_frag = diff_get_color(opt->use_color, DIFF_FRAGINFO);
 	const char *c_meta = diff_get_color(opt->use_color, DIFF_METAINFO);
@@ -1011,7 +1001,7 @@ out:
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *range)
 {
-	const char *prefix = output_prefix(&rev->diffopt);
+	const char *prefix = diff_line_prefix(&rev->diffopt);
 
 	fprintf(rev->diffopt.file, "%s\n", prefix);
 
-- 
gitgitgadget

