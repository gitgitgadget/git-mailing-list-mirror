Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F6425898
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754815; cv=none; b=LyPApwbs3GF1zNbsTNEqIaFU2YmKHEAKe3UM8z4OX8tScBEnlPtcGtk/jCxP5AEwojzfqZ1XQsPJMRtqmSwgDFx0yYSFxbdcidifghMaLbBHQWkQ52KGqsa62nMJByUuYAyfO+5N8jd39Pl7CcxxcuQpWBekiLACA6ojOg3hni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754815; c=relaxed/simple;
	bh=frP0b1rRtJke08fZtM+YirGY4Svms9LnztF2SdCVgKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nBdsIDuCjH3TSiGgvbAF8OzXu6BRpLcyFAaHdyMkUW14HEpEMYIX8fmQG3CnLPL1lSTJTlg6Qlz7SQBzAjtabesA0EC6C+wa950X8FjJmHUmHg2vdyA/s1J8rPhqjrgMHVuC+ZNXdh27494wR1C4ENh4fRC4O+CnZRe4HNVzdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J9v17R7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GFBEbQA1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J9v17R7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GFBEbQA1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F28237A012F;
	Wed, 26 Aug 2026 10:33:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 26 Aug 2026 10:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1787754812; x=1787841212; bh=+lNghnm6zjB55Gf7ZDSg4LGSJO1mKpgo
	t4wthvb7oBA=; b=J9v17R7uihCmx9P5rn98/6lXEYuCxLLCx5MJhgptu+DAuFxa
	a1OLH6Z3PtYWcpfrjH70xvOmqq4OesymU45j/Jk00xFZKnxIUttRjkGl6nlfFWsu
	xl1vlvDnyYi6Ny/rLIk8QgOtPQyOl9gzsuCMQ8UU/qdzh+LXDVltGle6luGGSext
	FAPi30wTv/urhGX+QcpuguV1JLCRyDGTAxpE71N/FXBexsUG9kVgga+MG26urADU
	1Igj92tgauFa1VVuwV7duosSy6yP4hLK8Y/e+qsdGitHVJlsePmX8CPZcf0O0E7q
	D0uMSUp368P5vrVwhLP21FwPIbHO1UQbTTY+jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787754812; x=
	1787841212; bh=+lNghnm6zjB55Gf7ZDSg4LGSJO1mKpgot4wthvb7oBA=; b=G
	FBEbQA1u+eVTej8giY0q9ziZxKSDB30Yuh7J75q/oW7AOKuK2bUDQv1/2m9PIJp1
	JFToOAZnZvzSahMd1wSYunf2CVOhxMce2CnSk/KvXJ5kHrnNUMnF184dC2O9ppDE
	vk3cuD9Ir0cfcmOntsk2BAi2lNZbEKV3kLwKv/uevxWtWa4VtNCFZ5SKqaoFGoUU
	/shtDCFQwHgXuEzntbBXqGOgKAiyO9ck5KGBspHIpxNgy3E7EQ2yUChjLFJk2XUd
	xzfZ3O1xRh7tpz2jRSjPKSDGkpW2Zlica/ZkRC5lI2VNwUrrYQVzQthvPhYTQ9zu
	Ogu7ZuQ7j/C6vsre+RMew==
X-ME-Sender: <xms:PPmOai6pHcMmnPhV6XITAa8GNFWR6jIlwG9CDV99yERBSji-pByc9g>
    <xme:PPmOah78m2wn8QeX9c4OIdPAarGospYBsPgRgwtkmIkaecripnJJ4YFX9zI2943DV
    c7Kc8wJcvGUVsmpzfC1bfChUCGj1eO_zoVEmGufmov-YFTLUdHL>
X-ME-Received: <xmr:PPmOavFC3gYCcAzoxejN9UXR-XdnJHUfn3RiKXVlEmCw2_hjjcE3ar2bDj_oPMnGH9Tm_BjbsryIfvbZojhBJaMpAWegJrJVqg>
X-ME-Proxy-Cause: dmFkZTEV9UgaT5g/kilGL9ONq0YFy24FP0UEiCVQ8+9kMdsaYAM1Cveu/lhuzixQ4+3rVC
    ++J5z+u0oh9WqnOAFDnYN7FnTx09JIco8vQsV7v8X2+56R7gxoxXzpC6mfkpUzgb8eh5sv
    QncX0c55SNh69eFCGcjh+zGiZ2phA31zyKynBCZD97LvFkssKQDvD+YWH3OcKZe1YQ/7vV
    nHFh3/m18KunACo4jnmUmEGI76XDVZIITn29GzFDSXSUqw95K3P9H779mMvEebl4lzX977
    kbIJY/q+0vjjKHX6b+j+QJNwmBzKZ2hMnJLys/6hNH9C7dH6mneiVxpVUZtYAOUID6QZog
    1Ys+zKdsSV6XlLBCVpfaeByOcHGHJA8MnuJ93+XSoMsQ0TfcHwDlQ+HIaAQu01JUzOlO2L
    qAbzL4sW554083XS0wk3xR+XmBOzFTtcUvaokWsVZyKVTASGbHTa+9VCnKqvpBmFMYHG+5
    ahnUxD952ngLMAMG53E55MBeqQK6DTph3DQuGWt3jUjHQ9MY2YWTJnMeXx21LJx8l0i6B9
    /qPeHTolgpNnE3ERsnMf1MA94kqsRLxy0z7M7WYQO9p6v1GrQKYOs3PqrK6ThnaZCCZgT8
    pwAUITo6GkggiHKftazbnQpOMOY3bKEk00UaibFWJFLuJpLZlbgYkCmUIMtQ
X-ME-Proxy: <xmx:PPmOaqRPzXj5nbiSyRhJgFoRo7Ba_F1XqZKQDEg47ISruQtse5SwvA>
    <xmx:PPmOaou-7nG_RL70M_y_3odibYJFk07zovEuh52MCI67R6rBe7nVNQ>
    <xmx:PPmOapzuk9GU0w8dO64gjPtpSCiknWQi120hs8PWEbdhux5V5RxJ4A>
    <xmx:PPmOai5zwT-ENCy5DbV2oeeD6BwXMdyIgkkViAWWoqBzLNKYoLC9MQ>
    <xmx:PPmOamTmFDVfe8MVIN1hPBk6BY-lczuw8rj63Igr4GCmV6q-UISn-dQI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 10:33:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] you_still_use_that(): reword the instructions
Date: Wed, 26 Aug 2026 07:33:31 -0700
Message-ID: <xmqqo6epj6is.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The message is overly long and may mislead readers into thinking
there is recourse other than adopting the new workflow.  Clarify
that it merely helps them find a replacement, rather than offering
to reconsider a decision that has already taken effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 usage.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git c/usage.c w/usage.c
index 3f0118ab2a..9933b9911c 100644
--- c/usage.c
+++ w/usage.c
@@ -392,15 +392,13 @@ NORETURN void you_still_use_that(const char *command_name, const char *hint)
 		fputs(hint, stderr);
 
 	fprintf(stderr,
-		_("If you still use this command, here's what you can do:\n"
+		_("If you need a replacement:\n"
 		  "\n"
-		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
-		  "- check if anyone has discussed this on the mailing\n"
-		  "  list and if they came up with something that can\n"
-		  "  help you: https://lore.kernel.org/git/?q=%s\n"
-		  "- send an email to <git@vger.kernel.org> to let us\n"
-		  "  know that you still use this command and were unable\n"
-		  "  to determine a suitable replacement\n"
+		  "- Read https://git-scm.com/docs/BreakingChanges.html.\n\n"
+		  "- Check what others on the mailing suggest as a replacement:\n"
+		  "  https://lore.kernel.org/git/?q=%s\n\n"
+		  "- Send an email to <git@vger.kernel.org> asking for help, only if\n"
+		  "  suggestions by others do not work for you.\n"
 		  "\n"),
 		percent_encoded.buf);
 	strbuf_release(&percent_encoded);
