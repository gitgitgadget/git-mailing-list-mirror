Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBE368D4F
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048293; cv=none; b=BCQtGOH3es3q0aK6VuzsjSeNXSigrC7X2xGJHRC0TrYMtz0ZYUwextNdS6SB7kz3kfZ9kMqlwe4lFFnFg9HX9KBoqtj2XvonqOkgEp7XgJG847U2PnwYcf9kRcPk5PByn1t1HjK1trez+ciu+laqK5BZvemkCN19LZ9DB0lkMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048293; c=relaxed/simple;
	bh=s5arCvq9bFnL2I4wgMBpNh4BIoT6AVwSqQgmfBv/k1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bvn3re0pckiD7xvK8m8U/qL6/ZQ1UDffgwbCJNM0ACcAI0I57UypQoqngte58RBQLXe+mZYrBvly+urr4A6oUJwig22aarxoKcPtRMDGp1hLf5inmBRIQ4tESEYK/wsEbJpR7v5w1wXNMO6HSdDISHW7jTpoUGQdTYrSKTCfzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=cO36F0/8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="cO36F0/8"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cb20b0a387bso256955a12.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785048291; x=1785653091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhEDOfMyqNTg5nrV2k9lzGiwG+ecxuLuSMrD0PYZVU8=;
        b=cO36F0/8KSHNSdTefxhyAqIYXW53ydrvNb8cPhk7pSOKPwDfXXA3fg64L6M6oz/6t6
         QHbFX08Qg6NscvL7R6xIreZ8fYHPwFlYik/arHb7Qgfki1v9hcMXWdZEIP9GQlXbbPZN
         yVcbQHGOQDVEmBnZJz6/aDJVHBHbkJbbtzi/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048291; x=1785653091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhEDOfMyqNTg5nrV2k9lzGiwG+ecxuLuSMrD0PYZVU8=;
        b=lmwYE5sGtwClitOYLQDaRZlJwjcOFNhTxkGy9xB6uh+2a3JaKSB0Rrr0X6zvLFoYjf
         YmYfu6Wr6L+USlP1ER9ysicFtccvVdVMqMlHyvNE65UrVS9m+tiGX9S9gwhYPwoDCByk
         1c5/WmhEKX3FMjMJdWPnjn2Pi3J9xpuzYUGoCAbTQsBRqg8yV5qb5l7uEu9aY1BNC+dV
         4u54f1cg4uvd/9sKNh65KwE132FJBqHLt2ErBRM0nbqMcODtOW/sqBPzl8l7LIU9agV7
         TFuN0TnEvs3M04toG1PlBH49JnM2jl4UcwME5ZuZcEOo3L4bR/KyxRJJvbagRzntAn8h
         I4Qg==
X-Gm-Message-State: AOJu0YyV0Hl9tHGX2W5rRwavGQUKOcxupGaFz17h0Ku9wsnFQejmOCZt
	k7lO/8lvfdBXvUgIMO3Jkj1ahldVJwBiMAR6VkI57HxY1IYfX6mpaWg/gAwVV3Z20WznCJRqiKC
	FA8/CEyg=
X-Gm-Gg: AR+sD13+jrTi7RGNH1/Yo1hlFw/aM4kxc5uZWqz3rpApJjShfGVTVOUMP4RoMvZls6A
	N92lF1xwmPEZMLNpUonspFDpWpbLAnroKrvvLxCD9o+lkatHG+7Xjg5PQTyCSw9+va8D4ppJ0BJ
	5csGWQI4613PSj6Ga+p6I4AxApQp7K7BsHv/fabY3IflnheBWnaptA2Whzh2YE+5T+8fcEE4w3k
	V7v9V6iMn18pswPb7xRLYcMJkj7q9C+1P9B/6r/As6wk1Bf6TnorGjARr8D1g8T2wnWmwwzw059
	A8dXkivkbFjtOSV47HPEL/qSCGfVbyLGmNGeuR2Uex1EFiSY38QfwEnig+CnEKxon9clC7jaTjR
	LeOM7ZXXi9Qr8p/zfxWqxrlyeLSnV+eVD1HSkWiXR8d+XH1vhi/r+0CxZ/k7wGntKrlFYfS9nbC
	7l45bMQR3tjYivvM1amo4Vh61qNj6XR1m2jiComVh4sx0DmESc+gTtrLA/uTTKHkfQnkNUIILe9
	X+KsRUSlMlkSno=
X-Received: by 2002:a17:902:fda5:b0:2ca:d344:7752 with SMTP id d9443c01a7336-2cfde8c90d9mr31545135ad.8.1785048291497;
        Sat, 25 Jul 2026 23:44:51 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm18622982eec.18.2026.07.25.23.44.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:44:51 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v5 1/3] http-fetch: correct --index-pack-arg documentation
Date: Sat, 25 Jul 2026 23:44:46 -0700
Message-ID: <a79af009eaedf607ce5110d7b0f880af0a2764ba.1785047139.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785047139.git.tnyman@openai.com>
References: <cover.1784874850.git.tnyman@openai.com> <cover.1785047139.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --packfile mode accepts one --index-pack-arg=<arg> option per
argument passed to index-pack, but its documentation and option
dependency errors still refer to the plural --index-pack-args form.

Correct the spelling and describe the repeatable per-argument form.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 Documentation/git-http-fetch.adoc | 9 +++++----
 http-fetch.c                      | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 2200f073c4..12036e65e9 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -50,11 +50,12 @@ commit-id::
 	URL and uses index-pack to generate corresponding .idx and .keep files.
 	The hash is used to determine the name of the temporary file and is
 	arbitrary. The output of index-pack is printed to stdout. Requires
-	--index-pack-args.
+	one or more --index-pack-arg options.
 
---index-pack-args=<args>::
-	For internal use only. The command to run on the contents of the
-	downloaded pack. Arguments are URL-encoded separated by spaces.
+--index-pack-arg=<arg>::
+	For internal use only. The first instance specifies the command run on
+	the contents of the downloaded pack. Subsequent instances specify its
+	arguments.
 
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
diff --git a/http-fetch.c b/http-fetch.c
index f9b6ecb061..601a77c3c1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -155,7 +155,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
+			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-arg");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -164,7 +164,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
+		die(_("the option '%s' requires '%s'"), "--index-pack-arg", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
-- 
2.55.0.openai.131.g83a728de1eb6

