Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB02ED860
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984989; cv=none; b=DCNF0uwgClrT23INPEYNkQWt6GtNpr+ua6fCXoA7fhixcXbCQV9rEG2z+5HF8tkHq4WWjNkxAPl4vliLn7lRbnE8on6MQeuajRa2phbIFcWvHaJ/miwln9Jhb72traUJFNmPukuvo2J0QDUW56nfEAJzIpXDO1NiDesrkqoOiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984989; c=relaxed/simple;
	bh=VlZmcWuoQ2WgncVRFtHB6rODYNent8xnhNwaRY2uCF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTm2kp3lSRGPNp0frKJXAKaUUXm5mS2CTX4pPMuAOUpiKzNzeEue9llLk4k5E6z/F23yJmBmSPdP2EKAwQQcMTCx/dnlpb+QtPWXmEs01PXB+PNWxLyhCjepJ0Bg3rq+w3L/ZQH8Uom1v4JAtrNvQHafu3+eKtp6F3L0l0hE6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cExVWgC5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y/PoZvnf; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cExVWgC5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y/PoZvnf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 778F67A00BC;
	Wed, 12 Nov 2025 17:03:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 12 Nov 2025 17:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984987; x=
	1763071387; bh=aEZOUMtamhY3HFlH6IJEq182TVPB0MmaCGT4x9RfgGw=; b=c
	ExVWgC55q3nH7NbZVMWtzLADRbSFnfotwmHVRs5DoVkTFqeUlFyj+vlmPaDGyH55
	P8HhvE6QOZpQWOiYm549cJerfHsXa8oIQKJNlw9T2TPiu8RFLMNQijo+0TusM9xj
	+YekLvxpAizelxuyQUNaY+WJJRxDQTjqCwAL0QlecttjU+128tE5kq62L/8NTPlV
	8llI54wPTku+qU/ixxJLYaXYpU2sHTqHzMH+4oFJD1EtuV/oO1oJhyIjA9qBy5Bx
	Mu9pqlmc6WfMN2IeaJSJtYGc6eIzkRQeMd4r8df0VibMNEodeUf6h/0meTQP18/d
	fly5zEhRRZDbMOHGBUSKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984987; x=1763071387; bh=aEZOUMtamhY3HFlH6IJEq182TVPB
	0MmaCGT4x9RfgGw=; b=y/PoZvnfC8DiuYF/mzzaUhhutIFt1b355xLRAph/LHoL
	+PJchenPGXlM9sb7y8NVZaAzbdJpFp/47zTphy09gn7XHnGwUibi/zKUH3Ta6dWa
	2wcHpMoLq2PlkNz//FDPqaDzVu7F10gBV+1imw+zizFciArCx5ERtPPNV4xpTWay
	dHlnkC0SIfr0vOvHrQmm5wd1v3nwYUz3PEAxrJ92kFYBJTtlTqSNXJEysNcCdM/c
	t/440VRuFjJZTcQE2XICM/aMGh9MG0imBrSduxOvZkzeUcMxADGtXHSgDy1QL061
	WH1zfiUfio9WyrU6XQtCUQoLWut0k9YcTOhNjVk40Q==
X-ME-Sender: <xms:GwQVaa8DyuiEPADzMiSyL5nzvEUbJ04a7P8S85GRa2JMbzpvn1Cz2g>
    <xme:GwQVaQtrOp0JrZGapdV0WIb3vMK43-uEL94PaAYS_ienPO6q7vSl7eexgNeddNHOv
    IkbBTvonWaEquEeijn_xXn80qfU3sQi4LGQGc7DWJ54aiTEM-4ZywM>
X-ME-Received: <xmr:GwQVadpreNoNn3TkOYj44XuMdMfrXMmHbYVtxftuxVP2FE_zv0Xv3NlgYhUxiQcYkZbUbRcUIOlTwfc60O78LMV-OQ1T8E_W88tf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:GwQVadkQ_tZKsF6bF8z6SXkOfboEOngilmfZ28jrIYKe_8iNNKzQWg>
    <xmx:GwQVaRygIm0hxxFco8Jvahw87Wcoo56JG3iWhCgODUJioXrnYRc9hQ>
    <xmx:GwQVaVk__xKZXjnXkYdaq7DpZzLe_2qbnLpQCu8zeZnuZflLsl4nDg>
    <xmx:GwQVaaehONm3FAGEJbpWbAgFtj8fJaPrGkZeXHF_l1LYH0FBMYkoAw>
    <xmx:GwQVaWWVbTv0L6Aiu27waY6vRfjIbWuMM23WkUe4UbOKWMCzOfBaNAQY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 04/12] diff: keep track of the type of the last line seen
Date: Wed, 12 Nov 2025 14:02:50 -0800
Message-ID: <20251112220258.1009253-5-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "\ No newline at the end of the file" can come after any of the
"-" (deleted preimage line), " " (unchanged line), or "+" (added
postimage line).  In later steps in this series, we will start
treating a change that makes a file to end in an incomplete line
as a whitespace error, and we would need to know what the previous
line was when we react to "\ No newline" in the diff output.  If
the previous line was a context (i.e., unchanged) line, the file
lacked the final newline before the change, and the change did not
touch that line and left it still incomplete, so we do not want to
warn in such a case.

Teach fn_out_consume() function to keep track of what the previous
line was, and prepare an otherwise empty switch statement to let us
react differently to "\ No newline" based on that.

Note that there is an existing curiosity (read: likely to be a bug)
in the code that increments line number in the preimage file every
time it sees a line with "\ No newline" on it, regardless of what
the previous line was.  I left it as-is, because it does not affect
the main theme of this series, and more importantly, I do not think
it matters, as these numbers are used only to compare them with
blank_at_eof_in_{pre,post}image to issue a warning when we see more
empty line was added at the end, but by definition, after we see
"\ No newline at the end of the file" for an added line, we will not
see an added line for the file.

An independent audit to ensure that this curious increment can be
safely removed would make a good #leftoverbits clean-up (we may even
find some code that decrements this counter or over-increments the
other quantity this counter is compared with that compensates the
effect of this curious increment that hides a bug, in which case we
may also need to remove them).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/diff.c b/diff.c
index b9ef8550cc..ff8fc91f88 100644
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
@@ -2426,6 +2427,15 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 		break;
 	case '\\':
 		/* incomplete line at the end */
+		switch (ecbdata->last_line_kind) {
+		case '+':
+		case '-':
+		case ' ':
+			break;
+		default:
+			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
+			    ecbdata->last_line_kind);
+		}
 		ecbdata->lno_in_preimage++;
 		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 				 line, len, 0);
@@ -2433,6 +2443,7 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 	default:
 		BUG("fn_out_consume: unknown line '%s'", line);
 	}
+	ecbdata->last_line_kind = line[0];
 	return 0;
 }
 
-- 
2.52.0-rc2-441-g030905368a

