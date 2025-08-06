Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19E1401B
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522129; cv=none; b=k7AEqlEeg9MnKKqLLNTUiJfQLwcfGjWtSs18pm+ighfDAcK8oTFeTE+xng2ZQOYcCXa5Vd3z9vClbtwQujd3OdtgLL7afLVDGY86rnib2S13PZDISb0Hop/cu3hT5ucbeZ2qAY8EESB0Xbb7p9jExY/31zi7e+t4BD8urcq03XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522129; c=relaxed/simple;
	bh=rW6XAXHR/baKs2zZ4OwvdZLmXD2Bq4LF8tM/Fw4bCbI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EpxH31eUKWe6L9c+kFOqB1I2r6ErNeP4a1H4p7t3lq6S17vAkBiQIUWfZNmSf+o64pa2/eDAA+mMmMrftLnQKV+NADdWK5EluwmOdpLHfXJZ6vuMm5z1AXMwMI0+LhaU68Q4VC2UEnOXXxoFvkq2xJj9vyQ+MBsfLzvzq/0IZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8haKP8H; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8haKP8H"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so3586475e9.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754522126; x=1755126926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1X06A0NdexEto8yPmI1p6MIlBfs5M6iYOqr3bHf/G8=;
        b=X8haKP8HCpFbbPJiYOk00VmCdDZPX3AwYAXUsn8FogXDAQGIICqen3xEwHyHOUI8V6
         95ydd8xgB/Ab+oRo4EwPLXcXbrCEySMcAOa1LB+Cf6c3o0LrQTxFSzWIgdOR6byN89Cz
         AGxe8KhiIeCwIe27gweak1QXwmlQtRKgqme6IDBTzo4m3XK1e1AfY88rtjQq6VVF3+rV
         zVC7lGfLIi4FuNWj77CBAz2K9begPSIaX+/9aClVYglUDFgcab218m1kw1+1dIeRWilP
         Lp9X/aEOxTnqgETuQu+462dAwMr9d+7MBf7uG8UkIF9RofPC4h1nfVJzZcFq4oSGen00
         SOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754522126; x=1755126926;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1X06A0NdexEto8yPmI1p6MIlBfs5M6iYOqr3bHf/G8=;
        b=bE2UNBXsd27Nv9zYCA7PmNU4ZOpc2O78FzOMR4dIDq3QtMXANYjLUjyM8SHb3P/x+R
         8mS1NT8USzERemb1TN53K4mTnhg1MfsWTBgYadPDioSUXK0iEa2VDNhNyxhSJHQ08l0W
         6x9Ga0pSJ4ypNPStuIFQCSIGNh3uiycSANh76PrFoJDZbrhMoO49JW/psfg98b1ZNPz7
         fGk+xGBvjO/7clxeRxrBuEoMx+/Py22aYcrZz+gAYMJbtb+BA9JPxk6ijTP3ByjmvDGc
         +77IC62PX03s61WAsO9cJmKfLBzTaLcsbtFiPHn/TTT2jPelhUUTW4ZeneNq5kklwe1D
         +7AA==
X-Gm-Message-State: AOJu0YzpKnk6WyGJOogRJ2UHzhWLIeYxGSp38dmfKCclNMlHlhBTX/yP
	KJh3Qsk4SXhJK6BTv3HR2/LJ6pmSs6JffD8oZi8ML2WhvFQ2I82utwDbAIhu6w==
X-Gm-Gg: ASbGnctDJSz3wcuwmKcqe0iOas/My6BsJXFLM2j8h3BS20fwUUh/k98JkZsgNRlu7Tk
	mm8WEbHkzM8ENhP0m7ajixAkGN2Ls+IpaB6NKKB0FDj8VKsY+2xf8KXqMc30TvMETWFaFbBjqbN
	AcRZrQ+yZWTBGSF2h2PGTqzKi+4Ig88ej77vkqNagyBLiu3rb7ViLCcT4PDqYrUnICTDeejn0e6
	ulyhzxlHXriW0ZY4YNi0qBv+Wlkh1YW+IWQfCv9FLjjBgy9j7pz6cGozOXqFeS70lgMM8uV9HH8
	fBUlLdQlpc7t+2XkIN0KUWTFN3eUAO7e3DzwXnARnbncD/YYBtBly5aKFIsSqLUDaz6UmMIhm0K
	x7JmQQQamIMruOCUG6gC8QL4=
X-Google-Smtp-Source: AGHT+IF83ALVqchPFCAUvHGJsWKmjmx12iGumWPSXRZvZkf1A2+4hSqiCgTc6XjjKxcra5grcMzVqw==
X-Received: by 2002:a05:600c:5490:b0:458:add2:d4b4 with SMTP id 5b1f17b1804b1-459e741bd55mr42204455e9.12.1754522125497;
        Wed, 06 Aug 2025 16:15:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm65053055e9.2.2025.08.06.16.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:15:25 -0700 (PDT)
Message-Id: <dccc204430535f8c9eb74d7861365dbb2c42bb02.1754522123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
References: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
	<pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Aug 2025 23:15:16 +0000
Subject: [PATCH v3 1/7] merge-ort: update comments to modern testfile location
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In commit 919df3195553 (Collect merge-related tests to t64xx,
2020-08-10), merge related tests were moved from t60xx to t64xx.  Some
comments in merge-ort relating to some tricky code referenced specific
testcases within certain testfiles for additional information, but
referred to their historical testfile names; update the testfile names
to mention their modern location.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 47b3d1730ece..d87ba6dd42bf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2163,7 +2163,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting mode for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
@@ -2520,7 +2520,7 @@ static void compute_collisions(struct strmap *collisions,
 	 * happening, and fall back to no-directory-rename detection
 	 * behavior for those paths.
 	 *
-	 * See testcases 9e and all of section 5 from t6043 for examples.
+	 * See testcases 9e and all of section 5 from t6423 for examples.
 	 */
 	for (i = 0; i < pairs->nr; ++i) {
 		struct strmap_entry *rename_info;
@@ -2618,7 +2618,7 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * That's why otherinfo and dir_rename_exclusions is here.
 	 *
 	 * As it turns out, this also prevents N-way transient rename
-	 * confusion; See testcases 9c and 9d of t6043.
+	 * confusion; See testcases 9c and 9d of t6423.
 	 */
 	new_dir = rename_info->value; /* old_dir = rename_info->key; */
 	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
-- 
gitgitgadget

