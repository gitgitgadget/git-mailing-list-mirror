Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950A22E011
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127332; cv=none; b=nNVu77JKNselWkwidi7IMXd0m1nL+mZto7F4x97I1YVVWxGT51xEhD9oLRnm+qmvf1nIms/s9nViU8uOWMXBXjpXVcQ7kV2S/0jeMn4KEWw5F8ZXlL/A7rKLDpoL8mZa9WKsER7BxBxL0ejO6iyJ5ECjYZbLuZMTQ0j4lEASrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127332; c=relaxed/simple;
	bh=L4lxolB2tYaHNy7VDTe/eONuYsbby63x2s2HxKaWjHM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WywwcMBSiCNJI6OMyNO2Lwu6Ecb2BqHOpqnqeyqtKK4bg3iSmIQ8gkC82ji0EECd5B9jaMBzEMvJyxjyNUAId5phezKm8PWW5jKA3emIsDtFhzeQnXnrd8GYzEnACajMXBLE/WH8imvvlDTq0oS6+mpFHMyDM9TDao+oUc4whT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW5pUexr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW5pUexr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39ac56756f6so4887215f8f.2
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127328; x=1744732128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHNLSWzKsgEAT54mfo5BmzjuzXYWxeumxxUZzgW97BA=;
        b=mW5pUexrYjP/X55E96nDYOZ5BQ7XsCESNBqRqmtxSvK63Shj8a3ogdHzTeEe+cyEUC
         y7mE+pp0nN71E6n//EWBS+vF9ETMLxsh83ZMB9utvUQa6zVvhbT2j+ENfbFr6lGve6V4
         8FftNDRzxHD+w+JB07Q5c9Nml/bi6Q6fVfxnlCV3PCzK2P4CUlh8gaHe6iLw2phIrRFG
         UhYxbfn5/DfiNPq6dsJyfIFDwsimo7ZPpoyjNQ/XEGd729ZLBfc6hqhoZS6ek5fBDQRC
         QKMRMOqYIg3YTWkCbHuDRwHBIxb/6XAbni7CYsmwDIP9prym4hTecR/tx6sicwjPXcrX
         8ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127328; x=1744732128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHNLSWzKsgEAT54mfo5BmzjuzXYWxeumxxUZzgW97BA=;
        b=o1QXatAmHm40HjCBjRb5406cm1UQPzTUDa3rSvrgwBW559Kg/c2wN1Sf2kavnMF/lh
         Cn6ycPe0ljpQvX6/Xs8toXFGAyAw/SC1iHOlcZIK5hc1mEtKjrBXeeE3REEFxlmFRqCW
         Aex9GIhev093tuaMMb78nI/KeKOuOkBbJkUkNb97PuKrZ+xP/cB2dqddQwFSB69DSkjp
         zCcbg1KIu425bST4q/UPaiUUA15wwdIEDBp5Sr7/TR4rvQgcIk/KnL9sHdtxxEP5Y6+x
         d2JdAaDE4ZfZ2xqDnoKpPfrbjIn7dUR1LjXgiiuLRHniSITj0+DqvbGzNje8G+ULtjuR
         5iWA==
X-Gm-Message-State: AOJu0YxwylPW+6PHGwvDq0Lbb1KZJbemy+msfnIW1KKtidNmSJ6D9Pv+
	XqkLcud1Qx+b51dFA1E+wPuyBZIZEn5l9hX2Ar7lwARgdWS8R/U31/rZXA==
X-Gm-Gg: ASbGnct8W1qGHevoxB+p117OXvphKiK0FnvVKmXZ42Po+57Vh6C1wIVvDhHtJ8Gd6Fx
	WbsS+P182qJdoIyTjQnrdHSmxnpbOFRglGAMseBHP9AvlkkBHzy8Bsv13HSq/CKSA+cNdJCtbL0
	nRi9q9T+pzPwI0tV26vy+f+s4k/5Az/lRVqhfhecLda8cSQL03ea3cqKpJhoItJND8TaxhSUoiI
	mcd/whNCINlS5aBB0J6x5yY+ARGUNda3cCqcetX/RbMjcDB1FP8hNTfdRkGTgDC2ke1enfc1twD
	CXFUx6w8o9aLFTbs1KxwnJmxpzzHXeBC6Rx/GyqilHc9xA==
X-Google-Smtp-Source: AGHT+IHD0PZ0pGVIfb/QhpztVBFYBj8lLrS+B8NN+D3o3VZBJo0PID0cbzoR4bNqXHfVumn6WtFf9A==
X-Received: by 2002:a05:6000:4282:b0:39a:c9b3:e1d7 with SMTP id ffacd0b85a97d-39cba93ca51mr14353644f8f.29.1744127328516;
        Tue, 08 Apr 2025 08:48:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226f1fsm15404495f8f.95.2025.04.08.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:48:48 -0700 (PDT)
Message-Id: <6203589ac17be5571a175e92326f688c118313db.1744127322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
References: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
	<pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Apr 2025 15:48:38 +0000
Subject: [PATCH v3 4/8] sequencer: switch non-recursive merges over to ort
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The do_recursive_merge() function, which is somewhat misleadingly named
since its purpose in life is to do a *non*-recursive merge, had code to
allow either using the recursive or ort backends.  The default has been
ort for a very long time, let's just remove the code path for allowing
the recursive backend to be selected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..b5d91fd3515 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -781,28 +781,19 @@ static int do_recursive_merge(struct repository *r,
 	for (i = 0; i < opts->xopts.nr; i++)
 		parse_merge_opt(&o, opts->xopts.v[i]);
 
-	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
-		memset(&result, 0, sizeof(result));
-		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
-					    &result);
-		show_output = !is_rebase_i(opts) || !result.clean;
-		/*
-		 * TODO: merge_switch_to_result will update index/working tree;
-		 * we only really want to do that if !result.clean || this is
-		 * the final patch to be picked.  But determining this is the
-		 * final patch would take some work, and "head_tree" would need
-		 * to be replace with the tree the index matched before we
-		 * started doing any picks.
-		 */
-		merge_switch_to_result(&o, head_tree, &result, 1, show_output);
-		clean = result.clean;
-	} else {
-		ensure_full_index(r->index);
-		clean = merge_trees(&o, head_tree, next_tree, base_tree);
-		if (is_rebase_i(opts) && clean <= 0)
-			fputs(o.obuf.buf, stdout);
-		strbuf_release(&o.obuf);
-	}
+	memset(&result, 0, sizeof(result));
+	merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree, &result);
+	show_output = !is_rebase_i(opts) || !result.clean;
+	/*
+	 * TODO: merge_switch_to_result will update index/working tree;
+	 * we only really want to do that if !result.clean || this is
+	 * the final patch to be picked.  But determining this is the
+	 * final patch would take some work, and "head_tree" would need
+	 * to be replace with the tree the index matched before we
+	 * started doing any picks.
+	 */
+	merge_switch_to_result(&o, head_tree, &result, 1, show_output);
+	clean = result.clean;
 	if (clean < 0) {
 		rollback_lock_file(&index_lock);
 		return clean;
-- 
gitgitgadget

