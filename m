Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA1280331
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203997; cv=none; b=jbxx3Cq0KgdzJHS8ZhS/aGtu2hIX3JHTXlqymV++jWy8wRGLaMerz6M1Bb7jRlhzGMOFXDSP0WgGgFvpeee2OFAGiHDkhlzErbYNGYk6ZgbPPUJ8wxRkb+ghHCyVl8sqPQlVNsvRxD+s+gpqXg9r3rtDddC5F4DQHtrNvckOWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203997; c=relaxed/simple;
	bh=9MeE9QMjmgYffSOw6pGuxsoBM86qpEPWlOSxrrvKDgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVrTka/TgeBpgrneny43rTHVjyJmpZDeL0xotXPpiz/o5k6qlBkle6hliG+0Sor/Mz3ML/i99lFcv68X5e8JGBiiZYrjRNkQtiFQeg/m54HWK/e0FJDV8IQ22rNWLSFa28LBinllYOv8W0WDKCNksapaDwpGuM6F0OqPLtw7nuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SbNLNLcX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8FZ+mLb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SbNLNLcX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8FZ+mLb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CF82BEC1275;
	Sun,  3 Aug 2025 02:53:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 03 Aug 2025 02:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203994; x=
	1754290394; bh=TmY4zCPqFWPF6w/lfwbXDjzuIfNy0mv9Loc636Q8CMc=; b=S
	bNLNLcXk46oD4qu0WZWSg+SvhDPabl/b3uwB7NXP2iXi8s7iML/xidzE7jSc2vr+
	fJKivznrlHCv007LpbEQUC1+O8ynuKQ8BtpwwJnjmLOftmlYx74yGcXkXDPRqyEa
	ybeUp1RSNNjKU39lF7d+alNQbx1H+0abv4JK/xAI7i1G1lDVq9AKtMmQKYzJjPRu
	xiOijQhk57P61q646RIpjhJ+ePr5bjt77LiGvBzQjTEFOVP2Cachiu8yGUriDqLQ
	KuGcCkDA6UUJHIDPhFWWjARiRNMLhszuWykwba0VxtypyYIQC1eJxH9volOw08u+
	n2174FSY1kEUrUhX/B4ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203994; x=1754290394; bh=TmY4zCPqFWPF6w/lfwbXDjzuIfNy
	0mv9Loc636Q8CMc=; b=E8FZ+mLbMtagu5+908GnIlHpaMdyCTMysQqpF1BzJ2WH
	FtL6IzIZq975WyAbSwRqyQKuPoG+ewLGMcV4N9os4ZHzJxfjC89T95aabqVvLKJk
	DWo5hltvRmvVfjPSKz7q855LknOLgLQC2YbX7vqGnKW3HJ/kZSEokw0qPsppfOjp
	qlUty+4P06XyCV4iy8ISKIle25gX7o3Hwm5WZqovNVugPodESvJg7UtHlgmqSgCi
	LJRtuNzEZYHRSOnni5PQw350ShwIVAD3Ruhx1oUE/lAX6xG0CfPtMdQYGlXBc86Y
	fmyMbcCS167ukcISQzv1LVwPdQYoi+adarQyy18htw==
X-ME-Sender: <xms:WgePaI_hjzWqUwGIkO2P_ipCin3_m0ln9LCueMr27NxwM0jp7XSaWg>
    <xme:WgePaA56BjmFDcnFw5I3-bma0qZzJf_w6Ci5nbfkypfVZwAI_EUvmwgVBeFidv1Pi
    EW9dW_ZY8TuK6hs8w>
X-ME-Received: <xmr:WgePaP3ULOqnE4Pk4b5q1qYcJSYv9Cpz0JVbslJrCRBJJyp_uWtLyDYcq91qIRi71gHKjcqwzCSserLDWo0sKrHaeFZQgcZYe10VUII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:WgePaHB7dKU8QzWOod5v3uUcohk4Khpm6o0KueCEZ4xpnQSCXHTwXA>
    <xmx:WgePaB0aV6I4R5OHwSCz2eQtMq7kMY_-wAnBPy8VB0BIWbmt3IyOIQ>
    <xmx:WgePaBvf3HRpenj40QX6XNnaLUxehM-K9okIyBrDhuABrdI4TfXl5g>
    <xmx:WgePaB44M_skm3_BMjHWUO-XqlUTGTSEf0CTwTwN6_I6V35lX5etwA>
    <xmx:WgePaLjQM_CFElj-V9RifOuIh7mz-0UHpFVoERBLtDypU_Tnr9A0tSIo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 07/12] notes: do not use strbuf_split*()
Date: Sat,  2 Aug 2025 23:52:59 -0700
Message-ID: <20250803065304.3325286-8-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065304.3325286-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065304.3325286-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading copy instructions from the standard input, the program
reads a line, splits it into tokens at whitespace, and trims each of
the tokens before using.  We no longer need to use strbuf just to be
able to trim, as string_list_split*() family now can trim while
splitting a string.

Retire the use of strbuf_split() from this code path.

Note that this loop is a bit sloppy in that it ensures at least
there are two tokens on each line, but ignores if there are extra
tokens on the line.  Tightening it is outside the scope of this
series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index a9529b1696..4fb36a743c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -375,18 +375,19 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		struct object_id from_obj, to_obj;
-		struct strbuf **split;
+		struct string_list split = STRING_LIST_INIT_NODUP;
 		int err;
 
-		split = strbuf_split(&buf, ' ');
-		if (!split[0] || !split[1])
+		string_list_split_in_place_f(&split, buf.buf, " ", -1,
+					     STRING_LIST_SPLIT_TRIM);
+		if (split.nr < 2)
 			die(_("malformed input line: '%s'."), buf.buf);
-		strbuf_rtrim(split[0]);
-		strbuf_rtrim(split[1]);
-		if (repo_get_oid(the_repository, split[0]->buf, &from_obj))
-			die(_("failed to resolve '%s' as a valid ref."), split[0]->buf);
-		if (repo_get_oid(the_repository, split[1]->buf, &to_obj))
-			die(_("failed to resolve '%s' as a valid ref."), split[1]->buf);
+		if (repo_get_oid(the_repository, split.items[0].string, &from_obj))
+			die(_("failed to resolve '%s' as a valid ref."),
+			    split.items[0].string);
+		if (repo_get_oid(the_repository, split.items[1].string, &to_obj))
+			die(_("failed to resolve '%s' as a valid ref."),
+			    split.items[1].string);
 
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, &from_obj, &to_obj);
@@ -396,11 +397,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 		if (err) {
 			error(_("failed to copy notes from '%s' to '%s'"),
-			      split[0]->buf, split[1]->buf);
+			      split.items[0].string, split.items[1].string);
 			ret = 1;
 		}
 
-		strbuf_list_free(split);
+		string_list_clear(&split, 0);
 	}
 
 	if (!rewrite_cmd) {
-- 
2.50.1-633-g69dfdd50af

