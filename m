Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A151D1305
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031004; cv=none; b=bltM5NUCmZgVaGhTHvzJFyPrb8cXi6oTHP70NMsM+AqPiFyFzX464HOauMpCOPT8PtCVC7zrwof8WwtTmzPREhm2AfuooG613IftTAcRNius7Oy56MrD4ZAl/7Z8z81aNvcX2g8Pfv7hqfKojbr3wIXilwZ9/RXWBd+YHl8NVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031004; c=relaxed/simple;
	bh=HxDtD8DknHPW8DXYsfgyPUUfTpU4z8NEOgyKhiksB8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGrIFvX2FxlemUfsJ1hZmmaE9F1I4Iy8d5WAHWvXVg8q5eCCKlDedQlGgg430TJS+5zTHoTRrDfAdIkcLEUePOr7SzXX0qv988NT4vIbi6Ur25yvG0OLGbzcjqStS2+dkA2zUJGOcuVC6SXjZlKgpxcELk1T1lJ0GGUFIDaZcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBjWrpla; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBjWrpla"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfcf4df87aso2757564a12.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732031001; x=1732635801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jpwe/28YZXBUxqjGOJAHRbt+/JfyYzxrWftlOOkswNo=;
        b=KBjWrplaA5y9SwAljXIR1a1aXdBhPl3gQOC184dA3OzIPGyfp5TFqvjzfkj0G5t7DK
         Wc+jpZdMZMfnh9B+E7Au6CblsAhfnboLXwWR7aFdFD2FdIJLf/KGoLg9V0W6nDVsTH56
         sC+NMm5ryr5BLrczEWlrh9zIXZM/T/f4qu+BknOJQUyw0ys/j3f8xCAHK5LNov6HYj/O
         eKbO+O9LKI+8DHQY8EEdNm+FgBXgE0LhcCbPM2IYg2G97U86Lp+456oG09Bd1jcqv9Ww
         AGM9YmtoCJ60veSZc+XTwKVYBZCIWtcM9q0V3ZtoKrInFmred/aOFwu0msvA5YWJOVPC
         lBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732031001; x=1732635801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jpwe/28YZXBUxqjGOJAHRbt+/JfyYzxrWftlOOkswNo=;
        b=n91xAoW61FLY19cZD5vBOLB2bekuwkv85Y+pru4hTbcL0W30RNwSTjl6yxJjIja1lo
         YNqBMJyj6dvHJPxIGRQBh7+GyOle8lKA/dfMAEyHjD/4mHW2VT7RBfmZmzSY2ArrZMt2
         M+ilD9jVpY7r+Wj7owVnbDsX/zJOBbbgNuWSAdNgDSOFX8xbhxWAjDsSHEIRiQG3/gFS
         DZB6s2nMR8vQRJC3u904EmN96V+ern+QLHl7JKkLz27hPWNr3lDum3FL8boEC6CsklZR
         GIRvTjE0pzn+k3kj8bobPuAJnb+QALxCCtAmmGmh0E7oARkywfTlcT/5NnW0ettuZWwz
         gj2g==
X-Gm-Message-State: AOJu0Yx0WKy0Pjqj+OJQkbU4vquIF1VXTgl7eM06GySn3ET+ja2Hl1xX
	rvRjMFHu60mFHg2UMgjErpB+e2v+qOPGNPPVrp5mhdr6b8VZNRoeC6kP+MkS
X-Google-Smtp-Source: AGHT+IEVsMTSUfZxVHHbVvnz4X4vVb9j2xI7JoydCgFBqZ/SeB7Kt2D1BMnmUNcm8LRrVSM7KwJYvA==
X-Received: by 2002:a17:907:2d91:b0:a9e:b08e:b02d with SMTP id a640c23a62f3a-aa483412861mr1609434166b.18.1732030626012;
        Tue, 19 Nov 2024 07:37:06 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:48 +0100
Subject: [PATCH v2 09/10] midx: pass down `hash_algo` to
 `get_split_midx_filename_ext`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-9-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=HxDtD8DknHPW8DXYsfgyPUUfTpU4z8NEOgyKhiksB8c=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYJK0sZMXXbcrpghcd0g6FGNUuLSpJzKQD8
 wAPmNvhnY+JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 f8DrC/0VkX0QeVtDJNDGlmU4t3Y3WAMT60UFnX7c9FLpsg/YdgkmDv5+eFi9Y9geF9s/VCThTea
 vRSWXKqUTmQBtHDyPctkqGnADtlZSEEqZQ9Q0fWZPRlE03z251LLnu/DbN7O9ifLzPwGDyzawR/
 sNqp/CLIP/CcE0JrO6v91hL4Xf3DxcyKcCjtc2dk9mNDzZv9tQ085InMYeUpOrLHARBPmH3XY/x
 zlaMdgkr6Xg2Q6XDioAG1ChrgtCGPpDy353WZuUcmrjyn6e5U+KdV3g25tWgjuQ/we89awl4Vr0
 1fxmot3c81ccXYlz4867imwfYk6CCqTYQk/SB8KTTxIF+QoGXyUE3XbUKPT0YBA+VwsywVbJk54
 7zsNKEgsSk15XYl2YArAVwhg+SoqNF1EOR+1Gevv7y5+fU5OTjdc+EH0ic+Ma4BJMv/MEgZcCLz
 ZLr6kS4nsmiRcNgF778zZOwSCkEdT9eoYvRfu/QyFAon6ZwXfl/f3QoEHypydJkYiyFts=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commit, pass down `hash_algo` to
`get_split_midx_filename_ext` and use `hash_to_hex_algop`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c |  7 ++++---
 midx.c       | 10 ++++++----
 midx.h       |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 2f0c09211282fa651af8f9a342f0564729468306..bcd1d50eb0f5c292c904a38f13279b1ebec9c855 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -993,7 +993,8 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 
 		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
 				      hash, midx_exts[i].non_split);
-		get_split_midx_filename_ext(&to, m->object_dir, hash,
+		get_split_midx_filename_ext(m->repo->hash_algo, &to,
+					    m->object_dir, hash,
 					    midx_exts[i].split);
 
 		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
@@ -1439,8 +1440,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
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

