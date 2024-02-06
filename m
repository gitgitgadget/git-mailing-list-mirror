Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDE27A728
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196359; cv=none; b=YIPmfeKbzJV7zccvqSR1K536nDcU537vcBCmJD/SSV/JFQA+vgolxlyIe1Jpok+kPXMpuE1OaiiAG1uW8+a2IgnPYD96QHkswuk4gO+pwl/Axsao9CyYFDx/mSadtEFN7B5JvMI6gc0Xw+wWUEAdYLbT+VB7yh/rlf+KnvAfKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196359; c=relaxed/simple;
	bh=g4ZLlEfPTK41Ntq9qyqJcpRFH6ZejOoGqeqQiTtEIFg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XayOM4tBMPL2wq0lzSBGNt5fg5ENxc8Rirw71daqlSJCNid9lmSW5sNREatHrAWN9CcMrImD08atIRomR1tYjAehYy7nVbiNLkgyB9DpraFE4eCMOHUBF5AnOZD/e+uMyWTE6fTQBfciFeh6bZ5k7HPQLrb0EjGpnI6nixQhrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS6wHNJA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS6wHNJA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fe33fb7a1so964785e9.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196355; x=1707801155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEPOGsPtHiV1uwINVtFI7NqdmubuPt+bwMAT2mZoxp4=;
        b=TS6wHNJAjDFVng31xtjFE8oCsW1MZFB2DvKhyBgPBdxUWJLfVhk4P/hbbZpbNk45IM
         /18N9eP22qg8XaCAVqSzD/cELywPGOog2upnTqxCHuGEXu/unnY/nn5j2LwCkV+47IhJ
         PZKK9S7cg2hKhgomezuLyRUjfWM37q4PZaz7o6MkFcoAc9x483DYOrRJjdjWV3M70z8i
         fNxDRMS4gp0hG278yw+mAUbfWmFE/FmMnthopEz4Mg78j7la45IxVbX+EbBv0RxERRVw
         gJU8yrZgSz+0d7s2KR+F6hLJxwwv/J6bEDrYqEznPGNxDt/cLKVi7VxcWXlIEkFP9OG+
         SU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196355; x=1707801155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEPOGsPtHiV1uwINVtFI7NqdmubuPt+bwMAT2mZoxp4=;
        b=jvQspVbNr70qnBS2vbahVsb6+C0dl0sTVnJngLpjTVJG77TWPG4VYCxJNBh6rYquV1
         5RGPb/CJsd/88N5KV3bgoXE9p18d5ug96NF6FKyBRzlTr/alYVFhQbJwGVwDrA7byPSP
         x42cqHqRS0H2PK3rHelb9gX1iKkPBKnmA77Tb0hPMzdUiM5xmBJBDtUqQJINeGfVsE0R
         xoPbegFjuJ15gwZnys9EHisilaTFqawcXKVRcWQFTCNYGFw14xYZ6XrWdOcMwE1SXumK
         Z1d3sVsI+ip12P4TDQbE0eLx24+cb05a/C6/zIMiz/UCDVo3W2/LFSi6CH+ItpgmEbK5
         nMlA==
X-Gm-Message-State: AOJu0YwpA/qqdECCuZIUqzu+zvBj4m8esqYMvLhyuR4vGNUf6SbNm7I3
	Jm3VUOrcZShz1gFsKSAnp/PpiBm35VUMtb1SUXyIvButYda1TNeO/vUBvogd
X-Google-Smtp-Source: AGHT+IGG+wE5EE5/GxutCT6plm5xVG0wq07kbQQqFXEAFiB7PFTDEtt3hq2NyzzRB0TxFokw3r+meQ==
X-Received: by 2002:a5d:4565:0:b0:33b:1786:f911 with SMTP id a5-20020a5d4565000000b0033b1786f911mr342531wrc.54.1707196355636;
        Mon, 05 Feb 2024 21:12:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWT/SVfvJtOGUWIVrWDaSU7QGXyKDkAmfyJ19hdDEQgHSbrILveaspGIw2/w3FiJ3mbnmixP5rBMpwgz8PR307KpY8RKt1nJEyNGPKOcGnLahc69woDtR5I/N++HON+TM1jReur7cF8/eN2V3wJ8ZFAQLzCSXZY0aFmpED74LGBhImqBCsO0qHrOWvFaWlp/JXNtpFwRA5I2A==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000008900b0033b484c3dacsm224287wrx.57.2024.02.05.21.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:34 -0800 (PST)
Message-ID: <b2a0f7829a1c5f2822e9a896ffe3744587ff1298.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:05 +0000
Subject: [PATCH v4 05/28] trailer: start preparing for formatting unification
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

Currently there are two functions for formatting trailers in
<trailer.h>:

    void format_trailers(const struct process_trailer_options *,
                         struct list_head *trailers, FILE *outfile);

    void format_trailers_from_commit(struct strbuf *out, const char *msg,
                                     const struct process_trailer_options *opts);

and although they are similar enough (even taking the same
process_trailer_options struct pointer) they are used quite differently.
One might intuitively think that format_trailers_from_commit() builds on
top of format_trailers(), but this is not the case. Instead
format_trailers_from_commit() calls format_trailer_info() and
format_trailers() is never called in that codepath.

This is a preparatory refactor to help us deprecate format_trailers() in
favor of format_trailer_info() (at which point we can rename the latter
to the former). When the deprecation is complete, both
format_trailers_from_commit(), and the interpret-trailers builtin will
be able to call into the same helper function (instead of
format_trailers() and format_trailer_info(), respectively). Unifying the
formatters is desirable because it simplifies the API.

Reorder parameters for format_trailers_from_commit() to prefer

    const struct process_trailer_options *opts

as the first parameter, because these options are intimately tied to
formatting trailers. And take

    struct strbuf *out

last, because it's an "out parameter" (something that the caller wants
to use as the output of this function).

Signed-off-by: Linus Arver <linusa@google.com>
---
 pretty.c     |  2 +-
 ref-filter.c |  2 +-
 trailer.c    | 11 ++++++-----
 trailer.h    |  5 +++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/pretty.c b/pretty.c
index cf964b060cd..bdbed4295aa 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1759,7 +1759,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				goto trailer_out;
 		}
 		if (*arg == ')') {
-			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
+			format_trailers_from_commit(&opts, msg + c->subject_off, sb);
 			ret = arg - placeholder + 1;
 		}
 	trailer_out:
diff --git a/ref-filter.c b/ref-filter.c
index 35b989e1dfe..d358953b0ce 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1985,7 +1985,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			struct strbuf s = STRBUF_INIT;
 
 			/* Format the trailer info according to the trailer_opts given */
-			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
+			format_trailers_from_commit(&atom->u.contents.trailer_opts, subpos, &s);
 
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
diff --git a/trailer.c b/trailer.c
index d23afa0a65c..5025be97899 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1083,10 +1083,10 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-static void format_trailer_info(struct strbuf *out,
+static void format_trailer_info(const struct process_trailer_options *opts,
 				const struct trailer_info *info,
 				const char *msg,
-				const struct process_trailer_options *opts)
+				struct strbuf *out)
 {
 	size_t origlen = out->len;
 	size_t i;
@@ -1144,13 +1144,14 @@ static void format_trailer_info(struct strbuf *out,
 
 }
 
-void format_trailers_from_commit(struct strbuf *out, const char *msg,
-				 const struct process_trailer_options *opts)
+void format_trailers_from_commit(const struct process_trailer_options *opts,
+				 const char *msg,
+				 struct strbuf *out)
 {
 	struct trailer_info info;
 
 	trailer_info_get(&info, msg, opts);
-	format_trailer_info(out, &info, msg, opts);
+	format_trailer_info(opts, &info, msg, out);
 	trailer_info_release(&info);
 }
 
diff --git a/trailer.h b/trailer.h
index c292d44b62f..c6d3ee49bbf 100644
--- a/trailer.h
+++ b/trailer.h
@@ -115,8 +115,9 @@ void free_trailers(struct list_head *);
  *     only the trailer block itself, even if the "only_trailers" option is not
  *     set.
  */
-void format_trailers_from_commit(struct strbuf *out, const char *msg,
-				 const struct process_trailer_options *opts);
+void format_trailers_from_commit(const struct process_trailer_options *opts,
+				 const char *msg,
+				 struct strbuf *out);
 
 /*
  * An interface for iterating over the trailers found in a particular commit
-- 
gitgitgadget

