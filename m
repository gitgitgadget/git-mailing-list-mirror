Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22375B1F2
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196356; cv=none; b=PlmGiXWTd6P2GsM5WmvU8f2Ab4AOXHu1Xx/NHIVibMTxb8ukGkzpF/jtjxfIMqd/inQWYcknVyWV8TnS9qnLTmUttDYDD3jhmb99ok+KYRTlpHfgnxUGGYHcE3t1isWqU8MPF1wBI3GDTgG8/cytEcNaUjhPTSRuAxx9vrtClfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196356; c=relaxed/simple;
	bh=drUD39xUc8WM+utEVxXTiU0Dg0IS66wVnv7Mt5VGK2A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rsj3xJhyAvUcAuIi8glbqWczKN2yVwB/Vlu38WrMEiQhJ6IDJPi4TahkgeHmFrMqzzKX2WNc8NGtib10s3u4tIROpUV2qOVWRU24wv9zmSuX7lDGNax8lto2BvxNRiAbWHQeTPnBOY98LvpCx0Eq9QvX3LAZNOAyn5+4SbqRTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgB3OhxK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgB3OhxK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fe2ed8746so1627885e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196351; x=1707801151; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duyinlY0QkJJiADy/N5wKycwy0BLJrkHINGYsEMmQcA=;
        b=WgB3OhxKC7cRm45KM7WRjoSLRvR63sKuGBwrBS2AZLyuVCoNhbQqkhM8UovaSGCoCg
         2J/kmsVqHr7RERPbLZQl4RM0DmPAiIN9QKMoZCNPA9C86H06ckkKCxg8G23WSaIDqRkR
         OxCcazO451r2Udu0xf0dL0Rfs8131mAm/LKWB3goqDXYhAUITMLM/hYgERWCijpo/+eT
         B+m2dH1l8TVGmBn05ZAU1SI1HllG2QCDZYrwu2/eO7vg9DZNbHPGEtAku4LWIrotl9Sa
         8gVPzNBwXcA9QktQKwTz1UsVfGVLJRp+U8fyCXw4KOTwotMBHqJvcSQPRPP3PWOSYOX2
         xegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196351; x=1707801151;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duyinlY0QkJJiADy/N5wKycwy0BLJrkHINGYsEMmQcA=;
        b=hqOHDT5L6rwOsHJebFQfGQ2/PtjhSTTVQEHd9ITrfjL2HSSiHQJgzyzN9KkMGnUrhC
         8BdLM464uGNv3fLxlxRQoSamABK3PZbQUPrrB025WPKMkNMXSgCYbsZkAOYFxHUBxYLo
         JqdUomaIUCgY+nrTpnAZ1sETJa1ig6yiEi+SUxARiPPEZ1peazykhcqHwJVePAu2F5iA
         w6CjR7+HfIKnZ4wO7Ps+Ocp4TpgIng1Ybyhw5j2e/IXx7wtoRrAq4acjZ7zCE8SeNoyU
         Uf3XbU6CPN4nRgpA3FsWdzAoKxbMQh1F9mYwQXuC4VqufM4lHv0xsbj4aPqMih886sTI
         rZNA==
X-Gm-Message-State: AOJu0Yzn/D8xGSqnAuEOTU23V5mSVc+FGL0i2mlh7rt5IbF4lCsA4YOW
	APJbriWEbhdgQcUL4/QGVtsb4e+FfGMxHrU6239tNCw48KVupILZ2Mu+Bnn7
X-Google-Smtp-Source: AGHT+IHjgzXZX0qa7njq3T0MC1DUHVFq8LmLhi6Ce5BJbMNwNZAFG5kSBUB7iOoDxuMf5aPY25E7uA==
X-Received: by 2002:a05:600c:1d20:b0:40f:e1ec:5d41 with SMTP id l32-20020a05600c1d2000b0040fe1ec5d41mr715051wms.32.1707196351378;
        Mon, 05 Feb 2024 21:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXUAm/PNhQ4CrYJ1QtnQTkWcwzzZZdpo2abIRF48N+laSFcfLwwo26CkKpZqCxby6ekcGTXgpzlWtymzTe37v2K1P7xTRQGz77IBLA98DzVm+fTmu32fT6BgY5OM2cJv5GL5S+PBoAUpncVa4JwOAJ5B3+dwXrTQipN08VPRn1TPP2PwyOkavmQOPReq6vkWBzLql49zNSOtg==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b0040fd3d8ce5csm637912wmb.16.2024.02.05.21.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:31 -0800 (PST)
Message-ID: <fdccaca2ba0c92a3f2b33f6608182ab80507ec53.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:02 +0000
Subject: [PATCH v4 02/28] shortlog: add test for de-duplicating folded
 trailers
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

The shortlog builtin was taught to use the trailer iterator interface in
47beb37bc6 (shortlog: match commit trailers with --group, 2020-09-27).
The iterator always unfolds values and this has always been the case
since the time the iterator was first introduced in f0939a0eb1 (trailer:
add interface for iterating over commit trailers, 2020-09-27). Add a
comment line to remind readers of this behavior.

The fact that the iterator always unfolds values is important
(at least for shortlog) because unfolding allows it to recognize both
folded and unfolded versions of the same trailer for de-duplication.

Capture the existing behavior in a new test case to guard against
regressions in this area. This test case is based off of the existing
"shortlog de-duplicates trailers in a single commit" just above it. Now
if we were to remove the call to

    unfold_value(&iter->val);

inside the iterator, this new test case will break.

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t4201-shortlog.sh | 32 ++++++++++++++++++++++++++++++++
 trailer.c           |  1 +
 2 files changed, 33 insertions(+)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index d7382709fc1..f698d0c9ad2 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -312,6 +312,38 @@ test_expect_success 'shortlog de-duplicates trailers in a single commit' '
 	test_cmp expect actual
 '
 
+# Trailers that have unfolded (single line) and folded (multiline) values which
+# are otherwise identical are treated as the same trailer for de-duplication.
+test_expect_success 'shortlog de-duplicates trailers in a single commit (folded/unfolded values)' '
+	git commit --allow-empty -F - <<-\EOF &&
+	subject one
+
+	this message has two distinct values, plus a repeat (folded)
+
+	Repeated-trailer: Foo foo foo
+	Repeated-trailer: Bar
+	Repeated-trailer: Foo
+	  foo foo
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	subject two
+
+	similar to the previous, but without the second distinct value
+
+	Repeated-trailer: Foo foo foo
+	Repeated-trailer: Foo
+	  foo foo
+	EOF
+
+	cat >expect <<-\EOF &&
+	     2	Foo foo foo
+	     1	Bar
+	EOF
+	git shortlog -ns --group=trailer:repeated-trailer -2 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'shortlog can match multiple groups' '
 	git commit --allow-empty -F - <<-\EOF &&
 	subject one
diff --git a/trailer.c b/trailer.c
index e1d83390b66..f74915bd8cd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1270,6 +1270,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 		strbuf_reset(&iter->val);
 		parse_trailer(&iter->key, &iter->val, NULL,
 			      trailer, separator_pos);
+		/* Always unfold values during iteration. */
 		unfold_value(&iter->val);
 		return 1;
 	}
-- 
gitgitgadget

