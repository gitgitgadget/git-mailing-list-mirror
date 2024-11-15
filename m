Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58E1D043A
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678163; cv=none; b=V/Ifx+PPuwiJ/XeBTkMvzMZO74WTzddS85RoRMePCHJV9kpuF9xu4e2Ibsu7fX28PxFuHiSZE3XZwVNbyrM7PN0isoMIMtkfEXQPc2VsyYCp3zjv50eF2+6FZ4DVttH+w/drHo9Qbw+FWItnuNEldZIoxZYn9hSBctGF8VhQpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678163; c=relaxed/simple;
	bh=B+yWKCVwH9MSV2kgofDxL9IO8sMEtmQs880m3EVY6IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IjZEqy9mDWNnD6DVsTXtQY46fO1+ZOZjZgVHmF301vJlOAdvR4PHvLkb1eoQ80m3FlskLOu9JwbReKVw6MSGvHUCDE7Yjyb3WkjmI304WnBKKynm3Dd+nEwB+eIPGi8S9DqJs4RpWf2Ky1BuTB3pyfZjZGo3XiWwEqCjxs7dJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVfIc7Gf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVfIc7Gf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so2769761a12.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678160; x=1732282960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUY2PBAyRwiEfYAb5OAg43TZcqI7rH9ZB4X0qb0+1Ws=;
        b=lVfIc7GfFIVUXQ3nTgPgoPJfpGLoIMSsWnrOCPv9+HQKaNK+Y/0PYzNxjFKzbluck0
         Wakb704202WRiIV91PooPxGk3hr/H4+9V/mJGcYiNRlozaVebrN9ffU1XN2c1JjA32go
         OH4QuxzQjyV3+rIaC/fjh8HfSu+zxMi3XP8zyPVgOF0f1tXgKxjgCwIlDRbEIJ3PTdpB
         v5BqXidf1FVl1O2Fol9VoOjbH7nxz4Q5rfwsv5hYah8ahOYVvgD91VHwnA1+y+P2Ye3I
         mX+BcaG71DALu1REq3SCFxff8jszXr2h86DKrNX+CTjQ8xYctpIx0KeWHV8106y10tre
         ur9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678160; x=1732282960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUY2PBAyRwiEfYAb5OAg43TZcqI7rH9ZB4X0qb0+1Ws=;
        b=WCMINs6wCrWO5Qdw5JwjjWOFrDwrultIMSxviVb2g6Pnvxc1tsWeeaFF/83VL0AU9J
         3sfcK+HLpPGzIi0yDFEwsx+3QqLB0gfLfOO53HGtYp7jrw/rxk4Lac85YTO/C/6/mZ0f
         04SKREQY3xRFPa/M24pvYQDqgmk22LC3p21R8JJsVxzungSj0ijELfKVbFqyXUB2oVXk
         CwQw8TPyz/ONn+hgd24pKYDy7pHNy3R/dfwcN1WZj7wqSHNtVWkCJNNwULdRXn0bNn4S
         PELmoobMiXsSbtQELelsnuKkXdMQF8uJQFe8Kfe8aFi1eKqfZFFx+Xo23CMBny2I6A/h
         pt4Q==
X-Gm-Message-State: AOJu0YwK2A3mUgj4vc18K7CdfsbbqSheBVz9EgQTJ5tRWYcOfi/JLSuJ
	0kdmywkr/exvPbrO67+/WM/Pt4iZn/GLlP1wO4KloQRiQuuD3Xx2
X-Google-Smtp-Source: AGHT+IGpKpavXhPwTOeaMZJnapstFTnTpo9OlBSEO1KDKV+UKXJedyJlLVwvGOc5E6/Tg4RuS6OAOg==
X-Received: by 2002:a17:907:9344:b0:a9e:8612:f201 with SMTP id a640c23a62f3a-aa483555dd8mr240128866b.59.1731678159558;
        Fri, 15 Nov 2024 05:42:39 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:39 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 15 Nov 2024 14:42:20 +0100
Subject: [PATCH 7/8] midx: pass down `hash_algo` to
 `get_split_midx_filename_ext`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-7-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3566; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=B+yWKCVwH9MSV2kgofDxL9IO8sMEtmQs880m3EVY6IU=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/Iy3G0GsjeCLLwK97T1655wtbyhmufNviqw
 1WZZZ1wX4CJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPyAAKCRA+1Z8kjkaM
 fxL8C/412kbQNQAEqYq0lmayZ6zJs/r/517F5BYp5HjcAszWhZTdNWvE93WgwFO/G5q7jp/6GMf
 pON1fICEtatgmrAhhLL5d1gXKa6cnoj0a55qzgBnR10betOihVwc8vXc+b8c0XpydkwjMkzHAsQ
 fPOacirD7Nv+5DgauNls5ciMTEx/9v6jEHk1txG/Idzkr9C30YkIoKGsy6VP7jriGizN8FrC4Ff
 +z76wLI4LsIjUYHD6iMmkyjnYCVRWqh0a1WT6sUuWrba1VqYY4qcTWNjQ6aM3a7R5STRj0GiFsq
 jJiLH7+/z+rPLq93jgbbjPutpoS/+LXJSMNc/FzvsjpNm0XFQhAG+AaRNoe6GI36QMYF0ViRId1
 /p3CF0Y/6ugYvudNCIMZvXHpjDt/ykFxquH6cqLOuTPCNxhPTDLxjUXFD86LIMOkaqDyQx+yeDq
 dhBIcenOOhY0UyYeInOxUNnVPDHGmEUfPfUqZeJl/sqUM2VTNqCiXVP5/lJQPYGeDZAnM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commit, pass down `hash_algo` to
`get_split_midx_filename_ext` so we can use `hash_to_hex_algop` and not
rely on the `the_repository` global variable.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c |  7 ++++---
 midx.c       | 10 ++++++----
 midx.h       |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 7c1563845993075d622f59faeb25462180434abd..21a64f791cd8addf33437d85304dcf35bf17d904 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -992,7 +992,8 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 
 		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
 				      hash, midx_exts[i].non_split);
-		get_split_midx_filename_ext(&to, m->object_dir, hash,
+		get_split_midx_filename_ext(m->repo->hash_algo, &to,
+					    m->object_dir, hash,
 					    midx_exts[i].split);
 
 		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
@@ -1438,8 +1439,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		if (link_midx_to_chain(ctx.base_midx) < 0)
 			return -1;
 
-		get_split_midx_filename_ext(&final_midx_name, object_dir,
-					    midx_hash, MIDX_EXT_MIDX);
+		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
+					    object_dir, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
diff --git a/midx.c b/midx.c
index 9bed4185ff4d44602aedfe0329dd840ff9e85435..f45ea842cd6eda23d2eadc9deaae43839aef24c1 100644
--- a/midx.c
+++ b/midx.c
@@ -236,11 +236,13 @@ void get_midx_chain_filename(struct strbuf *buf, const char *object_dir)
 	strbuf_addstr(buf, "/multi-pack-index-chain");
 }
 
-void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
+void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
+				 struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext)
 {
 	get_midx_chain_dirname(buf, object_dir);
-	strbuf_addf(buf, "/multi-pack-index-%s.%s", hash_to_hex(hash), ext);
+	strbuf_addf(buf, "/multi-pack-index-%s.%s",
+		    hash_to_hex_algop(hash, hash_algo), ext);
 }
 
 static int open_multi_pack_index_chain(const struct git_hash_algo *hash_algo,
@@ -328,8 +330,8 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
 		valid = 0;
 
 		strbuf_reset(&buf);
-		get_split_midx_filename_ext(&buf, object_dir, layer.hash,
-					    MIDX_EXT_MIDX);
+		get_split_midx_filename_ext(r->hash_algo, &buf, object_dir,
+					    layer.hash, MIDX_EXT_MIDX);
 		m = load_multi_pack_index_one(r, object_dir, buf.buf, local);
 
 		if (m) {
diff --git a/midx.h b/midx.h
index 7620820d4d0272926af9e4eeb68bfb73404c7ec2..9d1374cbd58d016bb82338337b2a4e5ba7234092 100644
--- a/midx.h
+++ b/midx.h
@@ -97,7 +97,8 @@ void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
 			   const unsigned char *hash, const char *ext);
 void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
 void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
-void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
+void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
+				 struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext);
 
 struct multi_pack_index *load_multi_pack_index(struct repository *r,

-- 
2.47.0

