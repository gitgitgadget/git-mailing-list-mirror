Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0A202F70
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782034; cv=none; b=fZ/BIfGccYchhqj/5izDuEijLySg2v756eWT3ZCkTHwfAibe/QR3gdz487n+IH8XG0aujR08oHJJcGmwyjw76UFmUZJXELVCt7LTRDqvdE9aJKmAXpDdwFDsODekjnII6j1wDOXVp2yU+KrzfgsPQq3b02/H1Ga40MUvqxIYgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782034; c=relaxed/simple;
	bh=pN7YS163cZvLU0vZNu0FruA6AYLxAaqtHxusOARUrxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjXSAe7sD0wlNXWkwLPN0k148YuYWzG3tMPbbaSv3ST79DF60vuTjM56I+MPjblDVcW6Hd07epa48/eiGAa9PMXb+RqeYF84FbXWb59Vj6kessxgeYRZ+FSY4P+YN7DbzHLf+Dme4wuDKdV8Pmo8hkUfaYXQhDKVcvCq6FdEAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgdkQswh; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgdkQswh"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so1223678a12.2
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769782033; x=1770386833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ2fk2hPLeGY27yY7QIJzWdgo1ZvQRGA1sM5tlbGXZ4=;
        b=jgdkQswhLywFtSVQuKIbc1sfNSUvjdl8oMzMja9P+g9WsRWGJexs/iIg03hA07YrAp
         79MZSy0nRX6AYxtgVAySuaYByLYd4zca4VmVgK+d0f+du8h7GnaMX3l+pKLVSV9QGTIP
         KvatrNNaR0KFYUTXuP3iFIkENySPELmudvtIrkKGBef4RGwLzyFSWs4ZEGm9GTVD0J6i
         lFwlK1FIX7KwtQ5wucOxkApbWGN8t91e3jHhEzkCDwq+GNnrjit9Zklrkmw0z2V2VpHu
         7O2HgtZXM46PNsGPMjKSC/ifKieRP2rs16gCKrdkyjxUh/9JZAdbHVgsw2ok7Hcg1kjq
         962Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769782033; x=1770386833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJ2fk2hPLeGY27yY7QIJzWdgo1ZvQRGA1sM5tlbGXZ4=;
        b=Yg65G5cZxP7Ksv5lAO5YaLhIZUR+om6Ck3otk0ifAs5wyqTqDAXou0MzI7BvHy9mZI
         JMcSoofr0RdPFqKM25WzY4RP5VasmIqahO6xolIw2GtMUVGogDtEO8SPYOfIRDZT9zRg
         PLqGIqq2ulx2tyOw6C+tzOqmAI/mjQujZiXmvbaAOCKdVdH11Q0mHS2GkmHdXigI9rvB
         w7vAhYxzRNldYmjp2RQLTdKmmmNpU0HMBm3AL+kofPlEoENoNX/qen3ZvL/a26NkyTOV
         /P4swjGtD43im0UBfEFstZ9X5UvcZPnPQ7ysuqMi4nvuHRo7I8o9vwNK9ibKgTnxngS0
         A8Og==
X-Gm-Message-State: AOJu0YygZEyn7n6EhW5j+WrkXfUox6O3BkyPHbuiFzvpjYaP1Q4Sje/c
	jcXHaQDhDhC/j2RJkh/s/M2vB7osQYDaGIysxrLimNOEEQ1QSAJTc0sO
X-Gm-Gg: AZuq6aJ40YsjiuAHoKzybHUYxB1tkpbKgodHhcB30AI+EBkufW6y+N3KdHu3aYXhHh5
	S+lERDkWJndA8hAntTb72fvoSbQglcXvUJJrlEwuW8V1LD2BHoSXROew4NwNge2KRnBzag0OVyl
	KEpuuVDMPy6ADj/vM6ErmWGT2NPerV67tpIu5ePLt/CAI4VAGQ7alETIKWGEEw+cPLAJM35Ndse
	uFv4lR/EmxCEdWtSesc+AzPK4N1ARJxhloDvM0U80LTWAGka1S986SVVMny6wPqXznSGhtnrKKu
	JF7ayUc8U7ocE4GZg872YbJivEVJ0eoJVMUenDeG5PdhVwGnyUmW3R8gyBya369lu9Xdhgl6gUp
	cfPfz59ToR9IjUUNI7hAInTe3N82e/m7PHsenufnt+PnHEvbiv2L9l2rbrPTPa6bGtDU9HLVt1l
	Qx5hGNYY6qfuXtkeLUBHycBO/CVljT9oicFQJwEVWpr50=
X-Received: by 2002:a05:6a20:94c7:b0:38d:f988:613f with SMTP id adf61e73a8af0-392e01b3642mr2932154637.80.1769782032500;
        Fri, 30 Jan 2026 06:07:12 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3edb50sm8605883a91.13.2026.01.30.06.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:07:11 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	peff@peff.net,
	pushkarkumarsingh1970@gmail.com
Subject: [PATCH v2] path: factor out skip_slashes() in normalize_path_copy_len()
Date: Fri, 30 Jan 2026 14:01:44 +0000
Message-ID: <20260130140143.5579-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqh5s4b66w.fsf@gitster.g>
References: <xmqqh5s4b66w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Thanks for the detailed feedback.

This version keeps skip_slashes(), but drops handle_dot_component() and
restores the original control flow around the four dot-component cases.
The up_one logic is kept inline, with a short explanatory comment as
suggested.

Changes since v1:
  - Keep skip_slashes() helper.
  - Restore inline dot-component handling.
  - Remove handle_dot_component() helper.
  - Keep up_one logic inline and add a brief comment.

Thanks for the review.

Pushkar
---
 path.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index d726537622..1772fcb21c 100644
--- a/path.c
+++ b/path.c
@@ -1112,6 +1112,14 @@ const char *remove_leading_path(const char *in, const char *prefix)
  * end with a '/', then the callers need to be fixed up accordingly.
  *
  */
+
+static const char *skip_slashes(const char *p)
+{
+	while (is_dir_sep(*p))
+		p++;
+	return p;
+}
+
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 {
 	char *dst0;
@@ -1129,8 +1137,7 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 	}
 	dst0 = dst;
 
-	while (is_dir_sep(*src))
-		src++;
+	src = skip_slashes(src);
 
 	for (;;) {
 		char c = *src;
@@ -1150,8 +1157,7 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 			} else if (is_dir_sep(src[1])) {
 				/* (2) */
 				src += 2;
-				while (is_dir_sep(*src))
-					src++;
+				src = skip_slashes(src);
 				continue;
 			} else if (src[1] == '.') {
 				if (!src[2]) {
@@ -1161,8 +1167,7 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 				} else if (is_dir_sep(src[2])) {
 					/* (4) */
 					src += 3;
-					while (is_dir_sep(*src))
-						src++;
+					src = skip_slashes(src);
 					goto up_one;
 				}
 			}
@@ -1182,6 +1187,8 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 
 	up_one:
 		/*
+		 * strip the last component
+		 *
 		 * dst0..dst is prefix portion, and dst[-1] is '/';
 		 * go up one level.
 		 */
-- 
2.43.0

