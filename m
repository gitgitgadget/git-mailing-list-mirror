Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439A81AD0
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324606; cv=none; b=gl3/oyAyzs3IgPRIDnPaU5mtpCvaa9NgzjPCOCWN52NAfj9V7gkgmgGHjOLhOARAZoGgc6YYO4LtTQaR1G+1NUJXDWvKbIlPQrycGsFcfdfDCDXNHs3Ki0qSrqVzlmp7rmuVuLGoUKr6NYjqw/ATBMaRxOkUyqdahIOzxvhxRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324606; c=relaxed/simple;
	bh=qgaCTcaCONfClr99VBhYoiILbaY6HRx47+FyShzOq4I=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Uw8LzIzOGMHwjmUVCIASY9Op1dmrVR7YxgRyj/4tU+mUpdyCK4mM4E6KfXagJgxANiVW/z/aJDgT8U5GVR3RzAvNnHlS2w2Da4GcBvV5H5wCCM8twAw9zg4EEhM8NjJAyoU+z/Bkv/7NWq2c0+LhYK6N/6tsspYDwjilFbxxbc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APztVwO7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APztVwO7"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so1137266a12.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324601; x=1707929401; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cmSjmEwSf4IcLLAiT/MjedmxtuGZLWacEhH+jTj75w=;
        b=APztVwO7rxzlOkg3eNULtP/q8vO95Xf5+as0l9gj3/4sqckwFfl+viEMDMR1KnRcm4
         FjiE8jkyl/qRMgyJqqiJOUwv02uqySP4txLM07wAYShG23qDVnG7HVhj3lUzCcwH70va
         64cJG5tk8KE2Bqs0KiOOyjUkI9luowFXmmQaGGWwYODvGqnpxSfys3uD1M8py399NUhN
         wtU4N8MxHZF1hAX07qEZlOBndpRfC6DPy4KefU4oCgmBwrMnV+P0k/IDfAWUKFTx8bv3
         kcp8hs8/nCmlL09sB/ohhkIP5MyqKBmL5PkuLMVV4qrA5e9IMNUtkE678EjF/BCwADKx
         pcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324601; x=1707929401;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cmSjmEwSf4IcLLAiT/MjedmxtuGZLWacEhH+jTj75w=;
        b=eE3p9yIP4inQ4w5DXxpP/Ow32yuDApryq9Ptvo9LFNjGau0Z056in9jB3ZWVmXDAiL
         azuvmZEzvJU8fnCYVc83lFIehq8AScBH5pr7Th8FHOVWZSEHGOEkN1l1i8/Dqa2673hU
         gbVRaVdGAJL79utuCo5rtNg7wUZ/4+RiStwcTtxKXlea/nVJZLZPsfgPwvXpPVwHn5Wi
         +ZBV9JxiLxbK4rf8b4iga2CubjYuJlhsGfmOs6LhbLXftZRlWggVvMR9fGOzmiiMxLIo
         nLYyqYk+KRudi9nzdJAxFM/PxQCjH7OyjBBoo8SkKo6ZaWEIOK9+eUrDKpuxxFuNyOGM
         bmOQ==
X-Gm-Message-State: AOJu0YzDDoNUEWur0qpNBc7bGmkvzGWZato+rHzAt0uo2ePiWFFeA72Y
	SNFCh/MEr+v/cfqoKi6ybfL978JKIB8AuRYgZCDjlXmB82HPu+XGi4y4n5kw
X-Google-Smtp-Source: AGHT+IHm+F/VdMHnW8GHTsensPKAqArASEHtYJbXP6WwfMHt0bIoryHU2eyhwS+pbYcEUNsgchLIUA==
X-Received: by 2002:a05:600c:4ecf:b0:40f:d25c:41d0 with SMTP id g15-20020a05600c4ecf00b0040fd25c41d0mr4997991wmq.29.1707324278711;
        Wed, 07 Feb 2024 08:44:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaaDjnZiX7RpuzvyOLBNnPlIkzn4+whVyM5QYUV4/0vG/5dwH3GM/nIcDygfS1a1BZ30thTG1V6o90vGvYn8K40hRRX6IFRX5Qyg==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a056000111100b0033b50344a97sm1410534wrw.7.2024.02.07.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:44:38 -0800 (PST)
Message-ID: <4dedc5704c3af6ab4ec8cc7503dc826480775b8e.1707324277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
References: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:44:35 +0000
Subject: [PATCH 1/2] show-ref --verify: accept pseudorefs
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
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

"git show-ref --verify" is useful for scripts that want to look up a
fully qualified refname without falling back to the DWIM rules used by
"git rev-parse" rules when the ref does not exist. Currently it will
only accept "HEAD" or a refname beginning with "refs/". Running

    git show-ref --verify CHERRY_PICK_HEAD

will always result in

    fatal: 'CHERRY_PICK_HEAD' - not a valid ref

even when CHERRY_PICK_HEAD exists. By calling refname_is_safe() instead
of comparing the refname to "HEAD" we can accept all one-level refs that
contain only uppercase ascii letters and underscores.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/show-ref.c  | 2 +-
 t/t1403-show-ref.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 79955c2856e..1c15421e600 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -172,7 +172,7 @@ static int cmd_show_ref__verify(const struct show_one_options *show_one_opts,
 	while (*refs) {
 		struct object_id oid;
 
-		if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD")) &&
+		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
 		    !read_ref(*refs, &oid)) {
 			show_one(show_one_opts, *refs, &oid);
 		}
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index d0a8f7b121c..33fb7a38fff 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -174,6 +174,14 @@ test_expect_success 'show-ref --verify HEAD' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'show-ref --verify pseudorefs' '
+	git update-ref CHERRY_PICK_HEAD HEAD $ZERO_OID &&
+	test_when_finished "git update-ref -d CHERRY_PICK_HEAD" &&
+	git show-ref -s --verify HEAD >actual &&
+	git show-ref -s --verify CHERRY_PICK_HEAD >expect &&
+	test_cmp actual expect
+'
+
 test_expect_success 'show-ref --verify with dangling ref' '
 	sha1_file() {
 		echo "$*" | sed "s#..#.git/objects/&/#"
-- 
gitgitgadget

