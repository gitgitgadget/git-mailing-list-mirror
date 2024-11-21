Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA11DDA2E
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221851; cv=none; b=gE8+Gcr0HagP1TP8rym3/k3zA62Gvvh2awONdrRbjRcq4d6Ss/Ytoq/j9WXA9DwYkrSFnR+mctQuMKkyCCOqgv6zeKb6B+W4dp8xpHi5oxpaYLesm9cmTI/AiwK37buTrsKqMNRqaQ77SZ8d6znvi6AvmOFBxZaExwb/gYBihxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221851; c=relaxed/simple;
	bh=bVgG0O0yE14ZUIjX5CaOKfeKmzwrVzoSlBzuM0w/jBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+zu1cLA1LYY35mRxnCKGs2gaBnFRWgDANosPvL/D2qY+gA4aowNm56w1QJmFK1H+SvJGNleC20eFGsDoWStrINyIUuEFdDSy0I3MDQMSpmcIR26KQ3ihHYVTuzBIHnk7vNtIcS3fQGdTrLPCA5NAIQWkByoYewr9WCBBePtp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwdKUM9t; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwdKUM9t"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29645a83b1bso880834fac.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221849; x=1732826649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZTRd/YRxheGKQ3Um9aqxW/l7wDYAHTttQgGllc/+08=;
        b=NwdKUM9toEcgZ/1fZvIHFLy0NYJoUtscdN8Gx0d/KRem3Gw6eJfEyGz6PH5tk9hQpV
         cREBQAsZWr6vkUq4772Xkg+msAyer0zNUTI1P7QXon1jk439AwK1G3Zb6+2NcL5RuXNM
         67z4Sy1JFLXXKkjThcy9MG3p+9j8M3h/W07krGmhcM+IaV0hEe9UsEmFzAxcVdlAJUH/
         fG4h/KW7B5sn1xyMFiryiv2WX3cmng19qxkNOgfT/OyeVQ6WPEd1BNKfIRboLBZgjmqT
         oE1p3b6ApHe9MQV3MzLxwiQY85CpD+Lcwc+B4VafOiDOndxIzxAjk+GuA7GVAFPeM/Vr
         zY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221849; x=1732826649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZTRd/YRxheGKQ3Um9aqxW/l7wDYAHTttQgGllc/+08=;
        b=Y/BkQmSg/GOXsI7bsfGos45l+IC482lIx+NDVN+iX5e+YIBluyaKSQD1ZSKmmhM71K
         NyR1Sc1R8TRegDgzsjblTAh/2VaHbrK1Y9Bnc6QyblTbOAw5TXlygZ5hoGaJ3324KkVb
         LrZXAd5fxZzrOX3fjI912jsGPxGIENEREzkxr0GOXYCN9qY7HksnodcaEjI/t/Tag9Ff
         +am2ddRkuCLAAHLk/JR2AFRaiA79HCJUN8hcUJwiQnyTAk/x/Eszivhm9NhyCWg7UOI6
         wMbD0D3HHyQ6zPqJiEXQ8zNKzYI4G75BNq7GFJBM7xh+ln8xTbH2tTx6ApjiDSRqYI36
         ikjQ==
X-Gm-Message-State: AOJu0YxwaC1RJY2BkWXS12xjroZ8IuGy6noWgfWbrSCwpkBkduS9YdGQ
	WTfN94e1leYXsMwnFbv7flhVh6upphrmkPw6DvVx5oKe7v56vUeqlUyO8g==
X-Gm-Gg: ASbGnctw+2iFTBhDrhp2G4GttGA2xPvgjnpKuIW7TsEh983bYg2Afd8nCezPGbHZpaZ
	Y++sMg0N6W1w8Y0J5Vg0pjEpJR2dwiGa+NWrzi9sSARN07AhiwhXw5P4+Z1c42RKk0DPAgprZFF
	T+6dtFuiaHSS54q800Ucr17ENOd91VN5T4u517bDrnsFV6CztzSGYHzWokuZr1IzkPme/AgWlub
	zDBSsur006NBwVe+hs9Kpl9bE6uWMJp13Hn152dRGV79iFNmtZruI1EcQ==
X-Google-Smtp-Source: AGHT+IHxa3J7UeSZ3IMe51hfaM3jLfoRSIojo2OGTh7sGqLffp5qrKy+k8cDRvK81KtwAYh5Td+xMA==
X-Received: by 2002:a05:6871:3a09:b0:27b:583b:bfc2 with SMTP id 586e51a60fabf-297206b0e3bmr411420fac.0.1732221848929;
        Thu, 21 Nov 2024 12:44:08 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d669843sm126481fac.28.2024.11.21.12.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:44:08 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/5] fetch-pack: expose `fetch_pack_config_cb()`
Date: Thu, 21 Nov 2024 14:41:18 -0600
Message-ID: <20241121204119.1440773-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121204119.1440773-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During fetch-pack operations, git-index-pack(1) may be spawned and
perform fsck checks. The message severity of these checks is
configurable and propagated via appending it to the `--fsck-objects`
option.

With `fetch_pack_config_cb()`, fsck configuration gets populated to a
`fetch_pack_options`. Expose `fetch_pack_config_cb()`, to facilitate
formatted fsck message configuration generation. In a subsequent commit,
this is used to wire message configuration to `unbundle()` during bundle
fetches.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 fetch-pack.c | 4 ++--
 fetch-pack.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 73309f8043..10b66795bc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1857,8 +1857,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	return ref;
 }
 
-static int fetch_pack_config_cb(const char *var, const char *value,
-				const struct config_context *ctx, void *cb)
+int fetch_pack_config_cb(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb)
 {
 	struct fetch_pack_options *opts = cb;
 	const char *msg_id;
diff --git a/fetch-pack.h b/fetch-pack.h
index 8243b754ce..f35a75a3c5 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -1,6 +1,7 @@
 #ifndef FETCH_PACK_H
 #define FETCH_PACK_H
 
+#include "config.h"
 #include "string-list.h"
 #include "protocol.h"
 #include "list-objects-filter-options.h"
@@ -114,4 +115,7 @@ struct fetch_pack_options {
 	.fsck_msg_types = STRBUF_INIT, \
 }
 
+int fetch_pack_config_cb(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb);
+
 #endif
-- 
2.47.0

