Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D42066C3
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149843; cv=none; b=Yj4EaZyiX9E/0xRG7k33JLE1cKT9+LxHfLBIdbghT3ZCJSWhU6VQm2+y//e49QBrZSyQOwDBgsJNijU9JK39Hr0jTr5YSaUJMgf2E0K7IHqYRALJTSNCgZH7PDjI7A9eSZ8KksmGSKvfilzn94rtvGBj58xjdN27qEYNxqPLx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149843; c=relaxed/simple;
	bh=rvesfyF5ALThksiXFhqWz9CLihsK5WKzzUZNT69bql8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EzYSfRWPRxHeL424NLsm8cO9hgGgJcRoBLptPZPMEEAkl0UkOG7SUPdHABQMni4YVK7yodtSakqqNbWNxEtkHodU1TKVBKEiy8FzhExxjvZArXpL86umamlaZKZoAhvHH/BznXqVPhZBZcfDPeouVnba4Grf3xbxWjBWSln0LZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHnngmh3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHnngmh3"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb7f539c35so432838466b.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149840; x=1740754640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BYAz7zWuBokToXe1zgtDZ2ht3Qyz0ZzSHLM1mj5x2Y=;
        b=DHnngmh3QcJACBBp5F0wN1LOjV5TNH30tMZj0l+rGl0AhAeGhC96re7ELvsoPX/F/y
         jZsOuCNKl3pRh0S1ZUZTKkM/MVpsB2ZtDkiCW+7/5xh75+epFePu74862mfVUieRk06E
         LSVzsKluIv7TJG6tpUdodsrLuobWIsyx14g5GdyuYIpkJcQ0V4Lnz9AOUqq1lbnzca67
         AcVHOlubrF4CVXGNHaZaVa9twwWiUsTBI1uaG8KdSASFgPyLMSn44o55aib6huUpGped
         K9+uAYQIDp7eiH31XWq4/HMoD6U97/tNc2ZeM1hBR040yuDfLoKTptj8zm2VksS28vI7
         JFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149840; x=1740754640;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BYAz7zWuBokToXe1zgtDZ2ht3Qyz0ZzSHLM1mj5x2Y=;
        b=apcPxKAGt7bXUWxiHSqv2G1tfrl3LJyqEMAE3ZYKp1lul2dnXMN/xmAVdOeFXHgHAo
         t2fGO6WkI+ydg5H5usj9gXO8BJk2Vv0+1PNkJ6Nq9JQ8eC5sgEzKftljBJIpiIEZCmzg
         2ai+83TEbV0bs666cKvRYr0mNwGI4MF8tKdDLY1X7EsU+MN04cD9ajrK8hMDL1UWL4rr
         Cf5+4TJ/jTI3niFH56qxkSCTpkTguDpcolrSPkJg3Eh4N4ka+1Nv765IPsedZPCi6zTp
         hDdUy7cqnI0xHYk3hB6LTlyHdajtMRGa6yRtZYWyylGF/fsa6z5pE6w7xVzOYou82m66
         e9Ag==
X-Gm-Message-State: AOJu0YwVB+QlI/lwTYvVkbphOUDoPwssDxMBI9hKSS3WxUaYi9rktdlm
	oKces8gsCzj+kZ02/TT92pscuD4WrY5EhQ3pIKuQrHEP/VyzGod4v/kE9Q==
X-Gm-Gg: ASbGncsaUhHeqaq5gZaqxxNA2tiXxbKzmxNbeEoKbHeGUvAFrpqV2wh0wEZVXyqtgEK
	7T1p0D/iIPsnv+k9vJHYNVo6NFrc+690eH5DaWOvi5HQsloM/NUlJI9D+gWYKfHEPAqJMMxzQFr
	skkfY957En8JUrqg/r9nBbsSxhle3BZ850P+Z5sTNpogO3aF+p1yvevJe7l/gDPBfTyzv4GgK+d
	/lWmA9WMuUO6O1E4mjYu9ZzFLYnEu+s2mC3/Y0AYwSmr3QCx0Xdk21B9DZXYvZ1/xzzFj/ipgXM
	nG6OxA9KxNp7Y6ggXuNlagB7l8k=
X-Google-Smtp-Source: AGHT+IEO6gLMXLzFSjD5+UeGiluFWoj/mZ+XXkQUyNjRVYDH66IAPKM25n1ZMXlqNeeQRG8aDedkXg==
X-Received: by 2002:a17:906:318b:b0:abb:eec3:391b with SMTP id a640c23a62f3a-abc09c0a677mr355588666b.36.1740149839514;
        Fri, 21 Feb 2025 06:57:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232254sm1648020466b.27.2025.02.21.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:19 -0800 (PST)
Message-Id: <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Feb 2025 14:57:16 +0000
Subject: [PATCH 1/2] add -p: mark split hunks as undecided
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a hunk is split each of the new hunks inherits whether it is
selected or not from the original hunk. This means that if a selected
hunk is split all of the new hunks are selected and the user is not asked
whether or not they want to select the new hunks. This is unfortunate as
the user is presumably splitting the original hunk because they only
want to select some sub-set of it. Fix this by marking all the new hunks
as "undecided" so that we prompt the user to decide whether to select
them or not.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c                |  3 ++-
 t/t3701-add-interactive.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 95c67d8c80c..f44f98275cc 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -953,6 +953,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 			* sizeof(*hunk));
 	hunk = file_diff->hunk + hunk_index;
 	hunk->splittable_into = 1;
+	hunk->use = UNDECIDED_HUNK;
 	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
 
 	header = &hunk->header;
@@ -1054,7 +1055,7 @@ next_hunk_line:
 
 		hunk++;
 		hunk->splittable_into = 1;
-		hunk->use = hunk[-1].use;
+		hunk->use = UNDECIDED_HUNK;
 		header = &hunk->header;
 
 		header->old_count = header->new_count = context_line_count;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b8a05d95f3f..760f3d0d30f 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1230,4 +1230,14 @@ test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
 	test_cmp expect actual
 '
 
+test_expect_success 'splitting previous hunk marks split hunks as undecided' '
+	test_write_lines a " " b c d e f g h i j k >file &&
+	git add file &&
+	test_write_lines x " " b y d e f g h i j x >file &&
+	test_write_lines n K s n y q | git add -p file &&
+	git cat-file blob :file >actual &&
+	test_write_lines a " " b y d e f g h i j k >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

