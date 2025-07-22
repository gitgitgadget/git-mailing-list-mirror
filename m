Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC123264A71
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197798; cv=none; b=nvwrvvlr3WlYcU07kcub979vIp34XPRCg3CihRysRmyajAcBMMjghg7NRLLV64UoAmvusC6WpE1EL9jwUIBvu2kDMjp3t/Dcxs7Ih5jGt1A83w5dajnIbHn9FyWFbkqSvxAiS69CDoGXsM1K7GW8J4hv0PtdgIJ61cVFK77Rvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197798; c=relaxed/simple;
	bh=h28Zpuwr2aT+L8LcCx9BgrFwS268exxoyRg3EOF7lUQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nUUA/5mykvosFfil5eoVilIOvpN54Ad6mQIFfqcMdSkjns+SwIbHnVmS4qRlfcOCPm3QTk6r69PhJyuOZOxKthbLejNK8Z/HwaGl3fAW1mTsW4EutU6y7Nbh90RixWl66gosjlCaLih5DjfiOTa28fbo0T+BVWUUY+DcbG0NKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZVA/ZC7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZVA/ZC7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45619d70c72so51518075e9.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197795; x=1753802595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/A+51K2ywUduDL8AQtkLj2uWNhMnEXOkSFhqSgNP78=;
        b=GZVA/ZC7BOawbzYrXkuqruB5JIOefda+zYaCHvEeqf5bkh2UhHn1U5FszjpFNG3AWp
         MqjGL4MA0c94wGMrztvgYUi1tbXR9YQkCYo6Z5tqL1fe9Uv6K/NTE72UA7TbJDHjm/ZZ
         Zn7N/MZEyIFrwHgmxvhdaRdlKMqSEnL1/1Yu+Y3YwuJRKU8odXKDJah0MPJ3daVF76kx
         CZzsAAT+OEIoL03VR9QRRDPTcUE1zlYSaZ4k/yRwAeqPqHl9LrAqt5tbaB6GBR47X7gX
         9NXz65JGcO4HvoxPaSWFRc/lUgbHgj5ynLHHkndm9bIjPavZYvDsx3I5/APS7GOqDA3m
         5mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197795; x=1753802595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/A+51K2ywUduDL8AQtkLj2uWNhMnEXOkSFhqSgNP78=;
        b=YLTq3gUqDHYFLKAPeEkUVsgonw8aQLT0izzaQQZbXLgijiGPxSdOxk7BPcxfj76WIl
         FvvYwDtqyXQp3swjfP0WGGxfnZEzMJcau6urkqKwXpPFOlnQ7Om0NxtHloFevCdYtj2W
         tExeWA9GWclJ1cGgUak4POIXrSwDbSaJCz/W+ZDjtC/0ie4l75qvW7MM+NBqp+Dc5VAE
         nWJWnNxWzkWEIBZOsgQMldim31BjsJnjqRsIm+GSwZtFN6pSnhuWpMkKvF4AAHJWT5K8
         SDR8OTzWoOINMzDnxoPJzf3mFm6kle6H9lCM3taGKtwsknf6GHhdw0D5HO2sP4As1UvE
         P4iQ==
X-Gm-Message-State: AOJu0YwnAiD4yUtM0trX5cF7zen12K6QKbZbqk0YtKL7PvoLQRLv7bYP
	Pvl+psmQ7GwvDvtKvQ5E5N0SQ8+njIFU6qIMd3qT57MITTqSpYbh25RftB7jyw==
X-Gm-Gg: ASbGncu5bho4B/Cvv3Q/jCSEEozUzMgbs0fh03vyGJp8RL8o7doQv09DdUtNEt4hW6A
	fgWVzFo3EHyw3/JLUJ0lMcWKDhhupqhZWWplc9D4rZUrD8W5vglf/Xx7GqHxORp7GFDz/kOK6tK
	zCbruySnQ5pPgcMF5BdQWpGO2fuRkbDxZhpeOtc0TGH6S71+F3VelamASgnA8bGdDT/OYI+iz5S
	JwaqJfwp1Er4maEBEfHTs/opqpHTJjZ40YV1QnwZjJTBfwtdeHMRoANxRZz2ClmH4+SIGVe+Ivn
	eIjWy4GwQdyYY5C6+OJWU2S1RnzD60MTBuH784m1YYl7F48QtttYSRp126LrS0g3kXcW0JHPMcF
	ZE09c+0gssVninZqX/Y1AS7o=
X-Google-Smtp-Source: AGHT+IH1imnss1attU9xxCzUyoirJHIZhcyb2B1vbhWaNzzZ737P2OcejwLRBoMfYG/4baQa8Px6gA==
X-Received: by 2002:a05:600d:e:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-45862750f03mr31423925e9.10.1753197794405;
        Tue, 22 Jul 2025 08:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25678sm13562749f8f.12.2025.07.22.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:23:13 -0700 (PDT)
Message-Id: <58df0710efc042b014a0c8282ce1d7fa62fbb760.1753197791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Jul 2025 15:23:07 +0000
Subject: [PATCH 2/6] merge-ort: drop unnecessary temporary in
 check_for_directory_rename()
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

check_for_directory_rename() had a weirdly coded check for whether a
strmap contained a certain key.  Replace the temporary variable and call
to strmap_get_entry() with the more natural strmap_contains() call.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d87ba6dd42bf..9b9d82ed10f7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2580,7 +2580,6 @@ static char *check_for_directory_rename(struct merge_options *opt,
 {
 	char *new_path;
 	struct strmap_entry *rename_info;
-	struct strmap_entry *otherinfo;
 	const char *new_dir;
 	int other_side = 3 - side_index;
 
@@ -2615,14 +2614,13 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * to not let Side1 do the rename to dumbdir, since we know that is
 	 * the source of one of our directory renames.
 	 *
-	 * That's why otherinfo and dir_rename_exclusions is here.
+	 * That's why dir_rename_exclusions is here.
 	 *
 	 * As it turns out, this also prevents N-way transient rename
 	 * confusion; See testcases 9c and 9d of t6423.
 	 */
 	new_dir = rename_info->value; /* old_dir = rename_info->key; */
-	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
-	if (otherinfo) {
+	if (strmap_contains(dir_rename_exclusions, new_dir)) {
 		path_msg(opt, INFO_DIR_RENAME_SKIPPED_DUE_TO_RERENAME, 1,
 			 rename_info->key, path, new_dir, NULL,
 			 _("WARNING: Avoiding applying %s -> %s rename "
-- 
gitgitgadget

