Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06229A9DA
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314720; cv=none; b=JqxzIAQhKiNPZ5p8PCxknZ5eD2AV6ZB5Fe3laqR8Sv6WBKkdEbb4lW2AvrrIeAmuyGsWl7ZlFV6c6mY8OdXxJu65ld/J+GndYvXpS45JBHKfgWWcBrak5SGUhDMnoEjO5K9rACtWtgVnXawiciROtcwlUlEBtVRZkelGv3D/cOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314720; c=relaxed/simple;
	bh=Vii/lHdoNK7L60z1OHfiRUUvhj/3PaAnssAP8ZzkUZY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nbza7CYbZyqfwXPAcu5mzngzO2sy9mH8VUAIuTqzFWaw+TP+sZbPmfithxX14pMhAKTRiU4nq/P/xF56RUipbBQNNRTc0hT68/TROvak3SGM3GEmQXjT/NvaSmX9CIum42O1aPj3kvZ98JBFXixi4UBa1gpYQ8WvLvn0A9F6VWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFvKel9I; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFvKel9I"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a1fb17bb8cso652298f8f.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314716; x=1747919516; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0VqiwVaqp1WMOjAp5Y0Sco8T9/NVA2JwgwbY11pkbs=;
        b=DFvKel9IDVHjwB3vksqPtcPxH+xdL6MVe2mej4OaH8NZWPK7V6Chki24NchhenJw0w
         f4N+RhwsSAtrX2EVKojQhrzRaPBBqqr4+/3Bp2KERJKsu4dzDd7QntdrghVOpR24UJGj
         w5JxFmpftrOsa43eZfePvmPncOb4MuRQaMsZz7lpBiPfm1USThDpNTXlcuNSKGhCka4C
         OmbMSe1kuFZ4eYL0B4FshitK8po8RoQfWSo3Z74Od9KXxd7Q1qtbZ/zNBkJfyvl0uXTt
         xnFN0OVqmtvns/PwKAYXCbk9nGaU6T5mhNXLH386vy9VYERPEcb9ZqwWDlmAyAsq+G3T
         YYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314716; x=1747919516;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0VqiwVaqp1WMOjAp5Y0Sco8T9/NVA2JwgwbY11pkbs=;
        b=qQzPTuSbbyI4RZC1YfmlykkIAPWBip5CoMXwTSAjqtJ5ztJPZRWSHCA19iitaoH9OG
         rmvwTDJaMvxn34yReiV3dFciDXuu+VmdjUJovmytTYfvaco6yCpEBY1SZjNu1mDWQOIM
         oAMowRZvdLTHLGAL5LyNqSm97BNld0yv8LehDqUUfOMih9e4gS21/yFkCgMiu1cRSrYO
         KWdZGyiFnbMutKO16o+yrrl/bMiA5gMMFeB+eoKAiCAM3/P7uzvlmugkWbkg5EnzoxSr
         vg48U/9N6su+KM6e2iH4W4R6gWA4OduJxpqburBIXMhHzPn4YYE3OJFOidoXgMIs8s9w
         yKMQ==
X-Gm-Message-State: AOJu0YyI7fqoK2n0NCNejJ/yYSUDLXihmtyh24i9L5wOkzfAZ0v0Ivq7
	aZDUz/58RzjVhfrrOyOg/IxdlYHOgV/DTPw7jzV/DmswQXg+W1FDa7a0rA==
X-Gm-Gg: ASbGnctmP3m7V+U3NUIlk60UphGY2QiMGuN9xeps4rii0OYURtnS9GVDkHw99LkXfVX
	70S7vncuxOIY1XibMU4ke63llJTtUyKKy9NFgBrQrErn22Pl34xL2ZOKJDcETL8udrza1XxlLLs
	mJRyQrftvikKZfqYWFS7CoSkzNPzkHnr3kjm0Geh/wyymnw2qswxRWaeL4KFkD8V10rkys39Y0d
	01501pYixdSShC9HgtpCV64XmXnrg7T0jeSdcO1gGEE3S3cAgRKePjkuVm4MEnZzpnjqyY4moFt
	hIGaItMy+2PLy2/RMLf0k9rHxVurgCAS0rLec4FmMFYZQCYvOzVgx5rbjeQkNKk=
X-Google-Smtp-Source: AGHT+IGgwm3kfDFf1vfUKQtJuyjPXUZJ2OFZHzgkC5MNh/F+a0EXU5n4j0YV6DHaRh6aNDyKMPDPqw==
X-Received: by 2002:a05:6000:4210:b0:3a3:5c04:8b63 with SMTP id ffacd0b85a97d-3a35c0491f0mr607945f8f.42.1747314715905;
        Thu, 15 May 2025 06:11:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c7b2sm22974247f8f.93.2025.05.15.06.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:55 -0700 (PDT)
Message-Id: <80422a5770ded04993c73c657b363ddad45e2f4a.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:43 +0000
Subject: [PATCH 05/11] has_dir_name(): make code more obvious
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

One thing that might be non-obvious to readers (or to analyzers like
CodeQL) is that the function essentially does nothing when the Git index
is empty, and in particular that it does not look at the value of
`len_eq_last` (which would be uninitialized at that point).

Let's make this much easier to understand, by returning early if the Git
index is empty, and by avoiding empty `else` blocks.

This commit changes indentation and is hence best viewed using
`--ignore-space-change`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 55 +++++++++++++---------------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 73f83a7e7a11..c0bb760ad473 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1117,48 +1117,19 @@ static int has_dir_name(struct index_state *istate,
 	 *
 	 * Compare the entry's full path with the last path in the index.
 	 */
-	if (istate->cache_nr > 0) {
-		cmp_last = strcmp_offset(name,
-			istate->cache[istate->cache_nr - 1]->name,
-			&len_eq_last);
-		if (cmp_last > 0) {
-			if (name[len_eq_last] != '/') {
-				/*
-				 * The entry sorts AFTER the last one in the
-				 * index.
-				 *
-				 * If there were a conflict with "file", then our
-				 * name would start with "file/" and the last index
-				 * entry would start with "file" but not "file/".
-				 *
-				 * The next character after common prefix is
-				 * not '/', so there can be no conflict.
-				 */
-				return retval;
-			} else {
-				/*
-				 * The entry sorts AFTER the last one in the
-				 * index, and the next character after common
-				 * prefix is '/'.
-				 *
-				 * Either the last index entry is a file in
-				 * conflict with this entry, or it has a name
-				 * which sorts between this entry and the
-				 * potential conflicting file.
-				 *
-				 * In both cases, we fall through to the loop
-				 * below and let the regular search code handle it.
-				 */
-			}
-		} else if (cmp_last == 0) {
-			/*
-			 * The entry exactly matches the last one in the
-			 * index, but because of multiple stage and CE_REMOVE
-			 * items, we fall through and let the regular search
-			 * code handle it.
-			 */
-		}
-	}
+	if (!istate->cache_nr)
+		return 0;
+
+	cmp_last = strcmp_offset(name,
+				 istate->cache[istate->cache_nr - 1]->name,
+				 &len_eq_last);
+	if (cmp_last > 0 && name[len_eq_last] != '/')
+		/*
+		 * The entry sorts AFTER the last one in the
+		 * index and their paths have no common prefix,
+		 * so there cannot be a F/D conflict.
+		 */
+		return 0;
 
 	for (;;) {
 		size_t len;
-- 
gitgitgadget

