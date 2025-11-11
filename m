Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CA8460
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819508; cv=none; b=qT8EyjbOGHqP1HtMfpyUo34hbAv2R+E/hh505GxuNSzJ5XJKs0ayHCOoMsTqreeZcnpYc19QI5cXaTmbXji6iesf2GX4oX0s7KOFwzl+4wEx+VACszqjV+cE9skjK5Ht644Kn/qlAcZdacqhI3dNp14oPg9FOnlgucp8bZbMT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819508; c=relaxed/simple;
	bh=Mykx1tiKBuC65e10EH3EjzgcozLQDvyWb0j+NUZV9dI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2GMyFvIwChen+9Vg9k+qGUms1xWeSPUIshZN63S0uoBOyoZ7Six+rIm/gaO+2m5z7NCALjbO7S66KyUUIkgHalxQy9pxdCodq4ryRrqmKBZ+0TGk/ULyRd3W4qUM8ekrwlvGB2i4a8LzHfLtgTAsDH/dA7k5N8RgKJXc691H4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MLUyIUh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8qgZTgS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MLUyIUh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8qgZTgS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 34CB61D0012F;
	Mon, 10 Nov 2025 19:05:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 10 Nov 2025 19:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819505; x=
	1762905905; bh=FrXxchUKeTE5GH0KHHVF2G8YBUQUcF0B0dy8htFVKWQ=; b=M
	LUyIUh41PvdInolt2bK7d2py+oMfzh1Yqv+RJGvWCYTAdUie1DK4/5kHE/RDVWcF
	ynElaWXt8kCcAiFeQiJbrzTDxXCb18ilR687C3dSXcFYjFpVi5UVscrFY2myktLu
	ExS4FArw/yyHC9FQhOmhiP2SLMHcyPjXD4j90cxlbVB/9DC7FyYo/T7Vqhjd7cpl
	GuisrdiZzeCnLlPrBtK2VHo5GVvAW2eLQ3JsM96Qes8ZBFyLBxaSNAL2ENL65Cyp
	qW2XjO9tCGtcH8jZn7XzolMss/q6k5S2Iw9Kj4Jnnv1PsaUCQXqY/OkVR14YjK65
	FKdosmTLN2cBpPwoUj4cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819505; x=1762905905; bh=FrXxchUKeTE5GH0KHHVF2G8YBUQU
	cF0B0dy8htFVKWQ=; b=Y8qgZTgS+h6uKQlREFtyxlrAqmIk2VcMJ3LNh7kn5fXc
	qKtodx88oQP05wmZ3hG8s04xTJ+G8v5oX0d0JXFVtO6fsCEis4aoo+XP7NpxzJJQ
	+Q8ILUZEvF2fH9RZdjGSGje/cOz/+9Zw+MFQkpbbgwGTA1NAPlUlafoAdq1jVUS6
	M48LUzFjTg1LA/3IWjEJLwZ0/pjlDqoRs7PeB9X5Mk04Y6pidj1qA2PQqMePt8Ky
	LDe8V44hTG3/5DDjllNsxk7U74/8/sCkX8lpUqzj74SVaVvBDggTL+MPJuMgT9C7
	q70qIE7f1aqI7znqNP8iyWzpvcS9Ogm+Arz7iTs13w==
X-ME-Sender: <xms:sH0SaT0e73OK5v6Kk-n5EEUWBEH7y7QJSU2FIOMHLLw32v5tvD-NwA>
    <xme:sH0SaYFNytBsanOdfTJcaMHsKFTrhIL-QkeV-xnYvX827rcYWgIwa-BHMKVv8D9D-
    2EWhswaFdmLNABHxNO04QaIJJLLfz8pQq3igUZ_VwcLymn9x4hE0ck>
X-ME-Received: <xmr:sH0SaRjc-SyX8n_2bgFkUD7oQPMsMO3MndO3N3dxoRUlXf8TvBWHTz3k39xJ2C7vWw_GYlnmS3z0TzV6Xu2HzYntZRpb11MdzLKG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:sH0SaT-PGoBdbvGfCSIFXn9blMEgVKm-sShv0LFD-h46rD9pgMjpcQ>
    <xmx:sH0SaYoV3AE-ZzmV7wFPnF6feDqJ9Yh3Km6hi5qCT5GpiB8NnycRhA>
    <xmx:sH0SaS8T36oEg9p8lrMoiW4MfhkHFAVdI8XMMkpiVH4ZBPIIrWGjOA>
    <xmx:sH0SacUXIHlzLxYHHg3u1MMPkQokEL2MosgoM9m5Glp2HWIwsOnADA>
    <xmx:sX0SafMOqeDTPU9GuEh-lIJ9x18oLU7VP7JjPfynVffpXMme4ySZS3Eg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 06/12] diff: call emit_callback ecbdata everywhere
Date: Mon, 10 Nov 2025 16:04:45 -0800
Message-ID: <20251111000451.2243195-7-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
References: <20251105213052.1499224-1-gitster@pobox.com>
 <20251111000451.2243195-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everybody else, except for emit_rewrite_lines(), calls the
emit_callback data ecbdata.  Make sure we call the same thing by
the same name for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 8f1b4e6069..67071136a4 100644
--- a/diff.c
+++ b/diff.c
@@ -1780,7 +1780,7 @@ static void add_line_count(struct strbuf *out, int count)
 	}
 }
 
-static void emit_rewrite_lines(struct emit_callback *ecb,
+static void emit_rewrite_lines(struct emit_callback *ecbdata,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
@@ -1791,17 +1791,17 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		endp = memchr(data, '\n', size);
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
-			ecb->lno_in_preimage++;
-			emit_del_line(ecb, data, len);
+			ecbdata->lno_in_preimage++;
+			emit_del_line(ecbdata, data, len);
 		} else {
-			ecb->lno_in_postimage++;
-			emit_add_line(ecb, data, len);
+			ecbdata->lno_in_postimage++;
+			emit_add_line(ecbdata, data, len);
 		}
 		size -= len;
 		data += len;
 	}
 	if (!endp)
-		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
+		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.52.0-rc1-455-g30608eb744

