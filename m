Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC917D2
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252096; cv=none; b=Zzqm8hRyZdljkEY9xTgZEqaTdAcF1FeEgbYAqJ2J4DfZJczSDqhkEF4kSFmmgteodzEVTxebs+FvQVEUhF22+uBqqN8sfDxsiaCU7XvY+GRTnxJzmXG/nHNSmNgCd8/7If0PKq6umxk3dqbxd6xpJk9VSS2CN270NQV+eWxSlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252096; c=relaxed/simple;
	bh=fiifOQ30GqMvHhI9/LOQ6AWtcFKC8Ys0gKUdEDybgGk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=COhblFnI8NLguWfP65dIS5hO0u9ThGFX8ArRVsrcwed6CU0xV3jSwaGyUnYyt3M7xQYTe/Pwo7/9LLUxX4RHLF+bWBTAbOlbHlpTQKFxty0C+yKiOzdOPlmPJ70whFZcibB2jdXauup9y5LawXhd+VLqFFfDlqrwPGMsPy1czxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl9dHH7g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl9dHH7g"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412c23551e2so5442805e9.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252092; x=1709856892; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrctyrePLkHINnJUdYYp8v79VB8peoiGPur5KFwl0dA=;
        b=Cl9dHH7gM33M2uZvPl9/wZZqaS8ghqSRxdzXFE7BGQ4QtyuRCkDHP4ZcZvP8nubxQF
         hrxT0CnDKMJUcvhpme3TX0qDQPKZRLS0d2CgxGQi2pXLpq8L49r8LvgKdeLmS0ASlWc8
         jMlJjhlsD9ZnwavvJNLM/XrYGx1UXag5xTIYrQLrDnK9905na3crDb8ZXJr4lA8vaWfu
         RuiPZ+gW0oh7p41YHU+wD0VZYs1ov7Rkv3TPrxrywjUWxUfGNU9kbNjTxixN7qLRWtvT
         iuylX7Ds7dRW9AQ/5BowMcP76fknVq6P3euVc07rtRtjx5rQPoXyOnXjsdF7BL7QCGpC
         46zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252092; x=1709856892;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrctyrePLkHINnJUdYYp8v79VB8peoiGPur5KFwl0dA=;
        b=jq51pvu2QC4D+i/flBUjqdkjaEsHEAQNvWJgfh8FQoVuBQTPJmlGt/l/uqHl+tzwc6
         w5xDbF8+x8GKMMMaXXR8Sfn2Cu+yTSVqDOvOgAq30aNmxucVppF5EuPQANMMOekVlO3T
         wl3w0xBixTE4GEqDxxosNTXeEuoB6Ow1PeJpfoOFEHf0YhDwWx/3MxyIIWNQvMVZ6iGv
         Ho6fu0fQy4rBD6Xoxj21ZS9BtMyvrkrGs9qI+BZvOttCZQhcKTXoo72faGoKNRzzdfbF
         y4QYNDEL8FGEqznKW5kQwHghIH6FM5iik4lJRhpUMxgS+ReFeOjQqO1ajQlVXzrmUz1Z
         s84g==
X-Gm-Message-State: AOJu0YyKwd94YCblsbhpEiNs2hiW8IgusV6S1HsMDl1tsm46QhKTff2i
	4fdq+oVrWYE+mdrZ8CJUpqRAbwSJU22qvOMyJsORqPuonZGZOJ+bOzVrmLpi
X-Google-Smtp-Source: AGHT+IFk9zqJ0XVFaxEmPt2/zOYksAKSGDDNuK52qT3/WKtbNsHFwvYOOPRwyYOD48rkUHiLnlKQ5g==
X-Received: by 2002:a05:600c:1c28:b0:412:b6a7:ecf1 with SMTP id j40-20020a05600c1c2800b00412b6a7ecf1mr94361wms.0.1709252092240;
        Thu, 29 Feb 2024 16:14:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00412ae4b45b3sm6839086wmq.30.2024.02.29.16.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:51 -0800 (PST)
Message-ID: <47c994ce025e5574454234b686c41b7b9170cf13.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:42 +0000
Subject: [PATCH v6 5/9] trailer: reorder format_trailers_from_commit()
 parameters
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
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
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

Similarly, reorder parameters for format_trailer_info(), because later
on we will unify the two together.

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

