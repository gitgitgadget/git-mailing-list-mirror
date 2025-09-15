Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8334F476
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950151; cv=none; b=rrfcZWT4SS1j+sGa2VjbNNnWVL9ELROf04w3l1RMaZJmfv21j9iYI5rgtkCa27jHAdrTjZt32WaQxADsyLyJOCLdVO0uD7u3lRlRuyC1gO5maGLjcMcryZBQFW9Vha6846WDGymQ/1VZCDdyvSE1njiCEQLN5JMuYyjT/MLu6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950151; c=relaxed/simple;
	bh=IZR6Tu+51i5UOs0d2ux4Wezz2U8QIr7UI2EZwEB+3JY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=URuNp1iKk/WqXeRhUbNOmWOOuC/cBuZY0XSALWvu/G7I3d9oU1k8ipmy5f9JxJm9t7V81UUBzpRLvR4ogevKm9CmJGmTsODgX9AaU7gJ2CkeOrgZ8WazAga3YBN1v2szvhBoLO3ccoflBU34EXXAWUUT8M+KwhYraNBxjwODTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUcil4M2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUcil4M2"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8112c7d196eso468965585a.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757950148; x=1758554948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hdZdGITdwuUfzuUV/RkAlKFWPkU7UwtfFk0hHq6L0M=;
        b=cUcil4M2G+uYcd4rvDSIQtosvvR2hrOduYjsrH3VhEfeKFiumi6KSr4KI+rRUfIfCw
         zEDSQK3dzsalnYRGwoZ4eDm52yVhKMvdp/cc+jVy4DZfD597tAdvdzofRvC4+CzgL28S
         jGTOboFShye7NkVFbKm7OEdejRM5SNdoqVXyCKo80TQzJCNkUd7bWSROvfczPnug3g9j
         kEewybMgyDREFIaUZTFNutEkfgkdcocGn1CsIXPrwthfW/dy3SePNlfPovUW4fw/o3Wn
         yVmdrqAOmzqK+OOhCHIJlO77hUX191BwzHyFPG4z4DFC9LecoG2Me3yfgav7qsREVOhO
         m0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950148; x=1758554948;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hdZdGITdwuUfzuUV/RkAlKFWPkU7UwtfFk0hHq6L0M=;
        b=n0C6rCAV0o0wrxqcgSMDcfY0jV0jZWiL6wabdl4yBsCspRmEqGHazvgxF2SQLgjQ+P
         d3GlGotVctY3mPGG8uZV5WXLeFfcvYuSyY6JIWFKffGczatiXI5dOvSRH06S6YUh1Beb
         RRrNFEo49p5DoF1rVUp2RR6iLMPN5gppL1eFuv9LnjB6v2epuLA9W/0C/y+rYhvIfEDC
         ULFgUQZBqElPcJgXbnE45Q4IXHTN/kHAcbVd/hkD9Sp8Qi7sIx8qXK3t/QMOxl1F+ub9
         89braiAp4KDsFYwMn/nuY9/no2PLC7OCBCbbt0qQ4re6H0S+WDI0ZUSXkE6F4PRO3BtW
         dSLg==
X-Gm-Message-State: AOJu0YzOazajmc5vlfly6TDaMECpoJw1dZukb2/Be8ZaqzfLrnxSJQzb
	xkJCPxgZRVEmbPv5cXzga5KmS5tq242D7GqlhnEg8SnueOzdBjLIXyiZqP/u1w==
X-Gm-Gg: ASbGncvnvC1VkfSXoq38BMKpVREJllXWtXkHsiWxJ29jp9qnWB3fjZuEZ2nKCEtZFSj
	0KwZWY+HreOiDIufnb8AR/ApFZ3hMdB+bj8XQIFDAesPW0BPhQ9oZI8Ti1ciDVpUxrNPKf4MGW8
	naBfbLe7kWwhH37z0Rb+bwXwhwTbLfa4dkk8DLWgMD/kpbSZDXNV741CvhunN99rUJiw3zL5uc3
	On1zzWElyk5KtkWjD7Lup2V2kK7Z0PTLxo53rYgB+bkKyzR0iFKTiXcdhVHuf63YNWzQPC9XBRn
	hwxRPKHkDJ1QbmhXl63YnJ2KyeNRV8rUkEoha0Y36DEdSbfD+rS3PLd4Wdrj5Ec1Np4Yt6vl+LZ
	aca/ckNFqXigMImUqYBT3N5SLJ3nX9EF9cUA=
X-Google-Smtp-Source: AGHT+IEdi60/mBhaYG/iPtuKVl32seVlf+esMUJlC76NN1/ehLM7E5xr8FTaLSApxhPtZSDWzt1LnA==
X-Received: by 2002:a05:620a:448a:b0:823:be81:f218 with SMTP id af79cd13be357-823fcc673f5mr1319074785a.18.1757950148214;
        Mon, 15 Sep 2025 08:29:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.95.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974dbc6sm809072285a.24.2025.09.15.08.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:29:07 -0700 (PDT)
Message-Id: <3a831b1a2d16296acd53dde57c1a612efab66512.1757950144.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Sep 2025 15:29:04 +0000
Subject: [PATCH v2 2/2] add-patch: update hunk splitability after editing
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If, when the user edits a hunk, they change deletion lines into
context lines or vice versa, then the number of hunks that the edited
hunk can be split into may differ from the unedited hunk. This means
that so we should recalculate `hunk->splittable_into` after the hunk
has been edited. In practice users are unlikely to hit this bug as it
is doubtful that a user who has edited a hunk will split it afterwards.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c                | 12 +++++++++++-
 t/t3701-add-interactive.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 32157e31ed..0754f54a38 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1191,19 +1191,29 @@ static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
 {
 	struct hunk_header *header = &hunk->header;
 	size_t i;
+	char ch, marker = ' ';
 
+	hunk->splittable_into = 0;
 	header->old_count = header->new_count = 0;
 	for (i = hunk->start; i < hunk->end; ) {
-		switch(normalize_marker(&s->plain.buf[i])) {
+		ch = normalize_marker(&s->plain.buf[i]);
+		switch (ch) {
 		case '-':
 			header->old_count++;
+			if (marker == ' ')
+				hunk->splittable_into++;
+			marker = ch;
 			break;
 		case '+':
 			header->new_count++;
+			if (marker == ' ')
+				hunk->splittable_into++;
+			marker = ch;
 			break;
 		case ' ':
 			header->old_count++;
 			header->new_count++;
+			marker = ch;
 			break;
 		}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 43a856e0c0..77f99e9ecb 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1311,4 +1311,30 @@ test_expect_success WITH_BREAKING_CHANGES 'splitting previous hunk marks split h
 	test_cmp expect actual
 '
 
+test_expect_success 'splitting edited hunk' '
+	# Before the first hunk is edited it can be split into two
+	# hunks, after editing it can be split into three hunks.
+
+	write_script fake-editor.sh <<-\EOF &&
+	sed "s/^ c/-c/" "$1" >"$1.tmp" &&
+	mv "$1.tmp" "$1"
+	EOF
+
+	test_write_lines a b c d e f g h i j k l m n >file &&
+	git add file &&
+	test_write_lines A b c d E f g h i j k l M n >file &&
+	(
+		test_set_editor "$(pwd)/fake-editor.sh" &&
+		if test_have_prereq WITH_BREAKING_CHANGES
+		then
+			test_write_lines e K s j y n y q
+		else
+			test_write_lines e K s n K n y q
+		fi | git add -p file
+	) &&
+	git cat-file blob :file >actual &&
+	test_write_lines a b d e f g h i j k l M n >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
