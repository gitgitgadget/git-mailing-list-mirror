Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6B30C610
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763354117; cv=none; b=Hi0GlHeLaggT21pVPN9FHnPSmmVTT5LQAuwULzloAmCa7OreAfpvFVQseTxlUrjw5qx2ooe4EAklS7raiyPDCaMpeIG0WgYftAPxHbrzYznOCHFmpJ7vBPHnBMXiUuwCpCMeo+JeAIcag//b8coKgZsyqZjLdC1Qx8K3OAzEeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763354117; c=relaxed/simple;
	bh=im76FXNreuGInwJDlKrCe6Ry7tFleU/ewz15JY02j1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX9oFzseUbBPphFbj7JH71Z//mrK9C9G03x9weczkFkMZGU5CJs4S5JrBSndt59SnkBsgMGcZy1gpxosuJeiqcXrSVgTM1sBcaUiGkk0QwgEPG74AT0jyaW3PfqmSdhlpJU3XFIXscJiZT9hJPksedYrISiBuDHNemCYmZ/CaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyqQpbGU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyqQpbGU"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so3094575f8f.2
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 20:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763354113; x=1763958913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN5auDvtQuoMwkpDA5IVQSKe1iKnYDXkl0AZq+vW7wA=;
        b=FyqQpbGUh0hCtTzZkJ8Xa46dEooSjnE6U2ryVGwwpRWWURXSXPGXKBS8r0nidv/lbK
         hb75tCklIi3wF33bE8wL9xdR2IQk6JME8o7wvNU7Gfw0W1haXOYGa9qfzn4lMbPNtGYX
         UTrU0rdWO+x+ae4Hb1/9hGdV91cMX0hmX4uaQR0Fn2c77F5tSaiybgRe72YWkwRsitdR
         OiWDRS9+4iHnMiuoiEdBO30tkGKpxuw3fxEd7EEPL90AYOPvjGmIeWR6tuuW1p1CL7XF
         BgUITRx0qzoKDBzgxfg/seFGielTVstx2+FPVBhwM/UASLPXiqiwT5TPnPydPdg2hgh5
         Q4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763354113; x=1763958913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AN5auDvtQuoMwkpDA5IVQSKe1iKnYDXkl0AZq+vW7wA=;
        b=anvSfxatcFaeDPdUIaWjH5F/ffl54tkpI359s9fGgQnqFaCmX9H0eL4l1o1ys1980a
         9j0EB8Qt9N1VlfykZpco5fVvSe4TXyW7O2JEP7amLG44Z5AwteY2IgPr5Cez0DUb/jjR
         RX9Ry+28vcnlsLE9OoHeWyEqqJoCq01qSksk6FZMpeKEl4YZEjMMBwmsSjSC9VwvQlBR
         KTw58D3rdY36Nr037sDEQlrzTUY1gZ7A0hqKhcuIj3n32rykPIJgsBjjetYIkxpugLgH
         27PmNkDli0f1Z2KF0w4epNHzBp0YNhJ3AFXVO7eiEfZudgU3WQfDLrK+rXoW8y55kgj5
         q8Yg==
X-Gm-Message-State: AOJu0YyF0Hzr7KqdHhgslHxzbITFAufBneTnTcB5oDcXOuIi2GlWG9JO
	lILEbQbhAWssitSJwfldehKFucx013IztBcr8bLDYhDoG1ulzoOnITwsTAQuZw==
X-Gm-Gg: ASbGncuvwV8O0CiB2oS8Glv/ZhjEYLP1AOssg2EX9spELPoDDM3x2DDYBO1KoCSpdFS
	1O/R/lNcA0xAgu50a984AoxutqtgSqa1nhOUepYjMWWu9yzYSQTa5MUDkUS9KBRYnadDoEO16sL
	egqLyT6SB8Xag7qxVGd5KDxA1m5OinSrkVKX1zgcdhSnG747A/LlXRVLkSYrEMn741oVXNdLyfi
	gMHdzChGUOsdUZIDckHLnpLET6sC3NQ3bTbedcI2qPzZIqBMo5latYkUCl8HaLv2/b33owDiMG/
	tv/jLw36XG47/jcT14JTw5GKzjcKu2vDOe3rKHbsPIjV8oZpfuAvGXM4JXJD+hE66ys2XI7Sz96
	ocRXfnjXhG8qOZDmMWGOLXD9BO/z0+dDYvUwGIz72aAGyDoML3un3tbaQnc26ObC+LvwJXe8q0g
	q5jf4M7chub+vIl+zlTVNcwK/VR6LF4YM6T7vR7g==
X-Google-Smtp-Source: AGHT+IFyGCCj84Map8S9xtabIwgf63qX2RIBq71+ijQ9wjzPD+8du4yy0jfKYAyEsQ9SpzsTV2xSyw==
X-Received: by 2002:a05:6000:200c:b0:42b:31a5:f032 with SMTP id ffacd0b85a97d-42b5934dad6mr9993820f8f.28.1763354113271;
        Sun, 16 Nov 2025 20:35:13 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85627sm25115284f8f.16.2025.11.16.20.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 20:35:12 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] commit: refactor verify_commit_buffer()
Date: Mon, 17 Nov 2025 05:34:49 +0100
Message-ID: <20251117043450.322644-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc2.6.g1f299c9613
In-Reply-To: <20251117043450.322644-1-christian.couder@gmail.com>
References: <20251105061918.3688870-1-christian.couder@gmail.com>
 <20251117043450.322644-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we are going to check commit signatures, but we
won't have a commit yet, only a commit buffer, and we are going to
discard this commit buffer if the signature is invalid. So it would be
wasteful to create a commit that we might discard, just to be able to
check a commit signature.

It would be simpler instead to be able to check commit signatures
using only a commit buffer instead of a commit.

To be able to do that, let's extract some code from the
check_commit_signature() function into a new verify_commit_buffer()
function, and then let's make check_commit_signature() call
verify_commit_buffer().

Note that this doesn't fundamentally change how
check_commit_signature() works. It used to call parse_signed_commit()
which calls repo_get_commit_buffer(), parse_buffer_signed_by_header()
and repo_unuse_commit_buffer(). Now these 3 functions are called
directly by verify_commit_buffer().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 commit.c | 17 +++++++++++++++--
 commit.h |  7 +++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 16d91b2bfc..709c9eed58 100644
--- a/commit.c
+++ b/commit.c
@@ -1315,7 +1315,8 @@ static void handle_signed_tag(const struct commit *parent, struct commit_extra_h
 	free(buf);
 }
 
-int check_commit_signature(const struct commit *commit, struct signature_check *sigc)
+int verify_commit_buffer(const char *buffer, size_t size,
+			 struct signature_check *sigc)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
@@ -1323,7 +1324,8 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 
 	sigc->result = 'N';
 
-	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
+	if (parse_buffer_signed_by_header(buffer, size, &payload,
+					  &signature, the_hash_algo) <= 0)
 		goto out;
 
 	sigc->payload_type = SIGNATURE_PAYLOAD_COMMIT;
@@ -1337,6 +1339,17 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	return ret;
 }
 
+int check_commit_signature(const struct commit *commit, struct signature_check *sigc)
+{
+	unsigned long size;
+	const char *buffer = repo_get_commit_buffer(the_repository, commit, &size);
+	int ret = verify_commit_buffer(buffer, size, sigc);
+
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
+
+	return ret;
+}
+
 void verify_merge_signature(struct commit *commit, int verbosity,
 			    int check_trust)
 {
diff --git a/commit.h b/commit.h
index 1d6e0c7518..5406dd2663 100644
--- a/commit.h
+++ b/commit.h
@@ -333,6 +333,13 @@ int remove_signature(struct strbuf *buf);
  */
 int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
+/*
+ * Same as check_commit_signature() but accepts a commit buffer and
+ * its size, instead of a `struct commit *`.
+ */
+int verify_commit_buffer(const char *buffer, size_t size,
+			 struct signature_check *sigc);
+
 /* record author-date for each commit object */
 struct author_date_slab;
 void record_author_date(struct author_date_slab *author_date,
-- 
2.52.0.rc2.6.g1f299c9613

