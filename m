Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4789354ADF
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808860; cv=none; b=Yrn1OX62JRojLhsKeyNUGL0WN+3U9jOxZ7S4M9P7NaV9sDJFB1bLdgoZL90CMXLskWa5ql4gteojSB1vnX/9AVk8IXRVaxW+BiIkAtLDXwVDJrhvMUpEfEWdbknFqsbGRi3kNAXsmnO0E32UX0m52vkiMswAkmIbpv3m6XQFUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808860; c=relaxed/simple;
	bh=TSNex/mab4o9DgsLiCnhj+zvnQiqTU73e5W0QPv6ptE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+0FDetX/05PhkgfuIoB4t76el5rAmVQptlHxv/I1Um9OC3YAXbAjMI+M5TJkJTf1jTkpO74VEHb+ZmTkxik0pyfFIXR8Gp1S0KhkiiizVH0h5727dSsz1JWn4txcM2BOerR2VvgfU9AvGjYH6kxxIV0P/UnoagfrLkyBkJ3KCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF0TQTLJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF0TQTLJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c5cce2c6so3199476f8f.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808857; x=1773413657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V+etn0cA//txtyXAsM/3ziOTzBOLmfi3M/HWoHs6t6o=;
        b=CF0TQTLJuMWh9qN2QaN7tY2RyjL+2bnOK72qNXb5DBE4ddjCmsqqSaL7NNl09qsgzz
         gAj5AhKkzslGNTib9svTYYHAjP5p9tomQhmUbaP7JUTVRCTOKTHkEsct/HS+Rh8kPFM8
         WAIQ0lGuxpMkVz48DOmzx1KyOMcanXSHveI4njqDhs9hPrlaBK9nyRW0n94bZQXJwFuk
         i2swsIZkXtHixG+blIa52HLJWlJ/SxNK+okWVPYtpibB2hiuengc9HxrTSlU1DvSYIu8
         qVXevxE70eVm1qFd/4Py6XQXZJjLteFet+u95DZGRqRqtKtaLuzVcMlIyHWfjjbR4hjU
         ZhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808857; x=1773413657;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+etn0cA//txtyXAsM/3ziOTzBOLmfi3M/HWoHs6t6o=;
        b=YZjrqCC/L4v07iFggKzIGXNPsfzd3zl0lftg8qfIetDKq1gOvgE7j+ZX8Qdmed1Y9N
         tm582p1bvKUM3C363L+YVmW3LJFf/JlHCUkEHmY8JaoQRQmRcGhRv58aj36q/HSJ6EAB
         kOZJqAOT9Emj+U3CAme51JKqR8suvlI0xly6y83v99H37XruvCfCipKbaqDer4tf+Fqa
         6N96qQQkwjt1Thx8fcvohwxfo9yMa/o3uP7FB1xNoQNoQAhaIXiMibCLLJctM9KTD14S
         26EUw4AiV899amxJHPcl7rJjvm+g9SH2TSpZnn9LxlDBei4orqjdw1AfTH4VyzufCsGC
         yEbQ==
X-Gm-Message-State: AOJu0Yx899qbLci0Gud7bnis7SjBk3Wr23sJLBNWF5IwbN1FyvnruR3D
	5Gy3Fg48D7YIJbfmd84kUEY53tX0Y+tnvDuKokc6RYc9hMWuoJvvddF0vAzH5Q==
X-Gm-Gg: ATEYQzxDxYjbBT2oy0jG9/2nHUX48REQBR/ugMk0TUoiiGuBcAxuBH4yDza4sBrie4+
	qn+9lRJFz53fOPPKM20etVirzAmiStYfV72cKE1SwwOcCYdRgPGIHfroAiuw2MWqRP42oPgI/4W
	UegRo7v5lBfc6nlxGxR9puo1RJEQkF9Mtvr1w9V+WUeGHY42OKaXkmAOMRRqHRDdz099nxaTTHf
	0nuBenbbjysioLcEQbJUEKvhshz0jQjmB2ZXzbEC9gWoLa1msQnEIKGpTZFWru7OtnZ9VJqYUGO
	6SxAaO2mAzeWdviNJaggen69jBEjaZ91R2GuouMNy2eA8BAiRyEMQlSeYkLpcL2nQJuBABmsNlG
	cRakXUqR5I252OnoZc9Ngej+ph0nI6j8sMh9rmCLK4IETFf4qnYLuYYc8JZkrwBMHO4/yzoUXB/
	PxGpNlc155OKfRmqXz8/cOZe9Yo3o=
X-Received: by 2002:a05:6000:4205:b0:436:369f:39f5 with SMTP id ffacd0b85a97d-439da89c006mr3732755f8f.43.1772808856967;
        Fri, 06 Mar 2026 06:54:16 -0800 (PST)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4278563f8f.0.2026.03.06.06.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:54:16 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 1/6] interpret-trailers: factor trailer rewriting
Date: Fri,  6 Mar 2026 14:53:27 +0000
Message-ID: <0d08b361995f4d117b3c80a7e403c1a821d10a5f.1772808594.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1772808594.git.phillip.wood@dunelm.org.uk>
References: <20260224070552.148591-1-me@linux.beauty> <cover.1772808594.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

Extract the trailer rewriting logic into a helper that appends to an
output strbuf.

Update interpret_trailers() to handle file I/O only: read input once,
call the helper, and write the buffered result.

This separation makes it easier to move the helper into trailer.c in the
next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Li Chen <me@linux.beauty>
---
 builtin/interpret-trailers.c | 57 ++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 41b0750e5af..69f9d67ec0e 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, const char *file)
 	strbuf_complete_line(sb);
 }
 
-static void interpret_trailers(const struct process_trailer_options *opts,
-			       struct list_head *new_trailer_head,
-			       const char *file)
+static void process_trailers(const struct process_trailer_options *opts,
+			     struct list_head *new_trailer_head,
+			     struct strbuf *input, struct strbuf *out)
 {
 	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block_sb = STRBUF_INIT;
 	struct trailer_block *trailer_block;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	trailer_block = parse_trailers(opts, sb.buf, &head);
+
+	trailer_block = parse_trailers(opts, input->buf, &head);
 
 	/* Print the lines before the trailer block */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
+		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
 
 	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
-		fprintf(outfile, "\n");
-
+		strbuf_addch(out, '\n');
 
 	if (!opts->only_input) {
 		LIST_HEAD(config_head);
@@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block_sb);
+	format_trailers(opts, &head, out);
 	free_trailers(&head);
-	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
-	strbuf_release(&trailer_block_sb);
 
 	/* Print the lines after the trailer block as is. */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
-		       sb.len - trailer_block_end(trailer_block), outfile);
+		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
+			   input->len - trailer_block_end(trailer_block));
 	trailer_block_release(trailer_block);
-
+}
+
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	struct strbuf input = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	FILE *outfile = stdout;
+
+	trailer_config_init();
+
+	read_input_file(&input, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	process_trailers(opts, new_trailer_head, &input, &out);
+
+	strbuf_write(&out, outfile);
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
-	strbuf_release(&sb);
+	strbuf_release(&input);
+	strbuf_release(&out);
 }
 
 int cmd_interpret_trailers(int argc,
-- 
2.52.0.362.g884e03848a9

