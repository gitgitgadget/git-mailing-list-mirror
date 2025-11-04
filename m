Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D16E2405F8
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222182; cv=none; b=mj78meRbfa/EWZebwiq9Et+tKwDCqjXkk/cHME56KX4Za+WGUnzM4Xt15DTeB90AdyaxvD7TBuzJCCnNPUe7vcYQ4j7RTV3TEey9ZopFy8ICWGpGzeTdd3LNZlgBPqVsgYORb2Ktold+d5rEVBqSf3xgFq8cYMA1lQI7T3QXa/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222182; c=relaxed/simple;
	bh=TxPvfPfvZaSsP7Cg8wdyIhZ/YByPw2ql+NX9aJfu0c4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2j68XNajR8mdgMkkOeGpkhcEaLqHnDwHIJO4wuDpB4F6GRQVXV55xTWcjTXfAJuGzq0kAsiKSJRx2E3DmngNc5erA4lstdmXhiqBhdSaDpRIVJcA+Tz7357drJJtICsaDtCzWBoAZthMqPvCvG9cl7Hd4B+dL+fsURnzQUNx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AamK+myX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epl9AQDh; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AamK+myX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epl9AQDh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC2777A03F4;
	Mon,  3 Nov 2025 21:09:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 03 Nov 2025 21:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222179; x=
	1762308579; bh=p02W+w+oXN6X+KuF0JMDXh6yOoomCYUKs/kdpXLngbU=; b=A
	amK+myXwdbszPIME8CZQX4Y3mWoXS9uSuvVK6ACFoG8jBZjS9ByB1QwrZ1Qm2cEW
	+od03uUyxe4Ma98X0t2YhR+L7uikQxMqHxI1fCXS2XEBY+VkokpxfyCaQtaDe0RK
	rAr6abZC1W+sTzJp1+Gt1VZvXm+qIKyhXXA/gLwwjCMkjWG4Y3VkeR/TFYo2qNKn
	pYUMiRQa987537h2LP01+nUALX5g30XuVrDV+Eo/aIZCxj9BqI9zXF28NYY4x4JN
	w083Gp8S0FbzexZXlDh2q1Bps04y6drJfO6p4h9qekORL0RIdQVxLxxv9ZLyt/7L
	npTaojUtjaynaIOfxJoRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222179; x=1762308579; bh=p02W+w+oXN6X+KuF0JMDXh6yOoom
	CYUKs/kdpXLngbU=; b=epl9AQDh+V2yd9c6UOIO2/XYSh+ppE8ulg4z9pMMhSNY
	6eknaPFxT7fE9WFH95bxvsw3L0EkUZhmOlwxnD3dqldb02bsjf93IbKmEzubRmLn
	ZcHcOtZRI8JziDCN3IRPUp6Vpszgj672OuBMsEvRoZsxV6IHeRiybk+Ekds1ggQ7
	sypQ0LtO1iyVoxmKAqs4kiBPiI6tmKK7GGj69Y1eCsQqouBcRouwLmep1sTqtELc
	mrmSTSBc/PNddEc993q3/dh+U9CrPmpGERarJ9ib5xduOAiOwWXmPFSec9lvLvHv
	7/SK8lxKXJRQpxUlR6su6fGari4vD65AlPpb2fXwFA==
X-ME-Sender: <xms:Y2AJaTHtRqQh8lKDTv9_S1IJSeWmn9uKz5yA6Rqa6ts1W9AeuIsXnA>
    <xme:Y2AJaWWjDKvrffK63yBQiqlz4HeuFRnOvOQTXLsrpA90lcxpMREeG4mcNn4gYn7-k
    iHAMb-vWJrlvbwdZA-SZi3q-K9RWyRAE1rZIF4PSgbIja0T4Gk>
X-ME-Received: <xmr:Y2AJaSxGk5rGkNbYsUCr07o37D3m9dkxK-C-CVqSXMgspY78X8yB-SmGfpkbdjmBqKEw60OLlASA52e9EgsoV7SomguiUuBP_KeO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Y2AJacOxKiKW-XLy-VFuzTbz5IIsFQkOIDFbV2flUp6ExGdpbqkUUA>
    <xmx:Y2AJab5fbcugFyhh5BwA4y7f0qKStEquLGxb4Jv_szXB66xXLc9pEA>
    <xmx:Y2AJaVNjVoY9xI7wKrP6WG9wT0QW_H8_OWw9bj9ZZ4EgRqp22hLGHg>
    <xmx:Y2AJaRmPHTYMZ9cWUO-ynn7d_dkO8EakQ4nxDyZR7aIBHkTQdqsRvg>
    <xmx:Y2AJaedn9zjwdBykwP_cHJOfcnWFnyCHWvVEuTLpNL2spNmUgAxTH-vz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 05/12] diff: refactor output of incomplete line
Date: Mon,  3 Nov 2025 18:09:21 -0800
Message-ID: <20251104020928.582199-6-gitster@pobox.com>
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

Create a helper function that reacts to "\ No newline at the end of
file" in preparation for unifying the incomplete line handling in
the code path that handles xdiff output and the code path that
bypasses xdiff and produces complete rewrite patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index e73320dfb1..d388d318e4 100644
--- a/diff.c
+++ b/diff.c
@@ -1379,6 +1379,10 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		emit_line(o, "", "", line, len);
 		break;
 	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
+		set = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, set, reset, line, len);
+		break;
 	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -1668,6 +1672,13 @@ static void emit_context_line(struct emit_callback *ecbdata,
 	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT, line, len, flags);
 }
 
+static void emit_incomplete_line(struct emit_callback *ecbdata,
+				 const char *line, int len)
+{
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
+			 line, len, 0);
+}
+
 static void emit_hunk_header(struct emit_callback *ecbdata,
 			     const char *line, int len)
 {
@@ -2442,8 +2453,7 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
 			    ecbdata->last_line_kind);
 		}
-		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
-				 line, len, 0);
+		emit_incomplete_line(ecbdata, line, len);
 		break;
 	default:
 		BUG("fn_out_consume: unknown line '%s'", line);
-- 
2.52.0-rc0

