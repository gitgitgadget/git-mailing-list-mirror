Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DF14D28C
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407289; cv=none; b=MstSmAI46peOIMPN8b7tq+kC6eaQ0TaICFPeyUGEtj1DQAr0sNWCfdYcmeuAJI8kMO3vfGwhAwBjywkCNIk7ydFwpRvlWij3KpITCYYNbjEoyrJy397hDN4R6T+xC6ZAJHdRu0CB5EuM1qhawUwKs7CtYRJEzbxEgTqZglsezoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407289; c=relaxed/simple;
	bh=8K4xVmyqiCmjtMN3Z+7YoOgWz6omKVgjVsjAlK8VEh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQVPOarZzIVjg0KYe6EglEp2IdXF87cQJBqnJIF+WAj3iiKtBRjiOiqYGz6JQztuFJ3+8fMfR45ejy6c2BvD3mr2h2ZZc+GT5HPCKSQpBfR7q3AU7zaW4gk0+Fc42EHphoJiC/7V6lT0KZhl7GZ70F67DuHwO+1NXfEx+jU3Iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8+lNgjP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8+lNgjP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439950a45daso27430915e9.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740407285; x=1741012085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8FDWFS7nSwCA7x2q+qcv7Hw2WPjWFzvNms+uWLJj+A=;
        b=M8+lNgjPTdz4P17q5S4WHYSUhNCwVQDQav139A6Kd/JcHQnHcn+Gbf3FxkUYjZPz2f
         YjwfQ9KtYyFSm1BnTMIc6cMPCeIVAq/c7Ufzy891HTG78rbPeLoj5mE3JaZCGM3FtwLX
         +ZuAF293woqlUi0KoRB0eC91annmx2DjehQbpzK2/Brma02AdJRvZ+o5aoKvzXVP9JIz
         Ta27YZg0cd6AfqFwHz12T0G8FNdA+NkFaj307xro+fmHdezW+yh97AKhzq+Avrj/FVln
         FNVr7mVeZfC/SE7f3U12eTyJXh9VZYcu3icUEZyl7aBGT8dGlUcUCqKrJtmUOHIrkaKy
         E9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407285; x=1741012085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8FDWFS7nSwCA7x2q+qcv7Hw2WPjWFzvNms+uWLJj+A=;
        b=rMqBBTVhPDNTd6BmBhmQYM0wxvQ5GGuAr/YVuP3oo8LDV80T2Ff0j8pNc+Xf3tnB+2
         RFmyk27HgTpdeKaAu2+TAsEH59a4H8ZXpaSQC11lju+Ya7kRW6PQgCVNpSieTGsy0/a5
         ehX0iNM3T9H8I2GmatK4s00oO5WoZpQ+J3KQ44GN0lr6kEY+Ly3pLsADSRTbsxES0DNW
         aJAiyXFHm5jzdRdArc18tKler1PBHwUnMB6Jy1k3gg4X/N+ELtPM6SK75lY6oO3wMrNz
         wAfIm7EgU4SsXxwi3eCtMkgQvEVZ81e1Ed6raLmylvSefVEFQAoC5QC97lQIn8gPtG3Y
         uK1w==
X-Gm-Message-State: AOJu0Yx/ILZ00zOjRUTQbCs1uVSjjCs6dKGoSXNbhNvCZfCKPsy+Mt+v
	RIMEHiGfLeMbmfyMpcxOmVAK0MMt6Elqw+5tdnR48i6G79J4x6+cIRL1xg==
X-Gm-Gg: ASbGnct99CrFdG9XQTT6QWsIUENRqnYA7i5H8gelBnrS2OHVBm1bjDmzh0ROiGEuUte
	Sp+k1bYG3z597gQ3+d2O3ozTDWtWu46PWanwuG8j981VKEtkQzCL7RUkskS5JK3sqWA3g5sdrOz
	904Qw+BTYp+aK22IO/eiKxewfR1tiCo4MIgw+oOFg1wQklIS8fDrHWQV9YdgyBIfYz0KysTdQIo
	0F/HHgg7A60+Zg+oz9cBxXAfqQIrsCEoAGRqSwG/BYxNC2ejqM0K/5+sJUJuC4H9D93IdCGYzmi
	+76tR45eEdM9e2BUBobcuUe6bDJRjy5PwFsJyEmhMMdFgZrwubZHlJX6dN4g
X-Google-Smtp-Source: AGHT+IHQpAfCZZwfcwxCOekJu9w6g7SliS8YTN/bpMi6PlxGq/WmISJjOI4Z0sQo7Y/8zAO/d+DZyw==
X-Received: by 2002:a05:6000:186f:b0:38d:eb33:7f7e with SMTP id ffacd0b85a97d-38f6f097f55mr9840223f8f.36.1740407285322;
        Mon, 24 Feb 2025 06:28:05 -0800 (PST)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:29b9:ffdd:d750:1ffc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm31713125f8f.73.2025.02.24.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:28:04 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/6] fast-export: fix missing whitespace after switch
Date: Mon, 24 Feb 2025 15:27:40 +0100
Message-ID: <20250224142744.279643-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.48.1.401.g48e0d4203c
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
 <20250224142744.279643-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Documentation/CodingGuidelines" says that there should be whitespaces
around operators like 'if', 'switch', 'for', etc.

Let's fix this in "builtin/fast-export.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a5c82eef1d..2bf787191a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -694,7 +694,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	if (anonymize) {
 		reencoded = anonymize_commit_message();
 	} else if (encoding) {
-		switch(reencode_mode) {
+		switch (reencode_mode) {
 		case REENCODE_YES:
 			reencoded = reencode_string(message, "UTF-8", encoding);
 			break;
@@ -828,7 +828,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		const char *signature = strstr(message,
 					       "\n-----BEGIN PGP SIGNATURE-----\n");
 		if (signature)
-			switch(signed_tag_mode) {
+			switch (signed_tag_mode) {
 			case SIGNED_TAG_ABORT:
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
@@ -853,7 +853,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	tagged = tag->tagged;
 	tagged_mark = get_object_mark(tagged);
 	if (!tagged_mark) {
-		switch(tag_of_filtered_mode) {
+		switch (tag_of_filtered_mode) {
 		case TAG_FILTERING_ABORT:
 			die("tag %s tags unexported object; use "
 			    "--tag-of-filtered-object=<mode> to handle it",
@@ -965,7 +965,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			continue;
 		}
 
-		switch(commit->object.type) {
+		switch (commit->object.type) {
 		case OBJ_COMMIT:
 			break;
 		case OBJ_BLOB:
-- 
2.48.1.401.g48e0d4203c

