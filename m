Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404B201030
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724933; cv=none; b=Co5YDuRCX1LWE7mHbjgwCj0evaYn9RcofbdSHUQUNgKACGJGFNAVtwayTUVi5FMiuKXtOuT4URnZDm6Mj91oofof+sD0vLnp2EQzXlr50CNoFfq76eGzyx1mi6vShirlv/G9cd+Qbx4KC+4I7zLGkSaBc6iRXaeG/JGDlarC5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724933; c=relaxed/simple;
	bh=ViU8JkW4ZR49GovRN3zlEVxut2zJE8Xl9HpWofIxyqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiUrhite2VJQholm9q1DfwLZ2e7nqs6eo2SptxrMN49fu+lieHwYqEM7UfVdM4+v0BUESwOzFdNNQg35OuuSNy0TE5B4sWldxNE6gKiobR6YWS/9+ZBFt9YkcsU3YZ0wsdUpnpldQLZ8eZ40Iue/NK4UBpoDTdPCZiK+o6bUwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzBSmd65; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzBSmd65"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so55222391fa.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724929; x=1733329729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7dDmM8xmKZjLvLDLK2A8x/QAigchVTAKjdpcKXYtEY=;
        b=RzBSmd65wzlOW3JsHqfkgmwirJyoNsKgJu048DgyApsIJzKNDXHQADZoxd59p6nK4S
         t22a/ipNMQ26VmP9qnVrYwziRQhiIW08wg7djvozDPTp/dfmCpP66Hx/uwT0eC/JcWu5
         HuU9pQ0sQSZQ+vidt4Zk1rhW7WcGaNibsx/Ri7QeaoZdK+HNyw3yWGWD8+uSqbMlnyCe
         4jw22f9BsYwn82MOhHHcyR7I5yFbwoxXDJJ9BPqroGuvdNLzzfwKLlp0E3Hq5Cqwt21K
         69uVKuxxA4Ro8qJ0VJyX6vUgiXBLOWI0GRbf8Ax0VJMi1Gx0NFqHTLZeCwb+GDFa/uBa
         FKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724929; x=1733329729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7dDmM8xmKZjLvLDLK2A8x/QAigchVTAKjdpcKXYtEY=;
        b=BaaDI4/yWJ8+ZqB63gVdyFE2L+iHz6RJlzSQCHFRC0jKCjrOGvncujEdzuZrRBc7EP
         jjSIICVgJILZAOjLNpIRpheKkF5GCp4e8SXppeFlEsNj3ddy1DhtoUsoXqDmrczawFHg
         OXpLUQFLW7B73oOBotCzGcJjrTx3sclakWKXG7UolMS0JVZkF2/lqPlPc9F8wtCIxCuJ
         WKtMKGhGHvzwS8OaABXKtQ3EJaTeFQxpWO2WoL6E8w9S8yijUJmyeYSN+pzP8TYJV3gI
         KPd0ReIwpPSvVxyjAQRWS6/s315/X2jZDt2LsHTOsKcSWcctB6LBhBif8IoKk+k49E3J
         w0sQ==
X-Gm-Message-State: AOJu0Yw3SLFX8PMNq8AGaK2qrwzTmShusntZpGQ4qHZ0jB2Y9XvKP4PC
	ORHIgwWIKi3F2qrxRMSw/e8qpMZU4YVCu1lVJ2spJjlpc7VJ3ylL
X-Gm-Gg: ASbGncsILEi84kKRqSSuJL6rAMfEIi2RZ/0pu7z0mhwPJaKyjVrawIgASgDXw9sponP
	OQEIY6QAZ6pSiCVmMUYmNHdTpl9o93m5JkRFz62rrumApu8GLGLb4jABTSNwKBoTJj3j2067HFl
	7AwjOMuyt6stqrkdws6rdU+qQbxgVCZXZljtrvue74SMXoCFFZz1IiPH/VMlmC9echayOPxcG9u
	bGYrqQo3m5wPs9MS9AMEbkirEl7G+zz0CIpXBzh5joWXuk+3aYdcZC0zI0R1g==
X-Google-Smtp-Source: AGHT+IEkdDsP3zvMZXLqQNxuWYhBxRx7ho88koznROpooWr0vl2mXHbxNMILBIY98z9RgXyEw57Z+A==
X-Received: by 2002:a2e:ab0a:0:b0:2fb:5c84:929b with SMTP id 38308e7fff4ca-2ffd60d2b4dmr31526571fa.36.1732724929197;
        Wed, 27 Nov 2024 08:28:49 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:48 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:27 +0100
Subject: [PATCH v3 2/8] midx-write: use `revs->repo` inside
 `read_refs_snapshot`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-2-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ViU8JkW4ZR49GovRN3zlEVxut2zJE8Xl9HpWofIxyqY=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i8kLXnJBXFv/8HlEEGyiS/sPDyghwQAHiri
 epdfTEIFaCJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvAAKCRA+1Z8kjkaM
 fwr9DACb6vSoyugrNWE93ZYASNRkLN7C+tG4+ouH6v6vvWwEc5AaRskS9qcBw0kbtowDdO7zvsJ
 +JXcRPPqhk56XCUj1/LR9ljEEW0KH4+Cbc2mn0tc/eBYi6SARiFDPqOU5inrRpm0iXAxV9VsvxG
 AVrspDY/P+bsRmzZVPC6ySfc8caAUDDMBEM6fddSYOHCmHEc2lsp0tH2l7qPIFPuhmisaob01t7
 RtiofDDZIxVxzFayDW6Rfcg4KO1EArAnSm/OptyPY//T+ikcAbkp5bAKD9hnz2t/NWXQdN1eaVX
 r+ngtUHOP2nkLyFvffDP3zLRVxcgZl3PhHmHhfj5bIe6H5+uTv63mv7gQiz2s9xCpVQFu8I4D6v
 QlrPcqFO0XLYrgGJw6omWGxZ8uBenFDyOdhoZulsyYI2cVYX6yrVjw9c0wf7k+RM4Q/lcof6GRT
 OaeQIXMqHt2yPEQboSf511/cLKaCdZJPjnE0reEqgyDWMDAoww6zFDSEmGmmF/s1stC9A=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The function `read_refs_snapshot()` uses `parse_oid_hex()`, which relies
on the global `the_hash_algo` variable. Let's instead use
`parse_oid_hex_algop()` and provide the hash algo via `revs->repo`.

Also, while here, fix a missing newline after the function's definition.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 22b5233f51ec6c6d99b8f9613818f1581dca5982..564438f616f59cd24edda956e4af0e0acf167138 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -760,7 +760,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
 			hex = &buf.buf[1];
 		}
 
-		if (parse_oid_hex(hex, &oid, &end) < 0)
+		if (parse_oid_hex_algop(hex, &oid, &end, revs->repo->hash_algo) < 0)
 			die(_("could not parse line: %s"), buf.buf);
 		if (*end)
 			die(_("malformed line: %s"), buf.buf);
@@ -776,6 +776,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
 	strbuf_release(&buf);
 	return 0;
 }
+
 static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
 						    const char *refs_snapshot,
 						    struct write_midx_context *ctx)

-- 
2.47.1

