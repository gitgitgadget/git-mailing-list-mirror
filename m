Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94A3A0B18
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208250; cv=none; b=FKpXXwvyNDM6NXBUdNU6iqP3kvJkKjis+HN4t5bhbr3u9jEvJ3YIEyPw1rDSeNWGiJwhJxmPiVWCR1WPKug45FbnHAIhvheg0VkpfbQXjscTOw7dpoaM483WPvGNmveecHl543m69uDsxeJKZOYCUEQJiNG1PqTeKSFXHj/EmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208250; c=relaxed/simple;
	bh=ofdjp6D6qpF7nzC2L+XqqBitrCzoSJ+ffhqQ+lERq8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3DA3Wdx1VG1GGTr0WZyQKeTdBngxqC3qar8zJVFZMZnHgFpSS3ruvOhKzxLQWz9jHtioOKB2xT9YibZ1J0m0mOC4uDJ12NuntVWvHHURqYkjzcgpXDcP+RKHLJ95r6pZyLpg8iy/DCbEaXtBRthdiXSrXGPFanhtUHEdn0lVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeXLuVUb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeXLuVUb"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43767807cf3so1501857f8f.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772208247; x=1772813047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MxSKjmzOKfX0dLQUJ+WeKeQldI+ggDx/042yVFQ+3k=;
        b=LeXLuVUboa/dMyN2XBPMTAwL2Ek0tJs2lrxEYW+h62TEaoWX2AnoYvJ9LJGxxSZdr8
         LBNATvgjIan4UEqT9MgXEtrxOWFaYXOVY5sY8flW6vwZmAJdwQgYfLvvkc5YepOmnphC
         5p88nBWUtnPCciQ8AqT7rOU1P4NfYfP/z8wpoz4yCCAfJJcARZFLvWNx08RfnufosguX
         qJ0WmYcli0gE3A46aITzTCaBdSk1RmNJ+uZaICkg+5ibT7cbLIuJfLx7cC0TcjEB2ZTR
         ApEaoT1wJJyCN716/FxC/n7ld8rIzpHmJqqEssyzDKLw+NnG12xz6DKNUDZocU7yYKXB
         WQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208247; x=1772813047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MxSKjmzOKfX0dLQUJ+WeKeQldI+ggDx/042yVFQ+3k=;
        b=WbWaYP2HwSkk5Q1efldj3e9eVF5xk/RMQVE4Woj3N7Alp5FR8axOTwNWjx1SigxFLi
         52GUt4I/XSBfE8RntTn/Q1hE3C+re+of6wp/95NKUlEY+EGw/muGbSqtCSluuepP+YX/
         kq/Rgq0dyVeKjXYzryvLTcdFAHu+H5LW2FpJEtQq2Ci5Q3OBq6aG9lAHal7sC3vHBLzI
         1wnHb5BZBC0TJ6h0LatpDcBNRW1lVXWoarGvR2S0iG5Xm1Z6AGcNBOzqy9roETcjYmV/
         mTGvQtLlMZie0j9bS2lO1/F2wuT30AFgCZlsTIi7Annnc5UmW70Vb5v/LBAmrJyNoRl7
         kizQ==
X-Gm-Message-State: AOJu0YxTnat6oMUkyyFW/JoNhRIvY3fKCOdIx7qKllNITwd2LZ6wmuUq
	q8ZjR7EuTwKij6VeCyzNEhheb14QZnbx6DtLj/3OjMu3mIGfg3dhze61tfB9hw==
X-Gm-Gg: ATEYQzypcWHL4pPIyb3/+VVj0/UzlHfjAaxmfcjVnp1EZG4fAKFqyZfT418XKjCBLzg
	LSB+fYZxUpbHSoHaklvngghCgvkGrQI0X9OrQf6mq+FIe0r7rXCC86p4k4ryDv9szdqbwLrVr2t
	cR7mpQJ5X4ZIGVczft4JW2v1qVNO+YjdnmwZofet0wXj34NrOk5LQqISps/sl3WJgKIMqtda6tH
	ndpT+dVBzsxTqzIVCZOQxwHadB5fESGoHk3qXkNjmLi6zVL/2LPpWjr20eyfnsfi3ynXfwBJQj4
	qZWgFTbO4P1jQ6UOEZSIngIavdDW3AiZ2ueTgUILc8SCfjY+H2vV+Bq/jXd2g2q10wE0G7AKXmq
	tGw0co+qMAqxWQweNLGcvWm7LL18ioM45Gfv6safwBo74LBfK0830aKhaabwt+qI72C/x2aTzEA
	ueLtlVfRb8JYIb9Ue3s5owV1lHPWJ+LFQ3Uo65KCn25P8SLQ==
X-Received: by 2002:a5d:5889:0:b0:435:e061:9e10 with SMTP id ffacd0b85a97d-4399dde302fmr5717792f8f.12.1772208247137;
        Fri, 27 Feb 2026 08:04:07 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b48asm8247952f8f.37.2026.02.27.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:04:06 -0800 (PST)
Date: Fri, 27 Feb 2026 17:04:04 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2 1/2] diff: handle UTF-8 chars in prefix when
 calculating diffstat width
Message-ID: <9e8161a7009e270c76a7cc4411b1977837ee7d19.1772136203.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>

The diffstat width is calculated by taking the terminal width and
incorrectly subtracting the `strlen()` of `line_prefix`, instead of the
actual display width of `line_prefix`, which may contain UTF-8
characters (e.g., ANSI-colored strings in `log --graph --stat`).

Utilize the display width instead, obtained via `utf8_strnwidth()` with
the flag `skip_ansi`.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 diff.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 35b903a9a0..395cb464f4 100644
--- a/diff.c
+++ b/diff.c
@@ -2749,7 +2749,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	count = i; /* where we can stop scanning in data->files[] */
 
 	/*
-	 * We have width = stat_width or term_columns() columns total.
+	 * We have width = stat_width or term_columns() columns total minus the
+	 * length of line_prefix skipping UTF-8 chars to get the display width
+	 * (e.g., to skip ANSI-colored strings in "log --graph --stat").
 	 * We want a maximum of min(max_len, stat_name_width) for the name part.
 	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
 	 * We also need 1 for " " and 4 + decimal_width(max_change)
@@ -2776,14 +2778,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
 	 */
-
-	/*
-	 * NEEDSWORK: line_prefix is often used for "log --graph" output
-	 * and contains ANSI-colored string.  utf8_strnwidth() should be
-	 * used to correctly count the display width instead of strlen().
-	 */
 	if (options->stat_width == -1)
-		width = term_columns() - strlen(line_prefix);
+		width = term_columns() - utf8_strnwidth(line_prefix, strlen(line_prefix), 1);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
-- 
2.43.0

