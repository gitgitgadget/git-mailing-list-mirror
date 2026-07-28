Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4FE446829
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246875; cv=none; b=sdbYOHxYMExghpb40xBxwrJ+1oKL+WQ6MS9jpw9h4gVSbIxLvz6eSCmXrvQWhOze0Mwzm/uLgMhMYCIJaGpQpl0lpMHz+JfeLHiXJ/ABX/lq89U3OKg/9QSzeiTTrdFgKnd8E02ajzXgN0SihIFKoSSHuqEX3/84zq3CWi4hVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246875; c=relaxed/simple;
	bh=kZ7Sa7FGNwpBO3Xu8NP93B7PrhikSwQeIv1CKuVtw2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPKK8zfUYbDOJKt2e5YriLZPD7lIw0zbaCks7WN1xv2rJV1I3pJ2izpO4cUQs3KWjFYNkjcq2mKUkcyHcSZ2Indmk6GqkkhTC92J9Jb2/v2Xrcl8him17wStS37vQdMmyOpeIM5St8+esyz9nOSIyF/oBZ+dJ60jtetcNRnnOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ6Nce94; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ6Nce94"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7380954d1c6so1288940137.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785246872; x=1785851672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TlSXaW/qcuKqY2SAJrjP3MpeZ2p3AeclVBZPXYp4y1c=;
        b=gQ6Nce949EeYca8HKoCTCWOzt1bhkh2ifRjJNBrL4L4rLiO+n4Dk7wLIgdqHL0gdaq
         kc0kt7iFN3zuQ0IvIhymvyotpHKoNuMgobi9xmP/uXIR/XVLHfpf3q2l307hBA3pmyYb
         lPbN1KIg4B7U7HVtInSe0m43d+QdpDRmt/O7qGCRQE6saqjz87L53Tr4JvYrQQtuhsxY
         GUlA9sh6xD/vx0sCTPUcTGqaNDDXfzKTz/5ywqo13IR4kUZTQib1lzxpEztRPZWD+16Q
         MIth/1NUcDDhQ6kku+yQslQsn3JDdgA/4GjZA84r+2grYLQDoFdWOxl1Umw9qfaB2s8G
         dAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246872; x=1785851672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TlSXaW/qcuKqY2SAJrjP3MpeZ2p3AeclVBZPXYp4y1c=;
        b=YeltP30gmefwOO8HCDea9/Wn0nVlOwyapmLixFNKLHATWwj9I6T1cJBdJVHkyiYhgj
         t2i4q1DNe1URhOGnaBze3kpGqn0hfDfFXUOPuZK7MQikWlL8dXP4VnjMAkrFhlXzhTMG
         rYltMIiUwihSCFqs8DtHmsVDwBjzbZfbTe8eU3wHCTPYqH8SmKkHuDwBTrbD3TU+WsKJ
         gwLwqVSXwAZ5HrmxA0ofvwfRdwdu9wFOtjgR9j6T0k0u2PcXvwK1VhhzsYgH4IZZSu0R
         AC5iax2qSk3SJGMdN4gnOWjmHNkiltu/A4fe42xvtmyRHO52yNEGs7HQ8vEqZEKnRnHj
         F9Rw==
X-Gm-Message-State: AOJu0Ywy8Wsu6NI+cJxHsn3mDWP53elYMbGs6e38nmoOtnB85YYHLrJw
	uSnB0WehDYSY5Rzqk8BkIqC4fPtUbRsY8qbo43RWOap6F0CMKk4LnX+Wj2TKDQJ70uo=
X-Gm-Gg: AR+sD12kj7EBWvOCDY1fADAga0No8HEapzrm+8JMEZXg8vFTknQOLArZzJzHf4nNZTc
	uJZ3OugS6hg1ZLAGJA6JYY5Luivzc/0pHcK1xt4JEeLWcLSmwBgQQ/weqOXRx4TBS6PTBYtYqtV
	VAIK02PK8DPeITZ0ecifg/alEM2lhXbU19N3lTmbasyvad3zrzC2aPO67wGPSCyu7L9h5BL/rTE
	fx8QQuZMmu7wrap4ROHeDfLfHVefuFhMbUDV1YLia94nmZkXm6eKrvoF3rYa1U0e55Fxqi+aCab
	nlacscDpEYUGf02GMMpsMbP6BnXV4TVQ9OXebV0RaA/Dj5qUGEIjikyaXfY5mAjoc+JD2K/nOVf
	KO/rkj1htGnAy4goqP5nHOamOVKaTjTWkN+sp/0vq23RnxDLGT8Wkr7KGW1oetwPrjCk1gaHzPf
	qW+AzLuXWB09nsFkig6m+oOsS5En7IllZHFomDK22ZLehtFD+r
X-Received: by 2002:a05:6102:4b12:b0:73e:605c:405c with SMTP id ada2fe7eead31-7549fd662b7mr986186137.12.1785246872381;
        Tue, 28 Jul 2026 06:54:32 -0700 (PDT)
Received: from st-davidlin1 ([142.188.83.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3056cde82sm9061412e0c.12.2026.07.28.06.54.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 06:54:31 -0700 (PDT)
From: David Lin <davidzylin@gmail.com>
X-Google-Original-From: David Lin <davidlin@stripe.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ttaylorr@openai.com,
	David Lin <davidlin@stripe.com>
Subject: [PATCH v2] pack-bitmap: handle objects at bitmap position zero
Date: Tue, 28 Jul 2026 09:52:48 -0400
Message-ID: <20260728135248.61304-1-davidlin@stripe.com>
X-Mailer: git-send-email 2.54.0.1783223981.geb76c99f7f.stripe
In-Reply-To: <20260727171331.21088-1-davidlin@stripe.com>
References: <20260727171331.21088-1-davidlin@stripe.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`bitmap_position()` only returns a negative value when an object is not
present in the bitmap index.

In `find_objects()`, we have added a check (11d45a6e6a) to avoid
processing a root whose reachability is already represented by the base
bitmap, but accidentally uses `pos > 0`. Consequently, it never performs
the membership test for an object at position zero.

If that object has an individual reachability bitmap, we unnecessarily
OR that bitmap into the base again. Otherwise, we add the object to the
not-mapped list, only for the subsequent pass to recognize that it is
already present. The latter pass correctly treats all non-negative
positions as valid, so this does not change the resulting object set,
but an off-by-one edge case.

Treat position zero as valid by changing the condition to `pos >= 0`.

The existing pseudo-merge traversal test exercises this case. Its
position-zero commit is presented through multiple roots. Before this
change, each occurrence is counted as a bitmap hit; afterwards, only
the first occurrence is counted. Assert the resulting hit count to
cover the boundary condition.

Also cover the non-pseudo-merge case by passing `HEAD` twice. The first
occurrence initializes the base from its stored bitmap, and the second
must recognize that position zero is already present.

Helped-by: Taylor Blau <ttaylorr@openai.com>
Signed-off-by: David Lin <davidlin@stripe.com>
---
Changes since v1:
- Clarify the bitmap disk load wordings.
- Add coverage for the non-pseudo-merge case.

 pack-bitmap.c                   |  2 +-
 t/t5333-pseudo-merge-bitmaps.sh | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d8dc4ae8d1..e85bd69ba4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1569,7 +1569,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 
 		if (base) {
 			int pos = bitmap_position(bitmap_git, &object->oid);
-			if (pos > 0 && bitmap_get(base, pos)) {
+			if (pos >= 0 && bitmap_get(base, pos)) {
 				object->flags |= SEEN;
 				continue;
 			}
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 305d677108..5b2a17f90a 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -50,7 +50,15 @@ test_expect_success 'bitmap traversal without pseudo-merges' '
 	test_pseudo_merges_cascades 0 <trace2.txt &&
 	test_pseudo_merges >merges &&
 	test_must_be_empty merges &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT=$PWD/trace2.txt \
+		git rev-list --objects --use-bitmap-index HEAD HEAD >/dev/null &&
+
+	# The first HEAD initializes base from its position-zero bitmap. The
+	# duplicate root should not count as another bitmap hit.
+	test_trace2_data bitmap bitmap/hits 1 <trace2.txt
 '
 
 test_expect_success 'pseudo-merges accurately represent their objects' '
@@ -85,6 +93,10 @@ test_expect_success 'bitmap traversal with pseudo-merges' '
 
 	test_pseudo_merges_satisfied 8 <trace2.txt &&
 	test_pseudo_merges_cascades 1 <trace2.txt &&
+
+	# Position zero is named by HEAD, its branch, and its tag, but it
+	# should count as only one bitmap hit.
+	test_trace2_data bitmap bitmap/hits 1 <trace2.txt &&
 	test_cmp expect actual
 '
 

base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
-- 
2.54.0

