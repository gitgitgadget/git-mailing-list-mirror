Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75411C28E
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819504; cv=none; b=tWjijW4IFgDiGWA9RETFYYvv7Gk5h9XJr9Xjy2rV11xeriJp882Vngj/lbamxpHjzjsVa0vtfAT018e0rxMe2LDuIwmCDRaeM7NQ1AunuDe9ROENfuyAzhi40vb89zjIkLzYX2wVdzInCvlh7Z8sIN36wzjW/anvR9b8A6jJ6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819504; c=relaxed/simple;
	bh=me9KE9hNIXM3KsYj9q5PakuxjZ7IqO4O7/yXaPPVB4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m48CieyUKFlLx3u7cZcML7310KvY7Pjt4H70/0A//S0cNRUkB6S5fI78C1Mpr3jZNr8qwZ+/n2poY2Ab1WDvpgUrGmHzMqqZfAERdzWWJVnX8sgaqkE0fwN6fVdUrFAYD+/jP0c76d0tw2Zc9hvC8i0sWui5THo7atpYEU5iqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KnZLrRr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRkPSFP1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KnZLrRr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRkPSFP1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22F907A019B;
	Mon, 10 Nov 2025 19:05:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 19:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819500; x=
	1762905900; bh=YwM8LxDnjSv12FSjYXapAlimYpwnRGOTf8uH51pzJTE=; b=K
	nZLrRr+xowI0SJnpL/XaNfeN9INcH6YWfI0JpI3thMzzZoDWif3STLEaSAc1BC+O
	Hr1s1C4HVZ2wKZR7suerAEqrswfpTYi+Q335VxX8qwg9mxRwee0P+d0TPmfOHY9X
	2mXeQW7gTP1ijmc9nH3KmW30k1ptuwJn0p6aZ8HoxEE+dbQYLlWhNZsDRlzbAb/5
	Ls1+p0CTmQHg1pvHcqQXEW2xqMHwlGYDFhG4E5d5uWys0jVD+DmoDZmoSLLpHJXn
	uxGjRag8RksGMXI6McXXWuxt4Qgez423gROnTsfXrBwTQE4wbTMhljNnNeumBraT
	k4U7HeQuaowyXHrwZ0R0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819500; x=1762905900; bh=YwM8LxDnjSv12FSjYXapAlimYpwn
	RGOTf8uH51pzJTE=; b=IRkPSFP1HAWcgwSqh7BBevCqxkwfWD02dw0+3mYjnzCi
	WODiuWikTOUmG6LBtl7rj6jYU9xTxOqwQpMD/D3xWVCmyLWdKXDZz7Zas2OfbDvU
	NrAsopXT8O3s2UcOfUyb0DXjUKqTnw93aDVWOAtLYH+VmzRPE16awmt8ZZunEW2q
	R8RX9Jvw6UNKHCXtaO7SIBADuVeIb4NIYpZTVAb+sXkbd2Kq4q0t9WlAHDXftxvS
	pgeqFNGP/X8FXRGESVtMLVORp3c4vIsOnFT5ANHlmU7trpM3qgPSks+FFR9Xf5OH
	92jZ80dLBzHQztu8laKIaQc4W6zpJ/Z9Rw4YRyoWpg==
X-ME-Sender: <xms:rH0SaZFu2cXg0mMtmxZHC23OFiB6Dsfyj5oxFVz9HSdFKl0oE1q4Rw>
    <xme:rH0SaUX5KRuPpjehVhfx0dkqbLs8VQz4OOv8kryzy7sGtl-yotkFP-K0K6REuEyVL
    XF7HcA9oNLupGy7C58dS57xDpJS5UJsfaKxBtKMblgo9_yFt6MF>
X-ME-Received: <xmr:rH0SaYwWuBxcojv9fQblqEMwbO9Xo4nmy56mS_l6E1eo6nj3rKKrDcZLer1a189OSqDkTQmcNMRTJBQ3BaGSVLSqAkfnP-SexgLC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:rH0SaaOqjfchKzEppP0m1pjge5rM7sxyNO1lZXAZtdtb3m_zShbYOw>
    <xmx:rH0SaR6XqkCgQjpnaxs41_9yscwTPVEvbp1TiBtpw9Y7CSOeMY6-7A>
    <xmx:rH0SaTM3p71NcUeqFBqd8X3RzbRGGJOKawawAWkvYslhYttqqxqZfw>
    <xmx:rH0SaXkFY_Sa0ige4_m5DtgJQbWuSYoEcHvqxW10UVfjlEc6BISpdA>
    <xmx:rH0SaUcZxhufpv9omJLWWY2Cd6zbWc2eMzAl1O156Nx-C4mTOUUVWlxe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 04/12] diff: fix incorrect counting of line numbers
Date: Mon, 10 Nov 2025 16:04:43 -0800
Message-ID: <20251111000451.2243195-5-gitster@pobox.com>
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

The "\ No newline at the end of the file" can come after any of the
"-" (deleted preimage line), " " (unchanged line), or "+" (added
postimage line).  Incrementing only the preimage line number upon
seeing it does not make any sense.

We can keep track of what the previous line was, and increment
lno_in_{pre,post}image variables properly, like this patch does.  I
do not think it matters, as these numbers are used only to compare
them with blank_at_eof_in_{pre,post}image to issue the warning every
time we see an added line, but by definition, after we see "\ No
newline at the end of the file" for an added line, we will not see
an added line for the file.

Keeping track of what the last line was (in other words, "is it that
the file used to end in an incomplete line?  The file ends in an
incomplete line after the change?  Both the file before and after
the change ends in an incomplete line that did not change?") will be
independently useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index b9ef8550cc..e73320dfb1 100644
--- a/diff.c
+++ b/diff.c
@@ -601,6 +601,7 @@ struct emit_callback {
 	int blank_at_eof_in_postimage;
 	int lno_in_preimage;
 	int lno_in_postimage;
+	int last_line_kind;
 	const char **label_path;
 	struct diff_words_data *diff_words;
 	struct diff_options *opt;
@@ -2426,13 +2427,28 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 		break;
 	case '\\':
 		/* incomplete line at the end */
-		ecbdata->lno_in_preimage++;
+		switch (ecbdata->last_line_kind) {
+		case '+':
+			ecbdata->lno_in_postimage++;
+			break;
+		case '-':
+			ecbdata->lno_in_preimage++;
+			break;
+		case ' ':
+			ecbdata->lno_in_preimage++;
+			ecbdata->lno_in_postimage++;
+			break;
+		default:
+			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
+			    ecbdata->last_line_kind);
+		}
 		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 				 line, len, 0);
 		break;
 	default:
 		BUG("fn_out_consume: unknown line '%s'", line);
 	}
+	ecbdata->last_line_kind = line[0];
 	return 0;
 }
 
-- 
2.52.0-rc1-455-g30608eb744

