Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4014831E
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124958; cv=none; b=RjDuZJKcSTK73jo4PCUuA5+AEa1GlrpCWob6qqkI9nmg8ubRNa+bWSgAYnnUzrzjRJ1h1ZLAgLt4lKNJo1k6BMvjR4D1als/hTYpcqiRHdRMln5EpP/8yDw33kC4A70J78IXfprrIDbocZE2pKgeZehS/y245L9wHsm4cmp41OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124958; c=relaxed/simple;
	bh=drUD39xUc8WM+utEVxXTiU0Dg0IS66wVnv7Mt5VGK2A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O/bHTvyupoIhr0WI31eBj/wamqha8mDyCTFe8cia9MrNL7KS2rYPOM962dNA1gjTZ74NFzNxHUhLzplnDMO6wi3gLuWlYWTZ2IyZbd++JVOuhnDcLvCLuAOLPOOyGhy8I3rfd7LmZYO7bVvSxXO21TCcBE8TgtGnkVECo2IcBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR8R653T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR8R653T"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412568b5c1eso1800695e9.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124954; x=1708729754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duyinlY0QkJJiADy/N5wKycwy0BLJrkHINGYsEMmQcA=;
        b=HR8R653TW3DTuSZ4B4PUP/Fe1rLcAd5krmhVOkjFrKMAJQ8S5Dkg7OrJy9mIiVCHKx
         O20numvKRzqObAiwM/HhBFHZRWXEOHJsuHWuDHkkvxLTpb0Wesqlf1YMWsAoVU96Roqw
         z+oShHgHDxLZk9qYP2qHNP2XP7UVxXRZfieAIrUmvX4mgo5NFwdDnZoFNgbBZIyoK1CP
         xt5VFHCnaOXM8Z+zGz7pfpMeyVI2lG1vYheY5uhoGgvegM4sbaZ/krruRLrwkad+tDTA
         AjwJiUITpNXF+r9JrOCnRbdRtglibMJVOxGdsKgU0W2BW6vkr+dQBwXe2MfNth6uA0Bd
         2X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124954; x=1708729754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duyinlY0QkJJiADy/N5wKycwy0BLJrkHINGYsEMmQcA=;
        b=i+GcVAYRfHbttt/rqQIjzj9+Qz3pQy4jVXZA+UQgpMD7Mf1AcC2vfl2/h5lzlXQWbv
         39gG51Z6cHf8msBkJXFlCPepxSWyFjSkDVGXjhzItWhcMb1+m2JP1Ql/TlW28Ihvxe+E
         E/d2+T/BcsyXfPxN2RrfjU32Ph8d0Jb1/ScwyAeMpEvtaX+pHGG045QsINqEruVMAzBF
         pA3LOiYy4CW7mzob55ZHYy4dhCOthxdKr0Xv1z2j74Plg2cMs+J77+iUbTUGiCYFDqeN
         E4S/4rBRqXgb45ybPEewXSgtDSVWaTlYOkh4MdT4RkG3bsbaeJr5jGCWxrRZAydfBMr/
         eplg==
X-Gm-Message-State: AOJu0Yz07E4K6EARQrnNw1meT7Uc1VLV+6PCDvDeXmJhlTzgLF6Smzz1
	5wL+Ndq84NaxVYSmOiB1XOvHp6mFVHOqiaHn+J8Cc2HAPfSs/ZGGXWSRaQTo
X-Google-Smtp-Source: AGHT+IFtw07uu7fAnrUl3Di81WjGJp98PVi+cJKMyf4604os4bTCRvjjFMNirrUmX4MXFsNdnJ0eOQ==
X-Received: by 2002:a05:600c:3515:b0:412:4a57:388c with SMTP id h21-20020a05600c351500b004124a57388cmr1879806wmq.14.1708124954118;
        Fri, 16 Feb 2024 15:09:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a1c4c03000000b004120675e057sm1688016wmf.0.2024.02.16.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:13 -0800 (PST)
Message-ID: <fdccaca2ba0c92a3f2b33f6608182ab80507ec53.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:03 +0000
Subject: [PATCH v5 2/9] shortlog: add test for de-duplicating folded trailers
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
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
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

