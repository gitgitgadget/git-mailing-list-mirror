Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9012D7D3A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393448; cv=none; b=AIAfuvr7e5V+GbbZ5bUN87NCvh1SosOhXH8DVVBcOP19islB8nErmhk6+zHEa9YG/KStt49koqxgxJ2NC5MhrOO9KbNnUSxlaUdht+MEg64J8poKOq/FBfo2Hop5q/bZ8Q32xU4JjBembg43JqUy/ZJkwlrHrqwevpa5Hckw4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393448; c=relaxed/simple;
	bh=0eMkWHazJ17tNUj/nF11DiJfAobyH7t//oiJX5I+zqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoczE2w/ki4rLRDcYSmHREtwgkQQ6EF3sngdKDA4swCd4TlzciZ7SRpeBdhTiqHD+TBnkG8yRTG9Ep3Z5pykQhYInYWW9ivQn3pTDpV0omKQPC/LKcDIMJrV6kTLqKHLIDqMvCg7KCaVHCBjpmJktqldD7FKvNljCIwlfbb1GKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRFDChe3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRFDChe3"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43590777e22so580018f8f.3
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393446; x=1770998246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Geag/GjIYIIDNLXsq2BXXXYGRLVhSpbVe9VpPKO4s1Y=;
        b=IRFDChe3jOcimIlH1LiALc8zwC8e4hwzM76/W1FgvN/Adm8o1oZ4iS2zwhVuoTvbjW
         dXnQmcI+giLOLQ2p8tG5gWKysDUVO5ym38vmRh0lxfu/IZwgNuI+iktrCVG2yjM24lfu
         3GozKh/OyAOWPyFY0HUBX/cM7BybmolqNekCdI7kcuoBj4JF4uCF7Em4BAD9XXgQOwP/
         E0IjERau+oelGhstvML3uyj3PPdE4yBYXT5Y3MLmTlUH/2ZV3pLuyzzWGX0WCuq8wrar
         DWaMQv8dK2kyJVjttaFXUtNylMZQfHKCqoCHHEPWPUE022GwHDBbmy5fwRUVSB5kWolE
         Yuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393446; x=1770998246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Geag/GjIYIIDNLXsq2BXXXYGRLVhSpbVe9VpPKO4s1Y=;
        b=v+14Jp+41H4ts5UufjlI/gc3HIgw+wXYKvySpvSdST9WSWfSAS1IhVaRNQT8d2Ocuq
         uk8Nmupp9FZZYXlxCS0f7iUlgseiiojDFeNCpDiKKVAOCaZMsw7axeOQLdP4GUvchq+T
         TOfqVFRbixPiTvI1P9TG2G60PJlLCI8osxEz+yB6RQ7rB4ral1pa/oK03oRj4EfYPFbD
         rr14eAC0BacTqRUUcOU1RSi1irZRiQmD5kBrHhHJmE9MSeupqtwwgfKwWv93+ZvMwGdR
         B1Qmlqx2tekS87WpxVyNgr7WoaJzdnhsFxfKSD0ExyH/8CBBADNZRcD/CzANRRs38fPH
         V2mg==
X-Gm-Message-State: AOJu0YyoawN3N1mIcqMY/lja2ZUUfWPrZ5HLrNXyyRE3PV9gawG73Wxc
	DTHXNBdAfqESmRAKmOZSrafRTEMWw7UQJH6kYWN5z/jWzdzkTWGnQd44R/32+BxafLA=
X-Gm-Gg: AZuq6aISuVqvet3ivokNRl7KRZcc1sLVyAzmOLuLV8WaMtS+0bEGiqtVCIl7p/o3xMa
	UWbHxvV7uFH1gKK9W36ReqXOyLYaX+fcBrLmXb79IphQyDIJsQUACQ8cwVz53XchGoEKPpqR9Y8
	XCWrThvFgfUE12SfHucXT66Uxi2QyhhfZHcK4MqcW+G/uD04cPtlFW42ZxoJoSclRfvW6qM+d4b
	L9EIJtuRnsCFpq/zcs/WnswAGIoGi3m9xGUPRmgfFZDDEJf8UKNVsFOUeWUgbv3tDRZBsg7i2Zb
	VQwcFFrI6uzr9wjfop3fMT1Bia+RRT6sQwWOs50JPif9SYuKELqjmZgLxhqTUoaLAWbnaf7B4e+
	wcqLakL1UVozgJxsd6j04eQRWKikVnPBGlLUjnMXcJDzm3JRu1V4zgyJQ1A8hX/qHFXm18HLI/1
	iBaeRHxZDdQG9o7sS9gwJc
X-Received: by 2002:a05:6000:144c:b0:431:808:2d58 with SMTP id ffacd0b85a97d-436293bb5e4mr4644776f8f.51.1770393446310;
        Fri, 06 Feb 2026 07:57:26 -0800 (PST)
Received: from localhost ([102.91.81.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972faaasm6495975f8f.27.2026.02.06.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:57:25 -0800 (PST)
Date: Fri, 6 Feb 2026 16:57:35 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 3/3] add-patch: Allow proper 'git apply' when using the
 --rework-with-file flag
Message-ID: <10c0a4cb36534f5ed1ebed783b37d03a56007f97.1770390576.git.abrahamadekunle50@gmail.com>
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770390576.git.abrahamadekunle50@gmail.com>

When the flag `--rework-with-file` is used with `--patch`, if the user
has decided `USE` on a hunk in a file, goes to another file, and then
returns to this file and changes the previous decision on the hunk to
`SKIP`, because the patch has already been applied, the last decision
is not registered and the now SKIPPED hunk is still applied.

Modify the logic to allow all files to be applied only after the user
has finished making hunk decisions and quits. This will ensure the last
decision of the user is applied regardless of how the user navigates back
and forth and decides.

This change does not affect the default behaviour of applying the auto
advancing after deciding on all hunks in a file.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c | 66 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 2bd839f17e..9fb33715c2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1422,6 +1422,40 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "< - go to the previous file\n"
    "? - print help\n");
 
+static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	size_t j;
+
+		/* Any hunk to be used? */
+	for (j = 0; j < file_diff->hunk_nr; j++)
+		if (file_diff->hunk[j].use == USE_HUNK)
+			break;
+
+	if (j < file_diff->hunk_nr ||
+		(!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
+		/* At least one hunk selected: apply */
+		strbuf_reset(&s->buf);
+		reassemble_patch(s, file_diff, 0, &s->buf);
+
+		discard_index(s->s.r->index);
+		if (s->mode->apply_for_checkout)
+			apply_for_checkout(s, &s->buf,
+					s->mode->is_reverse);
+		else {
+			setup_child_process(s, &cp, "apply", NULL);
+			strvec_pushv(&cp.args, s->mode->apply_args);
+			if (pipe_command(&cp, s->buf.buf, s->buf.len,
+					NULL, 0, NULL, 0))
+				error(_("'git apply' failed"));
+		}
+		if (repo_read_index(s->s.r) >= 0)
+			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
+							1, NULL, NULL, NULL);
+	}
+
+}
+
 static size_t dec_mod(size_t a, size_t m)
 {
 	return a > 0 ? a - 1 : m - 1;
@@ -1456,7 +1490,6 @@ static enum patch_update_response patch_update_file(struct add_p_state *s,
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
 	int all_decided = 0;
@@ -1818,32 +1851,8 @@ static enum patch_update_response patch_update_file(struct add_p_state *s,
 		}
 	}
 
-	/* Any hunk to be used? */
-	for (i = 0; i < file_diff->hunk_nr; i++)
-		if (file_diff->hunk[i].use == USE_HUNK)
-			break;
-
-	if (i < file_diff->hunk_nr ||
-	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
-		/* At least one hunk selected: apply */
-		strbuf_reset(&s->buf);
-		reassemble_patch(s, file_diff, 0, &s->buf);
-
-		discard_index(s->s.r->index);
-		if (s->mode->apply_for_checkout)
-			apply_for_checkout(s, &s->buf,
-					   s->mode->is_reverse);
-		else {
-			setup_child_process(s, &cp, "apply", NULL);
-			strvec_pushv(&cp.args, s->mode->apply_args);
-			if (pipe_command(&cp, s->buf.buf, s->buf.len,
-					 NULL, 0, NULL, 0))
-				error(_("'git apply' failed"));
-		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
-						     1, NULL, NULL, NULL);
-	}
+	if (!s->s.no_auto_advance)
+		apply_patch(s, file_diff);
 
 	putchar('\n');
 	return ret;
@@ -1922,6 +1931,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			}
 		}
     }
+	for (i = 0; i < s.file_diff_nr; i++)
+		if (s.s.no_auto_advance)
+			apply_patch(&s, s.file_diff + i);
 
 	if (s.file_diff_nr == 0)
 		err(&s, _("No changes."));
-- 
2.39.5 (Apple Git-154)

