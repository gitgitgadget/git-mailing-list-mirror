Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3F2773E9
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378265; cv=none; b=o/mgF33an55jiLpwU0K3KelYbESx5en01XWkvuCdhyblw6y/iFtU4mJiAj7qfquFc9FwM4Cc5VvpXtP02ksgYrjVUjKHHv8p2RAgldE2bVMG+BRvESBNRTe7bHJH69TA/mDq62cYKkKM32B7SJG+X1OUjZfR9hx7By0weiYVumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378265; c=relaxed/simple;
	bh=n85yqI/NNUYtbae6/dqY1XWk14+3zpN/PbBeB5kdK0s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCbDBpoj5JncSAHuKJUeBsRwzxJNAlA2XU5K5yTx6xBYImVhnCuUm7l9GL2GUcXyoRLcTzKNrALxzPlNcmgEv8Gky8TK8jkVZBvyWLWyMPttKQd5NBjEK2kVxZfAP+YhEKecY1zLrk4b4c4ATYo9RXpzjyF/AKoLCwy+PKov2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eiq5BH02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGQumJDp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eiq5BH02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGQumJDp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 542FB7A021D;
	Wed,  5 Nov 2025 16:31:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 16:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378261; x=
	1762464661; bh=LlmdnHlkAL1hovQUQhdYj5rTWEC23Tokeo9ppUFiTqo=; b=E
	iq5BH02l/Ci6mqtIMKbOj0waZ/LJwnK06WvOaiMPHbz8NljXBCOVk8CFkCiHz70W
	csMt3cSL149WpVm4F9m204CwDONlzEaw+yerj+Qrb/2S7swqhI+EVJ8zfjvO+oGS
	lvzuDZ4Up+K1Z7OIKEzRT4RpHweELe9PxHK1oovNq9U9tdI9PXIodMfvVxdEkM4j
	X3tKg4VaNaCA2NpAAXpCDV9joCdOUUSqaoE2yJjysef3SoGWWeJtSrZhv8xswxvf
	hXwmJcZqHVGoSkrM+VWPNYp857iNAP1gkQgK+SP76/V9Zym+EGZZ0g/vHpO9QnoQ
	bCHJRXOWHM4XDrRiKb3fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378261; x=1762464661; bh=LlmdnHlkAL1hovQUQhdYj5rTWEC2
	3Tokeo9ppUFiTqo=; b=lGQumJDp7JUr3mGquE8N7Kp6yrZYctKvoSqTdkZabnw7
	ovtfjql+yZ/6FKOGjJKsOXQLlxX7ohToBr1mOiwtCx5b1e74zefTaYgp6/jd6ZNu
	C3CK6ZxsInmUuxSqxRHjJU6O20jmjdiPQNhsJ7hV1TGSelyRFZLnOCV//b5JTQAM
	XuMhjWsSdkC/9BZIMuWrbcOK3jJkTA/7cTkOwPMdan5IMzF+DR8QYzDU3N3QxvRz
	nRFET53PSi4NHgndjVblJQLBiAbx/MVIXL6xu4esTTOk4MA/jaFwj3Dz6rg723jr
	Gjgfk4bjEGlg7Za8QBZ7KM0C/aYTn0dSaCoZSlWo0w==
X-ME-Sender: <xms:FMILaYJfZ3j5E4J4eABESvBQ1AFWR27e074tkKEcUr1INOu9dfe6ag>
    <xme:FMILaeIVPsTDDDa30B9hKIkGR72c7gc4YAjveZ81mXxZmMyL84jyqoLTeHRBqccBY
    i-uOyfY3XBsDg_kFtaMo8YzkbTw0fzjBWbtq0nLHpgJaJpg0QZ-M1w>
X-ME-Received: <xmr:FMILaWVTubIuwxTNXkFRBS2OKivuWnOIsoeSZgDmVubjQ_X1iWelSkLMA4BcLRiFvVlh7w4FaYtrSFQ0kjBDYDquO9lG0IvTDeeu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:FMILaQiJyzhB618pInizcS08uCCiT3yP1eX2KPPf_aQCdvrl69nkIQ>
    <xmx:FcILaR8G7Tj9EMfaCTvqdR0KY-oabhpUrtYHZhnaip8gGQ68WKntfw>
    <xmx:FcILaaBgl1SHYP0mRHeNg4uKszMMDhVoeeG3DwYGf8XbbgYED7vk4g>
    <xmx:FcILaeKWWLQjc9Zvcr8h3MCL-XqpZMBOZUW5d70p-ckWmHosLmptlQ>
    <xmx:FcILabhWPGWl6gaSJbe1L49oRAbMMHryjPUBJsStgjb5596Npybz3yBJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 04/12] diff: fix incorrect counting of line numbers
Date: Wed,  5 Nov 2025 13:30:44 -0800
Message-ID: <20251105213052.1499224-5-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0-105-gc08128fbb6
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
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
2.52.0-rc0-105-gc08128fbb6

