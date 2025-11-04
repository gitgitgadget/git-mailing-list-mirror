Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859A23EAB6
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222180; cv=none; b=BoczzttrkBAHgtstcI6UELSMvXIw50WGo1ul7yQIVEXb7unfZUCICACg0G75feFMVwKFXi0CH6/+UYK6HCmHWtG6jzucwYbMNnfMrtiEL8jeQnfm7ToQ3DUd3TEHw33pJYGslKfDuudhQcTuSvUwxSrc5vdsAG8t5cgVovtezy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222180; c=relaxed/simple;
	bh=8zX1fYgfjL0+fo4hDrNXI6pqs0OT/LxEm2jNwtdnrXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+R350JA60H2KtjePDBbZkds3wZpWFu961sdglNZmbno24J0NzAwkd+OrInTtAsFJ7+RTzW4wzQpvNKA36vytruUV8Lvi00cumBjO21KVd9kwF9XWPsmrXDce9UXnw4DzO6jXgJ4DGm6PCkMTnqQA0wuNVU+UAesxIkfQ//PH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dVmm3NS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovuUt6MJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dVmm3NS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovuUt6MJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 18F281D003F6;
	Mon,  3 Nov 2025 21:09:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 03 Nov 2025 21:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222177; x=
	1762308577; bh=/3jcu3JY95ufdApHIpuUreFcRp3dI8FSMa2Jf3srp2c=; b=d
	Vmm3NS3tysUNLc6t+e6MXAC5/f4VVmCf/Y2vJ8mNJc8mlOpwDKll2rATh0cEpycl
	XNr7wiRbQ4Z/fHE9LORaT6VzzGCUH++P8O2TKmh0wqR8B/MsJuarIU08sQhcnGiH
	SWnU2jwg38ZOc+doE9ycKOt5C/Ih5aLEfQ4FDiB4PrNy28cKp5EGmFsBbEFl5OK5
	O7r8kp+xK3KsfaO3vTfp6HmWFAHEKTd19w9+0V7TA4GFr6s/3QB/i2DDAOBfflvE
	BJZtjnJJt7DybiYnGLWKl3yDvx/dW11YYwdrB9SU90kC8R9ZLrpwtBe7hJOgG8yG
	4b32COytFKBun6YwhmClw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222177; x=1762308577; bh=/3jcu3JY95ufdApHIpuUreFcRp3d
	I8FSMa2Jf3srp2c=; b=ovuUt6MJ/umegi5oGrh4DZ3fv0h+9PSzJRzsdYvoKAiS
	kMRkp8SZH9cqgryEFuWl9WxoGarS4FYVJIH/pTV91pXqZYMmQhHzcbZvi/P0w1p8
	hRnXceMie2iaeAJqfHeFBSFLvLlMg1mhB5hmSJs+iLi1M1WfJmlD2S5SGqya311g
	vLUvBv0yVYFKxN1ySi8ASAszfUymJDPQ5l85xa7oAB3Q/YiSKXaphL9POoiackgW
	A11UgvAmkHbj2qknWNSrE+0h661qjSl0deyYazB7kzP2gvobG2GvGIF4mHabTabL
	1pLmSMyjJGFfInLzogb4RyuWJQ3je+lGPY6GE9xy0w==
X-ME-Sender: <xms:YWAJaXECzwQrOtDbzVBoSBQP6WDJgqIHPUW7g9g90JbZ6-xK2TGgiA>
    <xme:YWAJaaUvFR8OqOpSO8nGBswbOv2uiKdlMVFfrOOVK0BzMBOf-50tRZK0pfMWfQ0Rz
    3pUX_6ADbxfVPs6li73L5NmEiDJNFkr2sEFhdj_NOlL4p2cxGzAHQ>
X-ME-Received: <xmr:YWAJaWx9OHtrFSnwTMVk2ty7kDB_TDbe8CeBj0nxqN7rEewhtd5WS5--B6M_F2rVkOHTM2Frzhoux1FpdBAdOSI-eUnIgXJUKPqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:YWAJaQO4Jqcg-v2v3h3AoxdiHKdWrjmPuIIMa8AWGAux7F5CYg0U3g>
    <xmx:YWAJaf6IWRt2neYUnlLzLVbYTnjEBaTV0MF4OCqxy-dKP29k_vLENg>
    <xmx:YWAJaZNz80ELYNGEx5nH4euU6zrBFgfe5okzKJjkQ8ew5FOPREr6HA>
    <xmx:YWAJaVn6lq-xHQzt35norckLcueAf85eydRuLh6e6Ol1WlLlQvFY7Q>
    <xmx:YWAJaScdc6vr_qli1R_LeNiIlfBuO1dY2Gic8hA4Wquo0PDJl2Hxbai4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 04/12] diff: fix incorrect counting of line numbers
Date: Mon,  3 Nov 2025 18:09:20 -0800
Message-ID: <20251104020928.582199-5-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
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
2.52.0-rc0

