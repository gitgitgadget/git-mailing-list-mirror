Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96742BE02C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974499; cv=none; b=cRv7arggmBQHaIZxRGMknP26OzEJ88vAunDfyXkfy7FsZFq8MrWEybvYUZu2Scdl/ZffGtUOPE/TxG3DMpjyJPWDjKY2bQwNQM7aQbagzqPbcKPYbbFIMulEIA5N6FD6/nFDHAt5ZPpAxVyH+y608sN2jvpgUrX00QvfEt2U/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974499; c=relaxed/simple;
	bh=k638VykDQLGAcmf5qcDw/8/eZCcNtW8VR7Zo8y7M6RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hzkTtSTIEI9nR0PqyS9mFZUyzz+NO/LfKg65QjaxIZ8316bSya4zzh3eeZvEeedmZTH8K7Xwu4s9OEOhFccvN4p15lk8+UdtG4tgPvLzG7qV5X3j46a+O62xMaFQtAncztsdtk78gUBruKR5xT46+XXJ/S+8Iu2hgejDdM280k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e6xpz7a5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kd8jLKrE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e6xpz7a5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kd8jLKrE"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 923E37A010D;
	Mon, 13 Jul 2026 16:28:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jul 2026 16:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783974496; x=1784060896; bh=jBzz6HW8bQ
	HbR1L6URaStppjb+TTitndckKFjtkb0NY=; b=e6xpz7a57GhI/t+C4D9hOS0hIa
	P1C9mqW33X3kU4QhewApn9VJB9kv6Mw6GS3UxfkL7qHSE9+uVT6+Bh6c7FeX/egg
	ROwCOkq3TVJ+RYtO5uzolVAvJStjUN0PORxFDIabnJeG6vumuoUAIuEbDViMbNx8
	CSN/MD9Jo3EWYEOjp20s7VJuTW4PYFHAelNb1tmZ2f1CFHaGlmnExi7wLAP2zuq0
	7m4y4qKIhU9ZGsE5oy8vhR1eKy+ZTpfe3gI/vveieEdZy9yFLYF/Q//pGZ1WK1jn
	+hit9jXo4WXWYKS4i5HjlxmttsMSXqYyrup6IJL9238in+o+I0pnT+5Td6SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783974496; x=1784060896; bh=jBzz6HW8bQHbR1L6URaStppjb+TTitndckK
	Fjtkb0NY=; b=Kd8jLKrEOQ80+2LXMsx+cWZi2v6M+kOPCucVUT4kLx8r2FL2VU+
	x5yS+koA29ST1Eh1bAA1x41GXns4W4lr1ggblUqu/JVUkYK6m62h5QtgqQQd+Esc
	KuBrB6AMCa1FRlYbRBLFBRpFfvQ27CJCOeYaWmd2IGOqB+cKV/3BCLTOdRwhG1ID
	qBkJEmhB6JwqLSO1PsIZwS0yUHKydYtzKbBqpwyCSQg5aMqQTQSI6W4WywNN8niR
	/2Q5wL5U9p9YkVrDuPAOlc+MWmXOE9P7jGRmeCiCA1/rvflxihWqM4+WjoXC2RRp
	HVqgq6FGUH29ZUOuAhT4/Zpt54QeYV8zW1w==
X-ME-Sender: <xms:X0pVatJKMDP-qz5KOKxJ29N5q4a7o9n5QwzGA22C0w9-CksF7WvUWQ>
    <xme:X0pVavomzqnoF2_rN0KqSY5tkTyGLmaGiGkTd3wf104AvxcR0evNjQZo2Y0yLkF9Q
    JXlywh2_NMLpiLtJXJD4lVxL1CQZqGTM6Lgk1iz_utNMYPATCb9MQ>
X-ME-Received: <xmr:X0pVajs_Ldcj4npiWG9otUGLefdMvGxUxwz-ZxgnzeglUR_cibTIkNzeIHamxOctIOnLmW744CwSfgyl2zfGOfZaPVtOqMhwrKiWN-Y>
X-ME-Proxy-Cause: dmFkZTEcHcWa+DZLdkHqQo+0padWSyE2MEFZoPK1Dfym0Z+quRQHo1S2mlwSEdzFEPl3qY
    Yjx/r0pnQ0PbXJSrx3WzIoPyEaG499JVYTsFT5y6AYC9du2mcxK5KgfdhxzGMlbbE9E04l
    oCxJiGxJB8rQv5fKV9LT3dhXe3bXS3Alviq9UMBJTOn5r04xXaRk8MzL/awuwNGRPj/XPM
    fB0svncwpp3UyqZ2GgoUYucuk7ilgonBuDbt2Xo70UxczpgC4F4QeHtan57yHAYnid0Yu2
    Z7hgSRugEYkgLdIw6yrNKnBAhp7TNpJBa7TLPJ80THkbGSPGK1mVRfY327Q2laDcBKyFOi
    P1c4xrk8+5/oXsOpWdJ9BBkGF0MWDlHblYwPSknRx9s1sH4CWbWLU/xO8lOK/MZRpwYoMR
    uNz5GmVxqv7d3GLLt5J91tV2Na9OV1kydTlbXSz269nv/n15PFdBr70bAM063ufWEsuCKb
    AyXjTuaoPMPpqF/1mWxxvp3998PCsNotK0tJBMlgS6QRGxvLodeOp2HQ0jlki9WI5aGDRo
    usH17quON35qPuCILlC5UEFGI7GVhB3B481Zm6qIJTeAaMsjHTrTktxmxYI5zkl7RLmibv
    Hku7qRNY5xaZfQ6h68oYt2vwu9abqK9J4RspSrWvwxwgrIe1h9KkVfnTA9FA
X-ME-Proxy: <xmx:X0pVahI6IcepZ4tbQKEZrw_lpf2zEtIOsrBBBzA5QUH3vzjD8B4ejQ>
    <xmx:X0pVaqrI10Eoz13TCybLyGml2ZlQUdC7d38oQ5-SOUpMknEoAw2bTA>
    <xmx:X0pVasUfp-39HVFRhTwUU50L_1QPktczrkcrx7V0nnOdmF_SHGCnrg>
    <xmx:X0pVan3Sxj2bG9hAOPkEQNyPt1FHDMrpIrxFUchvcXponjZ4wezuZA>
    <xmx:YEpVagAJiVUp4Q1ylTj_ioYcX_YmI4EWraLErTiwB__eRihiVc0e3P8d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 16:28:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  ayu.chandekar@gmail.com,
  chandrapratap3519@gmail.com,  christian.couder@gmail.com,
  jltobler@gmail.com,  karthik.188@gmail.com,  krka@spotify.com,
  mroik@delayed.space,  peff@peff.net,  phillip.wood@dunelm.org.uk,
  siddharthasthana31@gmail.com
Subject: Re: [PATCH v11 0/7] graph: indent visual roots in graph
In-Reply-To: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
	(Pablo Sabater's message of "Mon, 13 Jul 2026 18:43:57 +0200")
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
	<20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
Date: Mon, 13 Jul 2026 13:28:14 -0700
Message-ID: <xmqqy0fews69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> V9 DIFF:
>
> - Changed boolean variables to be bit fields.

v11???

>
> 7:  737331b68d ! 7:  c1fa81022e graph: add --[no-]graph-indent and log.graphIndent
>     @@ revision.h: struct rev_info {
>       	/* Display history graph */
>       	struct git_graph *graph;
>       	int graph_max_lanes;
>     -+	int no_graph_indent;
>     -+	unsigned int graph_indent_set;
>     ++	unsigned int no_graph_indent:1;
>     ++	unsigned int graph_indent_set:1;

OK.  References to these occur primarily in a boolean context, and
all assignments to them are either 0 or 1.

graph.c:442:		revs->no_graph_indent = !val;
graph.c:1008:	       !graph->revs->no_graph_indent;
graph.c:1353:			if (graph->is_visual_root && !graph->revs->no_graph_indent) {
revision.c:2630:		revs->no_graph_indent = 0;
revision.c:2631:		revs->graph_indent_set = 1;
revision.c:2633:		revs->no_graph_indent = 1;
revision.c:2634:		revs->graph_indent_set = 1;
revision.c:3209:	if (revs->graph_indent_set > 0 && !revs->graph)

You may want to rewrite the last conditional check to:

	if (revs->graph_indent_set && !revs->graph)

This avoids confusing readers into thinking the member can be set
to 2 or greater.

Thanks.
