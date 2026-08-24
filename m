Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922612E1722
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603783; cv=none; b=rE+JfaXSWWs6t1PSRYJt4Cl10m1B+bgb5Lh/+uM2xQaJFYM3qtGs9Nuf3WLQ0IXDeEUGv+ejXTdXQpl+TCQqauOvX88XIdtZRHDxMHu2B4z42AhcA+r+31X6kFvM1/QXwgaxv6wuIREyoOPhtnrCv+65YGnshe/xO1cEtgbcFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603783; c=relaxed/simple;
	bh=/LKyQ5BoH5IIfzObZPgrnGj85RSUAgw7RtKWk+183wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOec45H7xwdY8NXRzX9aGCLOuoe1bPi2sLnqHL0+hANsV4gf0WnS3tPMnRr2mQolkJbamnjoMUZhG7gPFlD1CkXEgu8tg2FkfUKC4rU1xYacld6h99ightmPTu/kFMCWDbsl+pRO9xMqFuLVBhpVD76VzDnFKywqjuaXiVv7FTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fZSXP7E2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZ2BRPzr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fZSXP7E2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZ2BRPzr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E3F1A1D000F4;
	Mon, 24 Aug 2026 16:36:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 16:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787603780;
	 x=1787690180; bh=r4bnmhmzWe5TC3KN2vQld/+yQlSNrrsbdhQkMOaOCRw=; b=
	fZSXP7E2s54egDK7dP+k9jPBki3J83BDzK4CnYa535ARwBsAOdg5jFs3Mfc4Y774
	8kH+fZC+1ISME/KUBRdy0gCeo7nwv5NbHt/LD1POu88oW8iT3RjmzVJ5udRma76z
	FZrJWMJXIAn5gRTtYmjOFjNzqabTi3ZZ7LW+xuvffoZLCNPbkOpwuTY+ypU/14ZD
	qWowA8A9V9SeJsNTLPaAVHWa6GzSmwEBotY7sFLA/5XSNGDwK6BezkdRoBsGu71C
	7xVHjaEKRmtMLDW+34SAREUnyaHOvCAwMYs+Nk6LZ39tXBPhLR68RsXuqKGNb5NW
	p0CAsWQPmzt1YgAqzbPqoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787603780; x=
	1787690180; bh=r4bnmhmzWe5TC3KN2vQld/+yQlSNrrsbdhQkMOaOCRw=; b=N
	Z2BRPzrq5t1MPGe+3eHx3JjwY6jhn4v74+6x9MD2/Jhh8GLgYPoAtN0uof/BlfTc
	IQkSmNy7xHDpuH9LUyc15D5yzeWfNAZ7/4HtLFi7MaOt5AYnVA2W9lJeDquX6uUI
	udk1/rpoqMBw+UoBCIF/7muwCVwtSd1QyrD2rQreqzfER3iX9NsSo3VJRifnrdyP
	1t6pF2V+j0C2wmCTYrYZRsjcTeiXJPJT9Lo7RKh57aEH3AesC6VH82tYMECWj20I
	BnLR321FLzNGl7K2wCnlcFJZjoyQnhsKFr94dhkFjkKlDQ5N9tGw8gws1RisQ3GA
	EN65CBctQz2rw0LFfp3vQ==
X-ME-Sender: <xms:RKuMar4WUjbFbNf4-4W_N8ZWxpEo3syZyrvKPaf0Pfv46UDrxfg6t3s>
    <xme:RKuMam4CHnXtRi4GI9bj7qDqDjys3CE5up-oKRlI3Nl5K1x8SvlsN20Ok6BEG_LDz
    rhLQz8x5v7wLSkyUjgc_Ds7dB7XvTNdwff0BhgSkZbRV6h2KRyjKg>
X-ME-Received: <xmr:RKuMagHTpql8-L1vQeuUVKr5JXQAt2o6IX1Zkmq9orG5i19aiSAC1Q98aZOv2AoLQQUzPGUmgULLar8uWlMTCLZU2gTXEw4OWufzvG2QuqCGCj3c_5gKNWf2LQ>
X-ME-Proxy-Cause: dmFkZTGRZzEnvCfEZu240d+XEIRXsnp2hsMHLk6EvQxqR52dEdmFvb9o6/2oKvbK7qAHRO
    Whk7JexquvsDl7NTRqYRloNS9or4hL4+bpZzvQVs6FX/ohUNkj5OxDFfpJriTGD5d+rEyJ
    +cK0Y//vXkXpBciTU0dj2Smtb/f175E/l/QJOW5epGcCEQFVkz8//KHhHxOuYJFUo1TFvU
    cVm5cHP2zPlRi/mrYWbFgX+Zfm9reikcyMZ5uQL16iXrk6G0dX6cbpe/4B2qfhsE1DsLL5
    KDkAobBLPO+oJHv0czehyMyFNXiU2e7ERJcx8u9GVr/dFU7FEXe0PX1544auD1qLpcdteF
    P5Te1mTyt0Or1JUAu2xddfHug8oJkBEhleeoQYGa8VjoVFGLRTW3NEGWYFExjYyIIDULxG
    xzVJH3kYYvL+K64jjBfDnwX598wRh5Lp7XLUeScZLnEyJaj9dtubb+advsooCrjtt0I63x
    EsPe+qQdYh7wwjpmY9wDDuFE7gvuYmPHO/BiydCDaIG4jIavkTNH/G05sEXMmY45RZ7E8P
    X/JOBbPrrjbnJOFmIyJniGe9y1FxjOxlZuQmXjpYjFEKsy1kG4F0URm8CaQZ+ZvbPcTxQq
    5740NNGi417AT8Rkfl63vBk6483H3ksmlbWra8eKq5pKQCaoFWeINBHEJ9Kg
X-ME-Proxy: <xmx:RKuManQGYagzkw017prBkq5BR_IotMidoac6U-XRKydUizp6O4U6Jw>
    <xmx:RKuMaht10lFkLtzjrPmmuz0E73fr4K9_Mpz0bkSLP2kj0TlTHiVnWw>
    <xmx:RKuMauwJTujhgulJs7zCUvpzwLLlSEl3Dw22G9Vs34qeztF5P-opGA>
    <xmx:RKuMaj70SK-V2C51FYnUVeojJ7UohzL-dwSYEfV4vbZkOmUXyO74nA>
    <xmx:RKuMavRbX2maiaVl6NRapJuwDGgiQJGQjmdNkPNQPWulw2wBNqb1V0D_>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 16:36:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/3] format-patch: simplify get_notes_arg parameters
Date: Mon, 24 Aug 2026 22:35:42 +0200
Message-ID: <simplify_params.c58@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
`rdiff_log_arg` to `struct rev_info`. I changed `get_notes_arg` by
simply replacing the first argument with an access on this struct
member. But the second argument was already `struct rev_info`. So I
should have just simplified to *only* passing that parameter. Let’s do
that now.

Now is also a good time to format this `for_each...` line since it’s
gotten quite long.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (testing):
    just compile tested

 builtin/log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 350b35c5563..560af00e2fd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1333,16 +1333,18 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
 	return 0;
 }
 
-static void get_notes_args(struct strvec *arg, struct rev_info *rev)
+static void get_notes_args(struct rev_info *rev)
 {
 	if (!rev->show_notes) {
-		strvec_push(arg, "--no-notes");
+		strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		strvec_push(arg, "--notes");
+		strvec_push(&rev->rdiff_log_arg, "--notes");
 	} else {
-		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+		for_each_string_list(&rev->notes_opt.extra_notes_refs,
+				     get_notes_refs,
+				     &rev->rdiff_log_arg);
 	}
 }
 
@@ -2404,7 +2406,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&(rev.rdiff_log_arg), &rev);
+		get_notes_args(&rev);
 	}
 
 	/*
-- 
2.55.0.13.g85d2d65e389

