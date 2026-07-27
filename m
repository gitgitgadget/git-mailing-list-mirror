Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BE1F5437
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112140; cv=none; b=P8GigJTT9hSRLP/dkRWYoSj5o4y3FGSQcW1iONyqS2Cy+GctUMyKAZpg2GP4VsuycyVsXVG/WitO9IuyIooJjD1JtqqbeeP/QJapOBUJ0Yo+UKLMYy+VfX/xFGg5OyaWLDFrJ/RzjEvo0y8x+wF0dbHZyQLM/IyLTFpcIuo9lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112140; c=relaxed/simple;
	bh=s5arCvq9bFnL2I4wgMBpNh4BIoT6AVwSqQgmfBv/k1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVHDqikXZk0HiTKDEmADJ+TFFzA5z6cF/LPCbvH+1ByB4eCEmDg6hXaNIvmWi6fnJHnmAOQR5N4K0mU9hs6LXJSpjEgXYuA2ljKwvx4HlDuzb9c09LEP06n1pvDkaFvSznANY856znkVZMnyNKI3VaTlBeLEiKSInXaiZHgNbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=H58x4Yah; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="H58x4Yah"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfd2e4e83cso4426545ad.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785112139; x=1785716939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhEDOfMyqNTg5nrV2k9lzGiwG+ecxuLuSMrD0PYZVU8=;
        b=H58x4YahO+N0ZnypEHZlp9tH6oyI77k8Wo0hEXqAoSJNAKg7ZjVqJJ9aZ0yZypTGqr
         j6eEFfMIoOgKS/LXGfqB9FlDTZ6qmIb0f9e9DSgr49c5PHwgREyhNwTnA2g4pXK2CsBa
         AEQ5KNid0Adalr54474f0SPINn5DEk7080NUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112139; x=1785716939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhEDOfMyqNTg5nrV2k9lzGiwG+ecxuLuSMrD0PYZVU8=;
        b=TlTVncW83JWz5RRkuHoAqYkHyF9HuMhzSujxEpt9Hkp6z22oernGXHLAbeKXxEeLdt
         FP0cfEfaractk74ukZYZ+E+jGXZeKxY3Ey05qQECDPpgzfR2xU3N+t7y0uuP15GaRj90
         EJNVpx9JYbczw09Ekpv3xMHvIAP35RWyF3nYEimk7LZDWqa31PhUfeb7QrQzHd/Uvb/V
         35ZpWx+TZy0ThSIKacaSkTyAV1NB/Y7Tgne5HQUaSQ9OAcu8nGRxQOL2wQFlGs31T7eh
         PNagyhj+OcFcpqHbkvqZdIOmwvfzStzLR4BLIo5C/s+JQvrYviclgYrGk0fETED/Omnr
         Vb0w==
X-Gm-Message-State: AOJu0YzNzs3m1G/ox9v0MmkBMMypb8VHdFLekiFs2ByeUDK+KJ50ScIb
	hlMJhQuRMx7ZrJIWUNl4ol435ZbCA0UoN6I+U11Mo8/KxAdt0CtkvGx6YBH+1h78qZIoskQnkDJ
	66P8jn2c=
X-Gm-Gg: AR+sD13nqRcSHhmtt5f/BJHtf6lnC6v9IGR3s09cHQLguWah03Q3kdedRDfyR+sMNEZ
	uuVcP4wo+OETMfBsILsbtF1N3AJHxyBqC+sWe68ZMEPcRoobVEKDco/ob7MYN+tMLTJqcA8vbsk
	G9KYqONSLOkQTRrfhPX+8GZTQ7u4zFbnDD8mYH7Khy3Eldoi7o/BzsbiJXxxVVTudAOy55gYhPE
	8GTa5lQhiyC7N43klANFVmKCeQEAzagLJL9ZnSdsfTWdH/tc8nyGp5V6hij5z0AKJxwDClhzcCV
	woC3d+WV7DKO33P+q4y/NjeCuXQlk8Xr3FyfyBIdYNb1EmhKIXzGID1DsGft/Au9kmtgXqvWDG6
	8PIDFwbySaA9WXpGJXrGZu6ysnaFhlZR8xceH+38xHW6AtBitXxZ8GtuglKnyudJkrxoYoPemt8
	c7Svl2RB3PKBoYSrjsAGBk1MSUoWs6e0fTIV+WMG98vxj5TDQyRNcI0nLeNzmuideFNtcUj2iz9
	VsOEH8=
X-Received: by 2002:a17:90b:58e5:b0:37f:eda5:516f with SMTP id 98e67ed59e1d1-38f2926773fmr4290221a91.0.1785112138672;
        Sun, 26 Jul 2026 17:28:58 -0700 (PDT)
Received: from com-76773.corp.openai.org ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm19920328c88.8.2026.07.26.17.28.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 17:28:58 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v6 1/6] http-fetch: correct --index-pack-arg documentation
Date: Sun, 26 Jul 2026 17:28:38 -0700
Message-ID: <b5050a88ca8aa0b73c099ac773b07bd2bf398eb1.1785111375.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785111375.git.tnyman@openai.com>
References: <cover.1785047139.git.tnyman@openai.com> <cover.1785111375.git.tnyman@openai.com>
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

