Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79D1CC8B9
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768760; cv=none; b=n2P7ttxUgiTvzCUMzAWJQh8fj6X0IANiStN94Z2VUOENcI1U0VLxnWRxU8auIamDgUNJtB5wlPWL/Cg/TLtJBR5r7MGCc/tsTcZx0xQbOLUtiioIGTumogoH05+VHDGxhZUsgXfeCUVh9Lko7YJDBbfJBA8NjH3OZp/hCZB/Su0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768760; c=relaxed/simple;
	bh=XKhsoO3sXXkHd9YaOI6JXDKuqQROMDkPsPCe/7+QP5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl1f6e1BRaedjyUY3VQ7P01EkWFmNXrbz/Cr2m6VFFjZxI/eLlxUtlPkRDd4E9j9ZfoKsEewSO9jXaUEkXjJoW9ekpPtCwi+OWEtYwJZJkJX/l65reSmymFYBie1UtiE2SneEq6rP0aYX0dzB0A0ohZxLZAYnbB+zBmNZsRQP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whe3nU7a; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whe3nU7a"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1324299a12.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729768757; x=1730373557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzpqcM64Y5V+BehsY+crnnXc5gRN65YdCPvO8AGKqi0=;
        b=Whe3nU7af4QWmwYh6r6qDDn7V0w/sfPZ9HrVsoY55h2yxrv9INyF+bVvjzHVVkhSmG
         vWFob7tt4hyX0FTxRgdFzHxrfvUn8isn0ySGosqnNaMKYv+S5MGoU5NngMDqlzFAMYKu
         m2GydTFMcUk5TAXMpBXzrONp1q53xLZqPAq2K6tITGPOGfFPSy5+OsygNi4DcIxpSXhZ
         6PCf8O3qP/KiBeyp+4YtvuzEKIl2U+liDezECG13XDHl6qWtzP169JGKYbyJC0ze+ywV
         BMPH9HHArfgS+Gbb2xAN1MbrbwlDukTyixVw3vIQtuxdAJkH7FdwwhX3eOznqfWagWWN
         BLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729768757; x=1730373557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzpqcM64Y5V+BehsY+crnnXc5gRN65YdCPvO8AGKqi0=;
        b=Lsml3Unyf8Xg90rmBo3jB0OX48BMtJ0liycv67Cd1rbUIVObEUBYgMFhmr+UMPsZ5I
         npQOmwfX8thslmhX6QPwoPhv+5XChT7+ZqEC7igo96oVHiP5oqXtlBLEuuzQ4MqLxbFU
         /JbFXABdyJ8Vf1Sp/J0dfpYovSYChnHmPc7iigAr8hILGCj1E80wvi3e8Tk3rhdHwUYl
         cqQDrI3EG29KwksYLdSy3u91XRCwBs8ZqSce+nwLnyi1uBNzxNb0TG+hCzxHCHW5fxgb
         u+WeDBKhal96MOeR55TddaaDXNzh3qMiDVmNdBR8jk001cdA+vzSl2JP7UcUCopQLIDu
         Amgw==
X-Gm-Message-State: AOJu0YwkeQoSaH3E+AMSJbEhPy6dZW9Caie9arXMY2eapTjWL0qAzVIq
	FA1z21XlK7Ev6aADNJky6i+t9E+FATa4h6fvahiZ/MpxNeK/KGMw
X-Google-Smtp-Source: AGHT+IEpAzcKib4kXuGpgu5sXRJNLwBqtVewNLFp1tJs3nTKcxhNUlzLBCfysmXWUIawKrZxf2nmqA==
X-Received: by 2002:a17:90b:1e50:b0:2da:82d4:c63c with SMTP id 98e67ed59e1d1-2e77e58dd8fmr2721619a91.4.1729768757151;
        Thu, 24 Oct 2024 04:19:17 -0700 (PDT)
Received: from localhost ([14.191.221.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4c89a5sm1210267a91.20.2024.10.24.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:19:16 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:19:13 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Teng Long <dyroneteng@gmail.com>
Subject: Re: [RFC PATCH] notes: add prepend command
Message-ID: <ZxotMcKv5rEIMZ8q@danh.dev>
References: <20241023201430.986389-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023201430.986389-1-bence@ferdinandy.com>

On 2024-10-23 22:14:24+0200, Bence Ferdinandy <bence@ferdinandy.com> wrote:
> -static int append_edit(int argc, const char **argv, const char *prefix)
> +
> +static int append_prepend_edit(int argc, const char **argv, const char *prefix, int prepend)
>  {
>  	int allow_empty = 0;
>  	const char *object_ref;
> @@ -716,11 +718,18 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  
>  		if (!prev_buf)
>  			die(_("unable to read %s"), oid_to_hex(note));
> -		if (size)
> -			strbuf_add(&buf, prev_buf, size);
> -		if (d.buf.len && size)
> -			append_separator(&buf);
> -		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
> +		if (prepend) {
> +			if (d.buf.len && size)
> +				append_separator(&buf);
> +			if (size)
> +				strbuf_add(&buf, prev_buf, size);
> +		} else {
> +			if (size)
> +				strbuf_add(&buf, prev_buf, size);
> +			if (d.buf.len && size)
> +				append_separator(&buf);
> +		}
> +		strbuf_insert(&d.buf, prepend ? d.buf.len : 0, buf.buf, buf.len);
>  
>  		free(prev_buf);
>  		strbuf_release(&buf);

Without prejudice about whether we should take this command.
(I think we shouldn't, just like we shouldn't top-posting).

I think this diff should be written like this for easier reasoning:

----- 8< -----------------
@@ -711,19 +713,27 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
-		struct strbuf buf = STRBUF_INIT;
 		char *prev_buf = repo_read_object_file(the_repository, note, &type, &size);
 
 		if (!prev_buf)
 			die(_("unable to read %s"), oid_to_hex(note));
-		if (size)
+		if (!size) {
+			// no existing notes, use whatever we have here
+		} else if (prepend) {
+			if (d.buf.len)
+				append_separator(&d.buf);
+			strbuf_add(&d.buf, prev_buf, size);
+		} else {
+			struct strbuf buf = STRBUF_INIT;
 			strbuf_add(&buf, prev_buf, size);
-		if (d.buf.len && size)
-			append_separator(&buf);
-		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
+			if (d.buf.len)
+				append_separator(&buf);
+			strbuf_addbuf(&buf, &d.buf);
+			strbuf_swap(&buf, &d.buf);
+			strbuf_release(&buf);
+		}
 
 		free(prev_buf);
-		strbuf_release(&buf);
 	}
 
 	if (d.buf.len || allow_empty) {
-------------- 8< --------------------

Even if we don't take this subcommand, I think we should re-write the
append part, so:
- we can see the append logic better,
- we can avoid the `strbuf_insert` which will require memmove/memcpy.

Well, the second point is micro-optimisation, so take it with a grain
of salt.


Also tests.
-------------- 8< -----------------------
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 99137fb235731..5a7ad40fde6a8 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -558,6 +558,20 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append: specify a separator with an empty arg' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-2
+
+	notes-1
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes prepend --separator="" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'append: specify a separator with an empty arg' '
 	test_when_finished git notes remove HEAD &&
 	cat >expect <<-\EOF &&
----------- >8 --------------


-- 
Danh
