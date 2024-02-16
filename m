Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFA1487F3
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124960; cv=none; b=lJTrS1GMACeClJfy2kdL3qi/D7F5v6Fxc7SuB+fW0ekz4XYpNiYXluL4L5o1CJ3C/5v+2d2YyhqcGysZSavTQ12d5zqKe89O/nxlrhdJKx43IZMh4GY5Uq0iB2GRwARJvk42dg89jWgvmKWWa+Ur4uM5cSEAi5xB12er4CD3t1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124960; c=relaxed/simple;
	bh=g4ZLlEfPTK41Ntq9qyqJcpRFH6ZejOoGqeqQiTtEIFg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SDfeyD6dKuAYNvVFTcDx2+TDSM1dBDZTuqD7FJsAMfW5SIql+xEMyxUEfLpiIs036SlSE7r1RoGracuTfak6hB77ZEgFp0nzaLEnRuCaEqYw3pWSgeKkMisp2fqn6XzULSGwY58eg1tliS4NpQwOF+9GQyfmfBHrhZWVFevLKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0IMC3vp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0IMC3vp"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b28aadb28so1428413f8f.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124957; x=1708729757; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEPOGsPtHiV1uwINVtFI7NqdmubuPt+bwMAT2mZoxp4=;
        b=l0IMC3vpP5K3FakpOaaDNs5487EjIqel6uCglEBnflxfQqLt75sKTrbCLQo114I/Fr
         rpywohVcooVVwfc+c2gL4qsuaFx+qvG9JluOjarT3dtI5txBPey7XeAKCGuYFGn0rDe6
         cKAhO9wtz+3o5SijjQTYjaJb/MbgeSel+vBruWHS09L2aVVd7wgxJ7rvDr5RoR0V/Cge
         LSVuAn4mC+12QPUk0Cov1AYBzwLzSeidk+3YLf35ruSSo91SKR+6Pnyibui/SVOiGL8L
         Yiz7EjttMMS8BfGX+pM8ufDa0dcjkcpLyrS4RkP9UPAAEPu4a/Tw3BTCNe21lm8g6qrr
         RJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124957; x=1708729757;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEPOGsPtHiV1uwINVtFI7NqdmubuPt+bwMAT2mZoxp4=;
        b=AxCnd72Ag8Z9LLkEDr+dfzZs70pWffD/5S2QuihhdHRV6SLf16s+mA+AyJYGVAihuI
         Z4zWov34GyVD4Fohc+sex1lkaCTASTXHTbb6hR5X82fboRxMy7DXbexJ+DiO1ccU0N8r
         /mg2qOdikSsw9TaSzM4pdWovjp9T5hSHnhqKFpFWl9f2QU8Gtcm4CyIKgittV5jTWieY
         9KjjvntEqmrg16YhyIlp9ZM2GIf55X/ckqeyU4N+3lwdnsDfclHyzYSQVKk84768sP5b
         sHoTh8UDddzok47v5AbJWqTxYpSsqKxJz18dlcldSWW2umApRWETG+x7k4NnmDO7tJ38
         QoQw==
X-Gm-Message-State: AOJu0YzIzJ/m9X0M68qCEIJ1sxYSqcW7j8PcUR/m8n1FN4zoT4j3PLCZ
	dgslwYZbnJGgQtkbH6WUKwITlG7HCGmg2WbBJAuCKPi1oGy4nmlhuVBC1wUm
X-Google-Smtp-Source: AGHT+IEu/tw7aetr5SRUMrJVmld8baz8PtD2Ix5Mzmal16qmv2oyKG17T3XIvydbP3KEtn4I8tvcFA==
X-Received: by 2002:a05:6000:154b:b0:33d:2848:79b6 with SMTP id 11-20020a056000154b00b0033d284879b6mr797196wry.45.1708124957110;
        Fri, 16 Feb 2024 15:09:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d420e000000b0033d282c7537sm735922wrq.23.2024.02.16.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:16 -0800 (PST)
Message-ID: <b2a0f7829a1c5f2822e9a896ffe3744587ff1298.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:06 +0000
Subject: [PATCH v5 5/9] trailer: start preparing for formatting unification
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

