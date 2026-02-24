Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA9145A05
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895482; cv=none; b=M85+N3TLZY2F1FMoZ/NYpQth45ZwnNhw72JMgvgM7mPEEeHiAz4yS5rytMDWAeunsIHg3tcRKyKZ6AZS1VgQBNeKGzD1yu6dQL3CU4yINXntmnfo3uFoElLmgVVHYI0QbyRooqQ1/bzF2NfFwWnv4HdGIRARYxQbz02t4wZNwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895482; c=relaxed/simple;
	bh=sCNsS2w0HVHTKZYz82xwtg7kjAJq8pd0X1u/ci8gKgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE7XBkyJU3Y24B2moW7bsDf31aPnTip6tf3/FARtlbj4ZKvNxUT+w7Sto7Ghf0y6aJ8pD+2boJ1TXqlRmyU1pmncVahosmJqn5/kCEVitRSp/G+qmHjG1FAVXwoAYJ4vGOGeb0rgOjDoQGBN01XZ3OiSSMz7DPQ8O5XM/fqvlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUuUofOg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUuUofOg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48336a6e932so30370605e9.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771895479; x=1772500279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vd5pCCQUnqP4yvRQ5jPCjCyJutL1//P/OTZG1Tr1TNA=;
        b=jUuUofOgr1YP1Ryn6ffWseFrh1Dm0TQzsCxE7rYJwJhgTx97l8Mz2QNy0ujvjmI93G
         viFfeR6qjHJPaR0pRKEC1iF2BZuFDxWBwlEcNjDidUA2xodQe5vyoFbLtBWmm6+98ZS0
         KBOZxHQ7SNYZnnRXlecY0zfQxZtDzCrePT8TTj8sve1ueDpgzAanQySZsPuqpE2/D9qv
         4p5z5jCPJmIp31Nu/R6iODOGoKN2XuM+LeoDXNEGZAR05ppZpqEhyeSlWnHr1gQccDA0
         iqDTl4WjkYJbMKmQVLRPRRyZMWD1i8L0Aq4Nzbh2B8eKIJQeS+pZ694B/D5Cw5JuBpJi
         sV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771895479; x=1772500279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd5pCCQUnqP4yvRQ5jPCjCyJutL1//P/OTZG1Tr1TNA=;
        b=tGJLL8gbGBKhCKk6OAdUAZBG2GFCZUoci3f3mw4pdzTlPQxG2tksYMY5HR3FRHXvL+
         oIj5atPa4BbbXmP+QB4hNTwpAEtZGB7vgIzGUN5thGPXS01keYPXYLBASiFU5ZHJrzxd
         IuX8wObqVfw4LAJOWgJxY6x1yxsMyxGPJrmGf8KewjmJplBESwmCU03q6M3FhEf5DQKA
         evZAPCJZAYoIysLfNIJkSQNQNV/BSsghFzd61IZ0PViga9BAtzJWX/ab86nUzHX0eCfA
         uiiVZpmGb5ecahCjot5Y3/uVFn74jitX5edZza9qToVa6amNd6oHLuSO0a0upZ+mG4J7
         rZhw==
X-Gm-Message-State: AOJu0YxY3hq6OpOaom8OCKF7lDNiHpbxT8JFpH2gLuKtC4es0nN8eQQM
	4AV7DLfmSRNEgwZvAClAvz6HffBJsYf704aKYorC6DG1aKPTGYq7jpEshd03rQ==
X-Gm-Gg: AZuq6aI9+JP9ZQCV2lKVdIYeKNz7MqJZz43HftBauwGLTrEKWl9fYBY4CzSfQxJpwrN
	dhfFIXsymVQ0A2ee0K944G+LyhTTXLMsdXDj40cgWugYwXafDWHL0VoOu6fqsmEbQugjF95Gotb
	5hjUCvHYlnGwSQ3P6UOcjZyeUkrUMN7iM3S2cWQ/dhcPlji+93mUGf2ByNuxm61gUyGkaTZ10Ta
	4mM8JNI/SDM60wCUxXwSqfkNahD0O+pY2yPXJd6PnSsziCvQb1jAWlkSXQIZZI0cMTRjRObxZAU
	AmPtgNVZ2fQzt9Pmb9YkDFfx3583hdAc06RuKIE0ayJXYCwtmTZcGwh0JNDvaGIEZOuam43GeLa
	hGPBwKBnkdVwqKxnyJzWMF4tcErJDyomRyAWlIn5mPwLDOxaxS1WphDd1UpzYi6CG4bdXm8GGEe
	HH9TzdWRrEhrRD+gHoVMWhLwLydick1fNYcBM=
X-Received: by 2002:a05:600c:8717:b0:483:612d:7a5c with SMTP id 5b1f17b1804b1-483a96375e3mr168604555e9.25.1771895479073;
        Mon, 23 Feb 2026 17:11:19 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b21ceasm225036555e9.0.2026.02.23.17.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:11:18 -0800 (PST)
Date: Tue, 24 Feb 2026 02:11:16 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 1/2] diff: handle ANSI chars in prefix when calculating
 diffstat width
Message-ID: <a798eda511c23ce15df1280a73861ac951459315.1771894207.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>

The diffstat width is calculated by taking the terminal width and
incorrectly subtracting the strlen() of line_prefix, instead of the
actual display width of line_prefix (which may contain ANSI chars).

Utilize the display width instead, obtained via utf8_strnwidth() with
the flag to skip ANSI chars.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 diff.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 35b903a9a0..de1db28714 100644
--- a/diff.c
+++ b/diff.c
@@ -2749,7 +2749,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	count = i; /* where we can stop scanning in data->files[] */
 
 	/*
-	 * We have width = stat_width or term_columns() columns total.
+	 * We have width = stat_width or term_columns() columns total
+	 * minus the length of line_prefix skipping ANSI chars to get the
+	 * display width (e.g., to skip ANSI-colored strings in "log --graph").
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

