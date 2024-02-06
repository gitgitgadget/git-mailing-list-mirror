Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607F7E110
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196366; cv=none; b=DI0oHzy6WOOrj7wjS1y5qKAw8kaCHJvnC0vGQiwWvE25RZQDSUfCX20xngOgGZJ/fnPFh09erZzfnbqS1arsRRwRsJrggXQsC5aWCiDt/BnKwynkt+qVd9mKPqjEsX2Wfwq1KwpC4YWFRNDryP5UMc2PpNyN4H4Teui47TwYEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196366; c=relaxed/simple;
	bh=ux9G7jdICdkTx6s80B42U9sW2MuPWuHpMMUNYcISqgQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pUgw6VJSRBChyzxUf8x/PIf0a2zdmusl+zHD82VHEz/CIpfL0dbttk7pAH3pqP+BaWeFS3g/LBQ/58FqcBShTms4aFBzYWkDClfQ5jg7oBmff+uKYlQLjaQJzHqQVxQDHMmwQGM1yQHP8328Sb4n33Q/KpowGlfaiOp6I+9C7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4IIJqxZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4IIJqxZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso42221705e9.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196362; x=1707801162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eu8VZfWN0T7GOuc0qSL8pko+jJUToSbuTDb/wyxAQqE=;
        b=j4IIJqxZ9NyuRIhx7NfMCIxDeuO/xANOd8bBiyfriBuM7ZLEVFQ9zXol2JKiBqdHtL
         LbkfGnlUCL59IspuKNWph89DMuonpHgwpuwaqcdifzQCKdPfpXI4VtxEvx8xHCy54TTD
         eg1kFryko6nEHwK4375NXfpXMtpCkySYQjPnPe+/SfpBvaDWaQm4jd2Ke+kxSAtIeZaN
         qoqqAFge8PmL2wln1QMFJQdkbomjgUqAVW2vJQI/znNcnO5NQ+L1jClZHwTvuqvGIeNS
         I8eardAn6AakqnQCcmVIoDFYPUNajF+Hrw/hzXyPsz0e1oZ/4gbYq/dRo+kSC90NgrRW
         2Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196362; x=1707801162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu8VZfWN0T7GOuc0qSL8pko+jJUToSbuTDb/wyxAQqE=;
        b=ry5pEp7H01hGiKGM8AJyyz9P59h3BJ+GhdkNBeSfyKJ9B0i50ojeOt9j7BynK8pGuB
         rKMc6Nn5Mrh2kSpDqs/KbJyVgORuhtfddoPxJby9hTpJAAAq8IofbftuBHmhekSz6ePu
         gD57yOmVmVAAelIQ0lHp35OI0HAL05qPldgjggh5/YnfCuAQifuSJKlRUZXuPb3KqZ5S
         Rp/tjeAMKeE/tGFIDFJjhUVIdWPsBlS8Eypi5zbXArY5fvCPYZwWwbrnFnBebpaT9V9B
         JRyyX7YvMdyCRY9PTCkN1y3QpqlcB4M0gd/mHwZAjgwje5IXhSftXt9qGaNt2grRRyxy
         vBdw==
X-Gm-Message-State: AOJu0YzmKPwJQW4bS+cxMttFn/DfZX6EYPFjGpBFu+98zLdfKzEzyLz/
	niVoTZsXnIUyVGz5aiCA2IFHVL+zlPNm61iyXwoe+hexv4yDPY8a5W8h8UMK
X-Google-Smtp-Source: AGHT+IGqHmVrC0t8bWe2AqbF3qj/0K9pZshwr6FWcMUWPNKm5IzPIKRQdq4vtReXVmWDgznTnwCBaw==
X-Received: by 2002:adf:f690:0:b0:33b:17c5:f25a with SMTP id v16-20020adff690000000b0033b17c5f25amr360566wrp.64.1707196362071;
        Mon, 05 Feb 2024 21:12:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcFz0M/zC8l5ROa7Cn46+ZKvH1OtZ1ppwUUjP0HjolA1OP/E3LsAh/fC3G7AmzPlxgaUKIGBm+OOXymmiqe1kT4/CQGhTXMra+WzcHemg4jRaOihGL6fPlIfJfSzwhPybZq7vVpHtWe2C2Q7m5mxJpHNVuijtX1EumussxIYpmGOuo7jeubvxQQIqnX1KSVgU0D/tCy82tTA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b0033b35da3842sm1057792wrv.28.2024.02.05.21.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:41 -0800 (PST)
Message-ID: <ad77c33e4574d0d14c0c1ebb95790084c856e0ad.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:13 +0000
Subject: [PATCH v4 13/28] trailer: begin formatting unification
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Now that the preparatory refactors are over, we can replace the call to
format_trailers() in interpret-trailers with format_trailer_info(). This
unifies the trailer formatting machinery, but at the cost of breaking
tests.

More specifically, this patch breaks t7502 and t7513, but only because
we haven't fully stolen the features present in format_trailers() (which
knows about opts->trim_empty) and print_tok_val() (which has
non-hardcoded printing of the separator and space).

We will teach format_trailer_info() these features in the next two
patches to make all tests pass again.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  2 +-
 trailer.c                    | 12 ++++++------
 trailer.h                    |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 11f4ce9e4a2..f57af0db37b 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -171,7 +171,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block);
+	format_trailer_info(opts, &head, &trailer_block);
 	free_trailers(&head);
 	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
 	strbuf_release(&trailer_block);
diff --git a/trailer.c b/trailer.c
index 0774a544c4f..f4defad3dae 100644
--- a/trailer.c
+++ b/trailer.c
@@ -162,9 +162,9 @@ static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
 		strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
 }
 
-void format_trailers(const struct process_trailer_options *opts,
-		     struct list_head *trailers,
-		     struct strbuf *out)
+static void format_trailers(const struct process_trailer_options *opts,
+			    struct list_head *trailers,
+			    struct strbuf *out)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -1085,9 +1085,9 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-static void format_trailer_info(const struct process_trailer_options *opts,
-				struct list_head *trailers,
-				struct strbuf *out)
+void format_trailer_info(const struct process_trailer_options *opts,
+			 struct list_head *trailers,
+			 struct strbuf *out)
 {
 	size_t origlen = out->len;
 	struct list_head *pos;
diff --git a/trailer.h b/trailer.h
index 1d106b6dd40..3c13006a4c1 100644
--- a/trailer.h
+++ b/trailer.h
@@ -101,7 +101,7 @@ void trailer_info_get(const struct process_trailer_options *,
 void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
-void format_trailers(const struct process_trailer_options *,
+void format_trailer_info(const struct process_trailer_options *,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *);
-- 
gitgitgadget

