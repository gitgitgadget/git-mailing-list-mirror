Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F633D1
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885231; cv=none; b=WQCpiFhe56hge2klaiyFm3ivYsaxAhTAe7zXhmm1rMPqnadR/Fag9YDWDu5Rra8FnZN9vOTmmxlWMJVpfWt3kQJ8Kfu1S7HFWDDo8cZgzAPK+NnYFMxk8nGmkQ7r0LlTfKsrXygwbyOcBDr0lKpF4gRJx62rVRi1EfG3E4RUmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885231; c=relaxed/simple;
	bh=a4AX1C9Hw5xmGhpSzQZDL84n4LcfDp4HsaFBsFwBFO4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=EzpWqLJNN2bSJ+2isLyBEqVdfm7d2owRD5vFr/8S6HcnMtyc68lF0ayDn3qP25sUuRsyWGKpHqcPgNY4ZZ1piR791JipVmlqVVDBRGaeODRReIeY/roBfDWDayM7rrJnEV7TpXz89HhA5RF8JXkewwT7wVSO3TJPN9aiThTOyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tsa67ZcJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tsa67ZcJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so696198666b.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727885227; x=1728490027; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TyiFgJ2zBolllOxpH+/b3UICPFn1ZeiEixBl+ui6CL4=;
        b=Tsa67ZcJgp9Pn6vMdvGICYxrzqBzy0ui/Z0pBbyJpAmYl6x8pYJ1Ue6J3RcHNOk+qu
         60RkBim6W1ROPeEkYM7ouJ6V1WUhDk1fTz/ccp5nDoUME5jnMk2VhPvS3rPxOoY7C9d7
         No042DH1nubr9PzUv/wRbiMEr+dCc1XyKSGCACJcGXTXDOSQwg5jwHGQGmnyQuU1Q/5i
         A3HVStZU+fJycjEEZG5J2bJFpk9KCiVK62Hc0KhHRZjIWTAp+jEyNfLDFSl1FUJWtlBU
         DqL6yrQoViBqBVoPHu46a+5xPLJJABBpza8GXZwkxc/mO/udsnPpXs/nqPXwx2MltKE9
         Nqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727885227; x=1728490027;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyiFgJ2zBolllOxpH+/b3UICPFn1ZeiEixBl+ui6CL4=;
        b=c4jLz/WosT51OPb61SnDs66JbxpatqENBcdWyZmkp69zpdj9XuPr1QrfgYNtEboWAA
         QVaJ7HV+M90OuVB7yZfqop+9el39L1izTzA8kSEMInAUiRQSALDQNrXvnNWgsCEllITO
         GJ+3ZVmg+dcVlw3WAczHanYiHopny0jhmyywms6sxGMq4RQfcHZf2PQ84zRYSvcZkVbf
         B0YvQSQXYaV+EvP4+8izOx5zOQ7RRTAkc1kjNkZLjmS9C8hOZTBjfygxwOtNUDhSb5vK
         +j3AXjJj0/Aoj8NzMMZI8gu1zqYkokfuoz+J6kz9RqGYBl3mkSjjt8aV/3IzfAMq/Jtz
         HV9Q==
X-Gm-Message-State: AOJu0YwlwmRe+LfjmU9Yie5uvF6UqLpJAmQJzca8R2mLfKK50EPxqNnc
	91wrbiFHOLxqIv0L/d+g6vlk3TdIEzpQfx+pQEotdrIOQbjhiFO7IWRa0g==
X-Google-Smtp-Source: AGHT+IFGAoMaHkLrlKaKECVFkO+dPUqlCg4ixMHsMHq3wrYzxtBGOSLMNQs4JcX6k7j39hX1BhaNJQ==
X-Received: by 2002:a17:907:25c6:b0:a7a:8c8d:40ac with SMTP id a640c23a62f3a-a98f820a7f0mr378616066b.4.1727885226855;
        Wed, 02 Oct 2024 09:07:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27d42e3sm886445366b.82.2024.10.02.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:07:06 -0700 (PDT)
Message-Id: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Oct 2024 16:07:04 +0000
Subject: [PATCH] line-log: protect inner strbuf from free
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The output_prefix() method in line-log.c may call a function pointer via
the diff_options struct. This function pointer returns a strbuf struct
and then its buffer is passed back. However, that implies that the
consumer is responsible to free the string. This is especially true
because the default behavior is to duplicate the empty string.

The existing functions used in the output_prefix pointer include:

 1. idiff_prefix_cb() in diff-lib.c. This returns the data pointer, so
    the value exists across multiple calls.

 2. diff_output_prefix_callback() in graph.c. This uses a static strbuf
    struct, so it reuses buffers across calls. These should not be
    freed.

 3. output_prefix_cb() in range-diff.c. This is similar to the
    diff-lib.c case.

In each case, we should not be freeing this buffer. We can convert the
output_prefix() function to return a const char pointer and stop freeing
the result.

This choice is essentially the opposite of what was done in 394affd46d
(line-log: always allocate the output prefix, 2024-06-07).

This was discovered via 'valgrind' while investigating a public report
of a bug in 'git log --graph -L' [1].

[1] https://github.com/git-for-windows/git/issues/5185

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    line-log: protect inner strbuf from free
    
    This fixes a regression introduced in 2.46.0.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1806%2Fderrickstolee%2Fline-log-use-after-free-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1806/derrickstolee/line-log-use-after-free-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1806

 line-log.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/line-log.c b/line-log.c
index 67c80b39a0d..29cf66bdd10 100644
--- a/line-log.c
+++ b/line-log.c
@@ -897,13 +897,13 @@ static void print_line(const char *prefix, char first,
 		fputs("\\ No newline at end of file\n", file);
 }
 
-static char *output_prefix(struct diff_options *opt)
+static const char *output_prefix(struct diff_options *opt)
 {
 	if (opt->output_prefix) {
 		struct strbuf *sb = opt->output_prefix(opt, opt->output_prefix_data);
 		return sb->buf;
 	} else {
-		return xstrdup("");
+		return "";
 	}
 }
 
@@ -916,7 +916,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 	struct diff_ranges *diff = &range->diff;
 
 	struct diff_options *opt = &rev->diffopt;
-	char *prefix = output_prefix(opt);
+	const char *prefix = output_prefix(opt);
 	const char *c_reset = diff_get_color(opt->use_color, DIFF_RESET);
 	const char *c_frag = diff_get_color(opt->use_color, DIFF_FRAGINFO);
 	const char *c_meta = diff_get_color(opt->use_color, DIFF_METAINFO);
@@ -1003,7 +1003,6 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 out:
 	free(p_ends);
 	free(t_ends);
-	free(prefix);
 }
 
 /*
@@ -1012,10 +1011,9 @@ out:
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *range)
 {
-	char *prefix = output_prefix(&rev->diffopt);
+	const char *prefix = output_prefix(&rev->diffopt);
 
 	fprintf(rev->diffopt.file, "%s\n", prefix);
-	free(prefix);
 
 	while (range) {
 		dump_diff_hacky_one(rev, range);

base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
-- 
gitgitgadget
