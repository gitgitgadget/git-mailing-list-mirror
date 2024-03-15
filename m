Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18E1B5BF
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485717; cv=none; b=pOYpvZluVHbn9wEQAH34sFuOvVbMF8ihIatB64WAyNwoBpefORAWyruSUj3hPNdgQP1XUi5VlRbBQ+AugIs6z//ekksxtqHKx5rT22sLRjA3sdTCM6rFNIFhkB15oWfpFoykRVjnt88B7mfp16dpG/S0Rw2ClgsS9Rsw9ydm260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485717; c=relaxed/simple;
	bh=bB5ZnAkvcSD7SZmz4//9/FaojLD8KfUsJcMG5y/Sb90=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GpHJZ2v5Bf8pEv9sndExvY0kWEP4EagLg0FVnn6H0eAjAAqtzeE1cah3Ao56LH+H1Oz4NIYXmvTNVceZsrqeezXdNlfV13UMqxGCzcf9ASo0yKGxLiOkE07MZNoSgjAQWMsdfvzWgQUULV8URDdNLIgHRWUs1aBDJGcnEivPXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ7rPZZE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ7rPZZE"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51320ca689aso2037924e87.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710485713; x=1711090513; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvFfpyMwYJrJtcCYZDHtOZ1OtFNfSKrtlGzpxaHvq7w=;
        b=bZ7rPZZEIwgQNwH+5uTyJPAEUCH7ps8ICW3ctHJsWmnQ6bNS1OZi/HzpUjVPWmw98n
         9yGLkY7Y5omqC9nLqOeLKAMIpeQFPV8qsOkdAtsATpQgJN7QNhY6X3OGQ/Qv+VD9VKj4
         CGYg4Di3kATFZkJix/bwtcWK3/CLMtURi0XLs8z/JJbCBFieNvIMHvH2Lg/9K2TNzkSd
         KQbyObWQl7k25WKAjEMlCSZcZ+6JZl0vxukFbXM5omwsFfDlsCJiWtVIKOQMW1nZV5Dx
         R8HDEFIR1m5gpIhIdRyFruk86GFckRWAWSpkGzjhn8ZTyMi9HEjsLmqxq98zGz1+vFWt
         Stvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710485713; x=1711090513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvFfpyMwYJrJtcCYZDHtOZ1OtFNfSKrtlGzpxaHvq7w=;
        b=eu9rYBsdyT8jHNz6ayoU06f651JIbM/xYq2AQWrhSB/DzKkY/NArN60+vMj+LTqVpS
         MQvCX/brOkQwg6uYjpowqyjzchmk7mQgZ2aOpgMUG3C2pvTbw00QFW5w9b+BfzE6UaGe
         fTThiUJgX2H3XnAKe0dXD2KbE99MK+9jCq4lVe3I5//TvPbXgSg0hMIJ7fehfjlzprQj
         7tNlPLpHt+iUfyfozVt+W/TtvW+9TrfnJcgR6ppmiaEkFg4m/Twtl9neqMyxCDocfrzd
         /WGA5M3qD+bWpCRyiB/s9YFE7bZypIM77nxYV1nunljzwdVrTmtP340vQOT+X1R2beuu
         pHpQ==
X-Gm-Message-State: AOJu0YxsnoCl4KBwB5fSAOqstANFBTV5iQ01hO6vbumSLRr5uC7OiZRE
	JgN9xEVnB5zis6ZtJ6aMreDg/N+iqYi9g6YENn1beCyw6ioRTpdb1TkUjjQJ
X-Google-Smtp-Source: AGHT+IFw1slWXku3UUX1kTRG5+0yea3nzXS/IEEJPBgstQZBpvwUcxxO2LizDkd9AvDv/0IRXfpT9g==
X-Received: by 2002:a19:7409:0:b0:513:4766:2713 with SMTP id v9-20020a197409000000b0051347662713mr1530617lfe.59.1710485712707;
        Thu, 14 Mar 2024 23:55:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b00413f035d58esm4754426wmq.10.2024.03.14.23.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:55:11 -0700 (PDT)
Message-ID: <cd3c4b455f168d840b9d1214709ab5b152a76c17.1710485706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 06:55:05 +0000
Subject: [PATCH 5/5] trailer: finish formatting unification
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
Cc: "Christian Couder [ ]" <chriscool@tuxfamily.org>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    "Emily Shaffer [ ]" <nasamuffin@google.com>,
    "Josh Steadmon [ ]" <steadmon@google.com>,
    "Randall S. Becker [ ]" <rsbecker@nexbridge.com>,
    "Christian Couder [ ]" <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Rename format_trailer_info() to format_trailers(). Finally, both
interpret-trailers and format_trailers_from_commit() can call
"format_trailers()"!

Update the comment in <trailer.h> to remove the (now obsolete) caveats
about format_trailers_from_commit(). Those caveats come from
a388b10fc1 (pretty: move trailer formatting to trailer.c, 2017-08-15)
where it says:

    pretty: move trailer formatting to trailer.c

    The next commit will add many features to the %(trailer)
    placeholder in pretty.c. We'll need to access some internal
    functions of trailer.c for that, so our options are either:

      1. expose those functions publicly

    or

      2. make an entry point into trailer.c to do the formatting

    Doing (2) ends up exposing less surface area, though do note
    that caveats in the docstring of the new function.

which suggests format_trailers_from_commit() started out from pretty.c
and did not have access to all of the trailer implementation internals,
and was never intended to replace (unify) the formatting machinery in
trailer.c. The refactors leading up to this commit (as well as
additional refactors that will follow) expose additional functions
publicly, and is therefore choosing option (1) as described in
a388b10fc1.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  2 +-
 trailer.c                    |  8 ++++----
 trailer.h                    | 15 ++++-----------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f57af0db37b..11f4ce9e4a2 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -171,7 +171,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailer_info(opts, &head, &trailer_block);
+	format_trailers(opts, &head, &trailer_block);
 	free_trailers(&head);
 	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
 	strbuf_release(&trailer_block);
diff --git a/trailer.c b/trailer.c
index 43d5baef9ce..3e4dab9c065 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1052,9 +1052,9 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-void format_trailer_info(const struct process_trailer_options *opts,
-			 struct list_head *trailers,
-			 struct strbuf *out)
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers,
+		     struct strbuf *out)
 {
 	size_t origlen = out->len;
 	struct list_head *pos;
@@ -1128,7 +1128,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 		strbuf_add(out, msg + info.trailer_block_start,
 			   info.trailer_block_end - info.trailer_block_start);
 	} else
-		format_trailer_info(opts, &trailer_objects, out);
+		format_trailers(opts, &trailer_objects, out);
 
 	free_trailers(&trailer_objects);
 	trailer_info_release(&info);
diff --git a/trailer.h b/trailer.h
index 3c13006a4c1..9f42aa75994 100644
--- a/trailer.h
+++ b/trailer.h
@@ -101,23 +101,16 @@ void trailer_info_get(const struct process_trailer_options *,
 void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
-void format_trailer_info(const struct process_trailer_options *,
+void format_trailers(const struct process_trailer_options *,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *);
 
 /*
- * Format the trailers from the commit msg "msg" into the strbuf "out".
- * Note two caveats about "opts":
- *
- *   - this is primarily a helper for pretty.c, and not
- *     all of the flags are supported.
- *
- *   - this differs from process_trailers slightly in that we always format
- *     only the trailer block itself, even if the "only_trailers" option is not
- *     set.
+ * Convenience function to format the trailers from the commit msg "msg" into
+ * the strbuf "out". Reuses format_trailers() internally.
  */
-void format_trailers_from_commit(const struct process_trailer_options *opts,
+void format_trailers_from_commit(const struct process_trailer_options *,
 				 const char *msg,
 				 struct strbuf *out);
 
-- 
gitgitgadget
