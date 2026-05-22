Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69012BF3F4
	for <git@vger.kernel.org>; Fri, 22 May 2026 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427748; cv=none; b=GZV3KuzjygsZ6K9y8VRxpEd0V0Xlg0ar4xHq8GNS0PTwW64O/ezCOol5I4wLnT9LfAEDiGKKqks8PFdDMHJxGhvSbBBFe7OrMM9liM2oCXs53KiupCjLuY7gDlt4Q09Wz/IC5t97L9uYOZgPNJKps74WZq/Kqvu55yLtO2vXJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427748; c=relaxed/simple;
	bh=5UK6EFlgSwepeey934Abz4F2vIMNIqpivpFdYh5AW/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IXhlZo2wywGFwgmSlTxAgguMUvsTi/+nQPtGeKOO9FDupm8emyXZngAeHpTxpNC8QV1UPkr+sBu64foL544BRq+DDbUm5DtikuajIy1LKNDh4FpIrD5TNuT7kdTlN0cKnpRGdwNDzVJmVvkreeyh6VcnXBJchXpD4vqyB9kie/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vXbeZqsy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYoV3KrW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vXbeZqsy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYoV3KrW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CA7E31D000E0;
	Fri, 22 May 2026 01:29:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 01:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779427744; x=1779514144; bh=398GDwyopH
	NGQy624dVqgUNlfprXgjo+f7PN0B5qU0Y=; b=vXbeZqsyvMa3FKOF/v1ZeyhKTg
	o8QsaaugPOA9sZ1QzoAUWEyqKRKget9xOISAUEkREUd+OlKL5IHVjxKWkJx+iR7j
	2ewCS1UxTHuJ0r3y5ef/iGbN1SWwQx3wIW4tQnOxL2Aigl9UayaUjJGe+dMcjqlB
	e9iCB0RcnXpVrfEU3ypxqHH2IABNqGbjcU6LcdXKYKMbfXuTiuLibhAXAn2HK9iw
	dkTLjrqeFokaWg5iOquQO+VgEMdwTRohn4AiWULQLML53kJHAZE5Tv0/T+J+JmWi
	0BUjw4ePA/4j/bXUAaKc0sDqcjVDChVtAfVJyaOAyZeyBpYlTgS63L8Gkbnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779427744; x=1779514144; bh=398GDwyopHNGQy624dVqgUNlfprXgjo+f7P
	N0B5qU0Y=; b=XYoV3KrW5fFbAkmJzmA5H1azeZbjn56T7cfNUCN8cyH7TgThrR7
	nupsw9LNvUh9eFE+labMX3knB6sSh/EUZpSi1wxWsAzxgNFSPc+kGqGV0sZH5Fb2
	8JLn7UglfDRQVbDvWfIwNRTw6H3dbSIrXCrlePbTKF2qSBmIzXSzJbE1MfvqePWJ
	To3GnweQocKoAUkOZk1L/Gp26V0nYzihCEt/d7h+a1POGYhdz5i1Pj0LA1aP0B/5
	Gd0YOg50fNeKy3xCKJ84FAzp9nuj7efIl3eVXRHFb4h+Oc3IKk2wXkJyLgfYHJtE
	B/LlOajzRD1Ux5n4iFHQ0AtdGZ1U78AmOmQ==
X-ME-Sender: <xms:oOkPatKgoLYNbI6hn3YUyKJ5RPtJGrfzScc6RPcA89pC2XIniizzRA>
    <xme:oOkPagLmp9PSDo-kE_GGcbMihH4v-wnRBynxJ85m-cii3kc5rOo91B8N3SogiSEB3
    kVRETguozmC1AAX1hZAnKurGg8A4XpJlXMUUAcExURaimd_JvzZ>
X-ME-Received: <xmr:oOkPaqvI5Cp07LKZUecn6EW22ODMogoeUGEpzO-X_dHgAoaGUqkL2AZ939A4nOS60pmTWL5SvIauiCHGrSwTBwL-g1FBk8X5aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:oOkPatQgd_A1FNThG3fy4c2Aeo1_anUoUzB2bL-5Juaq-ixnpdhcAA>
    <xmx:oOkPagOo6DLPZSOytQvcE5Oj-M61oT627js_tNW__8-bv4x11xKWLw>
    <xmx:oOkPaiaJXH_OFmmEgfjTuOf67LkQM_s1jdOcW8md2UH3ygAQnF4e0A>
    <xmx:oOkPaqyckUj-NJqpn56tPKwO7FWnyYEa-qK7Ok-tnOd4UwwXnMOwMQ>
    <xmx:oOkPaqNSjp5QYerxKg0m3AMxCqciLP9BIZz7E65szXyl0IPLo1dSVNq3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 01:29:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 0/5] [RFC] diff: add diff.<driver>.process for external
 hunk providers
In-Reply-To: <pull.2120.git.1779415884.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Fri, 22 May 2026 02:11:19
	+0000")
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 14:29:03 +0900
Message-ID: <xmqq8q9cui5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series adds diff.<driver>.process, a long-running subprocess protocol
> that lets external tools provide hunks to git's diff and blame pipelines.
>
> Over the past 18 years, git's diff pipeline accumulated many features that
> operate on hunks: word diff, function context, color-moved, indent
> heuristic, blame. External tools can replace the pipeline entirely
> (diff.<driver>.command) or select among builtin algorithms
> (diff.<driver>.algorithm), but there is no way for a tool to provide
> line-change information into the pipeline. Tools that understand code
> structure (tree-sitter parsers, format-aware analyzers, tools like
> Difftastic and Mergiraf) must bypass git's pipeline and lose access to
> everything downstream.
>
> The protocol follows filter.<driver>.process: pkt-line over stdin/stdout,
> capability negotiation, one tool invocation per git command. The tool
> receives file pairs and returns hunk descriptors that git feeds into the
> standard xdiff pipeline. All output features work normally.
>
> Zero hunks with status=success means the tool considers the files
> equivalent. git diff shows no output for the file, and git blame skips the
> commit, attributing lines to earlier commits.
>
> On error or tool crash, git falls back silently to the builtin diff
> algorithm. The feature is opt-in via diff.<driver>.process and
> .gitattributes; unconfigured files are unaffected.
>
> The series includes git diff-process-normalize, a built-in tool that
> compares files line by line ignoring whitespace (same logic as "git diff -w"
> via xdiff_compare_lines):

Interesting.

If the goal is purely to normalize content before comparison
(e.g. stripping comments or canonicalizing formatting), we already
have the `textconv` mechanism.  While `textconv` is a "one-shot"
per-file process, it is significantly simpler.

I suspect, however, that the primary focus here is to allow external
tools to provide structural alignment (e.g. for AST- aware diffs
like Difftastic or Mergiraf) without losing the original content in
the display.  Unlike `textconv`, which transforms the text the user
sees, this protocol lets the display remain identical to the source
while using a custom engine for the line-matching logic.

If that is the intent, it should be stated more explicitly in the
documentation and commit messages.  The "whitespace-normalize"
demonstration in [PATCH 5/5] is misleading because it's exactly the
case where `textconv` would be sufficient.

I am afraid that the use of a long-running subprocess for every
diff/blame invocation adds significant complexity and overhead.  In
particular, wouldn't the `blame` implementation performs a
round-trip to the subprocess for every commit in the history?  Even
with a persistent process, the overhead of serializing and
deserializing the entire file content twice (old and new) for every
commit could be prohibitive for large files or deep histories.

So, I dunno.
