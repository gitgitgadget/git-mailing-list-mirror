Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F02E6116
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775468205; cv=none; b=FIHY0NmcdechcgfFa5hZEGGDkExitoJR4KhNczz9UzEKhx/mmmnexIgXKnA0rSldY0e8aYD8BnnK7GjGr/+tal+6uf+BHtMgk4rqRN2NP8s7zBKuogtMv57zjuyT5RJv7MmlIzi8ZqswcI4igA5ZeJT/VtOF9MfN31knpSKFKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775468205; c=relaxed/simple;
	bh=4P5hz3c2feQlTYeTDtqRbLy+xQ1tznBj1fFjQyEhFJQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nuxtQ/WquxGNuOekUKXa786iXQi7JBXyySmEmGECSQSbMkvERBm/xAOc087N+iZ+gpenUiq6rl5pGFkqqvPrTCwXKJ1K/zQOiP0jVEF64SF933YIa0RgwaNfbTPlLPIay2tvlGQUh/jkJzNdWa6mY1uphhlhOzt9bqJsKWnQwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gDPE4mBS; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gDPE4mBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775468201; x=1776073001; i=l.s.r@web.de;
	bh=mqtkwGins4xl+sZKZPCNE8RR1aM7xveJ+aaZJTdUoJw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gDPE4mBS3YbIAQ7rsi9J5J7vwMOTM+ThQjPNzxoEQaMAJXpYn052A7BMWZ0tY/pg
	 Fz/yltFA3pX2XQqpT1l+C2IHDAgvLcYLx3P18kdJF8VG+btseIvw2+nibcof3OIcJ
	 kZcEial07u1MWKlaPGCho4twOfeqWXEH4gvIIju/Pfe5sdunx62bjjjpPPeVfPjSQ
	 cokGjS77ed1hN7MnK9c5pF7XxdOOIfwHzUiUJUzf3Iyg5qQjSjYGir7FwoZQZVfgl
	 Yue08uvq1+P5tqcrB3eB2e1/fEditCFBYYO3b8iOypAVHIFqEyTIGezwOcIwus6ef
	 hGbsXkTl60ava+EmMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxQV-1wDCnq3QWZ-00BYzK; Mon, 06
 Apr 2026 11:31:21 +0200
Message-ID: <ff6a940c-39fc-4dbf-a164-7770c7f26a31@web.de>
Date: Mon, 6 Apr 2026 11:31:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] history: fix short help for argument of --update-refs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nCDZf2THx94oRpHSR6rTt4/j92pnifSCzRopVpx5+qSWDk1GoBG
 ese88MGwGDirgotk9olYhy+SNXcoNsChNH9VcgvtkF8HF9JVxsH7tnyU++irIyW7ygCavB8
 YpLp/4EkKykqBL+gI4/jsIXAXn7clvkVWr8+OscP3sqGa1DjYLwutCQKSkw5fBxJBOu1EAI
 G6wn1+FJXwJIs/y5o4imA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zPcFp2rOPrk=;RAIxnQAe+myphZ26/Vs86j4eoGp
 +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

"print" is not a valid argument for --update-refs.  List both valid
alternatives literally in the argh string, consistent with documentation
and usage string.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
git history is a new command in the coming release.

 builtin/history.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 568dc75ee7..9526938085 100644
=2D-- a/builtin/history.c
+++ b/builtin/history.c
@@ -437,8 +437,8 @@ static int cmd_history_reword(int argc,
 	enum ref_action action =3D REF_ACTION_DEFAULT;
 	int dry_run =3D 0;
 	struct option options[] =3D {
-		OPT_CALLBACK_F(0, "update-refs", &action, N_("<action>"),
-			       N_("control which refs should be updated (branches|head)"),
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
@@ -666,8 +666,8 @@ static int cmd_history_split(int argc,
 	enum ref_action action =3D REF_ACTION_DEFAULT;
 	int dry_run =3D 0;
 	struct option options[] =3D {
-		OPT_CALLBACK_F(0, "update-refs", &action, N_("<refs>"),
-			       N_("control ref update behavior (branches|head|print)"),
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control ref update behavior"),
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
=2D-=20
2.53.0
