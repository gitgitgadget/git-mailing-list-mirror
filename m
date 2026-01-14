Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C639E6E8
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405271; cv=none; b=rWDLay5Ls6dEyOAUvpO4ukFuxmdiBdSkZ2BUcmoWWBZTNyrsNmaoxEizXz/SlUQLFqp0xzIgOuDC0HJAWuk44M6m/r79k3tZOAtvPoDlRmlraymfd7XBZ62vbvGQaowo+GPbH5bpjP5r2Hk62PAP7ZFbiuM8FeqUrEty9K7RuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405271; c=relaxed/simple;
	bh=2/e4bb4TAB5JIL8CUkkH/IjmrRUw3TkBM88VQHGY2LA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPW40be/Mb6E+mgXKGw55wuPSZ1PnmTRvLS8Bt5OG1z2P/CwEuZrt2M+ODwacfaed1AudPENRlieQN8N5Vdwls/JHYBpaLCA4VdgXsFWaIJ0c8DFZUa2SJicL0P+nayMDYi6/b3gobyb5SxqylEO/DrG2Juo4F/K4D63/RLtgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNf752uS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNf752uS"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8765be29d6so111082766b.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405268; x=1769010068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBb8nHZEkbSH8seIWmuBngKKVKfvSBD/0MZM0bCzzpE=;
        b=UNf752uSgqhFp/6IDrEoQFg4JW0Qy+9qfd4uCwM9k0Lk2KCcV6P92NM3Q1P1VSSabQ
         5Iku6fsRtblsCfX5AIYCsTB9pe+BUfJP53etzVh+1PWvFjMsIXFIlSrkuQE9g17I1DhZ
         hXPAqT8ub0UIpCBscw3K4SVSxjS4p5bHOt+IUgvF1zi21qXR7TnrpUyuNQcvNTN4SJ5s
         tRIyBxi3ByIoa7Mu8A7rhukOwNS6j+yriBtMNf3/Jac96wkt3tsb3UwpslYA0YN+3jT6
         QenTO4pc9YrqpIYs9xCc+6H14ifkXsCmGEMsLXSU6BZGOipNzqGdtgD3h5WGMpkbnBps
         Ox7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405268; x=1769010068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LBb8nHZEkbSH8seIWmuBngKKVKfvSBD/0MZM0bCzzpE=;
        b=eIvde2xIlU5FlEeYOHVIAb5+GjqU2C6A2JKq5CzcUZqMx7xWEPqIZZIi9GBhFv3SZf
         Dy9Gb6XK+Fv/s+AHmpgNSExeLQ/BWAyKapIKh4I5mEsPg2ccpYBhyHbMGtwak0hEgLMQ
         479YZZFQljoednvSAPcfVVxvdUfYbjqj4J5sTI9XZyNkKUCwQ23GflAaP3Y7GG46VUzA
         HYu/uCRIf4FrMYfeQ7Sy6jTGFAb/DjigN0kveDWO8Is1KVIpeyZTDj5DoqIE8o/2GOw+
         sDOWMPD26w98mcXU7H0kHmQzmPg1Qdf/9GkocjpcvFGXlb+kedp6xBQ3a+TG3jACOGMv
         cKWw==
X-Gm-Message-State: AOJu0YxQnbVppc2c9z8jTgL5DeflItoUJ9+eg0TiWlAmdY3w3IvlgIXE
	yAnUgZ2vmbvbexp45HdL9B/6XddF95bEOUKiO2tSxf5U90rFChA6XMsd
X-Gm-Gg: AY/fxX6LqPzCScGVJdMZL8u/AogsUWL/kbHaUAXPX9uBgvCy5V1/0kqgIXopFYs3PSX
	59vskEvX33jGQXZp9AY45cVNhbl/HuvuBbY2MclXI1e3B576yIunWKpHU2R+7XIl1QXgtZSxgM4
	EMNOdx9xyEXPiBx9SPnOAdezBetEG2cnqIeP2KaXx2r4SoJzMODyNJGlypBUlHv60HVQ97EA4W1
	9ttdrARdJSEjrBFAuV5Ykce/w1w9aTuXebxlMmCYJDYg1rfNzvbeV5iQEBhgbVFZA3s5c5dGW7A
	SmdERhETrNmjjRPrg7wR1C82z+VCcLase13ge3ZMnFsIZfkQYApoB0DF4Nq8nmdiMKLAXVNb1WC
	EqySXrOQZ5uwFoq7HEgUbt4VJv4R0CtGwonbzxJ7ISFMIERHLRkjnTgbCD/eHM2jBdR8qza70l6
	Q34O4MkRlJ677QjVepAAQ=
X-Received: by 2002:a17:907:7254:b0:b7a:1be1:983 with SMTP id a640c23a62f3a-b8767907a95mr211144666b.63.1768405267729;
        Wed, 14 Jan 2026 07:41:07 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1b84:297e:182e:6730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872642beb3sm804851166b.46.2026.01.14.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:41:07 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Jan 2026 16:40:44 +0100
Subject: [PATCH 3/6] refs: add rejection detail to the callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-3-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2/e4bb4TAB5JIL8CUkkH/IjmrRUw3TkBM88VQHGY2LA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlnuQ9y9rgBromtkqSZmPdniM5l4O8/FtqOb
 2c08jwaSXOgh4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpZ7kPAAoJED7VnySO
 Rox/wcUMAJ6WUIwWxbits3hX2hZApACZ+MrzHf7KigX7OrjjkLXSUzYRCrsTxHkWhiLJ1FogWvd
 94LYFMA+UbgVj83zabhIAX49jdIGHQ7C3g1P/XQQqMmqGz92nStdWHv/XkOBX7rvm8bsR09S4x2
 NMrbV9BsE2GYQsy6HC2NWlsCGIxVEQO4Bqn84YktBWTc03hONDEIjXhDyTwHi2SsR6jdGwT6lFU
 P3vW++4MbL8CM5K+F7phjqYJlIlZ3rMHJp8RpfbTKPIkvVoWDAfqNZH6IAGhyr9OgZ4+TVrQqew
 IJfdFIQ2OoLvBjPTgQIBNXmgOxutWvrNy4/slLEt9cQPh/5/qiqIiS68X3FWLUBJt4n/QF3nmm8
 vtXRMe9bypVR7ruc19xUh5SsEZstpab66ml/eNklNiDcCLkqRLgmsrMHXIveefQmwr/hCmB3jkZ
 u1Ob2xLwpWfsLImb3mRWK7DsrkZJP/J2kZt6WMaivOMnZDUd6IZBJQZ76H7jrdGqx6ZKz2g3YV7
 Fw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit started storing the rejection details alongside the
error code for rejected updates. Pass this along to the callback
function `ref_transaction_for_each_rejected_update()`. Currently the
field is unused, but will be integrated in the upcoming commits.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c        | 1 +
 builtin/receive-pack.c | 1 +
 builtin/update-ref.c   | 1 +
 refs.c                 | 2 +-
 refs.h                 | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 288d3772ea..d427adea61 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1649,6 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
+					      const char *details UNUSED,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ef1f77be8c..94d3e73cee 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1813,6 +1813,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
+					      const char *details UNUSED,
 					      void *cb_data)
 {
 	struct strmap *failed_refs = cb_data;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 195437e7c6..0046a87c57 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -573,6 +573,7 @@ static void print_rejected_refs(const char *refname,
 				const char *old_target,
 				const char *new_target,
 				enum ref_transaction_error err,
+				const char *details UNUSED,
 				void *cb_data UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index 991bd8e6ee..ad1898598f 100644
--- a/refs.c
+++ b/refs.c
@@ -2880,7 +2880,7 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
 		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
 		   update->old_target, update->new_target,
-		   update->rejection_err, cb_data);
+		   update->rejection_err, update->rejection_details, cb_data);
 	}
 }
 
diff --git a/refs.h b/refs.h
index d9051bbb04..4fbe3da924 100644
--- a/refs.h
+++ b/refs.h
@@ -975,6 +975,7 @@ typedef void ref_transaction_for_each_rejected_update_fn(const char *refname,
 							 const char *old_target,
 							 const char *new_target,
 							 enum ref_transaction_error err,
+							 const char *details,
 							 void *cb_data);
 void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
 					      ref_transaction_for_each_rejected_update_fn cb,

-- 
2.51.2

